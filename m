Return-Path: <linux-wireless+bounces-29953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 178E9CD1424
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 18:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 862CF3084DAB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 17:53:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0082934D3AC;
	Fri, 19 Dec 2025 15:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VW1I07NF"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ADD434D4F4
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159221; cv=none; b=cISZgUAZS5um491hGM9IBnLUSa8to6XCwoQY8DBpY3VhyMLnlAXs5kiA78uwm0FouAF8/D6CeJ4rZ4Pwx3p1uYbg0FG5ZlnCLOlDfNR9qvHrd8j8biCy8f+JiBGh5it52d98uEnBEVcowBsbM3n9MmneyNgXphmvDQTBNroF7xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159221; c=relaxed/simple;
	bh=jL0QM1v99QEoViO9S3HcGBHIkHFuA8KQrDf2LXqrRBg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=au7QCjntjcTmG/T+CP58jsTiWFDOxVvZabCe578YhRPxXtvQp4wEC4sXI+GqeHnBXLDQJvioXo6FtxEzKLaJnQ67++t/OkwLHM9advZ/fwOionTFr6n6pZuxKLZHOIVYbfxcCHCJvrG8PKpVviRSrWdb2kPbke1DlCuC5pSc6aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VW1I07NF; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4775e00b16fso10525715e9.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159217; x=1766764017; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BXcHXIDfWoSkrk6mEFbnYEvAXHgRRlXY75uZgyD6jWc=;
        b=VW1I07NFqIJH2aeycnI90/1uxYV8fkYm6qn8ycshrbEXVh5mKUReQRhUfXBveFeEXl
         9pOjscY0J3OyE5aQfpaJB1y9oEvziub9cLrtMrE5T15wkdFzRbcb/5SXm6nkayOkrvVP
         12bpKkYFAz/KcXPZbvga5250bwZBruYSuX6zg+WDDSRc1FkNnsxE7Fyjf9jefzYDxdjs
         83QDtDiWfT6tX/FHz7s8AWHUSb5PRKphsyYcBoZYXWfjsOmMGtSSj3Udkx1GhLNUtjwK
         U8RGLx7nkecnMvqkwwGmgb8BeEftLg6sy0RfFs9FRf/rdctL1Bt0BQq1zBfvAP8uC/J4
         ncBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159217; x=1766764017;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BXcHXIDfWoSkrk6mEFbnYEvAXHgRRlXY75uZgyD6jWc=;
        b=LDhkr6kIXvD9VQl6JU/TPfQ+koRco3VNoCIrVztzeKo6E7vHCuF2GxSuNaClM7Z5Mv
         pFBR56M0p7qAweZPcyLNndCh1SK2N70JY3j/OyOl/2ItG5kcyOd+4jPYQkxuMwpxMxUC
         MtCIXz9/v8ijWQl6SrU2XmHYkMBPXNakBRZs+hLAW83lXZ1bS9P2OBEj9JSaNGycPcdv
         zMwPfnJXClJGuBkPoFT0hRsR7mmdaT57gJ4nQApLCZ9RHEivuSeEqCKF+S2NAWUFrJtQ
         Yna2uvB04scXTi4/xfNVg1f80cib5Kfu/uQiqcnwWdgEJMLszbJukfTXRFzJlkgEgKd7
         9dYQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0H5mkzz3HfJi6QhIzwM5c1Q4SlskJLEEPymDdszldMA76NDEd5g3xvyDGbMhmWFHmGEdm7lDYSJlVihC1oQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI1uGh0KYveQfA7BXuqeoZJg6ZsyK3pP7SwIqq0Zhedv3P80Nz
	OkmbJu3AxuNqxGXmfy1OAi5CkdOB0jvDk+nPA8OOdBPRKbYixPWhwjLw5ngVj1wrFZFaZuLGDdQ
	lug==
X-Google-Smtp-Source: AGHT+IHyKiIB7A3/4NS3dgdSOn3IONvOE4PwqBUh1HTTKAWUaRZZqyIHVFzTOOWTZuodACVR6hwE9Va7/g==
X-Received: from wmco28.prod.google.com ([2002:a05:600c:a31c:b0:477:afa:d217])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:45cf:b0:47a:7fdd:2906
 with SMTP id 5b1f17b1804b1-47d1954a550mr28322755e9.12.1766159217354; Fri, 19
 Dec 2025 07:46:57 -0800 (PST)
Date: Fri, 19 Dec 2025 16:40:12 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-24-elver@google.com>
Subject: [PATCH v5 23/36] compiler-context-analysis: Remove Sparse support
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
v5:
* Rename "context guard" -> "context lock".

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
index 9ad800e27692..fccd6d68158e 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -262,57 +262,32 @@ static inline void _context_unsafe_alias(void **p) { }
 	extern const struct __ctx_lock_##ctx *name
 
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
  * __must_hold() - function attribute, caller must hold exclusive context lock
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * lock instance @x exclusively.
+ * lock instance(s) exclusively.
  */
-# define __must_hold(x)		__requires_ctx_lock(x)
+#define __must_hold(...)	__requires_ctx_lock(__VA_ARGS__)
 
 /**
  * __must_not_hold() - function attribute, caller must not hold context lock
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must not hold the given context
- * lock instance @x.
+ * lock instance(s).
  */
