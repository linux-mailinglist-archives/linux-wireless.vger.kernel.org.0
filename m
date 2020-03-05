Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 948DD17A84D
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726220AbgCEO5O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:57:14 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35776 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726162AbgCEO5N (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:57:13 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rvx-001JyE-F1; Thu, 05 Mar 2020 15:57:09 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 1/4] wmediumd: update list.h from kernel
Date:   Thu,  5 Mar 2020 15:56:52 +0100
Message-Id: <20200305155407.76768e7e8871.Ibd11bcf6d629ea75bf3edc6b64242c46d5f2c6be@changeid>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305145655.67427-1-johannes@sipsolutions.net>
References: <20200305145655.67427-1-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This just pulls in some nicer things to use.

---
 wmediumd/list.h | 506 ++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 446 insertions(+), 60 deletions(-)

diff --git a/wmediumd/list.h b/wmediumd/list.h
index a33a187473f2..a6212af9a712 100644
--- a/wmediumd/list.h
+++ b/wmediumd/list.h
@@ -1,9 +1,20 @@
-#ifndef _LIST_H
-#define _LIST_H
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LIST_H
+#define _LINUX_LIST_H
 
-/* Stripped down implementation of linked list taken
- * from the Linux Kernel.
- */
+#include <linux/types.h>
+#include <stddef.h>
+
+/* Stripped down from Linux ~5.5 */
+
+#define POISON_POINTER_DELTA 0
+#define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
+#define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
+#define WRITE_ONCE(p, v) do { p = v; } while (0)
+#define READ_ONCE(p) (p)
+#ifndef container_of
+#define container_of(ptr, type, member) ((type *)(void*)( (char*)ptr - offsetof(type, member)))
+#endif
 
 /*
  * Simple doubly linked list implementation.
@@ -24,12 +35,30 @@ struct list_head {
 #define LIST_HEAD(name) \
 	struct list_head name = LIST_HEAD_INIT(name)
 
+/**
+ * INIT_LIST_HEAD - Initialize a list_head structure
+ * @list: list_head structure to be initialized.
+ *
+ * Initializes the list_head to point to itself.  If it is a list header,
+ * the result is an empty list.
+ */
 static inline void INIT_LIST_HEAD(struct list_head *list)
 {
-	list->next = list;
+	WRITE_ONCE(list->next, list);
 	list->prev = list;
 }
 
+static inline bool __list_add_valid(struct list_head *new,
+				struct list_head *prev,
+				struct list_head *next)
+{
+	return true;
+}
+static inline bool __list_del_entry_valid(struct list_head *entry)
+{
+	return true;
+}
+
 /*
  * Insert a new entry between two known consecutive entries.
  *
@@ -40,10 +69,13 @@ static inline void __list_add(struct list_head *new,
 			      struct list_head *prev,
 			      struct list_head *next)
 {
+	if (!__list_add_valid(new, prev, next))
+		return;
+
 	next->prev = new;
 	new->next = next;
 	new->prev = prev;
-	prev->next = new;
+	WRITE_ONCE(prev->next, new);
 }
 
 /**
@@ -59,6 +91,7 @@ static inline void list_add(struct list_head *new, struct list_head *head)
 	__list_add(new, head, head->next);
 }
 
+
 /**
  * list_add_tail - add a new entry
  * @new: new entry to be added
@@ -79,15 +112,171 @@ static inline void list_add_tail(struct list_head *new, struct list_head *head)
  * This is only for internal list manipulation where we know
  * the prev/next entries already!
  */
-static inline void __list_del(struct list_head *prev, struct list_head *next)
+static inline void __list_del(struct list_head * prev, struct list_head * next)
 {
 	next->prev = prev;
-	prev->next = next;
+	WRITE_ONCE(prev->next, next);
 }
 
