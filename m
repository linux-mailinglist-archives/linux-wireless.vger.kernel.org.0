Return-Path: <linux-wireless+bounces-29186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E83C74DF6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1E8594E766C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82EB735B12D;
	Thu, 20 Nov 2025 15:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="1RwWWr/Q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7635CB95
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651576; cv=none; b=r9rVZQN2ePwr7kIBfIP614E3cr2QasKrkdElkqOPYmZPmu2DdK7mbnXiOkA1K5fYVvt+0HmSmN7DUXQDUdycfUtoEW2WQ9ByOTHMsH2kzLSrpDxTq8AYH1i+URW21ApBaMgQBZ6PkUmvQ2sesrcwkjB2GGiIc35JbgBaxnOYhzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651576; c=relaxed/simple;
	bh=7UPhXVoQzb0nHVZ/E5WnJmrxexsYTFwM9dm+H6EnW5w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HKBDDxhRTJX6HvEXn2Bl5bdyVeHuhDK1C6DUXEQVYyGZuM+O0HUMrE7kA/awYKLQaJevN4V9aoNMclgJ30kmKv4BD0Q8m3EvQhhPm3urw5twix4dakOIMZCnvfMU33VBBtlfePT1L5Df5QLw9wSplY0jaGvFxyzHyXjjatGLdvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=1RwWWr/Q; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so460324f8f.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:12:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651552; x=1764256352; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln7UVfCWiCp9IlXxOO2xIWRuRprEYh3pWr1qQfgYpRY=;
        b=1RwWWr/Qfq1G6JZvGTWJHe4b87taklfazXzJeIlP+wauW/0p/hlMi/fEQdTtDaZbC5
         FvWqDicG7qQIASIdfLKy/nq+j2cLMCap3P3sPoEtlfNtgiPZq5Wp2pWX/MAmxzsGPHiz
         bRDd3TAaava0bknRxPr98IE6PFfviznYKQG3ZNdNSFMe8gaTNMJ3s7XTVRPfXjoBZK2C
         9lfYM+ioGG06WXLJk1cz0GvbMQJZ2FuDG/yxCd7IOSWqcwibI6L4bTW3xmhWzlT/RJLC
         8M9VTxp6WpsXfHBwaKYD2taHFw6ezIVTXIuwZ9yt21enez9xlO2YDTzv7i1FB9FoPk11
         ZAfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651552; x=1764256352;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ln7UVfCWiCp9IlXxOO2xIWRuRprEYh3pWr1qQfgYpRY=;
        b=bULwAJHNu+u6hq/RJ2n8Gn4WR57Q9hld/gvgh0HkvjwiC1CyL2XQsTdk1yK+5NJ2N2
         jte9a6emPC8ojAs5OFYz7c+52ScVu0Q7+2rJYJ+FGJkq1rxzSPMNl4/kC9Wd04jVPYuy
         mBAKJK2yM+PRjfOrm7L2r/zYdHOoZ/RX0Ju83UhbYp4V3SZAWBWY2lsMQ3W+BMpcpncs
         Sp+JYTS2ddm7x70Z7zCPbDo049i+do2ONMqhfePTlaUQf8WnI6NuFyiNorMubYdRjp+r
         k2ezVlFeGHkxY8XL+NXRwXGUJqpDccAHgkNBvHckPvrrYf4e6o5a/owARrtJn3b29G+M
         31ew==
X-Forwarded-Encrypted: i=1; AJvYcCVCytbduBkCqHD2vt5pi2/dClFTSWOO1PW0jcK+wlHABRAtvidMJXoG+S0UAoqLM1a2QgJdya7ox5InwUPneg==@vger.kernel.org
X-Gm-Message-State: AOJu0YytiVdPv0mD9GrUGoUs6tUM0f5V4xbeg4nHSJGd1weY8GCR7o5N
	t3ndjxiYaoU5vYgwRxrC20pBIleLRhoTfsnNdo4JkgnzNq49HUp3/owPm9XtZVzaTbFEE/92PkJ
	Jtg==
