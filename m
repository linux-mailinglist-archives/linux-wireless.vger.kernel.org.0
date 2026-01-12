Return-Path: <linux-wireless+bounces-30713-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEB0D15858
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 23:05:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EE7F13045DDA
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 22:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB16342CA7;
	Mon, 12 Jan 2026 22:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="hs5fvItj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20D903101D8;
	Mon, 12 Jan 2026 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768255531; cv=none; b=uIoZmN2yvl2EpPkpLy+PhetTVKBgdQbYoKw/y68qK9J24WX/VjuzkibZWMbzwn6WeOvMj7WK66eUKnktCgzotd5/6A2C3gXma13hPQZ8ypXmAiCYUHjF5peQmDDJW62OLurGDkv3zcUMStTLb5z0z4XS6qr/0SEexLA4yv8OZcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768255531; c=relaxed/simple;
	bh=AWbovU9yx+EpWoS2uH0YQS2sLaGQNcCturbavPTShxs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EKC0zCQvL0wjuxe6AL+d8FlCv/eCpdQeYtxQfBpzlL1gcG0E7/27kE/Cum5knEC+WL3Hp+7FdqJs4UhG7O1ejO7wcD+x1LYxfayjYwRl2Ekg2gq2VpEvwteJZsz/UPtyEMt5KjGT4WFSbaYAIZ9Gla8/bpgXsEZlJd6Pe6phXsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=hs5fvItj; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dqmf137mPzlqfHK;
	Mon, 12 Jan 2026 22:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1768255522; x=1770847523; bh=z9Y4BPiPU5vZeqyn1OIEPskt
	kMud/fciou6gPOxT/Gg=; b=hs5fvItjOEws4VXy8vRpfYKZ6iyXl7qohAnJxjPR
	hMx4gdQ+APBsH3BLqhgEqPQMix6M9gSCOQ+5eME/2LwroWVIeUXroMEG/a3Fqknq
	FdM9OcgvI52xQwiErSfBLyFlB92ssvSNbndiHo9uc6GBOBa5lH/lnV2YC61stTL3
	LgoJdWlkxhEDR9qAW8cLuNUpV/2zWO3F1/axpXRkpjUl9rMX+fIxGiG/iqTNxXBw
	3RKN/ZrDAQ0P7Yt0aHJfTt4Q7SG8kjBXQuspB49gAWBnigIUkjm0NYEsZkQyMT+Z
	2mZFN83sJGRk0MscnaN1nLn9JPULOySkmo9EeDGhgsGmAw==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id IkkI-SR9t1-b; Mon, 12 Jan 2026 22:05:22 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dqmdS2QtzzllB6t;
	Mon, 12 Jan 2026 22:04:59 +0000 (UTC)
Message-ID: <3de714fc-7a18-4bcc-9ab5-c3831efbdb84@acm.org>
Date: Mon, 12 Jan 2026 14:04:59 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 36/36] sched: Enable context analysis for core.c and
 fair.c
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
 Ingo Molnar <mingo@redhat.com>
References: <20251219154418.3592607-1-elver@google.com>
 <20251219154418.3592607-37-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-37-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 8:40 AM, Marco Elver wrote:
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index a63f65aa5bdd..a22248aebcf9 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -738,10 +738,12 @@ static inline int thread_group_empty(struct task_struct *p)
>   		(thread_group_leader(p) && !thread_group_empty(p))
>   
>   extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
> -						unsigned long *flags);
> +						unsigned long *flags)
> +	__acquires(&task->sighand->siglock);

I think the above annotation is wrong and should be changed into
__cond_acquires(nonnull, &task->sighand->siglock). My understanding of
the code in kernel/signal.c is that lock_task_sighand() only returns
with sighand->siglock acquired if it returns a non-NULL pointer.

Bart.

