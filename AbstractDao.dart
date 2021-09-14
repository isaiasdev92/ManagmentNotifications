abstract class AbstractDao<T> {
  
  Future<bool> insert(T key);

  Future<bool> update(T key);

  Future<List<T>> getAll();

  Future<bool> delete(T value);

  Future<void> deleteAll();
} 
