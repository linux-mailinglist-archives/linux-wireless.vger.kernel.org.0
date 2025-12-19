Return-Path: <linux-wireless+bounces-29979-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8DACD189D
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C82130402D2
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 19:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F28C2FF653;
	Fri, 19 Dec 2025 19:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="boeNGRJs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90582C0F93;
	Fri, 19 Dec 2025 19:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766171116; cv=none; b=TcLXQK7UhwZ+lpGPJNHVpkYzsHQAag3zEpMkHlWAFzL8AjkxzYQ02gwMBEtyQblKSSvURkx5DAFlfYZaeoBXyxFNfjZ1jtoLWDJCQKpsl4zdgun9GsewwD9cUzeH+R7taz8NcwzTEoDkyWylTVORHLTBjom2rbbpE79jWUMmo/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766171116; c=relaxed/simple;
	bh=GUlTKYNsj0V7yELs8AVES3ATXpfeypJWX6tHxwY0zQQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=d65ULC6Reb9mtGUHyRYNO06zmMfiHTf157HjOYVrpEpR4gwp9nO38nSMFzHdfUSh9fHN+dFB1bQbHKjIehAb0EEot/icMGTtg4mRZQEjaSS809u0mamPqTZsgLkPiI4m+7HThGSfJPzPRTf/6sROf+g+Iffy5rXScCfvGr0k8K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=boeNGRJs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dXxn46t8hzlwmGt;
	Fri, 19 Dec 2025 19:05:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766171105; x=1768763106; bh=eV7MMJjNh+GgBWpC1KWI4e80
	gQbcoqCCVdMqswFoyR0=; b=boeNGRJsgKlp3hLFPG9KwlpxMPgC9GvTxoYtra57
	fDZ5/Bqc/iY9il04qGlocz0VkE3ZY0ptfRFx06N+FIezk1JtMZ3yKWbIFU5PSGIk
	UkPJ9FseM/A0PwzH7CpKNEDAubZI78GvBdRyUYqj2Qo7RYbpuEPQ9TQYF3ijUtlQ
	9tbrbv7L8aAiJLNzhrDWlnR8Ny4jKU8I7gAcKMVaLEN66MDjRYS80V/oKh1jBmmz
	PXK8NOKIrEfnkpeqJRkA+METSqRvisYP2/Jc4prbjyHvgvE0WRWMxCSCoRrM2jEm
	DxjjdTfH0hiFBN/vWp9lz2GI2eF7GRfL8o5zH83z5GTa5A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id Pu13yLEvt3U6; Fri, 19 Dec 2025 19:05:05 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dXxmf0ZcWzlvwXX;
	Fri, 19 Dec 2025 19:04:49 +0000 (UTC)
Message-ID: <2f0c27eb-eca5-4a7f-8035-71c6b0c84e30@acm.org>
Date: Fri, 19 Dec 2025 11:04:49 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 02/36] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
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
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-3-elver@google.com>
 <97e832b7-04a9-49cb-973a-bf9870c21c2f@acm.org>
 <CANpmjNM=4baTiSWGOiSWLfQV2YqMt6qkdV__uj+QtD4zAY8Weg@mail.gmail.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <CANpmjNM=4baTiSWGOiSWLfQV2YqMt6qkdV__uj+QtD4zAY8Weg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 10:59 AM, Marco Elver wrote:
> On Fri, 19 Dec 2025 at 19:39, 'Bart Van Assche' via kasan-dev
> <kasan-dev@googlegroups.com> wrote:
>> I'm concerned that the context_lock_struct() macro will make code harder
>> to read. Anyone who encounters the context_lock_struct() macro will have
>> to look up its definition to learn what it does. I propose to split this
>> macro into two macros:
>> * One macro that expands into "__ctx_lock_type(name)".
>> * A second macro that expands into the rest of the above macro.
>>
>> In other words, instead of having to write
>> context_lock_struct(struct_name, { ... }); developers will have to write
>>
>> struct context_lock_type struct_name {
>>       ...;
>> };
>> context_struct_helper_functions(struct_name);
> 
> This doesn't necessarily help with not having to look up its
> definition to learn what it does.
> 
> If this is the common pattern, it will blindly be repeated, and this
> adds 1 more line and makes this a bit more verbose. Maybe the helper
> functions aren't always needed, but I also think that context lock
> types should remain relatively few.  For all synchronization
> primitives that were enabled in this series, the helpers are required.
> 
> The current usage is simply:
> 
> context_lock_struct(name) {
>     ... struct goes here ...
> };  // note no awkward ) brace
> 
> I don't know which way the current kernel style is leaning towards,
> but if we take <linux/cleanup.h> as an example, a simple programming
> model / API is actually preferred.
Many kernel developers are used to look up the definition of a data
structure either by using ctags, etags or a similar tool or by using
grep and a pattern like "${struct_name} {\$". Breaking the tools kernel
developer use today to look up data structure definitions might cause
considerable frustration and hence shouldn't be done lightly.

Thanks,

Bart.