-#define POISON_POINTER_DELTA 0
-#define LIST_POISON1  ((void *) 0x00100100 + POISON_POINTER_DELTA)
-#define LIST_POISON2  ((void *) 0x00200200 + POISON_POINTER_DELTA)
+/*
+ * Delete a list entry and clear the 'prev' pointer.
+ *
+ * This is a special-purpose list clearing method used in the networking code
+ * for lists allocated as per-cpu, where we don't want to incur the extra
+ * WRITE_ONCE() overhead of a regular list_del_init(). The code that uses this
+ * needs to check the node 'prev' pointer instead of calling list_empty().
+ */
+static inline void __list_del_clearprev(struct list_head *entry)
+{
+	__list_del(entry->prev, entry->next);
+	entry->prev = NULL;
+}
+
+static inline void __list_del_entry(struct list_head *entry)
+{
+	if (!__list_del_entry_valid(entry))
+		return;
+
+	__list_del(entry->prev, entry->next);
+}
+
+/**
+ * list_del - deletes entry from list.
+ * @entry: the element to delete from the list.
+ * Note: list_empty() on entry does not return true after this, the entry is
+ * in an undefined state.
+ */
+static inline void list_del(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	entry->next = LIST_POISON1;
+	entry->prev = LIST_POISON2;
+}
+
+/**
+ * list_replace - replace old entry by new one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace(struct list_head *old,
+				struct list_head *new)
+{
+	new->next = old->next;
+	new->next->prev = new;
+	new->prev = old->prev;
+	new->prev->next = new;
+}
+
+/**
+ * list_replace_init - replace old entry by new one and initialize the old one
+ * @old : the element to be replaced
+ * @new : the new element to insert
+ *
+ * If @old was empty, it will be overwritten.
+ */
+static inline void list_replace_init(struct list_head *old,
+				     struct list_head *new)
+{
+	list_replace(old, new);
+	INIT_LIST_HEAD(old);
+}
+
+/**
+ * list_swap - replace entry1 with entry2 and re-add entry1 at entry2's position
+ * @entry1: the location to place entry2
+ * @entry2: the location to place entry1
+ */
+static inline void list_swap(struct list_head *entry1,
+			     struct list_head *entry2)
+{
+	struct list_head *pos = entry2->prev;
+
+	list_del(entry2);
+	list_replace(entry1, entry2);
+	if (pos == entry1)
+		pos = entry2;
+	list_add(entry1, pos);
+}
+
+/**
+ * list_del_init - deletes entry from list and reinitialize it.
+ * @entry: the element to delete from the list.
+ */
+static inline void list_del_init(struct list_head *entry)
+{
+	__list_del_entry(entry);
+	INIT_LIST_HEAD(entry);
+}
+
+/**
+ * list_move - delete from one list and add as another's head
+ * @list: the entry to move
+ * @head: the head that will precede our entry
+ */
+static inline void list_move(struct list_head *list, struct list_head *head)
+{
+	__list_del_entry(list);
+	list_add(list, head);
+}
+
+/**
+ * list_move_tail - delete from one list and add as another's tail
+ * @list: the entry to move
+ * @head: the head that will follow our entry
+ */
+static inline void list_move_tail(struct list_head *list,
+				  struct list_head *head)
+{
+	__list_del_entry(list);
+	list_add_tail(list, head);
+}
+
+/**
+ * list_bulk_move_tail - move a subsection of a list to its tail
+ * @head: the head that will follow our entry
+ * @first: first entry to move
+ * @last: last entry to move, can be the same as first
+ *
+ * Move all entries between @first and including @last before @head.
+ * All three entries must belong to the same linked list.
+ */
+static inline void list_bulk_move_tail(struct list_head *head,
+				       struct list_head *first,
+				       struct list_head *last)
+{
+	first->prev->next = last->next;
+	last->next->prev = first->prev;
+
+	head->prev->next = first;
+	first->prev = head->prev;
+
+	last->next = head;
+	head->prev = last;
+}
+
+/**
+ * list_is_first -- tests whether @list is the first entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_first(const struct list_head *list,
+					const struct list_head *head)
+{
+	return list->prev == head;
+}
+
+/**
+ * list_is_last - tests whether @list is the last entry in list @head
+ * @list: the entry to test
+ * @head: the head of the list
+ */
+static inline int list_is_last(const struct list_head *list,
+				const struct list_head *head)
+{
+	return list->next == head;
+}
 
 /**
  * list_empty - tests whether a list is empty
@@ -95,32 +284,215 @@ static inline void __list_del(struct list_head *prev, struct list_head *next)
  */
 static inline int list_empty(const struct list_head *head)
 {
-	return head->next == head;
+	return READ_ONCE(head->next) == head;
 }
 
 /**
- * list_del - deletes entry from list.
- * @entry: the element to delete from the list.
- * Note: list_empty() on entry does not return true after this, the entry is
- * in an undefined state.
+ * list_empty_careful - tests whether a list is empty and not being modified
+ * @head: the list to test
+ *
+ * Description:
+ * tests whether a list is empty _and_ checks that no other CPU might be
+ * in the process of modifying either member (next or prev)
+ *
+ * NOTE: using list_empty_careful() without synchronization
+ * can only be safe if the only activity that can happen
+ * to the list entry is list_del_init(). Eg. it cannot be used
+ * if another CPU could re-list_add() it.
  */
