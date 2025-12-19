Return-Path: <linux-wireless+bounces-29983-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 696DFCD1BFE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:27:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D7A030726F5
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FF933C193;
	Fri, 19 Dec 2025 20:26:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="3LHIpw+i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E808531C58E;
	Fri, 19 Dec 2025 20:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766175998; cv=none; b=CIU8GQexgf6mJigph1WECom9U+FIzVM+ivr9Op8dcNFFU2dZbBKH6LD09azp7yn2DDurdYaFDMEbymQ1yL+mKOR9IPSgajGv9Cp+U50VX4rm9geMsJmIVJOUpnSnvg4VU6Ma34zrG9KLh6CGUHPeGu6vGyyJp1PBitGLkud0C0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766175998; c=relaxed/simple;
	bh=t91VKbgXjHTNXWGI0hk6vcqHhU0kzFjqniaqjOhoFeg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOetJGYuqo7d9PLWBLqa+x19e5WjnfO9ymvjfDFjsorbUloJ7QeJ4ghWHgBcAYo1AwKGxWHKFORgaOjwl6e53MPYNTD4Uo9CODTZKgtPK3iiTsxKm9WFKxJw+ytWwYtCGqTGnMGrSmcdQU3WGq2Anm7vmtb5u8v16Wm2Et7YP6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=3LHIpw+i; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dXzb00Dlzz1XM0pZ;
	Fri, 19 Dec 2025 20:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766175988; x=1768767989; bh=+XIWCwsoEOSiUB9cSDM01ohK
	HVap8EzItAr4kGei6l0=; b=3LHIpw+ieGDbEleAlfBlytRlkHzz0FuNkyXKj3yU
	S32iMbGcs0xQwrQ96fRo/sfT2B1xWjxWBl4Zmwsh3C+nrtdKA6Xed25MPdOCf9cm
	OqPTEBPUhtk0GS4PDhB/osqX2tyQ5qlnUBv7p0VyAR6hSFuFmB0OawSv0O47US5/
	JVEkmMhGnXcUDadT9IfMciHirW0f53kX6OuysmpCmU7SzmEVCZCFZ5kBWMSaeAD5
	ifMcPAA3c5cPVUXL08MT0F8lNI15xLyN9g+ZI4CeiJTFZ9V40mxi28nG+Y2Qlfgn
	U/PZ4Dn7NZgRHwASo68yhekJGP/2bVFKJP5Y3DR1pjapoQ==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qiEhQEwhfLs6; Fri, 19 Dec 2025 20:26:28 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dXzZd0R6zz1XM6Jk;
	Fri, 19 Dec 2025 20:26:16 +0000 (UTC)
Message-ID: <17723ae6-9611-4731-905c-60dab9fb7102@acm.org>
Date: Fri, 19 Dec 2025 12:26:16 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
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
 <20251219154418.3592607-9-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-9-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:39 AM, Marco Elver wrote:
> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);

Given the "one change per patch" rule, shouldn't the annotation fixes
for rwlock operations be moved into a separate patch?

> -typedef struct {
> +context_lock_struct(rwlock) {
>   	arch_rwlock_t raw_lock;
>   #ifdef CONFIG_DEBUG_SPINLOCK
>   	unsigned int magic, owner_cpu;
> @@ -31,7 +31,8 @@ typedef struct {
>   #ifdef CONFIG_DEBUG_LOCK_ALLOC
>   	struct lockdep_map dep_map;
>   #endif
> -} rwlock_t;
> +};
> +typedef struct rwlock rwlock_t;

This change introduces a new globally visible "struct rwlock". Although
I haven't found any existing "struct rwlock" definitions, maybe it's a
good idea to use a more unique name instead.

> diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
> index 819aeba1c87e..018f5aabc1be 100644
> --- a/include/linux/spinlock_api_up.h
> +++ b/include/linux/spinlock_api_up.h
> @@ -24,68 +24,77 @@
>    * flags straight, to suppress compiler warnings of unused lock
>    * variables, and to add the proper checker annotations:
>    */
> -#define ___LOCK(lock) \
> -  do { __acquire(lock); (void)(lock); } while (0)
> +#define ___LOCK_void(lock) \
> +  do { (void)(lock); } while (0)

Instead of introducing a new macro ___LOCK_void(), please expand this
macro where it is used ((void)(lock)). I think this will make the code
in this header file easier to read.
    > -#define __LOCK(lock) \
> -  do { preempt_disable(); ___LOCK(lock); } while (0)
> +#define ___LOCK_(lock) \
> +  do { __acquire(lock); ___LOCK_void(lock); } while (0)

Is the macro ___LOCK_() used anywhere? If not, can it be left out?

> -#define __LOCK_BH(lock) \
> -  do { __local_bh_disable_ip(_THIS_IP_, SOFTIRQ_LOCK_OFFSET); ___LOCK(lock); } while (0)
> +#define ___LOCK_shared(lock) \
> +  do { __acquire_shared(lock); ___LOCK_void(lock); } while (0)

The introduction of the new macros in this header file make the changes
hard to follow. Please consider splitting the changes for this header
file as follows:
* A first patch that splits ___LOCK() into ___LOCK_exclusive() and
   ___LOCK_shared().
* A second patch with the thread-safety annotation changes
   (__acquire() -> __acquire_shared()).

>   /* Non PREEMPT_RT kernels map spinlock to raw_spinlock */
> -typedef struct spinlock {
> +context_lock_struct(spinlock) {
>   	union {
>   		struct raw_spinlock rlock;
>   
> @@ -26,7 +26,8 @@ typedef struct spinlock {
>   		};
>   #endif
>   	};
> -} spinlock_t;
> +};
> +typedef struct spinlock spinlock_t;

Also here, a new global struct name is introduced (spinlock). Maybe the
name of this new struct should be made more unique?

Thanks,

Bart.

