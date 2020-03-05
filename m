Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3754E17A850
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:57:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgCEO5W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:57:22 -0500
Received: from s3.sipsolutions.net ([144.76.43.62]:35780 "EHLO
        sipsolutions.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726184AbgCEO5V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:57:21 -0500
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.93)
        (envelope-from <johannes@sipsolutions.net>)
        id 1j9rvy-001JyE-95; Thu, 05 Mar 2020 15:57:10 +0100
From:   Johannes Berg <johannes@sipsolutions.net>
To:     linux-wireless@vger.kernel.org
Cc:     Bob Copeland <me@bobcopeland.com>,
        Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 3/4] wmediumd: port to usfstl
Date:   Thu,  5 Mar 2020 15:56:54 +0100
Message-Id: <20200305155407.2d46086a497c.I57157fad401b34e76b8d5f499935d1d18ba8cb2a@changeid>
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

Port to the usfstl for time/scheduling, which should also fix an
issue with station moving not happening unless there are frames
in each move interval (which is likely since it's long, so the
issue is likely only theoretical).

Also add time integration (sched_ctrl) using the user-mode linux
protocol.

Tested with hwsim tests from wpa_supplicant (in user-mode linux
with time-travel) as well as with actually a time-control app
that I'm going to release soon.

---
 wmediumd/Makefile                  |   9 +-
 wmediumd/config.c                  |  25 +-
 wmediumd/inc/linux/um_timetravel.h | 118 ++++
 wmediumd/inc/usfstl/assert.h       | 126 +++++
 wmediumd/inc/usfstl/list.h         |  90 ++++
 wmediumd/inc/usfstl/loop.h         |  71 +++
 wmediumd/inc/usfstl/sched.h        | 367 +++++++++++++
 wmediumd/inc/usfstl/schedctrl.h    |  47 ++
 wmediumd/inc/usfstl/uds.h          |  24 +
 wmediumd/inc/usfstl/vhost.h        | 144 +++++
 wmediumd/inc/usfstl/vhostproto.h   | 105 ++++
 wmediumd/lib/internal.h            |  38 ++
 wmediumd/lib/loop.c                |  79 +++
 wmediumd/lib/sched.c               | 295 ++++++++++
 wmediumd/lib/schedctrl.c           | 205 +++++++
 wmediumd/lib/uds.c                 | 160 ++++++
 wmediumd/lib/vhost.c               | 834 +++++++++++++++++++++++++++++
 wmediumd/lib/wallclock.c           | 138 +++++
 wmediumd/wmediumd.c                | 233 +++-----
 wmediumd/wmediumd.h                |  12 +-
 20 files changed, 2934 insertions(+), 186 deletions(-)
 create mode 100644 wmediumd/inc/linux/um_timetravel.h
 create mode 100644 wmediumd/inc/usfstl/assert.h
 create mode 100644 wmediumd/inc/usfstl/list.h
 create mode 100644 wmediumd/inc/usfstl/loop.h
 create mode 100644 wmediumd/inc/usfstl/sched.h
 create mode 100644 wmediumd/inc/usfstl/schedctrl.h
 create mode 100644 wmediumd/inc/usfstl/uds.h
 create mode 100644 wmediumd/inc/usfstl/vhost.h
 create mode 100644 wmediumd/inc/usfstl/vhostproto.h
 create mode 100644 wmediumd/lib/internal.h
 create mode 100644 wmediumd/lib/loop.c
 create mode 100644 wmediumd/lib/sched.c
 create mode 100644 wmediumd/lib/schedctrl.c
 create mode 100644 wmediumd/lib/uds.c
 create mode 100644 wmediumd/lib/vhost.c
 create mode 100644 wmediumd/lib/wallclock.c

diff --git a/wmediumd/Makefile b/wmediumd/Makefile
index 395215b74089..585f488a9bd5 100644
--- a/wmediumd/Makefile
+++ b/wmediumd/Makefile
@@ -7,9 +7,10 @@ NL3FOUND := $(shell $(PKG_CONFIG) --atleast-version=3 libnl-3.0 && echo Y)
 NL31FOUND := $(shell $(PKG_CONFIG) --exact-version=3.1 libnl-3.1 && echo Y)
 NL3xFOUND := $(shell $(PKG_CONFIG) --atleast-version=3.2 libnl-3.0 && echo Y)
 
-CFLAGS += -g -Wall -Wextra -Wno-unused-parameter -O2
+CFLAGS += -g -Wall -Wextra -Wno-unused-parameter -O2 -Iinc
 CFLAGS += -MMD -MP
-LDFLAGS += -levent -lm
+CFLAGS += -Wno-format-zero-length
+LDFLAGS += -lm
 
 ifeq ($(NL2FOUND),Y)
 CFLAGS += -DCONFIG_LIBNL20
@@ -49,6 +50,8 @@ CFLAGS += $(shell $(PKG_CONFIG) --cflags $(NLLIBNAME))
 CFLAGS+=-DVERSION_STR=$(VERSION_STR)
 LDFLAGS+=-lconfig 
 OBJECTS=wmediumd.o config.o per.o
+OBJECTS += lib/loop.o lib/sched.o lib/schedctrl.o
+OBJECTS += lib/uds.o lib/vhost.o lib/wallclock.o
 
 all: wmediumd 
 
@@ -59,4 +62,4 @@ DEPS := $(patsubst %.o,%.d,$(OBJECTS))
 clean: 
 	rm -f $(OBJECTS) $(DEPS) wmediumd
 
