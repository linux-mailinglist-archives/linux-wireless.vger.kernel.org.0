Return-Path: <linux-wireless+bounces-29978-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A158CD1840
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:01:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27501306CF7A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 19:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCBF2D8DA8;
	Fri, 19 Dec 2025 19:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="UjD9F4cw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715DD2561A2;
	Fri, 19 Dec 2025 19:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766170823; cv=none; b=d+GDhzhaONWIyg861PF7NcN/JkuH/sAV8CnWv4efrfYEpYJhQDizJRsEyHelLzklpdiDw90PQGzpAfDqU6z/5KeVaZmDh2vwLP7ZrOB65VfjDL5uB+eZjDsaGfw/NuCdpwsWhERF53Bo5ahPB4gPRZVcF4vXur7oorEn8Ug+RVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766170823; c=relaxed/simple;
	bh=ePVSZjUMvM5UwcnAVR7UWrqjg1Vrw8j5vSX/Uk6yy0Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JrwYKSiOGazzEjJwabAuKMBkFdaM9o9NACJPHcyl9igc7KYn9cbwgPP+vbvNQUHk59xgq18Tdju6qGH01pgmm5FoWLyHRZy8kmODO+/bsgfgyhfeGQVP3hao/vx098D7N3S41+IrXFZ1BMpeBowvmRhhA5dTcJnK5ibz4b5VxUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=UjD9F4cw; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dXxgS5FtLzlvrT5;
	Fri, 19 Dec 2025 19:00:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766170813; x=1768762814; bh=ePVSZjUMvM5UwcnAVR7UWrqj
	g1Vrw8j5vSX/Uk6yy0Y=; b=UjD9F4cwVPH0tWHDaelPuqlhc+2YTxTbndSefpWT
	po3XBept/JAFVJlKDP0H+iWdyE9vzebm4zie+0CTa+RCNEdUNPw56SgQTVCCE5Fe
	VVrq/ZYjIVLlOn4zsgLjPAU6gEetYUkmXEx+IlbFWuAQjhniwyCqudbL49xsJV5s
	V3fezX1THeOXM767I+teAsn088t3APhcDxHPLaXnNFkoJuGfEOlrNd4Sc41SvPmI
	He5W0DOYCpNqfvJ6nHco8LxDf8cRtI39bsR3f8T3akCr/vM4Ao3/Y0X/wqah9zGY
	cIse1t6O/qxZcmsN2ajDouGqT+5p6mlzod3Nak5uvCrQiA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XxrjPaU1Y7x5; Fri, 19 Dec 2025 19:00:13 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dXxfz4M91zllB6t;
	Fri, 19 Dec 2025 18:59:55 +0000 (UTC)
Message-ID: <1df1695e-778a-45da-9348-61f9ea34a862@acm.org>
Date: Fri, 19 Dec 2025 10:59:54 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
To: Marco Elver <elver@google.com>, Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>,
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
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
 Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
 Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>,
 kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org,
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/15/25 7:53 AM, Marco Elver wrote:
> For cleanup.h, the problem is that to instantiate we use
> "guard(class)(args..)". If it had been designed as "guard(class,
> args...)", i.e. just use __VA_ARGS__ explicitly instead of the
> implicit 'args...', it might have been possible to add a second
> cleanup variable to do the same (with some additional magic to extract
> the first arg if one exists). Unfortunately, the use of the current
> guard()() idiom has become so pervasive that this is a bigger
> refactor. I'm going to leave cleanup.h as-is for now, if we think we
> want to give this a go in the current state.

Peter, has it already been considered to make the guard() and
scoped_guard() macros more consistent? If there would be agreement that
guard(class)(args..) should be changed into guard(class, args..), I can
help with realizing this conversion.

Thanks,

Bart.