X-Google-Smtp-Source: AGHT+IGEIThrt25p8iFaAeOhASluQ3+/NjEt1IOMSXAcPjrVxIIVxtBuFT8+DlrUkxM3iN/ogjkjO7OQog==
X-Received: from wrs17.prod.google.com ([2002:a05:6000:651:b0:42b:328d:1994])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6000:2c05:b0:42b:4267:83d5
 with SMTP id ffacd0b85a97d-42cb9a11c12mr2935283f8f.8.1763651552168; Thu, 20
 Nov 2025 07:12:32 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:39 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-15-elver@google.com>
Subject: [PATCH v4 14/35] rcu: Support Clang's context analysis
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

Improve the existing annotations to properly support Clang's context
analysis.

The old annotations distinguished between RCU, RCU_BH, and RCU_SCHED;
however, to more easily be able to express that "hold the RCU read lock"
without caring if the normal, _bh(), or _sched() variant was used we'd
have to remove the distinction of the latter variants: change the _bh()
and _sched() variants to also acquire "RCU".

When (and if) we introduce context guards to denote more generally that
"IRQ", "BH", "PREEMPT" contexts are disabled, it would make sense to
acquire these instead of RCU_BH and RCU_SCHED respectively.

The above change also simplified introducing __guarded_by support, where
only the "RCU" context guard needs to be held: introduce __rcu_guarded,
where Clang's context analysis warns if a pointer is dereferenced
without any of the RCU locks held, or updated without the appropriate
helpers.

The primitives rcu_assign_pointer() and friends are wrapped with
context_unsafe(), which enforces using them to update RCU-protected
pointers marked with __rcu_guarded.

Signed-off-by: Marco Elver <elver@google.com>
---
v3:
* Properly support reentrancy via new compiler support.

v2:
* Reword commit message and point out reentrancy caveat.
---
 Documentation/dev-tools/context-analysis.rst |  2 +-
 include/linux/rcupdate.h                     | 77 ++++++++++++------
 lib/test_context-analysis.c                  | 85 ++++++++++++++++++++
 3 files changed, 139 insertions(+), 25 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index a3d925ce2df4..05164804a92a 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -81,7 +81,7 @@ Supported Kernel Primitives
 
 Currently the following synchronization primitives are supported:
 `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`, `seqlock_t`,
-`bit_spinlock`.
+`bit_spinlock`, RCU.
 
 For context guards with an initialization function (e.g., `spin_lock_init()`),
 calling this function before initializing any guarded members or globals
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index c5b30054cd01..5cddb9019a99 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -31,6 +31,16 @@
 #include <asm/processor.h>
 #include <linux/context_tracking_irq.h>
 
+token_context_guard(RCU, __reentrant_ctx_guard);
+token_context_guard_instance(RCU, RCU_SCHED);
+token_context_guard_instance(RCU, RCU_BH);
+
+/*
+ * A convenience macro that can be used for RCU-protected globals or struct
+ * members; adds type qualifier __rcu, and also enforces __guarded_by(RCU).
+ */
+#define __rcu_guarded __rcu __guarded_by(RCU)
+
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
 
@@ -425,7 +435,8 @@ static inline void rcu_preempt_sleep_check(void) { }
 
 // See RCU_LOCKDEP_WARN() for an explanation of the double call to
 // debug_lockdep_rcu_enabled().
-static inline bool lockdep_assert_rcu_helper(bool c)
+static inline bool lockdep_assert_rcu_helper(bool c, const struct __ctx_guard_RCU *ctx)
+	__assumes_shared_ctx_guard(RCU) __assumes_shared_ctx_guard(ctx)
 {
 	return debug_lockdep_rcu_enabled() &&
 	       (c || !rcu_is_watching() || !rcu_lockdep_current_cpu_online()) &&
@@ -438,7 +449,7 @@ static inline bool lockdep_assert_rcu_helper(bool c)
  * Splats if lockdep is enabled and there is no rcu_read_lock() in effect.
  */
 #define lockdep_assert_in_rcu_read_lock() \
-	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_lock_map)))
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_lock_map), RCU))
 
 /**
  * lockdep_assert_in_rcu_read_lock_bh - WARN if not protected by rcu_read_lock_bh()
@@ -448,7 +459,7 @@ static inline bool lockdep_assert_rcu_helper(bool c)
  * actual rcu_read_lock_bh() is required.
  */
 #define lockdep_assert_in_rcu_read_lock_bh() \
