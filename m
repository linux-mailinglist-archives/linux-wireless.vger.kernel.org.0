Return-Path: <linux-wireless+bounces-29802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id BD429CC2C52
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 13:33:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 41239302A1E0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 12:33:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D55FA397D02;
	Tue, 16 Dec 2025 12:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aULM0WOR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3800839657F;
	Tue, 16 Dec 2025 12:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888346; cv=none; b=exKvJNYO3gwMSw3QEGHshualH8leLKsah+UamZlTtZ61b37u99ZaKS97oeHn9YbJDKd+/5xIRC8a298YVaOrlwtv3WMBUqbgBCUXxs1SU+3jSb+nUYSp8fGfftn5UIbf9mzEdBUd0I7Pa9Xt9z7CipqSzWbBKXLnd27gP9uMcaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888346; c=relaxed/simple;
	bh=gZwI7sOneK9KHQIkPczmUqip2/c0r5NuxsZIbFXEnvs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r0bKudA/rwMQrA+N6HLGe6OvcMP2nl1zehfRM39cBAx0LZPSpJBb3j5qDStEge00QsR5FogUPAvFEuxDFkUYoG1it5lAXxnKZjYZCjLK+CKCJHtjOak9rFjQOFDnFr7Cfps60cAU1vRcSXTJhGNfw3IAO/WN5F4239UUDWeysrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=aULM0WOR; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=PT+1SSkmSVMS0Ka1JPI8XlGmFQ/04yBEbtnblqzrJZU=; b=aULM0WORyMyG1V7q67HHf8Pnaa
	NC5JgDx3xvq8f+F5KNJZu8KWF3bk3QdZNq9mAaJd4kCIL2Ga28adix+Urc5e4fLYxU69ezBB7gY58
	5lm8yjCsk3qFLmry+oBd0hT3UqC3563GeqMBjfc+GBTZ6vxxwamfPdEiVrKRP1twYbsECNhYm8tFP
	sFyalImbKjiTayr5QZxW7qOk8cNg8AiB+WgzHpnpuzEegTlZ8ErrdxvnCefnRvUGHiPZe3bf4KPr4
	MzBHq7NI02WHXEqjGEvQA1Grvv3OmLz94h3Ff5gqAXkM0itxSMmOPBVBsR/Oc3Uew3hsmaYs3hWiz
	WDe7RvXw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVTMO-00000004iUO-3Ujr;
	Tue, 16 Dec 2025 11:36:56 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9425D300220; Tue, 16 Dec 2025 13:32:11 +0100 (CET)
Date: Tue, 16 Dec 2025 13:32:11 +0100
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
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
Message-ID: <20251216123211.GT3707837@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUAPbFJSv0alh_ix@elver.google.com>

On Mon, Dec 15, 2025 at 02:38:52PM +0100, Marco Elver wrote:

> Working on rebasing this to v6.19-rc1 and saw this new scoped seqlock
> abstraction. For that one I was able to make it work like I thought we
> could (below). Some awkwardness is required to make it work in
> for-loops, which only let you define variables with the same type.

> 
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index b5563dc83aba..5162962b4b26 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -1249,6 +1249,7 @@ struct ss_tmp {
>  };
>  
>  static __always_inline void __scoped_seqlock_cleanup(struct ss_tmp *sst)
> +	__no_context_analysis
>  {
>  	if (sst->lock)
>  		spin_unlock(sst->lock);
> @@ -1278,6 +1279,7 @@ extern void __scoped_seqlock_bug(void);
>  
>  static __always_inline void
>  __scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state target)
> +	__no_context_analysis
>  {
>  	switch (sst->state) {
>  	case ss_done:
> @@ -1320,9 +1322,18 @@ __scoped_seqlock_next(struct ss_tmp *sst, seqlock_t *lock, enum ss_state target)
>  	}
>  }
>  
> +/*
> + * Context analysis helper to release seqlock at the end of the for-scope; the
> + * alias analysis of the compiler will recognize that the pointer @s is is an
> + * alias to @_seqlock passed to read_seqbegin(_seqlock) below.
> + */
> +static __always_inline void __scoped_seqlock_cleanup_ctx(struct ss_tmp **s)
> +	__releases_shared(*((seqlock_t **)s)) __no_context_analysis {}
> +
>  #define __scoped_seqlock_read(_seqlock, _target, _s)			\
>  	for (struct ss_tmp _s __cleanup(__scoped_seqlock_cleanup) =	\
> -	     { .state = ss_lockless, .data = read_seqbegin(_seqlock) };	\
> +	     { .state = ss_lockless, .data = read_seqbegin(_seqlock) }, \
> +	     *__UNIQUE_ID(ctx) __cleanup(__scoped_seqlock_cleanup_ctx) = (struct ss_tmp *)_seqlock; \
>  	     _s.state != ss_done;					\
>  	     __scoped_seqlock_next(&_s, _seqlock, _target))
>  

I am ever so confused.. where is the __acquire_shared(), in read_seqbegin() ?

Also, why do we need this second variable with cleanup; can't the
existing __scoped_seqlock_cleanup() get the __releases_shared()
attribute?

