Return-Path: <linux-wireless+bounces-29805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8A7CC3A7C
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 15:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6092D30719CD
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 14:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D46A3596EC;
	Tue, 16 Dec 2025 13:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dMWulvkE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CA0358D2C;
	Tue, 16 Dec 2025 13:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892510; cv=none; b=FZgHWS0fmuCHczt2g2BXfjki5owoDdCVOn/6qUf3S1vS0y9XQMzYj8WrXeokfjX1lr4Re1ZnO6iFJSlVE8RKm+wE4tQq9avHBe59aHKUG0qkS9zF0Qkpe4kdNZIxqlz121RRpjWeKne+uqcyAY7ti8i8Y5fSITmXGLSw740mxs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892510; c=relaxed/simple;
	bh=gWLCD3iBOBUmWuAt+1zM67Tkj23VTvcGTN7S+MGr/ks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RPqecn0gUX9gVyVjHQzMB3U73teEXvOKockdNz+bVfX3ydDGMM1FJI807xGmQ6IepzO8XLjgtkJdyD3ox4DXJ+qz4xXjh0hofU1GVuoK9vgWibuNjgmkjGab6Cl5JAL7a6IjAIEI8m/nPO6ckdntPrOB7bWxSvGtz9zQIbvJc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dMWulvkE; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=3682UGOf9mvj955UPR/gJlxWjdDq8XctSWFz2A093u0=; b=dMWulvkEtlHRfwLzo+fiUy1Rul
	jjpm7Nh2E3i0jPKr9HMflOZdHLmzPwGROrRfy+9DA6rqyFyOwg/sOMcHP7z1I0KSJNIkPWJ2wBtvb
	Ab5EX9vtW7XFPbI4t8avQsSZnbwYHlc3xLHwv/1NtPJCLFIMM2yoqbJX0EIdSz3yYrDjgMHG9FMBZ
	xuG4HBparMxFnq8+KjCFyLlfRplAa3ifZIAEXjq5tFbyaU1w/zO0idGO9PQS93MnJhQKxuk3vQX6n
	NUXzHndpgSJ6+YIVw3RTr17Z6URMVucWjRkhg5YJiyV6sn66SBQExl7rk/IIt4FKVR/iMv9woMrvX
	bcL7MGng==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVVIn-00000003LNo-2njp;
	Tue, 16 Dec 2025 13:41:21 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0582B30029E; Tue, 16 Dec 2025 14:41:20 +0100 (CET)
Date: Tue, 16 Dec 2025 14:41:19 +0100
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
Message-ID: <20251216134119.GU3707837@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <20251216123211.GT3707837@noisy.programming.kicks-ass.net>
 <aUFdRzx1dxRx1Uqa@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUFdRzx1dxRx1Uqa@elver.google.com>

On Tue, Dec 16, 2025 at 02:23:19PM +0100, Marco Elver wrote:

> > Also, why do we need this second variable with cleanup; can't the
> > existing __scoped_seqlock_cleanup() get the __releases_shared()
> > attribute?
> 
> The existing __scoped_seqlock_cleanup() receives &_s (struct ss_tmp *),
> and we can't refer to the _seqlock from __scoped_seqlock_cleanup(). Even
> if I create a member seqlock_t* ss_tmp::seqlock and initialize it with
> _seqlock, the compiler can't track that the member would be an alias of
> _seqlock. The function __scoped_seqlock_next() does receive _seqlock to
> effectively release it executes for every loop, so there'd be a "lock
> imbalance" in the compiler's eyes.
> 
> So having the direct alias (even if we cast it to make it work in the
> single-statement multi-definition, the compiler doesn't care) is
> required for it to work.

Right -- it just clicked while I was walking outside. Without actual
inlining it cannot see through the constructor and track the variable :/

OK, let me stare at this more.