-	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_bh_lock_map)))
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_bh_lock_map), RCU_BH))
 
 /**
  * lockdep_assert_in_rcu_read_lock_sched - WARN if not protected by rcu_read_lock_sched()
@@ -458,7 +469,7 @@ static inline bool lockdep_assert_rcu_helper(bool c)
  * instead an actual rcu_read_lock_sched() is required.
  */
 #define lockdep_assert_in_rcu_read_lock_sched() \
-	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_sched_lock_map)))
+	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_sched_lock_map), RCU_SCHED))
 
 /**
  * lockdep_assert_in_rcu_reader - WARN if not within some type of RCU reader
@@ -476,17 +487,17 @@ static inline bool lockdep_assert_rcu_helper(bool c)
 	WARN_ON_ONCE(lockdep_assert_rcu_helper(!lock_is_held(&rcu_lock_map) &&			\
 					       !lock_is_held(&rcu_bh_lock_map) &&		\
 					       !lock_is_held(&rcu_sched_lock_map) &&		\
-					       preemptible()))
+					       preemptible(), RCU))
 
 #else /* #ifdef CONFIG_PROVE_RCU */
 
 #define RCU_LOCKDEP_WARN(c, s) do { } while (0 && (c))
 #define rcu_sleep_check() do { } while (0)
 
-#define lockdep_assert_in_rcu_read_lock() do { } while (0)
-#define lockdep_assert_in_rcu_read_lock_bh() do { } while (0)
-#define lockdep_assert_in_rcu_read_lock_sched() do { } while (0)
-#define lockdep_assert_in_rcu_reader() do { } while (0)
+#define lockdep_assert_in_rcu_read_lock() __assume_shared_ctx_guard(RCU)
+#define lockdep_assert_in_rcu_read_lock_bh() __assume_shared_ctx_guard(RCU_BH)
+#define lockdep_assert_in_rcu_read_lock_sched() __assume_shared_ctx_guard(RCU_SCHED)
+#define lockdep_assert_in_rcu_reader() __assume_shared_ctx_guard(RCU)
 
 #endif /* #else #ifdef CONFIG_PROVE_RCU */
 
@@ -506,11 +517,11 @@ static inline bool lockdep_assert_rcu_helper(bool c)
 #endif /* #else #ifdef __CHECKER__ */
 
 #define __unrcu_pointer(p, local)					\
-({									\
+context_unsafe(								\
 	typeof(*p) *local = (typeof(*p) *__force)(p);			\
 	rcu_check_sparse(p, __rcu);					\
-	((typeof(*p) __force __kernel *)(local)); 			\
-})
+	((typeof(*p) __force __kernel *)(local)) 			\
+)
 /**
  * unrcu_pointer - mark a pointer as not being RCU protected
  * @p: pointer needing to lose its __rcu property
@@ -586,7 +597,7 @@ static inline bool lockdep_assert_rcu_helper(bool c)
  * other macros that it invokes.
  */
 #define rcu_assign_pointer(p, v)					      \
