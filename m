Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ACDA32332E
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Feb 2021 22:23:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbhBWVWB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Feb 2021 16:22:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231274AbhBWVVx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Feb 2021 16:21:53 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DCC4C061574
        for <linux-wireless@vger.kernel.org>; Tue, 23 Feb 2021 13:21:12 -0800 (PST)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1lEf7E-007ZoZ-6g; Tue, 23 Feb 2021 22:21:08 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Bob Copeland <me@bobcopeland.com>
Cc:     linux-wireless@vger.kernel.org,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH] wmediumd: lib: update from usfstl
Date:   Tue, 23 Feb 2021 22:21:02 +0100
Message-Id: <20210223212102.2189124-1-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Johannes Berg <johannes.berg@intel.com>

This updates the code from the usfstl lib, notably bringing
in a bugfix for a race during the handling of the response
to UM_TIMETRAVEL_WAIT.
---
 wmediumd/inc/usfstl/list.h       |  13 ++-
 wmediumd/inc/usfstl/loop.h       |  16 ++++
 wmediumd/inc/usfstl/sched.h      | 103 ++++++++++++++++-------
 wmediumd/inc/usfstl/schedctrl.h  |   2 +-
 wmediumd/inc/usfstl/vhost.h      |   6 ++
 wmediumd/inc/usfstl/vhostproto.h |   1 +
 wmediumd/lib/loop.c              |   6 +-
 wmediumd/lib/sched.c             | 112 ++++++++++++++++++++++++-
 wmediumd/lib/schedctrl.c         | 106 +++++++++++++++---------
 wmediumd/lib/uds.c               |   6 +-
 wmediumd/lib/vhost.c             | 136 +++++++++++++++++++++----------
 11 files changed, 386 insertions(+), 121 deletions(-)

diff --git a/wmediumd/inc/usfstl/list.h b/wmediumd/inc/usfstl/list.h
index f3ed4d170df3..a07c9e91e0a4 100644
--- a/wmediumd/inc/usfstl/list.h
+++ b/wmediumd/inc/usfstl/list.h
@@ -13,7 +13,7 @@
 #endif
 
 #ifndef container_of
-#define container_of(ptr, type, member) ((type *)(void*)( (char*)ptr - offsetof(type, member)))
+#define container_of(ptr, type, member) ((type *)(void *)((char *)ptr - offsetof(type, member)))
 #endif
 
 struct usfstl_list_entry {
@@ -24,7 +24,7 @@ struct usfstl_list {
 	struct usfstl_list_entry list;
 };
 
-#define USFSTL_LIST_INIT(name) { 	\
+#define USFSTL_LIST_INIT(name) {	\
 	.list.next = &(name).list,	\
 	.list.prev = &(name).list,	\
 }
@@ -64,6 +64,13 @@ static inline void usfstl_list_append(struct usfstl_list *list,
 	     item; \
 	     item = usfstl_next_item(_list, item, typeof(*item), member))
 
