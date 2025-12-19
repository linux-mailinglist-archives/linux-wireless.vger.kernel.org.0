Return-Path: <linux-wireless+bounces-29999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9710BCD1F22
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3E9553022AA7
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:17:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC0246768;
	Fri, 19 Dec 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="V4YzBbXd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C622BEC2A
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766179035; cv=none; b=AKXga3BNffy19wBlK5yf5tMLPTURE9Mm1mHiFpkyxx3dzesUucm2KI5D2NaZm/TQfSztJTwHIKNNDqIeRWTNu3simsEkp2w2025fZwJtrx6NuvipDcbxei+wFlXX7J1HtDTSdV5IEwmrMpEzQ2ySX143qdd1s6LPhrrzHZUDQiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766179035; c=relaxed/simple;
	bh=LLpGwIKkDXp5hVROlTCKeGGUdVbJKYXE3k+8i7znnho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OcS/J758L5lMh9Sv6O6G1Vhv+Ep5o1w9qAWYhUsYI26mit1FABrpfbrHkLgdZbYdEEhBYupmMoaGxPhtbI8CXCUkzN1KX2Sm1yKkpzD88bCzhJjKLl5sqpBbNZWxn+OCjh5BdNwMZ86doBfZpm9/yhW8H2TGv4Thu2HM+5DyU4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=V4YzBbXd; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1994506b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:17:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766179033; x=1766783833; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=0rK9w1Snx+IiOS1yyTvDXywJSRfl2rZ6jIui6kPmEaA=;
        b=V4YzBbXdfQIieJZp0VnJGt7qtfMwAH5MdmJkO310lDFFybaA8U60ZNjsxN6/IZSzS7
         0e2qn2Z+fBWU5xP3BM7w5n3pXYSwgSMZDqeKAOy1/Ieq3osXSfFZicc/cjmRAJm5hgcY
         WwxXyWb10AlioOt0yEp97HC5f+8qPDZZMXNQZdAUfOatV07/4XN2TWT3GxvERX+75qNc
         AnV/axgAmieubX9aFeSXXMKKyHDX2aCGdOAGa9IRQH9vgxqylvXBRNf8TPwD1JcBhix3
         XHIDvHxoR4rnPovp7zplMG8xmY8peZwSt4QqRH3RLGBQMGvFLUvz3PNMPSAkSRg+IIpE
         CgiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766179033; x=1766783833;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0rK9w1Snx+IiOS1yyTvDXywJSRfl2rZ6jIui6kPmEaA=;
        b=nLTT8/DAC2i5txNj/b/65TkLDyUMFEpFcXegM5Hm7ywF6qNlxpTaZBWWzrdUaO3nTj
         O/b47G5MmKDf5n5q6ZgQMov6EN4Ntuq/4GIjAhLacQrSg/Xan5xuDGmTSQLOi+N2zbXb
         yjxedjSg+OZUhnugrVxRFOZu8SMg6DdeU9kTskDDuAzErewAYbdn1UVIRT6KZah8aqdO
         vbKp6Y7renH+H6F8s5+FrW5ALdNSq7IUeuwCqMor5oW5VFWFFZwLTJ99gX3mU5nZKVEl
         n+HJYGWTOG1pVI5pQ4AoF9qnfaQWReGrmibSDyY4pv0a5B2PzEgcpFWKJ+GVdKVhBQ3v
         0K3g==
X-Forwarded-Encrypted: i=1; AJvYcCXHegCPprTCq1gzWi29s0H1gkicUfkRRGYw4qp6/5PiS4iG0/mexw+7szqV6Ft8ZE5Yzx03R+4wVbhZRFNL7Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwO8VcmfGraAkGCu1eelgYafhxFf8JH6qRKk1t8RR5ofX5FqZDV
	GdEp4rLQUrNU6xLMOZAMguXCNU1KYWosz6EoCIrwZEGsWhvMI6kDhEVPJ9Mvr1CA6VIuL4Bn/kL
	LA7TL/wDvArHTb5rk0S4e23jTetY+vUoLsH+xkuzz
X-Gm-Gg: AY/fxX7IBEK1bvkEoIenTHN5GtrliTTKWRKtWKesBjeyCYuiQFJEV7T7zMNlzNj59nb
	zrGcBq4oDyRMkpQv7oqUfon8ciZ+O/xk6uPNRHrpvOuHc+KlFwZ23o3WFSz0ExYIoAq0z7xjg7b
	7uLMw/MLPP9Q4+ipClPfAcu5MTy6pAgax5KdVIkpt+tzFd2thtVvOqOZrOtM4l6joBNMaT53jO4
	DAWpgGo33zIhX1kJ0oPvBVoSXvawHqCv5L295rg+R0cCLOeFkpUlI0C+PHYTLfs9b6M7PN6Pri1
	VzxmqeX4ihnycdE2h2dtZ1yFJX50jBWm3etAyA==