-# define __must_not_hold(x)	__excludes_ctx_lock(x)
+#define __must_not_hold(...)	__excludes_ctx_lock(__VA_ARGS__)
 
 /**
  * __acquires() - function attribute, function acquires context lock exclusively
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function acquires the given context
- * lock instance @x exclusively, but does not release it.
+ * lock instance(s) exclusively, but does not release them.
  */
-# define __acquires(x)		__acquires_ctx_lock(x)
+#define __acquires(...)		__acquires_ctx_lock(__VA_ARGS__)
 
 /*
  * Clang's analysis does not care precisely about the value, only that it is
@@ -339,17 +314,16 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
+#define __cond_acquires(ret, x) __cond_acquires_impl_##ret(x)
 
 /**
  * __releases() - function attribute, function releases a context lock exclusively
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * lock instance @x exclusively. The associated context must be active on
+ * lock instance(s) exclusively. The associated context(s) must be active on
  * entry.
  */
-# define __releases(x)		__releases_ctx_lock(x)
+#define __releases(...)		__releases_ctx_lock(__VA_ARGS__)
 
 /**
  * __acquire() - function to acquire context lock exclusively
@@ -357,7 +331,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that acquires the given context lock instance @x exclusively.
  */
-# define __acquire(x)		__acquire_ctx_lock(x)
+#define __acquire(x)		__acquire_ctx_lock(x)
 
 /**
  * __release() - function to release context lock exclusively
@@ -365,7 +339,7 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  * No-op function that releases the given context lock instance @x.
  */
-# define __release(x)		__release_ctx_lock(x)
+#define __release(x)		__release_ctx_lock(x)
 
 /**
  * __cond_lock() - function that conditionally acquires a context lock
@@ -383,25 +357,23 @@ static inline void _context_unsafe_alias(void **p) { }
  *
  *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
  */
-# define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
+#define __cond_lock(x, c)	__try_acquire_ctx_lock(x, c)
 
 /**
  * __must_hold_shared() - function attribute, caller must hold shared context lock
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the caller must hold the given context
- * lock instance @x with shared access.
+ * lock instance(s) with shared access.
  */
-# define __must_hold_shared(x)	__requires_shared_ctx_lock(x)
+#define __must_hold_shared(...)	__requires_shared_ctx_lock(__VA_ARGS__)
 
 /**
  * __acquires_shared() - function attribute, function acquires context lock shared
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function acquires the given
- * context lock instance @x with shared access, but does not release it.
+ * context lock instance(s) with shared access, but does not release them.
  */
-# define __acquires_shared(x)	__acquires_shared_ctx_lock(x)
+#define __acquires_shared(...)	__acquires_shared_ctx_lock(__VA_ARGS__)
 
 /**
  * __cond_acquires_shared() - function attribute, function conditionally
@@ -410,23 +382,22 @@ static inline void _context_unsafe_alias(void **p) { }
  * @x: context lock instance pointer
  *
  * Function attribute declaring that the function conditionally acquires the
- * given context lock instance @x with shared access, but does not release it. The
- * function return value @ret denotes when the context lock is acquired.
+ * given context lock instance @x with shared access, but does not release it.
+ * The function return value @ret denotes when the context lock is acquired.
  *
  * @ret may be one of: true, false, nonzero, 0, nonnull, NULL.
  */
-# define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _shared)
+#define __cond_acquires_shared(ret, x) __cond_acquires_impl_##ret(x, _shared)
 
 /**
  * __releases_shared() - function attribute, function releases a
  *                       context lock shared
- * @x: context lock instance pointer
  *
  * Function attribute declaring that the function releases the given context
- * lock instance @x with shared access. The associated context must be active
- * on entry.
+ * lock instance(s) with shared access. The associated context(s) must be
+ * active on entry.
  */
-# define __releases_shared(x)	__releases_shared_ctx_lock(x)
+#define __releases_shared(...)	__releases_shared_ctx_lock(__VA_ARGS__)
 
 /**
  * __acquire_shared() - function to acquire context lock shared
@@ -435,7 +406,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that acquires the given context lock instance @x with shared
  * access.
  */
-# define __acquire_shared(x)	__acquire_shared_ctx_lock(x)
+#define __acquire_shared(x)	__acquire_shared_ctx_lock(x)
 
 /**
  * __release_shared() - function to release context lock shared
@@ -444,7 +415,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * No-op function that releases the given context lock instance @x with shared
  * access.
  */
-# define __release_shared(x)	__release_shared_ctx_lock(x)
+#define __release_shared(x)	__release_shared_ctx_lock(x)
 
 /**
  * __cond_lock_shared() - function that conditionally acquires a context lock shared
@@ -457,9 +428,7 @@ static inline void _context_unsafe_alias(void **p) { }
  * shared access, if the boolean expression @c is true. The result of @c is the
  * return value.
  */
-# define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
-
-#endif /* __CHECKER__ */
+#define __cond_lock_shared(x, c) __try_acquire_shared_ctx_lock(x, c)
 
 /**
  * __acquire_ret() - helper to acquire context lock of return value
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 50e63eade019..d828a4673441 100644
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
2.52.0.322.g1dd061c0dc-goog


