Return-Path: <linux-wireless+bounces-30024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 13E35CD2FC3
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 14:34:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4DA36300963E
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 13:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0219C21E082;
	Sat, 20 Dec 2025 13:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="JRF85bcV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4786B1B4224;
	Sat, 20 Dec 2025 13:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766237617; cv=none; b=a0G91FaMEZpde2sAn7GiUnPIILdpsaTwF/NCrMaiLj4643IQXENYtUQ/hU7G3eX5TjCpr0qLjkaH4DutersI3Q4qavellMLWfuA0/dgJMSB/d4Fh+rvacWn+/B0ZSUfas6UHDzBSSgqabMxmmJjWhCWhFxy7Jr7GanLYaLd9LOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766237617; c=relaxed/simple;
	bh=sd8MF34DcKU450XHBOHX76rfibz+4ayylz6CA0Z+S7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hBNobeAOry050Pslj3lt9dLYuqvM/6C7aKWc73g+51LzJy6jFw8ZsM1WjajjW9JdCPVZqBuc+jpOswsbqTpBochgl1Tm/stk8jmlfYNg71b8WJ2Dj7n39h1PAsPaex8hPBIE+SfunHE7DC/7PNWBTba7a5ekFllV9rHG0EwawD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=JRF85bcV; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=sd8MF34DcKU450XHBOHX76rfibz+4ayylz6CA0Z+S7s=; b=JRF85bcVfuUAbdlqGNRlYDFj2X
	MBZkp9kK6+DWxZ52qXPI17aJHnxE/PD7M59fMz0XlJkLJw11Z17OWWZbt5mZH1ys+rOn3Z1KDVB6S
	pu4iTEanoYUavMKRG903o1dahMZ0gDpPnnVx7+/+hgxgbEKW50uF8kBQ4HY+A+nfVPf7NwCSjB9tQ
	XFVRPahMmUPfQxml3WuS3Qv3Gc4CPdqRroheFVCf5xskR0ix6PWdP9YZCg3meap4C/doiZ3x74vL0
	lUxDktQDZJqJIqf19QBR8eASqGGVYD+WDF8aIslzL0CNI572PyCVjjutiJoMAXmXAHHze0S35TE0X
	1Sb5xwug==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vWwDb-0000000CS0m-1fEQ;
	Sat, 20 Dec 2025 12:37:55 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 0441C30057E; Sat, 20 Dec 2025 14:33:07 +0100 (CET)
Date: Sat, 20 Dec 2025 14:33:07 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>, Boqun Feng <boqun.feng@gmail.com>,
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>,
	Dmitry Vyukov <dvyukov@google.com>,
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
Subject: Re: [PATCH v5 02/36] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
Message-ID: <20251220133307.GR3707891@noisy.programming.kicks-ass.net>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-3-elver@google.com>
 <97e832b7-04a9-49cb-973a-bf9870c21c2f@acm.org>
 <CANpmjNM=4baTiSWGOiSWLfQV2YqMt6qkdV__uj+QtD4zAY8Weg@mail.gmail.com>
 <2f0c27eb-eca5-4a7f-8035-71c6b0c84e30@acm.org>
 <aUWjfxQ1fIZdxd-C@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aUWjfxQ1fIZdxd-C@elver.google.com>

On Fri, Dec 19, 2025 at 08:11:59PM +0100, Marco Elver wrote:

> > Many kernel developers are used to look up the definition of a data
> > structure either by using ctags, etags or a similar tool or by using
> > grep and a pattern like "${struct_name} {\$". Breaking the tools kernel
> > developer use today to look up data structure definitions might cause
> > considerable frustration and hence shouldn't be done lightly.

Its a simple matter of adding a regex to scripts/tags.sh :-) Also clangd
language server sees right through it as is. So all 'modern' stuff using
that will have no problems.


