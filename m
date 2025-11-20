Return-Path: <linux-wireless+bounces-29178-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 79145C74C2A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 2BA792B3EA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:12:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB48358D1D;
	Thu, 20 Nov 2025 15:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ir7czem0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DE4357A46
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651505; cv=none; b=Y0RfEjwiseoNPox8YH7+NlAzddxcCScmppxQzXbV7qC4aaa4avY+HHugoSx7k6zt2Icv0wpjpxEoc2rXXLRaYMN1iADZONXOBJ/NeSjptcwKQZlrOxgEICt2iy3/9THCSLV3CHoMYfd0diFs22XheZdQKoBKgEmMiL0RPFjY5nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651505; c=relaxed/simple;
	bh=kPQ7Y4ibZ70noLRvRuj0t3W6aiDQGYUeUC0Oe4+OJBw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LFWZBtf2XAGAj96/2O6hg8UTms+r2v5JD60ka8ski+PfvrpJZFFhv/uVTCbN9EpBnv4e4P9Nb2Nn14ePEPQXSDeigYJY1sthiA6X3tjAoYW/lDitqHhrcv/mtL/GT6je+65dj6pn2bmfF74kX8Hi4bu/O9clEgYXsoWPV9AGR7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ir7czem0; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b735400de44so94491966b.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:11:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651496; x=1764256296; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aQzgcISd2vbQZXtJWGq+JJNhDcvZ3ay3Xv8naW52gEo=;
        b=ir7czem0K3vlPcb4xvsiwV2+DrZ9W/oijEcCVhwVZY2g6uKhHBtoUZtDAvkGL1mkCz
         sAn16GeHjDtMdAl4ArEvjSqCqoyuh0I1Fs1wf+7x0cKZF0fveIRG2jRH3MQuJkDuglmw
         iS4h7NlmtMUjgnJXL2XCo7VZAkqskg2mK55bmQyGePw4xrRMHnJaWT5/daxZer5jY2ej
         TurRxdNu/CTWVwWcqShJsgFwFjTezTkqV3pM/YvpCkA6vGg0WsArTCzCTibM/1q+WNSC
         oOJKLk54aWGK67kzteOqdvjCROIvG9ain5nRUN9HCABrAX0wTK3AvIAF2RHBoAZAzwDD
         dyRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651496; x=1764256296;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQzgcISd2vbQZXtJWGq+JJNhDcvZ3ay3Xv8naW52gEo=;
        b=RpYDBCmxKHdFPPVAePR+pWu4GlwxNymCYks81PVAKFJsB/Z6Y5cHcFsT3uanwqVCWM
         VVYpxqiWcDlw4lFzT1l20RPiGY6uKCihCqxEyQIbsZkaSJb1MVZLzpZBzkghSCKGj4SX
         gUojl83KMRP1Mfg38eSxUE4GPZhK1I/vJTUrjG9IBY/h+Z391EeoCnPV1aizp8QeI24z
         ishnZHi9POfix3e0cMZ57ZKJE7XioSJzpap7Il1BabGhxMVZTxbQrOmtlObKbJrvMoDq
         TKPM0KVsFXQcJqZ05KXMsJtSjvGC2V4iPQP2jxjoenW1jd2uyFS4RkEEIzkLpd642bXu
         N0kA==
X-Forwarded-Encrypted: i=1; AJvYcCWK5iGouhATiJtZfVy/sb8bAFjs6Zi6FKR/z7iT2dyxDxby0WHbOTJ1LmnTsLtd/b//ArlPD4g8V3D008fNjw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxypBbLOLgvMVRBRqjZSlYJUrrlF2llnRjC5Mo+HMSDp4G2mjdX
	zG1s8zIYIt8TUHILjnGgJnGwYFnffpe+oAHSRL2tc0aVZ9KiursSee/NJhADibnZLRtJ8dwSOGR
	Xrw==
X-Google-Smtp-Source: AGHT+IHtFDUbBCcz68B5yl4+E7U+1inKytiJmjNdpXX9LnNqAnRdSUSbK1o8WJIs9ZzP1T0fmeAlZls5iQ==
X-Received: from ejbrp28.prod.google.com ([2002:a17:906:d97c:b0:b72:41e4:7558])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a17:907:9812:b0:b6d:5b4d:7277
 with SMTP id a640c23a62f3a-b76550b65a3mr361991766b.0.1763651495821; Thu, 20
 Nov 2025 07:11:35 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:31 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-7-elver@google.com>
Subject: [PATCH v4 06/35] cleanup: Basic compatibility with context analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, 
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
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>, Thomas Gleixner <tglx@linutronix.de>, 
	Thomas Graf <tgraf@suug.ch>, Uladzislau Rezki <urezki@gmail.com>, Waiman Long <longman@redhat.com>, 
	kasan-dev@googlegroups.com, linux-crypto@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	linux-security-module@vger.kernel.org, linux-sparse@vger.kernel.org, 
	linux-wireless@vger.kernel.org, llvm@lists.linux.dev, rcu@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Introduce basic compatibility with cleanup.h infrastructure: introduce