+#define usfstl_for_each_list_item_safe(item, next, _list, member) \
+	for (item = usfstl_list_first_item(_list, typeof(*item), member), \
+	     next = item ? usfstl_next_item(_list, item, typeof(*next), member) : NULL; \
+	     item; \
+	     item = next, \
+	     next = item ? usfstl_next_item(_list, next, typeof(*next), member) : NULL)
+
 #define usfstl_for_each_list_item_continue_safe(item, next, _list, member) \
 	for (item = item ? usfstl_next_item(_list, item, typeof(*item), member) : \
 			   usfstl_list_first_item(_list, typeof(*item), member), \
@@ -71,7 +78,7 @@ static inline void usfstl_list_append(struct usfstl_list *list,
 	     item; \
 	     item = next, next = item ? usfstl_next_item(_list, next, typeof(*item), member) : NULL)
 
-static inline bool usfstl_list_empty(struct usfstl_list *list)
+static inline bool usfstl_list_empty(const struct usfstl_list *list)
 {
 	return list->list.next == &list->list;
 }
diff --git a/wmediumd/inc/usfstl/loop.h b/wmediumd/inc/usfstl/loop.h
index bab3017f9e9e..6d6204daba91 100644
--- a/wmediumd/inc/usfstl/loop.h
+++ b/wmediumd/inc/usfstl/loop.h
@@ -38,6 +38,8 @@ struct usfstl_loop_entry {
 	void *data;
 };
 
+extern struct usfstl_list g_usfstl_loop_entries;
+
 /**
  * g_usfstl_loop_pre_handler_fn - pre-handler function
  *
@@ -68,4 +70,18 @@ void usfstl_loop_unregister(struct usfstl_loop_entry *entry);
  */
 void usfstl_loop_wait_and_handle(void);
 
+/**
+ * usfstl_loop_for_each_entry - iterate main loop entries
+ */
+#define usfstl_loop_for_each_entry(entry) \
+	usfstl_for_each_list_item(entry, &g_usfstl_loop_entries, list)
+
+/**
+ * usfstl_loop_for_each_entry_safe - iterate main loop entries safely
+ *
+ * Where "safely" means safe to concurrent modification.
+ */
+#define usfstl_loop_for_each_entry_safe(entry, tmp) \
+	usfstl_for_each_list_item_safe(entry, tmp, &g_usfstl_loop_entries, list)
+
 #endif // _USFSTL_LOOP_H_
diff --git a/wmediumd/inc/usfstl/sched.h b/wmediumd/inc/usfstl/sched.h
index 2cef1f1b4561..48e3826b70e1 100644
--- a/wmediumd/inc/usfstl/sched.h
+++ b/wmediumd/inc/usfstl/sched.h
@@ -6,7 +6,6 @@
 #ifndef _USFSTL_SCHED_H_
 #define _USFSTL_SCHED_H_
 #include <stdint.h>
-#include <stdlib.h>
 #include <inttypes.h>
 #include <stdbool.h>
 #include "assert.h"
@@ -41,6 +40,29 @@
  * external, scheduler to synchronize multiple components.
  */
 
+/**
+ * struct usfstl_job - usfstl scheduler job
+ * @time: time this job fires
+ * @priority: priority of the job, in case of multiple happening
+ *	at the same time; higher value means higher priority
+ * @group: group value, in range 0-31
+ * @name: job name
+ * @data: job data
+ * @callback: called when the job occurs
+ */
+struct usfstl_job {
+	uint64_t start;
+	uint32_t priority;
+	uint8_t group;
+	const char *name;
+
+	void *data;
+	void (*callback)(struct usfstl_job *job);
+
+	/* private: */
+	struct usfstl_list_entry entry;
+};
+
 /**
  * struct usfstl_scheduler - usfstl scheduler structure
  * @external_request: If external scheduler integration is required,
@@ -50,6 +72,8 @@
  *	for the previously requested runtime being granted, and you
  *	must call usfstl_sched_set_time() before returning from this
  *	function.
+ * @external_sync_from: For external scheduler integration, return current
+ *	time based on external time info.
  * @time_advanced: Set this to have logging (or similar) when time
  *	advances. Note that the argument is relative to the previous
  *	time, if you need the current absolute time use
@@ -61,9 +85,11 @@
 struct usfstl_scheduler {
 	void (*external_request)(struct usfstl_scheduler *, uint64_t);
 	void (*external_wait)(struct usfstl_scheduler *);
+	uint64_t (*external_sync_from)(struct usfstl_scheduler *sched);
 	void (*time_advanced)(struct usfstl_scheduler *, uint64_t delta);
 
 /* private: */
+	void (*next_time_changed)(struct usfstl_scheduler *);
 	uint64_t current_time;
 	uint64_t prev_external_sync, next_external_sync;
 
@@ -81,9 +107,17 @@ struct usfstl_scheduler {
 		uint64_t start;
 		uint32_t nsec_per_tick;
 		uint8_t timer_triggered:1,
-		        initialized:1;
+			initialized:1;
 	} wallclock;
 
+	struct {
+		struct usfstl_scheduler *parent;
+		int64_t offset;
+		uint32_t tick_ratio;
+		struct usfstl_job job;
+		bool waiting;
+	} link;
+
 	struct {
 		void *ctrl;
 	} ext;
@@ -95,30 +129,6 @@ struct usfstl_scheduler {
 		.pending_jobs = USFSTL_LIST_INIT(name.pending_jobs),	\
 	}
 
-/**
- * struct usfstl_job - usfstl scheduler job
- * @time: time this job fires
- * @priority: priority of the job, in case of multiple happening
- *	at the same time; higher value means higher priority
- * @group: group value, in range 0-31
- * @name: job name
- * @data: job data
- * @callback: called when the job occurs
- */
-struct usfstl_job {
-	uint64_t start;
-	uint32_t priority;
-	uint8_t group;
-	const char *name;
-
-	void *data;
-	void (*callback)(struct usfstl_job *job);
-
-	/* private: */
-	struct usfstl_list_entry entry;
-};
-
-
 #define usfstl_time_check(x) \
 	({ uint64_t __t; typeof(x) __x; (void)(&__t == &__x); 1; })
 
@@ -145,17 +155,18 @@ struct usfstl_job {
 	uint64_t _a = a;						\
 	uint64_t _b = b;						\
 	if (!usfstl_time_cmp(_a, op, _b))				\
-		abort();						\
+		usfstl_abort(__FILE__, __LINE__,			\
+			     "usfstl_time_cmp(" #a ", " #op ", " #b ")",\
+			     "  " #a " = %" PRIu64 "\n"			\
+			     "  " #b " = %" PRIu64 "\n",		\
+			     _a, _b);					\
 } while (0)
 
 /**
  * usfstl_sched_current_time - return current time
  * @sched: the scheduler to operate with
  */
-static inline uint64_t usfstl_sched_current_time(struct usfstl_scheduler *sched)
-{
-	return sched->current_time;
-}
+uint64_t usfstl_sched_current_time(struct usfstl_scheduler *sched);
 
 /**
  * usfstl_sched_add_job - add job execution
@@ -364,4 +375,34 @@ void usfstl_sched_wallclock_exit(struct usfstl_scheduler *sched);
  */
 void usfstl_sched_wallclock_wait_and_handle(struct usfstl_scheduler *sched);
 
+/**
+ * usfstl_sched_link - link a scheduler to another one
+ * @sched: the scheduler to link, must not already use the external
+ *	request methods, of course. Should also not be running.
+ * @parent: the parent scheduler to link to
+ * @tick_ratio: "tick_ratio" parent ticks == 1 of our ticks;
+ *	e.g. 1000 for if @sched should have microseconds, while @parent
+ *	uses nanoseconds.
+ *
+ * This links two schedulers together, and requesting any runtime in the
+ * inner scheduler (@sched) depends on the parent scheduler (@parent)
+ * granting it.
+ *
+ * Time in the inner scheduler is adjusted in two ways:
+ * 1) there's a "tick_ratio" as described above
+ * 2) at the time of linking, neither scheduler changes its current
+ *    time, instead an offset between the two is maintained, so the
+ *    inner scheduler can be at e.g. zero and be linked to a parent
+ *    that has already been running for a while.
+ */
+void usfstl_sched_link(struct usfstl_scheduler *sched,
+		       struct usfstl_scheduler *parent,
+		       uint32_t tick_ratio);
+
+/**
+ * usfstl_sched_unlink - unlink a scheduler again
+ * @sched: the scheduler to unlink, must be linked
+ */
+void usfstl_sched_unlink(struct usfstl_scheduler *sched);
+
 #endif // _USFSTL_SCHED_H_
diff --git a/wmediumd/inc/usfstl/schedctrl.h b/wmediumd/inc/usfstl/schedctrl.h
index 236aa6725068..c8b1cb612ae4 100644
--- a/wmediumd/inc/usfstl/schedctrl.h
+++ b/wmediumd/inc/usfstl/schedctrl.h
@@ -16,7 +16,7 @@ struct usfstl_sched_ctrl {
 	int64_t offset;
 	uint32_t nsec_per_tick;
 	int fd;
-	unsigned int waiting:1, acked:1, frozen:1;
+	unsigned int waiting:1, acked:1, frozen:1, started:1;
 	uint32_t expected_ack_seq;
 };
 
diff --git a/wmediumd/inc/usfstl/vhost.h b/wmediumd/inc/usfstl/vhost.h
index c451c560caaf..f07a33d7142c 100644
--- a/wmediumd/inc/usfstl/vhost.h
+++ b/wmediumd/inc/usfstl/vhost.h
@@ -127,6 +127,12 @@ void usfstl_vhost_user_dev_notify(struct usfstl_vhost_user_dev *dev,
 				  unsigned int vring,
 				  const uint8_t *buf, size_t buflen);
 
+/**
+ * usfstl_vhost_user_config_changed - notify host of a config change event
+ * @dev: device to send to
+ */
+void usfstl_vhost_user_config_changed(struct usfstl_vhost_user_dev *dev);
+
 /**
  * usfstl_vhost_user_to_va - translate address
  * @dev: device to translate address for
diff --git a/wmediumd/inc/usfstl/vhostproto.h b/wmediumd/inc/usfstl/vhostproto.h
index 375755f2aa92..8e7a76e7a63a 100644
--- a/wmediumd/inc/usfstl/vhostproto.h
+++ b/wmediumd/inc/usfstl/vhostproto.h
@@ -82,6 +82,7 @@ struct vhost_user_msg {
 #define VHOST_USER_GET_CONFIG			24
 #define VHOST_USER_VRING_KICK			35
 
+#define VHOST_USER_SLAVE_CONFIG_CHANGE_MSG	 2
 #define VHOST_USER_SLAVE_VRING_CALL		 4
 
 #define VHOST_USER_F_PROTOCOL_FEATURES 30
diff --git a/wmediumd/lib/loop.c b/wmediumd/lib/loop.c
index 67f6876165c7..e2b28efd20ce 100644
--- a/wmediumd/lib/loop.c
+++ b/wmediumd/lib/loop.c
@@ -29,7 +29,7 @@ void usfstl_loop_register(struct usfstl_loop_entry *entry)
 {
 	struct usfstl_loop_entry *tmp;
 
-	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+	usfstl_loop_for_each_entry(tmp) {
 		if (entry->priority >= tmp->priority) {
 			usfstl_list_insert_before(&tmp->list, &entry->list);
 			return;
@@ -54,7 +54,7 @@ void usfstl_loop_wait_and_handle(void)
 		FD_ZERO(&rd_set);
 		FD_ZERO(&exc_set);
 
-		usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+		usfstl_loop_for_each_entry(tmp) {
 			FD_SET(tmp->fd, &rd_set);
 			FD_SET(tmp->fd, &exc_set);
 			if ((unsigned int)tmp->fd > max)
@@ -64,7 +64,7 @@ void usfstl_loop_wait_and_handle(void)
 		num = select(max + 1, &rd_set, NULL, &exc_set, NULL);
 		assert(num > 0);
 
-		usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+		usfstl_loop_for_each_entry(tmp) {
 			void *data = g_usfstl_loop_pre_handler_fn_data;
 
 			if (!FD_ISSET(tmp->fd, &rd_set) &&
diff --git a/wmediumd/lib/sched.c b/wmediumd/lib/sched.c
index 2694a034d7dd..7ebd81a99b4e 100644
--- a/wmediumd/lib/sched.c
+++ b/wmediumd/lib/sched.c
@@ -8,6 +8,22 @@
 #include <usfstl/assert.h>
 #include <usfstl/sched.h>
 #include <usfstl/list.h>
+#include "internal.h"
+
+uint64_t usfstl_sched_current_time(struct usfstl_scheduler *sched)
+{
+	uint64_t current_time;
+
+	if (!sched->external_sync_from || !sched->waiting)
+		return sched->current_time;
+
+	current_time = sched->external_sync_from(sched);
+
+	/* update current time after sync */
+	usfstl_sched_set_time(sched, current_time);
+
+	return current_time;
+}
 
 static bool usfstl_sched_external_request(struct usfstl_scheduler *sched,
 					  uint64_t time)
