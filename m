Return-Path: <linux-wireless+bounces-29212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B4C8C75E9A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 19:23:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8246834FFDE
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 18:22:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C9B35A95A;
	Thu, 20 Nov 2025 18:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="J/IkutnX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F832352FA2
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 18:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763662975; cv=none; b=E6sVFXN+2aN5AWoG9HolWRiEponCvfQu+myAjIDVCE1qvZmyhQoax1C0nJ/x/ZsIluLHqnqryDZWKt1SN1ipCMlQ2P8TFvRaybtq/C3GaWFKpbQEo6FKSDi6tfw8GmTkzaJO+7sPuuST3eV7H1CfhqQuKJUTYtBiYjvdCHxc970=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763662975; c=relaxed/simple;
	bh=wecZEUleM2pVH/ldG6VyoxAP3Tx+t9JIJBh2fst1eeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ddXM35hduj2GOfduNwZSvnSm6leFSlmtnwwbM18A8bsA84YFsf9mogRihqsO9xYBcEb2hg3FGslRdTtyHvmBoW8+mH77CEu6/RsdFDX7dvSfgMTjSw2QSyOiOfoUoCW7BysYCH3Hy4iGY8lM1bUJ+ohU5pB29ad7TW6Djqe+hTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=J/IkutnX; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-37a875e3418so7632131fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:22:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1763662970; x=1764267770; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=J/IkutnX5xh5twoI+/c3+loAYdV5odj/zi2fFt1XB0txraftqyAMH0YbDmXS9RCeKP
         TZ4BiYtxTr+zNGd4qvxTOz66q4I/PjSc/C2ZiTX4NkCEpm781LiVSh1FCKdv7FZ4k/hG
         XKPtEn/gAta/Oi23o6o6YEMwCMepQkpMoWZ+A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763662970; x=1764267770;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+BPfdnrOHpw/8tC+sL0oorkp9gKYtrunKdRWYzTn+GA=;
        b=nyUuCUfy0Og2+9dH1AsZVGhcLAeifbx/0siDeF0T+piQneQ5ec8egbFVC5OlKHobD9
         4gycibH3z4mtcQ17o31VzEACFvbE55hN/r6GMFYWS0S2zdWreWIisaqkNW+PAQYz/rBL
         xbrE92iDR/9cLh+4qK3olt5rxvIyns/lOVARX489pyj3EK+SGHUjIpf27ZBTo7z3KJuq
         ZYCTxdjJWBXXvUOI32kxuyCKrZBIbWeO4KtKyxNf1mhXowmKsJXTWhA31ZVyZeGgtWaM
         SfmIYbo9xIAiHK+Lu9Stvb6A5Dfdqj4up8KQ7qL0ECrA3wgkyQvrf1Uw9idsWK7d7xkB
         0L4Q==
X-Forwarded-Encrypted: i=1; AJvYcCXHBQRwn2EsNFTT6ih3mehqlEgewfTyJN9E6MmTjA1f5jOgaVnFNtn54xmdDGaMv6AB4Sz2C2pRAJhUjvFmXQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPht1ceLeQWrLT3+jF5Q/xvJglrYhqTpUHaVR28pStWxq2fGxy
	H79fO50VDJI4rR8iHNoIjMZJIQH9gC0UV7mS+jtTxQniHPvTUQYWCbW0YLMHNvqJBBTfvbrLqNS
	4HAPH/Akn/Q==
X-Gm-Gg: ASbGncswZt5L7XL14k5XPjToFcjvDchnUJNZWqbb6Lm8LOgOof4gMXdXhGaHgvF3uC9
	M335jlazPxNTHUnZFdK3XTbB0aF8hbRXIeIiOOFPuxtYHNwKOUO19LnW9OO3gTxtCeW9+A+f93l
	cKyT0AoHiiLIXneA2IqSuBJdeSjhWAxOi2ImQZX/hkw+S99TzE/6OMun8fIgogedeUIE4H5TC0R
	P6DLadz8SpamhmvlVQlflut0lSRwFw04iEyK7c8b0diIZ9DRwEnD43VCks3ePJoX4aC9eoqswwx
	FmzC2zbWKez1QfMxzWqXsqvSq4WyfqqZfym0/La9fQB33FflWOU/0LLOIvtBr/BgQDU+KIq8yVF
	vGnk/rttUuwCHd2nveIy170Z51z7TCPckznK6pTAbb1eq47SQqrF6npqKzlTt23A8hauyOFbtdD
	KXXb55VMG9dKKnrswvU20nPiLRc4cW3m709yG9bL9ahp+FYLAY4fSuuLOn3q+7xcIB
