Return-Path: <linux-wireless+bounces-29989-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CADE7CD1DE0
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A35D0301B2FE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:54:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD9E733B6D2;
	Fri, 19 Dec 2025 20:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UfehkjIJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167442E093E;
	Fri, 19 Dec 2025 20:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177641; cv=none; b=UgJq1BsAKtUG2TPy1c+4t6DQust9ICxMTKoHUMCzmtk54OXH9z2qOfpsdhnkymWLqvOTPE6JQ3xGFTqGjGezpgHFPyNl3K1QiwPXE7n/YApc/4IxLF8l7AOXvwiJsNm/phZlS/+3vNWz+7kRLeVjH8auiXA3SufjxCLOJ/9r5uI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177641; c=relaxed/simple;
	bh=9tBSnfxXYnHTobBsw8dx2/CPnuFYhLg13H7lqEO9dpI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ElzlVXc1+wuh5+nJ3jquT6OQTqtQSnyn/E3q43hSbGyC2s3qDi6yGezN6Aq4HMVHlsNV8TOhBX0QEi70ZGEujCwgnydUEoaCqz/mQO4HSP6J0CPsnHLa6DtEuiUTX8oBDc/sFj+tq8+rX0Hqb8nUxJMCW9Mgfs5y5I7QUCOC6BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UfehkjIJ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY0Bb26BgzlgyG0;
	Fri, 19 Dec 2025 20:53:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766177631; x=1768769632; bh=n0Uo17R9WMorX1SnpOAKwu8b
	4IBQKRGE96JfpenCXBM=; b=UfehkjIJdc0Hxhy6e1QrqozCPDNCsdBaBTSNAMAE
	KsX0uDHgLFBBSrs9xSwfM3qph2C8+tbTb7M9XBr9DWnYeElRdF0N5FkNATZoOm2w
	d9a9JYW75qJFA4k5r1QWHovpAcRZQt+sieHUKqQwpbWOE9k5jNutrfaRN59H54bt
	MYntbfUUaSDX7hnAvMzk9AdUr66yGKIn+c/kBY2oO9xYFVJmWlBkVGJuHOLyUFlu
	hmMmOyvGGnzkX+vq0/0DsUm0fnGWj9DmTR9vkB421Q46RF2Bpcx1RMMwQ10vmHKf
	/mt2CDUYrOjmtKcd35CqH/Zwc2a1AjvbVgEAHtuyr4UgYw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vHlYWjU2OGjG; Fri, 19 Dec 2025 20:53:51 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY0BC4DBmzlwqQL;
	Fri, 19 Dec 2025 20:53:39 +0000 (UTC)
Message-ID: <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
Date: Fri, 19 Dec 2025 12:53:38 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 07/36] lockdep: Annotate lockdep assertions for context
 analysis
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
 <20251219154418.3592607-8-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-8-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:39 AM, Marco Elver wrote:
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index dd634103b014..621566345406 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
>   	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
>   
>   #define lockdep_assert_held(l)		\
> -	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> +	do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assume_ctx_lock(l); } while (0)
>   
>   #define lockdep_assert_not_held(l)	\
>   	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
>   
>   #define lockdep_assert_held_write(l)	\
> -	lockdep_assert(lockdep_is_held_type(l, 0))
> +	do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_lock(l); } while (0)
>   
>   #define lockdep_assert_held_read(l)	\
> -	lockdep_assert(lockdep_is_held_type(l, 1))
> +	do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_lock(l); } while (0)
>   
>   #define lockdep_assert_held_once(l)		\
>   	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> @@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
>   #define lockdep_assert(c)			do { } while (0)
>   #define lockdep_assert_once(c)			do { } while (0)
>   
> -#define lockdep_assert_held(l)			do { (void)(l); } while (0)
> +#define lockdep_assert_held(l)			__assume_ctx_lock(l)
>   #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
> -#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
> -#define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
> +#define lockdep_assert_held_write(l)		__assume_ctx_lock(l)
> +#define lockdep_assert_held_read(l)		__assume_shared_ctx_lock(l)
>   #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
>   #define lockdep_assert_none_held_once()	do { } while (0)

I think these macros should use __must_hold() instead of __assume...().
lockdep_assert_held() emits a runtime warning if 'l' is not held. Hence,
I think that code where lockdep_assert_held() is used should not compile
if it cannot be verified at compile time that 'l' is held.

Thanks,

Bart.