@@ -90,6 +106,9 @@ void usfstl_sched_add_job(struct usfstl_scheduler *sched, struct usfstl_job *job
 	 * external scheduler.
 	 */
 	usfstl_sched_external_request(sched, job->start);
+
+	if (sched->next_time_changed)
+		sched->next_time_changed(sched);
 }
 
 bool usfstl_job_scheduled(struct usfstl_job *job)
@@ -169,8 +188,13 @@ struct usfstl_job *usfstl_sched_next(struct usfstl_scheduler *sched)
 	 * If external scheduler is active, we might get here with nothing
 	 * to do, so we just need to wait for an external input/job which
 	 * will add an job to our scheduler in usfstl_sched_add_job().
+	 *
+	 * And due to the fact that we don't have any API for canceling external
+	 * time request, we can request external time which adds a job on the
+	 * external scheduler and cancel internally, and get scheduled to run
+	 * with nothing to do.
 	 */
-	if (usfstl_list_empty(&sched->joblist) && sched->external_request)
+	while (usfstl_list_empty(&sched->joblist) && sched->external_request)
 		usfstl_sched_external_wait(sched);
 
 	while ((job = usfstl_sched_next_pending(sched, NULL))) {
@@ -293,3 +317,89 @@ void usfstl_sched_restore_groups(struct usfstl_scheduler *sched,
 	usfstl_sched_restore_blocked_jobs(sched);
 	usfstl_sched_remove_blocked_jobs(sched);
 }
+
+static void usfstl_sched_link_job_callback(struct usfstl_job *job)
+{
+	struct usfstl_scheduler *sched = job->data;
+
+	sched->link.waiting = false;
+}
+
+static uint64_t usfstl_sched_link_external_sync_from(struct usfstl_scheduler *sched)
+{
+	uint64_t parent_time;
+
+	parent_time = usfstl_sched_current_time(sched->link.parent);
+
+	return DIV_ROUND_UP(parent_time - sched->link.offset,
+			    sched->link.tick_ratio);
+}
+
+static void usfstl_sched_link_external_wait(struct usfstl_scheduler *sched)
+{
+	sched->link.waiting = true;
+
+	while (sched->link.waiting)
+		usfstl_sched_next(sched->link.parent);
+
+	usfstl_sched_set_time(sched, usfstl_sched_current_time(sched));
+}
+
+static void usfstl_sched_link_external_request(struct usfstl_scheduler *sched,
+					       uint64_t time)
+{
+	uint64_t parent_time;
+	struct usfstl_job *job = &sched->link.job;
+
+	parent_time = sched->link.tick_ratio * time + sched->link.offset;
+
+	usfstl_sched_del_job(job);
+	job->start = parent_time;
+	usfstl_sched_add_job(sched->link.parent, job);
+}
+
+void usfstl_sched_link(struct usfstl_scheduler *sched,
+		       struct usfstl_scheduler *parent,
+		       uint32_t tick_ratio)
+{
+	struct usfstl_job *job;
+
+	USFSTL_ASSERT(tick_ratio, "a ratio must be set");
+	USFSTL_ASSERT(!sched->link.parent, "must not be linked");
+
+	USFSTL_ASSERT_EQ(sched->external_request, NULL, "%p");
+	sched->external_request = usfstl_sched_link_external_request;
+
+	USFSTL_ASSERT_EQ(sched->external_wait, NULL, "%p");
+	sched->external_wait = usfstl_sched_link_external_wait;
+
+	USFSTL_ASSERT_EQ(sched->external_sync_from, NULL, "%p");
+	sched->external_sync_from = usfstl_sched_link_external_sync_from;
+
+	sched->link.tick_ratio = tick_ratio;
+	sched->link.parent = parent;
+
+	sched->link.job.callback = usfstl_sched_link_job_callback;
+	sched->link.job.data = sched;
+
+	/* current_time = (parent_time - offset) / tick_ratio */
+	sched->link.offset = sched->link.parent->current_time -
+		sched->current_time * sched->link.tick_ratio;
+
+	/* if we have a job already, request to run it */
+	job = usfstl_sched_next_pending(sched, NULL);
+	if (job)
+		usfstl_sched_external_request(sched, job->start);
+}
+
+void usfstl_sched_unlink(struct usfstl_scheduler *sched)
+{
+	USFSTL_ASSERT(sched->link.parent, "must be linked");
+
+	sched->external_sync_from = NULL;
+	sched->external_wait = NULL;
+	sched->external_request = NULL;
+
+	usfstl_sched_del_job(&sched->link.job);
+	memset(&sched->link, 0, sizeof(sched->link));
+}
diff --git a/wmediumd/lib/schedctrl.c b/wmediumd/lib/schedctrl.c
index 540826026d68..bcd5f896ea61 100644
--- a/wmediumd/lib/schedctrl.c
+++ b/wmediumd/lib/schedctrl.c
@@ -24,43 +24,6 @@ static void _usfstl_sched_ctrl_send_msg(struct usfstl_sched_ctrl *ctrl,
 			 (int)sizeof(msg), "%d");
 }
 
