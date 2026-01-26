Return-Path: <linux-wireless+bounces-31187-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNyiDZ+4d2nKkQEAu9opvQ
	(envelope-from <linux-wireless+bounces-31187-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:55:27 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D35828C3F6
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 19:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D73C301B734
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 18:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E80A261586;
	Mon, 26 Jan 2026 18:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="4b+R0ix5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from 013.lax.mailroute.net (013.lax.mailroute.net [199.89.1.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4C9252904;
	Mon, 26 Jan 2026 18:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.1.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769453720; cv=none; b=a5kMJcFafY8QjK8WAMhGzxtQCzBkX3bLRimVxo0ov1021PCQPiF1PjQZyp2Ab77gMa+ZnptbDPxtdiVq0tNCuysOEJjqd1ltrIVPtf0+hY/Y/EMtUR+GVFGywj/6E6POhbUt5gFM0lA5MnaKi4K3soVZ6BEMx5zoLctu7Sw9uBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769453720; c=relaxed/simple;
	bh=jMVk9CS2JBRNsS5GC6/yI2ZxOvdhUQdY4kP4Vs3jjqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U1LdWPmSE5EV/wwkSS6C/sNX1XhD/h0erzyArhHo19CvXQl7xZCsNgooFFxCFnkPxGxw/v1mFZ4qxiHCViTDS73pUrt1R4jjDEsbGmWEbCNe9mIM/wWj6ZBOHhFsLkUeIKOMBUffctIWlzGFVH0aOB7tMnsHcxBELg7cChxkvgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=4b+R0ix5; arc=none smtp.client-ip=199.89.1.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Received: from localhost (localhost [127.0.0.1])
	by 013.lax.mailroute.net (Postfix) with ESMTP id 4f0Hm56kBhzlgyGr;
	Mon, 26 Jan 2026 18:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1769453709; x=1772045710; bh=lrmRnMiS7e8oDqS8sJHadbKN
	aRE4y8/9HerN9jURAnw=; b=4b+R0ix5+Os0UdymHVdPefR75pAjuePHzZSBDv1T
	PhKFA4FAC8OQc9TuXgMxSrv6ALYLM26zsK043txlRzxnGUh1OQAsqSN0foShyawt
	pgoA82i8a3e56Az+c5yQ/FRzJRlVVV9ONPOmo5QZvE0Q0R6BZlDabDdSvqRaIrWq
	5qv/o/SAv+5/3fRLam45SzREjjV6pc62GFn6nBiQJg3JMywlrNKvmQ7VlMyrTxAH
	T23+3S/pU978iX4yw8ahY2EFo/8Xq0lczgH+hEk7oD3ExiVmcFff0tai2SlH7PR7
	9U/uiA5vPsPPUdDSnrYljSKcp1+NnDZMaTuY+V/YB+pCTQ==
X-Virus-Scanned: by MailRoute
Received: from 013.lax.mailroute.net ([127.0.0.1])
 by localhost (013.lax [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id vhOvcRL97NLm; Mon, 26 Jan 2026 18:55:09 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 013.lax.mailroute.net (Postfix) with ESMTPSA id 4f0Hlj4MJNzlh1T6;
	Mon, 26 Jan 2026 18:54:57 +0000 (UTC)
Message-ID: <8c1bbab4-4615-4518-b773-a006d1402b8b@acm.org>
Date: Mon, 26 Jan 2026 10:54:56 -0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 15/36] srcu: Support Clang's context analysis
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
 <20251219154418.3592607-16-elver@google.com>
 <dd65bb7b-0dac-437a-a370-38efeb4737ba@acm.org>
 <aXez9fSxdfu5-Boo@elver.google.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <aXez9fSxdfu5-Boo@elver.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[acm.org,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[acm.org:s=mr01];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[infradead.org,gmail.com,kernel.org,davemloft.net,chrisli.org,google.com,arndb.de,lst.de,linuxfoundation.org,gondor.apana.org.au,nvidia.com,intel.com,lwn.net,joshtriplett.org,nttdata.co.jp,arm.com,efficios.com,goodmis.org,i-love.sakura.ne.jp,linutronix.de,suug.ch,redhat.com,googlegroups.com,vger.kernel.org,kvack.org,lists.linux.dev];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31187-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[acm.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bvanassche@acm.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_GT_50(0.00)[50];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D35828C3F6
X-Rspamd-Action: no action

On 1/26/26 10:35 AM, Marco Elver wrote:
> That being said, I don't think it's wrong to write e.g.:
> 
> 	spin_lock(&updater_lock);
> 	__acquire_shared(ssp);
> 	...
> 	// writes happen through rcu_assign_pointer()
> 	// reads can happen through srcu_dereference_check()
> 	...
> 	__release_shared(ssp);
> 	spin_unlock(&updater_lock);
> 
> , given holding the updater lock implies reader access.
> 
> And given the analysis is opt-in (CONTEXT_ANALYSIS := y), I think
> it's a manageable problem.

I'd like to make context-analysis mandatory for the entire kernel tree.

> If you have a different idea how we can solve this, please let us know.
> 
> One final note, usage of srcu_dereference_check() is rare enough:
> 
> 	arch/x86/kvm/hyperv.c:	irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
> 	arch/x86/kvm/x86.c:	kvm_free_msr_filter(srcu_dereference_check(kvm->arch.msr_filter, &kvm->srcu, 1));
> 	arch/x86/kvm/x86.c:	kfree(srcu_dereference_check(kvm->arch.pmu_event_filter, &kvm->srcu, 1));
> 	drivers/gpio/gpiolib.c:	label = srcu_dereference_check(desc->label, &desc->gdev->desc_srcu,
> 	drivers/hv/mshv_irq.c:	girq_tbl = srcu_dereference_check(partition->pt_girq_tbl,
> 	drivers/hwtracing/stm/core.c:	link = srcu_dereference_check(src->link, &stm_source_srcu, 1);
> 	drivers/infiniband/hw/hfi1/user_sdma.c:	pq = srcu_dereference_check(fd->pq, &fd->pq_srcu,
> 	fs/quota/dquot.c:			struct dquot *dquot = srcu_dereference_check(
> 	fs/quota/dquot.c:				struct dquot *dquot = srcu_dereference_check(
> 	fs/quota/dquot.c:		put[cnt] = srcu_dereference_check(dquots[cnt], &dquot_srcu,
> 	fs/quota/dquot.c:		transfer_from[cnt] = srcu_dereference_check(dquots[cnt],
> 	include/linux/kvm_host.h:	return srcu_dereference_check(kvm->memslots[as_id], &kvm->srcu,
> 	virt/kvm/irqchip.c:	irq_rt = srcu_dereference_check(kvm->irq_routing, &kvm->irq_srcu,
> 
> , that I think it's easy enough to annotate these places with the above
> suggestions in case you're trying out global enablement.

Has it ever been considered to add support in the clang compiler for a
variant of __must_hold() that expresses that one of two capabilities
must be held by the caller? I think that would remove the need to
annotate SRCU update-side code with __acquire_shared(ssp) and
__release_shared(ssp).

Thanks,

Bart.

