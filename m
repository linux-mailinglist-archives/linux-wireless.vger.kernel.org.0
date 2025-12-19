Return-Path: <linux-wireless+bounces-29990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84B73CD1DCE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 81DB13001BDB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 20:55:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEB533C193;
	Fri, 19 Dec 2025 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="iY/ltKNs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96F1233B6F8;
	Fri, 19 Dec 2025 20:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766177725; cv=none; b=RRWM4kWTA3BKW+N5rcoOp8vLZNw7m3XrQmD0ZYMxSmjmSO6ahTDMjA8mokC/t+NxC6NAlGQoYCMBJf93I7v6azAg56Tr0OEIkC87T9fu4Sso4tPvcbSrs4qfH6yuYMvp2P5mW+plGJfypeJWLquKKQCU6aVkzxzystFIJjlyiHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766177725; c=relaxed/simple;
	bh=FxkLQWKzqSQzzZfInnFwxA0OfbwFt+2QO4xiCZYjQkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmMH72mDwR45sDC+8C+mci/afDBw9LnvWLlbJ1WnwNMkc5y03E1KoT0EeNi2tetRlizrCHtXaJV54R3vSIjTIA2LsvqZ2Xa4lNPdfeKaevi0M9txsbeT7mQKWckHk4hoirLxPZLU37flEtNmlWM5YB+W2OXW7kLvTr0zkAtKfJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=iY/ltKNs; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4dY0DC1g6NzlxTSc;
	Fri, 19 Dec 2025 20:55:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1766177715; x=1768769716; bh=XdZxKJLVv/us0MhlURSAieVC
	/jzQimy4qD0cHcgmVzU=; b=iY/ltKNsXjZN2SOn/7Mgk2nBiIFfkhQl9wu1rxsY
	gqMl8gzI4Fdl7lRwvuyzu7BWqPG53SnYRBw92pU/YfkNHA1oj26W7lr6+j5RR0uF
	yIO6LZVQLnDdYtCKFJK2JKXsUbas5xX9N0Cd4MqfHLRdUuyQFIFHBeQ4g++xzSQp
	gU0eJDXxLL9HnDwtcV2Is8KV5H4vPha7HstD2vRL0jPgV4n/YaDhiqi6j32BHDhA
	klf/01+b+GILMZcS2Xt+ypFduBskYOaif+4ge3c/WrC+gq03AbnGqHj3Xw4Txc6v
	eiaB6hoDKfyCfX8yrnN20mCQbhQQgqc7PGjrVHpqbn8r2A==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id qbQZoCDMrrgt; Fri, 19 Dec 2025 20:55:15 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4dY0Cp5nntzlwmHT;
	Fri, 19 Dec 2025 20:55:02 +0000 (UTC)
Message-ID: <81d2defc-8980-4022-a464-3d285aff199c@acm.org>
Date: Fri, 19 Dec 2025 12:55:01 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 17/36] locking/rwsem: Support Clang's context analysis
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
 <20251219154418.3592607-18-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-18-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/19/25 7:40 AM, Marco Elver wrote:
>   static inline void rwsem_assert_held_nolockdep(const struct rw_semaphore *sem)
> +	__assumes_ctx_lock(sem)
>   {
>   	WARN_ON(atomic_long_read(&sem->count) == RWSEM_UNLOCKED_VALUE);
>   }
>   
>   static inline void rwsem_assert_held_write_nolockdep(const struct rw_semaphore *sem)
> +	__assumes_ctx_lock(sem)
>   {
>   	WARN_ON(!(atomic_long_read(&sem->count) & RWSEM_WRITER_LOCKED));
>   }
> @@ -119,6 +121,7 @@ do {								\
>   	static struct lock_class_key __key;			\
>   								\
>   	__init_rwsem((sem), #sem, &__key);			\
> +	__assume_ctx_lock(sem);					\
>   } while (0)

Just like as for lockdep.h, I think that the above annotations should be 
changed into __must_hold().

Thanks,

Bart.