DECLARE_LOCK_GUARD_*_ATTRS() helpers to add attributes to constructors
and destructors respectively.

Note: Due to the scoped cleanup helpers used for lock guards wrapping
acquire and release around their own constructors/destructors that store
pointers to the passed locks in a separate struct, we currently cannot
accurately annotate *destructors* which lock was released. While it's
possible to annotate the constructor to say which lock was acquired,
that alone would result in false positives claiming the lock was not
released on function return.

Instead, to avoid false positives, we can claim that the constructor
"assumes" that the taken lock is held via __assumes_ctx_guard().

This will ensure we can still benefit from the analysis where scoped
guards are used to protect access to guarded variables, while avoiding
false positives. The only downside are false negatives where we might
accidentally lock the same lock again:

	raw_spin_lock(&my_lock);
	...
	guard(raw_spinlock)(&my_lock);  // no warning

Arguably, lockdep will immediately catch issues like this.

While Clang's analysis supports scoped guards in C++ [1], there's no way
to apply this to C right now. Better support for Linux's scoped guard
design could be added in future if deemed critical.

[1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html#scoped-context

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v3:
* Add *_ATTRS helpers instead of implicit __assumes_cap (suggested by Peter)
* __assert -> __assume rename
---
 include/linux/cleanup.h | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index 2573585b7f06..4f5e9ea02f54 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -274,16 +274,21 @@ const volatile void * __must_check_fn(const volatile void *val)
 
 #define DEFINE_CLASS(_name, _type, _exit, _init, _init_args...)		\
 typedef _type class_##_name##_t;					\
+typedef _type lock_##_name##_t;						\
 static inline void class_##_name##_destructor(_type *p)			\
+	__no_context_analysis						\
 { _type _T = *p; _exit; }						\
 static inline _type class_##_name##_constructor(_init_args)		\
+	__no_context_analysis						\
 { _type t = _init; return t; }
 
 #define EXTEND_CLASS(_name, ext, _init, _init_args...)			\
+typedef lock_##_name##_t lock_##_name##ext##_t;			\
 typedef class_##_name##_t class_##_name##ext##_t;			\
 static inline void class_##_name##ext##_destructor(class_##_name##_t *p)\
 { class_##_name##_destructor(p); }					\
 static inline class_##_name##_t class_##_name##ext##_constructor(_init_args) \
+	__no_context_analysis \
 { class_##_name##_t t = _init; return t; }
 
 #define CLASS(_name, var)						\
@@ -461,12 +466,14 @@ _label:									\
  */
 
 #define __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, ...)		\
+typedef _type lock_##_name##_t;						\
 typedef struct {							\
 	_type *lock;							\
 	__VA_ARGS__;							\
 } class_##_name##_t;							\
 									\
 static inline void class_##_name##_destructor(class_##_name##_t *_T)	\
+	__no_context_analysis						\
 {									\
 	if (!__GUARD_IS_ERR(_T->lock)) { _unlock; }			\
 }									\
@@ -475,6 +482,7 @@ __DEFINE_GUARD_LOCK_PTR(_name, &_T->lock)
 
 #define __DEFINE_LOCK_GUARD_1(_name, _type, _lock)			\
 static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
+	__no_context_analysis 						\
 {									\
 	class_##_name##_t _t = { .lock = l }, *_T = &_t;		\
 	_lock;								\
@@ -483,6 +491,7 @@ static inline class_##_name##_t class_##_name##_constructor(_type *l)	\
 
 #define __DEFINE_LOCK_GUARD_0(_name, _lock)				\
 static inline class_##_name##_t class_##_name##_constructor(void)	\
+	__no_context_analysis						\
 {									\
 	class_##_name##_t _t = { .lock = (void*)1 },			\
 			 *_T __maybe_unused = &_t;			\
@@ -490,6 +499,14 @@ static inline class_##_name##_t class_##_name##_constructor(void)	\
 	return _t;							\
 }
 
+#define DECLARE_LOCK_GUARD_0_ATTRS(_name, _lock, _unlock)		\
+static inline class_##_name##_t class_##_name##_constructor(void) _lock;\
+static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+
+#define DECLARE_LOCK_GUARD_1_ATTRS(_name, _lock, _unlock)		\
+static inline class_##_name##_t class_##_name##_constructor(lock_##_name##_t *_T) _lock;\
+static inline void class_##_name##_destructor(class_##_name##_t *_T) _unlock;
+
 #define DEFINE_LOCK_GUARD_1(_name, _type, _lock, _unlock, ...)		\
 __DEFINE_CLASS_IS_CONDITIONAL(_name, false);				\
 __DEFINE_UNLOCK_GUARD(_name, _type, _unlock, __VA_ARGS__)		\
-- 
2.52.0.rc1.455.g30608eb744-goog