-static void usfstl_sched_ctrl_send_msg(struct usfstl_sched_ctrl *ctrl,
-				       enum um_timetravel_ops op,
-				       uint64_t time)
-{
-	static uint32_t seq, old_expected;
-
-	do {
-		seq++;
-	} while (seq == 0);
-
-	_usfstl_sched_ctrl_send_msg(ctrl, op, time, seq);
-	old_expected = ctrl->expected_ack_seq;
-	ctrl->expected_ack_seq = seq;
-
-	USFSTL_ASSERT_EQ((int)ctrl->acked, 0, "%d");
-
-	while (!ctrl->acked)
-		usfstl_loop_wait_and_handle();
-	ctrl->acked = 0;
-	ctrl->expected_ack_seq = old_expected;
-
-	if (op == UM_TIMETRAVEL_GET) {
-		if (ctrl->frozen) {
-			uint64_t local;
-
-			local = ctrl->sched->current_time * ctrl->nsec_per_tick;
-			ctrl->offset = ctrl->ack_time - local;
-		} else {
-			uint64_t time;
-
-			time = DIV_ROUND_UP(ctrl->ack_time - ctrl->offset,
-					    ctrl->nsec_per_tick);
-			usfstl_sched_set_time(ctrl->sched, time);
-		}
-	}
-}
-
 static void usfstl_sched_ctrl_sock_read(int fd, void *data)
 {
 	struct usfstl_sched_ctrl *ctrl = data;
@@ -101,10 +64,72 @@ static void usfstl_sched_ctrl_sock_read(int fd, void *data)
 	_usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_ACK, 0, msg.seq);
 }
 
