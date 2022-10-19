from email.mime import audio
import numpy as np
TEACHER_CODE=False
def sort_songs(audio_features):
    """"Receive audio features and sort them according to your criterion"

    Args:
        audio_features (list of dictionaries): List of songs with audio features

    Returns:
        list of dict: the sorted list
    """
    sorted_songs=[]

    # Random shuffle: replace it!
    if TEACHER_CODE:
        random_idxs=np.random.permutation(len(audio_features))
        for idx in random_idxs:
            sorted_songs.append(audio_features[idx])
    else:
        danceability = np.array(af["danceability"] for af in audio_features)
        idxs = np.argsort(danceability) # indexes to use to sort the array
        N_third = int(len(audio_features))
        low_danceability_idxs = idxs[0:N_third]
        mid_danceability_idxs = idxs[N_third:2*N_third]
        high_danceability_idxs = idxs[2*N_third:]

        sorted_idxs = np.stack([mid_danceability_idxs, high_danceability_idxs, low_danceability_idxs[::-1]])

        for idx in sorted_idxs.flatten():
            sorted_songs.append(audio_features[int(idx)])
        
    return sorted_songs