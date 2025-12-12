Return-Path: <linux-wireless+bounces-29705-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D63AACB87E8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 10:38:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8C5A30AAD75
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 09:34:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1543148BD;
	Fri, 12 Dec 2025 09:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gP5FiKEc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385B313551;
	Fri, 12 Dec 2025 09:34:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765532043; cv=none; b=J1bH5cHY3ckqB8q+6qGb9TbmzXdHnL25HmmE+x9g/ZixS9GRlGPl44l/eMWCCu4AuYQdwFvFQhTJSd4jnY+WXLtYCp/wVHfdu/seXdAX1av4y7rCDCWtv4p7NDx16qALqgM6KC5Jkw4refWWHOnrAKf+LJDL6dtFVQTaBhZvU5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765532043; c=relaxed/simple;
	bh=GW71wNZ8+Fsd1OdwnYLm5FFt+hCLN6fs9aPvg42ygdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Up3S5v3M4piqqn8E6X1YwbGFIea9zYZ8Nj7vrC8nFJP5SNaFp3/FmFaJXL3m1Y4Vh8XA1KntMJUsMli6cAaxrV03aanyPNPiKiZvzkqJYUtTBsz0jfb6w3iHu2NkvfdH+1bQ9afGuWuTejFD1jLeWrYROt+E+MPhSjkfzsG2fKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=gP5FiKEc; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pQbWCtHdrI7qQ4N4sW7tS14xKqY+Ou7bmuq3drTQLtI=; b=gP5FiKEcmRnzQyUehVXnsV1XLo
	4CcGaKrOQoiMISbVTofuAAzhJZgdbdZphc6+x1ybUzVkZ9ZIq+GUIyAW0RXaobcGzp3FoJSN6rFWv
	0yhVMGdMzV2vtNMeuYgu5t8Zyu42infVTLpV1cfat8gOQ0liRPhAl4eLgDj43ybPYnnQcKV+ONTXe
	Y/AKRBnafep3f9UBI2BEeoF+Qa7g1+EVNns6zvQakSyTIOu7q6cost+mJYrwRrG47Eqfq4pu7TD3X
	n20VKo6HKyEjEjh14xxcfmEYEjGZ4QZ5QEkUMmF28XCiymvyS8qAbpHBDAWhL6ziTxLJdrPEApNBc
	jWFa+7Rg==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTzWw-0000000FU4K-0MV6;
	Fri, 12 Dec 2025 09:33:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 08ED630041D; Fri, 12 Dec 2025 10:33:40 +0100 (CET)
Date: Fri, 12 Dec 2025 10:33:39 +0100
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
Subject: Re: [PATCH v4 16/35] kref: Add context-analysis annotations
Message-ID: <20251212093339.GK3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-17-elver@google.com>
 <20251211122636.GI3911114@noisy.programming.kicks-ass.net>
 <CANpmjNN+zafzhvUBBmjyy+TL1ecqJUHQNRX3bo9fBJi2nFUt=A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNN+zafzhvUBBmjyy+TL1ecqJUHQNRX3bo9fBJi2nFUt=A@mail.gmail.com>

On Thu, Dec 11, 2025 at 02:54:06PM +0100, Marco Elver wrote:

> Wrappers will need their own annotations; for this kind of static
> analysis (built-in warning diagnostic), inferring things like
> __cond_acquires(true, lock) is far too complex (requires
> intra-procedural control-flow analysis), and would likely be
> incomplete too.
> 
> It might also be reasonable to argue that the explicit annotation is
> good for documentation.
> 
> Aside: There's other static analysis tooling, like clang-analyzer that
> can afford to do more complex flow-sensitive intra-procedural
> analysis. But that has its own limitations, requires separate
> invocation, and is pretty slow in comparison.

I was sorta hoping that (perhaps only for __always_inline) the thing
would indeed do an early inline pass on the AST such that these cases
would not in fact require inter-procedural analysis.

