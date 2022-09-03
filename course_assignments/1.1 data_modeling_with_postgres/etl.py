import os
import glob
import psycopg2
import pandas as pd
from sql_queries import *


def process_song_file(cur, filepath):
    """
    This function process read and process all song files.
    In the end it generate songplays, times and users tables.
    
    Inputs: 
    cur - cursor object
    filepath - string filepath of log files
    
    Returns:
    None
    """
    # open song file
    df = pd.read_json(filepath, typ="series")

    # insert song record
    song_data = list(df[['song_id', 'title', 'artist_id', 'year', 'duration']].values)
    cur.execute(song_table_insert, song_data)
    
    # insert artist record
    artist_data = list(df[['artist_id', 'artist_name', 'artist_location', 'artist_latitude', 'artist_longitude']].values)
    cur.execute(artist_table_insert, artist_data)


def process_log_file(cur, filepath):
    """
    This function process read and process all log files.
    In the end it splits log files into songs and artists dimension tables.
    
    Inputs: 
    cur - cursor object
    filepath - string filepath of song files
    
    Returns:
    None
    """
    # open log file
    df = pd.read_json(filepath, lines=True)

    # filter by NextSong action
    df = df[df['page']=='NextSong']

    # convert timestamp column to datetime
    df['timestamp'] =  pd.to_datetime(df['ts'], unit='ms')
    
    # insert time data records
    df['hour'] = df['timestamp'].dt.hour
    df['day'] = df['timestamp'].dt.day
    df['weekofyear'] = df['timestamp'].dt.week
    df['month'] = df['timestamp'].dt.month
    df['year'] = df['timestamp'].dt.year
    df['weekday'] = df['timestamp'].dt.weekday
    
    time_data = df[['timestamp', 'hour', 'day', 'weekofyear', 'month', 'year', 'weekday']].values.tolist()
     
    column_labels = ('start_time', 'hour', 'day', 'weekofyear', 'month', 'year', 'weekday')
    time_df = pd.DataFrame(data=time_data, columns=column_labels)

    for i, row in time_df.iterrows():
        cur.execute(time_table_insert, list(row))

    # load user table
    user_df = df[['userId', 'firstName', 'lastName', 'gender', 'level']]

    # insert user records
    for i, row in user_df.iterrows():
        cur.execute(user_table_insert, row)

    # insert songplay records
    for index, row in df.iterrows():
        
        # get songid and artistid from song and artist tables
        cur.execute(song_select, (row.song, row.artist, row.length))
        results = cur.fetchone()
        if results:
            songid, artistid = results
        else:
            songid, artistid = None, None

        # insert songplay record
        songplay_data = (row.timestamp, row.userId, row.level, songid, artistid, row.sessionId, row.location, row.userAgent)
        cur.execute(songplay_table_insert, songplay_data)


def process_data(cur, conn, filepath, func):
    """
    This function walk through provided filepath and append all files in folders.
    It also shows the process of file appending.
    
    Inputs: 
    cur - cursor object
    conn - sql connector object
    filepath - string filepath of song files
    func - function
    
    Returns:
    None
    """
    # get all files matching extension from directory
    all_files = []
    for root, dirs, files in os.walk(filepath):
        files = glob.glob(os.path.join(root,'*.json'))
        for f in files :
            all_files.append(os.path.abspath(f))

    # get total number of files found
    num_files = len(all_files)
    print('{} files found in {}'.format(num_files, filepath))

    # iterate over files and process
    for i, datafile in enumerate(all_files, 1):
        func(cur, datafile)
        conn.commit()
        print('{}/{} files processed.'.format(i, num_files))


def main():
    """
    Main function executes connection to created database and all other functions.
    Then close connector.
    
    """
    conn = psycopg2.connect("host=127.0.0.1 dbname=sparkifydb user=student password=student")
    cur = conn.cursor()

    process_data(cur, conn, filepath='data/song_data', func=process_song_file)
    process_data(cur, conn, filepath='data/log_data', func=process_log_file)

    conn.close()


if __name__ == "__main__":
    main()