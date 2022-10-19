# %% Import libraries
from classes import Sonifier, Grammar_Sequence, metronome_grammar
import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# %%
whole_grammar = {
    "S": ["M", "SM"],
    "M": ["W",["H", "H"]],
    "W": ["w", "pw", ["Q", "H", "Q"]],
    "H": ["h", "ph", ["Q", "Q"], ["O", "Q", "O"]],
    "Q": ["q", "pq", ["O", "O"]],
    "O": ["o", "po"]
}

ex4_word_dur = {
    "w": 1,
    "pw": 1,
    "h": 0.5,
    "ph": 0.5,
    "q": 0.25,
    "pq": 0.25,
    "o": 0.125,
    "po": 0.125,
}

if __name__ == "__main__":
    fn_out = "ex4_octave_composition.wav"

    NUM_M = 8
    START_SEQUENCE = ["M", ]*NUM_M
    G = Grammar_Sequence(whole_grammar)

    final_sequence, seqs = G.create_sequence(START_SEQUENCE)
    for seq in seqs:
        print(" ".join(seq))
    print(f"Final sequence: {' '.join(final_sequence)}")

    S = Sonifier("sounds/cough.wav", BPM=174, word_dur=ex4_word_dur)
    audio_array = S.create_audio(final_sequence, add_metronome=True)
    S.write("out/"+fn_out, audio_sequence=audio_array)

# %%
