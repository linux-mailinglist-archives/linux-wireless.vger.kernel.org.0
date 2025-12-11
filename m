Return-Path: <linux-wireless+bounces-29651-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A4BB5CB5C58
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:17:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 254063010988
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FD392C11CF;
	Thu, 11 Dec 2025 12:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JQUFeVK9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF0029E0E5;
	Thu, 11 Dec 2025 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765455438; cv=none; b=stFAmPyV/ezDno/3mxq9csCT6tQ33mdPs3H/1iuZ6ceINyEJw88i7tDFF/PCPki26S5WBdWyUjK0CMiuFGRkgmxvzW0ycJm84T49UmzN+6z9ncvzfX/mubZcQS6YKIYMkEYBKzKB/MmiFHjoeYQ8zCf7OP8ZcbmQkNkde68379k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765455438; c=relaxed/simple;
	bh=L/ssP63d+UxeZkVMo2MPyzgDHRbOqC+pvc3SVn7Q+F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=chHETkncbwk6TqsVE/wcqHd47u4cE415Y51LC0D+FKB+bN9gykpemobECdVdhe8ThdbJN4+xCq3NSKnEW93eC1imTKA0B53wKmx2oPFWM7ggeJ+BF2ytSmsuuwymwPS/723r2VmhXmSZGt18RvtuGngZF54zfvk7WRggzxNARYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JQUFeVK9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=39KoR5/fOj3fCtjlvg+DfDvWOhyBBWrm+m1GgO5bCLU=; b=JQUFeVK98tjeYpfU93rMF2ZY19
	bAsRE3AVzS8uNN1rSyDutKu3gLcTtuHvhuOJj2RMhmQzVgJBqfNeXxKO/clvF8DQvLMATUDN6SZSF
	84MZfyjGW1SaTQ7YLkmKmz/YSI0c950DbeuGKK2uP2GEGewedHgITujDipZ3yrY2OErO7bzvUh+53
	epSXiiwAKohLvCwEGDmc3375iypbRIz1SRqd35HtDzlUf39T0ZEBBWihSj2EaefFEM2dQV63abUjL
	PWkRyBu9U/Gxl4sIlvsl14hULIsz6Dv3HCQUcTGP2JFZGKEYcvUu5cS5HGNjTnYLmXrec2cxusQUB
	jigfaTgw==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTeju-0000000Et79-48aq;
	Thu, 11 Dec 2025 11:21:43 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 87A0730301A; Thu, 11 Dec 2025 13:16:59 +0100 (CET)
Date: Thu, 11 Dec 2025 13:16:59 +0100
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
Message-ID: <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120151033.3840508-7-elver@google.com>

On Thu, Nov 20, 2025 at 04:09:31PM +0100, Marco Elver wrote:
> Introduce basic compatibility with cleanup.h infrastructure: introduce
> DECLARE_LOCK_GUARD_*_ATTRS() helpers to add attributes to constructors
> and destructors respectively.
> 
> Note: Due to the scoped cleanup helpers used for lock guards wrapping
> acquire and release around their own constructors/destructors that store
> pointers to the passed locks in a separate struct, we currently cannot
> accurately annotate *destructors* which lock was released. While it's
> possible to annotate the constructor to say which lock was acquired,
> that alone would result in false positives claiming the lock was not
> released on function return.
> 
> Instead, to avoid false positives, we can claim that the constructor
> "assumes" that the taken lock is held via __assumes_ctx_guard().

What is the scope of this __assumes_ctx stuff? The way it is used in the
lock initializes seems to suggest it escapes scope. But then something
like:

	scoped_guard (mutex, &foo) {
		...
	}
	// context analysis would still assume foo held

is somewhat sub-optimal, no?

> Better support for Linux's scoped guard design could be added in
> future if deemed critical.

I would think so, per the above I don't think this is 'right'.

