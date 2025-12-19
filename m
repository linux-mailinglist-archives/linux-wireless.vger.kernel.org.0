Return-Path: <linux-wireless+bounces-30005-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD1FCD20D8
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 22:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A183E305A3F4
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 21:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 377442C235E;
	Fri, 19 Dec 2025 21:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wxzxqX9N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D36029C321
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 21:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766180956; cv=none; b=psb/UH7zv6N94G8z2nW2R9SDgc9o2r/syOSsR+G0M/KjuL2dgedNId2yM84knqMI22iH85cQkbylM9OK7AmkOVh5sZQGaY9QECWpQ88UKSKKruh5yiOddflXMa+QvcCQAqSqdnJxkzOdvY6oPmlXAI8iGNhiJ2NOj3TgrYXTLVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766180956; c=relaxed/simple;
	bh=k9J0WFzlkYtCk1RXVJs8ICS2UcS46vYMNi/KF0RXH0A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=n1wPkLEFhgxk0ySEdVCIkvT9PFrSIXPC/fd+NY6U38kGZBS+11yfN8oSVLCkZUibgZQDN6+xy4eMfFLzMVz3Rb2hMCW9Gwc183MGn79Y0bU59y+gqR1l5yeAmPke2tNyZEJdpGco3bM86JG9En8q09OiFuUUIkhEwaj5e7+zvv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wxzxqX9N; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-34c363eb612so2140787a91.0
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 13:49:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766180952; x=1766785752; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NzDuEDjTM8ZWLDMfL/9YFXqkNSYfSWOUAvfjFgQokA0=;
        b=wxzxqX9NTO+ux5QSAcxOM6N4IFypnQhbKmPscGrkLhB0JOtlA75xFwJBn3T/ndKGFF
         dGu73fTDFG1w7J7q09Rt2RIg0RiPTxdyLZAi9Yo7VnX4CCGDbs+Al8VT5I+bWlMi2RSa
         2FbFx4vLCJK8j0nAmNQv4ZuhoB8LqGTKjzRN5XBCWHSTJLbQiVTuCIkipaAoML/6gSY1
         JVw//ZcP0nWpjLQ/CeXnGTPTOumpHJ4dU8U8gMyF3aTjQe321HLJGcUCIclL0o8h2+BZ
         7p+xcyKOMxVFgvpAYQBtWCVrv8RzLkh0A5kz4oHK0cAt/eZmsHmkQgBgG6tbS+FLp400
         uL7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766180952; x=1766785752;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzDuEDjTM8ZWLDMfL/9YFXqkNSYfSWOUAvfjFgQokA0=;
        b=WsimjdK85lXEqaSis72fDFfeCcpthxzAkAzOOEYXGVpLGPQ/DSknBLxE6ZUev+62a/
         bu4KgwigsGq61kpbyAtUvheDpdLRZkO3h2VS1D7MB9tMjXSm1nIJGEz0hMB60n0OJhtN
         VjuV36tExZyL5+WUOrgGql4a/haU7uHE9FFeyd61etjtYjLhkNqQRiCmeM1QmU9Y/emr
         7Ozj/w6bVZ8Mk0pCG8o5Y6+bgItEvpA2PYAdBAT1ehcOO0pfZ+QWItugFhB1UEnwRTvu
         v8D66v5TKxhcAndo3ULIcZ0UBfDNpEmswySrP09+JugYVBJmOe6ZxK8Uj0ZOmbGSmyEv
         O3WA==
X-Forwarded-Encrypted: i=1; AJvYcCV4ND6Vx6tNrAMCnRDE9bX2a4RnGO/aSDJ2qnprq3eDcz0eS4uZsTh3ZWUg9tpLeih/JxQ1d7DLWLlMKyfUDA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzvs0wOskn7dCCWpI00Vy2g02yK1Luv9dMj5pLMO7Rp2A/oUD18
	s9bnqPOVEgLhUOmQ56UIr1GRKktpPwCbVvkKU4OwehVCOsXMfvtdQgy9SVgyL3Kv7xFjqhB4X2q
	M+y1QeE5MEmc87lltJRfk69SiueAZL8RUp2kKiO1Q
