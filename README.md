The repository TEI-2-SC contains transformations for TEI files to Shared Canvas manifests in JSON-LD, the XSL code is created in the scope of the Biblissima project (http://www.biblissima-condorcet.fr).

Biblissima — Bibliotheca bibliothecarum novissima — is an observatory for the written cultural heritage of the Middle Ages and the Renaissance, developed through the French government programme Équipements d’excellence, part of the Investissements d’avenir.
The observatory focusses on documents written in the main languages of culture in Medieval and Renaissance Europe (Arabic, French, Greek, Hebrew, Latin, etc.) and contributes to a better understanding of the circulation of texts, the evolution of libraries and the transmission of knowledge in Europe from the 8th to 18th centuries.

Shared Canvas manifests serve to display structural and descriptive metadata alongside with the images and transcriptions of a text bearing object in a viewer like e.g. Mirador (developed by Stanford University) see one implementation at http://demos.biblissima-condorcet.fr/mirador.

For the specifications see the IIIF Image API 1.1 (http://iiif.io/image-api/1.1), IIIF Metadata API 1.0 (http://iiif.io/metadata-api/1.0) and the draft version of IIIF Presentation API 2.0 Draft (http://iiif.io/api/presentation/2.0) and for general information see the International Image Interoperability Framework website (http://iiif.io).


In a first step two transformations for transcriptions to Shared Canvas (a using facsimile module, b using sourceDoc)
and an XSL that
automatically adds facsimile surfaces and zones as estimates to a TEI file with a transcription, calculating the position of each line based on the zone of a writing area, are made available.



