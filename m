Return-Path: <linux-wireless+bounces-29173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D782C74C8A
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F3BAB4ECFA6
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84ED22F7AB5;
	Thu, 20 Nov 2025 15:02:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2l8HqkQ7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972522F8BD2
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650974; cv=none; b=ny2D7jjAW0Q5XbrXPDQWrVMbzBdhm/L1JL39zpgrMz0bgc9o/P0K7KzUN5vmXufqf082siA9gDMNpaCFsvmUXyNyiOCZjiwIu3uqQyERS4QHF3kvYwBVpSib6jARsO0k9GRVR4sCtaw6qrbZqRvLTBcGoXVmmvW5jQpiJ1ilAl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650974; c=relaxed/simple;
	bh=g/pcRuqNqSJ9il1AN9uXiWPsEHGF2sqboQr2ZT1RndI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BCgNkfOGWpFE55yUeIg/C3fNdFlr9io2UG5ZkrhvtaoQzTFP9cs2G+7eFh5/GUtnh4MNaN7FEVOD6UUJwE2KmYFhgJBnjGyPvhJOuxPIqOuSFMY7XTJsXWLCX/GgZ8k/xdcD2kGPwHtnRUbVZ9jOgAaA440EMBlYNt7dra/xx0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2l8HqkQ7; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477212937eeso6019325e9.2
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650968; x=1764255768; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+xm08Oqaiz0C+41w88sCv4Knf0HeT4Y61beURoEgshc=;
        b=2l8HqkQ71zJDzTmEBSxYyjhjsek9KqM6EKRmA2DqPBhmWVaXIxDjonC+1GAO16KA5k
         McapSz6xQJu3X5ntV04jI/XKwWWs80RL7lFA/Wb1Xv5ngMBhkj0fWD6ki/kXIRPNGkZe
         JVkYaLz8SdZdFSBc1i/Oz2yFD1QMvrDLeePKo8LOz/Roqaniow0W3GSknfjBbgVB79H/
         zsYrLGjjuUfiPlpjXkpj3LiH9ORmrj6lt9X94Kyx0xZLs68QrACXUjIJ8v1Y0kdnAy6d
         REcqDh0qHyqYnSViaf2iQA0SgneatjkicvSEi2q2w0BfH/93+1YSu0PMgQbHMLy4Ycjl
         ArwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650968; x=1764255768;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+xm08Oqaiz0C+41w88sCv4Knf0HeT4Y61beURoEgshc=;
        b=MNcWZW0aTMQeZ4BVsJnD9fF7oRSDvS+q0uVvQCraL+sBcuZRiRI5rEVSNTSeJmQ93s
         B4OucDwhxq6EllAzGKfK1dEIQmoTpgIUYuKC34E3Sitow7QMDmrc5bRT/FiNJThrpolw
         w1d2Z5HR+rV5fuqc2T8DMm6kTlvxZ/to4fO0lkP2p3IHhmodQwdl2dpQSd/14hoGnavh
         PwRgLKHwsqixwfj2IxGgEqCOhir2/1bHwkFclE99BV6jWF69YzZYqGQIcvSfUP/8FEFr
         CzFRENAXYaK+eHHDp/3ms2NjmvOyVdnH8ewIl391NUiRxe215xU1MJzpaFI+j1SBW3z2
         vK2A==
X-Forwarded-Encrypted: i=1; AJvYcCVPn0r4QvwQyW8j6G2AcyaiuLn8MJH1Rx9I962bsCOuIynBIOH1a21ADOJt6q/cOg+Ye3zemdcNmvCVaNBjsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyKCBdnwnCybo1SmNf7J9ItQinggQ5z5TVYU/tsQZpSuO6M01So
	Fliw8K5k+OTWTStgvObVtJx1oadP1thqMblCNOihdWGfSSBBQidn+9NoY5uKNGG0QIRjGcY4/IY
	yOw==
