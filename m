Return-Path: <linux-wireless+bounces-29192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A45A5C74E6E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E034C35A777
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18C8364E9B;
	Thu, 20 Nov 2025 15:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="fT1oLB6c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95BD0364028
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651611; cv=none; b=EYDFXo2PF52RF+0okIRbQhlKAOlgwl5OQ7nOIMM3hRKCzJn2mVHaykSxR5iOjzeOcKpTpDe6QeCdCHII6R5bjkTIjaKFyOiOesdB7psU6/aP/Yi+HeDCHWlp6K3h6Ut3VZeX+l/GtlXYjwEqqQMKmo8kVODi3r9GzI5J5f4oFzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651611; c=relaxed/simple;
	bh=uf1gzv7z8skOrRT4+VFvC3of+qZ1MAXWLNFNhiBTmcE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=H3rGarHXYdG8naAscTa5pJeY7v0n6zfTZN7JwRTJ6h8nb3Roko+81JZiZW5TdAlU31Jnzm3kKbjY7yLEkMMPnYe/sQLCsJVo8Edhp6EoLOlwwZAzfU8BYDBuw4GEPE109rkbOZwgCGfyqr5dOFCJpgGOrAO68o48ASVV6vhSa4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=fT1oLB6c; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779393221aso5902945e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651602; x=1764256402; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=FM+v7kmKwxv6mQJTQvhb3JUsaW+ES8Jzb95oMtr52Zo=;
        b=fT1oLB6c5VIKMCiWxU8rNiukd32qEB//omllrOy8gKSoALUR0/l69DQdtzxf7u9+Wf
         lOaLJWfFzMMK2Q1IKTpMkgRDqeoELU+yrEPy2htsOvfzP/BWrlNA6YlXaRbtCdIlBDCd
         /vx3TSRu8ySShSYKto7HMV5MqJ+qzw/xrgvFkf6+54AiMSuIblFaQesQDiKzUS0jWuSH
         3YFQsqTnfKE1KXzvAa2D26tz06N4jQAX3vP7tfGfr/NlkpnBTSXqjWsbg+Q4KIdYJCyf
         sFnraBmsWK4b4nB1a9QuHaeDR2Vk0vuft2yo/l1r7K+iGjk7HyezlspnObSA3JxN1uw1
         za0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651602; x=1764256402;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FM+v7kmKwxv6mQJTQvhb3JUsaW+ES8Jzb95oMtr52Zo=;
        b=c2gDNm7AHC9xJUkLZwDksiLfCY3oKp4djTdHASdF7IFPVFARO9/Qcq4GlyHWTq1AiZ
         pdU7vrlKjtfrkntHiQx8t6VJqvTlJvtYLS5/Vav62ffMCHaX15hCeZgjZJHJ+dajcsTH
         3aKbv2OMonJnLgoWh3gCNsdIowRa3plMdUCvoXh4J72LaLlFtLw+C1oztjR/QyO8DaJt
         MZPr3606UtHtMTZFPY4O45UPfdB5KpKjbkzf1Mmd5RXXxmiDKCtZ4VrArg9vTYmplHAd
         ZinFB9t3L6YUp7KtAL+wRuJKxbCzWKIQYTiGjf+BpDiVr7T3x/bhxrm+eE8at6WhbYYC
         TZzA==
X-Forwarded-Encrypted: i=1; AJvYcCX6lGJL8GvrRt0U2fhPCHhCdYeQUFenposMLQw8t3BcKU2ileX3So6G2fds/8RjBnp9jOaR1ltziD4GlgrP4A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/87oLLq1MdLlV5845do5AFygCGER5kjAqKeXltHUoHTKfj7MC
	mCDO1mKBa0NG+g8ajV8DQULTZOiUh0VkcK5r++xh/AXQl30L59CdOdOVrrhGVP3Hbd6SCCK/6RV
	nrw==
X-Google-Smtp-Source: AGHT+IFa8gcAYDmSbcN98uTmCv7ow2f9WIs4txwLFz3cf4q2hwFdJRSgsIcTcuSjJZmiASAfOgD6nIwlVA==
X-Received: from wmgi8.prod.google.com ([2002:a05:600c:2d88:b0:475:d94e:4d5d])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:458e:b0:46e:396b:f5ae
 with SMTP id 5b1f17b1804b1-477bac0cfb5mr29573045e9.16.1763651595671; Thu, 20
 Nov 2025 07:13:15 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:47 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-23-elver@google.com>
Subject: [PATCH v4 22/35] compiler-context-analysis: Remove Sparse support
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

Remove Sparse support as discussed at [1].

