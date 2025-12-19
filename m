Return-Path: <linux-wireless+bounces-29998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 905E4CD1ECE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1894C300644E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:10:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1859341642;
	Fri, 19 Dec 2025 21:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PwDuScq5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 461271E520C
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766178601; cv=none; b=XobhaRatMBC9l9DxNqwefFyY27b1FSVR6PSHsvtMFEpmlEqSVncBN1U5Wzqw+ebxJufg32aj8RCLTX0X94FiLxmDRK2trqDIu7+JoWRC1I58S1q0+yzRZExcXKCOyJeyXDH4bEfH2DswW33ND9haKnJ0Y3QIjHacBIOjiaiM92U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766178601; c=relaxed/simple;
	bh=iqhEYrpWgm5Yfz8pxMwX3Z8XLhEcxpfARdS1KcSLhis=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iHTOyR29TgWqK7HDwN4eYxrjpYF4AeTcX4nX2YNdtUWfc8xZFIlbzYmHhgyjKkzIIx8paez0a8bCYG3E9eIP7hVir1tYgzb71rpuLWCeO1i9zkpbDXS9qhCrlMNJtoWdI3Al//fG1InXNZJo9NpkQk21PKeT6vsvgf237hujj4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PwDuScq5; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c902f6845so2865726a91.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:10:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766178600; x=1766783400; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iqhEYrpWgm5Yfz8pxMwX3Z8XLhEcxpfARdS1KcSLhis=;
        b=PwDuScq5uKrCO6abf4MvGNoS2mKDzBjKYJ0bmhTBciEbsfEZPL8W1fZ5ueco+n190+
         qC1SNl5YEtS1IdQ/tG+2hrFXMcLWkoZNRGb7WSoFCc3nf3uyQ0oYiWaIk9rZT3MVChUE
         76yw3iWuODcst7Rk/h8qgT9xHw66X0aJxXevk9+1fAOZCe4xf+4eA/c8FafVYwoKBlU5
         KUvXkGaunNgrVUUi3o22zWzLA1Uke1H2puCSY69VY/PPYf9W/kL2ph8YcbNGmF8Nyw98
         uf17JPqE8ARf2s05s+jtQV6IPGBqoEcmOsvlG3wXi4bjlQhVclB4y6KQ7Zl/NZVJ+D+O
         cKBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766178600; x=1766783400;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iqhEYrpWgm5Yfz8pxMwX3Z8XLhEcxpfARdS1KcSLhis=;
        b=u1KyRNgu0vqG/woA6fb8Mbc8sA76jYdjNojCErmVxxOK+xvJRKZ3LbkV12cZN4uUOB
         am0gM8lBiC6sefg/j1RJPmpkxJ+CLj8XF6YzZK8Kcp1rA+pB8okGBgSQ21uhEtelj1Zs
         /myPVdcytT2dG08EyzNdveMEaeqT3dwONW7KrXpObxXA4Q4IXDvJbUg7Sp71LdfvkAlL
         ARxmsCbajvGr8kpEHZrDIdoDR5ozDfvmr5avrO6YT8YaGpZpLqxg3puYHFpCz6Yh46rk
         gU969tlO1eEwJvS7+XtIfDaAfA9lua2AuhkTR5QYEMXbLswALT16SAC+MLYTHI+FScKU
         hHtA==
X-Forwarded-Encrypted: i=1; AJvYcCUTPpG0vY4+CFZ6L4N5kQj/gwn9FDmhp/IMVLW4pi7j4Y7pP8muGPr9UsA697ahKdiYYkh60gdOkXigW51MSQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7E1p9Pb5X39bXpwVYTInZm4gV+kVMrOBg+7t9PwwRkWkHFPvo
	lg0sny9GDQl6btfzt0uVyZDlOWjhiCznaoAK8rPEsXusbvVw3AYnhoMhyTARMyQkQEfnt0n2Sg2
	Zcpe1c+I+VubH2zvrnWTIp5FI85HRrGeq1OoCKLpU
X-Gm-Gg: AY/fxX64rFJaTYG7KgMICuf+fammTEJPtrCbws+j/40ca8sbildhWYiGZIrab6zxVgP
	eOm1RpAJZk4dhHYWZhM65bQwzlrdk+jl/mKg8199VSA5Xh80K4Y/ZbnTM38RJbCCXhgklaHFKft
	02+BL/nDWvS6nHV/rY6mLvhZ52rbqO5iIXBYWJ9SdKcDH6+5iYUJOMXgMkxde+PJnoCQXP6zYWW
	SnwlPA2OS26eya4LCz4p1BKs7fobYAL4h+Vw1axlHzDA925j18YF0y/1vrrGSfEVTy7zMAXs/rL
	rcw3/p55kZf+2W/X5yagrCnDUg4=
X-Google-Smtp-Source: AGHT+IGdr0jH8cGEaDB7eA0QDwFP/5Ve8WscN7cZkV8XMcvDcmhs6BtuLqrVUM3kTfn7w87OZJ/+kODUMJAxXUcmHFc=
X-Received: by 2002:a05:7022:ef0b:b0:11b:9386:7ece with SMTP id
 a92af1059eb24-12172309509mr4284248c88.43.1766178599422; Fri, 19 Dec 2025
 13:09:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-14-elver@google.com>
 <3b070057-5fda-410e-a047-d9061d56a82f@acm.org>
In-Reply-To: <3b070057-5fda-410e-a047-d9061d56a82f@acm.org>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Dec 2025 22:09:23 +0100
X-Gm-Features: AQt7F2racRCVQBtX1XHCEqHFLvRozCqLgqx9fCp_0Wp28A2qceHYZ0Bj23R_eEk
Message-ID: <CANpmjNN6QrxwUUkpAopTfxLwUqGfB53J96dwOWHNcoYrOrEocQ@mail.gmail.com>
Subject: Re: [PATCH v5 13/36] bit_spinlock: Support Clang's context analysis
To: Bart Van Assche <bvanassche@acm.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
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

On Fri, 19 Dec 2025 at 21:48, 'Bart Van Assche' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On 12/19/25 7:40 AM, Marco Elver wrote:
> > +/*
> > + * For static context analysis, we need a unique token for each possible bit
> > + * that can be used as a bit_spinlock. The easiest way to do that is to create a
> > + * fake context that we can cast to with the __bitlock(bitnum, addr) macro
> > + * below, which will give us unique instances for each (bit, addr) pair that the
> > + * static analysis can use.
> > + */
> > +context_lock_struct(__context_bitlock) { };
> > +#define __bitlock(bitnum, addr) (struct __context_bitlock *)(bitnum + (addr))
>
> Will this cause static analyzers to complain about out-of-bounds
> accesses for (bitnum + (addr)), which is equivalent to &(addr)[bitnum]?

Only if they decide to interpret never-executed code (i think the
kernel has various dead code that's optimized out that might trigger
static analyzers if they analyzed it).
But this could probably be improved by using a different idiom, and
using an empty inline function that takes bitnum, addr as args, and
Clang simply takes the call to that function as the context lock
identity.

