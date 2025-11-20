Return-Path: <linux-wireless+bounces-29176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 527A4C74CB7
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:14:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EA5EA4EE0E4
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2B034C98C;
	Thu, 20 Nov 2025 15:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NKoFanqO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4EE2F2612
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650990; cv=none; b=LpQZUNpyhjuqbpZIaeIvX6kM81cNvCpST2ihM9hmaw7kAxSl3VK83qZ6UdPtXdlklCTWOtAhaX8av7/rZdjGi0wReuNfJwbrgPjVH9VYOD43VCrBbIhX7tklpGTCHZ626nkM0wbSEdIVN95KdbLhNUm9i9usP7QUpTn6HRRYQ4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650990; c=relaxed/simple;
	bh=RlAtbvGe2o7GLZNK2osXwConM8SMxqUIfv+xbK8o9+E=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oeyvZRIj8ZgiMs6BMG9iuN+PHsczDfbaV4KWRS2+Pk5jevy/X3GYP18rHjKBp6zaItbiAiRnAhNOXGPXq6tN9fZ1XK597IGDXiLutYj4B8eK/3mTnN731rslJweYmL65eBc167RqkX5ixkhp4b58PJbN92JQr+Co2VI0A2gvGWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NKoFanqO; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-477563e531cso9731015e9.1
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:02:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650976; x=1764255776; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zAJGdoX03+Z7kHA10F2BJAYl/c1vU7j8o14tItuzLUc=;
        b=NKoFanqOwY+7a1Jy9XT0NiAK9uAdjfQJDPWB9hbwPdUfpRaIUDMLZieCSeCVa1JYTZ
         iRFtTmAtBInDAorPpMhuwlVDfcDA5b25xX5sqgTAAlpi9LXzqm4FVwL3O9eDXXJkt5N4
         +dcr5mNqHyQMsoR4n1Kfwh3Q7U/T5RCoxqv+p54eGNnf5XbDEdyooHIG79B213ENpqfa
         kOgzE/cMiLcB5lImpbfsORpfIuialdtTIg5O0pPCxATCMiUl4sMKt2X4Ep7Cj0yB0o2v
         QLU9pdkoNsr2dPXZ6TL8JDnN55yQQIIwT7LsMrCqspkqKEMNYYhOj2Mxo4T+cuzeDveI
         IgZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650976; x=1764255776;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zAJGdoX03+Z7kHA10F2BJAYl/c1vU7j8o14tItuzLUc=;
        b=fgGzkCltLtMhogdzxsC1jFZ9HZaKLXvmffj3rRmDemm57VWjFVuqkWRWw35lB8vpWW
         SpescZNq+jNATHXp3U0NcG+2A0Bw4/zdk6gOGoJv1ScFxT2DFZxy68MZuOioF0Jv1T++
         dkCZHDz2Il3u9+nrUifMKcqtZwD/B5S3D3q07zJh1tqnb//3GEkI+6x/gMPigQnIqrQU
         16bkMPOsDnWxjY1dcc+TK2KSS/y6krScWRSvZZD1CAcF82Brjj+z4c5Gtg65OY3282BR
         wkik1xVNjQoHA0LCY/i7/vGuzJGg2MRRkYJ6vOycs8rh/7EfhW9D6QZtcxSkLIrKrjRz
         4RFg==
X-Forwarded-Encrypted: i=1; AJvYcCUXUAmzMkLDEU6IM6+MB+hOrXJUyWH35ri9Bn+bk5nJseVroke4n9EFFhqZGC+STN52oL30rvd/yCpYeC0RIA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyOkmKXncbSE1xEc+QPgjrNROx+DOBqxfW6lbXjwmZhwWBBDrNN
	evwrX/FNNEBVbizP1klNGv45kx8D61rA3f7bFrVK0VlGRF1qPMfajkLqvjDDnqcWa0y+veVeHtu
	96Q==
X-Google-Smtp-Source: AGHT+IFIYsn75+II8LsVddaa6qNKEfaR+cAEgpbzcwe6Py2Tl/ywj/JLpQudo1QVKMjc586QGSbi0kmLJg==
X-Received: from wmot8.prod.google.com ([2002:a05:600c:4508:b0:477:a4d4:607a])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:1d05:b0:477:54cd:200a
 with SMTP id 5b1f17b1804b1-477b8a518f4mr26264575e9.6.1763650976118; Thu, 20
 Nov 2025 07:02:56 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:06 +0100
In-Reply-To: <20251120145835.3833031-2-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-6-elver@google.com>
Subject: [PATCH v4 04/35] Documentation: Add documentation for Compiler-Based
 Context Analysis
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

Adds documentation in Documentation/dev-tools/context-analysis.rst, and
adds it to the index.

Signed-off-by: Marco Elver <elver@google.com>
---
v4:
* Rename capability -> context analysis.

v2:
* Remove cross-reference to Sparse, since we plan to remove Sparse
  support anyway.
