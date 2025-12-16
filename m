Return-Path: <linux-wireless+bounces-29801-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EC856CC3026
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 14:00:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 23BBB312CA17
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 12:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E3BE34F46E;
	Tue, 16 Dec 2025 12:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="g637eP12"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02003328E3;
	Tue, 16 Dec 2025 12:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765887861; cv=none; b=laVnbdhhz7fBpAl8OvU0dgjfaWfaaOI5UmlREdlRUqt886uZs7/fFxwysPu1CxnbFgm9BJWl0KUVIswuWD7ocDF7I926tR/GpxuomoInuA/oMcc95Cy0zo1S21JNezeBsDEHS+jRwoWoZEeN1LCUlJCLk6exDb3KfIqaKrOeZZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765887861; c=relaxed/simple;
	bh=lLRQaT+PfrlE09N+ydMoSz7Mn4llxrI8kjoKOroo6L4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lVAuMAZ9iU9oOK3B49IDWkPG5Qhh8c04pZ4QbTEogupY4CBFFXuUdaP3twB01A6iLxEJjz5c0nol5o/fKubFJEQEosZ8iKbPJ5elRmzyD6/RmRpjUm0q0Klif0b1r3yus0rRmgfLV4KgTmgoOEw4IgJUu+OUTqKqHyHf/WBZeGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=g637eP12; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=lLRQaT+PfrlE09N+ydMoSz7Mn4llxrI8kjoKOroo6L4=; b=g637eP12cSdDeAwjLUJVp9bFxA
	NCfokUWkyh4uqLE48N1Kt6KCkC0EROAHECKL/1Pfv7IamNv287e7/ZRrq31y34dK3TYBeWd+ECvxs
	L2SBBUq1PaIzX16nemfVr+aLsuXjWsLOgrSUi5KRBcSlf5V/ymVNJIDj3BrGeJPcaT2nC099cRgIH
	jZMyRMXi3Rdob5lJ/38vx25CRMg8UqRuY8Ehd0Lf01AEduHpm4wgTpBdsE5z9c25E0Q1CoPEhtZ43
	C3TmwnFQoLCm3OgM+z6Aor54f4zuN6+7brFHBUbgoXnQ1ypFdhfOMuTF5UMymOEpBLnFKLBNM9Sfb
	JfHr4YQQ==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vVTES-00000004hkA-3IWl;
	Tue, 16 Dec 2025 11:28:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 60ABA300220; Tue, 16 Dec 2025 13:23:59 +0100 (CET)
Date: Tue, 16 Dec 2025 13:23:59 +0100
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
Message-ID: <20251216122359.GS3707837@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>

On Mon, Dec 15, 2025 at 04:53:18PM +0100, Marco Elver wrote:
> One observation from the rebase: Generally synchronization primitives
> do not change much and the annotations are relatively stable, but e.g.
> RCU & sched (latter is optional and depends on the sched-enablement
> patch) receive disproportionally more changes, and while new
> annotations required for v6.19-rc1 were trivial, it does require
> compiling with a Clang version that does produce the warnings to
> notice.

I have:

Debian clang version 22.0.0 (++20251023025710+3f47a7be1ae6-1~exp5)

I've not tried if that is new enough.

> While Clang 22-dev is being tested on CI, I doubt maintainers already
> use it, so it's possible we'll see some late warnings due to missing
> annotations when things hit -next. This might be an acceptable churn
> cost, if we think the outcome is worthwhile. Things should get better
> when Clang 22 is released properly, but until then things might be a
> little bumpy if there are large changes across the core
> synchronization primitives.

Yeah, we'll see how bad it gets, we can always disable it for
COMPILE_TEST or so for a while.

