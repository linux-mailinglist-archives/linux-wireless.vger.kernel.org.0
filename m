Return-Path: <linux-wireless+bounces-30593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 349D8D074F7
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 07:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7518530424A7
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 06:02:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B2A2773EE;
	Fri,  9 Jan 2026 06:02:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87B528F949;
	Fri,  9 Jan 2026 06:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767938578; cv=none; b=cfs991zJpX1nhL3h47mOFbgzzoAb0tt+cife4B9AHBaXdCCMeZZgXaFaLXuhP0qLl1HRjgJJGQUxlUbQbBXldnl62ifLtji+hzFiEJzKDjLXlj9XOwDEiDGybOe1YoZetI5DcJrj4IwpnBgosbskKxk3P/jyVJ30JdLmMhjSark=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767938578; c=relaxed/simple;
	bh=kjrPdLo2LuEMuL3ltra9YWkafT3XliJSnrixgwe1OgY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sEm1P9RHk3XvYX54MDslVI5bhlPMmAn0E01vx6M5jxasVruC+M3htQFZJwrDdTMl0w05Eg9z8TYrpZsbdttmDuNw6AGegmVfiQs8xzzsfsGZx+x0G3ZwMQO8oI2zQKnnsuKlqh7ArlyqKVJvzoxjsTuvVPW65RJJLf4oRLJGGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 5106967373; Fri,  9 Jan 2026 07:02:49 +0100 (CET)
Date: Fri, 9 Jan 2026 07:02:49 +0100
From: Christoph Hellwig <hch@lst.de>
To: Marco Elver <elver@google.com>
Cc: Bart Van Assche <bvanassche@acm.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH v5 10/36] locking/mutex: Support Clang's context
 analysis
Message-ID: <20260109060249.GA5259@lst.de>
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-11-elver@google.com> <57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.org> <aWA9P3_oI7JFTdkC@elver.google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aWA9P3_oI7JFTdkC@elver.google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Fri, Jan 09, 2026 at 12:26:55AM +0100, Marco Elver wrote:
> Probably the most idiomatic option is to just factor out construction.
> Clearly separating complex object construction from use also helps
> readability regardless, esp. where concurrency is involved. We could
> document such advice somewhere.

Initializing and locking a mutex (or spinlock, or other primitive) is a
not too unusual pattern, often used when inserting an object into a
hash table or other lookup data structure.  So supporting it without
creating pointless wrapper functions would be really useful.  One thing
that would be nice to have and probably help here is to have lock
initializers that create the lock in a held state.


