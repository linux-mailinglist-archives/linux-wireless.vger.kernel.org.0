Return-Path: <linux-wireless+bounces-29947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAD80CD0F41
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 24868306EF14
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F61134B18E;
	Fri, 19 Dec 2025 15:46:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gO6eBRqo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864B634AAF2
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159197; cv=none; b=W39pGMjrc7pSTVuntQ636y6JVy10lufVNzLclqYqHVvBjcihv0PWaEyVd1oQJ/b2MmxuzYM7f5maF7w9N9OKagAr1JWRGHT6tOtICAGCmjdcR7pMwshD75x2kYm3NdZiEC5wgv6hqDPz3u0g86XJFieWREV2wLD21mzVQfIWs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159197; c=relaxed/simple;
	bh=vKoqr2RYzTDHLLYtIp6JkWt3yQo+z8EUmJ1VlwwcZhM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=IoxrB/gie0sDJ7S2+MspSwk4a8RYnLfk4teUbBhvY9pFXefO8SyO+jlSxr/3Tr10MtqAiKS3VX+hqrPdDDhDMbZrUBEQYyymfzHQ6rUTmK0c8YXdal2dzD78sBVBavjsHueK6456MZgH+vixUEQTtO6HQ9sNZXTun91g7dxwhLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=gO6eBRqo; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477a11d9e67so9458685e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159193; x=1766763993; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=91/M6Wc5goo40nrJkJ1ulkL+/DliPVncC/51mYdmaQ4=;
        b=gO6eBRqonKFaODH9SECpcFKvWbBc2f7QoDdwhscPbHhltM7d0pzOp/9jev/yirXRy7
         JhbjLwijEq92Fm3YoO4gDCOjIXnaxR7GDRpiMbfKS0ZkjpyBAKUuoNQt+t5Yqaf9sv1e
         Nx+KQCie0OVobYqckJkpaOXBqV3YZnNO5RFggY1DFghLZ5ugpuGDmXYqeKlHUYU0C9zN
         GQsqlSjTCY4VVU37aaM/zSkBuVoa5K3CQHjGlcp75TrBxd1lYbqLSwNbrhkKnaJ1pWk8
         buQXJSO4pq6SOufHgFUy3E7OhTtolTzIMnoKHjQXlOPqdqVh1BMIXB1GGspUKrRjrMaD
         WQFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159193; x=1766763993;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91/M6Wc5goo40nrJkJ1ulkL+/DliPVncC/51mYdmaQ4=;
        b=DDiQH8KAOGiUPF0DUKZB5dLcARZN8CP9ONzLotFfEMDbOKBAAa83rp74eTdzf/BZ7a
         VCSlOPEGeNIRYD4YPy9eHpUBriIi2NH9wNxOULudQQ4MXlGcqccS16qruL49d8bUNYZM
         NCMGdmqNoS90ZX3AbZf+69R5NCSysLHUpJpa4ncMU+2onJMS/bQvBwpbyRf5I5mxAjMf
         VKAdMYLOw5WYg3A6UGPLYdPWwbM+tPiQVtzFrPpQECcxt0NAwXhRZ5rHEJiztsWYTo7l
         9ENFO4DFQIyt3gB88aMrHdMK7hIITrfPxxg5P0AvVsNzkDNE6Wsxc1hyHFFayopabezi
         Vr5A==
X-Forwarded-Encrypted: i=1; AJvYcCWBQJoT/7CpQNyypWm747U+zAYs56HXb1D5H7uMvwT6ZRfFe4e4weEWVVU3I97YYF86Bdn2J/lkjMLuPNXS8w==@vger.kernel.org
X-Gm-Message-State: AOJu0YwsQ72jY6dozNXhiKJMXAqqQOyK0Gl97UJTRjXkWRTuVhFDkapP
	LLtXMyxPlWN78BW46QuJqkbJR0C2zA5ZpWRAK+HyFZCifSGJX1wgwlee3FGGY/zPZEqfpvMdMC+
	zPw==
X-Google-Smtp-Source: AGHT+IGE1LgxqdKnUpQTqh6OwtRuQIXkK6E2bbB3uOqTPKnnNib9O3sYIDs/w4CmKbE3kIU0DbcVhMnPBQ==
X-Received: from wmxb4-n2.prod.google.com ([2002:a05:600d:8444:20b0:477:5a4b:d57f])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1c28:b0:45d:dc85:c009
 with SMTP id 5b1f17b1804b1-47d1954586amr32388785e9.10.1766159192865; Fri, 19
 Dec 2025 07:46:32 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:06 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-18-elver@google.com>
Subject: [PATCH v5 17/36] locking/rwsem: Support Clang's context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add support for Clang's context analysis for rw_semaphore.

Signed-off-by: Marco Elver <elver@google.com>
---
v5:
* Rename "context guard" -> "context lock".
* Use new cleanup.h helpers to properly support scoped lock guards.

v4:
* Rename capability -> context analysis.

