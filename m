Return-Path: <linux-wireless+bounces-29985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA71CD1DA4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E8202310F6F9
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE97338595;
	Fri, 19 Dec 2025 20:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="yvRF6QOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC313242B1;
	Fri, 19 Dec 2025 20:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177285; cv=none; b=TBKfFUWSZJHw/oTBwOEGxgaR11MnmGStJnvwF1G6r1UEtGhRmDxX77AeFvR8CEzEGoDBq8i9HEvYlyoGiSB8q9eAqF6LsNpCV7Xzi35tOO9I8bDmx3k2o+f/EQgriacMHCluNXPvT+rMz+LykyVGxuAeT0Q9f39BWKTIxUx72iE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177285; c=relaxed/simple;
	bh=RpTDLGmqmvX91HRlulscWF8eEEmxcYbVfxnBODEf7Fc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaHpgrQ2MjREuDeQNYsgWnyWjTx4G2u4L5DMf1XBZhsu/G1qM8IxQ5NsHN+8m0TwMwawDXOHTJPubNYJDYfy1lK5QafIfCe0qjwnN7m+sGBOHnqQaUHEv/IhM/a/GdOPW6MqKWmFjDdkxsSoLMPIDHOEh0/5fX71hS1FpX0M7nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=yvRF6QOZ; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY03k3PBFzlqfwx;
	Fri, 19 Dec 2025 20:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766177275; x=1768769276; bh=RpTDLGmqmvX91HRlulscWF8e
	EEmxcYbVfxnBODEf7Fc=; b=yvRF6QOZG6UHkzlDEI+784Z3F6GrQK/qbhDhyH/q
	M0VmZ1z5qrHfAYDtPV8Dk/4in6+gahQxa1lbZ1Jo6c9wtCyIYJGMKW//Odp+W+WN
	kP75zw9/8DlRJ+zhV6IQnwokulJ8QNP5RFHBufnRbn7Bu+UomFMF1zl0CcA6lGHQ
	qNkHLoupGo+gAFxdviBTwFsmv7lpmbSZGX3B0nYorvFBAjGXtIEDutsEekW/XB+L
	aBqbyKoEpOUB/D4Xqjq9vrPvyll5guVFPGo5cn7XZCahnqCDjsHt/bWPsvysAyBk
	i+SiyJwUkfkxqvnCbKDjxUarusC1UNbaLpXOezGEXmcqGQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id RwSAk9NGYx7Z; Fri, 19 Dec 2025 20:47:55 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY03N45hpzlvrT5;
	Fri, 19 Dec 2025 20:47:44 +0000 (UTC)
Message-ID: <3b070057-5fda-410e-a047-d9061d56a82f@acm.org>
Date: Fri, 19 Dec 2025 12:47:43 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/36] bit_spinlock: Support Clang's context analysis
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
 Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>,
 Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>,
 Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
 Eric Dumazet <edumazet@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>,
 Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
 Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>,
 Josh Triplett <josh@joshtriplett.org>, Justin Stitt
 <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
 Kentaro Takeda <takedakn@nttdata.co.jp>,
 Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>,
 Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-14-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-14-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:40 AM, Marco Elver wrote:
> +/*
> + * For static context analysis, we need a unique token for each possible bit
> + * that can be used as a bit_spinlock. The easiest way to do that is to create a
> + * fake context that we can cast to with the __bitlock(bitnum, addr) macro
> + * below, which will give us unique instances for each (bit, addr) pair that the
> + * static analysis can use.
> + */
> +context_lock_struct(__context_bitlock) { };
> +#define __bitlock(bitnum, addr) (struct __context_bitlock *)(bitnum + (addr))

Will this cause static analyzers to complain about out-of-bounds
accesses for (bitnum + (addr)), which is equivalent to &(addr)[bitnum]?

Thanks,

Bart.

