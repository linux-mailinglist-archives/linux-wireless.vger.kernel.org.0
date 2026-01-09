Return-Path: <linux-wireless+bounces-30601-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EBCAAD0A685
	for <lists+linux-wireless@lfdr.de>; Fri, 09 Jan 2026 14:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7BE87306D709
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Jan 2026 13:07:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51B5835BDC2;
	Fri,  9 Jan 2026 13:07:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F612EAD10;
	Fri,  9 Jan 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767964025; cv=none; b=a2ztNGYwBKt0cU34PdFh5YMkA70C4T6/XVaJQjnL5x5PNgS0BSs3CyxTUcRN80hZSrFQXYazzJmgamfv7w8WcwgmB6yv1UYDSESBT1aT6qQvkpg43NOD9TOF8tR8xWhCgylCG/GDXXYTIOLT5wuIwOxOjc8jVryh0/TYR+kqrLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767964025; c=relaxed/simple;
	bh=I5Q9VQte+4cFW14Gz8D4egaODJhcInTga4GejSY4LNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uUs5nxC8Ontljgziu66/phRF7ShB9N3os14dCcZthpN0A95gCX8a4Eq6+YaC7yVHAf6P4lpiCxwMY07Y28DjaSP+m7/s+LFng+LezdZn0/APNv+W/nsIaW02O1eRY992Kl2DtOlCNvd0neusKlLbg9wnqgV6k5N9n0FZAz+yfnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 32BC75ACA9;
	Fri,  9 Jan 2026 13:06:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id A03A520010;
	Fri,  9 Jan 2026 13:06:44 +0000 (UTC)
Date: Fri, 9 Jan 2026 08:07:15 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Marco Elver <elver@google.com>, Bart Van Assche <bvanassche@acm.org>,
 Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Luc Van Oostenryck
 <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, "Paul E.
 McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>,
 Arnd Bergmann <arnd@arndb.de>, Dmitry Vyukov <dvyukov@google.com>, Eric
 Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu
 <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, Jann Horn
 <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, Johannes Berg
 <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, Josh Triplett
 <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, Kees Cook
 <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda
 <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay
 <neeraj.upadhyay@kernel.org>, Nick Desaulniers
 <nick.desaulniers+lkml@gmail.com>, Tetsuo Handa
 <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>,
 Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman
 Long <longman@redhat.com>, kasan-dev@googlegroups.com,
 linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-security-module@vger.kernel.org,
 linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
 llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v5 10/36] locking/mutex: Support Clang's context
 analysis
Message-ID: <20260109080715.0a390f6b@gandalf.local.home>
In-Reply-To: <20260109060249.GA5259@lst.de>
References: <20251219154418.3592607-1-elver@google.com>
	<20251219154418.3592607-11-elver@google.com>
	<57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.org>
	<aWA9P3_oI7JFTdkC@elver.google.com>
	<20260109060249.GA5259@lst.de>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: xo5wgurkrpym6obtb6d77z4eqezppqwq
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: A03A520010
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Yuy/xlEJ4FchBK8FGPRyEzpxFlfJw7cM=
X-HE-Tag: 1767964004-230449
X-HE-Meta: U2FsdGVkX1/mK5KxM694kU63Rdn/iZMuRkOJbrkqpBY9gVZfABZTPJnGV+GXEC41f1CraOV8yVb8JwE6ex2vbV4aoxOT3VLKLF5Thmk+n9vBrpyyHnFtGdrkM3exSJJfO3l1oVR97XyrKK8Hkfj/5sdmmAH04zSgJDoYobVhPLcJaqT68Q0XdWN9PbI1sOsFrspcL2fHNGmrmo/p6rwpjlSypMilSM5I5ewwgNFo1hyODxJhs+YqTtFErumcaYRIY1tmmRLhIj0JwjIBTskcyNNIQY/Qv4I7CCtQ3inbL2pdKc5Mrj40SiW4O33CrPwJHtQvEPJd1GEXqrywF3gfPLCE0T+XQaZa

On Fri, 9 Jan 2026 07:02:49 +0100
Christoph Hellwig <hch@lst.de> wrote:

> On Fri, Jan 09, 2026 at 12:26:55AM +0100, Marco Elver wrote:
> > Probably the most idiomatic option is to just factor out construction.
> > Clearly separating complex object construction from use also helps
> > readability regardless, esp. where concurrency is involved. We could
> > document such advice somewhere.  
> 
> Initializing and locking a mutex (or spinlock, or other primitive) is a
> not too unusual pattern, often used when inserting an object into a
> hash table or other lookup data structure.  So supporting it without
> creating pointless wrapper functions would be really useful.  One thing
> that would be nice to have and probably help here is to have lock
> initializers that create the lock in a held state.

Right. If tooling can't handle a simple pattern of initializing a lock than
taking it, that's a hard show stopper of adding that tooling.

-- Steve

