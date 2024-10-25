const DB_NAME = "fenix-db";
const DB_VERSION = 1;
const STORE_NAME = "fenix-documents";

export async function openDatabase() {
  return await idb.openDB(DB_NAME, DB_VERSION, {
    upgrade(db, oldVersion, newVersion, transaction) {
      if (!db.objectStoreNames.contains(STORE_NAME)) {
        db.createObjectStore(STORE_NAME);
      }
    },
  });
}

export async function getStoredDocumentNumber() {
  const db = await openDatabase();
  return db.get(STORE_NAME, "documento");
}

export async function storeDocumentNumber(documentNumber) {
  const db = await openDatabase();
  return db.put(STORE_NAME, documentNumber, "documento");
}

window.db = {
  openDatabase,
  getStoredDocumentNumber,
  storeDocumentNumber,
};
