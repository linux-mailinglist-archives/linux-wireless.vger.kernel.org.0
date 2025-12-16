Return-Path: <linux-wireless+bounces-29798-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 41230CC20F3
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 12:02:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8976E3027A54
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Dec 2025 11:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B866F33B6E4;
	Tue, 16 Dec 2025 11:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZpviBOjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B2433BBBC
	for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 11:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765882874; cv=none; b=fe/lD+64t27SXx50+SbbwCXfUZVUeCoK9eJgYLYvx6GV3uHgyqBtZavXaRTPeLZR4aRwaTYPH7V0f9zQls65fgmpk1xFjdn98yiAb8Ys6VzVKM8K2drX+YSUZCWdhN2cjxgh5QnShKDbiW1JIfUa0zFxee3AuYX2IaCcB0yD7SY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765882874; c=relaxed/simple;
	bh=mOm64EM4tgjM1MXcHPhVsoMKtGcavhpQka6kUnBhwsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D7fsj8cI2d5eMYMYeWCGEworC0tBP/OCqA5qL1Ga3L6ZsNkaQyMzhdDsGixBJAFur3fVBXQr/UBEemCiiifZMOZSej3/JkF3xBckZWhWqDpqY/4nay+V/Cxfr/w3Bi1VMNQpecLPz14HjwrSol45b8Xh8dv66pDKoLIcKqaqW54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZpviBOjD; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4779a637712so29808445e9.1
        for <linux-wireless@vger.kernel.org>; Tue, 16 Dec 2025 03:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1765882871; x=1766487671; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3fwbXvgWn6Nd0xRDLnbqnTLufRK/0AjdBlMA+CLIc/0=;
        b=ZpviBOjDfIsPR/XLfIKK+E0LIxfXjaTtVEH5dh2NuZoghJq5XN47vDA9xiaqnrcHWW
         EnOS1JV1hbBUhWh0NVgF4UOpTm+TdwMOl6ljVwzHAQp83Nlo4u7SeTLoNigK7QIahXTv
         qoP/kMr/yPJD8DF2mghOx0N0hZKx8GX5ArUQB3NtLwKcrPiW+9Rmjtod5+ooHKGa8ykf
         ZYAt9JIaU4zdF6HShCHWD/ElcjWSd0IvTUE63gEX9ZyUE5xwEBIexAIMeXNVu2/zr3Ib
         hmANx7BFkha7D6hca0s+i4hT+H4E8wwd08e81wNQwvDx+ll1BnNFs5hFyCbDLEZo1KbN
         a8yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765882871; x=1766487671;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3fwbXvgWn6Nd0xRDLnbqnTLufRK/0AjdBlMA+CLIc/0=;
        b=aaWki6cEAVapy8M2V4VRpobDkY2sGHsKuT3LmWRR3CKXw6zn5T8OS7u+04D1oQ2wL5
         /fjSds/6BoUkiKMq4PN1uXZmGxMOVG9+OWZzrYYeJIV2V6MTrLIhZTYqFg0qGbgJiryn
         Cc0nSiPxr1aPRq4Svv5myAGXLb5iirqcDrhmnCZx1j79tA0jqsR8Wmc/2dnTg83ygBiD
         //wxJfUZ3SaIsX2RzYY11lvUTqiSk0pOmUM5S0+vN+GXjciTkxf/d7e9qvlBNSLNCqes
         0UAF5038f/mdpWvjuaByy+6dRRLCgT3Il/Xivy5DaGaF6iKzanzxfs4u2skWz7l6xOzE
         ExUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVAMKxmEVxVMsQvv9ohJ+l/b3FrrAHJF0i2BbHLUoAC9Tt7hA/1tlUiHXPrw3LmdBCUM/6ncmGlnJn8+Ifkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLvBizzgvMe2Tt6m3eYvAGUbb+jZbWU41zq7325e7wpqQr4z9l
	FWuwn6AdfQk9gsR36GSdZul7+cxAk9ZpaOYKg7Y7uvNUoStLVSH9q4f13DKZO64Mqg==
X-Gm-Gg: AY/fxX6pBwbambErA91IaYlIS9Tcn5GVVCYKU+TXp6BD47FIrcCX42r+1TXD+IX+JBP
	W0ft/UuoP4ykyO2/6ZLbMq79ZTuua3VEVR0yFHvrNyW1aAYfE42VqYfKOACZ3aI4PPQkehk7BTn
	LLQd79u6Rgdxulsk5il1JksEDCApTLIE0A81iGvesuYnL9fM2UyV0fu0chBtaZMpjPxATibR4js
	PzsRGpldIbHuDoQB1D4Tkirb0vAsdEOV92adQ0k6sUpJyMFA7/YWXZBM3bErzr85XLRQ2Ull1Ld
	1i5oPWJvGUOEdUk9u4wPmtosKSuFxm1VYS7XeCtBlPEyz98Udq3jUgzKza4SNTafgXDOXfdC9R/
	PzdWo4LcHecRqjCeDzLkZksoYDAnvixGxdxfIP2+wGcBn9tHbv1C3vb+IV5bptY2D4mAweFlXB2
	mZAMl3TSr6UUSztsL2dHMFIFDqd278nAQ0gwbHBHs1bXMm3MBATRp/y71XKp4=
