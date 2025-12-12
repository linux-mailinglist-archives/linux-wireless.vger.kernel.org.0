Return-Path: <linux-wireless+bounces-29708-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B0B1CB89AB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 11:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 829893079EAF
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 10:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A9B531A57C;
	Fri, 12 Dec 2025 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kbkpTIwj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B919E31A07C
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 10:16:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765534570; cv=none; b=su5jvtXulh/RTvtxW5Oh0v2B0gJAd6EdjRR75rMEj4y29zGNNLLxF4elznDBbOs36oC4u15ftXzDaVBKUzrfUund40beCC2/BXUsF0OlgUYPL1mYXNykuJk3RNi0fMOzczps8IQR/yKj71Dbpj08UQ4L7TvNDb/LZV2IiEwblzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765534570; c=relaxed/simple;
	bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=etWkJoshtZ/LS2g5+3nUIgVGX4RpcXRT3y2rg8swEwAvDluH0kXzLZe0TrlOsPxvECkHIxcVDXF9QHJDmMWt4OUbZUiCsEM1c0lP9JeR8uaUdYmp0jaXs+o7V+VTb1tJQm6ATDJjU7C63MJBxxEgfMWeD0/jU3jmRAbG7vSW7EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kbkpTIwj; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-bc17d39ccd2so672146a12.3
        for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 02:16:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765534567; x=1766139367; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
        b=kbkpTIwjpQS8ePNpRzQzmqynFKNs7/NxFbTXEqQxrUChBOEd0ClCuYdBQSv/22spWQ
         Mlau/Z1r7/t8B4xFGTNsO12c5ZTlO8IX7JmdNjWmjdVZ/Jjmk3SOeb81vSBizctBon6C
         b9PSWBQffnaVrZsxTpaFewgJOaV8M65WyBFjjc/d5LNfdNJtX504o4PmkXzgy9+JGpaR
         p+BOqszpjmfwPdF9SWGeFROnU0ow5OvvXnKcQ2WceWvfngjFOxfI5+Rs21yMoX+9CWFu
         9Pv3ZqG+EuPi3/Br8MUwkjm1WFmizI4Ur371xJf7pXnmBlKHwciyx1Eiw/6wKklL/E6/
         Jp7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765534567; x=1766139367;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yy8AVUr1WzoEhC0gwViTyIIecU1pDeO+TdO72jBT6kg=;
        b=sDF5sUSlWbS+Vl85yUE22P/X71g9VzMo1TshE9QL6z3mqTuSolWoKLWKopCIcwXrg8
         MYpexXmTmnhjj6buQTvwV5sZ/CwIK51OUdZjX2d2QfxZPnzDf/o4mh5Q4kELLQsFrNN1
         6Cx/xhjTs9UqKLBg1UnwKEAIUsUEhyHeK2yGE4zLKUBRQfMIxh7hozn08l8oBloyaH8P
         gHPyeCHlQEtN+1FYAN+BD+593qEoG1G9XMZJ8ZAzCFXPv5nyEm0jJDVMViTvYOlGDQ4n
         wPb7YIPOlxOpCH0x5XkLINKwsd+2cNpg1JvbXmUnsiCqXI8b2lWCheisASAE30r2Wnev
         MOFA==
X-Forwarded-Encrypted: i=1; AJvYcCUzVyNBlIc65yMkKtfwTXJYTsRD0bA7VzHiurUVejzA7nYvXNqOiUV8bspBEczmf0r7MlyBH/CZMHmkYD/Qtw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwGBjb6K3qjUS0SQAT+2f3n/bcpXfY/0ojwu1VdOSkqHCdxb8Wa
	ASJOXdCaoqLlDyLOim6FXPY0ILoMfU7k40uEBY+CI5sNehTFpZqQ6h+jZoY1WXDOr/TOOHU6B/V
	pflZwZe8IrxKIGcM4zNh2JO2vBh3l0aq5n8xN3WU+
X-Gm-Gg: AY/fxX5Ig2TOT5Q/tCaGXHhpn19gzZfiFXMyavPPArIGtSlMPHyX2apLvkyPWV4oONA
	3lMOcLm/eluDzhddwUbygsdTCa4lXlJyEldsVFlz3dkny4+Wk+dxDinDNN4ZU8vH6UDamX0gkoh
	feVmyl5isHPSmk33nUFMhOgPkuWgaerZT6hgs3uAYKDQagEW8GvEEp+rJA5uFPNuPmA0UyjLABU
	tm4BeT0YNjUi+8pIOH4w0KsSXxWJerVnVryxZL+Hh54vuFCtMPTTuQmwb6n/ZcuPnEOVgDZ2JHJ
	sh1trHmTsBO8kVimr4C7KDuhGEqVBbUfiFKHmg==
