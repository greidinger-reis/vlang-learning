module queue

struct Node[T] {
	value T [required]
mut:
	next &Node[T] = unsafe { 0 }
}

pub interface IQueue[T] {
	len int
	head &Node[T]
	tail &Node[T]
	enqueue(item T)
	dequeue() ?T
	is_empty() bool
	peek() ?T
}

pub struct Queue[T] {
mut:
	len  int
	head &Node[T] = unsafe { 0 }
	tail &Node[T] = unsafe { 0 }
}

pub fn (this &Queue[T]) is_empty() bool {
	return this.len == 0
}

pub fn (mut this Queue[T]) enqueue[T](item T) {
	node := &Node[T]{
		value: item
	}

	if this.is_empty() {
		this.tail = node
		this.head = node
		return
	}

	this.tail.next = &node
	this.tail = node
	this.len++
}

pub fn (mut this Queue[T]) dequeue[T]() ?T {
	if unsafe { this.head == 0 } {
		return none
	}
	head := this.head
	this.head = this.head.next

	this.len--
	return head.value
}

pub fn (this &Queue[T]) peek[T]() ?T {
	if unsafe { this.head == 0 } {
		return none
	}

	return this.head.value
}