v3:
* Switch to DECLARE_LOCK_GUARD_1_ATTRS() (suggested by Peter)
* __assert -> __assume rename
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/rwsem.h                        | 76 +++++++++++++-------
 lib/test_context-analysis.c                  | 64 +++++++++++++++++
 3 files changed, 114 insertions(+), 28 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index f7736f1c0767..7b660c3003a0 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -80,7 +80,7 @@ Supported Kernel Primitives
 
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU, SRCU (`srcu_struct`).
+`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`.
 
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index f1aaf676a874..8da14a08a4e1 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -45,7 +45,7 @@
  * reduce the chance that they will share the same cacheline causing
  * cacheline bouncing problem.
  */
-struct rw_semaphore {
+context_lock_struct(rw_semaphore) {
 	atomic_long_t count;
 	/*
 	 * Write owner or one of the read owners as well flags regarding
@@ -76,11 +76,13 @@ static inline int rwsem_is_locked(struct rw_semaphore *sem)
 }
 
 static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
 }
 
 static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
 }
@@ -119,6 +121,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
+	__assume_ctx_lock(sem);					\
 } while (0)
 
 /*
@@ -148,7 +151,7 @@ extern bool is_rwsem_reader_owned(struct rw_semaphore *sem);
 
 #include <linux/rwbase_rt.h>
 
-struct rw_semaphore {
+context_lock_struct(rw_semaphore) {
 	struct rwbase_rt	rwbase;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
@@ -172,6 +175,7 @@ do {								\
 	static struct lock_class_key __key;			\
 								\
 	__init_rwsem((sem), #sem, &__key);			\
+	__assume_ctx_lock(sem);					\
 } while (0)
 
 static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
@@ -180,11 +184,13 @@ static __always_inline int rwsem_is_locked(const struct rw_semaphore *sem)
 }
 
 static __always_inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!rwsem_is_locked(sem));
 }
 
 static __always_inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	WARN_ON(!rw_base_is_write_locked(&sem->rwbase));
 }
@@ -202,6 +208,7 @@ static __always_inline int rwsem_is_contended(struct rw_semaphore *sem)
  */
 
 static inline void rwsem_assert_held(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	if (IS_ENABLED(CONFIG_LOCKDEP))
 		lockdep_assert_held(sem);
@@ -210,6 +217,7 @@ static inline void rwsem_assert_held(const struct rw_semaphore *sem)
 }
 
 static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
+	__assumes_ctx_lock(sem)
 {
 	if (IS_ENABLED(CONFIG_LOCKDEP))
 		lockdep_assert_held_write(sem);
@@ -220,48 +228,62 @@ static inline void rwsem_assert_held_write(const struct rw_semaphore *sem)
 /*
  * lock for reading
  */
-extern void down_read(struct rw_semaphore *sem);
-extern int __must_check down_read_interruptible(struct rw_semaphore *sem);
-extern int __must_check down_read_killable(struct rw_semaphore *sem);
+extern void down_read(struct rw_semaphore *sem) __acquires_shared(sem);
+extern int __must_check down_read_interruptible(struct rw_semaphore *sem) __cond_acquires_shared(0, sem);
+extern int __must_check down_read_killable(struct rw_semaphore *sem) __cond_acquires_shared(0, sem);
 
 /*
  * trylock for reading -- returns 1 if successful, 0 if contention
  */
-extern int down_read_trylock(struct rw_semaphore *sem);
+extern int down_read_trylock(struct rw_semaphore *sem) __cond_acquires_shared(true, sem);
 
 /*
  * lock for writing
  */
-extern void down_write(struct rw_semaphore *sem);
-extern int __must_check down_write_killable(struct rw_semaphore *sem);
+extern void down_write(struct rw_semaphore *sem) __acquires(sem);
+extern int __must_check down_write_killable(struct rw_semaphore *sem) __cond_acquires(0, sem);
 
 /*
  * trylock for writing -- returns 1 if successful, 0 if contention
  */
-extern int down_write_trylock(struct rw_semaphore *sem);
+extern int down_write_trylock(struct rw_semaphore *sem) __cond_acquires(true, sem);
 
 /*
  * release a read lock
  */
-extern void up_read(struct rw_semaphore *sem);
+extern void up_read(struct rw_semaphore *sem) __releases_shared(sem);
 
 /*
  * release a write lock
  */
-extern void up_write(struct rw_semaphore *sem);
-
-DEFINE_GUARD(rwsem_read, struct rw_semaphore *, down_read(_T), up_read(_T))
-DEFINE_GUARD_COND(rwsem_read, _try, down_read_trylock(_T))
-DEFINE_GUARD_COND(rwsem_read, _intr, down_read_interruptible(_T), _RET == 0)
-
-DEFINE_GUARD(rwsem_write, struct rw_semaphore *, down_write(_T), up_write(_T))
-DEFINE_GUARD_COND(rwsem_write, _try, down_write_trylock(_T))
-DEFINE_GUARD_COND(rwsem_write, _kill, down_write_killable(_T), _RET == 0)
+extern void up_write(struct rw_semaphore *sem) __releases(sem);
+
+DEFINE_LOCK_GUARD_1(rwsem_read, struct rw_semaphore, down_read(_T->lock), up_read(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_read, _try, down_read_trylock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_read, _intr, down_read_interruptible(_T->lock), _RET == 0)
+
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_try, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_intr, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read_intr, _T)
+
+DEFINE_LOCK_GUARD_1(rwsem_write, struct rw_semaphore, down_write(_T->lock), up_write(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_write, _try, down_write_trylock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(rwsem_write, _kill, down_write_killable(_T->lock), _RET == 0)
+
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_try, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_kill, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_kill_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write_kill, _T)
 
 /*
  * downgrade write lock to read lock
  */
-extern void downgrade_write(struct rw_semaphore *sem);
+extern void downgrade_write(struct rw_semaphore *sem) __releases(sem) __acquires_shared(sem);
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 /*
@@ -277,11 +299,11 @@ extern void downgrade_write(struct rw_semaphore *sem);
  * lockdep_set_class() at lock initialization time.
  * See Documentation/locking/lockdep-design.rst for more details.)
  */
-extern void down_read_nested(struct rw_semaphore *sem, int subclass);
-extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass);
-extern void down_write_nested(struct rw_semaphore *sem, int subclass);
-extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass);
-extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock);
+extern void down_read_nested(struct rw_semaphore *sem, int subclass) __acquires_shared(sem);
+extern int __must_check down_read_killable_nested(struct rw_semaphore *sem, int subclass) __cond_acquires_shared(0, sem);
+extern void down_write_nested(struct rw_semaphore *sem, int subclass) __acquires(sem);
+extern int down_write_killable_nested(struct rw_semaphore *sem, int subclass) __cond_acquires(0, sem);
+extern void _down_write_nest_lock(struct rw_semaphore *sem, struct lockdep_map *nest_lock) __acquires(sem);
 
 # define down_write_nest_lock(sem, nest_lock)			\
 do {								\
@@ -295,8 +317,8 @@ do {								\
  * [ This API should be avoided as much as possible - the
  *   proper abstraction for this case is completions. ]
  */
-extern void down_read_non_owner(struct rw_semaphore *sem);
-extern void up_read_non_owner(struct rw_semaphore *sem);
+extern void down_read_non_owner(struct rw_semaphore *sem) __acquires_shared(sem);
+extern void up_read_non_owner(struct rw_semaphore *sem) __releases_shared(sem);
 #else
 # define down_read_nested(sem, subclass)		down_read(sem)
 # define down_read_killable_nested(sem, subclass)	down_read_killable(sem)
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 39e03790c0f6..1c96c56cf873 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -8,6 +8,7 @@
 #include <linux/build_bug.h>
 #include <linux/mutex.h>
 #include <linux/rcupdate.h>
+#include <linux/rwsem.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
@@ -262,6 +263,69 @@ static void __used test_seqlock_scoped(struct test_seqlock_data *d)
 	}
 }
 
+struct test_rwsem_data {
+	struct rw_semaphore sem;
+	int counter __guarded_by(&sem);
+};
+
+static void __used test_rwsem_init(struct test_rwsem_data *d)
+{
+	init_rwsem(&d->sem);
+	d->counter = 0;
+}
+
+static void __used test_rwsem_reader(struct test_rwsem_data *d)
+{
+	down_read(&d->sem);
+	(void)d->counter;
+	up_read(&d->sem);
+
+	if (down_read_trylock(&d->sem)) {
+		(void)d->counter;
+		up_read(&d->sem);
+	}
+}
+
+static void __used test_rwsem_writer(struct test_rwsem_data *d)
+{
+	down_write(&d->sem);
+	d->counter++;
+	up_write(&d->sem);
+
+	down_write(&d->sem);
+	d->counter++;
+	downgrade_write(&d->sem);
+	(void)d->counter;
+	up_read(&d->sem);
+
+	if (down_write_trylock(&d->sem)) {
+		d->counter++;
+		up_write(&d->sem);
+	}
+}
+
+static void __used test_rwsem_assert(struct test_rwsem_data *d)
+{
+	rwsem_assert_held_nolockdep(&d->sem);
+	d->counter++;
+}
+
+static void __used test_rwsem_guard(struct test_rwsem_data *d)
+{
+	{ guard(rwsem_read)(&d->sem); (void)d->counter; }
+	{ guard(rwsem_write)(&d->sem); d->counter++; }
+}
+
+static void __used test_rwsem_cond_guard(struct test_rwsem_data *d)
+{
+	scoped_cond_guard(rwsem_read_try, return, &d->sem) {
+		(void)d->counter;
+	}
+	scoped_cond_guard(rwsem_write_try, return, &d->sem) {
+		d->counter++;
+	}
+}
+
 struct test_bit_spinlock_data {
 	unsigned long bits;
 	int counter __guarded_by(__bitlock(3, &bits));
-- 
2.52.0.322.g1dd061c0dc-goog


