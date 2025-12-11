Return-Path: <linux-wireless+bounces-29647-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E8EECCB5B01
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 12:44:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CC5130184C2
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 11:44:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1ED8309EE2;
	Thu, 11 Dec 2025 11:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="uIJmfimn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B92030498E;
	Thu, 11 Dec 2025 11:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765453485; cv=none; b=rpN6lOnpCyTvC2P3x4FK2FSt/YO/F3qKcxP7yU2cUR2diXrntvQb0FD7y5NYjGytNVrToT7lXBkHlhiXVEviL2IVSMka8/FqlSB9u5H2oDvNh0gBVG5rDpd1LlpUvucy7zU22V8ou/TKcYJDoI8q9cylXoK1szzFI7PfsyzEB4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765453485; c=relaxed/simple;
	bh=58/Ao+s84qwJwv4zr3xEZigLVkU0Pj6c3+rIe/4WF8M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SfqXpjDt1yqCLJrmeIQLFvjs5twhToUscDAaOt6yhIKn0l05i1bgzfTKRyXsZcZhbhg5eoiTzuuwAaZL95JBBTQGwPjFMx42F9dtJpFK3HbtJdMnXz6kPFq5MtDvxHu3dq4Q1waWvIswYFmWPj8DmKSm0TdtH+sVnb2TrX22vis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=uIJmfimn; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=1Xyvz2EmetVTqNxA3ooND6KrVryVhRTmeDWJ7L8+Veo=; b=uIJmfimnlNHvC/G7x6PPflA13K
	lshdJGbQZ4Hj6U3gBt+qTwrd7U8BHV3bTjJFXW5qDlWjqGZEsKv1RsQk1E0GucLcbJGz3KswikKF3
	FC9DO6iNWOf6K4jpEp8JjNWgtpdSRXEXFrNc2CLESx/naRoQs54Gzizq9ktTzAzRlq9Z5+clz0NEx
	k3OH+xn15/MmfudhJetIFZG31/V4Z7jkj3+XQEqjINgec//KCLdIEKn1mk9FdcfkcSlQqdLKwxrM7
	pm8yeej2PowuoHC6yP98kzuZOludbZHHtNOyU0VV+rXNKI4WmbwiV4TtB8qVZsgsvBZvLZxCpvSrr
	AuH3zvWQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vTf60-0000000EBKA-0bcG;
	Thu, 11 Dec 2025 11:44:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id AF7D630301A; Thu, 11 Dec 2025 12:44:31 +0100 (CET)
Date: Thu, 11 Dec 2025 12:44:31 +0100
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
Message-ID: <20251211114431.GD3911114@noisy.programming.kicks-ass.net>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120145835.3833031-4-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251120145835.3833031-4-elver@google.com>

On Thu, Nov 20, 2025 at 03:49:04PM +0100, Marco Elver wrote:
> +/**
> + * __guarded_by - struct member and globals attribute, declares variable
> + *                only accessible within active context
> + *
> + * Declares that the struct member or global variable is only accessible within
> + * the context entered by the given context guard. Read operations on the data
> + * require shared access, while write operations require exclusive access.
> + *
> + * .. code-block:: c
> + *
> + *	struct some_state {
> + *		spinlock_t lock;
> + *		long counter __guarded_by(&lock);
> + *	};
> + */
> +# define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))

I must express pure hatred for this '.. code-block:: c' thing.