-static inline void __list_del_entry(struct list_head *entry)
+static inline int list_empty_careful(const struct list_head *head)
 {
-	__list_del(entry->prev, entry->next);
+	struct list_head *next = head->next;
+	return (next == head) && (next == head->prev);
 }
 
-static inline void list_del(struct list_head *entry)
+/**
+ * list_rotate_left - rotate the list to the left
+ * @head: the head of the list
+ */
+static inline void list_rotate_left(struct list_head *head)
 {
-	__list_del(entry->prev, entry->next);
-	entry->next = LIST_POISON1;
-	entry->prev = LIST_POISON2;
+	struct list_head *first;
+
+	if (!list_empty(head)) {
+		first = head->next;
+		list_move_tail(first, head);
+	}
+}
+
+/**
+ * list_rotate_to_front() - Rotate list to specific item.
+ * @list: The desired new front of the list.
+ * @head: The head of the list.
+ *
+ * Rotates list so that @list becomes the new front of the list.
+ */
+static inline void list_rotate_to_front(struct list_head *list,
+					struct list_head *head)
+{
+	/*
+	 * Deletes the list head from the list denoted by @head and
+	 * places it as the tail of @list, this effectively rotates the
+	 * list so that @list is at the front.
+	 */
+	list_move_tail(head, list);
+}
+
+/**
+ * list_is_singular - tests whether a list has just one entry.
+ * @head: the list to test.
+ */
+static inline int list_is_singular(const struct list_head *head)
+{
+	return !list_empty(head) && (head->next == head->prev);
+}
+
+static inline void __list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	struct list_head *new_first = entry->next;
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry;
+	entry->next = list;
+	head->next = new_first;
+	new_first->prev = head;
+}
+
+/**
+ * list_cut_position - cut a list into two
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *	and if so we won't cut the list
+ *
+ * This helper moves the initial part of @head, up to and
+ * including @entry, from @head to @list. You should
+ * pass on @entry an element you know is on @head. @list
+ * should be an empty list or a list you do not care about
+ * losing its data.
+ *
+ */
+static inline void list_cut_position(struct list_head *list,
+		struct list_head *head, struct list_head *entry)
+{
+	if (list_empty(head))
+		return;
+	if (list_is_singular(head) &&
+		(head->next != entry && head != entry))
+		return;
+	if (entry == head)
+		INIT_LIST_HEAD(list);
+	else
+		__list_cut_position(list, head, entry);
+}
+
+/**
+ * list_cut_before - cut a list into two, before given entry
+ * @list: a new list to add all removed entries
+ * @head: a list with entries
+ * @entry: an entry within head, could be the head itself
+ *
+ * This helper moves the initial part of @head, up to but
+ * excluding @entry, from @head to @list.  You should pass
+ * in @entry an element you know is on @head.  @list should
+ * be an empty list or a list you do not care about losing
+ * its data.
+ * If @entry == @head, all entries on @head are moved to
+ * @list.
+ */
+static inline void list_cut_before(struct list_head *list,
+				   struct list_head *head,
+				   struct list_head *entry)
+{
+	if (head->next == entry) {
+		INIT_LIST_HEAD(list);
+		return;
+	}
+	list->next = head->next;
+	list->next->prev = list;
+	list->prev = entry->prev;
+	list->prev->next = list;
+	head->next = entry;
+	entry->prev = head;
+}
+
+static inline void __list_splice(const struct list_head *list,
+				 struct list_head *prev,
+				 struct list_head *next)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+
+	first->prev = prev;
+	prev->next = first;
+
+	last->next = next;
+	next->prev = last;
+}
+
+/**
+ * list_splice - join two lists, this is designed for stacks
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice(const struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head, head->next);
+}
+
+/**
+ * list_splice_tail - join two lists, each list being a queue
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ */
+static inline void list_splice_tail(struct list_head *list,
+				struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice(list, head->prev, head);
+}
+
+/**
+ * list_splice_init - join two lists and reinitialise the emptied list.
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_init(struct list_head *list,
+				    struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head, head->next);
+		INIT_LIST_HEAD(list);
+	}
+}
+
+/**
+ * list_splice_tail_init - join two lists and reinitialise the emptied list
+ * @list: the new list to add.
+ * @head: the place to add it in the first list.
+ *
+ * Each of the lists is a queue.
+ * The list at @list is reinitialised
+ */
+static inline void list_splice_tail_init(struct list_head *list,
+					 struct list_head *head)
+{
+	if (!list_empty(list)) {
+		__list_splice(list, head->prev, head);
+		INIT_LIST_HEAD(list);
+	}
 }
 
 /**
  * list_entry - get the struct for this entry
  * @ptr:	the &struct list_head pointer.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_entry(ptr, type, member) \
 	container_of(ptr, type, member)
@@ -129,7 +501,7 @@ static inline void list_del(struct list_head *entry)
  * list_first_entry - get the first element from a list
  * @ptr:	the list head to take the element from.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Note, that list is expected to be not empty.
  */
