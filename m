Return-Path: <linux-wireless+bounces-29981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60EF2CD1915
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 94C24301A731
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 19:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE31933FE01;
	Fri, 19 Dec 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="xlPNwaOS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BED333C52A;
	Fri, 19 Dec 2025 19:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171800; cv=none; b=a61ARnSnHQ9BWs823JyHDHRgod0/MUAisdo5Xh0jtKfVOQYIst85bCXjB1vAvvzQcm4kmGCMpuLpZCyDNPhVloowj07+jhkJQPEmQ1yGG6AwBgnSfkjY1kBW82L1v/XT1nbIMxGhjO1DUm1HiVBlPl7zOo7zgprTenAckeH2aBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171800; c=relaxed/simple;
	bh=qUK8wMbAq+gR/4DxN/s5iUHu54AsdjzohzUk+zyneYY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pT1ouZM5l/p2cqbJH6riB4dnFB577wo6myBta7VeCdiKu3UlmlZ4I7EFnd+DIdfISEArNvgc+bnyXZUkfhTgV9Ud53ZFe9t4yOu6UYsognMJmtUsJE4bm64vyLqzTF0/j3NhiOtdj+G9RUgpD2+7kuI42QGUbioZzSYgbFidKsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=xlPNwaOS; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dXy2G3SrRzlwmGs;
	Fri, 19 Dec 2025 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766171790; x=1768763791; bh=1d1QBQb0DaVer6VJvBPQjMip
	td3tuqlZ2ZCZ+5iT1Wk=; b=xlPNwaOSqS55oacKDxS5VHJW1eG+zFRK68hAmav2
	HEBWfm14o66rCOyR/8lRaTTTNFWfyer9OfLLqQVI9vQ4uww4GFmxCvKf/jw9MKMt
	cC5R34XygMp1hTaFaA3ZLzX3JbNMZUuLk+2Fn/RvXWr3YHYqV1lVZ+XEKxUsSnIv
	GpVLDlWSvwcTs6ssuRGT/XOxb009+othv9txBuH3W24r/98gFG6ysd8p1YkYWM7F
	WenbZkluwcT5WPWTukR2Hfmr4JLxhVObewGYlTZpnsZApLL1+tHVDpK8l0WIVVW0
	d9jjJOjoDRZeyH/o++wfO7y04X8X9fbXjVpMlTjiGJDSGw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id tXR7wglYQRQC; Fri, 19 Dec 2025 19:16:30 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dXy1p2cmLzlvwXP;
	Fri, 19 Dec 2025 19:16:13 +0000 (UTC)
Message-ID: <9d548e47-82c0-4f81-8a53-faee09d22b15@acm.org>
Date: Fri, 19 Dec 2025 11:16:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 06/36] cleanup: Basic compatibility with context
 analysis
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
 <20251219154418.3592607-7-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-7-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:39 AM, Marco Elver wrote:
> +#define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
> +static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
> +static __always_inline void __class_##_name##_cleanup_ctx(class_##_name##_t **_T) \
> +	__no_context_analysis _unlock { }
Elsewhere in the cleanup.h header arguments with the names "_lock" and
"_unlock" hold executable code that perform "lock" and "unlock"
operations respectively, e.g. mutex_lock() and mutex_unlock(). The
DECLARE_LOCK_GUARD_1_ATTRS() "_lock" and "_unlock" arguments however are
function annotations. Please prevent confusion and use other names for
the _lock and _unlock arguments, e.g. _acquire_attr and _release_attr.

Thanks,

Bart.