+static void usfstl_sched_ctrl_send_msg(struct usfstl_sched_ctrl *ctrl,
+				       enum um_timetravel_ops op,
+				       uint64_t time)
+{
+	static uint32_t seq, old_expected;
+
+	do {
+		seq++;
+	} while (seq == 0);
+
+	_usfstl_sched_ctrl_send_msg(ctrl, op, time, seq);
+	old_expected = ctrl->expected_ack_seq;
+	ctrl->expected_ack_seq = seq;
+
+	USFSTL_ASSERT_EQ((int)ctrl->acked, 0, "%d");
+
+	/*
+	 * Race alert!
+	 *
+	 * UM_TIMETRAVEL_WAIT basically passes the run "token" to the
+	 * controller, which passes it to another participant of the
+	 * simulation. This other participant might immediately send
+	 * us another message on a different channel, e.g. if this
+	 * code is used in a vhost-user device.
+	 *
+	 * If here we were to use use usfstl_loop_wait_and_handle(),
+	 * we could actually get and process the vhost-user message
+	 * before the ACK for the WAIT message here, depending on the
+	 * (host) kernel's message ordering and select() handling etc.
+	 *
+	 * To avoid this, directly read the ACK message for the WAIT,
+	 * without handling any other sockets (first).
+	 */
+	if (op == UM_TIMETRAVEL_WAIT) {
+		usfstl_sched_ctrl_sock_read(ctrl->fd, ctrl);
+		USFSTL_ASSERT(ctrl->acked);
+	}
+
+	while (!ctrl->acked)
+		usfstl_loop_wait_and_handle();
+	ctrl->acked = 0;
+	ctrl->expected_ack_seq = old_expected;
+
+	if (op == UM_TIMETRAVEL_GET) {
+		if (ctrl->frozen) {
+			uint64_t local;
+
+			local = ctrl->sched->current_time * ctrl->nsec_per_tick;
+			ctrl->offset = ctrl->ack_time - local;
+		} else {
+			uint64_t time;
+
+			time = DIV_ROUND_UP(ctrl->ack_time - ctrl->offset,
+					    ctrl->nsec_per_tick);
+			usfstl_sched_set_time(ctrl->sched, time);
+		}
+	}
+}
+
 static void usfstl_sched_ctrl_request(struct usfstl_scheduler *sched, uint64_t time)
 {
 	struct usfstl_sched_ctrl *ctrl = sched->ext.ctrl;
 
+	if (!ctrl->started)
+		return;
+
 	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_REQUEST,
 				   time * ctrl->nsec_per_tick + ctrl->offset);
 }
