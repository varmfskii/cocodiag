freq = 3974545/4
min_delay = 45
notes = [261.63,293.66,329.63,349.23,392.00,440.00,493.88,523.25]
for note in notes:
    a = int(note/4+.5)
    b = int((freq/note-min_delay)/8+.5)
    print(f'\tfdb {a},{b}\t; {note}')
