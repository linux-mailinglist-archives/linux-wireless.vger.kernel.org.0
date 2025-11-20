Return-Path: <linux-wireless+bounces-29194-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D59EDC74E59
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 25DEB4EAAEF
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 968F4359702;
	Thu, 20 Nov 2025 15:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0dO1Ccd0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 401DF3624B7
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651615; cv=none; b=ga6TsUxCwnT/VDfTVTX45goZiRfKeOf8e5Gy+uOFaQZkaSJ2rAvFvP6w/enb/ZK08gRGWQplNhKX3p39xHB6t9yiDltJYxVvQtoGVw9v7MSif6wpySXb7OkZey5pi05KJeHINyCyBeBF/D+mshrpVUakx0nkceiP3urxzyN51kA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651615; c=relaxed/simple;
	bh=ns3DYUnt32Y6bCDTYyQa3OW5L2DdvIEspeWXpXn2KHo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L+l2bV8WiUGqGXyxElo7I5nZBYS+e3jTkW32h44qqfp+wtwUh8AZNr7d2jQYts3hb9utwD1wmX/rtyA/Bsqh2ts+qAbJZ0bgYV6c4q/u8227lF8pGp1rGjWTInFcUuGPqUEIdd5ENlTyN8xvCCQp0uJq25IXD1ZwxsepHFV/Adk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0dO1Ccd0; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477939321e6so5994515e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:13:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651589; x=1764256389; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dkmPbZNSmdMyreEK/bsAoZcLQrwuNTqttZsMG2m8BsQ=;
        b=0dO1Ccd0uJ/ZJS2hfhlQvOCsbdQC2SmcFpXJFWP4I+2Umsdcm8eu+gMjwryEsoO0h8
         DuOHypvAJzqW+Fin5GVnirvXARBKffpayBYbTRVcwVB1gZbX7nJopk8IKeG+vcbx7gxP
         VYdNa/xSGmw9pA/V+2g9BuhDaxM+p+fkwzwigluPZZzwbiUxBgekbXbu7pwo4mKWe6kT
         C5aKr1InLyaev3wu2cVQvfvElUAqzotnAwkog89cTOaWnVUbqcGo6rvxh+0uQNC9EEjm
         epUdA1SjOf93NAk+EQ4ux0Vt7RXwhwUzkyCZBj/KUS1zDnqTVV+bibAneLdz3UNGMp8m
         WdPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651589; x=1764256389;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dkmPbZNSmdMyreEK/bsAoZcLQrwuNTqttZsMG2m8BsQ=;
        b=v7+tLsyEtlbAmvQJ1Xo8kKO11IxIGeJwxX0aQBU4yZJmqCdri7sVuPPvilBMmgkvln
         mwk1Q5AqwkqXRht8XSXiatlrkbvto+FPaYuexOZ6vlpME4Qe5/FN3TF36RXrGp6OSozK
         jPhap29C0FghfxDFOormMXHPi1NvfqfZn4KE/FTVGCV924b9NWgQqzpTYKC6yELUtBpU
         fsOeUJrrNXqncqaldflyJAC7Bu+Yt+RzsTTtMaxZmyU3I48LdLuyvG1ZxmWvWbfXTpet
         7ubP/25jYSj5yOrRyOWW/qFaRUJ7oTMD9zaz6j9WBcvko/slwTFDqcchYi2JhJLxmGTz
         NIDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZEqhzLKdQH5zw19CyR76XFdDZ6pg0GOpoDNDgWAccpbl9roYIF/oNmfGyV289tAW/x5mfoHXKtrTxqoDa0A==@vger.kernel.org
X-Gm-Message-State: AOJu0YyBaxLE14Sdol8DngtnlzMJKH791CA/K0judUmK3OM1faYc+ATz
	RrarKTRvbxvmyYJFzUZrhiy/SZEhGonGea3Jp2W80njyV2DdS0PFEWonQtN2vwgwCUexwml4bV0
	N4A==
