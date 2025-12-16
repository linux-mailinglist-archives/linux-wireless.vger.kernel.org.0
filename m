Return-Path: <linux-wireless+bounces-29816-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBCBCCC4726
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 17:53:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D87430DC50A
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 16:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0718359F8F;
	Tue, 16 Dec 2025 15:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Lixfu83f"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8857359711
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 15:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765900681; cv=none; b=IifOwLpMigIjPl3ov+h/0EECF/wz/hUGTqw9QcWgbn53iMKlWJc07qkWzNEy76FQCsEPDo02HYRxFcHuNCtnS6+m0eDLovV3j6dII+1DZRNR696V848oTStWFHaKSufPvqLm3OCNrNkvYLmUSoTkBR+CV6a5wBZeYPZzRQguJoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765900681; c=relaxed/simple;
	bh=chQZ2LVEnswr/hULOSSa1bLHOWkGwRkKoPQ4wPGnFNQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kXYg+91f5cc6b9gdBENr06r35xIySjY6BUcG+uuuxqqsxBe3yIHu+R7TT/d0WqL5aaImVUZ833Zf5wBSJaolFykjCoXuaDaxWKS8dZCtz/3B2kCszMFK7y7Su0kEp4bsi9a9HpV9GGqETmG3xHkb+VMzHc63uc69mDeT7Nj5wbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Lixfu83f; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4775e891b5eso21108505e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 07:57:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765900677; x=1766505477; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4T6EEvpkYB8O/dSoH4wvSyTHiJOCpYvJH+j1ElyVX1A=;
        b=Lixfu83faqKg5cZB7qOjlcvqZ8RqFIvBvPrPpJ2OJCgE+gnKQeRBheaVBk7R2x+jrc
         5bJnR0P6mfiqrMpPfUZ+sUAzl9qedWdBRBt91dVzIivP6/QBJZD9DupVhjzdyDW02DAD
         sagbx8HIKqSBD25FVgImQ7PRa2KiIZ4zy5vW/5W1iIw/LfRDLBHzDbjJLK0ytRuktFET
         ga409XGruEPrRPr2hvObEdNfXME/u40y9xDMAAIk7yGLSBlzpWExHtsMlcXh7kictvFM
         8bZPEl7T7Ep4dH21dardjwDprTtgs+1HK8hCEfnYS7/CwAygQ0CSRhy5SWq/c8XYxULE
         QKCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765900677; x=1766505477;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4T6EEvpkYB8O/dSoH4wvSyTHiJOCpYvJH+j1ElyVX1A=;
        b=PwV49hapOtquiSchfMwjnNXIcnC1xH22XdhPYGKWl5vbyWj7xjrZtXqcMPl/XvDZCx
         mxPJ7ek/Y346QWZn4pNm6Xh3uP4MpawArV+SdILiNgYBlx6ckW/NZPFPEyNHFSRr7dO0
         gKZmhBd0dl7BBkd9JcjanpzRic14aEtn5KR3tOWrEhkro+TAZCU2cFTD/eYq+p7wl87L
         ttoJ/hejljQKC1sQtNJk6nEjzKSI6NlI0h5WdGa7cS29RWAt5yyMmJEXFUmByps7Leei
         AZBFlOWB2duH9xymWZJuUhvW/83ia0U1cfj25XmH+s0LmK1QA38ZZx5Ov+EjwNjw1BCT
         xrCA==
X-Forwarded-Encrypted: i=1; AJvYcCU9pocLf9lr5TlfjyzLQs0rSbRkwH3IF+QKyzko/kiqavMB+b3mF7sJ16EHbDaNsBkNtlrt8sG9Bc+25yJPGg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxTUL/T2K3DMaGXAWIF7s5mTA0q4K20f4zqx/ZKcXV/uRETWVqX
	WrVPQZ6IkD13YlsAi0wXcqEt1Z8pQoeBG3ghXfDj1FETbzun8q3LG89RwI7JMnBwgw==