X-Gm-Gg: AY/fxX4in9L9heRwpiWXvAcec079EgWLpRECXGtHwMtRQBVYsmjycsGyCqG3WgYkckH
	Ld3GKeOr4wWkDSdzdpjBzU4aFfHZYAdaUTz3V/Uyk1DMc2hd1reSaaaPlRaI08GgWiFvE5X93ht
	vcEXEwInhCCkphP8ds/EKsob3Fisu2qRSIPlMfohPOfFIV+a6yBgvKF2keL+mrXP5hZCQFhQS0H
	RhckXRs6582Q3vlZKDghCHRlaDiAxxUk6LgAHfnCuRrkoABUGQm8SZr59jsBBW85UUunohb7nOg
	tvbhpi9h/rrMYg+PMKh1YC33m9g=
X-Google-Smtp-Source: AGHT+IH1wb+RKJ6da97DpXPpqA5MRT8qx5b7FDx5k2pjduqaEcwfYWMMGR5Rn4FLqe1i8Vtg4dzqeBXKvhP326Y4ZH8=
X-Received: by 2002:a05:7022:213:b0:11a:4016:44a5 with SMTP id
 a92af1059eb24-121722de1e1mr5781198c88.24.1766180951816; Fri, 19 Dec 2025
 13:49:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com> <20251219154418.3592607-9-elver@google.com>
 <17723ae6-9611-4731-905c-60dab9fb7102@acm.org> <CANpmjNO0B_BBse12kAobCRBK0D2pKkSu7pKa5LQAbdzBZa2xcw@mail.gmail.com>
 <0088cc8c-b395-4659-854f-a6cc5df626ed@gmail.com>
In-Reply-To: <0088cc8c-b395-4659-854f-a6cc5df626ed@gmail.com>
From: Marco Elver <elver@google.com>
Date: Fri, 19 Dec 2025 22:48:35 +0100
X-Gm-Features: AQt7F2rGv_yg31bAGJRVSa1c9k6UbjL-L12dGmORxx_mEF1TxDypAURYmp5bQlk
Message-ID: <CANpmjNN4JNG1OSWfGd2fAqTyYQ+Re7Czn796WD-47TwmuECxaQ@mail.gmail.com>
Subject: Re: [PATCH v5 08/36] locking/rwlock, spinlock: Support Clang's
 context analysis
To: Bart Van Assche <bart.vanassche@gmail.com>
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

On Fri, 19 Dec 2025 at 22:34, Bart Van Assche <bart.vanassche@gmail.com> wrote:
>
> On 12/19/25 2:02 PM, Marco Elver wrote:
> > On Fri, 19 Dec 2025 at 21:26, Bart Van Assche <bvanassche@acm.org> wrote:
> >> On 12/19/25 7:39 AM, Marco Elver wrote:
> >>> - extern void do_raw_read_lock(rwlock_t *lock) __acquires(lock);
> >>> + extern void do_raw_read_lock(rwlock_t *lock) __acquires_shared(lock);
> >>
> >> Given the "one change per patch" rule, shouldn't the annotation fixes
> >> for rwlock operations be moved into a separate patch?
> >>
> >>> -typedef struct {
> >>> +context_lock_struct(rwlock) {
> >>>        arch_rwlock_t raw_lock;
> >>>    #ifdef CONFIG_DEBUG_SPINLOCK
> >>>        unsigned int magic, owner_cpu;
> >>> @@ -31,7 +31,8 @@ typedef struct {
> >>>    #ifdef CONFIG_DEBUG_LOCK_ALLOC
> >>>        struct lockdep_map dep_map;
> >>>    #endif
> >>> -} rwlock_t;
> >>> +};
> >>> +typedef struct rwlock rwlock_t;
> >>
> >> This change introduces a new globally visible "struct rwlock". Although
> >> I haven't found any existing "struct rwlock" definitions, maybe it's a
> >> good idea to use a more unique name instead.
> >
> > This doesn't actually introduce a new globally visible "struct
> > rwlock", it's already the case before.
> > An inlined struct definition in a typedef is available by its struct
> > name, so this is not introducing a new name
> > (https://godbolt.org/z/Y1jf66e1M).
>
> Please take another look. The godbolt example follows the pattern
> "typedef struct name { ... } name_t;". The "name" part is missing from
> the rwlock_t definition. This is why I wrote that the above code
> introduces a new global struct name.

You're right. My point only applies to "typedef struct spinlock ..."