-do {									      \
+context_unsafe(							      \
 	uintptr_t _r_a_p__v = (uintptr_t)(v);				      \
 	rcu_check_sparse(p, __rcu);					      \
 									      \
@@ -594,7 +605,7 @@ do {									      \
 		WRITE_ONCE((p), (typeof(p))(_r_a_p__v));		      \
 	else								      \
 		smp_store_release(&p, RCU_INITIALIZER((typeof(p))_r_a_p__v)); \
-} while (0)
+)
 
 /**
  * rcu_replace_pointer() - replace an RCU pointer, returning its old value
@@ -861,9 +872,10 @@ do {									      \
  * only when acquiring spinlocks that are subject to priority inheritance.
  */
 static __always_inline void rcu_read_lock(void)
+	__acquires_shared(RCU)
 {
 	__rcu_read_lock();
-	__acquire(RCU);
+	__acquire_shared(RCU);
 	rcu_lock_acquire(&rcu_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock() used illegally while idle");
@@ -891,11 +903,12 @@ static __always_inline void rcu_read_lock(void)
  * See rcu_read_lock() for more information.
  */
 static inline void rcu_read_unlock(void)
+	__releases_shared(RCU)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock() used illegally while idle");
 	rcu_lock_release(&rcu_lock_map); /* Keep acq info for rls diags. */
-	__release(RCU);
+	__release_shared(RCU);
 	__rcu_read_unlock();
 }
 
@@ -914,9 +927,11 @@ static inline void rcu_read_unlock(void)
  * was invoked from some other task.
  */
 static inline void rcu_read_lock_bh(void)
+	__acquires_shared(RCU) __acquires_shared(RCU_BH)
 {
 	local_bh_disable();
-	__acquire(RCU_BH);
+	__acquire_shared(RCU);
+	__acquire_shared(RCU_BH);
 	rcu_lock_acquire(&rcu_bh_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock_bh() used illegally while idle");
@@ -928,11 +943,13 @@ static inline void rcu_read_lock_bh(void)
  * See rcu_read_lock_bh() for more information.
  */
 static inline void rcu_read_unlock_bh(void)
+	__releases_shared(RCU) __releases_shared(RCU_BH)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock_bh() used illegally while idle");
 	rcu_lock_release(&rcu_bh_lock_map);
-	__release(RCU_BH);
+	__release_shared(RCU_BH);
+	__release_shared(RCU);
 	local_bh_enable();
 }
 
@@ -952,9 +969,11 @@ static inline void rcu_read_unlock_bh(void)
  * rcu_read_lock_sched() was invoked from an NMI handler.
  */
 static inline void rcu_read_lock_sched(void)
+	__acquires_shared(RCU) __acquires_shared(RCU_SCHED)
 {
 	preempt_disable();
-	__acquire(RCU_SCHED);
+	__acquire_shared(RCU);
+	__acquire_shared(RCU_SCHED);
 	rcu_lock_acquire(&rcu_sched_lock_map);
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_lock_sched() used illegally while idle");
@@ -962,9 +981,11 @@ static inline void rcu_read_lock_sched(void)
 
 /* Used by lockdep and tracing: cannot be traced, cannot call lockdep. */
 static inline notrace void rcu_read_lock_sched_notrace(void)
+	__acquires_shared(RCU) __acquires_shared(RCU_SCHED)
 {
 	preempt_disable_notrace();
-	__acquire(RCU_SCHED);
+	__acquire_shared(RCU);
+	__acquire_shared(RCU_SCHED);
 }
 
 /**
@@ -973,22 +994,27 @@ static inline notrace void rcu_read_lock_sched_notrace(void)
  * See rcu_read_lock_sched() for more information.
  */
 static inline void rcu_read_unlock_sched(void)
+	__releases_shared(RCU) __releases_shared(RCU_SCHED)
 {
 	RCU_LOCKDEP_WARN(!rcu_is_watching(),
 			 "rcu_read_unlock_sched() used illegally while idle");
 	rcu_lock_release(&rcu_sched_lock_map);
-	__release(RCU_SCHED);
+	__release_shared(RCU_SCHED);
+	__release_shared(RCU);
 	preempt_enable();
 }
 
 /* Used by lockdep and tracing: cannot be traced, cannot call lockdep. */
 static inline notrace void rcu_read_unlock_sched_notrace(void)
+	__releases_shared(RCU) __releases_shared(RCU_SCHED)
 {
-	__release(RCU_SCHED);
+	__release_shared(RCU_SCHED);
+	__release_shared(RCU);
 	preempt_enable_notrace();
 }
 
 static __always_inline void rcu_read_lock_dont_migrate(void)
+	__acquires_shared(RCU)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
 		migrate_disable();
@@ -996,6 +1022,7 @@ static __always_inline void rcu_read_lock_dont_migrate(void)
 }
 
 static inline void rcu_read_unlock_migrate(void)
+	__releases_shared(RCU)
 {
 	rcu_read_unlock();
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU))
@@ -1041,10 +1068,10 @@ static inline void rcu_read_unlock_migrate(void)
  * ordering guarantees for either the CPU or the compiler.
  */
 #define RCU_INIT_POINTER(p, v) \
-	do { \
+	context_unsafe( \
 		rcu_check_sparse(p, __rcu); \
 		WRITE_ONCE(p, RCU_INITIALIZER(v)); \
-	} while (0)
+	)
 
 /**
  * RCU_POINTER_INITIALIZER() - statically initialize an RCU protected pointer
@@ -1206,4 +1233,6 @@ DEFINE_LOCK_GUARD_0(rcu,
 	} while (0),
 	rcu_read_unlock())
 
+DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
+
 #endif /* __LINUX_RCUPDATE_H */
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 77e599a9281b..f18b7252646d 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -7,6 +7,7 @@
 #include <linux/bit_spinlock.h>
 #include <linux/build_bug.h>
 #include <linux/mutex.h>
+#include <linux/rcupdate.h>
 #include <linux/seqlock.h>
 #include <linux/spinlock.h>
 
@@ -277,3 +278,87 @@ static void __used test_bit_spin_lock(struct test_bit_spinlock_data *d)
 		bit_spin_unlock(3, &d->bits);
 	}
 }
