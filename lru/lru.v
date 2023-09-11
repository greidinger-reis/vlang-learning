module lru

// LRUCache is a least recently used cache.
// It is a key value store with a maximum capacity.
[noinit]
pub struct LRUCache[K, V] {
	capacity u32 [required]
mut:
	cache map[K]V
}

// new creates a new LRU cache.
// @error if the capacity is 0.
pub fn LRUCache.new[K, V](capacity u32) !LRUCache[K, V] {
	if capacity == 0 {
		return error('Cache capacity cannot be 0.')
	}
	return LRUCache[K, V]{
		capacity: capacity
	}
}

// get returns the value for the given key.
pub fn (mut lru LRUCache[K, V]) get[K, V](key K) ?V {
	if key !in lru.cache {
		return none
	}
	lru.reorder(key)
	return lru.cache[key]
}

// put adds a new key value pair to the cache.
// If the key already exists, the value is updated.
// If the cache is at capacity, the least recently used key value pair is removed.
pub fn (mut lru LRUCache[K, V]) put[K, V](key K, value V) {
	if key !in lru.cache {
		lru.before_put()
	}

	lru.cache[key] = value
}

// reorder moves the given key to the front of the cache.
fn (mut lru LRUCache[K, V]) reorder[K, V](key K) {
	value := lru.cache[key]
	lru.cache.delete(key)
	lru.cache[key] = value
}

// before_put is called before a new key value pair is added to the cache.
fn (mut lru LRUCache[K, V]) before_put[K, V]() {
	if lru.cache.len + 1 > lru.capacity {
		lru.delete_least_used()
	}
}

// delete_least_used deletes the least recently used key value pair from the cache.
fn (mut lru LRUCache[K, V]) delete_least_used[K, V]() {
	least_used := lru.cache.keys()[0]
	lru.cache.delete(least_used)
}