X-Google-Smtp-Source: AGHT+IGUHW8T7PbhGDmbj5YjoSY8aOAhL/hfcFkM7c1fjnxT41/dPSOy7IIJVzHNh1nc5oCgWusA4fLoNQ==
X-Received: from wmbd17.prod.google.com ([2002:a05:600c:58d1:b0:477:76e1:9b4e])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:470a:b0:477:1bb6:17e5
 with SMTP id 5b1f17b1804b1-477b8d8b887mr39140845e9.30.1763650967589; Thu, 20
 Nov 2025 07:02:47 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:03 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-3-elver@google.com>
Subject: [PATCH v4 01/35] compiler_types: Move lock checking attributes to compiler-context-analysis.h
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

The conditional definition of lock checking macros and attributes is
about to become more complex. Factor them out into their own header for
better readability, and to make it obvious which features are supported
by which mode (currently only Sparse). This is the first step towards
generalizing towards "context analysis".

No functional change intended.

Signed-off-by: Marco Elver <elver@google.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
---
v4:
* Rename capability -> context analysis.
---
 include/linux/compiler-context-analysis.h | 32 +++++++++++++++++++++++
 include/linux/compiler_types.h            | 18 ++-----------
 2 files changed, 34 insertions(+), 16 deletions(-)
 create mode 100644 include/linux/compiler-context-analysis.h

diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
new file mode 100644
index 000000000000..f8af63045281
--- /dev/null
+++ b/include/linux/compiler-context-analysis.h
@@ -0,0 +1,32 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static context analysis.
+ */
+
+#ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+#define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
+
+#ifdef __CHECKER__
+
+/* Sparse context/lock checking support. */
+# define __must_hold(x)		__attribute__((context(x,1,1)))
+# define __acquires(x)		__attribute__((context(x,0,1)))
+# define __cond_acquires(x)	__attribute__((context(x,0,-1)))
+# define __releases(x)		__attribute__((context(x,1,0)))
+# define __acquire(x)		__context__(x,1)
+# define __release(x)		__context__(x,-1)
+# define __cond_lock(x, c)	((c) ? ({ __acquire(x); 1; }) : 0)
+
+#else /* !__CHECKER__ */
+
+# define __must_hold(x)
+# define __acquires(x)
+# define __cond_acquires(x)
+# define __releases(x)
+# define __acquire(x)		(void)0
+# define __release(x)		(void)0
+# define __cond_lock(x, c)	(c)
+
+#endif /* __CHECKER__ */
+
+#endif /* _LINUX_COMPILER_CONTEXT_ANALYSIS_H */
diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index 0a1b9598940d..7eb8d8db6c28 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -24,6 +24,8 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <linux/compiler-context-analysis.h>
+
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */
 #ifdef __CHECKER__
 /* address spaces */
@@ -34,14 +36,6 @@
 # define __rcu		__attribute__((noderef, address_space(__rcu)))
 static inline void __chk_user_ptr(const volatile void __user *ptr) { }
 static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
-/* context/locking */
-# define __must_hold(x)	__attribute__((context(x,1,1)))
-# define __acquires(x)	__attribute__((context(x,0,1)))
-# define __cond_acquires(x) __attribute__((context(x,0,-1)))
-# define __releases(x)	__attribute__((context(x,1,0)))
-# define __acquire(x)	__context__(x,1)
-# define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 /* other */
 # define __force	__attribute__((force))
 # define __nocast	__attribute__((nocast))
@@ -62,14 +56,6 @@ static inline void __chk_io_ptr(const volatile void __iomem *ptr) { }
 
 # define __chk_user_ptr(x)	(void)0
 # define __chk_io_ptr(x)	(void)0
-/* context/locking */
-# define __must_hold(x)
-# define __acquires(x)
-# define __cond_acquires(x)
-# define __releases(x)
-# define __acquire(x)	(void)0
-# define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 /* other */
 # define __force
 # define __nocast
-- 
2.52.0.rc1.455.g30608eb744-goog


