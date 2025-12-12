Return-Path: <linux-wireless+bounces-29706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E07CB8842
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 10:48:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90D13308D5BC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 09:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6CF6314A64;
	Fri, 12 Dec 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Ur4V8SWv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E0029B778;
	Fri, 12 Dec 2025 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532647; cv=none; b=N6FB9RZAYoeUu0tC4eMewXsNI8vsoPXJLPssaatSUuD4l26M1MnK04G7r3Qkzn9PMGLc3qpKEwo8udIOCCgppvP51T5LXT/+wAc5DTq6P/4/uQ3PeKath1nLoME+CA8LM+0K6rSe6/lNTWN4QOqMG6oEty6jWCxsrgj7UlWyieE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532647; c=relaxed/simple;
	bh=4LWJL0kQo4ufWh3QF9lrNK39CoU3j+zGv+hTqrvNy4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f6LvGSl9c50HtaHA/fGrYRFRqCyAM00hBTe6XaLmgOmSatudg8AZXsXVBRxwOcizZRpFQr9r9B2Z9FnOHDtdmHwvPntNNN2f2vYfyVRTEQUBB6NOJFu7BNeb5EKS/q3tuwLB33T60yiiPOFK9UD5ZC0dfdPisaXob8RLSnp7YIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Ur4V8SWv; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=J0s9Z/Nw7eH3J6mljMw45LY45lUZplaK/cGrdA/YkXU=; b=Ur4V8SWvfQ6bSD1Jimbf2HVssZ
	qtgtHbkdLRensVt0bGd9gmnk/6zpXiAQtBkoWUfgwj4Bf/1keaOG6pYGijSTHKAdKaLFq2VZYbFRA
	hQ5a0RAvYfnxCKTYdyOPpUiIlu4T6yPz6EeldvhXavFMh83NzCTTWjQ0QSmqfAcLMgExspdRiuu5s
	BCFQ5Us9cj0ZfN9IYbcwtcnFZDXYb59kyvH8kVVPhxxLkfxE2EPtxm4CVlUKWo7JOzF42LHRLV+VF
	vLvu3eTnH3zISwXdT9whryYHXL8nvHtiIVOsIgPDjAPaaAgTfdwEXYqdH/6qEhUzMqg86r9b9ud4/
	/tVR2YOQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTypH-0000000GQ2D-3yf4;
	Fri, 12 Dec 2025 08:48:36 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 2F0AD30041D; Fri, 12 Dec 2025 10:43:52 +0100 (CET)
Date: Fri, 12 Dec 2025 10:43:52 +0100
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
Message-ID: <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>

On Thu, Dec 11, 2025 at 02:19:28PM +0100, Marco Elver wrote:
> On Thu, 11 Dec 2025 at 13:17, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Thu, Nov 20, 2025 at 04:09:31PM +0100, Marco Elver wrote:
> > > Introduce basic compatibility with cleanup.h infrastructure: introduce
> > > DECLARE_LOCK_GUARD_*_ATTRS() helpers to add attributes to constructors
> > > and destructors respectively.
> > >
> > > Note: Due to the scoped cleanup helpers used for lock guards wrapping
> > > acquire and release around their own constructors/destructors that store
> > > pointers to the passed locks in a separate struct, we currently cannot
> > > accurately annotate *destructors* which lock was released. While it's
> > > possible to annotate the constructor to say which lock was acquired,
> > > that alone would result in false positives claiming the lock was not
> > > released on function return.
> > >
> > > Instead, to avoid false positives, we can claim that the constructor
> > > "assumes" that the taken lock is held via __assumes_ctx_guard().
> 
> 
> > Moo, so the alias analysis didn't help here?
> 
> Unfortunately no, because intra-procedural alias analysis for these
> kinds of diagnostics is infeasible. The compiler can only safely
> perform alias analysis for local variables that do not escape the
> function. The layers of wrapping here make this a bit tricky.
> 
> The compiler (unlike before) is now able to deal with things like:
> {
>     spinlock_t *lock_scope __attribute__((cleanup(spin_unlock))) = &lock;
>     spin_lock(&lock);  // lock through &lock
>     ... critical section ...
> }  // unlock through lock_scope (alias -> &lock)
> 
> > What is the scope of this __assumes_ctx stuff? The way it is used in the
> > lock initializes seems to suggest it escapes scope. But then something
> > like:
> 
> It escapes scope.
> 
> >         scoped_guard (mutex, &foo) {
> >                 ...
> >         }
> >         // context analysis would still assume foo held
> >
> > is somewhat sub-optimal, no?
> 
> Correct. We're trading false negatives over false positives at this
> point, just to get things to compile cleanly.

Right, and this all 'works' right up to the point someone sticks a
must_not_hold somewhere.

> > > Better support for Linux's scoped guard design could be added in
> > > future if deemed critical.
> >
> > I would think so, per the above I don't think this is 'right'.
> 
> It's not sound, but we'll avoid false positives for the time being.
> Maybe we can wrangle the jigsaw of macros to let it correctly acquire
> and then release (via a 2nd cleanup function), it might be as simple
> as marking the 'constructor' with the right __acquires(..), and then
> have a 2nd __attribute__((cleanup)) variable that just does a no-op
> release via __release(..) so we get the already supported pattern
> above.

Right, like I mentioned in my previous email; it would be lovely if at
the very least __always_inline would get a *very* early pass such that
the above could be resolved without inter-procedural bits. I really
don't consider an __always_inline as another procedure.

Because as I already noted yesterday, cleanup is now all
__always_inline, and as such *should* all end up in the one function.

But yes, if we can get a magical mash-up of __cleanup and __release (let
it be knows as __release_on_cleanup ?) that might also work I suppose.
But I vastly prefer __always_inline actually 'working' ;-)