* Mention __no_context_analysis should be avoided.
---
 Documentation/dev-tools/context-analysis.rst | 145 +++++++++++++++++++
 Documentation/dev-tools/index.rst            |   1 +
 2 files changed, 146 insertions(+)
 create mode 100644 Documentation/dev-tools/context-analysis.rst

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
new file mode 100644
index 000000000000..a15436e288fd
--- /dev/null
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -0,0 +1,145 @@
+.. SPDX-License-Identifier: GPL-2.0
+.. Copyright (C) 2025, Google LLC.
+
+.. _context-analysis:
+
+Compiler-Based Context Analysis
+===============================
+
+Context Analysis is a language extension, which enables statically checking
+that required contexts are active (or inactive) by acquiring and releasing
+user-definable "context guards". An obvious application is lock-safety checking
+for the kernel's various synchronization primitives (each of which represents a
+"context guard"), and checking that locking rules are not violated.
+
+The Clang compiler currently supports the full set of context analysis
+features. To enable for Clang, configure the kernel with::
+
+    CONFIG_WARN_CONTEXT_ANALYSIS=y
+
+The feature requires Clang 22 or later.
+
+The analysis is *opt-in by default*, and requires declaring which modules and
+subsystems should be analyzed in the respective `Makefile`::
+
+    CONTEXT_ANALYSIS_mymodule.o := y
+
+Or for all translation units in the directory::
+
+    CONTEXT_ANALYSIS := y
+
+It is possible to enable the analysis tree-wide, however, which will result in
+numerous false positive warnings currently and is *not* generally recommended::
+
+    CONFIG_WARN_CONTEXT_ANALYSIS_ALL=y
+
+Programming Model
+-----------------
+
+The below describes the programming model around using context guard types.
+
+.. note::
+   Enabling context analysis can be seen as enabling a dialect of Linux C with
+   a Context System. Some valid patterns involving complex control-flow are
+   constrained (such as conditional acquisition and later conditional release
+   in the same function).
+
+Context analysis is a way to specify permissibility of operations to depend on
+context guards being held (or not held). Typically we are interested in
+protecting data and code in a critical section by requiring a specific context
+to be active, for example by holding a specific lock. The analysis ensures that
+callers cannot perform an operation without the required context being active.
+
+Context guards are associated with named structs, along with functions that
+operate on struct instances to acquire and release the associated context
+guard.
+
+Context guards can be held either exclusively or shared. This mechanism allows
+assigning more precise privileges when a context is active, typically to
+distinguish where a thread may only read (shared) or also write (exclusive) to
+data guarded within a context.
+
+The set of contexts that are actually active in a given thread at a given point
+in program execution is a run-time concept. The static analysis works by
+calculating an approximation of that set, called the context environment. The
+context environment is calculated for every program point, and describes the
+set of contexts that are statically known to be active, or inactive, at that
+particular point. This environment is a conservative approximation of the full
+set of contexts that will actually be active in a thread at run-time.
+
+More details are also documented `here
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_.
+
+.. note::
+   Clang's analysis explicitly does not infer context guards acquired or
+   released by inline functions. It requires explicit annotations to (a) assert
+   that it's not a bug if a context guard is released or acquired, and (b) to
+   retain consistency between inline and non-inline function declarations.
+
+Supported Kernel Primitives
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. Currently the following synchronization primitives are supported:
+
+For context guards with an initialization function (e.g., `spin_lock_init()`),
+calling this function before initializing any guarded members or globals
+prevents the compiler from issuing warnings about unguarded initialization.
+
+Lockdep assertions, such as `lockdep_assert_held()`, inform the compiler's
+context analysis that the associated synchronization primitive is held after
+the assertion. This avoids false positives in complex control-flow scenarios
+and encourages the use of Lockdep where static analysis is limited. For
+example, this is useful when a function doesn't *always* require a lock, making
+`__must_hold()` inappropriate.
+
+Keywords
+~~~~~~~~
+
+.. kernel-doc:: include/linux/compiler-context-analysis.h
+   :identifiers: context_guard_struct
+                 token_context_guard token_context_guard_instance
+                 __guarded_by __pt_guarded_by
+                 __must_hold
+                 __must_not_hold
+                 __acquires
+                 __cond_acquires
+                 __releases
+                 __must_hold_shared
+                 __acquires_shared
+                 __cond_acquires_shared
+                 __releases_shared
+                 __acquire
+                 __release
+                 __cond_lock
+                 __acquire_shared
+                 __release_shared
+                 __cond_lock_shared
+                 __acquire_ret
+                 __acquire_shared_ret
+                 context_unsafe
+                 __context_unsafe
+                 disable_context_analysis enable_context_analysis
+
+.. note::
+   The function attribute `__no_context_analysis` is reserved for internal
+   implementation of context guard types, and should be avoided in normal code.
+
+Background
+----------
+
+Clang originally called the feature `Thread Safety Analysis
+<https://clang.llvm.org/docs/ThreadSafetyAnalysis.html>`_, with some keywords
+and documentation still using the thread-safety-analysis-only terminology. This
+was later changed and the feature became more flexible, gaining the ability to
+define custom "capabilities". Its foundations can be found in `Capability
+Systems <https://www.cs.cornell.edu/talc/papers/capabilities.pdf>`_, used to
+specify the permissibility of operations to depend on some "capability" being
+held (or not held).
+
+Because the feature is not just able to express capabilities related to
+synchronization primitives, and "capability" is already overloaded in the
+kernel, the naming chosen for the kernel departs from Clang's initial "Thread
+Safety" and "capability" nomenclature; we refer to the feature as "Context
+Analysis" to avoid confusion. The internal implementation still makes
+references to Clang's terminology in a few places, such as `-Wthread-safety`
+being the warning option that also still appears in diagnostic messages.
diff --git a/Documentation/dev-tools/index.rst b/Documentation/dev-tools/index.rst
index 4b8425e348ab..d864b3da4cc7 100644
--- a/Documentation/dev-tools/index.rst
+++ b/Documentation/dev-tools/index.rst
@@ -21,6 +21,7 @@ Documentation/process/debugging/index.rst
    checkpatch
    clang-format
    coccinelle
+   context-analysis
    sparse
    kcov
    gcov
-- 
2.52.0.rc1.455.g30608eb744-goog


