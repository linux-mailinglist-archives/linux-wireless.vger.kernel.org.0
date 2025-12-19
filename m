Return-Path: <linux-wireless+bounces-29940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 77170CD0FE3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0C360304B3E3
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:52:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0DCC33FE1F;
	Fri, 19 Dec 2025 15:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qRQejhVB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C597F340D90
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159173; cv=none; b=N7J/tJ3RN7+AKV5rwoSXgnwmHf8+Q7s6DI/usShJeyNcTvOeaaMMLBP3pARS9m23g1lC/6no8isuKP1xducjLxijM3NE3SkACdBICIgEqSuAGWIjB5RssLLw12m9XTrjaLw/nCQRhOpExZYcr0DeOOyQwtP/3KSMqzHevErUodg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159173; c=relaxed/simple;
	bh=m+2uypAcBzZqVoQHjxu4/pvBeR9wTc1cg3TkE2rmywI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=OkmuIrmlrimiTieKNgTa3I+BrKd58kQYY4/5DxEA+iueV98Lx/tVG6o+hTOrim5+/Ygx++h6kF1l7MuhfZ7IDytK1NY3bTtiTSMWFb73dTt8NciMoxG0LIwu5mgJB0p9hWEN+25JxH1gEEFgQBpFKYcTbS9GPIyu7oPPyje/bXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qRQejhVB; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477563e531cso12944295e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:46:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159165; x=1766763965; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2nto1KcJJjiv3QrSNF53pqHLj6j420z7Hf2YMAu356w=;
        b=qRQejhVBcAu6gcPuioMPgFGvv2dGvnUkqmqm1hI1nS5t+H18zzrw4D+efWQBJ0XIY8
         IM31tXkPD78IhQ8gTQ4r9aRhirJCx707sxWR9lGlwZxZ2f304XSDZjJdHlrgLWhqyN4C
         2mG7ISFpv4zKLmSW2c+mK0Yk9gRzS2chbbFd1eQx1U3Y2z4obpRQHFLy2WL92dlf+X90
         6zlraidkHW8gzG7sviCGmkXunNYi42rFz2+K/NKhtQubf3i9U/Ir9zV3hLejRkACCrq3
         4EZAFvEFrHQv0P2DDNgir+/EPSB9WJ7U6h1UUghGFFcWMM9ViT1OH9zEmq0hoREkwPGa
         XV1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159165; x=1766763965;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2nto1KcJJjiv3QrSNF53pqHLj6j420z7Hf2YMAu356w=;
        b=HsET28nTb7QieIRXZG7fADuS2UBNwoAmMmzM2iu/SgMJQv3oNXToUKePbg6IoJDMkL
         V/Kr3jINcyGnsIo27srusFAxHIt9D+Tjw47nVXH38x5cV7KRcJOH6mMV5RppuPlQEVFs
         VQnO7cx4+VXqO6VILefcc7bxYWyU6IKIOpJHDzxwga+W9Y8y9/3DPKNW/rc+tQV9VmMI
         E1uQNrzEiwQS3cVMyeOzmcmE9/plzfgzI9o13RrJL5ueXkGlX4JCgIL7GoDSqYFLJ5mz
         n1Xb+McSRiSYLotZC9Z2JveqyuGA2Bt+kAor0uqmEG0sTXZH9ZfUbwTC92xDKTNBqLXs
         JoiQ==
X-Forwarded-Encrypted: i=1; AJvYcCXuTlzS1uopPRnCcjZ5B9tSwOM+8QwOX39cFnS3sGU17SLFgXdIviQuLhwe3rICbxl3JPpwwoPg94hak9caWA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJSxyt5uvwicN8VcoIfjmMteK3bVD5DQoZp2HpZKbEuFg1tEG
	ek03jJZgPhw7jbWb2uaZ4rhGDBtse4TZ+sLf4nLPtujIiwmUdz8+1X1vavefU/aUm1YN+JHXkxP
	mGw==
