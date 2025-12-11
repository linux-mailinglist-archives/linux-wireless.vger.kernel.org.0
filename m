Return-Path: <linux-wireless+bounces-29646-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E32C3CB5AD5
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 562A630019E9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 11:43:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8902FFFA8;
	Thu, 11 Dec 2025 11:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gC2D4Nn6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DFF207A0B;
	Thu, 11 Dec 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453412; cv=none; b=F8mtUd3qGDyPChqNgqSHVPsUBT0JoKtBCIn+6X0g2OBmh+bpxoB8Gc9Zgcpz9b7H5EO0dcIdVFjMyqqexY6YU6aCVxUTVYrONHziyCGlJyrk09JOSGgruRx9XKmmiBkhrUH7QkiHGAWJW4JPXYv8Y/5GG59DnYyX2tcHklYoa54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453412; c=relaxed/simple;
	bh=a2q48itQxZLgJRwc9Vpxeep9OU7oiyd6Ljz+SYhIGZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q59qW3y7TPs6jvdqehhHb7FIyoOMnIjx3Xb/wi4I9Rk7V1PV4Wcsz5B8KKY5Vkt/AZ8wu0JfTlamDYEN7eK4eiXPSQu0RktVY/LNKJyMjW/sDxQQms2xO5XbGD1fky8q0kzhBNU916ZNcVukKseEuQR1vXgtnEIFQZoYCYv0hho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gC2D4Nn6; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=uQ1t1in3MNz+55jGFoFlKgze5NqUmk6ITua4X7r2Yeo=; b=gC2D4Nn6TBsE1we2zbHDdyJ5qr
	5r1+OVFGLSNem72JBqMo7iaGapPFi38ZsC431uA0Y92pG++DHkKwM6qgaxASR7JF02WkWrLSxu5+T
	N3/tUOuTVCAuPcWK7WW4QJzL5miwWBfBEAMHMwQukxzLV6StP8KclJid86BDcgk1KFVqtTOelz1kd
	TolBaeGejJh9I7Y8FKRhnFLoXnHKynMZ8pOcGBXC/qbeFfGKC2iBQZuL3ekazEAAlTEOBWJm7fS8T
	J3o7cDROPeRxtK+aKww43zCeRFqCeJc5r66NPdNWBNRSxKG6yWR1CYSIMJYOGRg0Rqn2M6aowIXJf
	TJ3ogtvg==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTf4Z-0000000EBFr-2coJ;
	Thu, 11 Dec 2025 11:43:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 29E1230301A; Thu, 11 Dec 2025 12:43:02 +0100 (CET)
Date: Thu, 11 Dec 2025 12:43:02 +0100
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
Subject: Re: [PATCH v4 07/35] lockdep: Annotate lockdep assertions for
 context analysis
Message-ID: <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-8-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120151033.3840508-8-elver@google.com>

On Thu, Nov 20, 2025 at 04:09:32PM +0100, Marco Elver wrote:

>  include/linux/lockdep.h | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> index 67964dc4db95..2c99a6823161 100644
> --- a/include/linux/lockdep.h
> +++ b/include/linux/lockdep.h
> @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
>  	do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)

Since I typically read patches without first reading the Changelog --
because when I read the code later, I also don't see changelogs.

I must admit to getting most terribly confused here -- *again*, as I
then search back to previous discussions and found I was previously also
confused.

As such, I think we want a comment here that explains that assume_ctx
thing.

It is *NOT* (as the clang naming suggests) an assertion of holding the
lock (which is requires_ctx), but rather an annotation that forces the
ctx to be considered held.

>  
>  #define lockdep_assert_held(l)		\
> -	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> +	do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assume_ctx_guard(l); } while (0)
>  
>  #define lockdep_assert_not_held(l)	\
>  	lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
>  
>  #define lockdep_assert_held_write(l)	\
> -	lockdep_assert(lockdep_is_held_type(l, 0))
> +	do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_guard(l); } while (0)
>  
>  #define lockdep_assert_held_read(l)	\
> -	lockdep_assert(lockdep_is_held_type(l, 1))
> +	do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_guard(l); } while (0)
>  
>  #define lockdep_assert_held_once(l)		\
>  	lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> @@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
>  #define lockdep_assert(c)			do { } while (0)
>  #define lockdep_assert_once(c)			do { } while (0)
>  
> -#define lockdep_assert_held(l)			do { (void)(l); } while (0)
> +#define lockdep_assert_held(l)			__assume_ctx_guard(l)
>  #define lockdep_assert_not_held(l)		do { (void)(l); } while (0)
> -#define lockdep_assert_held_write(l)		do { (void)(l); } while (0)
> -#define lockdep_assert_held_read(l)		do { (void)(l); } while (0)
> +#define lockdep_assert_held_write(l)		__assume_ctx_guard(l)
> +#define lockdep_assert_held_read(l)		__assume_shared_ctx_guard(l)
>  #define lockdep_assert_held_once(l)		do { (void)(l); } while (0)
>  #define lockdep_assert_none_held_once()	do { } while (0)
>  
> -- 
> 2.52.0.rc1.455.g30608eb744-goog
> 