+
+/*
+ * Test that we can mark a variable guarded by RCU, and we can dereference and
+ * write to the pointer with RCU's primitives.
+ */
+struct test_rcu_data {
+	long __rcu_guarded *data;
+};
+
+static void __used test_rcu_guarded_reader(struct test_rcu_data *d)
+{
+	rcu_read_lock();
+	(void)rcu_dereference(d->data);
+	rcu_read_unlock();
+
+	rcu_read_lock_bh();
+	(void)rcu_dereference(d->data);
+	rcu_read_unlock_bh();
+
+	rcu_read_lock_sched();
+	(void)rcu_dereference(d->data);
+	rcu_read_unlock_sched();
+}
+
+static void __used test_rcu_guard(struct test_rcu_data *d)
+{
+	guard(rcu)();
+	(void)rcu_dereference(d->data);
+}
+
+static void __used test_rcu_guarded_updater(struct test_rcu_data *d)
+{
+	rcu_assign_pointer(d->data, NULL);
+	RCU_INIT_POINTER(d->data, NULL);
+	(void)unrcu_pointer(d->data);
+}
+
+static void wants_rcu_held(void)	__must_hold_shared(RCU)       { }
+static void wants_rcu_held_bh(void)	__must_hold_shared(RCU_BH)    { }
+static void wants_rcu_held_sched(void)	__must_hold_shared(RCU_SCHED) { }
+
+static void __used test_rcu_lock_variants(void)
+{
+	rcu_read_lock();
+	wants_rcu_held();
+	rcu_read_unlock();
+
+	rcu_read_lock_bh();
+	wants_rcu_held_bh();
+	rcu_read_unlock_bh();
+
+	rcu_read_lock_sched();
+	wants_rcu_held_sched();
+	rcu_read_unlock_sched();
+}
+
+static void __used test_rcu_lock_reentrant(void)
+{
+	rcu_read_lock();
+	rcu_read_lock();
+	rcu_read_lock_bh();
+	rcu_read_lock_bh();
+	rcu_read_lock_sched();
+	rcu_read_lock_sched();
+
+	rcu_read_unlock_sched();
+	rcu_read_unlock_sched();
+	rcu_read_unlock_bh();
+	rcu_read_unlock_bh();
+	rcu_read_unlock();
+	rcu_read_unlock();
+}
+
+static void __used test_rcu_assert_variants(void)
+{
+	lockdep_assert_in_rcu_read_lock();
+	wants_rcu_held();
+
+	lockdep_assert_in_rcu_read_lock_bh();
+	wants_rcu_held_bh();
+
+	lockdep_assert_in_rcu_read_lock_sched();
+	wants_rcu_held_sched();
+}
-- 
2.52.0.rc1.455.g30608eb744-goog


