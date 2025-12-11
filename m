Return-Path: <linux-wireless+bounces-29648-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A77ACB5B1D
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:49:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 962B43002525
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 11:49:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD062309F14;
	Thu, 11 Dec 2025 11:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JVN1AzMs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B0B1EA84;
	Thu, 11 Dec 2025 11:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453760; cv=none; b=LjgvVcbeV1KralKda2crDfXliM52pTr2YSyJvGtI9I6wGoo4ahxrHEeovr5G7fcrBKLtlVrRgjOCHH3s+QE0ronKSdEE84/BDc5uV7LsXk9vZ2qwNGFhWGsGqJqee/euPHfP6yHS/m3ZCQSaxkprw06iJgJVGGJbvYvNBUWC1fU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453760; c=relaxed/simple;
	bh=BjsBA1Z7qANNd8xJ6WlVRJixSTHMv4oERCxWeYOZtfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i9nUdSjjmCOh/KzQGi67TyGgMaN/zl+3lsupl+0SSVGpm25oDRDLXB/QpNbWguscO7pvL5frH4q/6/SEzn/iGrRXmvfvjf+fsmLsNH+fExrktueRhdJdPS11wnRfyA6QhN2JEuVZ88wpJgCuGzXqQZphuRkVvo9qIa9kXIO8JPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JVN1AzMs; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=+OT4ivkTtGpyfGWvpgrf0Vr9j9IriXFLaXkwu0GJ6bw=; b=JVN1AzMsYXKkNnwNeBL1OpOC2M
	usRg9+5aFTrJDHOxEclPH1av467Fb3Bj3rPgMyCbJ5gZYycl9Gw6AjdhzpiLl3C0V9sb1i0yaQfRK
	mOf5ZYG2z9itaINLA0tfLNeKZSZyiW/C+oVjaNH6gOgA3m+gKuZvovx8NVkI5qpnHg6IQDV9R9c1T
	fyzEc9WqyUb15CtUOl/P9FkFgRDq1JVhxqr2lfHMG4MfmM6gG4CgJ90xouVD4A2O/wBERNIxj9gwr
	pYbXQ1fHOXH+zv5KIkiK43jA/QtjxQp5F0m7a8f08ERF19UcmgOhPesOMjYZXmUqtsp+gyMa2Aosq
	y9tldtSA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTfAP-0000000EBca-31xd;
	Thu, 11 Dec 2025 11:49:05 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2CEC930301A; Thu, 11 Dec 2025 12:49:05 +0100 (CET)
Date: Thu, 11 Dec 2025 12:49:05 +0100
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
Subject: Re: [PATCH v4 08/35] locking/rwlock, spinlock: Support Clang's
 context analysis
Message-ID: <20251211114905.GE3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-9-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120151033.3840508-9-elver@google.com>

On Thu, Nov 20, 2025 at 04:09:33PM +0100, Marco Elver wrote:

> To avoid warnings in constructors, the initialization functions mark a
> lock as acquired when initialized before guarded variables.

> diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
> index 5b87c6f4a243..a2f85a0356c4 100644
> --- a/include/linux/rwlock.h
> +++ b/include/linux/rwlock.h
> @@ -22,23 +22,24 @@ do {								\
>  	static struct lock_class_key __key;			\
>  								\
>  	__rwlock_init((lock), #lock, &__key);			\
> +	__assume_ctx_guard(lock);				\
>  } while (0)
>  #else
>  # define rwlock_init(lock)					\
> -	do { *(lock) = __RW_LOCK_UNLOCKED(lock); } while (0)
> +	do { *(lock) = __RW_LOCK_UNLOCKED(lock); __assume_ctx_guard(lock); } while (0)
>  #endif

This is again somewhat magical and confused the living daylight out of
me. I know (from having looked back on previous discussions) that I was
confused about this before, and clearly it didn't stick.

So obviously I'll be confused again when I look at this code in a years
time or so :/

Can we get a comment near this __assume_ctx_guard() thing (because
putting it all over the lock initializers would probably be duplicating
things too much)?