X-Google-Smtp-Source: AGHT+IHPMwFoz32u9J3kCO+8mIIo+dWtYExr149Lgk7NY5BncmGMC4iCyfwqqX0j0PAhtkij+iZr9A==
X-Received: by 2002:a05:600c:3ba7:b0:477:7af8:c88b with SMTP id 5b1f17b1804b1-47bd3d41de0mr37923685e9.11.1765882870450;
        Tue, 16 Dec 2025 03:01:10 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:ea4c:b2a8:24a4:9ce9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-430f5f6ede8sm17789236f8f.4.2025.12.16.03.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Dec 2025 03:01:09 -0800 (PST)
Date: Tue, 16 Dec 2025 12:01:02 +0100
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
Message-ID: <aUE77hgJa58waFOy@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120151033.3840508-7-elver@google.com>
 <20251211121659.GH3911114@noisy.programming.kicks-ass.net>
 <CANpmjNOmAYFj518rH0FdPp=cqK8EeKEgh1ok_zFUwHU5Fu92=w@mail.gmail.com>
 <20251212094352.GL3911114@noisy.programming.kicks-ass.net>
 <CANpmjNP=s33L6LgYWHygEuLtWTq-s2n4yFDvvGcF3HjbGH+hqw@mail.gmail.com>
 <20251212110928.GP3911114@noisy.programming.kicks-ass.net>
 <aUAPbFJSv0alh_ix@elver.google.com>
 <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANpmjNNm-kbTw46Wh1BJudynHOeLn-Oxew8VuAnCppvV_WtyBw@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Mon, Dec 15, 2025 at 04:53PM +0100, Marco Elver wrote:
[..]
> > > So I think as is, we can start. But I really do want the cleanup thing
> > > sorted, even if just with that __release_on_cleanup mashup or so.
> >
> > Working on rebasing this to v6.19-rc1 and saw this new scoped seqlock
> > abstraction. For that one I was able to make it work like I thought we
> > could (below). Some awkwardness is required to make it work in
> > for-loops, which only let you define variables with the same type.
> >
> > For <linux/cleanup.h> it needs some more thought due to extra levels of
> > indirection.
> 
> For cleanup.h, the problem is that to instantiate we use
> "guard(class)(args..)". If it had been designed as "guard(class,
> args...)", i.e. just use __VA_ARGS__ explicitly instead of the
> implicit 'args...', it might have been possible to add a second
> cleanup variable to do the same (with some additional magic to extract
> the first arg if one exists). Unfortunately, the use of the current
> guard()() idiom has become so pervasive that this is a bigger
> refactor. I'm going to leave cleanup.h as-is for now, if we think we
> want to give this a go in the current state.

Alright, this can work, but it's not that ergonomic as I'd hoped (see
below): we can redefine class_<name>_constructor to append another
cleanup variable. With enough documentation, this might be workable.

WDYT?

------ >8 ------


diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2f998bb42c4c..b47a1ba57e8e 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -518,7 +518,10 @@ static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
 
 #define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
 static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
-static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+static __always_inline void __class_##_name##_cleanup_ctx(class_##_name##_t **_T) \
+	__no_context_analysis _unlock {}
+#define WITH_LOCK_GUARD_1_ATTRS(_name, _T) class_##_name##_constructor(_T), \
+	*__UNIQUE_ID(cleanup_ctx) __cleanup(__class_##_name##_cleanup_ctx) = (void *)(_T)
 
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
 __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 8ed48d40007b..06c3f947ea49 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -255,9 +255,12 @@ DEFINE_LOCK_GUARD_1(mutex, struct mutex, mutex_lock(_T->lock), mutex_unlock(_T->
 DEFINE_LOCK_GUARD_1_COND(mutex, _try, mutex_trylock(_T->lock))
 DEFINE_LOCK_GUARD_1_COND(mutex, _intr, mutex_lock_interruptible(_T->lock), _RET == 0)
 
-DECLARE_LOCK_GUARD_1_ATTRS(mutex, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_try, __assumes_ctx_lock(_T), /* */)
-DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr, __assumes_ctx_lock(_T), /* */)
+DECLARE_LOCK_GUARD_1_ATTRS(mutex,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_try,	__acquires(_T), __releases(*(struct mutex **)_T))
+DECLARE_LOCK_GUARD_1_ATTRS(mutex_intr,	__acquires(_T), __releases(*(struct mutex **)_T))
+#define class_mutex_constructor(_T)	WITH_LOCK_GUARD_1_ATTRS(mutex, _T)
+#define class_mutex_try_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_try, _T)
+#define class_mutex_intr_constructor(_T) WITH_LOCK_GUARD_1_ATTRS(mutex_intr, _T)
 
 extern unsigned long mutex_get_owner(struct mutex *lock);
 

