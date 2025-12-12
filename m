Return-Path: <linux-wireless+bounces-29711-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1D43CB8AB1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 12:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A2193069575
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 11:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3BB63168E0;
	Fri, 12 Dec 2025 11:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="h0RqJPJB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B04C11E4BE;
	Fri, 12 Dec 2025 11:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765537793; cv=none; b=CvZ5qFE/LKt3GAyn6wQtI14CWjhDh6Vm3qj04XltygyyVLgmD2UmHKOm0SY8KebCn4bVYqODdeRLpJfUCtB8Odxwm2ASZAEiNwjuSunC4KKwLhWyV2O4f3Dwk5tTGDqJl5KVyudQzBgFBgGfY4lhP7gDbseW86mMSrN1jN9Rt7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765537793; c=relaxed/simple;
	bh=NJWANmLDFLgh9uv0VNdg/DhT7Pjr8ENeFuaRLEpVcLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BKv0vZnZEzj8XcvwWQjvVkx8JF5hw+sHxCBymbWc6XoU5+K0s7y3j6fxoYDumQrg0Cv1qpg/zY3a4Mg24Go4IWW5QIsjSRxfJ9aQIly/NLrYAldLIDFpfY8L0DFVixUNnvxfVBd/G/ybHChrE3ohYHM6t5K7xWbvfbac2KYoxGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=h0RqJPJB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sAhBWDHUpHF5PVStWIyQEDmT8IbGgPASZMaiPzih1nU=; b=h0RqJPJB3EslZXH+NrQY8Oawml
	xVZKoRMlILjKuWofLcV230Ra6sSrB2+xJvvgUEbp5EFV/Ksdl7n8uO/wv7F0hgMeWOXRU+OD2v1g6
	YTKEG10gwSh9bsJkLhxckP/d9wbsNQ6ayLlXDhf9hOmuRnj+WLStfaeCkHyhmMouC5a1H04FluZox
	r6CS1zDV7kB+xQmqonG5Xik2CYfRMXdrWt5KAW/Un4rc/os3/oSKhHMXr/E94yHUZ9ZNmv3taEqmo
	3yjzq0lkadR8xVmJOPsHrod0+96Cr641yagkt0pGVO0wgWglc8UyMpb3Fhnw4TDxwjAf9cwJOj3Ec
	NuZNKjag==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU0A9-0000000GVlg-2EQb;
	Fri, 12 Dec 2025 10:14:13 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C422A30057C; Fri, 12 Dec 2025 12:09:28 +0100 (CET)
Date: Fri, 12 Dec 2025 12:09:28 +0100
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
Message-ID: <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>

On Fri, Dec 12, 2025 at 11:15:29AM +0100, Marco Elver wrote:
> On Fri, 12 Dec 2025 at 10:43, Peter Zijlstra <peterz@infradead.org> wrote:
> [..]
> > > Correct. We're trading false negatives over false positives at this
> > > point, just to get things to compile cleanly.
> >
> > Right, and this all 'works' right up to the point someone sticks a
> > must_not_hold somewhere.
> >
> > > > > Better support for Linux's scoped guard design could be added in
> > > > > future if deemed critical.
> > > >
> > > > I would think so, per the above I don't think this is 'right'.
> > >
> > > It's not sound, but we'll avoid false positives for the time being.
> > > Maybe we can wrangle the jigsaw of macros to let it correctly acquire
> > > and then release (via a 2nd cleanup function), it might be as simple
> > > as marking the 'constructor' with the right __acquires(..), and then
> > > have a 2nd __attribute__((cleanup)) variable that just does a no-op
> > > release via __release(..) so we get the already supported pattern
> > > above.
> >
> > Right, like I mentioned in my previous email; it would be lovely if at
> > the very least __always_inline would get a *very* early pass such that
> > the above could be resolved without inter-procedural bits. I really
> > don't consider an __always_inline as another procedure.
> >
> > Because as I already noted yesterday, cleanup is now all
> > __always_inline, and as such *should* all end up in the one function.
> >
> > But yes, if we can get a magical mash-up of __cleanup and __release (let
> > it be knows as __release_on_cleanup ?) that might also work I suppose.
> > But I vastly prefer __always_inline actually 'working' ;-)
> 
> The truth is that __always_inline working in this way is currently
> infeasible. Clang and LLVM's architecture simply disallow this today:
> the semantic analysis that -Wthread-safety does happens over the AST,
> whereas always_inline is processed by early passes in the middle-end
> already within LLVM's pipeline, well after semantic analysis. There's
> a complexity budget limit for semantic analysis (type checking,
> warnings, assorted other errors), and path-sensitive &
> intra-procedural analysis over the plain AST is outside that budget.
> Which is why tools like clang-analyzer exist (symbolic execution),
> where it's possible to afford that complexity since that's not
> something that runs for a normal compile.
> 
> I think I've pushed the current version of Clang's -Wthread-safety
> already far beyond what folks were thinking is possible (a variant of
> alias analysis), but even my healthy disregard for the impossible
> tells me that making path-sensitive intra-procedural analysis even if
> just for __always_inline functions is quite possibly a fool's errand.

Well, I had to propose it. Gotta push the envelope :-)

> So either we get it to work with what we have, or give up.

So I think as is, we can start. But I really do want the cleanup thing
sorted, even if just with that __release_on_cleanup mashup or so.