X-Gm-Gg: AY/fxX4qy0xx2ogfZj4dCeX4eGz2NqYVvwEC+Tphpb1CQ0d+c/A+HttY5CNAsfADpqH
	0uB9po9tOuvqymg2ohV6QgyTtsSmx1A4kOrNCyEJL/nlrHwWdrqUWr20mW5pOdSyTa1HMEh5WG6
	/wpUpLOjRByPYz1lW1mT215QghH9o1rmttseb9tRkWn9MkGfhEGhvBHccFccukwsfwyzucwjsAB
	fRqmoDEQg9ly3dl0L4Bu0fCc77Bzs3B3fWEEqCsF6FMmNE5c7uKTD2i/H+HLgdEyIVtS6tyfUWY
	1bBykn7CMqSpGFoiuXuDMA5SECdPgCiGpc/Sfb0Je0G2SCAU9Imu5JTFhp70ssRxhBfkaVHrJ03
	4uTW+5gSOG8G2gmMx9b5JESTBoPnI1S3cZm1sJltUsXwkCfliaOZKf7QBllU+cvOrRd7t+wGqhn
	Ro6QDwNmYkc98UjqQsuz1LrrxtYhcEucN+BSaO9b+VRmXWZ2kv
X-Google-Smtp-Source: AGHT+IHDdQVZRbKnzvpABseF1CD6bLmsX8k69Taj+EhWj/QwI3tX5DeGEoYL60/CFL6IF5/VTsQYZw==
X-Received: by 2002:a05:600c:1c1a:b0:475:de12:d3b5 with SMTP id 5b1f17b1804b1-47a8f91601bmr141242195e9.34.1765900676692;
        Tue, 16 Dec 2025 07:57:56 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:ea4c:b2a8:24a4:9ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f7994b58sm18141460f8f.22.2025.12.16.07.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 07:57:55 -0800 (PST)
Date: Tue, 16 Dec 2025 16:57:49 +0100
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
Message-ID: <aUGBff8Oko5O8EsP@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
 <aUE77hgJa58waFOy@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUE77hgJa58waFOy@elver.google.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Dec 16, 2025 at 12:01PM +0100, Marco Elver wrote:
> On Mon, Dec 15, 2025 at 04:53PM +0100, Marco Elver wrote:
> [..]
> > > > So I think as is, we can start. But I really do want the cleanup thing
> > > > sorted, even if just with that __release_on_cleanup mashup or so.
> > >
> > > Working on rebasing this to v6.19-rc1 and saw this new scoped seqlock
> > > abstraction. For that one I was able to make it work like I thought we
> > > could (below). Some awkwardness is required to make it work in
> > > for-loops, which only let you define variables with the same type.
> > >
> > > For <linux/cleanup.h> it needs some more thought due to extra levels of
> > > indirection.
> > 
> > For cleanup.h, the problem is that to instantiate we use
> > "guard(class)(args..)". If it had been designed as "guard(class,
> > args...)", i.e. just use __VA_ARGS__ explicitly instead of the
> > implicit 'args...', it might have been possible to add a second
> > cleanup variable to do the same (with some additional magic to extract
> > the first arg if one exists). Unfortunately, the use of the current
> > guard()() idiom has become so pervasive that this is a bigger
> > refactor. I'm going to leave cleanup.h as-is for now, if we think we
> > want to give this a go in the current state.
> 
> Alright, this can work, but it's not that ergonomic as I'd hoped (see
> below): we can redefine class_<name>_constructor to append another
> cleanup variable. With enough documentation, this might be workable.

Below is the preview of the complete changes to make the lock guards
work properly.

Thanks,
-- Marco

------ >8 ------

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2f998bb42c4c..9fe3b0f816c6 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -516,9 +516,42 @@ static __always_inline class_##_name##_t class_##_name##_constructor(void) \
 static inline class_##_name##_t class_##_name##_constructor(void) _lock;\
 static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
 
