#Getting the list of open molecules:

from chimera import openModels, Molecule
mols = openModels.list(modelTypes=[Molecule])

#Getting the list of chains to use.  This example code assumes they're chain A:

chains = [m.sequence('A') for m in mols]

#chains = [molecule.sequences('A') for m in mols]

#Call Match->Align to create the alignment.

from StructSeqAlign import makeAlignment
mav = makeAlignment(chains)
