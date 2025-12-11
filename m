Return-Path: <linux-wireless+bounces-29672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A65DCB5FF3
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 14:20:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9D63F301F8C7
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Dec 2025 13:20:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35334313266;
	Thu, 11 Dec 2025 13:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HflTkvn8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10CF431065B
	for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 13:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765459210; cv=none; b=ki5PIiayvvvBVbask+t+rmMhMuqxl5ND9GGxa9VzTjDqSm936XMCnMuCKX8WjscKITiN3r2yN30O5n9SO7Vsrl7rSJliMlCX+GHTlIWZKYQUNkYCLR6DbZ/tVAZKAAyu3yZkL9J/GNb85Gr/Gm8t0TF7W/F5sjYgi8LbApMHRmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765459210; c=relaxed/simple;
	bh=xRpDisg42q3mlm2OwRhnv/Ng4aisbLnak6Lk2WbPerY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JU9/QgHe8DHaYfbJfWZUHpk7KhwWX50WNqsLi6SURy7I/Aq98wA1vbCfUXK2Sv7xt5V44Lr1DgSbyru/u9fTy2ofJH2z8y7BKJtijK54d50YzgquNxmS8inwiV6eNnNVrTM1bVbZw3PGxe8kEIXxO3yhAh+6UxxyMspK8t6Bzj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HflTkvn8; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-78c5b5c1eccso1098437b3.1
        for <linux-wireless@vger.kernel.org>; Thu, 11 Dec 2025 05:20:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765459207; x=1766064007; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aINMqpJxr1DSJJ7CC9TS1ttoat4qqoJbgL8dBerwdo8=;
        b=HflTkvn8hEQ5fY2RqhhszTXvTmLEvYgLZxCMcnDSLfuaLZuIErpFKXRxgf+UuHaC0O
         ZWeKNTs7qu+FT9MSt5UmeiYJQKzWSBhC49Im5iu+3YkzkxQJhXdRdqpSfKuiJ0WxI64c
         kPOlp4Q3bHCs0CYCUUh/Qt6ROZppFoOT9wu966KN8irGVJ58lhvNKcFIWsNtE19V++73
         OzRACFkmqDfIBaa2T9UEy6OzZdNiqJoxxuSB3FFZjmsiv7nibC0FHtgSTm4nffmNRTv/
         M/Dgzvj4OkQWQV3C3r/DSGsRc6QP/dXuVQAJsTnrvMWXM2YYqklOjG4eMkTYB2TDgvWU
         Ghlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765459207; x=1766064007;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aINMqpJxr1DSJJ7CC9TS1ttoat4qqoJbgL8dBerwdo8=;
        b=X6P5Lyr29w58OX6MgOFK8M9pI0uWoGxMbEozOuy+iX1IXYP+HPPpB+N+fgru0gU8XD
         136qAEuVY/0STrEwvyOuIrz2G6sJ6iOeArvDU9FZhC2gny+xVNNfEA3U7BVSk6xpoOWz
         53w74muo6MqOpvclBR+0PMLVlj1O1uA/WFIc97BPUzUwnOg1Cblb7LMPfY1cTuU/pqAX
         5j4tagFkoWM2fKAnSbOfS479Tu9Mxj3yVHxmbgOucLiiSNjiXbP/1lpwgBSpNPWk61/k
         dMrHwWa6ZK+rZXW1488xPlc5qkkEpFjVgGTGZAA/Jh+vJwOz8K+MknPiJuMvtTWKfpJW
         r6bg==
X-Forwarded-Encrypted: i=1; AJvYcCUKEB0Zkg4axRQAc81gwNWxL/kg0LM1A5f8le2iHIRIzLf90t09jZuPTgg2HElzUfg2mjm28WzOxYxGTXu/RQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeWcraDHleq/TyyNiis/ZAIsWoxUoDGX/N2rwdOUSk+hmHrGVM
	NepG0qyDcJr6RhRNu76c81DcE9a9YcUVUYsUo8X81yZSas1L2XTNuX4YSiccrh+89CT1zXVRlU1
	XEMqxCoIu3aeWuMhPoYNkVhg952/bk5qkHOuYwhxF