The kernel codebase is still scattered with numerous places that try to
appease Sparse's context tracking ("annotation for sparse", "fake out
sparse", "work around sparse", etc.). Eventually, as more subsystems
enable Clang's context analysis, these places will show up and need
adjustment or removal of the workarounds altogether.

Link: https://lore.kernel.org/all/20250207083335.GW7145@noisy.programming.kicks-ass.net/ [1]
Link: https://lore.kernel.org/all/Z6XTKTo_LMj9KmbY@elver.google.com/ [2]
Cc: Chris Li <sparse@chrisli.org>
Cc: "Luc Van Oostenryck" <luc.vanoostenryck@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v2:
* New patch.
---
 Documentation/dev-tools/sparse.rst        | 19 -----
 include/linux/compiler-context-analysis.h | 85 +++++++----------------
 include/linux/rcupdate.h                  | 15 +---
 3 files changed, 28 insertions(+), 91 deletions(-)

diff --git a/Documentation/dev-tools/sparse.rst b/Documentation/dev-tools/sparse.rst
index dc791c8d84d1..37b20170835d 100644
--- a/Documentation/dev-tools/sparse.rst
+++ b/Documentation/dev-tools/sparse.rst
@@ -53,25 +53,6 @@ sure that bitwise types don't get mixed up (little-endian vs big-endian
 vs cpu-endian vs whatever), and there the constant "0" really _is_
 special.
 
-Using sparse for lock checking
-------------------------------
-
-The following macros are undefined for gcc and defined during a sparse
-run to use the "context" tracking feature of sparse, applied to
-locking.  These annotations tell sparse when a lock is held, with
-regard to the annotated function's entry and exit.
-
-__must_hold - The specified lock is held on function entry and exit.
-
-__acquires - The specified lock is held on function exit, but not entry.
-
-__releases - The specified lock is held on function entry, but not exit.
-
-If the function enters and exits without the lock held, acquiring and
-releasing the lock inside the function in a balanced way, no
-annotation is needed.  The three annotations above are for cases where
-sparse would otherwise report a context imbalance.
-
 Getting sparse
 --------------
 
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 935e59089d75..6990cab7a4a9 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -250,57 +250,32 @@ static inline void _context_unsafe_alias(void **p) { }
 	extern const struct __ctx_guard_##ctx *name
 
 /*
- * Common keywords for static context analysis. Both Clang's "capability
- * analysis" and Sparse's "context tracking" are currently supported.
- */
-#ifdef __CHECKER__
-
-/* Sparse context/lock checking support. */
-# define __must_hold(x)		__attribute__((context(x,1,1)))
-# define __must_not_hold(x)
-# define __acquires(x)		__attribute__((context(x,0,1)))
-# define __cond_acquires(ret, x) __attribute__((context(x,0,-1)))
-# define __releases(x)		__attribute__((context(x,1,0)))
-# define __acquire(x)		__context__(x,1)
-# define __release(x)		__context__(x,-1)
-# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
-/* For Sparse, there's no distinction between exclusive and shared locks. */
-# define __must_hold_shared	__must_hold
-# define __acquires_shared	__acquires
-# define __cond_acquires_shared __cond_acquires
-# define __releases_shared	__releases
-# define __acquire_shared	__acquire
-# define __release_shared	__release
-# define __cond_lock_shared	__cond_acquire
-
-#else /* !__CHECKER__ */
+ * Common keywords for static context analysis.
+ */
 
 /**
  * __must_hold() - function attribute, caller must hold exclusive context guard
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * guard instance @x exclusively.
+ * guard instance(s) exclusively.
  */
-# define __must_hold(x)		__requires_ctx_guard(x)
+#define __must_hold(...)	__requires_ctx_guard(__VA_ARGS__)
 
 /**
  * __must_not_hold() - function attribute, caller must not hold context guard
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the caller must not hold the given context
- * guard instance @x.
+ * guard instance(s).
  */
-# define __must_not_hold(x)	__excludes_ctx_guard(x)
+#define __must_not_hold(...)	__excludes_ctx_guard(__VA_ARGS__)
 
 /**
  * __acquires() - function attribute, function acquires context guard exclusively
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the function acquires the given context
- * guard instance @x exclusively, but does not release it.
+ * guard instance(s) exclusively, but does not release them.
  */
-# define __acquires(x)		__acquires_ctx_guard(x)
+#define __acquires(...)		__acquires_ctx_guard(__VA_ARGS__)
 
 /*
  * Clang's analysis does not care precisely about the value, only that it is
@@ -327,17 +302,16 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
+#define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
 
 /**
  * __releases() - function attribute, function releases a context guard exclusively
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * guard instance @x exclusively. The associated context must be active on
+ * guard instance(s) exclusively. The associated context(s) must be active on
  * entry.
  */
