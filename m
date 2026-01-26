Return-Path: <linux-wireless+bounces-31181-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALK4Dfykd2k9jwEAu9opvQ
	(envelope-from <linux-wireless+bounces-31181-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:31:40 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7ED98B7E1
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:31:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1AA573005E87
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 17:31:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F6D34D3AD;
	Mon, 26 Jan 2026 17:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Jfjqa2A5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 011.lax.mailroute.net (011.lax.mailroute.net [199.89.1.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D26C34677D;
	Mon, 26 Jan 2026 17:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448693; cv=none; b=CFDUmdzVfhpFSKogh7dd3QeqP6Ouh9FrUhj1O4Chat3tZ0GVVdAhZiGeZiB9Gr7aCEfcR8Gpa0mVicT1DxysITOnKTITrmRZD64aJ2KHxtzI+GVe4g64qzCfrhZVBDHdpVQUf8mqRRJZp56HCBuRy2+ybyIfuDDuTqeF4k+JA9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448693; c=relaxed/simple;
	bh=M0wCL+k15bO3pDdyLHE8FGzohjX2ZEEC1+q4jfMMHgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wu4weehapWZrj+4Eh7fDVdnuPX8WiPq8pwzJ27AYj4YG2tJbVa4oV11s9C3e8ve+dVMHCh/LqsLDCTHJIZXws3LDsuFVJDON7Z+6lzldsUurbWgJXqt2Jpwg1tza4/ecyuwWu0Q1Tfypgyx3cKexP9GRl4hYrsI1bGv6u9HMFtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Jfjqa2A5; arc=none smtp.client-ip=199.89.1.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 011.lax.mailroute.net (Postfix) with ESMTP id 4f0FvS0HvMz1XM5kt;
	Mon, 26 Jan 2026 17:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769448682; x=1772040683; bh=cqyCB6D2UZUFPhod4jHX3yXa
	2CT5+Aq6RptHuHLLwP4=; b=Jfjqa2A5xcoH8vxqxrPT6Fc3T+WNWvUSPtyI3dfc
	K+K74UqCtqhORUbqAIJ2PabUFFnbxrVNvd96sUMMU/MEnaVjk9rgNQ8t5/0nRw19
	sH24JJ46JZl/8BikOO9Kx+mt4Ur/Rh8Yzl6nngAhCrvlw0oYG3zzrCOIJGm0wInA
	YwG5Fyd74wCsCC2gIdMl3vVF8TZuM0JPKyJCc8OrmAE33h8ZSEoKEb2DqwDLr2sf
	hlPf/0+ka1e80z6j8NCnVVqxTk2wxfTwIisYs3BeL1zHtJcgzeItDapUP68dFmWE
	DNXn0jJrQCoweUxibEiMVlGVbmaZJxeooqs7mbStQv3LCg==
X-Virus-Scanned: by MailRoute
Received: from 011.lax.mailroute.net ([127.0.0.1])
 by localhost (011.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id XReqotH7_hjc; Mon, 26 Jan 2026 17:31:22 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 011.lax.mailroute.net (Postfix) with ESMTPSA id 4f0Fv22xNsz1XLyhK;
	Mon, 26 Jan 2026 17:31:10 +0000 (UTC)
Message-ID: <dd65bb7b-0dac-437a-a370-38efeb4737ba@acm.org>
Date: Mon, 26 Jan 2026 09:31:09 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/36] srcu: Support Clang's context analysis
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
 <20251219154418.3592607-16-elver@google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251219154418.3592607-16-elver@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[davemloft.net,gmail.com,chrisli.org,kernel.org,google.com,arndb.de,lst.de,linuxfoundation.org,gondor.apana.org.au,nvidia.com,intel.com,lwn.net,joshtriplett.org,nttdata.co.jp,arm.com,efficios.com,goodmis.org,I-love.SAKURA.ne.jp,linutronix.de,suug.ch,redhat.com,googlegroups.com,vger.kernel.org,kvack.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-31181-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[google.com,infradead.org,gmail.com,kernel.org];
	DKIM_TRACE(0.00)[acm.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[acm.org:mid,acm.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E7ED98B7E1
X-Rspamd-Action: no action

On 12/19/25 7:40 AM, Marco Elver wrote:
> +/*
> + * No-op helper to denote that ssp must be held. Because SRCU-protected pointers
> + * should still be marked with __rcu_guarded, and we do not want to mark them
> + * with __guarded_by(ssp) as it would complicate annotations for writers, we
> + * choose the following strategy: srcu_dereference_check() calls this helper
> + * that checks that the passed ssp is held, and then fake-acquires 'RCU'.
> + */
> +static inline void __srcu_read_lock_must_hold(const struct srcu_struct *ssp) __must_hold_shared(ssp) { }
>   
>   /**
>    * srcu_dereference_check - fetch SRCU-protected pointer for later dereferencing
> @@ -223,9 +233,15 @@ static inline int srcu_read_lock_held(const struct srcu_struct *ssp)
>    * to 1.  The @c argument will normally be a logical expression containing
>    * lockdep_is_held() calls.
>    */
> -#define srcu_dereference_check(p, ssp, c) \
> -	__rcu_dereference_check((p), __UNIQUE_ID(rcu), \
> -				(c) || srcu_read_lock_held(ssp), __rcu)
> +#define srcu_dereference_check(p, ssp, c)					\
> +({										\
> +	__srcu_read_lock_must_hold(ssp);					\
> +	__acquire_shared_ctx_lock(RCU);					\
> +	__auto_type __v = __rcu_dereference_check((p), __UNIQUE_ID(rcu),	\
> +				(c) || srcu_read_lock_held(ssp), __rcu);	\
> +	__release_shared_ctx_lock(RCU);					\
> +	__v;									\
> +})

Hi Marco,

The above change is something I'm not happy about. The original
implementation of the srcu_dereference_check() macro shows that it is
sufficient to either hold an SRCU reader lock or the updater lock ('c').
The addition of "__srcu_read_lock_must_hold()" will cause compilation to
fail if the caller doesn't hold an SRCU reader lock. I'm concerned that
this will either lead to adding __no_context_analysis to SRCU updater
code that uses srcu_dereference_check() or to adding misleading
__assume_ctx_lock(ssp) annotations in SRCU updater code.

Thanks,

Bart.