X-Google-Smtp-Source: AGHT+IGjVSl0FdI0t6xZXRZ+yy/GRkabtVizenWIxxXTwOEj/5OduqGLfCIaX9FytZisvT/Qka2tQFBDyw==
X-Received: from wmbbd8.prod.google.com ([2002:a05:600c:1f08:b0:470:fd92:351d])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1987:b0:45d:d97c:236c
 with SMTP id 5b1f17b1804b1-477b8a8a5damr33381975e9.21.1763651588400; Thu, 20
 Nov 2025 07:13:08 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:45 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-21-elver@google.com>
Subject: [PATCH v4 20/35] locking/ww_mutex: Support Clang's context analysis
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

Add support for Clang's context analysis for ww_mutex.

The programming model for ww_mutex is subtly more complex than other
locking primitives when using ww_acquire_ctx. Encoding the respective
pre-conditions for ww_mutex lock/unlock based on ww_acquire_ctx state
using Clang's context analysis makes incorrect use of the API harder.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v3:
* __assert -> __assume rename

v2:
* New patch.
---
 Documentation/dev-tools/context-analysis.rst |  3 +-
 include/linux/ww_mutex.h                     | 22 +++++--
 lib/test_context-analysis.c                  | 69 ++++++++++++++++++++
 3 files changed, 87 insertions(+), 7 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index 8737de63a707..2936666651f3 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -81,7 +81,8 @@ Supported Kernel Primitives
 
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`.
+`bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`, `local_lock_t`,
+`ww_mutex`.
 
 For context guards with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/ww_mutex.h b/include/linux/ww_mutex.h
index 45ff6f7a872b..f6253e8ba9af 100644
--- a/include/linux/ww_mutex.h
+++ b/include/linux/ww_mutex.h
@@ -44,7 +44,7 @@ struct ww_class {
 	unsigned int is_wait_die;
 };
 
-struct ww_mutex {
+context_guard_struct(ww_mutex) {
 	struct WW_MUTEX_BASE base;
 	struct ww_acquire_ctx *ctx;
 #ifdef DEBUG_WW_MUTEXES
@@ -52,7 +52,7 @@ struct ww_mutex {
 #endif
 };
 
-struct ww_acquire_ctx {
+context_guard_struct(ww_acquire_ctx) {
 	struct task_struct *task;
 	unsigned long stamp;
 	unsigned int acquired;
@@ -107,6 +107,7 @@ struct ww_acquire_ctx {
  */
 static inline void ww_mutex_init(struct ww_mutex *lock,
 				 struct ww_class *ww_class)
+	__assumes_ctx_guard(lock)
 {
 	ww_mutex_base_init(&lock->base, ww_class->mutex_name, &ww_class->mutex_key);
 	lock->ctx = NULL;
@@ -141,6 +142,7 @@ static inline void ww_mutex_init(struct ww_mutex *lock,
  */
 static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
 				   struct ww_class *ww_class)
+	__acquires(ctx) __no_context_analysis
 {
 	ctx->task = current;
 	ctx->stamp = atomic_long_inc_return_relaxed(&ww_class->stamp);
@@ -179,6 +181,7 @@ static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
  * data structures.
  */
 static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
+	__releases(ctx) __acquires_shared(ctx) __no_context_analysis
 {
 #ifdef DEBUG_WW_MUTEXES
 	lockdep_assert_held(ctx);
@@ -196,6 +199,7 @@ static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
  * mutexes have been released with ww_mutex_unlock.
  */
 static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
+	__releases_shared(ctx) __no_context_analysis
 {
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	mutex_release(&ctx->first_lock_dep_map, _THIS_IP_);
@@ -245,7 +249,8 @@ static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
  *
  * A mutex acquired with this function must be released with ww_mutex_unlock.
  */
-extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx);
+extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx);
 
 /**
  * ww_mutex_lock_interruptible - acquire the w/w mutex, interruptible
@@ -278,7 +283,8 @@ extern int /* __must_check */ ww_mutex_lock(struct ww_mutex *lock, struct ww_acq
  * A mutex acquired with this function must be released with ww_mutex_unlock.
  */
 extern int __must_check ww_mutex_lock_interruptible(struct ww_mutex *lock,
-						    struct ww_acquire_ctx *ctx);
+						    struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx);
 
 /**
  * ww_mutex_lock_slow - slowpath acquiring of the w/w mutex
@@ -305,6 +311,7 @@ extern int __must_check ww_mutex_lock_interruptible(struct ww_mutex *lock,
  */
 static inline void
 ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
+	__acquires(lock) __must_hold(ctx) __no_context_analysis
 {
 	int ret;
 #ifdef DEBUG_WW_MUTEXES
@@ -342,6 +349,7 @@ ww_mutex_lock_slow(struct ww_mutex *lock, struct ww_acquire_ctx *ctx)
 static inline int __must_check
 ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 				 struct ww_acquire_ctx *ctx)
+	__cond_acquires(0, lock) __must_hold(ctx)
 {
 #ifdef DEBUG_WW_MUTEXES
 	DEBUG_LOCKS_WARN_ON(!ctx->contending_lock);
@@ -349,10 +357,11 @@ ww_mutex_lock_slow_interruptible(struct ww_mutex *lock,
 	return ww_mutex_lock_interruptible(lock, ctx);
 }
 
-extern void ww_mutex_unlock(struct ww_mutex *lock);
+extern void ww_mutex_unlock(struct ww_mutex *lock) __releases(lock);
 
 extern int __must_check ww_mutex_trylock(struct ww_mutex *lock,
-					 struct ww_acquire_ctx *ctx);
+					 struct ww_acquire_ctx *ctx)
+	__cond_acquires(true, lock) __must_hold(ctx);
 
 /***
  * ww_mutex_destroy - mark a w/w mutex unusable
@@ -363,6 +372,7 @@ extern int __must_check ww_mutex_trylock(struct ww_mutex *lock,
  * this function is called.
  */
 static inline void ww_mutex_destroy(struct ww_mutex *lock)
+	__must_not_hold(lock)
 {
 #ifndef CONFIG_PREEMPT_RT
 	mutex_destroy(&lock->base);
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 74eca21f7aaa..522769c9586d 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -14,6 +14,7 @@
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
 #include <linux/srcu.h>
+#include <linux/ww_mutex.h>
 
 /*
  * Test that helper macros work as expected.
@@ -523,3 +524,71 @@ static void __used test_local_trylock(void)
 		local_unlock(&test_local_trylock_data.lock);
 	}
 }
+
+static DEFINE_WD_CLASS(ww_class);
+
+struct test_ww_mutex_data {
+	struct ww_mutex mtx;
+	int counter __guarded_by(&mtx);
+};
+
+static void __used test_ww_mutex_init(struct test_ww_mutex_data *d)
+{
+	ww_mutex_init(&d->mtx, &ww_class);
+	d->counter = 0;
+}
+
+static void __used test_ww_mutex_lock_noctx(struct test_ww_mutex_data *d)
+{
+	if (!ww_mutex_lock(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (!ww_mutex_lock_interruptible(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (ww_mutex_trylock(&d->mtx, NULL)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	ww_mutex_lock_slow(&d->mtx, NULL);
+	d->counter++;
+	ww_mutex_unlock(&d->mtx);
+
+	ww_mutex_destroy(&d->mtx);
+}
+
+static void __used test_ww_mutex_lock_ctx(struct test_ww_mutex_data *d)
+{
+	struct ww_acquire_ctx ctx;
+
+	ww_acquire_init(&ctx, &ww_class);
+
+	if (!ww_mutex_lock(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (!ww_mutex_lock_interruptible(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	if (ww_mutex_trylock(&d->mtx, &ctx)) {
+		d->counter++;
+		ww_mutex_unlock(&d->mtx);
+	}
+
+	ww_mutex_lock_slow(&d->mtx, &ctx);
+	d->counter++;
+	ww_mutex_unlock(&d->mtx);
+
+	ww_acquire_done(&ctx);
+	ww_acquire_fini(&ctx);
+
+	ww_mutex_destroy(&d->mtx);
+}
-- 
2.52.0.rc1.455.g30608eb744-goog