@@ -140,7 +512,7 @@ static inline void list_del(struct list_head *entry)
  * list_last_entry - get the last element from a list
  * @ptr:	the list head to take the element from.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Note, that list is expected to be not empty.
  */
@@ -151,28 +523,34 @@ static inline void list_del(struct list_head *entry)
  * list_first_entry_or_null - get the first element from a list
  * @ptr:	the list head to take the element from.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Note that if the list is empty, it returns NULL.
  */
-#define list_first_entry_or_null(ptr, type, member) \
-	(!list_empty(ptr) ? list_first_entry(ptr, type, member) : NULL)
+#define list_first_entry_or_null(ptr, type, member) ({ \
+	struct list_head *head__ = (ptr); \
+	struct list_head *pos__ = READ_ONCE(head__->next); \
+	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
+})
 
 /**
  * list_last_entry_or_null - get the last element from a list
  * @ptr:	the list head to take the element from.
  * @type:	the type of the struct this is embedded in.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Note that if the list is empty, it returns NULL.
  */
-#define list_last_entry_or_null(ptr, type, member) \
-	(!list_empty(ptr) ? list_last_entry(ptr, type, member) : NULL)
+#define list_last_entry_or_null(ptr, type, member) ({ \
+	struct list_head *head__ = (ptr); \
+	struct list_head *pos__ = READ_ONCE(head__->prev); \
+	pos__ != head__ ? list_entry(pos__, type, member) : NULL; \
+})
 
 /**
  * list_next_entry - get the next element in list
  * @pos:	the type * to cursor
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_next_entry(pos, member) \
 	list_entry((pos)->member.next, typeof(*(pos)), member)
@@ -180,7 +558,7 @@ static inline void list_del(struct list_head *entry)
 /**
  * list_prev_entry - get the prev element in list
  * @pos:	the type * to cursor
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_prev_entry(pos, member) \
 	list_entry((pos)->member.prev, typeof(*(pos)), member)
@@ -193,6 +571,16 @@ static inline void list_del(struct list_head *entry)
 #define list_for_each(pos, head) \
 	for (pos = (head)->next; pos != (head); pos = pos->next)
 
+/**
+ * list_for_each_continue - continue iteration over a list
+ * @pos:	the &struct list_head to use as a loop cursor.
+ * @head:	the head for your list.
+ *
+ * Continue to iterate over a list, continuing after the current position.
+ */
+#define list_for_each_continue(pos, head) \
+	for (pos = pos->next; pos != (head); pos = pos->next)
+
 /**
  * list_for_each_prev	-	iterate over a list backwards
  * @pos:	the &struct list_head to use as a loop cursor.
@@ -226,7 +614,7 @@ static inline void list_del(struct list_head *entry)
  * list_for_each_entry	-	iterate over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry(pos, head, member)				\
 	for (pos = list_first_entry(head, typeof(*pos), member);	\
@@ -237,7 +625,7 @@ static inline void list_del(struct list_head *entry)
  * list_for_each_entry_reverse - iterate backwards over list of given type.
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_reverse(pos, head, member)			\
 	for (pos = list_last_entry(head, typeof(*pos), member);		\
@@ -248,7 +636,7 @@ static inline void list_del(struct list_head *entry)
  * list_prepare_entry - prepare a pos entry for use in list_for_each_entry_continue()
  * @pos:	the type * to use as a start point
  * @head:	the head of the list
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Prepares a pos entry for use as a start point in list_for_each_entry_continue().
  */
