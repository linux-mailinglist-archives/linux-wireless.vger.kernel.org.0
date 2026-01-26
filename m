Return-Path: <linux-wireless+bounces-31193-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCKdBRT9d2kvnAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31193-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 00:47:32 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 848858E4DC
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jan 2026 00:47:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0278F302A19B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Jan 2026 23:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CCDC3101AD;
	Mon, 26 Jan 2026 23:47:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QPyFHk96"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 626253101D8
	for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 23:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769471248; cv=pass; b=dFekV/E5CV+DiXDnThu94RrKMukKilF9RwRacTrhliZYi93K8TC4KiBCBbwRvhvnwOS4fVKpxDc9OxMqw+EAGtJa4bVJSMFhuUgfWgpannhALQ1BaTQrCi7DiUdxub1sHXU8z8IE6XrctJ+gSa5ginnDafeVh2nNgh3kZ6TqiYs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769471248; c=relaxed/simple;
	bh=fG2Ruh+rMXy8HECrlWrSGEzE9JMwnw/wcqEcRF2te3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BwiCOQPgrGdkyWmzc6HTfE4klzQV4OoEFpFruAGE5JdtMb/e1o49e/SR9NaYma3Sz9z8Q6sYq+AmPhCWzGark6M1QmHFRsDljWc/xyyR55UTemPRwzNggnoyXafhQS5ZJQstaUMIAzO0rXWrl4bM2UpC1J7IHM+zQSoiewLEM+w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QPyFHk96; arc=pass smtp.client-ip=74.125.82.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-1249b9f5703so1040966c88.0
        for <linux-wireless@vger.kernel.org>; Mon, 26 Jan 2026 15:47:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769471245; cv=none;
        d=google.com; s=arc-20240605;
        b=jwiOG7O+QScTBx7iKwKawjgi+pmqlwMohQLLxDc67bE91BTCfeIASqvswrerd/2RLQ
         9DWm2Ifh5U1taNJ+oiD0mHSndsDtLYituwNaQZm+HF2uDRP/u39drbvNd/WSBo1UTdoU
         NOccUHJHuIuvht9/YLNtpUKn58S7zek4J3K2aOwcyWWV3Lp8ut06fD0aI9hYTn2v1BK8
         Q6Raz5fOJxWTbFhHmMSVcsLIwvYeocnobmb3BhbwyWQ0cvD9i9jLyYuMa4p496zoBe3l
         9S3tRA4QW7v6ev5mA4HjsDCWOwVtyh6WKuHKrHmT+VSi4QhOUYo59goJyZiB2Cdy+vNz
         eq9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        fh=mKd4hj5+hEgq9d0HYwnCsonlzBM3G6hojvlXycQfMuk=;
        b=iN3ldCTz+OUflqYdmt/KocWfufpYOtTIxR2peVmRbhE9P3qpR3q5+rK/mHSZo0MURn
         aGel7wqL+fIW4i4hkPSocZzk0/gOzXYd+HVvbPtgogVGTObi/57IKcJBahEUnENRoKX+
         2v2SW7Vw13ITSJRW3SB5BL3IOpJmV1pFIohx9bGdC5MmUbX8eXmKgw+OKTeZUe6BTQzQ
         Pem+ZbVVyrSjr8kaVieBAVWkOpTUq0PWiio6nDU63qEV9Rbn9psQmP6IThMeKqiA7WXi
         MrdtYOLLCyRcI5ujeEAtKwsWFJGoUSNM38OfScRjJ20Xv00UbBZxxdRcrNBsJCk7szBi
         33Xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769471245; x=1770076045; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        b=QPyFHk96UvMrpMwkoIa7K76IVIsyFEnfZylNFV5QMW6rzMt1q1yhPRJPbtVPkVYr37
         QQih6C5oGngtDrT2O6TJ/NmalrhezMNkb25dAEFdF2KrioK3GhDmedvDZGFMwEh3ihqY
         JVQlTZ1GsSZw62zjipX4WnEYc1xlFLHZ/rBXw+v03T9uvrvWmt9jJfxjhDBTrivMhecH
         xY5XiTzs4FuuW3ITTswqPixr9Dy8rk2WBhWOlxNNBc7UF3/u5o1AfjHwCch4TOYbauT2
         KWPjRIH+OaDaBKqKOStCJSGsldadRt4KZBNG7dUZlgqW5w7DYgS30qdNee0ahFDUD1nl
         VIHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769471245; x=1770076045;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X34tjfxPPMupW8WHmEJAIsWdH0Oem6uch60iKqedEdc=;
        b=KiYzOaUt8gCkbQKPiFnwN8uHtuTWsD1nKyk69dKbXsm3XyuCdBlm9nQjF24nDMSNf6
         w5w7kxMZAM4dH3w3hVTR6tNplGrSowWjw4MgFmWu1eeo/e4RNaQ4BY8b+wH3TUkFyMsY
         tyX9SO0Fbwx9Ri0h7HJMtwcG6uoMLwowxUdel99iRPkd05bcFFI4RkPIOgIW7ZaGCnfq
         ecX6cE36Dm4JbBN8ZhoJYL9BUU6Tfgj5a9+wg/EvUvoHpLW6cLRiPXIBC9wPUOMUxBe4
         98A+0h7070yBjZwQBd0R+I0V1lFy/Eb8cVwDkTtXlyvwcefmivKqszYyeoVWQu2i/p9L
         t/Gg==
