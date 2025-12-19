Return-Path: <linux-wireless+bounces-29984-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 258AECD1CC6
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 90252307A201
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5531D2D9792;
	Fri, 19 Dec 2025 20:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="23ejbMoW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E59D62D6E67;
	Fri, 19 Dec 2025 20:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766176735; cv=none; b=WY8dvnsMs3B5N7bo4s8RJsfmwWRLE6RYeII8E8cIwmiikuv3nJvIl2Axdg8x4XJjAAgdI6QH4P3Iz2uLq0GgYwWE3IJWkVTLofSXnRZ0JEfICoZbWCriPW5eL5N+ZrEJ+uHESmVvV5a/JqCh0C5Ub63jiaRkXbooVj50RjMh3U8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766176735; c=relaxed/simple;
	bh=CZxWxdGzalfuaJeqiULERsX6sGBwBWd6pLNQFv3wUGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qaV3EHPrkoMN5CCoA3JSnK/7l+rfPDrQ/AzPU/qUxh4T7/kRZJ2Dgfrrr+aIGbxDQXGQpTqKRczY9W5IQOOH+dXXn8F9yvfndK3C+9g5xrYHDatFm47U7M9om46/BZXwlfX0w+oIlXc9MQpYAgllIA5LfLwEC9C721ObUFpkkv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=23ejbMoW; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dXzs815rqzlwqPy;
	Fri, 19 Dec 2025 20:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766176724; x=1768768725; bh=M2FKNH25BsSSupvqYh8XNhuf
	T7PJPLlufiLItK/K4/Q=; b=23ejbMoWSMGXSBFPZlmUzRtGna4H5HROcPKMbUup
	V/WdRBWbup4GDNoX4ZzYi/+9a2QxQyjFpfuEdRS5ewl/8ts1Xxp1RTcZSs54u6Ol
	V4+ys1ry+a515MDuanbl0Ud7DP9g1ofFdkwrrR83EYCeIoXuBBDi8v0Mx6Otj3WI
	eXu2aS2vAeC+/lTfWViepaxFvMNipVgj+00o7/6Ytj/CfDmAbV43JA319Vk62LAg
	y8BnF8cLm6gyyRXsKaD6m8R0XZAZMGGmDVyQ2i904nnISBAr0ieu6hnDNx9oLGke
	a0C4gG35l9QIBTC0Lq9pBQ+IlBmqQe7BkmR8IZhBjfK2WA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id MkJHsfOVfhWT; Fri, 19 Dec 2025 20:38:44 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dXzrm6hBtzlwqPY;
	Fri, 19 Dec 2025 20:38:32 +0000 (UTC)
Message-ID: <61037092-ddfb-4504-9351-7f6a3e5e4616@acm.org>
Date: Fri, 19 Dec 2025 12:38:32 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 12/36] bit_spinlock: Include missing <asm/processor.h>
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
 <20251219154418.3592607-13-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-13-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:40 AM, Marco Elver wrote:
> Including <linux/bit_spinlock.h> into an empty TU will result in the
> compiler complaining:
> 
> ./include/linux/bit_spinlock.h:34:4: error: call to undeclared function 'cpu_relax'; <...>
>     34 |                         cpu_relax();
>        |                         ^
> 1 error generated.
> 
> Include <asm/processor.h> to allow including bit_spinlock.h where
> <asm/processor.h> is not otherwise included.
> 
> Signed-off-by: Marco Elver <elver@google.com>
> ---
>   include/linux/bit_spinlock.h | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index c0989b5b0407..59e345f74b0e 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -7,6 +7,8 @@
>   #include <linux/atomic.h>
>   #include <linux/bug.h>
>   
> +#include <asm/processor.h>  /* for cpu_relax() */
> +
>   /*
>    *  bit-based spin_lock()
>    *

The abbreviation "TU" is uncommon so it's probably a good idea to expand
it. Anyway:

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

