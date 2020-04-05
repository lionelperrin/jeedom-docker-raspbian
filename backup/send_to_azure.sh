#!/bin/sh

echo "Retrieve current content of the blob $AZURE_BLOB_URI"
if ! curl -v "${AZURE_BLOB_URI}?restype=container&comp=list&${AZURE_BLOB_SAS_KEY}" -o /tmp/blob_file_list.txt > /tmp/lastoutput 2>&1
then
  echo "fail to retrieve content of the blob storage"
  echo
  cat /tmp/lastoutput
  echo
  exit 1
fi

for f in "$@"
do
  filename=$(basename $f)
  md5=$(openssl dgst -md5 -binary $f | openssl enc -base64) 
  if grep -q "$filename" /tmp/blob_file_list.txt &&
    grep -q "$md5" /tmp/blob_file_list.txt
  then
    echo "$f is already in the blob storage. Skipping."
  else
    echo "uploading $f"
    if ! curl -v -X PUT \
      -T "$f" \
      -H "Content-MD5: $md5" \
      -H "x-ms-date: $(date -u)" \
      -H "x-ms-blob-type: BlockBlob" \
      "${AZURE_BLOB_URI}/${filename}?${AZURE_BLOB_SAS_KEY}" > /tmp/lastoutput 2>&1
    then
      echo "failed to upload $f"
      echo
      cat /tmp/lastoutput
      echo
      exit 1
    fi
  fi
done
