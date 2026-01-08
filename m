Return-Path: <linux-wireless+bounces-30583-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 98222D0667E
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 23:11:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5A82B3013EEA
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 22:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88370322B64;
	Thu,  8 Jan 2026 22:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="y3DnIpMC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FDD2F39B5;
	Thu,  8 Jan 2026 22:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767910254; cv=none; b=eIjfP4fuQlK47m4pGdvOrFJNWmLKHkqjTAS9ZUfygYbPxgTE9x/N69MkA4P9dlzFCu1zxK6VLL+3d7MDrHQQAlnRR4TkTaaRAb7qKQNJycwkW9OOmPRhxsOrCVfk5mWW2vCt0LSZ53jNDFi5LYqSIIxzQWGwpForbymN9R/VEUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767910254; c=relaxed/simple;
	bh=Zrh6g3iqQucP/rJuVPvG/r1wbhapoAMvUjp8oSDN/3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZGxoPMA4sgdkuxU2OlMaha98jEK/GGGw9tbduEwb1fVYq+Jy7o7aaUSx9ezZ3XtxxGexGNALlqAiGwVHC9k5YQOviddeW+O11yiFgTCHrLPc014sNo1Vu3QLdp12VmkvJMvUkRk5x3V3N5QuYgS6d/1/QPdggZaFxotPPEmlQng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=y3DnIpMC; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4dnJxx5cFFz1XT1Z9;
	Thu,  8 Jan 2026 22:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1767910237; x=1770502238; bh=9wcZSTi8w0Set4rh18vUE4zP
	r/D6QOeIA+Se4D2Yz7E=; b=y3DnIpMCSQnKfEQcNUdJmBRbcLno92oeKfo+WMYi
	GH7blNKN0irLymfpBF3Hg2QDn+bUOND9Ph7+2f+3JOuxuWVyZeHsX/eUX6nr4u42
	Xo2+GsL+38yL5abFm2PTOhHHNbpFxaViFrEYePNdHtMs7t66UhI3rEcsqAbQ0git
	yvIzwW2Puf3sh2g2Yh6ypqckaBLqa3pUBV8iuttx96qnQS6WndngwpK8KdYd2a1p
	gWKipnbDHZpiaajmh8SgTT8KCPLDjeAtbIOlGRsmWTvjAkHdDpnNsQrr3OZChyg8
	yuKl6RyxlRCmlJ0VSvSzQ99QFu2RTNvj4T9gnBxHCvPCnw==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id 2VIQQt_5Aq81; Thu,  8 Jan 2026 22:10:37 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4dnJxZ1xlYz1XZYyy;
	Thu,  8 Jan 2026 22:10:26 +0000 (UTC)
Message-ID: <57062131-e79e-42c2-aa0b-8f931cb8cac2@acm.org>
Date: Thu, 8 Jan 2026 14:10:25 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/36] locking/mutex: Support Clang's context analysis
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
 <20251219154418.3592607-11-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-11-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:39 AM, Marco Elver wrote:
> diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> index bf535f0118bb..89977c215cbd 100644
> --- a/include/linux/mutex.h
> +++ b/include/linux/mutex.h
> @@ -62,6 +62,7 @@ do {									\
>   	static struct lock_class_key __key;				\
>   									\
>   	__mutex_init((mutex), #mutex, &__key);				\
> +	__assume_ctx_lock(mutex);					\
>   } while (0)

The above type of change probably will have to be reverted. If I enable
context analysis for the entire kernel tree, drivers/base/devcoredump.c
doesn't build. The following error is reported:

drivers/base/devcoredump.c:406:2: error: acquiring mutex '_res->mutex' 
that is already held [-Werror,-Wthread-safety-analysis]
   406 |         mutex_lock(&devcd->mutex);
       |         ^

dev_coredumpm_timeout() calls mutex_init() and mutex_lock() from the 
same function. The above type of change breaks compilation of all code
that initializes and locks a synchronization object from the same
function. My understanding of dev_coredumpm_timeout() is that there is a
good reason for calling both mutex_init() and mutex_lock() from that
function. Possible solutions are disabling context analysis for that
function or removing __assume_ctx_lock() again from mutex_init(). Does
anyone want to share their opinion about this?

Thanks,

Bart.

