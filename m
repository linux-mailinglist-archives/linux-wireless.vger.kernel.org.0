Return-Path: <linux-wireless+bounces-30609-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E39ED0C2AC
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 21:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A04D30704E8
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 20:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4179336827B;
	Fri,  9 Jan 2026 20:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="RjLtkJa1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CD1366DD6;
	Fri,  9 Jan 2026 20:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767989817; cv=none; b=TtQxWF0dTnHoXATSEMDJLBiZUyTBb9z7pf7oz9+7okSKowb9IXo49H7SGET3Ktn1ICtVBMQW8ZGrA01AUQXj2pLNX63ZFx8PbparcVOyZ5BQBmYVb2yxP3kuiQ2x3ZzzYZuiOnK1VuIXDvUOEXSarNgfGNQp7lRpk5pGQvBreAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767989817; c=relaxed/simple;
	bh=ADaYwFS3kKhM5xXVlApjjoRfDaP+xucJXVcKN8R+3xU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Fge9O7k51LaQUobXhpyUldTjEH8GkE262e2jssE3pWokm88FHFeEnPqfQBzLUWQnlCycOp72mrqHmZ6m6HcGxym3jXWJhpGP+WJfs3JW0qjC0jDIl04WgT9m6eXsKIUHcI6MmDD2uHox0tMbC0/0aSWsXneh9OGKidrYri32FEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=RjLtkJa1; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dntN66qC7z1XSVtL;
	Fri,  9 Jan 2026 20:16:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1767989807; x=1770581808; bh=MWWlok8ve6te0Z1LFT3tDlJ2
	/NkqaoxHzzfJCelUW48=; b=RjLtkJa1D0QD6TAtBF7G2Jt4AHXQc+brZdc/5Tt3
	jLo0eDAvbJmHIgNEXvLWEKHxTHRyVyb8D/Q06Ur+0T8jENUFddkat1ZKTy3z3SCC
	yDf86qyZn7Mw6O42JTSazct3a+5P6OhdLUxYoG2N+K1nLDa+zdW6XgfbDJXsR7ng
	jwo0GO2ay6yXtRwcQHBbI2rYmhtkOiawoqZQXc3Ti/WgrYqhAEUZOdNAs9KC7uUn
	Qq0xxt6q5wZuMIdq5Cl7pFCXgskRMzaEvQTOGgVF3O1ctVoejnnjZWNZJ35Ht4/9
	VhXFXR50Omzjcooxo8ojFKm5X7x9JePv61sq2YtntHteEg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id JY_Dc9oQqhZL; Fri,  9 Jan 2026 20:16:47 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dntMk3WPZz1XT1Zk;
	Fri,  9 Jan 2026 20:16:33 +0000 (UTC)
Message-ID: <05c77ca1-7618-43c5-b259-d89741808479@acm.org>
Date: Fri, 9 Jan 2026 12:16:33 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 20/36] locking/ww_mutex: Support Clang's context
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
 <20251219154418.3592607-21-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-21-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> Add support for Clang's context analysis for ww_mutex.
> 
> The programming model for ww_mutex is subtly more complex than other
> locking primitives when using ww_acquire_ctx. Encoding the respective
> pre-conditions for ww_mutex lock/unlock based on ww_acquire_ctx state
> using Clang's context analysis makes incorrect use of the API harder.

That's a very short description. It should have been explained in the
patch description how the ww_acquire_ctx changes affect callers of the
ww_acquire_{init,done,fini}() functions.

>   static inline void ww_acquire_init(struct ww_acquire_ctx *ctx,
>   				   struct ww_class *ww_class)
> +	__acquires(ctx) __no_context_analysis
> [ ... ]
>   static inline void ww_acquire_done(struct ww_acquire_ctx *ctx)
> +	__releases(ctx) __acquires_shared(ctx) __no_context_analysis
>   {
> [ ... ]
>   static inline void ww_acquire_fini(struct ww_acquire_ctx *ctx)
> +	__releases_shared(ctx) __no_context_analysis

The above changes make it mandatory to call ww_acquire_done() before
calling ww_acquire_fini(). In Documentation/locking/ww-mutex-design.rst
there is an example where there is no ww_acquire_done() call between
ww_acquire_init() and ww_acquire_fini() (see also line 202). The
function dma_resv_lockdep() in drivers/dma-buf/dma-resv.c doesn't call
ww_acquire_done() at all. Does this mean that the above annotations are
wrong? Is there a better solution than removing the __acquire() and
__release() annotations from the above three functions?

Bart.