@@ -133,6 +158,8 @@ void usfstl_sched_ctrl_start(struct usfstl_sched_ctrl *ctrl,
 	USFSTL_ASSERT_EQ(ctrl->sched, NULL, "%p");
 	USFSTL_ASSERT_EQ(sched->ext.ctrl, NULL, "%p");
 
+	memset(ctrl, 0, sizeof(*ctrl));
+
 	/*
 	 * The remote side assumes we start at 0, so if we don't have 0 right
 	 * now keep the difference in our own offset (in nsec).
@@ -156,6 +183,7 @@ void usfstl_sched_ctrl_start(struct usfstl_sched_ctrl *ctrl,
 
 	/* tell the other side we're starting  */
 	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_START, client_id);
+	ctrl->started = 1;
 
 	/* if we have a job already, request it */
 	job = usfstl_sched_next_pending(sched, NULL);
@@ -174,6 +202,8 @@ void usfstl_sched_ctrl_sync_to(struct usfstl_sched_ctrl *ctrl)
 {
 	uint64_t time;
 
+	USFSTL_ASSERT(ctrl->started, "cannot sync to scheduler until started");
+
 	time = usfstl_sched_current_time(ctrl->sched) * ctrl->nsec_per_tick;
 	time += ctrl->offset;
 
@@ -182,6 +212,8 @@ void usfstl_sched_ctrl_sync_to(struct usfstl_sched_ctrl *ctrl)
 
 void usfstl_sched_ctrl_sync_from(struct usfstl_sched_ctrl *ctrl)
 {
+	if (!ctrl->started)
+		return;
 	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_GET, -1);
 }
 
diff --git a/wmediumd/lib/uds.c b/wmediumd/lib/uds.c
index 5601bc4795c5..fc0fe2ad81f0 100644
--- a/wmediumd/lib/uds.c
+++ b/wmediumd/lib/uds.c
@@ -76,7 +76,7 @@ void usfstl_uds_remove(const char *path)
 	struct usfstl_loop_entry *tmp;
 	struct usfstl_uds_server *uds, *found = NULL;
 
-	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+	usfstl_loop_for_each_entry(tmp) {
 		if (tmp->handler != usfstl_uds_accept_handler)
 			continue;
 
@@ -89,6 +89,7 @@ void usfstl_uds_remove(const char *path)
 
 	USFSTL_ASSERT(found);
 
+	close(found->entry.fd);
 	usfstl_loop_unregister(&found->entry);
 	unlink(path);
 	free(found);
@@ -142,7 +143,7 @@ void usfstl_uds_disconnect(int fd)
 	struct usfstl_loop_entry *tmp;
 	struct usfstl_uds_client *uds, *found = NULL;
 
-	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+	usfstl_loop_for_each_entry(tmp) {
 		if (tmp->handler != usfstl_uds_readable_handler)
 			continue;
 
@@ -155,6 +156,7 @@ void usfstl_uds_disconnect(int fd)
 
 	USFSTL_ASSERT(found);
 
+	close(fd);
 	usfstl_loop_unregister(&found->entry);
 	free(found);
 }
diff --git a/wmediumd/lib/vhost.c b/wmediumd/lib/vhost.c
index cc35d8cd7aa4..9d4644199390 100644
--- a/wmediumd/lib/vhost.c
+++ b/wmediumd/lib/vhost.c
@@ -218,6 +218,49 @@ static int usfstl_vhost_user_read_msg(int fd, struct msghdr *msghdr)
 	return 0;
 }
 