+/*
+ * To support Context Analysis, we need to allow the compiler to see the
+ * acquisition and release of the context lock. However, the "cleanup" helpers
+ * wrap the lock in a struct passed through seperate helper functions, which
+ * hides the lock alias from the compiler (no inter-procedural analysis).
+ *
+ * To make it work, we introduce an explicit alias to the context lock instance
+ * that is "cleaned" up with a separate cleanup helper. This helper is a dummy
+ * function that does nothing at runtime, but has the "_unlock" attribute to
+ * tell the compiler what happens at the end of the scope.
+ *
+ * To generalize the pattern, the WITH_LOCK_GUARD_1_ATTRS() macro should be used
+ * to redefine the constructor, which then also creates the alias variable with
+ * the right "cleanup" attribute, *after* DECLARE_LOCK_GUARD_1_ATTRS() has been
+ * used.
+ *
+ * Example usage:
+ *
+ *   DECLARE_LOCK_GUARD_1_ATTRS(mutex, __acquires(_T), __releases(*(struct mutex **)_T))
+ *   #define class_mutex_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+ *
+ * Note: To support the for-loop based scoped helpers, the auxiliary variable
+ * must be a pointer to the "class" type because it is defined in the same
+ * statement as the guard variable. However, we initialize it with the lock
+ * pointer (despite the type mismatch, the compiler's alias analysis still works
+ * as expected). The "_unlock" attribute receives a pointer to the auxiliary
+ * variable (a double pointer to the class type), and must be cast and
+ * dereferenced appropriately.
+ */
 #define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
 static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