X-Gm-Gg: AY/fxX7xB55H0mLPSAXlISIJfKnPf0yI0AKQO3Y1i8hgFAjkbI0TTP95nUI6VFszl/A
	qp0e3jrbCl5HtHvxsGIir89P8t2eu/tLDWwYuFzW7+9wnafcXl5OFJCbJFf9vhHB4cKFK843SxJ
	9o732aGEONmjGyHYSA6Tkh+BS9d3rMI1haIQXkcSsnOZviQlE4LjUhDxBwxV9HPftvjRQs9d3Rm
	rm48U6UeUttFvOknQ98CkuijuIxI5SrpMjjhVeozaJMf44so7HViSrziQsIki/AP0gYBxodN3P1
	CyOEPm4ls6kBRkDTX5B95RYZks/9y5Cwdsw=
X-Google-Smtp-Source: AGHT+IGU9q+gRj8IYb1h4AykO50aa48oSg8Xgu9uuuuWfwfeI68H5yAO2hlPZXd3hwVQKsk/WdTiuzJsjMsANS/WvBA=
X-Received: by 2002:a05:690c:14:b0:78c:3835:496a with SMTP id
 00721157ae682-78d6dfa0ba0mr18429857b3.24.1765459206488; Thu, 11 Dec 2025
 05:20:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
In-Reply-To: <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
From: Marco Elver <elver@google.com>
Date: Thu, 11 Dec 2025 14:19:28 +0100
X-Gm-Features: AQt7F2pfFUoFUVEdkJ6Nswms767xMhA__DttYAE1PqX0AgFhiN8dcasmhdnfxEw
Message-ID: <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
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

On Thu, 11 Dec 2025 at 13:17, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Nov 20, 2025 at 04:09:31PM +0100, Marco Elver wrote:
> > Introduce basic compatibility with cleanup.h infrastructure: introduce
> > DECLARE_LOCK_GUARD_*_ATTRS() helpers to add attributes to constructors
> > and destructors respectively.
> >
> > Note: Due to the scoped cleanup helpers used for lock guards wrapping
> > acquire and release around their own constructors/destructors that store
> > pointers to the passed locks in a separate struct, we currently cannot
> > accurately annotate *destructors* which lock was released. While it's
> > possible to annotate the constructor to say which lock was acquired,
> > that alone would result in false positives claiming the lock was not
> > released on function return.
> >
> > Instead, to avoid false positives, we can claim that the constructor
> > "assumes" that the taken lock is held via __assumes_ctx_guard().


> Moo, so the alias analysis didn't help here?

Unfortunately no, because intra-procedural alias analysis for these
kinds of diagnostics is infeasible. The compiler can only safely
perform alias analysis for local variables that do not escape the
function. The layers of wrapping here make this a bit tricky.

The compiler (unlike before) is now able to deal with things like:
{
    spinlock_t *lock_scope __attribute__((cleanup(spin_unlock))) = &lock;
    spin_lock(&lock);  // lock through &lock
    ... critical section ...
}  // unlock through lock_scope (alias -> &lock)

> What is the scope of this __assumes_ctx stuff? The way it is used in the
> lock initializes seems to suggest it escapes scope. But then something
> like:

It escapes scope.

>         scoped_guard (mutex, &foo) {
>                 ...
>         }
>         // context analysis would still assume foo held
>
> is somewhat sub-optimal, no?

Correct. We're trading false negatives over false positives at this
point, just to get things to compile cleanly.

> > Better support for Linux's scoped guard design could be added in
> > future if deemed critical.
>
> I would think so, per the above I don't think this is 'right'.

It's not sound, but we'll avoid false positives for the time being.
Maybe we can wrangle the jigsaw of macros to let it correctly acquire
and then release (via a 2nd cleanup function), it might be as simple
as marking the 'constructor' with the right __acquires(..), and then
have a 2nd __attribute__((cleanup)) variable that just does a no-op
release via __release(..) so we get the already supported pattern
above.

