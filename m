Return-Path: <linux-wireless+bounces-29650-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3AC0CB5C28
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:09:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 26099302BD14
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7AB30BBBF;
	Thu, 11 Dec 2025 12:04:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Cm3yzuQq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB95C2BE7DD;
	Thu, 11 Dec 2025 12:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765454696; cv=none; b=kb7DUC55m61FDK59JzlWWaQNHgRmCrKmv4iTOBtEZVWvmM7cZ2BQjUJsXjCRtJe/N680/NEAHS9F+SNB7yOWD+XLc/yFHS1S2BP86aco0+vHNCTyxN2f6LUW9KDMMH8KzUNtzEpfD9FpmtlNx+/4DT78dd78oDZzZLKTsMKePuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765454696; c=relaxed/simple;
	bh=xYB9CZGFY7AgTnKdWBr89d3ngY1+Ue3cetPJG6t6F4k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P+EEF7MJuAR5GrwfDDW4T/pl6EeC2+R0xR3UKCLYxowc0c3OfFHmdgJTgPH4nx2VLn4PmAKAHmmysaqp4N2jnjt7TG3isphh+RBMkBV1zmWp2g5+/j1dxo8RrYjNG3siAvlz4sKwQfALecLc5l8TMdeIkSGntdXww+1CqyPU1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Cm3yzuQq; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J5QYsGE2XyUV8dMJUaGHOZ/s846nES10yHj06SSwiHE=; b=Cm3yzuQqYooIj2GZtZDWYEC3ZO
	S0fg9hzc4Z19Hv5Bc4P16q2CjNQ573CovUIuUpZEbXu9poIjw8goKrUxsrAu3j7Caix5SEmi3eHJ5
	ty2o3ZeXS3kqUORWQHfUhEXRPllWuKhXfU6FuRy+jNCn3CPiuhwnM6hD6rLf9Bd5pxh4A4qnGsqmd
	YA26rLCiywQY1V7BWRwKwRpg85biCy2lzMbTYkXrqgHkp9M0BmSuJ+nlBxwZvhjzGyyfDW1rDJahM
	onQMIaTpJMWn2CJQspzPC2bN0ZBuwOi8vBCFsSztBk6L098HJ6Am/lBaLXUiYdMTHDu2proPsv+AW
	SRG+MwEw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTfPW-0000000ECYb-0fah;
	Thu, 11 Dec 2025 12:04:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 803F130301A; Thu, 11 Dec 2025 13:04:41 +0100 (CET)
Date: Thu, 11 Dec 2025 13:04:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
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
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
Message-ID: <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120145835.3833031-4-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120145835.3833031-4-elver@google.com>

On Thu, Nov 20, 2025 at 03:49:04PM +0100, Marco Elver wrote:

> +/**
> + * context_guard_struct() - declare or define a context guard struct
> + * @name: struct name
> + *
> + * Helper to declare or define a struct type that is also a context guard.
> + *
> + * .. code-block:: c
> + *
> + *	context_guard_struct(my_handle) {
> + *		int foo;
> + *		long bar;
> + *	};
> + *
> + *	struct some_state {
> + *		...
> + *	};
> + *	// ... declared elsewhere ...
> + *	context_guard_struct(some_state);
> + *
> + * Note: The implementation defines several helper functions that can acquire
> + * and release the context guard.
> + */
> +# define context_guard_struct(name, ...)								\
> +	struct __ctx_guard_type(name) __VA_ARGS__ name;							\
> +	static __always_inline void __acquire_ctx_guard(const struct name *var)				\
> +		__attribute__((overloadable)) __no_context_analysis __acquires_ctx_guard(var) { }	\
> +	static __always_inline void __acquire_shared_ctx_guard(const struct name *var)			\
> +		__attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_guard(var) { } \
> +	static __always_inline bool __try_acquire_ctx_guard(const struct name *var, bool ret)		\
> +		__attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_guard(1, var)	\
> +	{ return ret; }											\
> +	static __always_inline bool __try_acquire_shared_ctx_guard(const struct name *var, bool ret)	\
> +		__attribute__((overloadable)) __no_context_analysis __try_acquires_shared_ctx_guard(1, var) \
> +	{ return ret; }											\
> +	static __always_inline void __release_ctx_guard(const struct name *var)				\
> +		__attribute__((overloadable)) __no_context_analysis __releases_ctx_guard(var) { }	\
> +	static __always_inline void __release_shared_ctx_guard(const struct name *var)			\
> +		__attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_guard(var) { } \
> +	static __always_inline void __assume_ctx_guard(const struct name *var)				\
> +		__attribute__((overloadable)) __assumes_ctx_guard(var) { }				\
> +	static __always_inline void __assume_shared_ctx_guard(const struct name *var)			\
> +		__attribute__((overloadable)) __assumes_shared_ctx_guard(var) { }			\
> +	struct name

-typedef struct {
+context_guard_struct(rwlock) {
        struct rwbase_rt        rwbase;
        atomic_t                readers;
 #ifdef CONFIG_DEBUG_LOCK_ALLOC
        struct lockdep_map      dep_map;
 #endif
-} rwlock_t;
+};
+typedef struct rwlock rwlock_t;


I must say I find the 'guard' naming here somewhat confusing. This is
not a guard, but an actual lock type.