X-Google-Smtp-Source: AGHT+IEI4FtTU2uBJwILA8/Yh0TJDO/NsIIewDaTcKmzVNBr5My/fTSLrYYgL2OtjmIxbmTe6FcaJZZhgQ==
X-Received: from wmby2.prod.google.com ([2002:a05:600c:c042:b0:477:165e:7e2a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4ecd:b0:477:1bb6:17e5
 with SMTP id 5b1f17b1804b1-47d19593e32mr28466615e9.30.1766159165093; Fri, 19
 Dec 2025 07:46:05 -0800 (PST)
Date: Fri, 19 Dec 2025 16:39:59 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-11-elver@google.com>
Subject: [PATCH v5 10/36] locking/mutex: Support Clang's context analysis
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

Add support for Clang's context analysis for mutex.

Signed-off-by: Marco Elver <elver@google.com>
---
v5:
* Rename "context guard" -> "context lock".

v4:
* Rename capability -> context analysis.

v3:
* Switch to DECLARE_LOCK_GUARD_1_ATTRS() (suggested by Peter)
* __assert -> __assume rename
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/mutex.h                        | 38 +++++++-----
 include/linux/mutex_types.h                  |  4 +-
 lib/test_context-analysis.c                  | 64 ++++++++++++++++++++
 4 files changed, 90 insertions(+), 18 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index 746a2d275fb2..1864b6cba4d1 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -79,7 +79,7 @@ Supported Kernel Primitives
 ~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 Currently the following synchronization primitives are supported:
-`raw_spinlock_t`, `spinlock_t`, `rwlock_t`.
+`raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`.
 
 For context locks with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index bf535f0118bb..89977c215cbd 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -62,6 +62,7 @@ do {									\
 	static struct lock_class_key __key;				\
 									\
 	__mutex_init((mutex), #mutex, &__key);				\
+	__assume_ctx_lock(mutex);					\
 } while (0)
 
 /**
@@ -182,13 +183,13 @@ static inline int __must_check __devm_mutex_init(struct device *dev, struct mute
  * Also see Documentation/locking/mutex-design.rst.
  */
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass);
+extern void mutex_lock_nested(struct mutex *lock, unsigned int subclass) __acquires(lock);
 extern void _mutex_lock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
 extern int __must_check mutex_lock_interruptible_nested(struct mutex *lock,
-					unsigned int subclass);
+					unsigned int subclass) __cond_acquires(0, lock);
 extern int __must_check _mutex_lock_killable(struct mutex *lock,
-		unsigned int subclass, struct lockdep_map *nest_lock);
-extern void mutex_lock_io_nested(struct mutex *lock, unsigned int subclass);
+		unsigned int subclass, struct lockdep_map *nest_lock) __cond_acquires(0, lock);
+extern void mutex_lock_io_nested(struct mutex *lock, unsigned int subclass) __acquires(lock);
 
 #define mutex_lock(lock) mutex_lock_nested(lock, 0)
 #define mutex_lock_interruptible(lock) mutex_lock_interruptible_nested(lock, 0)
@@ -211,10 +212,10 @@ do {									\
 	_mutex_lock_killable(lock, subclass, NULL)
 
 #else
-extern void mutex_lock(struct mutex *lock);
-extern int __must_check mutex_lock_interruptible(struct mutex *lock);
-extern int __must_check mutex_lock_killable(struct mutex *lock);
-extern void mutex_lock_io(struct mutex *lock);
+extern void mutex_lock(struct mutex *lock) __acquires(lock);
+extern int __must_check mutex_lock_interruptible(struct mutex *lock) __cond_acquires(0, lock);
+extern int __must_check mutex_lock_killable(struct mutex *lock) __cond_acquires(0, lock);
+extern void mutex_lock_io(struct mutex *lock) __acquires(lock);
 
 # define mutex_lock_nested(lock, subclass) mutex_lock(lock)
 # define mutex_lock_interruptible_nested(lock, subclass) mutex_lock_interruptible(lock)
@@ -232,7 +233,7 @@ extern void mutex_lock_io(struct mutex *lock);
  */
 
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
-extern int _mutex_trylock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock);
+extern int _mutex_trylock_nest_lock(struct mutex *lock, struct lockdep_map *nest_lock) __cond_acquires(true, lock);
 
 #define mutex_trylock_nest_lock(lock, nest_lock)		\
 (								\
@@ -242,17 +243,24 @@ extern int _mutex_trylock_nest_lock(struct mutex *lock, struct lockdep_map *nest
 
 #define mutex_trylock(lock) _mutex_trylock_nest_lock(lock, NULL)
 #else
-extern int mutex_trylock(struct mutex *lock);
+extern int mutex_trylock(struct mutex *lock) __cond_acquires(true, lock);
 #define mutex_trylock_nest_lock(lock, nest_lock) mutex_trylock(lock)
 #endif
 
-extern void mutex_unlock(struct mutex *lock);
+extern void mutex_unlock(struct mutex *lock) __releases(lock);
 
-extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
+extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock) __cond_acquires(true, lock);
 
-DEFINE_GUARD(mutex, struct mutex *, mutex_lock(_T), mutex_unlock(_T))
-DEFINE_GUARD_COND(mutex, _try, mutex_trylock(_T))
-DEFINE_GUARD_COND(mutex, _intr, mutex_lock_interruptible(_T), _RET == 0)
+DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
+DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _RET == 0)
+
+DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr, _T)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
diff --git a/include/linux/mutex_types.h b/include/linux/mutex_types.h
index fdf7f515fde8..80975935ec48 100644
--- a/include/linux/mutex_types.h
+++ b/include/linux/mutex_types.h
@@ -38,7 +38,7 @@
  * - detects multi-task circular deadlocks and prints out all affected
  *   locks and tasks (and only those tasks)
  */
