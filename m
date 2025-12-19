Return-Path: <linux-wireless+bounces-29975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 990FECD165F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 19:41:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 363CD3019B93
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 18:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48B002E973F;
	Fri, 19 Dec 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="r7Yag90D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3CC28030E;
	Fri, 19 Dec 2025 18:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766169557; cv=none; b=fku8u0G2RijFKdKbJgWyidHlg0JH4fakFAkojf49OvzHLLTEEa3wGoNB3imgVXioWCSju3KZVSmnC5XWWEIpg+lL3vUUR8pAlwFULDhLdSTVy/R9d+gDRsNyICQ6oBy059wWNWqMHWw0GXSfyso41amZvU/HXuSd5JVzxyPehTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766169557; c=relaxed/simple;
	bh=2oCcEiD86R3by/djtBIzSCExwYrw3Sejuf7j0oQ5WLs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F7hXbqm124RGpPPQoBA8y0tQ+IMScF8/eaKs7gVDZh3fwVGQ/g89lFZ4FwCiotSJRd7k0rh9/Z1Zmtp/07aT1xD7Trq5KTSA6Wjhk9z29kKFADmnc6jNyWavidUQv2OpRtRpWWGrKP313qRGNE2D8JcWTOb7GK7eM2TryOqzouk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=r7Yag90D; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dXxC64LYVz1XM0pZ;
	Fri, 19 Dec 2025 18:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766169545; x=1768761546; bh=dgosp44VAu2P7aU4KenxOvJY
	azdnvtt9NxyqcaL3Tns=; b=r7Yag90DdhVFdBZYPtWEBx9cmCCgXFjjEpr00iey
	p+3zXepZk3G3B4Bwu97WCJb1s5MPa26ClqUCvQBDwMVJvuz50WwTPPwUFZe5E46U
	ja5rUuNt4XNe/5D01S3EOF+T3RyTp91P0nuOYG2d6McW7+kHXp4wwJlozgS4PkCd
	qp+p8gQa7mJHDXA26JtCjnOfk8C6CZ67nPnsZoyJqdw/5BjSRx3eJIxixLXL3e4l
	vgETtAqLb8KL5bbR+McXEUlhwtoxeSkETq5HMtJtY0uulq95tLbcxqmBujTNeXEM
	1UW3CESdF+sBn47W7phlV4LPya+8JJCzHNIyZAlMr0OSAg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id lv8AghduxMyN; Fri, 19 Dec 2025 18:39:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dXxBk4GZrz1XM6Jc;
	Fri, 19 Dec 2025 18:38:54 +0000 (UTC)
Message-ID: <97e832b7-04a9-49cb-973a-bf9870c21c2f@acm.org>
Date: Fri, 19 Dec 2025 10:38:53 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/36] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-3-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-3-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:39 AM, Marco Elver wrote:
> +#if defined(WARN_CONTEXT_ANALYSIS)
> +
> +/*
> + * These attributes define new context lock (Clang: capability) types.
> + * Internal only.
> + */

How can macros be "internal only" that are defined in a header file that
will be included by almost all kernel code? Please consider changing
"internal only" into something that is more clear, e.g. "should only be
used in the macro definitions in this header file".

> +/*
> + * The below are used to annotate code being checked. Internal only.
> + */

Same comment here about "internal only".

> +/**
> + * context_lock_struct() - declare or define a context lock struct
> + * @name: struct name
> + *
> + * Helper to declare or define a struct type that is also a context lock.
> + *
> + * .. code-block:: c
> + *
> + *	context_lock_struct(my_handle) {
> + *		int foo;
> + *		long bar;
> + *	};
> + *
> + *	struct some_state {
> + *		...
> + *	};
> + *	// ... declared elsewhere ...
> + *	context_lock_struct(some_state);
> + *
> + * Note: The implementation defines several helper functions that can acquire
> + * and release the context lock.
> + */
> +# define context_lock_struct(name, ...)									\
> +	struct __ctx_lock_type(name) __VA_ARGS__ name;							\
> +	static __always_inline void __acquire_ctx_lock(const struct name *var)				\
> +		__attribute__((overloadable)) __no_context_analysis __acquires_ctx_lock(var) { }	\
> +	static __always_inline void __acquire_shared_ctx_lock(const struct name *var)			\
> +		__attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_lock(var) { } \
> +	static __always_inline bool __try_acquire_ctx_lock(const struct name *var, bool ret)		\
> +		__attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_lock(1, var)	\
> +	{ return ret; }											\
> +	static __always_inline bool __try_acquire_shared_ctx_lock(const struct name *var, bool ret)	\
> +		__attribute__((overloadable)) __no_context_analysis __try_acquires_shared_ctx_lock(1, var) \
> +	{ return ret; }											\
> +	static __always_inline void __release_ctx_lock(const struct name *var)				\
> +		__attribute__((overloadable)) __no_context_analysis __releases_ctx_lock(var) { }	\
> +	static __always_inline void __release_shared_ctx_lock(const struct name *var)			\
> +		__attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_lock(var) { } \
> +	static __always_inline void __assume_ctx_lock(const struct name *var)				\
> +		__attribute__((overloadable)) __assumes_ctx_lock(var) { }				\
> +	static __always_inline void __assume_shared_ctx_lock(const struct name *var)			\
> +		__attribute__((overloadable)) __assumes_shared_ctx_lock(var) { }			\
> +	struct name

I'm concerned that the context_lock_struct() macro will make code harder
to read. Anyone who encounters the context_lock_struct() macro will have
to look up its definition to learn what it does. I propose to split this
macro into two macros:
* One macro that expands into "__ctx_lock_type(name)".
* A second macro that expands into the rest of the above macro.

In other words, instead of having to write 
context_lock_struct(struct_name, { ... }); developers will have to write

struct context_lock_type struct_name {
     ...;
};
context_struct_helper_functions(struct_name);

My opinion is that the alternative that I'm proposing is easier to read.
Additionally, it doesn't break existing tools that support jumping from
the name of a struct to its definition, e.g. ctags and etags.

> +config WARN_CONTEXT_ANALYSIS_ALL
> +	bool "Enable context analysis for all source files"
> +	depends on WARN_CONTEXT_ANALYSIS
> +	depends on EXPERT && !COMPILE_TEST
> +	help
> +	  Enable tree-wide context analysis. This is likely to produce a
> +	  large number of false positives - enable at your own risk.
> +
> +	  If unsure, say N.

Why !COMPILE_TEST?

Thanks,

Bart.