X-Forwarded-Encrypted: i=1; AJvYcCVsXHaf1E5h+sehUT/xW6zo0XltLvyidw1W9Jxoh1B+er3QlPH6al97zGNhv3IMRJ630TDlb5WInRAa05qGuw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxld11jcLL/ze59404TZqZl0hOYvm22IXGo+nXdIxdFB63z6lEm
	EOSfxDZpnBaZrmPQ0myEKU08hRxylX4fVsnEuSMyw6CgCDuhNeywFNcHNT41gtcVZwdSS1U/izh
	Y9kxNd8eUCz+lO/TxETqSypMZ2sRtvMZokcXZ+cYv
X-Gm-Gg: AZuq6aJWae7xDN1XHx/8KE4PiB+TwP5+c7OzpUeaeTVllQW0alR4R8obqp/JYMIEqtl
	QljGA1qcuWReuKj6BOggd42+WAx33PF7x1L1haDWS7FDLMAxhlsm4x+ORDUbdYFci2qdXmaZZMh
	ujvAnc+XYucg6LsDu8ToXaRTnimRWtO519jVREFb+vnOs7/U4Uas/3tIqgkPovye5LJevBBJ85c
	EBzxTxFsObz/wa8t0cWQbgD8gTrMhYCMavPmCHQwhrpkiboIlEq54WOAl6EupqNvxUS1hScLHF/
	Dd8JeljfFdHMJwvdymA8TKqF+GWuXOA/36pZnQ==
X-Received: by 2002:a05:7022:eb46:20b0:124:9e46:82fb with SMTP id
 a92af1059eb24-1249e468815mr157327c88.38.1769471245289; Mon, 26 Jan 2026
 15:47:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-16-elver@google.com>
 <dd65bb7b-0dac-437a-a370-38efeb4737ba@acm.org> <aXez9fSxdfu5-Boo@elver.google.com>
 <8c1bbab4-4615-4518-b773-a006d1402b8b@acm.org> <20260126213556.GQ171111@noisy.programming.kicks-ass.net>
In-Reply-To: <20260126213556.GQ171111@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Tue, 27 Jan 2026 00:46:49 +0100
X-Gm-Features: AZwV_QgcknJe0PlLV-z7bksgFQT7uSnaZ1B5QvyI9tPRocr5FzcCAIEUg9yCt-Y
Message-ID: <CANpmjNPs9CtY1w1-MqL1-CnHVFLxXoA2rbd6d2w4wfxT8AP0ew@mail.gmail.com>
Subject: Re: [PATCH v5 15/36] srcu: Support Clang's context analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: Bart Van Assche <bvanassche@acm.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Christoph Hellwig <hch@lst.de>, 
	Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
	Frederic Weisbecker <frederic@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Herbert Xu <herbert@gondor.apana.org.au>, Ian Rogers <irogers@google.com>, 
	Jann Horn <jannh@google.com>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Johannes Berg <johannes.berg@intel.com>, Jonathan Corbet <corbet@lwn.net>, 
	Josh Triplett <josh@joshtriplett.org>, Justin Stitt <justinstitt@google.com>, 
	Kees Cook <kees@kernel.org>, Kentaro Takeda <takedakn@nttdata.co.jp>, 
	Lukas Bulwahn <lukas.bulwahn@gmail.com>, Mark Rutland <mark.rutland@arm.com>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Miguel Ojeda <ojeda@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[acm.org,gmail.com,kernel.org,davemloft.net,chrisli.org,google.com,arndb.de,lst.de,linuxfoundation.org,gondor.apana.org.au,nvidia.com,intel.com,lwn.net,joshtriplett.org,nttdata.co.jp,arm.com,efficios.com,goodmis.org,i-love.sakura.ne.jp,linutronix.de,suug.ch,redhat.com,googlegroups.com,vger.kernel.org,kvack.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-31193-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[elver@google.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-wireless,lkml];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,infradead.org:email]
X-Rspamd-Queue-Id: 848858E4DC
X-Rspamd-Action: no action

On Mon, 26 Jan 2026 at 22:36, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jan 26, 2026 at 10:54:56AM -0800, Bart Van Assche wrote:
>
> > Has it ever been considered to add support in the clang compiler for a
> > variant of __must_hold() that expresses that one of two capabilities
> > must be held by the caller? I think that would remove the need to
> > annotate SRCU update-side code with __acquire_shared(ssp) and
> > __release_shared(ssp).
>
> Right, I think I've asked for logical operators like that. Although I
> think it was in the __guarded_by() clause rather than the __must_hold().
> Both || and && would be nice to have ;-)

Some attributes take multiple arguments (__must_hold does), though
__guarded_by doesn't. Yet, && can still be had with adding it multiple
times e.g. '__guarded_by(pi_lock) __guarded_by(rq->__lock)'.

Only thing that doesn't exist is ||. I think the syntax you ask for
won't fly, but I can add it to the backlog to investigate an _any
variant of these attributes. Don't hold your breath though, given the
time it takes to land all that in a released Clang version.

> Specifically, I think I asked for something like:
>
>         cpumask_t       cpus_allowed __guarded_by(pi_lock && rq->__lock)
>                                      __guarded_shared_by(pi_lock || rq->__lock);
>
>
> I think Marco's suggestion was to use 'fake' locks to mimic those
> semantics.

