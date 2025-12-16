Return-Path: <linux-wireless+bounces-29804-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B26DCC3416
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 14:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B9D430CECE0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 13:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF053559F5;
	Tue, 16 Dec 2025 13:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="buYJu0gC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A51F354ACE
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765891601; cv=none; b=CPXF/FxpPC5bL7yndD8DmqXp8hzl1K7jBsxkhjaHYmLQE5+2iPQpixaiIfI1zPQXMsjk55EapLXGfte3zgkvuQ5Avol4Xfs+li9mB0mrGSYgjXhLV7QA5uHEdC++ItoZlHLfRCP7RNkUbmQAjB/yfmrDkl04Mwhtw54FlnST1cE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765891601; c=relaxed/simple;
	bh=XzSmUQ9wBuoAsnnswWznp0kvFEGZQ0Tj3+vUePVVnwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fB19PfZElyXQQihGLPd7tZ6Uh0iYXkSRg2imYOIK3jOi1a+17qGPDKXmAhems2Dk6pEGmGh+d6PsIxRXXtbmG/P0iixKT7DkzvDEafc/Dx7enFZtjBuP7Qzg/GjBZp1yhz1/i/N/Bs7Tf3TCG4ds0rVtNmAgpzDKkJpTStl32No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=buYJu0gC; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-649820b4b3aso2310817a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 05:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765891597; x=1766496397; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3V/ozmG0P6zbhJMhekfGn6dV/6uy4a54Tyfq8of8mrw=;
        b=buYJu0gC4OU4CKzN0mxTwWWLvQ4CNFOE6E5ISWagDJYeSPRRTZEJblsZjS10eKAI9o
         pQdfa6WhBntvFfS1/XfQ9/yKOraEw6DxVQO1uzuOL+URVzk+f/q/8DnJktaiNSd7DBJi
         tnvbE/8vjuq16rtJWuUvHoaCMvXhFVVpMb5RvybkAgLEXB0x4AmWNOt7wO8kDRH24QY6
         cvXAamGreZz8arkujIiH+dEPwH4lss3HYi/D/FkrIOKheflpobF84oPK+vMLJ5LcyDpB
         VceNZB1hflgT0S3PNCJ/TA87AIeCNjz1cBLeBQM6/Y56AMmE5BbW75KkDYJQlrauWTp6
         g5oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765891597; x=1766496397;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3V/ozmG0P6zbhJMhekfGn6dV/6uy4a54Tyfq8of8mrw=;
        b=c31CDteWwPuYXQSa9kjMSPxmdgazuqqsZJW2xWOflygbgAKDXOWBF6c1O6kwpr0Izp
         t2vdH95QaT3l03xjrZhtYdGauX+Gcn4y+Vlhdgz/8Ad3OhhXoYNBP6WQRpeM63vY7Zsh
         bvUmSdE0mOSCVKPpEVnkrUM0gjFCV0EeQ1jibFbCRzJ2nKo0m2wiPPa8l8XR0hcmt4uK
         3vVQnxzOkZ5YpfTftvGO4Uz0udjbjn6xEDB3lL2zwM9pCSraMQnSuaRRNlKsLm0Wrm6P
         Vs/t0qZDrHD0E31muw3w1ClRMiwURuME68uUhEkIod7chl12nUYu46lgbgIl6mVf+4rx
         Tpdg==
X-Forwarded-Encrypted: i=1; AJvYcCVJozq4o4pOlzObv1jXufdtw/dT2im5+ah7ToABlVIBz/h3KIzgrUbH4wzRwFKbdHwxlJQJpRmQn0cdZzQ+pA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6afS8d2PZbrkhUDeZa/O2lXCJc0IRrd1emgdME9kFdsa3A4bX
	5bYNAK1emFtQvb0mTp0txz2lvHo+w+qfoNO8hHNudIAkU1Mk4nOUzRVB6dk/u03Iyw==