@@ -259,7 +647,7 @@ static inline void list_del(struct list_head *entry)
  * list_for_each_entry_continue - continue iteration over list of given type
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Continue to iterate over list of given type, continuing after
  * the current position.
@@ -273,7 +661,7 @@ static inline void list_del(struct list_head *entry)
  * list_for_each_entry_continue_reverse - iterate backwards from the given point
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Start to iterate over list of given type backwards, continuing after
  * the current position.
@@ -287,7 +675,7 @@ static inline void list_del(struct list_head *entry)
  * list_for_each_entry_from - iterate over list of given type from the current point
  * @pos:	the type * to use as a loop cursor.
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Iterate over list of given type, continuing from current position.
  */
@@ -295,12 +683,25 @@ static inline void list_del(struct list_head *entry)
 	for (; &pos->member != (head);					\
 	     pos = list_next_entry(pos, member))
 
+/**
+ * list_for_each_entry_from_reverse - iterate backwards over list of given type
+ *                                    from the current point
+ * @pos:	the type * to use as a loop cursor.
+ * @head:	the head for your list.
+ * @member:	the name of the list_head within the struct.
+ *
+ * Iterate backwards over list of given type, continuing from current position.
+ */
+#define list_for_each_entry_from_reverse(pos, head, member)		\
+	for (; &pos->member != (head);					\
+	     pos = list_prev_entry(pos, member))
+
 /**
  * list_for_each_entry_safe - iterate over list of given type safe against removal of list entry
  * @pos:	the type * to use as a loop cursor.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  */
 #define list_for_each_entry_safe(pos, n, head, member)			\
 	for (pos = list_first_entry(head, typeof(*pos), member),	\
@@ -313,7 +714,7 @@ static inline void list_del(struct list_head *entry)
  * @pos:	the type * to use as a loop cursor.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Iterate over list of given type, continuing after current point,
  * safe against removal of list entry.
@@ -329,7 +730,7 @@ static inline void list_del(struct list_head *entry)
  * @pos:	the type * to use as a loop cursor.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Iterate over list of given type from current point, safe against
  * removal of list entry.
@@ -344,7 +745,7 @@ static inline void list_del(struct list_head *entry)
  * @pos:	the type * to use as a loop cursor.
  * @n:		another type * to use as temporary storage
  * @head:	the head for your list.
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * Iterate backwards over list of given type, safe against removal
  * of list entry.
@@ -359,7 +760,7 @@ static inline void list_del(struct list_head *entry)
  * list_safe_reset_next - reset a stale list_for_each_entry_safe loop
  * @pos:	the loop cursor used in the list_for_each_entry_safe loop
  * @n:		temporary storage used in list_for_each_entry_safe
- * @member:	the name of the list_struct within the struct.
+ * @member:	the name of the list_head within the struct.
  *
  * list_safe_reset_next is not safe to use in general if the list may be
  * modified concurrently (eg. the lock is dropped in the loop body). An
@@ -370,19 +771,4 @@ static inline void list_del(struct list_head *entry)
 #define list_safe_reset_next(pos, n, member)				\
 	n = list_next_entry(pos, member)
 
-#ifndef offsetof
-#define offsetof(TYPE, MEMBER) ((size_t) &((TYPE *)0)->MEMBER)
-#endif
-
-/**
- * container_of - cast a member of a structure out to the containing structure
- * @ptr:	the pointer to the member.
- * @type:	the type of the container struct this is embedded in.
- * @member:	the name of the member within the struct.
- *
- */
-#define container_of(ptr, type, member) ({			\
-	const typeof( ((type *)0)->member ) *__mptr = (ptr);	\
-	(type *)( (char *)__mptr - offsetof(type,member) );})
-
 #endif
-- 
2.24.1