-struct mutex {
+context_lock_struct(mutex) {
 	atomic_long_t		owner;
 	raw_spinlock_t		wait_lock;
 #ifdef CONFIG_MUTEX_SPIN_ON_OWNER
@@ -59,7 +59,7 @@ struct mutex {
  */
 #include <linux/rtmutex.h>
 
-struct mutex {
+context_lock_struct(mutex) {
 	struct rt_mutex_base	rtmutex;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
 	struct lockdep_map	dep_map;
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 273fa9d34657..2b28d20c5f51 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/build_bug.h>
+#include <linux/mutex.h>
 #include <linux/spinlock.h>
 
 /*
@@ -144,3 +145,66 @@ TEST_SPINLOCK_COMMON(read_lock,
 		     read_unlock,
 		     read_trylock,
 		     TEST_OP_RO);
+
+struct test_mutex_data {
+	struct mutex mtx;
+	int counter __guarded_by(&mtx);
+};
+
+static void __used test_mutex_init(struct test_mutex_data *d)
+{
+	mutex_init(&d->mtx);
+	d->counter = 0;
+}
+
+static void __used test_mutex_lock(struct test_mutex_data *d)
+{
+	mutex_lock(&d->mtx);
+	d->counter++;
+	mutex_unlock(&d->mtx);
+	mutex_lock_io(&d->mtx);
+	d->counter++;
+	mutex_unlock(&d->mtx);
+}
+
+static void __used test_mutex_trylock(struct test_mutex_data *d, atomic_t *a)
+{
+	if (!mutex_lock_interruptible(&d->mtx)) {
+		d->counter++;
+		mutex_unlock(&d->mtx);
+	}
+	if (!mutex_lock_killable(&d->mtx)) {
+		d->counter++;
+		mutex_unlock(&d->mtx);
+	}
+	if (mutex_trylock(&d->mtx)) {
+		d->counter++;
+		mutex_unlock(&d->mtx);
+	}
+	if (atomic_dec_and_mutex_lock(a, &d->mtx)) {
+		d->counter++;
+		mutex_unlock(&d->mtx);
+	}
+}
+
+static void __used test_mutex_assert(struct test_mutex_data *d)
+{
+	lockdep_assert_held(&d->mtx);
+	d->counter++;
+}
+
+static void __used test_mutex_guard(struct test_mutex_data *d)
+{
+	guard(mutex)(&d->mtx);
+	d->counter++;
+}
+
+static void __used test_mutex_cond_guard(struct test_mutex_data *d)
+{
+	scoped_cond_guard(mutex_try, return, &d->mtx) {
+		d->counter++;
+	}
+	scoped_cond_guard(mutex_intr, return, &d->mtx) {
+		d->counter++;
+	}
+}
-- 
2.52.0.322.g1dd061c0dc-goog