-# define __releases(x)		__releases_ctx_guard(x)
+#define __releases(...)		__releases_ctx_guard(__VA_ARGS__)
 
 /**
  * __acquire() - function to acquire context guard exclusively
@@ -345,7 +319,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that acquires the given context guard instance @x exclusively.
  */
-# define __acquire(x)		__acquire_ctx_guard(x)
+#define __acquire(x)		__acquire_ctx_guard(x)
 
 /**
  * __release() - function to release context guard exclusively
@@ -353,7 +327,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that releases the given context guard instance @x.
  */
-# define __release(x)		__release_ctx_guard(x)
+#define __release(x)		__release_ctx_guard(x)
 
 /**
  * __cond_lock() - function that conditionally acquires a context guard
@@ -371,25 +345,23 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
  */
-# define __cond_lock(x, c)	__try_acquire_ctx_guard(x, c)
+#define __cond_lock(x, c)	__try_acquire_ctx_guard(x, c)
 
 /**
  * __must_hold_shared() - function attribute, caller must hold shared context guard
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * guard instance @x with shared access.
+ * guard instance(s) with shared access.
  */
-# define __must_hold_shared(x)	__requires_shared_ctx_guard(x)
+#define __must_hold_shared(...)	__requires_shared_ctx_guard(__VA_ARGS__)
 
 /**
  * __acquires_shared() - function attribute, function acquires context guard shared
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the function acquires the given
- * context guard instance @x with shared access, but does not release it.
+ * context guard instance(s) with shared access, but does not release them.
  */
-# define __acquires_shared(x)	__acquires_shared_ctx_guard(x)
+#define __acquires_shared(...)	__acquires_shared_ctx_guard(__VA_ARGS__)
 
 /**
  * __cond_acquires_shared() - function attribute, function conditionally
@@ -398,23 +370,22 @@ static inline void _context_unsafe_alias(void **p) { }
  * @x: context guard instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given context guard instance @x with shared access, but does not release it. The
- * function return value @ret denotes when the context guard is acquired.
+ * given context guard instance @x with shared access, but does not release it.
+ * The function return value @ret denotes when the context guard is acquired.
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _shared)
+#define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _shared)
 
 /**
  * __releases_shared() - function attribute, function releases a
  *                       context guard shared
- * @x: context guard instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * guard instance @x with shared access. The associated context must be active
- * on entry.
+ * guard instance(s) with shared access. The associated context(s) must be
+ * active on entry.
  */
-# define __releases_shared(x)	__releases_shared_ctx_guard(x)
+#define __releases_shared(...)	__releases_shared_ctx_guard(__VA_ARGS__)
 
 /**
  * __acquire_shared() - function to acquire context guard shared
@@ -423,7 +394,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that acquires the given context guard instance @x with shared
  * access.
  */
-# define __acquire_shared(x)	__acquire_shared_ctx_guard(x)
+#define __acquire_shared(x)	__acquire_shared_ctx_guard(x)
 
 /**
  * __release_shared() - function to release context guard shared
@@ -432,7 +403,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that releases the given context guard instance @x with shared
  * access.
  */
-# define __release_shared(x)	__release_shared_ctx_guard(x)
+#define __release_shared(x)	__release_shared_ctx_guard(x)
 
 /**
  * __cond_lock_shared() - function that conditionally acquires a context guard shared
@@ -445,9 +416,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * shared access, if the boolean expression @c is true. The result of @c is the
  * return value.
  */
-# define __cond_lock_shared(x, c) __try_acquire_shared_ctx_guard(x, c)
-
-#endif /* __CHECKER__ */
+#define __cond_lock_shared(x, c) __try_acquire_shared_ctx_guard(x, c)
 
 /**
  * __acquire_ret() - helper to acquire context guard of return value
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 5cddb9019a99..dd12e738e073 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -1219,20 +1219,7 @@ rcu_head_after_call_rcu(struct rcu_head *rhp, rcu_callback_t f)
 extern int rcu_expedited;
 extern int rcu_normal;
 
-DEFINE_LOCK_GUARD_0(rcu,
-	do {
-		rcu_read_lock();
-		/*
-		 * sparse doesn't call the cleanup function,
-		 * so just release immediately and don't track
-		 * the context. We don't need to anyway, since
-		 * the whole point of the guard is to not need
-		 * the explicit unlock.
-		 */
-		__release(RCU);
-	} while (0),
-	rcu_read_unlock())
-
+DEFINE_LOCK_GUARD_0(rcu, rcu_read_lock(), rcu_read_unlock())
 DECLARE_LOCK_GUARD_0_ATTRS(rcu, __acquires_shared(RCU), __releases_shared(RCU))
 
 #endif /* __LINUX_RCUPDATE_H */
-- 
2.52.0.rc1.455.g30608eb744-goog