--include *.d
+-include *.d lib/*.d
diff --git a/wmediumd/config.c b/wmediumd/config.c
index 6b7df3822e61..971493780568 100644
--- a/wmediumd/config.c
+++ b/wmediumd/config.c
@@ -1,6 +1,7 @@
 /*
  *	wmediumd, wireless medium simulator for mac80211_hwsim kernel module
  *	Copyright (c) 2011 cozybit Inc.
+ *	Copyright (C) 2020 Intel Corporation
  *
  *	Author: Javier Lopez    <jlopex@cozybit.com>
  *		Javier Cardona  <javier@cozybit.com>
@@ -195,14 +196,10 @@ static void recalc_path_loss(struct wmediumd *ctx)
 	}
 }
 
-static void move_stations_to_direction(struct wmediumd *ctx)
+static void move_stations_to_direction(struct usfstl_job *job)
 {
+	struct wmediumd *ctx = job->data;
 	struct station *station;
-	struct timespec now;
-
-	clock_gettime(CLOCK_MONOTONIC, &now);
-	if (!timespec_before(&ctx->next_move, &now))
-		return;
 
 	list_for_each_entry(station, &ctx->stations, list) {
 		station->x += station->dir_x;
@@ -210,12 +207,8 @@ static void move_stations_to_direction(struct wmediumd *ctx)
 	}
 	recalc_path_loss(ctx);
 
-	clock_gettime(CLOCK_MONOTONIC, &ctx->next_move);
-	ctx->next_move.tv_sec += MOVE_INTERVAL;
-}
-
-static void move_stations_donothing(struct wmediumd *ctx)
-{
+	job->start += MOVE_INTERVAL * 1000000;
+	usfstl_sched_add_job(&scheduler, job);
 }
 
 static int parse_path_loss(struct wmediumd *ctx, config_t *cf)
@@ -245,7 +238,11 @@ static int parse_path_loss(struct wmediumd *ctx, config_t *cf)
 				"Specify %d directions\n", ctx->num_stas);
 			return -EINVAL;
 		}
-		ctx->move_stations = move_stations_to_direction;
+		ctx->move_job.start = MOVE_INTERVAL * 1000000;
+		ctx->move_job.name = "move";
+		ctx->move_job.data = ctx;
+		ctx->move_job.callback = move_stations_to_direction;
+		usfstl_sched_add_job(&scheduler, &ctx->move_job);
 	}
 
 	tx_powers = config_lookup(cf, "model.tx_powers");
@@ -496,8 +493,6 @@ int load_config(struct wmediumd *ctx, const char *file, const char *per_file)
 		ctx->fading_coefficient = 0;
 	}
 
-	ctx->move_stations = move_stations_donothing;
-
 	/* create link quality matrix */
 	ctx->snr_matrix = calloc(sizeof(int), count_ids * count_ids);
 	if (!ctx->snr_matrix) {
diff --git a/wmediumd/inc/linux/um_timetravel.h b/wmediumd/inc/linux/um_timetravel.h
new file mode 100644
index 000000000000..174057df166a
--- /dev/null
+++ b/wmediumd/inc/linux/um_timetravel.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _UAPI_LINUX_UM_TIMETRAVEL_H
+#define _UAPI_LINUX_UM_TIMETRAVEL_H
+#include <linux/types.h>
+
+/**
+ * struct um_timetravel_msg - UM time travel message
+ *
+ * This is the basic message type, going in both directions.
+ *
+ * This is the message passed between the host (user-mode Linux instance)
+ * and the calendar (the application on the other side of the socket) in
+ * order to implement common scheduling.
+ *
+ * Whenever UML has an event it will request runtime for it from the
+ * calendar, and then wait for its turn until it can run, etc. Note
+ * that it will only ever request the single next runtime, i.e. multiple
+ * REQUEST messages override each other.
+ */
+struct um_timetravel_msg {
+	/**
+	 * @op: operation value from &enum um_timetravel_ops
+	 */
+	__u32 op;
+
+	/**
+	 * @seq: sequence number for the message - shall be reflected in
+	 *	the ACK response, and should be checked while processing
+	 *	the response to see if it matches
+	 */
+	__u32 seq;
+
+	/**
+	 * @time: time in nanoseconds
+	 */
+	__u64 time;
+};
+
+/**
+ * enum um_timetravel_ops - Operation codes
+ */
+enum um_timetravel_ops {
+	/**
+	 * @UM_TIMETRAVEL_ACK: response (ACK) to any previous message,
+	 *	this usually doesn't carry any data in the 'time' field
+	 *	unless otherwise specified below
+	 */
+	UM_TIMETRAVEL_ACK		= 0,
+
+	/**
+	 * @UM_TIMETRAVEL_START: initialize the connection, the time
+	 *	field contains an (arbitrary) ID to possibly be able
+	 *	to distinguish the connections.
+	 */
+	UM_TIMETRAVEL_START		= 1,
+
+	/**
+	 * @UM_TIMETRAVEL_REQUEST: request to run at the given time
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_REQUEST		= 2,
+
+	/**
+	 * @UM_TIMETRAVEL_WAIT: Indicate waiting for the previously requested
+	 *	runtime, new requests may be made while waiting (e.g. due to
+	 *	interrupts); the time field is ignored. The calendar must process
+	 *	this message and later	send a %UM_TIMETRAVEL_RUN message when
+	 *	the host can run again.
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_WAIT		= 3,
+
+	/**
+	 * @UM_TIMETRAVEL_GET: return the current time from the calendar in the
+	 *	ACK message, the time in the request message is ignored
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_GET		= 4,
+
+	/**
+	 * @UM_TIMETRAVEL_UPDATE: time update to the calendar, must be sent e.g.
+	 *	before kicking an interrupt to another calendar
+	 *	(host -> calendar)
+	 */
+	UM_TIMETRAVEL_UPDATE		= 5,
+
+	/**
+	 * @UM_TIMETRAVEL_RUN: run time request granted, current time is in
+	 *	the time field
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_RUN		= 6,
+
+	/**
+	 * @UM_TIMETRAVEL_FREE_UNTIL: Enable free-running until the given time,
+	 *	this is a message from the calendar telling the host that it can
+	 *	freely do its own scheduling for anything before the indicated
+	 *	time.
+	 *	Note that if a calendar sends this message once, the host may
+	 *	assume that it will also do so in the future, if it implements
+	 *	wraparound semantics for the time field.
+	 *	(calendar -> host)
+	 */
+	UM_TIMETRAVEL_FREE_UNTIL	= 7,
+
+	/**
+	 * @UM_TIMETRAVEL_GET_TOD: Return time of day, typically used once at
+	 *	boot by the virtual machines to get a synchronized time from
+	 *	the simulation.
+	 */
+	UM_TIMETRAVEL_GET_TOD		= 8,
+};
+
+#endif /* _UAPI_LINUX_UM_TIMETRAVEL_H */
diff --git a/wmediumd/inc/usfstl/assert.h b/wmediumd/inc/usfstl/assert.h
new file mode 100644
index 000000000000..bc46cd0f851f
--- /dev/null
+++ b/wmediumd/inc/usfstl/assert.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright (C) 2018 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_ASSERT_H_
+#define _USFSTL_ASSERT_H_
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdarg.h>
+#include <stdbool.h>
+
+/*
+ * usfstl_abort - abort a test and print the given message(s)
+ */
+static inline void __attribute__((noreturn, format(printf, 4, 5)))
+usfstl_abort(const char *fn, unsigned int line, const char *cond, const char *msg, ...)
+{
+	va_list va;
+
+	printf("assertion failure in %s (line %d)\n", fn, line);
+	printf("'%s' failed\n", cond);
+	va_start(va, msg);
+	vprintf(msg, va);
+	va_end(va);
+	abort();
+}
+
+#define USFSTL_BUILD_BUG_ON(expr)	extern void __bbo_##__LINE__(char[1 - 2*!!(expr)]);
+
+#define _USFSTL_2STR(x)			#x
+#define USFSTL_2STR(x)			_USFSTL_2STR(x)
+
+#define __USFSTL_COUNTDOWN		10,9,8,7,6,5,4,3,2,1,0
+#define __USFSTL_COUNT(_0, _1, _2, _3, _4, _5, _6, _7, _8, _9, _10, N, ...)	N
+#define _USFSTL_COUNT(...)		__USFSTL_COUNT(__VA_ARGS__)
+#define USFSTL_COUNT(...)		_USFSTL_COUNT(, ##__VA_ARGS__, __USFSTL_COUNTDOWN)
+#define __USFSTL_ASSERT_HASARGS_LIST	1,1,1,1,1,1,1,1,1,1,0
+#define USFSTL_HASARGS(...)		_USFSTL_COUNT(, ##__VA_ARGS__, __USFSTL_ASSERT_HASARGS_LIST)
+
+#define __usfstl_dispatch(func, numargs) \
+        func ## numargs
+#define _usfstl_dispatch(func, numargs) \
+        __usfstl_dispatch(func, numargs)
+#define usfstl_dispatch(func, ...) \
+	_usfstl_dispatch(func, USFSTL_HASARGS(__VA_ARGS__))
+
+#define _USFSTL_ASSERT_0(cstr, cond) do {				\
+	if (!(cond))							\
+		usfstl_abort(__FILE__, __LINE__, cstr, "");		\
+} while (0)
+
+#define _USFSTL_ASSERT_1(cstr, cond, msg, ...) do {			\
+	if (!(cond))							\
+		usfstl_abort(__FILE__, __LINE__, cstr,			\
+			     msg, ##__VA_ARGS__);			\
+} while (0)
+
+/*
+ * assert, with or without message
+ *
+ * USFSTL_ASSERT(cond)
+ * USFSTL_ASSERT(cond, msg, format)
+ */
+#define USFSTL_ASSERT(cond, ...)	\
+	usfstl_dispatch(_USFSTL_ASSERT_, __VA_ARGS__)(#cond, cond, ##__VA_ARGS__)
+
+#define _USFSTL_ASSERT_CMP_0(as, a, op, bs, b, fmt) do {		\
+	typeof(a) _a = a;						\
+	typeof(b) _b = b;						\
+	if (!((_a) op (_b)))						\
+		usfstl_abort(__FILE__, __LINE__, as " " #op " " bs,	\
+			     "  " as " = " fmt "\n  " bs " = " fmt "\n",\
+			     _a, _b);					\
+} while (0)
+
+#define _USFSTL_ASSERT_CMP_1(as, a, op, bs, b, fmt, prfn) do {		\
+	typeof(a) _a = a;						\
+	typeof(b) _b = b;						\
+	if (!((_a) op (_b)))						\
+		usfstl_abort(__FILE__, __LINE__, as " " #op " " bs,	\
+			     "  " as " = " fmt "\n  " bs " = " fmt "\n",\
+			     prfn(_a), prfn(_b));			\
+} while (0)
+
+/*
+ * Assert that two values are equal.
+ *
+ * Note that this is a special case of USFSTL_ASSERT_CMP() below, so the
+ * documentation for that applies.
+ */
+#define USFSTL_ASSERT_EQ(a, b, fmt, ...)				\
+	usfstl_dispatch(_USFSTL_ASSERT_CMP_, __VA_ARGS__)(#a, a, ==,	\
+							  #b, b, fmt,	\
+							  ##__VA_ARGS__)
+
+/*
+ * Assert a comparison is true.
+ *
+ * Given a value, comparison operator and another value it checks that
+ * the comparison is true, and aborts the test (or program, if used
+ * outside a test) otherwise.
+ *
+ * You must pass a format string suitable for printing the values.
+ *
+ * You may additionally pass a formatting macro that evaluates the
+ * data for the format string, e.g.
+ *
+ * #define val_and_addr(x) (x), &(x)
+ * ...
+ * int x = 1, y = 2;
+ * USFSTL_ASSERT_CMP(x, ==, y, "%d (at %p)", val_and_addr)
+ *
+ * Will result in the printout
+ * [...]
+ *   x = 1 (at 0xffff1110)
+ *   y = 2 (at 0xffff1114)
+ */
+#define USFSTL_ASSERT_CMP(a, op, b, fmt, ...)				\
+	usfstl_dispatch(_USFSTL_ASSERT_CMP_, __VA_ARGS__)(#a, a, op,	\
+							  #b, b, fmt,	\
+							  ##__VA_ARGS__)
+
+#endif // _USFSTL_ASSERT_H_
diff --git a/wmediumd/inc/usfstl/list.h b/wmediumd/inc/usfstl/list.h
new file mode 100644
index 000000000000..f3ed4d170df3
--- /dev/null
+++ b/wmediumd/inc/usfstl/list.h
@@ -0,0 +1,90 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_LIST_H_
+#define _USFSTL_LIST_H_
+#include <stddef.h>
+#include <stdbool.h>
+
+#ifndef offsetof
+#define offsetof __builtin_offsetof
+#endif
+
+#ifndef container_of
+#define container_of(ptr, type, member) ((type *)(void*)( (char*)ptr - offsetof(type, member)))
+#endif
+
+struct usfstl_list_entry {
+	struct usfstl_list_entry *next, *prev;
+};
+
+struct usfstl_list {
+	struct usfstl_list_entry list;
+};
+
+#define USFSTL_LIST_INIT(name) { 	\
+	.list.next = &(name).list,	\
+	.list.prev = &(name).list,	\
+}
+#define USFSTL_LIST(name) struct usfstl_list name = USFSTL_LIST_INIT(name)
+
+static inline void usfstl_list_init(struct usfstl_list *list)
+{
+	list->list.next = &list->list;
+	list->list.prev = &list->list;
+}
+
+static inline void usfstl_list_insert_before(struct usfstl_list_entry *existing,
+					     struct usfstl_list_entry *new)
+{
+	new->prev = existing->prev;
+	existing->prev->next = new;
+	existing->prev = new;
+	new->next = existing;
+}
+
+static inline void usfstl_list_append(struct usfstl_list *list,
+				      struct usfstl_list_entry *new)
+{
+	usfstl_list_insert_before(&list->list, new);
+}
+
+#define usfstl_list_item(element, type, member) \
+	((type *)container_of(element, type, member))
+
+#define usfstl_next_item(_list, entry, type, member) \
+	((entry)->member.next != &(_list)->list ? \
+		usfstl_list_item((entry)->member.next, type, member) :\
+		NULL)
+
+#define usfstl_for_each_list_item(item, _list, member) \
+	for (item = usfstl_list_first_item(_list, typeof(*item), member); \
+	     item; \
+	     item = usfstl_next_item(_list, item, typeof(*item), member))
+
+#define usfstl_for_each_list_item_continue_safe(item, next, _list, member) \
+	for (item = item ? usfstl_next_item(_list, item, typeof(*item), member) : \
+			   usfstl_list_first_item(_list, typeof(*item), member), \
+	     next = item ? usfstl_next_item(_list, item, typeof(*item), member) : NULL; \
+	     item; \
+	     item = next, next = item ? usfstl_next_item(_list, next, typeof(*item), member) : NULL)
+
+static inline bool usfstl_list_empty(struct usfstl_list *list)
+{
+	return list->list.next == &list->list;
+}
+
+#define usfstl_list_first_item(_list, type, member) \
+	(usfstl_list_empty(_list) ? NULL : usfstl_list_item((_list)->list.next, type, member))
+
+static inline void usfstl_list_item_remove(struct usfstl_list_entry *entry)
+{
+	entry->next->prev = entry->prev;
+	entry->prev->next = entry->next;
+	entry->next = NULL;
+	entry->prev = NULL;
+}
+
+#endif // _USFSTL_LIST_H_
diff --git a/wmediumd/inc/usfstl/loop.h b/wmediumd/inc/usfstl/loop.h
new file mode 100644
index 000000000000..bab3017f9e9e
--- /dev/null
+++ b/wmediumd/inc/usfstl/loop.h
@@ -0,0 +1,71 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+/*
+ * This defines a simple mainloop for reading from multiple sockets and handling
+ * the one that becomes readable. Note that on Windows, it can currently only
+ * handle sockets, not arbitrary descriptors, since we only need it for RPC.
+ */
+#ifndef _USFSTL_LOOP_H_
+#define _USFSTL_LOOP_H_
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+#include "list.h"
+
+#ifdef _WIN32
+typedef uintptr_t usfstl_fd_t;
+#else
+typedef int usfstl_fd_t;
+#endif
+
+/**
+ * struct usfstl_loop_entry - main loop entry
+ * @list: private
+ * @handler: handler to call when fd is readable
+ * @fd: file descriptor
+ * @priority: priority, higher is handled earlier;
+ *	must not change while the entry is registered
+ * @data: user data
+ */
+struct usfstl_loop_entry {
+	struct usfstl_list_entry list;
+	void (*handler)(struct usfstl_loop_entry *);
+	usfstl_fd_t fd;
+	int priority;
+	void *data;
+};
+
+/**
+ * g_usfstl_loop_pre_handler_fn - pre-handler function
+ *
+ * If assigned (defaults to %NULL) this handler will be called
+ * before every loop handler's handling function, e.g. in order
+ * to synchronize time with the wallclock scheduler.
+ */
+extern void (*g_usfstl_loop_pre_handler_fn)(void *data);
+extern void *g_usfstl_loop_pre_handler_fn_data;
+
+/**
+ * usfstl_loop_register - add an entry to the mainloop
+ * @entry: the entry to add, must be fully set up including
+ *	the priority
+ */
+void usfstl_loop_register(struct usfstl_loop_entry *entry);
+
+/**
+ * usfstl_loop_unregister - remove an entry from the mainloop
+ * @entry: the entry to remove
+ */
+void usfstl_loop_unregister(struct usfstl_loop_entry *entry);
+
+/**
+ * usfstl_loop_wait_and_handle - wait and handle a single event
+ *
+ * Wait for, and handle, a single event, then return.
+ */
+void usfstl_loop_wait_and_handle(void);
+
+#endif // _USFSTL_LOOP_H_
diff --git a/wmediumd/inc/usfstl/sched.h b/wmediumd/inc/usfstl/sched.h
new file mode 100644
index 000000000000..2cef1f1b4561
--- /dev/null
+++ b/wmediumd/inc/usfstl/sched.h
@@ -0,0 +1,367 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_SCHED_H_
+#define _USFSTL_SCHED_H_
+#include <stdint.h>
+#include <stdlib.h>
+#include <inttypes.h>
+#include <stdbool.h>
+#include "assert.h"
+#include "list.h"
+#include "loop.h"
+
+/*
+ * usfstl's simple scheduler
+ *
+ * usfstl's concept of time is just a free-running counter. You can use
+ * any units you like, but we recommend micro or nanoseconds, even
+ * with nanoseconds you can simulate ~580 years in a uint64_t time.
+ *
+ * The scheduler is just a really basic concept, you enter "jobs"
+ * and then call usfstl_sched_next() to run the next job. Usually,
+ * this job would schedule another job and call usfstl_sched_next()
+ * again, etc.
+ *
+ * The scheduler supports grouping jobs (currently into up to 32
+ * groups) and then blocking certain groups from being executed in
+ * the next iteration. This can be used, for example, to separate
+ * in-SIM and out-of-SIM jobs, or threads from IRQs, etc. Note
+ * that groups and priorities are two entirely separate concepts.
+ *
+ * In many cases, you'll probably be looking for usfstltask.h instead
+ * as that allows you to simulate a cooperative multithreading system.
+ * However, raw jobs may in that case be useful for things like e.g.
+ * interrupts that come into the simulated system (if they're always
+ * run-to-completion i.e. cannot yield to other jobs.)
+ *
+ * Additionally, the scheduler has APIs to integrate with another,
+ * external, scheduler to synchronize multiple components.
+ */
+
+/**
+ * struct usfstl_scheduler - usfstl scheduler structure
+ * @external_request: If external scheduler integration is required,
+ *	set this function pointer appropriately to request the next
+ *	run time from the external scheduler.
+ * @external_wait: For external scheduler integration, this must wait
+ *	for the previously requested runtime being granted, and you
+ *	must call usfstl_sched_set_time() before returning from this
+ *	function.
+ * @time_advanced: Set this to have logging (or similar) when time
+ *	advances. Note that the argument is relative to the previous
+ *	time, if you need the current absolute time use
+ *	usfstl_sched_current_time(), subtract @delta from that to
+ *	obtain the time prior to the current advance.
+ *
+ * Use USFSTL_SCHEDULER() to declare (and initialize) a scheduler.
+ */
+struct usfstl_scheduler {
+	void (*external_request)(struct usfstl_scheduler *, uint64_t);
+	void (*external_wait)(struct usfstl_scheduler *);
+	void (*time_advanced)(struct usfstl_scheduler *, uint64_t delta);
+
+/* private: */
+	uint64_t current_time;
+	uint64_t prev_external_sync, next_external_sync;
+
+	struct usfstl_list joblist;
+	struct usfstl_list pending_jobs;
+	struct usfstl_job *allowed_job;
+
+	uint32_t blocked_groups;
+	uint8_t next_external_sync_set:1,
+		prev_external_sync_set:1,
+		waiting:1;
+
+	struct {
+		struct usfstl_loop_entry entry;
+		uint64_t start;
+		uint32_t nsec_per_tick;
+		uint8_t timer_triggered:1,
+		        initialized:1;
+	} wallclock;
+
+	struct {
+		void *ctrl;
+	} ext;
+};
+
+#define USFSTL_SCHEDULER(name)						\
+	struct usfstl_scheduler name = {				\
+		.joblist = USFSTL_LIST_INIT(name.joblist),		\
+		.pending_jobs = USFSTL_LIST_INIT(name.pending_jobs),	\
+	}
+
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
+
+#define usfstl_time_check(x) \
+	({ uint64_t __t; typeof(x) __x; (void)(&__t == &__x); 1; })
+
+/**
+ * usfstl_time_cmp - compare time, wrap-around safe
+ * @a: first time
+ * @op: comparison operator (<, >, <=, >=)
+ * @b: second time
+ *
+ * Returns: (a op b), e.g. usfstl_time_cmp(a, >=, b) returns (a >= b)
+ *	while accounting for wrap-around
+ */
+#define usfstl_time_cmp(a, op, b)	\
+	(usfstl_time_check(a) && usfstl_time_check(b) && \
+	 (0 op (int64_t)((b) - (a))))
+
+/**
+ * USFSTL_ASSERT_TIME_CMP - assert that the time comparison holds
+ * @a: first time
+ * @op: comparison operator
+ * @b: second time
+ */
+#define USFSTL_ASSERT_TIME_CMP(a, op, b) do {				\
+	uint64_t _a = a;						\
+	uint64_t _b = b;						\
+	if (!usfstl_time_cmp(_a, op, _b))				\
+		abort();						\
+} while (0)
+
+/**
+ * usfstl_sched_current_time - return current time
+ * @sched: the scheduler to operate with
+ */
+static inline uint64_t usfstl_sched_current_time(struct usfstl_scheduler *sched)
+{
+	return sched->current_time;
+}
+
+/**
+ * usfstl_sched_add_job - add job execution
+ * @sched: the scheduler to operate with
+ * @job: job to add
+ *
+ * Add an job to the execution queue, at the time noted
+ * inside the job.
+ */
+void usfstl_sched_add_job(struct usfstl_scheduler *sched,
+			  struct usfstl_job *job);
+
+/**
+ * @usfstl_sched_del_job - remove an job
+ * @sched: the scheduler to operate with
+ * @job: job to remove
+ *
+ * Remove an job from the execution queue, if present.
+ */
+void usfstl_sched_del_job(struct usfstl_job *job);
+
+/**
+ * usfstl_sched_start - start the scheduler
+ * @sched: the scheduler to operate with
+ *
+ * Start the scheduler, which initializes the scheduler data
+ * and syncs with the external scheduler if necessary.
+ */
+void usfstl_sched_start(struct usfstl_scheduler *sched);
+
+/**
+ * usfstl_sched_next - call next job
+ * @sched: the scheduler to operate with
+ *
+ * Go into the scheduler, forward time to the next job,
+ * and call its callback.
+ *
+ * Returns the job that was run.
+ */
+struct usfstl_job *usfstl_sched_next(struct usfstl_scheduler *sched);
+
+/**
+ * usfstl_job_scheduled - check if an job is scheduled
+ * @job: the job to check
+ *
+ * Returns: %true if the job is on the schedule list, %false otherwise.
+ */
+bool usfstl_job_scheduled(struct usfstl_job *job);
+
+/**
+ * usfstl_sched_next_pending - get first/next pending job
+ * @sched: the scheduler to operate with
+ * @job: %NULL or previously returned job
+ *
+ * This is used to implement usfstl_sched_for_each_pending()
+ * and usfstl_sched_for_each_pending_safe().
+ */
+struct usfstl_job *usfstl_sched_next_pending(struct usfstl_scheduler *sched,
+					 struct usfstl_job *job);
+
+#define usfstl_sched_for_each_pending(sched, job) \
+	for (job = usfstl_sched_next_pending(sched, NULL); job; \
+	     job = usfstl_sched_next_pending(sched, job))
+
+#define usfstl_sched_for_each_pending_safe(sched, job, tmp) \
+	for (job = usfstl_sched_next_pending(sched, NULL), \
+	     tmp = usfstl_sched_next_pending(sched, job); \
+	     job; \
+	     job = tmp, tmp = usfstl_sched_next_pending(sched, tmp))
+
+struct usfstl_sched_block_data {
+	uint32_t groups;
+	struct usfstl_job *job;
+};
+
+/**
+ * usfstl_sched_block_groups - block groups from executing
+ * @sched: the scheduler to operate with
+ * @groups: groups to block, ORed with the currently blocked groups
+ * @job: single job that's allowed anyway, e.g. if the caller is
+ *	part of the blocked group and must be allowed to continue
+ * @save: save data, use with usfstl_sched_restore_groups()
+ */
+void usfstl_sched_block_groups(struct usfstl_scheduler *sched, uint32_t groups,
+			       struct usfstl_job *job,
+			       struct usfstl_sched_block_data *save);
+
+/**
+ * usfstl_sched_restore_groups - restore blocked groups
+ * @sched: the scheduler to operate with
+ * @restore: data saved during usfstl_sched_block_groups()
+ */
+void usfstl_sched_restore_groups(struct usfstl_scheduler *sched,
+				 struct usfstl_sched_block_data *restore);
+
+/**
+ * usfstl_sched_set_time - set time from external source
+ * @sched: the scheduler to operate with
+ * @time: time
+ *
+ * Set the scheduler time from the external source, use this
+ * before returning from the sched_external_wait() method but also when
+ * injecting any other kind of job like an interrupt from an
+ * external source (only applicable when running with external
+ * scheduling and other external interfaces.)
+ */
+void usfstl_sched_set_time(struct usfstl_scheduler *sched, uint64_t time);
+
+/**
+ * usfstl_sched_set_sync_time - set next external sync time
+ * @sched: the scheduler to operate with
+ * @time: time
+ *
+ * When cooperating with an external scheduler, it may be good to
+ * avoid ping-pong all the time, if there's nothing to do. This
+ * function facilitates that.
+ *
+ * Call it before returning from the sched_external_wait() method and
+ * the scheduler will not sync for each internal job again, but
+ * only when the next internal job would be at or later than the
+ * time given as the argument here.
+ *
+ * Note that then you also have to coordinate with the external
+ * scheduler every time there's any interaction with any other
+ * component also driven by the external scheduler.
+ *
+ * To understand this, consider the following timeline, where the
+ * letters indicate scheduler jobs:
+ *  - component 1: A      C D E F
+ *  - component 2:   B             G
+ * Without calling this function, component 1 will always sync
+ * with the external scheduler in component 2, for every job
+ * it has. However, after the sync for job/time C, component
+ * 2 knows that it will not have any job until G, so if it
+ * tells component 1 (whatever RPC there is calls this function)
+ * then component 1 will sync again only after F.
+ *
+ * However, this also necessitates that whenever the components
+ * interact, this function could be called again. If you imagine
+ * jobs C-F to just be empty ticks that do nothing then this
+ * might not happen. However, if one of them causes interaction
+ * with component 2 (say a network packet in the simulation) the
+ * interaction may cause a new job to be inserted into the
+ * scheduler timeline of component 2. Let's say, for example,
+ * the job D was a transmission from component 1 to 2, and in
+ * component 2 that causes an interrupt and a rescheduling. The
+ * above timeline will thus change to:
+ *  - component 1: A      C D E F
+ *  - component 2:   B       N     G
+ * inserting the job N. Thus, this very interaction needs to
+ * call this function again with the time of N which will be at
+ * or shortly after the time of D, rather than at G.
+ *
+ * This optimises things if jobs C-F don't cause interaction
+ * with other components, and if considered properly in the RPC
+ * protocol will not cause any degradation.
+ *
+ * If not supported, just never call this function and each and
+ * every job will require external synchronisation.
+ */
+void usfstl_sched_set_sync_time(struct usfstl_scheduler *sched, uint64_t time);
+
+/**
+ * g_usfstl_top_scheduler - top level scheduler
+ *
+ * There can be multiple schedulers in an usfstl binary, in particular
+ * when the multi-binary support code is used. In any case, this will
+ * will point to the top-level scheduler to facilitate another level
+ * of integration if needed.
+ */
+extern struct usfstl_scheduler *g_usfstl_top_scheduler;
+
+/**
+ * usfstl_sched_wallclock_init - initialize wall-clock integration
+ * @sched: the scheduler to initialize, it must not have external
+ *	integration set up yet
+ * @ns_per_tick: nanoseconds per scheduler tick
+ *
+ * You can use this function to set up a scheduler to run at roughly
+ * wall clock speed (per the @ns_per_tick setting).
+ *
+ * This is compatible with the usfstlloop abstraction, so you can also
+ * add other things to the event loop and they'll be handled while
+ * the scheduler is waiting for time to pass.
+ *
+ * NOTE: This is currently Linux-only.
+ */
+void usfstl_sched_wallclock_init(struct usfstl_scheduler *sched,
+				 unsigned int ns_per_tick);
+
+/**
+ * usfstl_sched_wallclock_exit - remove wall-clock integration
+ * @sched: scheduler to remove wall-clock integration from
+ *
+ * This releases any resources used for the wall-clock integration.
+ */
+void usfstl_sched_wallclock_exit(struct usfstl_scheduler *sched);
+
+/**
+ * usfstl_sched_wallclock_wait_and_handle - wait for external events
+ * @sched: scheduler that's integrated with the wallclock
+ *
+ * If no scheduler events are pending, this will wait for external
+ * events using usfstl_wait_and_handle() and synchronize the time it
+ * took for such an event to arrive into the given scheduler.
+ */
+void usfstl_sched_wallclock_wait_and_handle(struct usfstl_scheduler *sched);
+
+#endif // _USFSTL_SCHED_H_
diff --git a/wmediumd/inc/usfstl/schedctrl.h b/wmediumd/inc/usfstl/schedctrl.h
new file mode 100644
index 000000000000..236aa6725068
--- /dev/null
+++ b/wmediumd/inc/usfstl/schedctrl.h
@@ -0,0 +1,47 @@
+/*
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_SCHEDCTRL_H_
+#define _USFSTL_SCHEDCTRL_H_
+#include <stdint.h>
+#include <inttypes.h>
+#include "loop.h"
+#include "sched.h"
+
+struct usfstl_sched_ctrl {
+	struct usfstl_scheduler *sched;
+	uint64_t ack_time;
+	int64_t offset;
+	uint32_t nsec_per_tick;
+	int fd;
+	unsigned int waiting:1, acked:1, frozen:1;
+	uint32_t expected_ack_seq;
+};
+
+void usfstl_sched_ctrl_start(struct usfstl_sched_ctrl *ctrl,
+			     const char *socket,
+			     uint32_t nsec_per_tick,
+			     uint64_t client_id,
+			     struct usfstl_scheduler *sched);
+void usfstl_sched_ctrl_sync_to(struct usfstl_sched_ctrl *ctrl);
+void usfstl_sched_ctrl_sync_from(struct usfstl_sched_ctrl *ctrl);
+void usfstl_sched_ctrl_stop(struct usfstl_sched_ctrl *ctrl);
+
+/**
+ * usfstl_sched_ctrl_set_frozen - freeze/thaw scheduler interaction
+ * @ctrl: scheduler control
+ * @frozen: whether or not the scheduler interaction is frozen
+ *
+ * When the scheduler control connection is frozen, then any remote
+ * updates will not reflect in the local scheduler, but instead will
+ * just modify the offset vs. the remote.
+ *
+ * This allows scheduling repeatedly at "time zero" while the remote
+ * side is actually running, e.g. to ensure pre-firmware boot hardware
+ * simulation doesn't affect the firmware simulation time.
+ */
+void usfstl_sched_ctrl_set_frozen(struct usfstl_sched_ctrl *ctrl, bool frozen);
+
+#endif // _USFSTL_SCHEDCTRL_H_
diff --git a/wmediumd/inc/usfstl/uds.h b/wmediumd/inc/usfstl/uds.h
new file mode 100644
index 000000000000..622e12286e99
--- /dev/null
+++ b/wmediumd/inc/usfstl/uds.h
@@ -0,0 +1,24 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+/*
+ * This defines a simple unix domain socket listen abstraction.
+ */
+#ifndef _USFSTL_UDS_H_
+#define _USFSTL_UDS_H_
+#include <unistd.h>
+#include <string.h>
+#include <stdint.h>
+#include "list.h"
+
+void usfstl_uds_create(const char *path, void (*connected)(int, void *),
+		       void *data);
+void usfstl_uds_remove(const char *path);
+
+int usfstl_uds_connect(const char *path, void (*readable)(int, void *),
+		       void *data);
+void usfstl_uds_disconnect(int fd);
+
+#endif // _USFSTL_UDS_H_
diff --git a/wmediumd/inc/usfstl/vhost.h b/wmediumd/inc/usfstl/vhost.h
new file mode 100644
index 000000000000..c451c560caaf
--- /dev/null
+++ b/wmediumd/inc/usfstl/vhost.h
@@ -0,0 +1,144 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_VHOST_H_
+#define _USFSTL_VHOST_H_
+
+#include "list.h"
+#include "sched.h"
+#include "schedctrl.h"
+#include "vhostproto.h"
+
+struct usfstl_vhost_user_buf {
+	unsigned int n_in_sg, n_out_sg;
+	struct iovec *in_sg, *out_sg;
+	size_t written;
+	unsigned int idx;
+	bool allocated;
+};
+
+struct usfstl_vhost_user_dev {
+	uint64_t features, protocol_features;
+	struct usfstl_vhost_user_server *server;
+	void *data;
+};
+
+struct usfstl_vhost_user_ops {
+	void (*connected)(struct usfstl_vhost_user_dev *dev);
+	void (*handle)(struct usfstl_vhost_user_dev *dev,
+		       struct usfstl_vhost_user_buf *buf,
+		       unsigned int vring);
+	void (*disconnected)(struct usfstl_vhost_user_dev *dev);
+};
+
+/**
+ * struct usfstl_vhost_user_server: vhost-user device server
+ */
+struct usfstl_vhost_user_server {
+	/**
+	 * @ops: various ops for the server/devices
+	 */
+	const struct usfstl_vhost_user_ops *ops;
+
+	/**
+	 * @name: socket name to use
+	 */
+	char *socket;
+
+	/**
+	 * @interrupt_latency: interrupt latency to model, in
+	 *	scheduler ticks (actual time then depends on
+	 *	the scheduler unit)
+	 */
+	unsigned int interrupt_latency;
+
+	/**
+	 * @max_queues: max number of virt queues supported
+	 */
+	unsigned int max_queues;
+
+	/**
+	 * @input_queues: bitmap of input queues (where to handle interrupts)
+	 */
+	uint64_t input_queues;
+
+	/**
+	 * @scheduler: the scheduler to integrate with,
+	 *	may be %NULL
+	 */
+	struct usfstl_scheduler *scheduler;
+
+	/**
+	 * @ctrl: external scheduler control to integrate with,
+	 *	may be %NULL
+	 */
+	struct usfstl_sched_ctrl *ctrl;
+
+	/**
+	 * @features: user features
+	 */
+	uint64_t features;
+
+	/**
+	 * @protocol_features: protocol features
+	 */
+	uint64_t protocol_features;
+
+	/**
+	 * @config: config data, if supported
+	 */
+	const void *config;
+
+	/**
+	 * @config_len: length of config data
+	 */
+	size_t config_len;
+
+	/**
+	 * @data: arbitrary user data
+	 */
+	void *data;
+};
+
+/**
+ * usfstl_vhost_user_server_start - start the server
+ */
+void usfstl_vhost_user_server_start(struct usfstl_vhost_user_server *server);
+
+/**
+ * usfstl_vhost_user_server_stop - stop the server
+ *
+ * Note that this doesn't stop the existing devices, and it thus
+ * may be used from the connected callback, if only one connection
+ * is allowed.
+ */
+void usfstl_vhost_user_server_stop(struct usfstl_vhost_user_server *server);
+
+/**
+ * usfstl_vhost_user_dev_notify - send a message on a vring
+ * @dev: device to send to
+ * @vring: vring index to send on
+ * @buf: buffer to send
+ * @buflen: length of the buffer
+ */
+void usfstl_vhost_user_dev_notify(struct usfstl_vhost_user_dev *dev,
+				  unsigned int vring,
+				  const uint8_t *buf, size_t buflen);
+
+/**
+ * usfstl_vhost_user_to_va - translate address
+ * @dev: device to translate address for
+ * @addr: guest-side virtual addr
+ */
+void *usfstl_vhost_user_to_va(struct usfstl_vhost_user_dev *dev, uint64_t addr);
+
+/* also some IOV helpers */
+size_t iov_len(struct iovec *sg, unsigned int nsg);
+size_t iov_fill(struct iovec *sg, unsigned int nsg,
+		const void *buf, size_t buflen);
+size_t iov_read(void *buf, size_t buflen,
+		struct iovec *sg, unsigned int nsg);
+
+#endif // _USFSTL_VHOST_H_
diff --git a/wmediumd/inc/usfstl/vhostproto.h b/wmediumd/inc/usfstl/vhostproto.h
new file mode 100644
index 000000000000..375755f2aa92
--- /dev/null
+++ b/wmediumd/inc/usfstl/vhostproto.h
@@ -0,0 +1,105 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_VHOST_PROTO_H_
+#define _USFSTL_VHOST_PROTO_H_
+
+#define MAX_REGIONS 2
+
+/* these are from the vhost-user spec */
+
+struct vhost_user_msg_hdr {
+	uint32_t request;
+
+#define VHOST_USER_MSG_FLAGS_VERSION	0x3
+#define VHOST_USER_VERSION		  1
+#define VHOST_USER_MSG_FLAGS_REPLY	0x4
+#define VHOST_USER_MSG_FLAGS_NEED_REPLY	0x8
+	uint32_t flags;
+
+	uint32_t size;
+};
+
+struct vhost_user_region {
+	uint64_t guest_phys_addr;
+	uint64_t size;
+	uint64_t user_addr;
+	uint64_t mmap_offset;
+};
+
+struct vhost_user_msg {
+	struct vhost_user_msg_hdr hdr;
+	union {
+#define VHOST_USER_U64_VRING_IDX_MSK	0x7f
+#define VHOST_USER_U64_NO_FD		0x80
+		uint64_t u64;
+		struct {
+			uint32_t idx, num;
+		} vring_state;
+		struct {
+			uint32_t idx, flags;
+			uint64_t descriptor;
+			uint64_t used;
+			uint64_t avail;
+			uint64_t log;
+		} vring_addr;
+		struct {
+			uint32_t n_regions;
+			uint32_t reserved;
+			struct vhost_user_region regions[MAX_REGIONS];
+		} mem_regions;
+		struct {
+			uint32_t offset;
+			uint32_t size;
+#define VHOST_USER_CFG_SPACE_WRITABLE	0x1
+#define VHOST_USER_CFG_SPACE_MIGRATION	0x2
+			uint32_t flags;
+			uint8_t payload[0];
+		} cfg_space;
+		struct {
+			uint64_t idx_flags;
+			uint64_t size;
+			uint64_t offset;
+		} vring_area;
+	} __attribute__((packed)) payload;
+};
+
+#define VHOST_USER_GET_FEATURES			 1
+#define VHOST_USER_SET_FEATURES			 2
+#define VHOST_USER_SET_OWNER			 3
+#define VHOST_USER_SET_MEM_TABLE		 5
+#define VHOST_USER_SET_VRING_NUM		 8
+#define VHOST_USER_SET_VRING_ADDR		 9
+#define VHOST_USER_SET_VRING_BASE		10
+#define VHOST_USER_SET_VRING_KICK		12
+#define VHOST_USER_SET_VRING_CALL		13
+#define VHOST_USER_GET_PROTOCOL_FEATURES	15
+#define VHOST_USER_SET_VRING_ENABLE		18
+#define VHOST_USER_SET_PROTOCOL_FEATURES	16
+#define VHOST_USER_SET_SLAVE_REQ_FD		21
+#define VHOST_USER_GET_CONFIG			24
+#define VHOST_USER_VRING_KICK			35
+
+#define VHOST_USER_SLAVE_VRING_CALL		 4
+
+#define VHOST_USER_F_PROTOCOL_FEATURES 30
+
+#define VHOST_USER_PROTOCOL_F_MQ                    0
+#define VHOST_USER_PROTOCOL_F_LOG_SHMFD             1
+#define VHOST_USER_PROTOCOL_F_RARP                  2
+#define VHOST_USER_PROTOCOL_F_REPLY_ACK             3
+#define VHOST_USER_PROTOCOL_F_MTU                   4
+#define VHOST_USER_PROTOCOL_F_SLAVE_REQ             5
+#define VHOST_USER_PROTOCOL_F_CROSS_ENDIAN          6
+#define VHOST_USER_PROTOCOL_F_CRYPTO_SESSION        7
+#define VHOST_USER_PROTOCOL_F_PAGEFAULT             8
+#define VHOST_USER_PROTOCOL_F_CONFIG                9
+#define VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD        10
+#define VHOST_USER_PROTOCOL_F_H_OST_NOTIFIER        11
+#define VHOST_USER_PROTOCOL_F_INFLIGHT_SHMFD       12
+#define VHOST_USER_PROTOCOL_F_RESET_DEVICE         13
+#define VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS 14
+
+#endif // _USFSTL_VHOST_PROTO_H_
diff --git a/wmediumd/lib/internal.h b/wmediumd/lib/internal.h
new file mode 100644
index 000000000000..709a1c48dc91
--- /dev/null
+++ b/wmediumd/lib/internal.h
@@ -0,0 +1,38 @@
+/*
+ * Copyright (C) 2018 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#ifndef _USFSTL_INTERNAL_H_
+#define _USFSTL_INTERNAL_H_
+#include <stdarg.h>
+#include <stdbool.h>
+#include <setjmp.h>
+#include <stdint.h>
+#include <usfstl/sched.h>
+
+/* byteswap helper */
+#define __swap32(v)			\
+	((((v) & 0xff000000) >> 24) |	\
+	 (((v) & 0x00ff0000) >>  8) |	\
+	 (((v) & 0x0000ff00) <<  8) |	\
+	 (((v) & 0x000000ff) << 24))
+
+static inline uint32_t swap32(uint32_t v)
+{
+	return __swap32(v);
+}
+
+#define DIV_ROUND_UP(a, b) ({	\
+	typeof(a) _a = a;	\
+	typeof(b) _b = b;	\
+	(_a + _b - 1) / _b;	\
+})
+
+/* scheduler */
+void _usfstl_sched_set_time(struct usfstl_scheduler *sched, uint64_t time);
+
+/* main loop */
+extern struct usfstl_list g_usfstl_loop_entries;
+
+#endif // _USFSTL_INTERNAL_H_
diff --git a/wmediumd/lib/loop.c b/wmediumd/lib/loop.c
new file mode 100644
index 000000000000..e5595a33234d
--- /dev/null
+++ b/wmediumd/lib/loop.c
@@ -0,0 +1,79 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <stddef.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <string.h>
+#include <usfstl/loop.h>
+#include <usfstl/list.h>
+#include <assert.h>
+#ifdef _WIN32
+#undef _WIN32_WINNT
+#define _WIN32_WINNT 0x0600
+#include <winsock2.h>
+#include <windows.h>
+#else
+#include <sys/select.h>
+#endif
+
+struct usfstl_list g_usfstl_loop_entries =
+	USFSTL_LIST_INIT(g_usfstl_loop_entries);
+void (*g_usfstl_loop_pre_handler_fn)(void *);
+void *g_usfstl_loop_pre_handler_fn_data;
+
+
+void usfstl_loop_register(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_loop_entry *tmp;
+
+	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+		if (entry->priority >= tmp->priority) {
+			usfstl_list_insert_before(&tmp->list, &entry->list);
+			return;
+		}
+	}
+
+	usfstl_list_append(&g_usfstl_loop_entries, &entry->list);
+}
+
+void usfstl_loop_unregister(struct usfstl_loop_entry *entry)
+{
+	usfstl_list_item_remove(&entry->list);
+}
+
+void usfstl_loop_wait_and_handle(void)
+{
+	while (true) {
+		struct usfstl_loop_entry *tmp;
+		fd_set rd_set, exc_set;
+		unsigned int max = 0, num;
+		FD_ZERO(&rd_set);
+		FD_ZERO(&exc_set);
+
+		usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+			FD_SET(tmp->fd, &rd_set);
+			FD_SET(tmp->fd, &exc_set);
+			if ((unsigned int)tmp->fd > max)
+				max = tmp->fd;
+		}
+
+		num = select(max + 1, &rd_set, NULL, &exc_set, NULL);
+		assert(num > 0);
+
+		usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+			void *data = g_usfstl_loop_pre_handler_fn_data;
+
+			if (!FD_ISSET(tmp->fd, &rd_set) &&
+			    !FD_ISSET(tmp->fd, &exc_set))
+				continue;
+
+			if (g_usfstl_loop_pre_handler_fn)
+				g_usfstl_loop_pre_handler_fn(data);
+			tmp->handler(tmp);
+			return;
+		}
+	}
+}
diff --git a/wmediumd/lib/sched.c b/wmediumd/lib/sched.c
new file mode 100644
index 000000000000..f23c8190fdce
--- /dev/null
+++ b/wmediumd/lib/sched.c
@@ -0,0 +1,295 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <stddef.h>
+#include <stdint.h>
+#include <usfstl/assert.h>
+#include <usfstl/sched.h>
+#include <usfstl/list.h>
+
+static bool usfstl_sched_external_request(struct usfstl_scheduler *sched,
+					  uint64_t time)
+{
+	if (!sched->external_request)
+		return false;
+
+	/*
+	 * If we received a next_external_sync point, we don't need to ask for
+	 * runtime for anything earlier than that point, we're allowed to run.
+	 * However, note that this only applies if we're not currently waiting,
+	 * if we are in fact waiting for permission, then of course we need to
+	 * ask for any earlier time, regardless of the next_external_sync, as
+	 * we won't schedule until we get called to run, and that usually won't
+	 * happen if we don't ask for it.
+	 */
+	if (!sched->waiting && sched->next_external_sync_set &&
+	    usfstl_time_cmp(time, <, sched->next_external_sync))
+		return false;
+
+	/* If we asked for this time slot already, don't ask again but wait. */
+	if (sched->prev_external_sync_set && time == sched->prev_external_sync)
+		return true;
+
+	sched->prev_external_sync = time;
+	sched->prev_external_sync_set = 1;
+	sched->external_request(sched, time);
+
+	return true;
+}
+
+static void usfstl_sched_external_wait(struct usfstl_scheduler *sched)
+{
+	/*
+	 * Once we wait for the external scheduler, we have to ask again
+	 * even if for some reason we end up asking for the same time.
+	 */
+	sched->prev_external_sync_set = 0;
+	sched->waiting = 1;
+	sched->external_wait(sched);
+	sched->waiting = 0;
+}
+
+void usfstl_sched_add_job(struct usfstl_scheduler *sched, struct usfstl_job *job)
+{
+	struct usfstl_job *tmp;
+
+	USFSTL_ASSERT_TIME_CMP(job->start, >=, sched->current_time);
+	USFSTL_ASSERT(!usfstl_job_scheduled(job),
+		      "cannot add a job that's already scheduled");
+	USFSTL_ASSERT_CMP(job->group, <, 32, "%u");
+
+	if ((1 << job->group) & sched->blocked_groups &&
+	    job != sched->allowed_job) {
+		job->start = 0;
+		usfstl_list_append(&sched->pending_jobs, &job->entry);
+		return;
+	}
+
+	usfstl_for_each_list_item(tmp, &sched->joblist, entry) {
+		if (usfstl_time_cmp(tmp->start, >, job->start))
+			break;
+		if (tmp->start == job->start &&
+		    tmp->priority < job->priority)
+			break;
+	}
+
+	/* insert after previous entry */
+	if (!tmp)
+		usfstl_list_append(&sched->joblist, &job->entry);
+	else
+		usfstl_list_insert_before(&tmp->entry, &job->entry);
+
+	/*
+	 * Request the new job's runtime from the external scheduler
+	 * (if configured); if this job doesn't request any earlier
+	 * runtime than previously requested, this does nothing. It
+	 * may, however, request earlier runtime if this is due to
+	 * an interrupt we got from outside while waiting for the
+	 * external scheduler.
+	 */
+	usfstl_sched_external_request(sched, job->start);
+}
+
+bool usfstl_job_scheduled(struct usfstl_job *job)
+{
+	return job->entry.next != NULL;
+}
+
+void usfstl_sched_del_job(struct usfstl_job *job)
+{
+	if (!usfstl_job_scheduled(job))
+		return;
+
+	usfstl_list_item_remove(&job->entry);
+}
+
+void _usfstl_sched_set_time(struct usfstl_scheduler *sched, uint64_t time)
+{
+	uint64_t delta;
+
+	if (sched->current_time == time)
+		return;
+
+	// check that we at least don't move backwards
+	USFSTL_ASSERT_TIME_CMP(time, >=, sched->current_time);
+
+	delta = time - sched->current_time;
+	sched->current_time = time;
+
+	if (sched->time_advanced)
+		sched->time_advanced(sched, delta);
+}
+
+void usfstl_sched_set_time(struct usfstl_scheduler *sched, uint64_t time)
+{
+	/*
+	 * also check that we're not getting set to something later than what
+	 * we requested, that'd be a bug since we want to run something at an
+	 * earlier time than what we just got set to; unless we have nothing
+	 * to do and thus don't care at all.
+	 */
+	USFSTL_ASSERT(usfstl_list_empty(&sched->joblist) ||
+		      usfstl_time_cmp(time, <=, sched->prev_external_sync),
+		      "scheduler time moves further (to %" PRIu64 ") than requested (%" PRIu64 ")",
+		      time, sched->prev_external_sync);
+
+	_usfstl_sched_set_time(sched, time);
+}
+
+static void usfstl_sched_forward(struct usfstl_scheduler *sched, uint64_t until)
+{
+	USFSTL_ASSERT_TIME_CMP(until, >=, sched->current_time);
+
+	if (usfstl_sched_external_request(sched, until)) {
+		usfstl_sched_external_wait(sched);
+		/*
+		 * The external_wait() method must call
+		 * usfstl_sched_set_time() before returning,
+		 * so we don't in this case.
+		 */
+		return;
+	}
+
+	_usfstl_sched_set_time(sched, until);
+}
+
+void usfstl_sched_start(struct usfstl_scheduler *sched)
+{
+	if (usfstl_sched_external_request(sched, sched->current_time))
+		usfstl_sched_external_wait(sched);
+}
+
+struct usfstl_job *usfstl_sched_next(struct usfstl_scheduler *sched)
+{
+	struct usfstl_job *job;
+
+	/*
+	 * If external scheduler is active, we might get here with nothing
+	 * to do, so we just need to wait for an external input/job which
+	 * will add an job to our scheduler in usfstl_sched_add_job().
+	 */
+	if (usfstl_list_empty(&sched->joblist) && sched->external_request)
+		usfstl_sched_external_wait(sched);
+
+	while ((job = usfstl_sched_next_pending(sched, NULL))) {
+		/*
+		 * Forward, but only if job isn't in the past - this
+		 * can happen if some job was inserted while we
+		 * were in fact waiting for the external scheduler, i.e.
+		 * some sort of external job happened while we thought
+		 * there was nothing to do.
+		 */
+		if (usfstl_time_cmp(job->start, >, sched->current_time))
+			usfstl_sched_forward(sched, job->start);
+
+		/*
+		 * Some sort of external job might have come to us (while
+		 * we were stuck waiting for the external scheduler), and
+		 * might have inserted an earlier job into the timeline.
+		 * If it's not this job's turn yet, reinsert it and check
+		 * what's up next in the next loop iteration.
+		 */
+		if (usfstl_sched_next_pending(sched, NULL) != job)
+			continue;
+
+		/*
+		 * Otherwise we've actually reached this job, so remove
+		 * and call it.
+		 */
+		usfstl_sched_del_job(job);
+		job->callback(job);
+		return job;
+	}
+
+	/*
+	 * We must not get here, if there's no job whatsoever the
+	 * simulation has basically ended in an undefined state, even
+	 * the main thread can no longer make progress.
+	 */
+	USFSTL_ASSERT(0, "scheduling while there's nothing to do");
+}
+
+void usfstl_sched_set_sync_time(struct usfstl_scheduler *sched, uint64_t time)
+{
+	USFSTL_ASSERT_TIME_CMP(time, >=, sched->current_time);
+	sched->next_external_sync = time;
+	sched->next_external_sync_set = 1;
+}
+
+static void usfstl_sched_block_job(struct usfstl_scheduler *sched,
+				 struct usfstl_job *job)
+{
+	usfstl_sched_del_job(job);
+	usfstl_list_append(&sched->pending_jobs, &job->entry);
+}
+
+struct usfstl_job *usfstl_sched_next_pending(struct usfstl_scheduler *sched,
+					     struct usfstl_job *job)
+{
+	return job ? usfstl_next_item(&sched->joblist, job, struct usfstl_job, entry) :
+		     usfstl_list_first_item(&sched->joblist, struct usfstl_job, entry);
+}
+
+static void usfstl_sched_remove_blocked_jobs(struct usfstl_scheduler *sched)
+{
+	struct usfstl_job *job = NULL, *next;
+
+	usfstl_for_each_list_item_continue_safe(job, next, &sched->joblist,
+					      entry) {
+		if (job == sched->allowed_job)
+			continue;
+		if ((1 << job->group) & sched->blocked_groups)
+			usfstl_sched_block_job(sched, job);
+	}
+}
+
+static void usfstl_sched_restore_job(struct usfstl_scheduler *sched,
+				     struct usfstl_job *job)
+{
+	usfstl_sched_del_job(job);
+	if (usfstl_time_cmp(job->start, <, sched->current_time))
+		job->start = sched->current_time;
+	usfstl_sched_add_job(sched, job);
+}
+
+static void usfstl_sched_restore_blocked_jobs(struct usfstl_scheduler *sched)
+{
+	struct usfstl_job *job = NULL, *next;
+
+	usfstl_for_each_list_item_continue_safe(job, next, &sched->pending_jobs,
+					      entry) {
+		if (job == sched->allowed_job ||
+		    !((1 << job->group) & sched->blocked_groups))
+		usfstl_sched_restore_job(sched, job);
+	}
+}
+
+void usfstl_sched_block_groups(struct usfstl_scheduler *sched, uint32_t groups,
+			       struct usfstl_job *job,
+			       struct usfstl_sched_block_data *save)
+{
+	save->groups = sched->blocked_groups;
+	save->job = sched->allowed_job;
+
+	// it makes no sense to allow a job unless its group is blocked
+	USFSTL_ASSERT(!job || (1 << job->group) & groups,
+		    "allowed job group %d must be part of blocked groups (0x%x\n)",
+		    job->group, groups);
+
+	sched->blocked_groups |= groups;
+	sched->allowed_job = job;
+
+	usfstl_sched_remove_blocked_jobs(sched);
+}
+
+void usfstl_sched_restore_groups(struct usfstl_scheduler *sched,
+				 struct usfstl_sched_block_data *restore)
+{
+	sched->blocked_groups = restore->groups;
+	sched->allowed_job = restore->job;
+
+	usfstl_sched_restore_blocked_jobs(sched);
+	usfstl_sched_remove_blocked_jobs(sched);
+}
diff --git a/wmediumd/lib/schedctrl.c b/wmediumd/lib/schedctrl.c
new file mode 100644
index 000000000000..ed5a9089124d
--- /dev/null
+++ b/wmediumd/lib/schedctrl.c
@@ -0,0 +1,205 @@
+/*
+ * Copyright (C) 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <usfstl/uds.h>
+#include <usfstl/schedctrl.h>
+#include <linux/um_timetravel.h>
+#include "internal.h"
+#include <stdio.h>
+#include <stdlib.h>
+
+static void _usfstl_sched_ctrl_send_msg(struct usfstl_sched_ctrl *ctrl,
+					enum um_timetravel_ops op,
+					uint64_t time, uint32_t seq)
+{
+	struct um_timetravel_msg msg = {
+		.op = op,
+		.seq = seq,
+		.time = time,
+	};
+
+	USFSTL_ASSERT_EQ((int)write(ctrl->fd, &msg, sizeof(msg)),
+			 (int)sizeof(msg), "%d");
+}
+
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
+static void usfstl_sched_ctrl_sock_read(int fd, void *data)
+{
+	struct usfstl_sched_ctrl *ctrl = data;
+	struct um_timetravel_msg msg;
+	int sz = read(fd, &msg, sizeof(msg));
+	uint64_t time;
+
+	USFSTL_ASSERT_EQ(sz, (int)sizeof(msg), "%d");
+
+	switch (msg.op) {
+	case UM_TIMETRAVEL_ACK:
+		if (msg.seq == ctrl->expected_ack_seq) {
+			ctrl->acked = 1;
+			ctrl->ack_time = msg.time;
+		}
+		return;
+	case UM_TIMETRAVEL_RUN:
+		time = DIV_ROUND_UP(msg.time - ctrl->offset,
+				    ctrl->nsec_per_tick);
+		usfstl_sched_set_time(ctrl->sched, time);
+		ctrl->waiting = 0;
+		break;
+	case UM_TIMETRAVEL_FREE_UNTIL:
+		/* round down here, so we don't overshoot */
+		time = (msg.time - ctrl->offset) / ctrl->nsec_per_tick;
+		usfstl_sched_set_sync_time(ctrl->sched, time);
+		break;
+	case UM_TIMETRAVEL_START:
+	case UM_TIMETRAVEL_REQUEST:
+	case UM_TIMETRAVEL_WAIT:
+	case UM_TIMETRAVEL_GET:
+	case UM_TIMETRAVEL_UPDATE:
+	case UM_TIMETRAVEL_GET_TOD:
+		USFSTL_ASSERT(0);
+		return;
+	}
+
+	_usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_ACK, 0, msg.seq);
+}
+
+static void usfstl_sched_ctrl_request(struct usfstl_scheduler *sched, uint64_t time)
+{
+	struct usfstl_sched_ctrl *ctrl = sched->ext.ctrl;
+
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_REQUEST,
+				   time * ctrl->nsec_per_tick + ctrl->offset);
+}
+
+static void usfstl_sched_ctrl_wait(struct usfstl_scheduler *sched)
+{
+	struct usfstl_sched_ctrl *ctrl = sched->ext.ctrl;
+
+	ctrl->waiting = 1;
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_WAIT, -1);
+
+	while (ctrl->waiting)
+		usfstl_loop_wait_and_handle();
+}
+
+#define JOB_ASSERT_VAL(j) (j) ? (j)->name : "<NULL>"
+
+extern struct usfstl_sched_ctrl g_schedCtrl;
+extern struct usfstl_scheduler g_usfstl_task_scheduler;
+
+void usfstl_sched_ctrl_start(struct usfstl_sched_ctrl *ctrl,
+			     const char *socket,
+			     uint32_t nsec_per_tick,
+			     uint64_t client_id,
+			     struct usfstl_scheduler *sched)
+{
+	struct usfstl_job *job;
+
+	USFSTL_ASSERT_EQ(ctrl->sched, NULL, "%p");
+	USFSTL_ASSERT_EQ(sched->ext.ctrl, NULL, "%p");
+
+	/*
+	 * The remote side assumes we start at 0, so if we don't have 0 right
+	 * now keep the difference in our own offset (in nsec).
+	 */
+	ctrl->offset = -sched->current_time * nsec_per_tick;
+
+	ctrl->nsec_per_tick = nsec_per_tick;
+	ctrl->sched = sched;
+	sched->ext.ctrl = ctrl;
+
+	USFSTL_ASSERT_EQ(usfstl_sched_next_pending(sched, NULL),
+			 (struct usfstl_job *)NULL, "%s", JOB_ASSERT_VAL);
+	USFSTL_ASSERT_EQ(sched->external_request, NULL, "%p");
+	USFSTL_ASSERT_EQ(sched->external_wait, NULL, "%p");
+
+	sched->external_request = usfstl_sched_ctrl_request;
+	sched->external_wait = usfstl_sched_ctrl_wait;
+
+	ctrl->fd = usfstl_uds_connect(socket, usfstl_sched_ctrl_sock_read,
+				      ctrl);
+
+	/* tell the other side we're starting  */
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_START, client_id);
+
+	/* if we have a job already, request it */
+	job = usfstl_sched_next_pending(sched, NULL);
+	if (job)
+		usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_REQUEST,
+					   job->start * nsec_per_tick);
+
+	/*
+	 * At this point, we're allowed to do further setup work and can
+	 * request schedule time etc. but must eventually start scheduling
+	 * the linked scheduler - the remote side is blocked until we do.
+	 */
+}
+
+void usfstl_sched_ctrl_sync_to(struct usfstl_sched_ctrl *ctrl)
+{
+	uint64_t time;
+
+	time = usfstl_sched_current_time(ctrl->sched) * ctrl->nsec_per_tick;
+	time += ctrl->offset;
+
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_UPDATE, time);
+}
+
+void usfstl_sched_ctrl_sync_from(struct usfstl_sched_ctrl *ctrl)
+{
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_GET, -1);
+}
+
+void usfstl_sched_ctrl_stop(struct usfstl_sched_ctrl *ctrl)
+{
+	USFSTL_ASSERT_EQ(ctrl, ctrl->sched->ext.ctrl, "%p");
+	usfstl_sched_ctrl_send_msg(ctrl, UM_TIMETRAVEL_WAIT, -1);
+	usfstl_uds_disconnect(ctrl->fd);
+	ctrl->sched->ext.ctrl = NULL;
+	ctrl->sched->external_request = NULL;
+	ctrl->sched->external_wait = NULL;
+	ctrl->sched = NULL;
+}
+
+void usfstl_sched_ctrl_set_frozen(struct usfstl_sched_ctrl *ctrl, bool frozen)
+{
+	ctrl->frozen = frozen;
+}
diff --git a/wmediumd/lib/uds.c b/wmediumd/lib/uds.c
new file mode 100644
index 000000000000..5601bc4795c5
--- /dev/null
+++ b/wmediumd/lib/uds.c
@@ -0,0 +1,160 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <stddef.h>
+#include <stdbool.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/stat.h>
+#include <sys/types.h>
+#include <sys/socket.h>
+#include <sys/un.h>
+#include <errno.h>
+#include <usfstl/assert.h>
+#include <usfstl/loop.h>
+#include <usfstl/list.h>
+#include "internal.h"
+
+struct usfstl_uds_server {
+	struct usfstl_loop_entry entry;
+	void (*connected)(int fd, void *data);
+	void *data;
+	char name[];
+};
+
+void usfstl_uds_accept_handler(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_uds_server *uds;
+	int fd;
+
+	uds = container_of(entry, struct usfstl_uds_server, entry);
+	fd = accept(uds->entry.fd, NULL, NULL);
+
+	uds->connected(fd, uds->data);
+}
+
+void usfstl_uds_create(const char *path, void (*connected)(int, void *),
+		       void *data)
+{
+	struct usfstl_uds_server *uds = malloc(sizeof(*uds) + strlen(path) + 1);
+	struct stat buf;
+	int ret = stat(path, &buf), fd;
+	struct sockaddr_un un = {
+		.sun_family = AF_UNIX,
+	};
+
+	USFSTL_ASSERT(uds);
+	strcpy(uds->name, path);
+	uds->data = data;
+	uds->connected = connected;
+
+	if (ret == 0) {
+		USFSTL_ASSERT_EQ((int)(buf.st_mode & S_IFMT), S_IFSOCK, "%d");
+		USFSTL_ASSERT_EQ(unlink(path), 0, "%d");
+	} else {
+		USFSTL_ASSERT_EQ(errno, ENOENT, "%d");
+	}
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	uds->entry.fd = fd;
+
+	strcpy(un.sun_path, path);
+	USFSTL_ASSERT_EQ(bind(fd, (void *)&un, sizeof(un)), 0, "%d");
+
+	USFSTL_ASSERT_EQ(listen(fd, 1000), 0, "%d");
+
+	uds->entry.handler = usfstl_uds_accept_handler;
+
+	usfstl_loop_register(&uds->entry);
+}
+
+void usfstl_uds_remove(const char *path)
+{
+	struct usfstl_loop_entry *tmp;
+	struct usfstl_uds_server *uds, *found = NULL;
+
+	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+		if (tmp->handler != usfstl_uds_accept_handler)
+			continue;
+
+		uds = container_of(tmp, struct usfstl_uds_server, entry);
+		if (strcmp(uds->name, path) == 0) {
+			found = uds;
+			break;
+		}
+	}
+
+	USFSTL_ASSERT(found);
+
+	usfstl_loop_unregister(&found->entry);
+	unlink(path);
+	free(found);
+}
+
+struct usfstl_uds_client {
+	struct usfstl_loop_entry entry;
+	void (*readable)(int fd, void *data);
+	void *data;
+};
+
+void usfstl_uds_readable_handler(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_uds_client *uds;
+
+	uds = container_of(entry, struct usfstl_uds_client, entry);
+
+	uds->readable(uds->entry.fd, uds->data);
+}
+
+int usfstl_uds_connect(const char *path, void (*readable)(int, void *),
+		       void *data)
+{
+	struct usfstl_uds_client *client;
+	struct sockaddr_un sock;
+	int fd, err;
+
+	client = calloc(1, sizeof(*client));
+	USFSTL_ASSERT(client);
+	client->entry.handler = usfstl_uds_readable_handler;
+	client->readable = readable;
+	client->data = data;
+
+	sock.sun_family = AF_UNIX;
+	strcpy(sock.sun_path, path);
+
+	fd = socket(AF_UNIX, SOCK_STREAM, 0);
+	USFSTL_ASSERT(fd >= 0);
+
+	err = connect(fd, (struct sockaddr *) &sock, sizeof(sock));
+	USFSTL_ASSERT(err == 0);
+
+	client->entry.fd = fd;
+	usfstl_loop_register(&client->entry);
+
+	return fd;
+}
+
+void usfstl_uds_disconnect(int fd)
+{
+	struct usfstl_loop_entry *tmp;
+	struct usfstl_uds_client *uds, *found = NULL;
+
+	usfstl_for_each_list_item(tmp, &g_usfstl_loop_entries, list) {
+		if (tmp->handler != usfstl_uds_readable_handler)
+			continue;
+
+		uds = container_of(tmp, struct usfstl_uds_client, entry);
+		if (uds->entry.fd == fd) {
+			found = uds;
+			break;
+		}
+	}
+
+	USFSTL_ASSERT(found);
+
+	usfstl_loop_unregister(&found->entry);
+	free(found);
+}
diff --git a/wmediumd/lib/vhost.c b/wmediumd/lib/vhost.c
new file mode 100644
index 000000000000..9f116f57f04a
--- /dev/null
+++ b/wmediumd/lib/vhost.c
@@ -0,0 +1,834 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <stdlib.h>
+#include <usfstl/list.h>
+#include <usfstl/loop.h>
+#include <usfstl/uds.h>
+#include <sys/socket.h>
+#include <sys/mman.h>
+#include <sys/un.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <usfstl/vhost.h>
+#include <linux/virtio_ring.h>
+#include <linux/virtio_config.h>
+#include <endian.h>
+
+#define MAX_REGIONS 2
+#define SG_STACK_PREALLOC 5
+
+struct usfstl_vhost_user_dev_int {
+	struct usfstl_list fds;
+	struct usfstl_job irq_job;
+
+	struct usfstl_loop_entry entry;
+
+	struct usfstl_vhost_user_dev ext;
+
+	unsigned int n_regions;
+	struct vhost_user_region regions[MAX_REGIONS];
+	int region_fds[MAX_REGIONS];
+	void *region_vaddr[MAX_REGIONS];
+
+	int req_fd;
+
+	struct {
+		struct usfstl_loop_entry entry;
+		bool enabled;
+		bool triggered;
+		struct vring virtq;
+		int call_fd;
+		uint16_t last_avail_idx;
+	} virtqs[];
+};
+
+#define CONV(bits)							\
+static inline uint##bits##_t __attribute__((used))			\
+cpu_to_virtio##bits(struct usfstl_vhost_user_dev_int *dev,		\
+		    uint##bits##_t v)					\
+{									\
+	if (dev->ext.features & (1ULL << VIRTIO_F_VERSION_1))		\
+		return htole##bits(v);					\
+	return v;							\
+}									\
+static inline uint##bits##_t __attribute__((used))			\
+virtio_to_cpu##bits(struct usfstl_vhost_user_dev_int *dev,		\
+		    uint##bits##_t v)					\
+{									\
+	if (dev->ext.features & (1ULL << VIRTIO_F_VERSION_1))		\
+		return le##bits##toh(v);				\
+	return v;							\
+}
+
+CONV(16)
+CONV(32)
+CONV(64)
+
+static struct usfstl_vhost_user_buf *
+usfstl_vhost_user_get_virtq_buf(struct usfstl_vhost_user_dev_int *dev,
+			      unsigned int virtq_idx,
+			      struct usfstl_vhost_user_buf *fixed)
+{
+	struct usfstl_vhost_user_buf *buf = fixed;
+	struct vring *virtq = &dev->virtqs[virtq_idx].virtq;
+	uint16_t avail_idx = virtio_to_cpu16(dev, virtq->avail->idx);
+	uint16_t idx, desc_idx;
+	struct vring_desc *desc;
+	unsigned int n_in = 0, n_out = 0;
+	bool more;
+
+	if (avail_idx == dev->virtqs[virtq_idx].last_avail_idx)
+		return NULL;
+
+	/* ensure we read the descriptor after checking the index */
+	__sync_synchronize();
+
+	idx = dev->virtqs[virtq_idx].last_avail_idx++;
+	idx %= virtq->num;
+	desc_idx = virtio_to_cpu16(dev, virtq->avail->ring[idx]);
+	USFSTL_ASSERT(desc_idx < virtq->num);
+
+	desc = &virtq->desc[desc_idx];
+	do {
+		more = virtio_to_cpu16(dev, desc->flags) & VRING_DESC_F_NEXT;
+
+		if (virtio_to_cpu16(dev, desc->flags) & VRING_DESC_F_WRITE)
+			n_in++;
+		else
+			n_out++;
+		desc = &virtq->desc[virtio_to_cpu16(dev, desc->next)];
+	} while (more);
+
+	if (n_in > fixed->n_in_sg || n_out > fixed->n_out_sg) {
+	    	size_t sz = sizeof(*buf);
+	    	struct iovec *vec;
+
+		sz += (n_in + n_out) * sizeof(*vec);
+
+		buf = calloc(1, sz);
+		if (!buf)
+			return NULL;
+
+		vec = (void *)(buf + 1);
+		buf->in_sg = vec;
+		buf->out_sg = vec + n_in;
+		buf->allocated = true;
+	}
+
+	buf->n_in_sg = 0;
+	buf->n_out_sg = 0;
+	buf->idx = desc_idx;
+
+	desc = &virtq->desc[desc_idx];
+	do {
+		struct iovec *vec;
+		uint64_t addr;
+
+		more = virtio_to_cpu16(dev, desc->flags) & VRING_DESC_F_NEXT;
+
+		if (virtio_to_cpu16(dev, desc->flags) & VRING_DESC_F_WRITE) {
+			vec = &buf->in_sg[buf->n_in_sg];
+			buf->n_in_sg++;
+		} else {
+			vec = &buf->out_sg[buf->n_out_sg];
+			buf->n_out_sg++;
+		}
+
+		addr = virtio_to_cpu64(dev, desc->addr);
+		vec->iov_base = usfstl_vhost_user_to_va(&dev->ext, addr);
+		vec->iov_len = virtio_to_cpu32(dev, desc->len);
+
+		desc = &virtq->desc[virtio_to_cpu16(dev, desc->next)];
+	} while (more);
+
+	return buf;
+}
+
+static void usfstl_vhost_user_free_buf(struct usfstl_vhost_user_buf *buf)
+{
+	if (buf->allocated)
+		free(buf);
+}
+
+static void usfstl_vhost_user_readable_handler(struct usfstl_loop_entry *entry)
+{
+	usfstl_loop_unregister(entry);
+	entry->fd = -1;
+}
+
+static int usfstl_vhost_user_read_msg(int fd, struct msghdr *msghdr)
+{
+	struct iovec msg_iov;
+	struct msghdr hdr2 = {
+		.msg_iov = &msg_iov,
+		.msg_iovlen = 1,
+		.msg_control = msghdr->msg_control,
+		.msg_controllen = msghdr->msg_controllen,
+	};
+	struct vhost_user_msg_hdr *hdr;
+	size_t i;
+	size_t maxlen = 0;
+	ssize_t len;
+
+	USFSTL_ASSERT(msghdr->msg_iovlen >= 1);
+	USFSTL_ASSERT(msghdr->msg_iov[0].iov_len >= sizeof(*hdr));
+
+	hdr = msghdr->msg_iov[0].iov_base;
+	msg_iov.iov_base = hdr;
+	msg_iov.iov_len = sizeof(*hdr);
+
+	len = recvmsg(fd, &hdr2, 0);
+	if (len < 0)
+		return -errno;
+	if (len == 0)
+		return -ENOTCONN;
+
+	for (i = 0; i < msghdr->msg_iovlen; i++)
+		maxlen += msghdr->msg_iov[i].iov_len;
+	maxlen -= sizeof(*hdr);
+
+	USFSTL_ASSERT_EQ((int)len, (int)sizeof(*hdr), "%d");
+	USFSTL_ASSERT(hdr->size <= maxlen);
+
+	if (!hdr->size)
+		return 0;
+
+	msghdr->msg_control = NULL;
+	msghdr->msg_controllen = 0;
+	msghdr->msg_iov[0].iov_base += sizeof(*hdr);
+	msghdr->msg_iov[0].iov_len -= sizeof(*hdr);
+	len = recvmsg(fd, msghdr, 0);
+
+	/* restore just in case the user needs it */
+	msghdr->msg_iov[0].iov_base -= sizeof(*hdr);
+	msghdr->msg_iov[0].iov_len += sizeof(*hdr);
+	msghdr->msg_control = hdr2.msg_control;
+	msghdr->msg_controllen = hdr2.msg_controllen;
+
+	if (len < 0)
+		return -errno;
+	if (len == 0)
+		return -ENOTCONN;
+
+	USFSTL_ASSERT_EQ(hdr->size, (uint32_t)len, "%u");
+
+	return 0;
+}
+
+static void usfstl_vhost_user_send_virtq_buf(struct usfstl_vhost_user_dev_int *dev,
+					     struct usfstl_vhost_user_buf *buf,
+					     int virtq_idx)
+{
+	struct vring *virtq = &dev->virtqs[virtq_idx].virtq;
+	unsigned int idx, widx;
+	int call_fd = dev->virtqs[virtq_idx].call_fd;
+	ssize_t written;
+	uint64_t e = 1;
+
+	if (dev->ext.server->ctrl)
+		usfstl_sched_ctrl_sync_to(dev->ext.server->ctrl);
+
+	idx = virtio_to_cpu16(dev, virtq->used->idx);
+	widx = idx + 1;
+
+	idx %= virtq->num;
+	virtq->used->ring[idx].id = cpu_to_virtio32(dev, buf->idx);
+	virtq->used->ring[idx].len = cpu_to_virtio32(dev, buf->written);
+
+	/* write buffers / used table before flush */
+	__sync_synchronize();
+
+	virtq->used->idx = cpu_to_virtio16(dev, widx);
+	
+	if (call_fd < 0 &&
+	    dev->ext.protocol_features &
+			(1ULL << VHOST_USER_PROTOCOL_F_INBAND_NOTIFICATIONS) &&
+	    dev->ext.protocol_features &
+			(1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ)) {
+		struct vhost_user_msg msg = {
+			.hdr.request = VHOST_USER_SLAVE_VRING_CALL,
+			.hdr.flags = VHOST_USER_VERSION,
+			.hdr.size = sizeof(msg.payload.vring_state),
+			.payload.vring_state = {
+				.idx = virtq_idx,
+			},
+		};
+		bool ack = dev->ext.protocol_features &
+			   (1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK);
+		size_t msgsz = sizeof(msg.hdr) + msg.hdr.size;
+
+		if (ack)
+			msg.hdr.flags |= VHOST_USER_MSG_FLAGS_NEED_REPLY;
+
+		written = write(dev->req_fd, &msg, msgsz);
+		USFSTL_ASSERT_EQ(written, (ssize_t)msgsz, "%zd");
+
+		if (ack) {
+			struct usfstl_loop_entry entry = {
+				.fd = dev->req_fd,
+				.priority = 0x7fffffff, // max
+				.handler = usfstl_vhost_user_readable_handler,
+			};
+			struct iovec msg_iov = {
+				.iov_base = &msg,
+				.iov_len = sizeof(msg),
+			};
+			struct msghdr msghdr = {
+				.msg_iovlen = 1,
+				.msg_iov = &msg_iov,
+			};
+
+			/*
+			 * Wait for the fd to be readable - we may have to
+			 * handle other simulation (time) messages while
+			 * waiting ...
+			 */
+			usfstl_loop_register(&entry);
+			while (entry.fd != -1)
+				usfstl_loop_wait_and_handle();
+			USFSTL_ASSERT_EQ(usfstl_vhost_user_read_msg(dev->req_fd,
+								    &msghdr),
+				       0, "%d");
+		}
+
+		return;
+	}
+
+	written = write(dev->virtqs[virtq_idx].call_fd, &e, sizeof(e));
+	USFSTL_ASSERT_EQ(written, (ssize_t)sizeof(e), "%zd");
+}
+
+static void usfstl_vhost_user_handle_queue(struct usfstl_vhost_user_dev_int *dev,
+					 unsigned int virtq_idx)
+{
+	/* preallocate on the stack for most cases */
+	struct iovec in_sg[SG_STACK_PREALLOC] = { };
+	struct iovec out_sg[SG_STACK_PREALLOC] = { };
+	struct usfstl_vhost_user_buf _buf = {
+		.in_sg = in_sg,
+		.n_in_sg = SG_STACK_PREALLOC,
+		.out_sg = out_sg,
+		.n_out_sg = SG_STACK_PREALLOC,
+	};
+	struct usfstl_vhost_user_buf *buf;
+
+	while ((buf = usfstl_vhost_user_get_virtq_buf(dev, virtq_idx, &_buf))) {
+		dev->ext.server->ops->handle(&dev->ext, buf, virtq_idx);
+
+		usfstl_vhost_user_send_virtq_buf(dev, buf, virtq_idx);
+		usfstl_vhost_user_free_buf(buf);
+	}
+}
+
+static void usfstl_vhost_user_job_callback(struct usfstl_job *job)
+{
+	struct usfstl_vhost_user_dev_int *dev = job->data;
+	unsigned int virtq;
+
+	for (virtq = 0; virtq < dev->ext.server->max_queues; virtq++) {
+		if (!dev->virtqs[virtq].triggered)
+			continue;
+		dev->virtqs[virtq].triggered = false;
+
+		usfstl_vhost_user_handle_queue(dev, virtq);
+	}
+}
+
+static void usfstl_vhost_user_virtq_kick(struct usfstl_vhost_user_dev_int *dev,
+				       unsigned int virtq)
+{
+	if (!(dev->ext.server->input_queues & (1ULL << virtq)))
+		return;
+
+	dev->virtqs[virtq].triggered = true;
+
+	if (usfstl_job_scheduled(&dev->irq_job))
+		return;
+
+	if (!dev->ext.server->scheduler) {
+		usfstl_vhost_user_job_callback(&dev->irq_job);
+		return;
+	}
+
+	if (dev->ext.server->ctrl)
+		usfstl_sched_ctrl_sync_from(dev->ext.server->ctrl);
+
+	dev->irq_job.start = usfstl_sched_current_time(dev->ext.server->scheduler) +
+			     dev->ext.server->interrupt_latency;
+	usfstl_sched_add_job(dev->ext.server->scheduler, &dev->irq_job);
+}
+
+static void usfstl_vhost_user_virtq_fdkick(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_vhost_user_dev_int *dev = entry->data;
+	unsigned int virtq;
+	uint64_t v;
+
+	for (virtq = 0; virtq < dev->ext.server->max_queues; virtq++) {
+		if (entry == &dev->virtqs[virtq].entry)
+			break;
+	}
+
+	USFSTL_ASSERT(virtq < dev->ext.server->max_queues);
+
+	USFSTL_ASSERT_EQ((int)read(entry->fd, &v, sizeof(v)),
+		       (int)sizeof(v), "%d");
+
+	usfstl_vhost_user_virtq_kick(dev, virtq);
+}
+
+static void usfstl_vhost_user_setup_mappings(struct usfstl_vhost_user_dev_int *dev)
+{
+	unsigned int idx;
+
+	for (idx = 0; idx < dev->n_regions; idx++) {
+		/*
+		 * Cannot rely on the offset being page-aligned, I think ...
+		 * adjust for it later when we translate addresses instead.
+		 */
+		dev->region_vaddr[idx] = mmap(NULL,
+					      dev->regions[idx].size +
+					      dev->regions[idx].mmap_offset,
+					      PROT_READ | PROT_WRITE, MAP_SHARED,
+					      dev->region_fds[idx], 0);
+		USFSTL_ASSERT(dev->region_vaddr[idx] != (void *)-1,
+			      "mmap() failed (%d) for fd %d", errno, dev->region_fds[idx]);
+	}
+}
+
+static void
+usfstl_vhost_user_update_virtq_kick(struct usfstl_vhost_user_dev_int *dev,
+				  unsigned int virtq, int fd)
+{
+	if (dev->virtqs[virtq].entry.fd != -1) {
+		usfstl_loop_unregister(&dev->virtqs[virtq].entry);
+		close(dev->virtqs[virtq].entry.fd);
+	}
+
+	if (fd != -1) {
+		dev->virtqs[virtq].entry.fd = fd;
+		usfstl_loop_register(&dev->virtqs[virtq].entry);
+	}
+}
+
+static void usfstl_vhost_user_dev_free(struct usfstl_vhost_user_dev_int *dev)
+{
+	unsigned int virtq, region;
+
+	usfstl_loop_unregister(&dev->entry);
+	usfstl_sched_del_job(&dev->irq_job);
+
+	for (virtq = 0; virtq < dev->ext.server->max_queues; virtq++) {
+		usfstl_vhost_user_update_virtq_kick(dev, virtq, -1);
+		if (dev->virtqs[virtq].call_fd != -1)
+			close(dev->virtqs[virtq].call_fd);
+	}
+
+	for (region = 0; region < MAX_REGIONS; region++) {
+		if (!dev->region_vaddr[region])
+			continue;
+		munmap(dev->region_vaddr[region], dev->regions[region].size);
+	}
+
+	if (dev->ext.server->ops->disconnected)
+		dev->ext.server->ops->disconnected(&dev->ext);
+	free(dev);
+}
+
+static void usfstl_vhost_user_get_msg_fds(struct msghdr *msghdr,
+					int *outfds, int max_fds)
+{
+	struct cmsghdr *msg;
+	int fds;
+
+	for (msg = CMSG_FIRSTHDR(msghdr); msg; msg = CMSG_NXTHDR(msghdr, msg)) {
+		if (msg->cmsg_level != SOL_SOCKET)
+			continue;
+		if (msg->cmsg_type != SCM_RIGHTS)
+			continue;
+
+		fds = (msg->cmsg_len - CMSG_LEN(0)) / sizeof(int);
+		USFSTL_ASSERT(fds <= max_fds);
+		memcpy(outfds, CMSG_DATA(msg), fds * sizeof(int));
+		break;
+	}
+}
+
+static void usfstl_vhost_user_handle_msg(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_vhost_user_dev_int *dev;
+	struct vhost_user_msg msg;
+	uint8_t data[256]; // limits the config space size ...
+	struct iovec msg_iov[3] = {
+		[0] = {
+			.iov_base = &msg.hdr,
+			.iov_len = sizeof(msg.hdr),
+		},
+		[1] = {
+			.iov_base = &msg.payload,
+			.iov_len = sizeof(msg.payload),
+		},
+		[2] = {
+			.iov_base = data,
+			.iov_len = sizeof(data),
+		},
+	};
+	uint8_t msg_control[CMSG_SPACE(sizeof(int) * MAX_REGIONS)] = { 0 };
+	struct msghdr msghdr = {
+		.msg_iov = msg_iov,
+		.msg_iovlen = 3,
+		.msg_control = msg_control,
+		.msg_controllen = sizeof(msg_control),
+	};
+	ssize_t len;
+	size_t reply_len = 0;
+	unsigned int virtq;
+	int fd;
+
+	dev = container_of(entry, struct usfstl_vhost_user_dev_int, entry);
+
+	if (usfstl_vhost_user_read_msg(entry->fd, &msghdr)) {
+		usfstl_vhost_user_dev_free(dev);
+		return;
+	}
+	len = msg.hdr.size;
+
+	USFSTL_ASSERT((msg.hdr.flags & VHOST_USER_MSG_FLAGS_VERSION) ==
+		    VHOST_USER_VERSION);
+
+	switch (msg.hdr.request) {
+	case VHOST_USER_GET_FEATURES:
+		USFSTL_ASSERT_EQ(len, (ssize_t)0, "%zd");
+		reply_len = sizeof(uint64_t);
+		msg.payload.u64 = dev->ext.server->features;
+		msg.payload.u64 |= 1ULL << VHOST_USER_F_PROTOCOL_FEATURES;
+		break;
+	case VHOST_USER_SET_FEATURES:
+		USFSTL_ASSERT_EQ(len, (ssize_t)sizeof(msg.payload.u64), "%zd");
+		dev->ext.features = msg.payload.u64;
+		break;
+	case VHOST_USER_SET_OWNER:
+		USFSTL_ASSERT_EQ(len, (ssize_t)0, "%zd");
+		/* nothing to be done */
+		break;
+	case VHOST_USER_SET_MEM_TABLE:
+		USFSTL_ASSERT(len >= (int)sizeof(msg.payload.mem_regions));
+		USFSTL_ASSERT(msg.payload.mem_regions.n_regions <= MAX_REGIONS);
+		memcpy(dev->regions, msg.payload.mem_regions.regions,
+		       msg.payload.mem_regions.n_regions *
+		       sizeof(dev->regions[0]));
+		dev->n_regions = msg.payload.mem_regions.n_regions;
+		usfstl_vhost_user_get_msg_fds(&msghdr, dev->region_fds, MAX_REGIONS);
+		usfstl_vhost_user_setup_mappings(dev);
+		break;
+	case VHOST_USER_SET_VRING_NUM:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.vring_state));
+		USFSTL_ASSERT(msg.payload.vring_state.idx <
+			      dev->ext.server->max_queues);
+		dev->virtqs[msg.payload.vring_state.idx].virtq.num =
+			msg.payload.vring_state.num;
+		break;
+	case VHOST_USER_SET_VRING_ADDR:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.vring_addr));
+		USFSTL_ASSERT(msg.payload.vring_addr.idx <=
+			      dev->ext.server->max_queues);
+		USFSTL_ASSERT_EQ(msg.payload.vring_addr.flags, (uint32_t)0, "0x%x");
+		USFSTL_ASSERT(!dev->virtqs[msg.payload.vring_addr.idx].enabled);
+		dev->virtqs[msg.payload.vring_addr.idx].virtq.desc =
+			usfstl_vhost_user_to_va(&dev->ext,
+					      msg.payload.vring_addr.descriptor);
+		dev->virtqs[msg.payload.vring_addr.idx].virtq.used =
+			usfstl_vhost_user_to_va(&dev->ext,
+					      msg.payload.vring_addr.used);
+		dev->virtqs[msg.payload.vring_addr.idx].virtq.avail =
+			usfstl_vhost_user_to_va(&dev->ext,
+					      msg.payload.vring_addr.avail);
+		USFSTL_ASSERT(dev->virtqs[msg.payload.vring_addr.idx].virtq.avail &&
+			    dev->virtqs[msg.payload.vring_addr.idx].virtq.desc &&
+			    dev->virtqs[msg.payload.vring_addr.idx].virtq.used);
+		break;
+	case VHOST_USER_SET_VRING_BASE:
+		/* ignored - logging not supported */
+		/*
+		 * FIXME: our Linux UML virtio implementation
+		 *        shouldn't send this
+		 */
+		break;
+	case VHOST_USER_SET_VRING_KICK:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.u64));
+		virtq = msg.payload.u64 & VHOST_USER_U64_VRING_IDX_MSK;
+		USFSTL_ASSERT(virtq <= dev->ext.server->max_queues);
+		if (msg.payload.u64 & VHOST_USER_U64_NO_FD)
+			fd = -1;
+		else
+			usfstl_vhost_user_get_msg_fds(&msghdr, &fd, 1);
+		usfstl_vhost_user_update_virtq_kick(dev, virtq, fd);
+		break;
+	case VHOST_USER_SET_VRING_CALL:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.u64));
+		virtq = msg.payload.u64 & VHOST_USER_U64_VRING_IDX_MSK;
+		USFSTL_ASSERT(virtq <= dev->ext.server->max_queues);
+		if (dev->virtqs[virtq].call_fd != -1)
+			close(dev->virtqs[virtq].call_fd);
+		if (msg.payload.u64 & VHOST_USER_U64_NO_FD)
+			dev->virtqs[virtq].call_fd = -1;
+		else
+			usfstl_vhost_user_get_msg_fds(&msghdr,
+						    &dev->virtqs[virtq].call_fd,
+						    1);
+		break;
+	case VHOST_USER_GET_PROTOCOL_FEATURES:
+		USFSTL_ASSERT_EQ(len, (ssize_t)0, "%zd");
+		reply_len = sizeof(uint64_t);
+		msg.payload.u64 = dev->ext.server->protocol_features;
+		if (dev->ext.server->config && dev->ext.server->config_len)
+			msg.payload.u64 |= 1ULL << VHOST_USER_PROTOCOL_F_CONFIG;
+		msg.payload.u64 |= 1ULL << VHOST_USER_PROTOCOL_F_SLAVE_REQ;
+		msg.payload.u64 |= 1ULL << VHOST_USER_PROTOCOL_F_SLAVE_SEND_FD;
+		msg.payload.u64 |= 1ULL << VHOST_USER_PROTOCOL_F_REPLY_ACK;
+		break;
+	case VHOST_USER_SET_VRING_ENABLE:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.vring_state));
+		USFSTL_ASSERT(msg.payload.vring_state.idx <
+			      dev->ext.server->max_queues);
+		dev->virtqs[msg.payload.vring_state.idx].enabled =
+			msg.payload.vring_state.num;
+		break;
+	case VHOST_USER_SET_PROTOCOL_FEATURES:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.u64));
+		dev->ext.protocol_features = msg.payload.u64;
+		break;
+	case VHOST_USER_SET_SLAVE_REQ_FD:
+		USFSTL_ASSERT_EQ(len, (ssize_t)0, "%zd");
+		usfstl_vhost_user_get_msg_fds(&msghdr, &dev->req_fd, 1);
+		USFSTL_ASSERT(dev->req_fd != -1);
+		break;
+	case VHOST_USER_GET_CONFIG:
+		USFSTL_ASSERT(len == (int)(sizeof(msg.payload.cfg_space) +
+					msg.payload.cfg_space.size));
+		USFSTL_ASSERT(dev->ext.server->config && dev->ext.server->config_len);
+		USFSTL_ASSERT(msg.payload.cfg_space.offset == 0);
+		USFSTL_ASSERT(msg.payload.cfg_space.size <= dev->ext.server->config_len);
+		msg.payload.cfg_space.flags = 0;
+		msg_iov[1].iov_len = sizeof(msg.payload.cfg_space);
+		msg_iov[2].iov_base = (void *)dev->ext.server->config;
+		reply_len = len;
+		break;
+	case VHOST_USER_VRING_KICK:
+		USFSTL_ASSERT(len == (int)sizeof(msg.payload.vring_state));
+		USFSTL_ASSERT(msg.payload.vring_state.idx <
+			      dev->ext.server->max_queues);
+		USFSTL_ASSERT(msg.payload.vring_state.num == 0);
+		usfstl_vhost_user_virtq_kick(dev, msg.payload.vring_state.idx);
+		break;
+	default:
+		USFSTL_ASSERT(0, "Unsupported message: %d\n", msg.hdr.request);
+	}
+
+	if (reply_len || (msg.hdr.flags & VHOST_USER_MSG_FLAGS_NEED_REPLY)) {
+		size_t i, tmp;
+
+		if (!reply_len) {
+			msg.payload.u64 = 0;
+			reply_len = sizeof(uint64_t);
+		}
+
+		msg.hdr.size = reply_len;
+		msg.hdr.flags &= ~VHOST_USER_MSG_FLAGS_NEED_REPLY;
+		msg.hdr.flags |= VHOST_USER_MSG_FLAGS_REPLY;
+
+		msghdr.msg_control = NULL;
+		msghdr.msg_controllen = 0;
+
+		reply_len += sizeof(msg.hdr);
+
+		tmp = reply_len;
+		for (i = 0; tmp && i < msghdr.msg_iovlen; i++) {
+			if (tmp <= msg_iov[i].iov_len)
+				msg_iov[i].iov_len = tmp;
+			tmp -= msg_iov[i].iov_len;
+		}
+		msghdr.msg_iovlen = i;
+
+		while (reply_len) {
+			len = sendmsg(entry->fd, &msghdr, 0);
+			if (len < 0) {
+				usfstl_vhost_user_dev_free(dev);
+				return;
+			}
+			USFSTL_ASSERT(len != 0);
+			reply_len -= len;
+
+			for (i = 0; len && i < msghdr.msg_iovlen; i++) {
+				unsigned int rm = len;
+
+				if (msg_iov[i].iov_len <= (size_t)len)
+					rm = msg_iov[i].iov_len;
+				len -= rm;
+				msg_iov[i].iov_len -= rm;
+				msg_iov[i].iov_base += rm;
+			}
+		}
+	}
+}
+
+static void usfstl_vhost_user_connected(int fd, void *data)
+{
+	struct usfstl_vhost_user_server *server = data;
+	struct usfstl_vhost_user_dev_int *dev;
+	unsigned int i;
+
+	dev = calloc(1, sizeof(*dev) +
+			sizeof(dev->virtqs[0]) * server->max_queues);
+
+	USFSTL_ASSERT(dev);
+
+	for (i = 0; i < server->max_queues; i++) {
+		dev->virtqs[i].call_fd = -1;
+		dev->virtqs[i].entry.fd = -1;
+		dev->virtqs[i].entry.data = dev;
+		dev->virtqs[i].entry.handler = usfstl_vhost_user_virtq_fdkick;
+	}
+
+	for (i = 0; i < MAX_REGIONS; i++)
+		dev->region_fds[i] = -1;
+	dev->req_fd = -1;
+
+	dev->ext.server = server;
+	dev->irq_job.data = dev;
+	dev->irq_job.name = "vhost-user-irq";
+	dev->irq_job.priority = 0x10000000;
+	dev->irq_job.callback = usfstl_vhost_user_job_callback;
+	usfstl_list_init(&dev->fds);
+
+	if (server->ops->connected)
+		server->ops->connected(&dev->ext);
+
+	dev->entry.fd = fd;
+	dev->entry.handler = usfstl_vhost_user_handle_msg;
+
+	usfstl_loop_register(&dev->entry);
+}
+
+void usfstl_vhost_user_server_start(struct usfstl_vhost_user_server *server)
+{
+	USFSTL_ASSERT(server->ops);
+	USFSTL_ASSERT(server->socket);
+
+	usfstl_uds_create(server->socket, usfstl_vhost_user_connected, server);
+}
+
+void usfstl_vhost_user_server_stop(struct usfstl_vhost_user_server *server)
+{
+	usfstl_uds_remove(server->socket);
+}
+
+void usfstl_vhost_user_dev_notify(struct usfstl_vhost_user_dev *extdev,
+				  unsigned int virtq_idx,
+				  const uint8_t *data, size_t datalen)
+{
+	struct usfstl_vhost_user_dev_int *dev;
+	/* preallocate on the stack for most cases */
+	struct iovec in_sg[SG_STACK_PREALLOC] = { };
+	struct iovec out_sg[SG_STACK_PREALLOC] = { };
+	struct usfstl_vhost_user_buf _buf = {
+		.in_sg = in_sg,
+		.n_in_sg = SG_STACK_PREALLOC,
+		.out_sg = out_sg,
+		.n_out_sg = SG_STACK_PREALLOC,
+	};
+	struct usfstl_vhost_user_buf *buf;
+
+	dev = container_of(extdev, struct usfstl_vhost_user_dev_int, ext);
+
+	USFSTL_ASSERT(virtq_idx <= dev->ext.server->max_queues);
+
+	if (!dev->virtqs[virtq_idx].enabled)
+		return;
+
+	buf = usfstl_vhost_user_get_virtq_buf(dev, virtq_idx, &_buf);
+	if (!buf)
+		return;
+
+	USFSTL_ASSERT(buf->n_in_sg && !buf->n_out_sg);
+	iov_fill(buf->in_sg, buf->n_in_sg, data, datalen);
+	buf->written = datalen;
+
+	usfstl_vhost_user_send_virtq_buf(dev, buf, virtq_idx);
+	usfstl_vhost_user_free_buf(buf);
+}
+
+void *usfstl_vhost_user_to_va(struct usfstl_vhost_user_dev *extdev, uint64_t addr)
+{
+	struct usfstl_vhost_user_dev_int *dev;
+	unsigned int region;
+
+	dev = container_of(extdev, struct usfstl_vhost_user_dev_int, ext);
+
+	for (region = 0; region < dev->n_regions; region++) {
+		if (addr >= dev->regions[region].user_addr &&
+		    addr < dev->regions[region].user_addr +
+			   dev->regions[region].size)
+			return (uint8_t *)dev->region_vaddr[region] +
+			       (addr -
+			        dev->regions[region].user_addr +
+			        dev->regions[region].mmap_offset);
+	}
+
+	USFSTL_ASSERT(0, "cannot translate address %"PRIx64"\n", addr);
+	return NULL;
+}
+
+size_t iov_len(struct iovec *sg, unsigned int nsg)
+{
+	size_t len = 0;
+	unsigned int i;
+
+	for (i = 0; i < nsg; i++)
+		len += sg[i].iov_len;
+
+	return len;
+}
+
+size_t iov_fill(struct iovec *sg, unsigned int nsg,
+		const void *_buf, size_t buflen)
+{
+	const char *buf = _buf;
+	unsigned int i;
+	size_t copied = 0;
+
+#define min(a, b) ({ typeof(a) _a = (a); typeof(b) _b = (b); _a < _b ? _a : _b; })
+	for (i = 0; buflen && i < nsg; i++) {
+		size_t cpy = min(buflen, sg[i].iov_len);
+
+		memcpy(sg[i].iov_base, buf, cpy);
+		buflen -= cpy;
+		copied += cpy;
+		buf += cpy;
+	}
+
+	return copied;
+}
+
+size_t iov_read(void *_buf, size_t buflen,
+		struct iovec *sg, unsigned int nsg)
+{
+	char *buf = _buf;
+	unsigned int i;
+	size_t copied = 0;
+
+#define min(a, b) ({ typeof(a) _a = (a); typeof(b) _b = (b); _a < _b ? _a : _b; })
+	for (i = 0; buflen && i < nsg; i++) {
+		size_t cpy = min(buflen, sg[i].iov_len);
+
+		memcpy(buf, sg[i].iov_base, cpy);
+		buflen -= cpy;
+		copied += cpy;
+		buf += cpy;
+	}
+
+	return copied;
+}
diff --git a/wmediumd/lib/wallclock.c b/wmediumd/lib/wallclock.c
new file mode 100644
index 000000000000..b4750621348a
--- /dev/null
+++ b/wmediumd/lib/wallclock.c
@@ -0,0 +1,138 @@
+/*
+ * Copyright (C) 2019 - 2020 Intel Corporation
+ *
+ * SPDX-License-Identifier: BSD-3-Clause
+ */
+#include <stddef.h>
+#include <stdint.h>
+#include <time.h>
+#include <sys/timerfd.h>
+#include <usfstl/sched.h>
+#include <usfstl/loop.h>
+
+void usfstl_sched_wallclock_handle_fd(struct usfstl_loop_entry *entry)
+{
+	struct usfstl_scheduler *sched;
+	uint64_t v;
+
+	sched = container_of(entry, struct usfstl_scheduler, wallclock.entry);
+
+	USFSTL_ASSERT_EQ((int)read(entry->fd, &v, sizeof(v)), (int)sizeof(v), "%d");
+	sched->wallclock.timer_triggered = 1;
+}
+
+static void usfstl_sched_wallclock_initialize(struct usfstl_scheduler *sched)
+{
+	struct timespec now = {};
+
+	USFSTL_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &now), 0, "%d");
+
+	sched->wallclock.start = (uint64_t)now.tv_sec * 1000000000 + now.tv_nsec;
+	sched->wallclock.initialized = 1;
+}
+
+void usfstl_sched_wallclock_request(struct usfstl_scheduler *sched, uint64_t time)
+{
+	struct itimerspec itimer = {};
+	unsigned int nsec_per_tick = sched->wallclock.nsec_per_tick;
+	uint64_t waketime;
+
+	USFSTL_ASSERT(nsec_per_tick != 0);
+
+	if (!sched->wallclock.initialized)
+		usfstl_sched_wallclock_initialize(sched);
+
+	waketime = sched->wallclock.start + nsec_per_tick * time;
+
+	itimer.it_value.tv_sec = waketime / 1000000000;
+	itimer.it_value.tv_nsec = waketime % 1000000000;
+
+	USFSTL_ASSERT_EQ(timerfd_settime(sched->wallclock.entry.fd,
+				       TFD_TIMER_ABSTIME, &itimer, NULL),
+		       0, "%d");
+}
+
+void usfstl_sched_wallclock_wait(struct usfstl_scheduler *sched)
+{
+	sched->wallclock.timer_triggered = 0;
+
+	while (!sched->wallclock.timer_triggered)
+		usfstl_loop_wait_and_handle();
+
+	usfstl_sched_set_time(sched, sched->prev_external_sync);
+}
+
+void usfstl_sched_wallclock_init(struct usfstl_scheduler *sched,
+			       unsigned int ns_per_tick)
+{
+	USFSTL_ASSERT(!sched->external_request && !sched->external_wait);
+
+	sched->external_request = usfstl_sched_wallclock_request;
+	sched->external_wait = usfstl_sched_wallclock_wait;
+
+	sched->wallclock.entry.fd = timerfd_create(CLOCK_MONOTONIC, 0);
+	USFSTL_ASSERT(sched->wallclock.entry.fd >= 0);
+
+	sched->wallclock.entry.handler = usfstl_sched_wallclock_handle_fd;
+
+	sched->wallclock.nsec_per_tick = ns_per_tick;
+
+	usfstl_loop_register(&sched->wallclock.entry);
+}
+
+void usfstl_sched_wallclock_exit(struct usfstl_scheduler *sched)
+{
+	USFSTL_ASSERT(sched->external_request == usfstl_sched_wallclock_request &&
+		    sched->external_wait == usfstl_sched_wallclock_wait);
+
+	sched->external_request = NULL;
+	sched->external_wait = NULL;
+
+	usfstl_loop_unregister(&sched->wallclock.entry);
+	close(sched->wallclock.entry.fd);
+}
+
+static void _usfstl_sched_wallclock_sync_real(struct usfstl_scheduler *sched)
+{
+	struct timespec now = {};
+	uint64_t nowns;
+
+	USFSTL_ASSERT_EQ(clock_gettime(CLOCK_MONOTONIC, &now), 0, "%d");
+
+	nowns = (uint64_t)now.tv_sec * 1000000000 + now.tv_nsec;
+	nowns -= sched->wallclock.start;
+	usfstl_sched_set_time(sched, nowns / sched->wallclock.nsec_per_tick);
+}
+
+static void usfstl_sched_wallclock_sync_real(void *data)
+{
+	_usfstl_sched_wallclock_sync_real(data);
+}
+
+void usfstl_sched_wallclock_wait_and_handle(struct usfstl_scheduler *sched)
+{
+	void (*old_fn)(void *);
+	void *old_data;
+
+	if (usfstl_sched_next_pending(sched, NULL))
+		return;
+
+	if (!sched->wallclock.initialized) {
+		/*
+		 * At least once at the beginning we should schedule
+		 * and initialize from an initial request, not here.
+		 */
+		usfstl_loop_wait_and_handle();
+		return;
+	}
+
+	old_fn = g_usfstl_loop_pre_handler_fn;
+	old_data = g_usfstl_loop_pre_handler_fn_data;
+	g_usfstl_loop_pre_handler_fn = usfstl_sched_wallclock_sync_real;
+	g_usfstl_loop_pre_handler_fn_data = sched;
+
+	usfstl_loop_wait_and_handle();
+
+	g_usfstl_loop_pre_handler_fn = old_fn;
+	g_usfstl_loop_pre_handler_fn_data = old_data;
+}
diff --git a/wmediumd/wmediumd.c b/wmediumd/wmediumd.c
index 0dd07429a99a..70979fca09d4 100644
--- a/wmediumd/wmediumd.c
+++ b/wmediumd/wmediumd.c
@@ -1,6 +1,7 @@
 /*
  *	wmediumd, wireless medium simulator for mac80211_hwsim kernel module
  *	Copyright (c) 2011 cozybit Inc.
+ *	Copyright (C) 2020 Intel Corporation
  *
  *	Author:	Javier Lopez	<jlopex@cozybit.com>
  *		Javier Cardona	<javier@cozybit.com>
@@ -28,17 +29,24 @@
 #include <stdint.h>
 #include <getopt.h>
 #include <signal.h>
-#include <event.h>
 #include <math.h>
 #include <sys/timerfd.h>
 #include <errno.h>
 #include <limits.h>
 #include <unistd.h>
+#include <stdarg.h>
+#include <usfstl/loop.h>
+#include <usfstl/sched.h>
+#include <usfstl/schedctrl.h>
 
 #include "wmediumd.h"
 #include "ieee80211.h"
 #include "config.h"
 
+USFSTL_SCHEDULER(scheduler);
+
+static void wmediumd_deliver_frame(struct usfstl_job *job);
+
 static inline int div_round(int a, int b)
 {
 	return (a + b - 1) / b;
@@ -85,73 +93,6 @@ void station_init_queues(struct station *station)
 	wqueue_init(&station->queues[IEEE80211_AC_VO], 3, 7);
 }
 
-bool timespec_before(struct timespec *t1, struct timespec *t2)
-{
-	return t1->tv_sec < t2->tv_sec ||
-	       (t1->tv_sec == t2->tv_sec && t1->tv_nsec < t2->tv_nsec);
-}
-
-void timespec_add_usec(struct timespec *t, int usec)
-{
-	t->tv_nsec += usec * 1000;
-	if (t->tv_nsec >= 1000000000) {
-		t->tv_sec++;
-		t->tv_nsec -= 1000000000;
-	}
-}
-
-// a - b = c
-static int timespec_sub(struct timespec *a, struct timespec *b,
-			struct timespec *c)
-{
-	c->tv_sec = a->tv_sec - b->tv_sec;
-
-	if (a->tv_nsec < b->tv_nsec) {
-		c->tv_sec--;
-		c->tv_nsec = 1000000000 + a->tv_nsec - b->tv_nsec;
-	} else {
-		c->tv_nsec = a->tv_nsec - b->tv_nsec;
-	}
-
-	return 0;
-}
-
-void rearm_timer(struct wmediumd *ctx)
-{
-	struct timespec min_expires;
-	struct itimerspec expires;
-	struct station *station;
-	struct frame *frame;
-	int i;
-
-	bool set_min_expires = false;
-
-	/*
-	 * Iterate over all the interfaces to find the next frame that
-	 * will be delivered, and set the timerfd accordingly.
-	 */
-	list_for_each_entry(station, &ctx->stations, list) {
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			frame = list_first_entry_or_null(&station->queues[i].frames,
-							 struct frame, list);
-
-			if (frame && (!set_min_expires ||
-				      timespec_before(&frame->expires,
-						      &min_expires))) {
-				set_min_expires = true;
-				min_expires = frame->expires;
-			}
-		}
-	}
-
-	if (set_min_expires) {
-		memset(&expires, 0, sizeof(expires));
-		expires.it_value = min_expires;
-		timerfd_settime(ctx->timerfd, TFD_TIMER_ABSTIME, &expires,
-				NULL);
-	}
-}
-
 static inline bool frame_has_a4(struct frame *frame)
 {
 	struct ieee80211_hdr *hdr = (void *)frame->data;
@@ -293,7 +234,7 @@ void queue_frame(struct wmediumd *ctx, struct station *station,
 {
 	struct ieee80211_hdr *hdr = (void *)frame->data;
 	u8 *dest = hdr->addr1;
-	struct timespec now, target;
+	uint64_t target;
 	struct wqueue *queue;
 	struct frame *tail;
 	struct station *tmpsta, *deststa;
@@ -313,8 +254,6 @@ void queue_frame(struct wmediumd *ctx, struct station *station,
 
 	int retries = 0;
 
-	clock_gettime(CLOCK_MONOTONIC, &now);
-
 	int ack_time_usec = pkt_duration(14, index_to_rate(0, frame->freq)) +
 	                    sifs;
 
@@ -409,22 +348,25 @@ void queue_frame(struct wmediumd *ctx, struct station *station,
 	 * delivery time starts after any equal or higher prio frame
 	 * (or now, if none).
 	 */
-	target = now;
+	target = scheduler.current_time;
 	for (i = 0; i <= ac; i++) {
 		list_for_each_entry(tmpsta, &ctx->stations, list) {
 			tail = list_last_entry_or_null(&tmpsta->queues[i].frames,
 						       struct frame, list);
-			if (tail && timespec_before(&target, &tail->expires))
-				target = tail->expires;
+			if (tail && target < tail->job.start)
+				target = tail->job.start;
 		}
 	}
 
-	timespec_add_usec(&target, send_time);
+	target += send_time;
 
 	frame->duration = send_time;
-	frame->expires = target;
+	frame->job.start = target;
+	frame->job.callback = wmediumd_deliver_frame;
+	frame->job.data = ctx;
+	frame->job.name = "frame";
+	usfstl_sched_add_job(&scheduler, &frame->job);
 	list_add_tail(&frame->list, &queue->frames);
-	rearm_timer(ctx);
 }
 
 /*
@@ -528,13 +470,17 @@ out:
 	return ret;
 }
 
-void deliver_frame(struct wmediumd *ctx, struct frame *frame)
+void wmediumd_deliver_frame(struct usfstl_job *job)
 {
+	struct wmediumd *ctx = job->data;
+	struct frame *frame = container_of(job, struct frame, job);
 	struct ieee80211_hdr *hdr = (void *) frame->data;
 	struct station *station;
 	u8 *dest = hdr->addr1;
 	u8 *src = frame->sender->addr;
 
+	list_del(&frame->list);
+
 	if (frame->flags & HWSIM_TX_STAT_ACK) {
 		/* rx the frame on the dest interface */
 		list_for_each_entry(station, &ctx->stations, list) {
@@ -605,57 +551,11 @@ void deliver_frame(struct wmediumd *ctx, struct frame *frame)
 	free(frame);
 }
 
-void deliver_expired_frames_queue(struct wmediumd *ctx,
-				  struct list_head *queue,
-				  struct timespec *now)
-{
-	struct frame *frame, *tmp;
-
-	list_for_each_entry_safe(frame, tmp, queue, list) {
-		if (timespec_before(&frame->expires, now)) {
-			list_del(&frame->list);
-			deliver_frame(ctx, frame);
-		} else {
-			break;
-		}
-	}
-}
-
-void deliver_expired_frames(struct wmediumd *ctx)
+void wmediumd_intf_update(struct usfstl_job *job)
 {
-	struct timespec now, _diff;
-	struct station *station;
-	struct list_head *l;
-	int i, j, duration;
-
-	clock_gettime(CLOCK_MONOTONIC, &now);
-	list_for_each_entry(station, &ctx->stations, list) {
-		int q_ct[IEEE80211_NUM_ACS] = {};
-		for (i = 0; i < IEEE80211_NUM_ACS; i++) {
-			list_for_each(l, &station->queues[i].frames) {
-				q_ct[i]++;
-			}
-		}
-		w_logf(ctx, LOG_DEBUG, "[" TIME_FMT "] Station " MAC_FMT
-					   " BK %d BE %d VI %d VO %d\n",
-			   TIME_ARGS(&now), MAC_ARGS(station->addr),
-			   q_ct[IEEE80211_AC_BK], q_ct[IEEE80211_AC_BE],
-			   q_ct[IEEE80211_AC_VI], q_ct[IEEE80211_AC_VO]);
-
-		for (i = 0; i < IEEE80211_NUM_ACS; i++)
-			deliver_expired_frames_queue(ctx, &station->queues[i].frames, &now);
-	}
-	w_logf(ctx, LOG_DEBUG, "\n\n");
-
-	if (!ctx->intf)
-		return;
-
-	timespec_sub(&now, &ctx->intf_updated, &_diff);
-	duration = (_diff.tv_sec * 1000000) + (_diff.tv_nsec / 1000);
-	if (duration < 10000) // calc per 10 msec
-		return;
+	struct wmediumd *ctx = job->data;
+	int i, j;
 
-	// update interference
 	for (i = 0; i < ctx->num_stas; i++)
 		for (j = 0; j < ctx->num_stas; j++) {
 			if (i == j)
@@ -663,11 +563,12 @@ void deliver_expired_frames(struct wmediumd *ctx)
 			// probability is used for next calc
 			ctx->intf[i * ctx->num_stas + j].prob_col =
 				ctx->intf[i * ctx->num_stas + j].duration /
-				(double)duration;
+				(double)10000;
 			ctx->intf[i * ctx->num_stas + j].duration = 0;
 		}
 
-	clock_gettime(CLOCK_MONOTONIC, &ctx->intf_updated);
+	job->start += 10000;
+	usfstl_sched_add_job(&scheduler, job);
 }
 
 static
@@ -735,7 +636,7 @@ static int process_messages_cb(struct nl_msg *msg, void *arg)
 			}
 			memcpy(sender->hwaddr, hwaddr, ETH_ALEN);
 
-			frame = malloc(sizeof(*frame) + data_len);
+			frame = calloc(1, sizeof(*frame) + data_len);
 			if (!frame)
 				goto out;
 
@@ -792,9 +693,9 @@ out:
 	return ret;
 }
 
-static void sock_event_cb(int fd, short what, void *data)
+static void sock_event_cb(struct usfstl_loop_entry *entry)
 {
-	struct wmediumd *ctx = data;
+	struct wmediumd *ctx = entry->data;
 
 	nl_recvmsgs_default(ctx->sock);
 }
@@ -858,30 +759,19 @@ void print_help(int exval)
 	printf("                  == 7: all packets will be logged\n");
 	printf("  -c FILE         set input config file\n");
 	printf("  -x FILE         set input PER file\n");
+	printf("  -t socket       set the time control socket\n");
 
 	exit(exval);
 }
 
-static void timer_cb(int fd, short what, void *data)
-{
-	struct wmediumd *ctx = data;
-	uint64_t u;
-
-	read(fd, &u, sizeof(u));
-
-	ctx->move_stations(ctx);
-	deliver_expired_frames(ctx);
-	rearm_timer(ctx);
-}
-
 int main(int argc, char *argv[])
 {
 	int opt;
-	struct event ev_cmd;
-	struct event ev_timer;
-	struct wmediumd ctx;
+	struct wmediumd ctx = {};
 	char *config_file = NULL;
 	char *per_file = NULL;
+	const char *time_socket = NULL;
+	struct usfstl_sched_ctrl ctrl = {};
 
 	setvbuf(stdout, NULL, _IOLBF, BUFSIZ);
 
@@ -894,7 +784,7 @@ int main(int argc, char *argv[])
 	unsigned long int parse_log_lvl;
 	char* parse_end_token;
 
-	while ((opt = getopt(argc, argv, "hVc:l:x:")) != -1) {
+	while ((opt = getopt(argc, argv, "hVc:l:x:t:")) != -1) {
 		switch (opt) {
 		case 'h':
 			print_help(EXIT_SUCCESS);
@@ -926,6 +816,9 @@ int main(int argc, char *argv[])
 			}
 			ctx.log_lvl = parse_log_lvl;
 			break;
+		case 't':
+			time_socket = optarg;
+			break;
 		case '?':
 			printf("wmediumd: Error - No such option: "
 			       "`%c'\n\n", optopt);
@@ -949,32 +842,46 @@ int main(int argc, char *argv[])
 	if (load_config(&ctx, config_file, per_file))
 		return EXIT_FAILURE;
 
-	/* init libevent */
-	event_init();
-
 	/* init netlink */
 	if (init_netlink(&ctx) < 0)
 		return EXIT_FAILURE;
 
-	event_set(&ev_cmd, nl_socket_get_fd(ctx.sock), EV_READ | EV_PERSIST,
-		  sock_event_cb, &ctx);
-	event_add(&ev_cmd, NULL);
+	if (ctx.intf) {
+		ctx.intf_job.start = 10000; // usec
+		ctx.intf_job.name = "interference update";
+		ctx.intf_job.data = &ctx;
+		ctx.intf_job.callback = wmediumd_intf_update;
+		usfstl_sched_add_job(&scheduler, &ctx.intf_job);
+	}
+
+	if (time_socket)
+		usfstl_sched_ctrl_start(&ctrl, time_socket,
+					1000 /* nsec per usec */,
+					(uint64_t)-1 /* no ID */,
+					&scheduler);
+	else
+		usfstl_sched_wallclock_init(&scheduler, 1000);
 
-	/* setup timers */
-	ctx.timerfd = timerfd_create(CLOCK_MONOTONIC, 0);
-	clock_gettime(CLOCK_MONOTONIC, &ctx.intf_updated);
-	clock_gettime(CLOCK_MONOTONIC, &ctx.next_move);
-	ctx.next_move.tv_sec += MOVE_INTERVAL;
-	event_set(&ev_timer, ctx.timerfd, EV_READ | EV_PERSIST, timer_cb, &ctx);
-	event_add(&ev_timer, NULL);
+	ctx.nl_loop.handler = sock_event_cb;
+	ctx.nl_loop.data = &ctx;
+	ctx.nl_loop.fd = nl_socket_get_fd(ctx.sock);
+	usfstl_loop_register(&ctx.nl_loop);
 
 	/* register for new frames */
 	if (send_register_msg(&ctx) == 0) {
 		w_logf(&ctx, LOG_NOTICE, "REGISTER SENT!\n");
 	}
 
-	/* enter libevent main loop */
-	event_dispatch();
+	while (1) {
+		if (time_socket) {
+			usfstl_sched_next(&scheduler);
+		} else {
+			usfstl_sched_wallclock_wait_and_handle(&scheduler);
+
+			if (usfstl_sched_next_pending(&scheduler, NULL))
+				usfstl_sched_next(&scheduler);
+		}
+	}
 
 	free(ctx.sock);
 	free(ctx.cb);
diff --git a/wmediumd/wmediumd.h b/wmediumd/wmediumd.h
index a1a315c096cf..077c17163afc 100644
--- a/wmediumd/wmediumd.h
+++ b/wmediumd/wmediumd.h
@@ -1,6 +1,7 @@
 /*
  *	wmediumd, wireless medium simulator for mac80211_hwsim kernel module
  *	Copyright (c) 2011 cozybit Inc.
+ *	Copyright (C) 2020 Intel Corporation
  *
  *	Author:	Javier Lopez	<jlopex@cozybit.com>
  *		Javier Cardona	<javier@cozybit.com>
@@ -104,6 +105,7 @@ enum {
 #include <stdint.h>
 #include <stdbool.h>
 #include <syslog.h>
+#include <usfstl/sched.h>
 
 #include "list.h"
 #include "ieee80211.h"
@@ -125,6 +127,8 @@ typedef uint64_t u64;
 #define NOISE_LEVEL	(-91)
 #define CCA_THRESHOLD	(-90)
 
+extern struct usfstl_scheduler scheduler;
+
 struct wqueue {
 	struct list_head frames;
 	int cw_min;
@@ -146,6 +150,7 @@ struct wmediumd {
 	int timerfd;
 
 	struct nl_sock *sock;
+	struct usfstl_loop_entry nl_loop;
 
 	int num_stas;
 	struct list_head stations;
@@ -153,9 +158,8 @@ struct wmediumd {
 	int *snr_matrix;
 	double *error_prob_matrix;
 	struct intf_info *intf;
-	struct timespec intf_updated;
+	struct usfstl_job intf_job, move_job;
 #define MOVE_INTERVAL	(3) /* station movement interval [sec] */
-	struct timespec next_move;
 	void *path_loss_param;
 	float *per_matrix;
 	int per_matrix_row_num;
@@ -171,7 +175,6 @@ struct wmediumd {
 				 int, struct station *, struct station *);
 	int (*calc_path_loss)(void *, struct station *,
 			      struct station *);
-	void (*move_stations)(struct wmediumd *);
 	int (*get_fading_signal)(struct wmediumd *);
 
 	u8 log_lvl;
@@ -184,7 +187,7 @@ struct hwsim_tx_rate {
 
 struct frame {
 	struct list_head list;		/* frame queue list */
-	struct timespec expires;	/* frame delivery (absolute) */
+	struct usfstl_job job;
 	bool acked;
 	u64 cookie;
 	u32 freq;
@@ -217,7 +220,6 @@ struct intf_info {
 void station_init_queues(struct station *station);
 double get_error_prob_from_snr(double snr, unsigned int rate_idx, u32 freq,
 			       int frame_len);
-bool timespec_before(struct timespec *t1, struct timespec *t2);
 int set_default_per(struct wmediumd *ctx);
 int read_per_file(struct wmediumd *ctx, const char *file_name);
 int w_logf(struct wmediumd *ctx, u8 level, const char *format, ...);
-- 
2.24.1