X-Google-Smtp-Source: AGHT+IH8fq53xzz4VEeZIfjpPn2aDZft0vSRUPpE08Jgar7Bwxv93jAlmI/oD2Bc5sYJ04yKuPnrNx+rDd5kmEFlwB8=
X-Received: by 2002:a05:7300:2aa5:b0:2ab:ca55:89b4 with SMTP id
 5a478bee46e88-2ac303f2fbcmr872533eec.43.1765534566419; Fri, 12 Dec 2025
 02:16:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com> <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Fri, 12 Dec 2025 11:15:29 +0100
X-Gm-Features: AQt7F2qb9ENq_mtkRfqCrKNBJnxHOwKNFDuSBIrcF4bjbeWckbG0712gmoUp-Ao
Message-ID: <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
Subject: Re: [PATCH v4 06/35] cleanup: Basic compatibility with context analysis
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, 
	Will Deacon <will@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Chris Li <sparse@chrisli.org>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, 
	Bart Van Assche <bvanassche@acm.org>, Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, 
	Eric Dumazet <edumazet@google.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Herbert Xu <herbert@gondor.apana.org.au>, 
	Ian Rogers <irogers@google.com>, Jann Horn <jannh@google.com>, 
	Joel Fernandes <joelagnelf@nvidia.com>, Johannes Berg <johannes.berg@intel.com>, 
	Jonathan Corbet <corbet@lwn.net>, Josh Triplett <josh@joshtriplett.org>, 
	Justin Stitt <justinstitt@google.com>, Kees Cook <kees@kernel.org>, 
	Kentaro Takeda <takedakn@nttdata.co.jp>, Lukas Bulwahn <lukas.bulwahn@gmail.com>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Miguel Ojeda <ojeda@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 12 Dec 2025 at 10:43, Peter Zijlstra <peterz@infradead.org> wrote:
[..]
> > Correct. We're trading false negatives over false positives at this
> > point, just to get things to compile cleanly.
>
> Right, and this all 'works' right up to the point someone sticks a
> must_not_hold somewhere.
>
> > > > Better support for Linux's scoped guard design could be added in
> > > > future if deemed critical.
> > >
> > > I would think so, per the above I don't think this is 'right'.
> >
> > It's not sound, but we'll avoid false positives for the time being.
> > Maybe we can wrangle the jigsaw of macros to let it correctly acquire
> > and then release (via a 2nd cleanup function), it might be as simple
> > as marking the 'constructor' with the right __acquires(..), and then
> > have a 2nd __attribute__((cleanup)) variable that just does a no-op
> > release via __release(..) so we get the already supported pattern
> > above.
>
> Right, like I mentioned in my previous email; it would be lovely if at
> the very least __always_inline would get a *very* early pass such that
> the above could be resolved without inter-procedural bits. I really
> don't consider an __always_inline as another procedure.
>
> Because as I already noted yesterday, cleanup is now all
> __always_inline, and as such *should* all end up in the one function.
>
> But yes, if we can get a magical mash-up of __cleanup and __release (let
> it be knows as __release_on_cleanup ?) that might also work I suppose.
> But I vastly prefer __always_inline actually 'working' ;-)

The truth is that __always_inline working in this way is currently
infeasible. Clang and LLVM's architecture simply disallow this today:
the semantic analysis that -Wthread-safety does happens over the AST,
whereas always_inline is processed by early passes in the middle-end
already within LLVM's pipeline, well after semantic analysis. There's
a complexity budget limit for semantic analysis (type checking,
warnings, assorted other errors), and path-sensitive &
intra-procedural analysis over the plain AST is outside that budget.
Which is why tools like clang-analyzer exist (symbolic execution),
where it's possible to afford that complexity since that's not
something that runs for a normal compile.

I think I've pushed the current version of Clang's -Wthread-safety
already far beyond what folks were thinking is possible (a variant of
alias analysis), but even my healthy disregard for the impossible
tells me that making path-sensitive intra-procedural analysis even if
just for __always_inline functions is quite possibly a fool's errand.

So either we get it to work with what we have, or give up.

Thanks,
-- Marco

