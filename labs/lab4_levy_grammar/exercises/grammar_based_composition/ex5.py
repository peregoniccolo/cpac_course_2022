# %% Import libraries
from classes import Sonifier, Grammar_Sequence, metronome_grammar
import os
os.chdir(os.path.dirname(os.path.abspath(__file__)))

# %%
synco_grammar = {
    "S": ["M", "SM"],
    "M": [["H", "H"], ["Q", "H", "Q"], ["TH", "TH", "TH"]],
    "H": ["h", "ph", ["O", "Q", "O"], ["TQ", "TQ", "TQ"]],
    "Q": ["q", "pq", ["TO", "TO", "TO"]],
    "O": ["o", "po"],
    "TO": ["to", "pto"],
    "TH": ["th", "pth"],
    "TQ": ["tq", "ptq"],
}

ex5_word_dur = {
    "h": 0.5,
    "ph": 0.5,
    "th": 1/3,
    "pth": 1/3,
    "q": 0.25,
    "pq": 0.25,
    "tq": 0.5/3,
    "ptq": 0.5/3,
    "o": 0.125,
    "po": 0.125,
    "to": 0.25/3,
    "pto": 0.25/3,
}

if __name__ == "__main__":
    fn_out = "ex5_synco_composition.wav"

    NUM_M = 8
    START_SEQUENCE = ["M", ]*NUM_M
    G = Grammar_Sequence(synco_grammar)

    final_sequence, seqs = G.create_sequence(START_SEQUENCE)
    for seq in seqs:
        print(" ".join(seq))
    print(f"Final sequence: {' '.join(final_sequence)}")

    S = Sonifier("sounds/cough.wav", BPM=174, word_dur=ex5_word_dur)
    audio_array = S.create_audio(final_sequence, add_metronome=True)
    S.write("out/"+fn_out, audio_sequence=audio_array)