X-Google-Smtp-Source: AGHT+IHpiDrn99m7x0uN4estdHNLC96nljKxP9R6JbsteT8HXtfNtk+xeDdUnA0onYdjgh5ezU9+Po7MHQlADcjwb9o=
X-Received: by 2002:a05:7022:2586:b0:11d:f037:891c with SMTP id
 a92af1059eb24-12172311ffamr3088830c88.44.1766179032817; Fri, 19 Dec 2025
 13:17:12 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-8-elver@google.com>
 <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
In-Reply-To: <cdde6c60-7f6f-4715-a249-5aab39438b57@acm.org>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Dec 2025 22:16:36 +0100
X-Gm-Features: AQt7F2oJirW61gdd7JR_kO6v8Pm8LYFzp_d0WJmR_my_E34K94emt-YaA94Rukg
Message-ID: <CANpmjNPJXVtZgT96PP--eNAkHNOvw1MrYzWt5f2aA0LUeK8iGA@mail.gmail.com>
Subject: Re: [PATCH v5 07/36] lockdep: Annotate lockdep assertions for context analysis
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

On Fri, 19 Dec 2025 at 21:54, 'Bart Van Assche' via kasan-dev
<kasan-dev@googlegroups.com> wrote:
>
> On 12/19/25 7:39 AM, Marco Elver wrote:
> > diff --git a/include/linux/lockdep.h b/include/linux/lockdep.h
> > index dd634103b014..621566345406 100644
> > --- a/include/linux/lockdep.h
> > +++ b/include/linux/lockdep.h
> > @@ -282,16 +282,16 @@ extern void lock_unpin_lock(struct lockdep_map *lock, struct pin_cookie);
> >       do { WARN_ON_ONCE(debug_locks && !(cond)); } while (0)
> >
> >   #define lockdep_assert_held(l)              \
> > -     lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> > +     do { lockdep_assert(lockdep_is_held(l) != LOCK_STATE_NOT_HELD); __assume_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_not_held(l)  \
> >       lockdep_assert(lockdep_is_held(l) != LOCK_STATE_HELD)
> >
> >   #define lockdep_assert_held_write(l)        \
> > -     lockdep_assert(lockdep_is_held_type(l, 0))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 0)); __assume_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_held_read(l) \
> > -     lockdep_assert(lockdep_is_held_type(l, 1))
> > +     do { lockdep_assert(lockdep_is_held_type(l, 1)); __assume_shared_ctx_lock(l); } while (0)
> >
> >   #define lockdep_assert_held_once(l)         \
> >       lockdep_assert_once(lockdep_is_held(l) != LOCK_STATE_NOT_HELD)
> > @@ -389,10 +389,10 @@ extern int lockdep_is_held(const void *);
> >   #define lockdep_assert(c)                   do { } while (0)
> >   #define lockdep_assert_once(c)                      do { } while (0)
> >
> > -#define lockdep_assert_held(l)                       do { (void)(l); } while (0)
> > +#define lockdep_assert_held(l)                       __assume_ctx_lock(l)
> >   #define lockdep_assert_not_held(l)          do { (void)(l); } while (0)
> > -#define lockdep_assert_held_write(l)         do { (void)(l); } while (0)
> > -#define lockdep_assert_held_read(l)          do { (void)(l); } while (0)
> > +#define lockdep_assert_held_write(l)         __assume_ctx_lock(l)
> > +#define lockdep_assert_held_read(l)          __assume_shared_ctx_lock(l)
> >   #define lockdep_assert_held_once(l)         do { (void)(l); } while (0)
> >   #define lockdep_assert_none_held_once()     do { } while (0)
>
> I think these macros should use __must_hold() instead of __assume...().
> lockdep_assert_held() emits a runtime warning if 'l' is not held. Hence,
> I think that code where lockdep_assert_held() is used should not compile
> if it cannot be verified at compile time that 'l' is held.

That's not the purpose of this - if a function or variable should have
a lock held, we mark them explicitly with __must_hold() or
__guarded_by(), and we don't really need to use lockdep_assert,
because the compiler helped us out. In an ideal world, every function
or variable that requires a lock held is annotated, and we don't need
to ever worry about explicitly checking if a lock is held (but we'll
be far from that for a while).

The purpose is described in the commit message:

> Presence of these annotations causes the analysis to assume the context
> lock is held after calls to the annotated function, and avoid false
> positives with complex control-flow; [...]

It's basically an escape hatch to defer to dynamic analysis where the
limits of the static analysis are reached. This is also the original
purpose of the "assert"/"assume" attributes:
https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#assert-capability-and-assert-shared-capability

Without this escape hatch, and deferral to dynamic analysis, we'd be
stuck in some cases.

