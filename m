Return-Path: <linux-wireless+bounces-29995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C09ACD1E6E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:02:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7ADFA3014AE2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:01:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E3922D660E;
	Fri, 19 Dec 2025 21:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="s9OJBwkd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADF12D5A01;
	Fri, 19 Dec 2025 21:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178110; cv=none; b=Xoxla2zGVGNvUqtLWzK/vvP9qbLkTtQj0Wf9/MqDGCuLUZjLC8mciBn6CW088iNJ78XqT7OeqjGk+cy/M1PG/D9s8a6bUjbYYRHK8oHt35aXPoRc3mQ/Dlu7AHq2ZRvpB7p3ROZkEV5w6oG2TJA94SvSPmlM+q0yvAs1nhcz4po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178110; c=relaxed/simple;
	bh=MkDUjQNs27Lw1dXpmCJjBTZs8R/jJJRn5FiTSdyMBac=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qE9Q8Tt1X9+TopPETHkbvkQU1LVkXAv9f0YWj27iYn3hNcT0ewk/OcLdjeuX21G4y22ujiG9v8n1hPP82Z1FK3URngG20K/Aetb2WlYBSaIhiWXUoBqCL0c9xskze+uowzG0txbMfaViI1ihIEGv/lsEaWIgmuYhHZOECcFZHP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=s9OJBwkd; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY0Mb6PP5zlxr5f;
	Fri, 19 Dec 2025 21:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766178100; x=1768770101; bh=9KjTqulqtSqtlYJ8kiScMrzE
	zgfg45JI8uubNScSnWY=; b=s9OJBwkdhoRjw1wT9W38EQGW90jCfITJQ4Dj5Ydm
	WkQeHjsl/TckZ0nDw8xfVOYGZw5litIkS9f3OXuZwzO3hTtugFky8jXGfceKpZDV
	U1wEoqDkAkOMwveLyjPBCCVL2v2gxTQ7x/fhl18iwptJc48fGOosD/Ijsbi7r/ca
	rtNB5lMYdEKIxVGwaqn1+m/eMvK94sr4xGOge9D31/73d4nxhOva8PPSQvnMQRHF
	+dGUczfKiOfUUVvzbKqIDczdov8eJDoRYazYFGQ2jKTEyiBdQxt7MumMuAFABlVU
	GcwDY+4yUv4P2PoxCQif8fbXLJcwS0c/QHyFDMfcdKDinA==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IXqnKxjTN97r; Fri, 19 Dec 2025 21:01:40 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY0Ly622Wzlxr5b;
	Fri, 19 Dec 2025 21:01:13 +0000 (UTC)
Message-ID: <a62c731f-7ff5-48a0-8700-b62cd163f369@acm.org>
Date: Fri, 19 Dec 2025 13:01:13 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 21/36] debugfs: Make debugfs_cancellation a context
 lock struct
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
 <20251219154418.3592607-22-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-22-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:40 AM, Marco Elver wrote:
> When compiling include/linux/debugfs.h with CONTEXT_ANALYSIS enabled, we
> can see this error:
> 
> ./include/linux/debugfs.h:239:17: error: use of undeclared identifier 'cancellation'
>    239 | void __acquires(cancellation)
> 
> Move the __acquires(..) attribute after the declaration, so that the
> compiler can see the cancellation function argument, as well as making
> struct debugfs_cancellation a real context lock to benefit from Clang's
> context analysis.
> 
> This change is a preparatory change to allow enabling context analysis
> in subsystems that include the above header.
Reviewed-by: Bart Van Assche <bvanassche@acm.org>