+static void usfstl_vhost_user_send_msg(struct usfstl_vhost_user_dev_int *dev,
+				       struct vhost_user_msg *msg)
+{
+	size_t msgsz = sizeof(msg->hdr) + msg->hdr.size;
+	bool ack = dev->ext.protocol_features &
+		   (1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK);
+	ssize_t written;
+
+	if (ack)
+		msg->hdr.flags |= VHOST_USER_MSG_FLAGS_NEED_REPLY;
+
+	written = write(dev->req_fd, msg, msgsz);
+	USFSTL_ASSERT_EQ(written, (ssize_t)msgsz, "%zd");
+
+	if (ack) {
+		struct usfstl_loop_entry entry = {
+			.fd = dev->req_fd,
+			.priority = 0x7fffffff, // max
+			.handler = usfstl_vhost_user_readable_handler,
+		};
+		struct iovec msg_iov = {
+			.iov_base = msg,
+			.iov_len = sizeof(*msg),
+		};
+		struct msghdr msghdr = {
+			.msg_iovlen = 1,
+			.msg_iov = &msg_iov,
+		};
+
+		/*
+		 * Wait for the fd to be readable - we may have to
+		 * handle other simulation (time) messages while
+		 * waiting ...
+		 */
+		usfstl_loop_register(&entry);
+		while (entry.fd != -1)
+			usfstl_loop_wait_and_handle();
+		USFSTL_ASSERT_EQ(usfstl_vhost_user_read_msg(dev->req_fd,
+							    &msghdr),
+				 0, "%d");
+	}
+}
+
 static void usfstl_vhost_user_send_virtq_buf(struct usfstl_vhost_user_dev_int *dev,
 					     struct usfstl_vhost_user_buf *buf,
 					     int virtq_idx)
@@ -256,44 +299,8 @@ static void usfstl_vhost_user_send_virtq_buf(struct usfstl_vhost_user_dev_int *d
 				.idx = virtq_idx,
 			},
 		};
-		bool ack = dev->ext.protocol_features &
-			   (1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK);
-		size_t msgsz = sizeof(msg.hdr) + msg.hdr.size;
-
-		if (ack)
-			msg.hdr.flags |= VHOST_USER_MSG_FLAGS_NEED_REPLY;
-
-		written = write(dev->req_fd, &msg, msgsz);
-		USFSTL_ASSERT_EQ(written, (ssize_t)msgsz, "%zd");
-
-		if (ack) {
-			struct usfstl_loop_entry entry = {
-				.fd = dev->req_fd,
-				.priority = 0x7fffffff, // max
-				.handler = usfstl_vhost_user_readable_handler,
-			};
-			struct iovec msg_iov = {
-				.iov_base = &msg,
-				.iov_len = sizeof(msg),
-			};
-			struct msghdr msghdr = {
-				.msg_iovlen = 1,
-				.msg_iov = &msg_iov,
-			};
-
-			/*
-			 * Wait for the fd to be readable - we may have to
-			 * handle other simulation (time) messages while
-			 * waiting ...
-			 */
-			usfstl_loop_register(&entry);
-			while (entry.fd != -1)
-				usfstl_loop_wait_and_handle();
-			USFSTL_ASSERT_EQ(usfstl_vhost_user_read_msg(dev->req_fd,
-								    &msghdr),
-				       0, "%d");
-		}
 
+		usfstl_vhost_user_send_msg(dev, &msg);
 		return;
 	}
 
@@ -380,11 +387,30 @@ static void usfstl_vhost_user_virtq_fdkick(struct usfstl_loop_entry *entry)
 	usfstl_vhost_user_virtq_kick(dev, virtq);
 }
 
