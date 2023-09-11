module main

import lru

struct Person {
	id   int
	name string
	pos  [2]u8
}

fn main() {
	person := Person{
		id: 1
		name: 'Johnny'
		pos: [u8(2), u8(2)]!
	}
	mut cache := lru.LRUCache.new[string, Person](230123)!
	cache.put('test', person)
	cache.put('test2', person)
	cache.put('test3', person)
	println(cache.get('test'))
}
