Return-Path: <linux-wireless+bounces-29673-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57B9FCB6032
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 14:26:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FCB830204B9
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB305313285;
	Thu, 11 Dec 2025 13:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="S3sYjDGk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01284313261
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 13:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459539; cv=none; b=EzZPNC1w1iLGnbciHDNnYnP/ieXptnwJl8NJJte2DXK4tZtlFwChrzL1lS1Zr+/gDnloQ+20vgSIvx1HNAUBqWO9ME/Mr8qSqljFfS8hyKcBYTQ/SoyiBIibsm/HW8AvS1KlnbFIvDMATDIquHIdTIln6AG3iWCzOlHf5mxUv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459539; c=relaxed/simple;
	bh=4koDoOQRFcQ8EnbnmmJvgwasJ9ijqSyJnmmWmgQ4c2s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C/lBrGkkKNzfMZ8r7NS9XdEhxylaqxznGcKnL0f4FkMYRb2NcfYlVB0fo9SNG0tI/OCmqqqi2+SlD11/MwIVEvos/0BOWLVtFcEOXyEOeMj9pD+y10nPHwWUXPXFXSMj7LTYSxmmPsfTsqMV9h3joJ0Llv6DPKmARhuA0R0Scbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=S3sYjDGk; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-6420c0cf4abso59328d50.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 05:25:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765459537; x=1766064337; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=bWA/kjxAjN+uRNvgRsuZ3C4JKMpyTL0y62dCZ1FivCw=;
        b=S3sYjDGkvoZmbdvrKBBU43ykeWBEyeIUzGZ1bUJYcShsHuHKiW4SEI2gYcMdxdZWwk
         2aA7slM8MmQr4oatTRXGZSDUu9aaPNBM5UXKIo4tZu3aBCHtdy1H/9eebAGdUo6qgX8L
         DvHj6zwUMUlBjO2u0UJVOCuNjgIiGKpFJ3xkH9rQCWgifZulMuykpqPtovrI/gQQK4fX
         tWozvIJabkt3lh8qlKQzKY5OQDpzBc2BgZrGHZlvzzLYrhdrhOMCB5DCqM/inYUnmrTm
         BOMqEJRR2hhdiarGzrCSpdsUJZAL7hGLrXSyYC+4RigvkTH6UsHPfhyza3j2GXbJnMLT
         uY7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765459537; x=1766064337;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bWA/kjxAjN+uRNvgRsuZ3C4JKMpyTL0y62dCZ1FivCw=;
        b=s09tmuEaNHaHRI58tssezps7grw7RuAHlezZUzVC3RgzXK1RqqLMzo1ZUE3Z+vPat8
         0kWA9xwA3CdQatHrEQ8szTQxJxPLdkLfhk2Rr4hT4YBFmoDiKtXlfBylTFYNJeYPy0DO
         IcklvWlRCkAQ++k5pWIdddgdX7rfiFfZEqCwpdUfEEcl3W9TktFktq1ZeR5lEZvSfIyi
         6ZAqK2gN1wSYRAWTyihAJ0Vt/Z1lN6kbyB7rLAJYBSwYgcbkYK3/rod8O7TkXQlNj+pz
         FzdeRJkC1I19ColhA0wmu1AqEuq2tFYEccCalMjyWyUDqAsJmag9ehiN9pwqyk1601hr
         4luw==
X-Forwarded-Encrypted: i=1; AJvYcCWkuD2DlAob2fszKmIifJ4IS8M4TIY9kPF5BbCwifSMiU68mVYprNWDj8UNjnNBd/XlVgzz/qJRlILAZyIr/w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzY6ZqqnSDipyZzsFaSV904O3gZ6cKBUBawhJTZHmbyRgEdp82b
	uUsFyTn1FK85LA0/e32ybxpdb11uivFEsp56G0HphJw4b1UkgOpBiykIHdxPzkzv7quOXeQbeOT
	PI+5n5goF1Nbma0uvYKDCeE8XcQTOCBS1CL4vtdrt
X-Gm-Gg: AY/fxX50U9eoBPMAJg93M2yZ3vWZDqSM2N5gO/EAxThq2r0b9Ze8AfPH/oXHKQK6jgv
	+AazaHDAPP3hloBuH5RSA3MK8rV5L5AtauiPOY813s9+Pid95G1x8C0RDLu9Oyyyk4QYO9Ojo8+
	5dFHFmnGT3LD9b1AL0w1dM3qENArs3GpJ4cln1FX8lOO5M5btM15xVfaHbtsoZiu2HNIefGgVMS
	c5niipeL8ZxXfMEbJB2cdYYsxawotDugKQtfAHxEMQxYiTAZfcydHe1aDDUQ9HhUpfP3zICSBz0
	JMmcoFIcUjgmejuJLGsxUg/VhH9ds4RBaIM=
X-Google-Smtp-Source: AGHT+IGPj4VYuvzobJuySeUtMjR2owpUV9b14snNLjzBypYDLw2+crQYToZkiUGcBVWZIJW//ll4Or+5K7PYShnu4As=
X-Received: by 2002:a53:d01b:0:b0:643:1a78:4492 with SMTP id
 956f58d0204a3-6446eb6016cmr3860639d50.81.1765459536448; Thu, 11 Dec 2025
 05:25:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251120151033.3840508-8-elver@google.com> <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211114302.GC3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:24:57 +0100
X-Gm-Features: AQt7F2r5KNsATXW8d-J0gXHLFG6W_D0lOL42kIv9mnu54Km1ZPN_9U9TSDd09do
Message-ID: <CANpmjNObaGarY1_niCkgEXMNm2bLAVwKwQsLVYekE=Ce6y3ehQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/35] lockdep: Annotate lockdep assertions for context analysis
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

On Thu, 11 Dec 2025 at 12:43, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 04:09:32PM +0100, Marco Elver wrote:
>
> >  include/linux/lockdep.h | 12 ++++++------
> >  1 file changed, 6 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index 67964dc4db95..2c99a6823161 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
> >       do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
>
> Since I typically read patches without first reading the Changelog --
> because when I read the code later, I also don't see changelogs.
>
> I must admit to getting most terribly confused here -- *again*, as I
> then search back to previous discussions and found I was previously also
> confused.
>
> As such, I think we want a comment here that explains that assume_ctx
> thing.
>
> It is *NOT* (as the clang naming suggests) an assertion of holding the
> lock (which is requires_ctx), but rather an annotation that forces the
> ctx to be considered held.

Noted. I'll add some appropriate wording above the
__assumes_ctx_guard() attribute, so this is not lost in the commit
logs.