X-Google-Smtp-Source: AGHT+IGejVSpNyrLlPssa6W05r4UcWARqMSkCuWIf50HMTvOe7dUvOQ2ScDuybTd5uTibUOnNlP2UA==
X-Received: by 2002:a05:651c:4396:20b0:37b:aaf7:f007 with SMTP id 38308e7fff4ca-37cc679edcemr10999981fa.31.1763662969702;
        Thu, 20 Nov 2025 10:22:49 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-37cc6b59d3esm6055471fa.14.2025.11.20.10.22.49
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Nov 2025 10:22:49 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-37a3d86b773so10737351fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 10:22:49 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWwT5FP0io++G/AC5Bj1/uZsHEibpIhjBCYRxb8/j6OdTctsglbfswVEGqNIq6kSfAPQU/amflKxhT6evNcXA==@vger.kernel.org
X-Received: by 2002:a17:907:7f0a:b0:b70:b71a:a5ae with SMTP id
 a640c23a62f3a-b7654fe9b97mr482177966b.44.1763662490181; Thu, 20 Nov 2025
 10:14:50 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120145835.3833031-4-elver@google.com>
In-Reply-To: <20251120145835.3833031-4-elver@google.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Nov 2025 10:14:34 -0800
X-Gmail-Original-Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
X-Gm-Features: AWmQ_bk-my8wSL6P8yRhTUREdDraem8VrQQmjD7uS2S9oN6T2mRX46ftlS1ytQU
Message-ID: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
To: Marco Elver <elver@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	"David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
	Chris Li <sparse@chrisli.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Alexander Potapenko <glider@google.com>, Arnd Bergmann <arnd@arndb.de>, Bart Van Assche <bvanassche@acm.org>, 
	Christoph Hellwig <hch@lst.de>, Dmitry Vyukov <dvyukov@google.com>, Eric Dumazet <edumazet@google.com>, 
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

On Thu, 20 Nov 2025 at 07:13, Marco Elver <elver@google.com> wrote:
>
> --- a/include/linux/compiler-context-analysis.h
> +++ b/include/linux/compiler-context-analysis.h
> @@ -6,27 +6,465 @@
>  #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>  #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
>
> +#if defined(WARN_CONTEXT_ANALYSIS)

Note the 400+ added lines to this header...

And then note how the header gets used:

> +++ b/scripts/Makefile.context-analysis
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
> +context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS             \
> +       -fexperimental-late-parse-attributes -Wthread-safety    \
> +       -Wthread-safety-pointer -Wthread-safety-beta
> +
> +export CFLAGS_CONTEXT_ANALYSIS := $(context-analysis-cflags)

Please let's *not* do it this way, where the header contents basically
get enabled or not based on a compiler flag, but then everybody
includes this 400+ line file whether they need it or not.

Can we please just make the header file *itself* not have any
conditionals, and what happens is that the header file is included (or
not) using a pattern something like

   -include $(srctree)/include/linux/$(context-analysis-header)

instead.

IOW, we'd have three different header files entirely: the "no context
analysis", the "sparse" and the "clang context analysis" header, and
instead of having a "-DWARN_CONTEXT_ANALYSIS" define, we'd just
include the appropriate header automatically.

We already use that "-include" pattern for <linux/kconfig.h> and
<linux/compiler-version.h>. It's probably what we should have done for
<linux/compiler.h> and friends too.

The reason I react to things like this is that I've actually seen just
the parsing of header files being a surprisingly big cost in build
times. People think that optimizations are expensive, and yes, some of
them really are, but when a lot of the code we parse is never actually
*used*, but just hangs out in header files that gets included by
everybody, the parsing overhead tends to be noticeable. There's a
reason why most C compilers end up integrating the C pre-processor: it
avoids parsing and tokenizing things multiple times.

The other reason is that I often use "git grep" for looking up
definitions of things, and when there are multiple definitions of the
same thing, I actually find it much more informative when they are in
two different files than when I see two different definitions (or
declarations) in the same file and then I have to go look at what the
#ifdef condition is. In contrast, when it's something where there are
per-architecture definitions, you *see* that, because the grep results
come from different header files.

I dunno. This is not a huge deal, but I do think that it would seem to
be much simpler and more straightforward to treat this as a kind of "N
different baseline header files" than as "include this one header file
in everything, and then we'll have #ifdef's for the configuration".

Particularly when that config is not even a global config, but a per-file one.

Hmm? Maybe there's some reason why this suggestion is very
inconvenient, but please at least consider it.

              Linus

