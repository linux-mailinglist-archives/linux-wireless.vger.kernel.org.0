Return-Path: <linux-wireless+bounces-29707-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D011CB8902
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 11:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8E216309CC59
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 10:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7865C3164B0;
	Fri, 12 Dec 2025 10:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q4PvE8q1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9A9C2DF700;
	Fri, 12 Dec 2025 09:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765533602; cv=none; b=AgbbAeYwkAFCiPgIR4qEXIntwR2CeKAJWY3KlwZT5RLeW8SFv8Yh/avrQxf+e3zsP/opkovrHf+5ryaAey0p1u/l0R73IMK0aCyEIn6OI5XM7uzKXZcgjGxlMr1s2RHEUGQTFf293efrP5fAkOr15UHg/Znl1laazj62jQQBypc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765533602; c=relaxed/simple;
	bh=Jmg8YoC8ENkVosXMX5wUnzKW2V3TYXeF+XYoSMCYBUs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KHrGS8j6nUK9qq7iYD76tpuUWQqP7dQfYz8xJU4yM9r0DGmZ1U8YGr7/cmo3amp6c2XT75KCjZF5rdd2yj5ZPEMK1Sxb3wS7UXaD0huF7v3T/smOoUuEv223TjQwrPrKF1rwC7vSjQV0QYjVQMh9riiu7y5+CGha0vsbbDq6GoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=q4PvE8q1; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=KSM4F9EPA4VrHSATWZaVBC81vHU19MDt0Mi2nP4hTcc=; b=q4PvE8q1MvSUiSan/OQUGVyWjB
	ey3Vrr3EGE7ZCZmMa2Q5RwD0Szf9yfpU9MDTOfKLxI7g78pi/86AKrvVEuYcUelT9SACClEtReQ4X
	YNEkxxEaf7Hj9lNNnecfwhhDw1JKhrgqon3hzMPEHvfRHMJXy1vuCRSOG+gKzHjH2areb2zIxNWHh
	qOvFVdyLVG1PxCmb11XYlPZWPjNmgL+p7J2n6WI3MKlwAD2OTti/zPQ4/lFxl9n6UUlXKAIOqZVnk
	2PnlnDVtTKp1PmPbGh5hRrZJfLK1yNLydbSCrVXlmnCktKj94YkiTNcHA+X+aMnJQX32qELAPOp7s
	fhefkUvA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTz4d-0000000GRLd-1uSY;
	Fri, 12 Dec 2025 09:04:27 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id C2F3930041D; Fri, 12 Dec 2025 10:59:43 +0100 (CET)
Date: Fri, 12 Dec 2025 10:59:43 +0100
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
Message-ID: <20251212095943.GM3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-8-elver@google.com>
 <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
 <CANpmjNObaGarY1_niCkgEXMNm2bLAVwKwQsLVYekE=Ce6y3ehQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNObaGarY1_niCkgEXMNm2bLAVwKwQsLVYekE=Ce6y3ehQ@mail.gmail.com>

On Thu, Dec 11, 2025 at 02:24:57PM +0100, Marco Elver wrote:

> > It is *NOT* (as the clang naming suggests) an assertion of holding the
> > lock (which is requires_ctx), but rather an annotation that forces the
> > ctx to be considered held.
> 
> Noted. I'll add some appropriate wording above the
> __assumes_ctx_guard() attribute, so this is not lost in the commit
> logs.

On IRC you stated:

<melver> peterz: 'assume' just forces the compiler to think something is
  held, whether or not it is then becomes the programmer's problem. we
  need it in 2 places at least: for the runtime assertions (to help
  patterns beyond the compiler's static reasoning abilities), and for
  initialization (so we can access guarded variables right after
  initialization; nobody should hold the lock yet)

I'm really not much a fan of that init hack either ;-)

Once we get the scope crap working sanely, I would much rather we move
to something like:

	scoped_guard (spinlock_init, &foo->lock) {
		// init foo fields
	}

or perhaps:

	guard(mutex_init)(&bar->lock);
	// init until end of current scope

Where this latter form is very similar to the current semantics where
mutex_init() will implicitly 'leak' the holding of the lock. But the
former gives more control where we need it.