+static void usfstl_vhost_user_clear_mappings(struct usfstl_vhost_user_dev_int *dev)
+{
+	unsigned int idx;
+	for (idx = 0; idx < MAX_REGIONS; idx++) {
+		if (dev->region_vaddr[idx]) {
+			munmap(dev->region_vaddr[idx],
+			       dev->regions[idx].size + dev->regions[idx].mmap_offset);
+			dev->region_vaddr[idx] = NULL;
+		}
+
+		if (dev->region_fds[idx] != -1) {
+			close(dev->region_fds[idx]);
+			dev->region_fds[idx] = -1;
+		}
+	}
+}
+
 static void usfstl_vhost_user_setup_mappings(struct usfstl_vhost_user_dev_int *dev)
 {
 	unsigned int idx;
 
 	for (idx = 0; idx < dev->n_regions; idx++) {
+		USFSTL_ASSERT(!dev->region_vaddr[idx]);
+
 		/*
 		 * Cannot rely on the offset being page-aligned, I think ...
 		 * adjust for it later when we translate addresses instead.
@@ -416,7 +442,7 @@ usfstl_vhost_user_update_virtq_kick(struct usfstl_vhost_user_dev_int *dev,
 
 static void usfstl_vhost_user_dev_free(struct usfstl_vhost_user_dev_int *dev)
 {
-	unsigned int virtq, region;
+	unsigned int virtq;
 
 	usfstl_loop_unregister(&dev->entry);
 	usfstl_sched_del_job(&dev->irq_job);
@@ -427,14 +453,17 @@ static void usfstl_vhost_user_dev_free(struct usfstl_vhost_user_dev_int *dev)
 			close(dev->virtqs[virtq].call_fd);
 	}
 
-	for (region = 0; region < MAX_REGIONS; region++) {
-		if (!dev->region_vaddr[region])
-			continue;
-		munmap(dev->region_vaddr[region], dev->regions[region].size);
-	}
+	usfstl_vhost_user_clear_mappings(dev);
+
+	if (dev->req_fd != -1)
+		close(dev->req_fd);
 
 	if (dev->ext.server->ops->disconnected)
 		dev->ext.server->ops->disconnected(&dev->ext);
+
+	if (dev->entry.fd != -1)
+		close(dev->entry.fd);
+
 	free(dev);
 }
 
@@ -517,6 +546,7 @@ static void usfstl_vhost_user_handle_msg(struct usfstl_loop_entry *entry)
 	case VHOST_USER_SET_MEM_TABLE:
 		USFSTL_ASSERT(len >= (int)sizeof(msg.payload.mem_regions));
 		USFSTL_ASSERT(msg.payload.mem_regions.n_regions <= MAX_REGIONS);
+		usfstl_vhost_user_clear_mappings(dev);
 		memcpy(dev->regions, msg.payload.mem_regions.regions,
 		       msg.payload.mem_regions.n_regions *
 		       sizeof(dev->regions[0]));
@@ -537,6 +567,7 @@ static void usfstl_vhost_user_handle_msg(struct usfstl_loop_entry *entry)
 			      dev->ext.server->max_queues);
 		USFSTL_ASSERT_EQ(msg.payload.vring_addr.flags, (uint32_t)0, "0x%x");
 		USFSTL_ASSERT(!dev->virtqs[msg.payload.vring_addr.idx].enabled);
+		dev->virtqs[msg.payload.vring_addr.idx].last_avail_idx = 0;
 		dev->virtqs[msg.payload.vring_addr.idx].virtq.desc =
 			usfstl_vhost_user_to_va(&dev->ext,
 					      msg.payload.vring_addr.descriptor);
@@ -603,6 +634,8 @@ static void usfstl_vhost_user_handle_msg(struct usfstl_loop_entry *entry)
 		break;
 	case VHOST_USER_SET_SLAVE_REQ_FD:
 		USFSTL_ASSERT_EQ(len, (ssize_t)0, "%zd");
+		if (dev->req_fd != -1)
+			close(dev->req_fd);
 		usfstl_vhost_user_get_msg_fds(&msghdr, &dev->req_fd, 1);
 		USFSTL_ASSERT(dev->req_fd != -1);
 		break;
@@ -761,6 +794,23 @@ void usfstl_vhost_user_dev_notify(struct usfstl_vhost_user_dev *extdev,
 	usfstl_vhost_user_free_buf(buf);
 }
 
+void usfstl_vhost_user_config_changed(struct usfstl_vhost_user_dev *dev)
+{
+	struct usfstl_vhost_user_dev_int *idev;
+	struct vhost_user_msg msg = {
+		.hdr.request = VHOST_USER_SLAVE_CONFIG_CHANGE_MSG,
+		.hdr.flags = VHOST_USER_VERSION,
+	};
+
+	idev = container_of(dev, struct usfstl_vhost_user_dev_int, ext);
+
+	if (!(idev->ext.protocol_features &
+			(1ULL << VHOST_USER_PROTOCOL_F_CONFIG)))
+		return;
+
+	usfstl_vhost_user_send_msg(idev, &msg);
+}
+
 void *usfstl_vhost_user_to_va(struct usfstl_vhost_user_dev *extdev, uint64_t addr)
 {
 	struct usfstl_vhost_user_dev_int *dev;
-- 
2.26.2