-static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+static __always_inline void __class_##_name##_cleanup_ctx(class_##_name##_t **_T) \
+	__no_context_analysis _unlock { }
+#define WITH_LOCK_GUARD_1_ATTRS(_name, _T)				\
+	class_##_name##_constructor(_T),				\
+	*__UNIQUE_ID(unlock) __cleanup(__class_##_name##_cleanup_ctx) = (void *)(_T)
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
 __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
diff --git a/include/linux/local_lock.h b/include/linux/local_lock.h
index bedcbb33b928..99c06e499375 100644
--- a/include/linux/local_lock.h
+++ b/include/linux/local_lock.h
@@ -104,9 +104,13 @@ DEFINE_LOCK_GUARD_1(local_lock_nested_bh, local_lock_t __percpu,
 		    local_lock_nested_bh(_T->lock),
 		    local_unlock_nested_bh(_T->lock))
 
-DECLARE_LOCK_GUARD_1_ATTRS(local_lock, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irq, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irqsave, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(local_lock_nested_bh, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock, __acquires(_T), __releases(*(local_lock_t __percpu **)_T))
+#define class_local_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irq, __acquires(_T), __releases(*(local_lock_t __percpu **)_T))
+#define class_local_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock_irq, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_irqsave, __acquires(_T), __releases(*(local_lock_t __percpu **)_T))
+#define class_local_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock_irqsave, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(local_lock_nested_bh, __acquires(_T), __releases(*(local_lock_t __percpu **)_T))
+#define class_local_lock_nested_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(local_lock_nested_bh, _T)
 
 #endif
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8ed48d40007b..06c3f947ea49 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -255,9 +255,12 @@ DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(_T->
 DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _RET == 0)
 
-DECLARE_LOCK_GUARD_1_ATTRS(mutex, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_try, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_constructor(_T)	WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+#define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _T)
+#define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr, _T)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 
diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 0e75e26e8813..8da14a08a4e1 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -262,17 +262,23 @@ DEFINE_LOCK_GUARD_1(rwsem_read, struct rw_semaphore, down_read(_T->lock), up_rea
 DEFINE_LOCK_GUARD_1_COND(rwsem_read, _try, down_read_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(rwsem_read, _intr, down_read_interruptible(_T->lock), _RET == 0)
 
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_try, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_intr, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_try, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_read_intr, __acquires_shared(_T), __releases_shared(*(struct rw_semaphore **)_T))
+#define class_rwsem_read_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_read_intr, _T)
 
 DEFINE_LOCK_GUARD_1(rwsem_write, struct rw_semaphore, down_write(_T->lock), up_write(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(rwsem_write, _try, down_write_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(rwsem_write, _kill, down_write_killable(_T->lock), _RET == 0)
 
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_try, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_kill, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_try, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write_try, _T)
+DECLARE_LOCK_GUARD_1_ATTRS(rwsem_write_kill, __acquires(_T), __releases(*(struct rw_semaphore **)_T))
+#define class_rwsem_write_kill_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rwsem_write_kill, _T)
 
 /*
  * downgrade write lock to read lock
diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index 397f4753d10a..41ed884cffc9 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -226,6 +226,7 @@ static inline void task_unlock(struct task_struct *p)
 }
 
 DEFINE_LOCK_GUARD_1(task_lock, struct task_struct, task_lock(_T->lock), task_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(task_lock, __assumes_ctx_lock(_T->alloc_lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(task_lock, __acquires(&_T->alloc_lock), __releases(&(*(struct task_struct **)_T)->alloc_lock))
+#define class_task_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(task_lock, _T)
 
 #endif /* _LINUX_SCHED_TASK_H */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 3a45b08ced43..396b8c5d6c1b 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -537,109 +537,132 @@ void free_bucket_spinlocks(spinlock_t *locks);
 DEFINE_LOCK_GUARD_1(raw_spinlock, raw_spinlock_t,
 		    raw_spin_lock(_T->lock),
 		    raw_spin_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock, _T)
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock, _try, raw_spin_trylock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_try, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_nested, raw_spinlock_t,
 		    raw_spin_lock_nested(_T->lock, SINGLE_DEPTH_NESTING),
 		    raw_spin_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_nested_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_nested, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irq, raw_spinlock_t,
 		    raw_spin_lock_irq(_T->lock),
 		    raw_spin_unlock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irq, _T)
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irq, _try, raw_spin_trylock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irq_try, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_bh, raw_spinlock_t,
 		    raw_spin_lock_bh(_T->lock),
 		    raw_spin_unlock_bh(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_bh, _T)
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_bh, _try, raw_spin_trylock_bh(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_bh_try, _T)
 
 DEFINE_LOCK_GUARD_1(raw_spinlock_irqsave, raw_spinlock_t,
 		    raw_spin_lock_irqsave(_T->lock, _T->flags),
 		    raw_spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave, _T)
 
 DEFINE_LOCK_GUARD_1_COND(raw_spinlock_irqsave, _try,
 			 raw_spin_trylock_irqsave(_T->lock, _T->flags))
-DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, __acquires(_T), __releases(*(raw_spinlock_t **)_T))
+#define class_raw_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(raw_spinlock_irqsave_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock, spinlock_t,
 		    spin_lock(_T->lock),
 		    spin_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock, _try, spin_trylock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_try, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock_irq, spinlock_t,
 		    spin_lock_irq(_T->lock),
 		    spin_unlock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irq, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irq, _try,
 			 spin_trylock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irq_try, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_irq_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irq_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock_bh, spinlock_t,
 		    spin_lock_bh(_T->lock),
 		    spin_unlock_bh(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_bh_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_bh, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_bh, _try,
 			 spin_trylock_bh(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_bh_try, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_bh_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_bh_try, _T)
 
 DEFINE_LOCK_GUARD_1(spinlock_irqsave, spinlock_t,
 		    spin_lock_irqsave(_T->lock, _T->flags),
 		    spin_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irqsave, _T)
 
 DEFINE_LOCK_GUARD_1_COND(spinlock_irqsave, _try,
 			 spin_trylock_irqsave(_T->lock, _T->flags))
-DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, __acquires(_T), __releases(*(spinlock_t **)_T))
+#define class_spinlock_irqsave_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(spinlock_irqsave_try, _T)
 
 DEFINE_LOCK_GUARD_1(read_lock, rwlock_t,
 		    read_lock(_T->lock),
 		    read_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(read_lock, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_read_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read_lock, _T)
 
 DEFINE_LOCK_GUARD_1(read_lock_irq, rwlock_t,
 		    read_lock_irq(_T->lock),
 		    read_unlock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irq, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irq, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_read_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read_lock_irq, _T)
 
 DEFINE_LOCK_GUARD_1(read_lock_irqsave, rwlock_t,
 		    read_lock_irqsave(_T->lock, _T->flags),
 		    read_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
-DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irqsave, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(read_lock_irqsave, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_read_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(read_lock_irqsave, _T)
 
 DEFINE_LOCK_GUARD_1(write_lock, rwlock_t,
 		    write_lock(_T->lock),
 		    write_unlock(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(write_lock, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_write_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(write_lock, _T)
 
 DEFINE_LOCK_GUARD_1(write_lock_irq, rwlock_t,
 		    write_lock_irq(_T->lock),
 		    write_unlock_irq(_T->lock))
-DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irq, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irq, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_write_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(write_lock_irq, _T)
 
 DEFINE_LOCK_GUARD_1(write_lock_irqsave, rwlock_t,
 		    write_lock_irqsave(_T->lock, _T->flags),
 		    write_unlock_irqrestore(_T->lock, _T->flags),
 		    unsigned long flags)
-DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irqsave, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(write_lock_irqsave, __acquires(_T), __releases(*(rwlock_t **)_T))
+#define class_write_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(write_lock_irqsave, _T)
 
 #undef __LINUX_INSIDE_SPINLOCK_H
 #endif /* __LINUX_SPINLOCK_H */
diff --git a/include/linux/srcu.h b/include/linux/srcu.h
index 88f01d6fded8..bb44a0bd7696 100644
--- a/include/linux/srcu.h
+++ b/include/linux/srcu.h
@@ -621,16 +621,21 @@ DEFINE_LOCK_GUARD_1(srcu, struct srcu_struct,
 		    _T->idx = srcu_read_lock(_T->lock),
 		    srcu_read_unlock(_T->lock, _T->idx),
 		    int idx)
-DECLARE_LOCK_GUARD_1_ATTRS(srcu, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
+#define class_srcu_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu, _T)
 
 DEFINE_LOCK_GUARD_1(srcu_fast, struct srcu_struct,
 		    _T->scp = srcu_read_lock_fast(_T->lock),
 		    srcu_read_unlock_fast(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
+#define class_srcu_fast_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast, _T)
 
 DEFINE_LOCK_GUARD_1(srcu_fast_notrace, struct srcu_struct,
 		    _T->scp = srcu_read_lock_fast_notrace(_T->lock),
 		    srcu_read_unlock_fast_notrace(_T->lock, _T->scp),
 		    struct srcu_ctr __percpu *scp)
+DECLARE_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, __acquires_shared(_T), __releases_shared(*(struct srcu_struct **)_T))
+#define class_srcu_fast_notrace_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(srcu_fast_notrace, _T)
 
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index fab6a19dda02..7c57a6d2f847 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1874,7 +1874,8 @@ DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),
 		    struct rq *rq; struct rq_flags rf)
-DECLARE_LOCK_GUARD_1_ATTRS(task_rq_lock, __assumes_ctx_lock(_T->pi_lock), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(task_rq_lock, __acquires(_T->pi_lock), __releases((*(struct task_struct **)_T)->pi_lock))
+#define class_task_rq_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(task_rq_lock, _T)
 
 DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
 		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
@@ -1928,21 +1929,24 @@ DEFINE_LOCK_GUARD_1(rq_lock, struct rq,
 		    rq_unlock(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-DECLARE_LOCK_GUARD_1_ATTRS(rq_lock, __assumes_ctx_lock(__rq_lockp(_T)), /* */);
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock, __acquires(__rq_lockp(_T)), __releases(__rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_lock, _T)
 
 DEFINE_LOCK_GUARD_1(rq_lock_irq, struct rq,
 		    rq_lock_irq(_T->lock, &_T->rf),
 		    rq_unlock_irq(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irq, __assumes_ctx_lock(__rq_lockp(_T)), /* */);
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irq, __acquires(__rq_lockp(_T)), __releases(__rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_irq_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_lock_irq, _T)
 
 DEFINE_LOCK_GUARD_1(rq_lock_irqsave, struct rq,
 		    rq_lock_irqsave(_T->lock, &_T->rf),
 		    rq_unlock_irqrestore(_T->lock, &_T->rf),
 		    struct rq_flags rf)
 
-DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irqsave, __assumes_ctx_lock(__rq_lockp(_T)), /* */);
+DECLARE_LOCK_GUARD_1_ATTRS(rq_lock_irqsave, __acquires(__rq_lockp(_T)), __releases(__rq_lockp(*(struct rq **)_T)));
+#define class_rq_lock_irqsave_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(rq_lock_irqsave, _T)
 
 #define this_rq_lock_irq(...) __acquire_ret(_this_rq_lock_irq(__VA_ARGS__), __rq_lockp(__ret))
 static inline struct rq *_this_rq_lock_irq(struct rq_flags *rf) __acquires_ret
@@ -3075,10 +3079,17 @@ static inline class_##name##_t class_##name##_constructor(type *lock, type *lock
 	__no_context_analysis								\
 { class_##name##_t _t = { .lock = lock, .lock2 = lock2 }, *_T = &_t;			\
   _lock; return _t; }
-#define DECLARE_LOCK_GUARD_2_ATTRS(_name, _lock, _unlock)				\
+#define DECLARE_LOCK_GUARD_2_ATTRS(_name, _lock, _unlock1, _unlock2)			\
 static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T1,	\
 							    lock_##_name##_t *_T2) _lock; \
-static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock
+static __always_inline void __class_##_name##_cleanup_ctx1(class_##_name##_t **_T1)	\
+	__no_context_analysis _unlock1 { }						\
+static __always_inline void __class_##_name##_cleanup_ctx2(class_##_name##_t **_T2)	\
+	__no_context_analysis _unlock2 { }
+#define WITH_LOCK_GUARD_2_ATTRS(_name, _T1, _T2)					\
+	class_##_name##_constructor(_T),						\
+	*__UNIQUE_ID(unlock1) __cleanup(__class_##_name##_cleanup_ctx1) = (void *)(_T1),\
+	*__UNIQUE_ID(unlock2) __cleanup(__class_##_name##_cleanup_ctx2) = (void *)(_T2)
 
 static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
 {
@@ -3229,7 +3240,12 @@ DEFINE_LOCK_GUARD_2(double_raw_spinlock, raw_spinlock_t,
 		    double_raw_lock(_T->lock, _T->lock2),
 		    double_raw_unlock(_T->lock, _T->lock2))
 
-DECLARE_LOCK_GUARD_2_ATTRS(double_raw_spinlock, __assumes_ctx_lock(_T1) __assumes_ctx_lock(_T2), /* */);
+DECLARE_LOCK_GUARD_2_ATTRS(double_raw_spinlock,
+			   __acquires(_T1, _T2),
+			   __releases(*(raw_spinlock_t **)_T1),
+			   __releases(*(raw_spinlock_t **)_T2));
+#define class_double_raw_spinlock_constructor(_T1, _T2) \
+	WITH_LOCK_GUARD_2_ATTRS(double_raw_spinlock, _T1, _T2)
 
 /*
  * double_rq_unlock - safely unlock two runqueues
diff --git a/lib/test_context-analysis.c b/lib/test_context-analysis.c
index 3f72b1ab2300..1c5a381461fc 100644
--- a/lib/test_context-analysis.c
+++ b/lib/test_context-analysis.c
@@ -459,8 +459,9 @@ static void __used test_srcu(struct test_srcu_data *d)
 
 static void __used test_srcu_guard(struct test_srcu_data *d)
 {
-	guard(srcu)(&d->srcu);
-	(void)srcu_dereference(d->data, &d->srcu);
+	{ guard(srcu)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
+	{ guard(srcu_fast)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
+	{ guard(srcu_fast_notrace)(&d->srcu); (void)srcu_dereference(d->data, &d->srcu); }
 }
 
 struct test_local_lock_data {