X-Gm-Gg: AY/fxX6xzT75KNq5hWDuMdA7g78nRBDIPuP0/yvPzM8MoTNBxA2Y8Q1E2UlcHhbuhm1
	Chrws5IoQNUSz1ZhSAJHeNazX49YRefeq0EPj8A9KeENuxBJVuUt6jNVuhVEPiapDRxrw5F/AOB
	kt9LxvPcXQF9ATByYHKseQgM4HvBDxY7UvtTtHvrMMLE6GB+uhje7Oco/kqpeUpf9Ko2hXW2EB1
	FXfkcORuHax0ULLTHfQRK6mwk0Mr0TeXSCuQeS6YqrOVeDW9US3j2ki6mwdDYnbtLhyoDrXNsm8
	lE/I9KHYpSQd/Gf4i2u3pXeRBrzYlNwpXhfjUDiJXFx1HyamHTyxVr8nG8h9OG0a8kAupNT62EK
	GkOrQDu/CbYP7ULIGF0T2gr0TpWzRFM0tygIZQ1S5DA6y6nloEqX2rPJ8do7a+rTMABJP8oAGHr
	LVd6WrUGtlODped8MEFG859h4GXfaP0tZVzcUEkittzi0+/3wG
X-Google-Smtp-Source: AGHT+IEXN8c4l2W138SpFxaraGM3jOuuGwcwQYafzXlaDOwN/Hd+sEz4uwdMcyiAnZ9D77N2tR3XDg==
X-Received: by 2002:a17:907:72c7:b0:b6d:9bab:a7ba with SMTP id a640c23a62f3a-b7d23a97591mr1453601666b.42.1765891597176;
        Tue, 16 Dec 2025 05:26:37 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:ea4c:b2a8:24a4:9ce9])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7cfa5d0b0dsm1693444566b.67.2025.12.16.05.26.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 05:26:36 -0800 (PST)
Date: Tue, 16 Dec 2025 14:26:28 +0100
From: Marco Elver <elver@google.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
	Will Deacon <will@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
	Chris Li <sparse@chrisli.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Alexander Potapenko <glider@google.com>,
	Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>,
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>,
	Eric Dumazet <edumazet@google.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Josh Triplett <josh@joshtriplett.org>,
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>,
	Kentaro Takeda <takedakn@nttdata.co.jp>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Miguel Ojeda <ojeda@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
	Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>,
	Uladzislau Rezki <urezki@gmail.com>,
	Waiman Long <longman@redhat.com>, kasan-dev@googlegroups.com,
	linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-security-module@vger.kernel.org,
	linux-sparse@vger.kernel.org, linux-wireless@vger.kernel.org,
	llvm@lists.linux.dev, rcu@vger.kernel.org
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context
 analysis
Message-ID: <aUFeBHuBJr-Y512D@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
 <20251216122359.GS3707837@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216122359.GS3707837@noisy.programming.kicks-ass.net>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Tue, Dec 16, 2025 at 01:23PM +0100, Peter Zijlstra wrote:
> On Mon, Dec 15, 2025 at 04:53:18PM +0100, Marco Elver wrote:
> > One observation from the rebase: Generally synchronization primitives
> > do not change much and the annotations are relatively stable, but e.g.
> > RCU & sched (latter is optional and depends on the sched-enablement
> > patch) receive disproportionally more changes, and while new
> > annotations required for v6.19-rc1 were trivial, it does require
> > compiling with a Clang version that does produce the warnings to
> > notice.
> 
> I have:
> 
> Debian clang version 22.0.0 (++20251023025710+3f47a7be1ae6-1~exp5)
> 
> I've not tried if that is new enough.

That's new enough - it's after
https://github.com/llvm/llvm-project/commit/7ccb5c08f0685d4787f12c3224a72f0650c5865e
which is the minimum required version.

> > While Clang 22-dev is being tested on CI, I doubt maintainers already
> > use it, so it's possible we'll see some late warnings due to missing
> > annotations when things hit -next. This might be an acceptable churn
> > cost, if we think the outcome is worthwhile. Things should get better
> > when Clang 22 is released properly, but until then things might be a
> > little bumpy if there are large changes across the core
> > synchronization primitives.
> 
> Yeah, we'll see how bad it gets, we can always disable it for
> COMPILE_TEST or so for a while.

