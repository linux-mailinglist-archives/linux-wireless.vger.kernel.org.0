Return-Path: <linux-wireless+bounces-29997-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB8ACD1EAD
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:06:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8452B301AD30
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B88D12EC56D;
	Fri, 19 Dec 2025 21:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="jMBK/0Ab"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B6B3A1E7F;
	Fri, 19 Dec 2025 21:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178373; cv=none; b=uX6mzMdCizJn3ZiznlfckmxsPPUQG7j/0e8VGkLFyEtmo52PI7ubq1ZmzOUk6Q1ert8x8tF4F9fVAOzXcf56EgdpryDz2Z7oDjenbG9i5a5LZfYBc/Eidw1IIJ0wpDS5Q4Pwqzv4HsxOCpOwhINJGzX591ml02OPGmCX6HBMAHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178373; c=relaxed/simple;
	bh=KbLUB8IaJRvBl5lXgJ7Cs0r+YarnKCWMUwz4SWOikvM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m4gZz7kvlehJ+00MAEDrOdIHeLAizYMJbLJxnm/5IQ09kkiElYuejMnhiPiXF0C8EmojjlRInKb4Hx1br4U+xLD3SnkrggSat1KcnKDqFBmUsM3sjD9dz6yDARK9VQmizkBssMg0Gv5d5VinWwgEZCG9FEWL7B8qaJyRAXIx2VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=jMBK/0Ab; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY0Sg4hrkzlvrT5;
	Fri, 19 Dec 2025 21:06:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766178370; x=1768770371; bh=smhZ+HMOPx/2qzqSsA1Ia7Ur
	+56UUYwNTrJDmSp3Lho=; b=jMBK/0AbAtObVFEFGviFLd2RSGaWuq0MAxKdU02G
	csnZEprY+hImGlfEAhOTFq+h5rnQaM7VHafuASxqWGyDHaw+2PK5azXLOnpBxURK
	7d9Eudp1J0mEa6n7oGefbSNAGm+DkaxRe6zj7ys8WEX953jVrGb2141cDLFyV64p
	PY9Hm2txcunb3mLXPyZloggZFYO/Gt/U8gYZ5GydPBxr+sjlJQWxDQHCsft72r3p
	7DMLSNSfmAh7dxoaB7TdT5NRNQTebgHE3VfsKDvyABMAQfRodM6sPf5BNhshXrq2
	pHHXLH/pCwtGLOylB0JTDpyma6sR18QIWROADirf8OtQdQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rkRyf9NcgFjM; Fri, 19 Dec 2025 21:06:10 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY0SP39w9zllB6t;
	Fri, 19 Dec 2025 21:05:57 +0000 (UTC)
Message-ID: <8086c568-9386-4231-b928-3e887c8679b4@acm.org>
Date: Fri, 19 Dec 2025 13:05:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 22/36] um: Fix incorrect __acquires/__releases
 annotations
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
 linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org,
 kernel test robot <lkp@intel.com>, Johannes Berg
 <johannes@sipsolutions.net>, Tiwei Bie <tiwei.btw@antgroup.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-23-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-23-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:40 AM, Marco Elver wrote:
> -void enter_turnstile(struct mm_id *mm_id) __acquires(turnstile)
> +struct mutex *__get_turnstile(struct mm_id *mm_id)
>   {
>   	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
>   
> -	mutex_lock(&ctx->turnstile);
> +	return &ctx->turnstile;
>   }

Many "container_of()" wrappers have "to" in their name. Please follow
that convention and rename this function into e.g. mm_id_to_turnstile().

Thanks,

Bart.

