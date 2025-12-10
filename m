Return-Path: <linux-wireless+bounces-29636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69E73CB37E4
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 17:37:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFE2430050B6
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Dec 2025 16:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F4D30FF37;
	Wed, 10 Dec 2025 16:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BYu/J6AO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4E2296BC3;
	Wed, 10 Dec 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765384646; cv=none; b=DUQJpQw2dfw4wHA1Sv3rplNzJV/Dr+nfT596/Fu2lP/cjJcacSB6ltF1CcC4NfKU9R9NftE2LULkrRsHi59mn8cky3trJ3EL6Y92wRNqE2bLdJSlQ71jjmbapHITetMpvM+xNyi5jZ3VMXxMGwIyPIxDMtP7q2TSNy8BiHFeUFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765384646; c=relaxed/simple;
	bh=b86F98043TIz4TBzyPlogwDUHxoL8b6Vo2xwTeajqis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ujtkI5b9o2bOXRUv9f2rn1P2rfvnSzdwSVsLyhAuu+OCXndk8T6fh3Ci8t9GCRMPT9EqcsZ+ZRNy+0ufSy5wv0qikj6hiXuJj4OTER/Jn6jJgv3ZDgUxw5IzIU4M+gAYLmZWNAxLo5yWpLFxqob/SMcQlHh6LWPPg7jlSn0skSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BYu/J6AO; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=kgo0gn00i5ezpmur+oazSYFqerNtpx0n/NmNjZb+ZMg=; b=BYu/J6AOcF2tcc1KVJ32FxlxHU
	bU3jWS69I/gzoL5rBfMEk59+8SQbX3m1TlSNJJBxfMpkoI1KbFOV27y7QMVenzPHs2zsO9Sf9JDR/
	0uQ3VHyBkDCTe/IxD+Z6b87X+qxa2kKTWHsibvBOBaekXJ6QPk+VCsTlrEk0LXs6LqwXPIzUtPCHi
	DgQm6ujZfpSwd9uSbFR7ePLCGitwY5+n8wyOncj7wceU19MDKcL1WcIIAVXEvXl9cAjIOPG8mYxWw
	6JMAH/tcx3NXcdb2kiwaVULI21AwrcK3vWCo8+YKj4qPCyLpmW/tbyigfGqh1WkZkRrZSQx7w1fJ+
	QH9+jTew==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTMJz-0000000DbAQ-3Ck2;
	Wed, 10 Dec 2025 15:41:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id A3513300566; Wed, 10 Dec 2025 17:37:00 +0100 (CET)
Date: Wed, 10 Dec 2025 17:37:00 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Marco Elver <elver@google.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
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
Subject: Re: [PATCH v4 00/35] Compiler-Based Context- and Locking-Analysis
Message-ID: <20251210163700.GN3707837@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <aTmdSMuP0LUAdfO_@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aTmdSMuP0LUAdfO_@elver.google.com>

On Wed, Dec 10, 2025 at 05:18:16PM +0100, Marco Elver wrote:
> All,
> 
> On Thu, Nov 20, 2025 at 03:49PM +0100, Marco Elver wrote:
> > Context Analysis is a language extension, which enables statically
> > checking that required contexts are active (or inactive) by acquiring
> > and releasing user-definable "context guards". An obvious application is
> > lock-safety checking for the kernel's various synchronization primitives
> > (each of which represents a "context guard"), and checking that locking
> > rules are not violated.
> [...] 
> > A Clang version that supports `-Wthread-safety-pointer` and the new
> > alias-analysis of context-guard pointers is required (from this version
> > onwards):
> > 
> > 	https://github.com/llvm/llvm-project/commit/7ccb5c08f0685d4787f12c3224a72f0650c5865e
> > 
> > The minimum required release version will be Clang 22.
> > 
> > This series is also available at this Git tree:
> > 
> > 	https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=ctx-analysis/dev
> [...] 
> 
> I realize that I sent this series at the end of the last release cycle,
> and now we're in the merge window, along with LPC going on -- so it
> wasn't the best timing (however, it might be something to discuss at
> LPC, too :-) .. I'm attending virtually, however :-/).
> 
> How to proceed?

Ah, I knew I was forgetting something :/ I'll try and have a peek at
this series this week.

