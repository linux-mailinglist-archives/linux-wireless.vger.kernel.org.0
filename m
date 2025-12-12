Return-Path: <linux-wireless+bounces-29704-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B5D3ECB87C1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 10:36:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 660023076818
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 09:32:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E9A313529;
	Fri, 12 Dec 2025 09:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="DMpgfaqC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB07C279DCC;
	Fri, 12 Dec 2025 09:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531937; cv=none; b=Y67D0XLuq/EkwhZHG/8jeXErTchIsFku2fYIhBc3sWzmEv6I9V8qg7L95sZlM0sjTFaOI5nqwivZWSRlm5skQURfbllq9BI/6TX3mp4UIvaNppAlVppjmkTpoN7Qd81Hh6mnkZ07xJTyA5Pyy2u2VIUQ2xTJDpW/YTlyZcu1TXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531937; c=relaxed/simple;
	bh=f9Da21adZQy/Oskm47YpQxay+GCPm29iHOfp24GOE3o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VhoL8J3z/jOh+HursG0/fEz4NFW/PS9h0/WAs0qevj4LAtH/2kwO9jXf53XTtqDfyv2fwlwSss4od2ODT1FpiCOjhS2SoKX4Xh3hQmRhp2muwEGsETGB7JPEg76aMG8+DE8BEn40cfoVfrNf/6xrLRE+NynTJi1g7fLYEFlTrBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=DMpgfaqC; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=7N1yRupjJwsCEjdeUujuXdzSn7k5Mwr4a3y236fW66U=; b=DMpgfaqCYynagwlYCabdmyw/Bp
	rUrSWkBegZ7jFRY2i5aeyB3mBsMgEJmvOI0UYVuZszBnKfB9R5n85wNsrF+pa+wV09POIzKpx0Plm
	5ztxDsDOKPs08ziIzR4xEbQLew7usFxnN7+f3OYd+0FRhq3UKr+eIQumIXme//DjvI6A17dnCDjOv
	UErEQ9Ybt3bC0AD21CkKRgFinT24xXYc+0CoUTjQkZa/8/sybPij8mY6g7IEQZKZbws0SII2upGj5
	Pm0cIgInYYSL26iTrbPz5JyXnVLmPXf+7T6z44avAqu0UsbtenM0BV7SHv+qf468Pez8BP7yUSJsv
	h8N4R/2w==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTyde-0000000GP06-2F8E;
	Fri, 12 Dec 2025 08:36:34 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 8C24F30041D; Fri, 12 Dec 2025 10:31:49 +0100 (CET)
Date: Fri, 12 Dec 2025 10:31:49 +0100
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
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
Message-ID: <20251212093149.GJ3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120145835.3833031-4-elver@google.com>
 <20251211120441.GG3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOyDW7-G5Op5nw722ecPEv=Ys5TPbJnVBB1_WGiM2LeWQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNOyDW7-G5Op5nw722ecPEv=Ys5TPbJnVBB1_WGiM2LeWQ@mail.gmail.com>

On Thu, Dec 11, 2025 at 02:12:19PM +0100, Marco Elver wrote:

> What's a better name?

That must be the hardest question in programming; screw this P-vs-NP
debate :-)

> context_lock_struct -> and call it "context lock" rather than "context
> guard"; it might work also for things like RCU, PREEMPT, BH, etc. that
> aren't normal "locks", but could claim they are "context locks".
> 
> context_handle_struct -> "context handle" ...

Both work for me I suppose, although I think I have a slight preference
to the former: 'context_lock_struct'.

One other possibility is wrapping things like so:

#define define_context_struct(name) ... // the big thing

#define define_lock_struct(name) define_context_struct(name)



