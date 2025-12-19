Return-Path: <linux-wireless+bounces-29934-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AC01DCD0A2B
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 16:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E85D4306A07C
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Dec 2025 15:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1503325A659;
	Fri, 19 Dec 2025 15:45:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="urs97b6w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99C4633B972
	for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 15:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766159141; cv=none; b=H4L4BwXTVzsvbWVYCvyisNv+9UFEZEtiVDH6y1wqHTaNDiVKRCllzC/qywWsoVWri+q56zfS/q/jqKW1bQI+ARgyfwi1V2swthfWdR3LfhkyLFpO9XOqrDgwAVQ0cWpdn0hDvtmu3OgVY6fbdfgkFWq1+1BZ+iLTcGLKqZxOtIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766159141; c=relaxed/simple;
	bh=D876gfERGm4Uh8Tof9yRwAWiXRfLZlCBiCrqdIxRAxc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LNsOFrqSDMD45ZNatVq7Xc5DwTefzXofJ+YynMj3W6GSThtKKeKPlAqA9xJObNJERWR5iFajv4eoNCOtj0ApHKHaCoYSPI39VFlZfuFHMQ01/H9Uo6/Z+bc94gR+uwiWJGYGM4rMKgbAjiKZaSr5lwltoZtmKIL7oDO1HzvOMoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=urs97b6w; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-4779da35d27so17886345e9.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Dec 2025 07:45:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1766159136; x=1766763936; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wNypD57EGX2MX8ivTIXP0XbqOR/mFQo2ssZAJ4O2zXU=;
        b=urs97b6wXGfVRyg2RQQJYV8Voj7uxokAqjV1bHnvEQg0POLBxgC9l+1uKc1e2ME6vx
         fxVp/ShBN4LK/XUQ8DNOaxLo7uWoa0ClaeA+MSlnIfcfoWbk3yq+xEWYww4m2GcEScMG
         yWwE3T8vCbGm5ygDIGTLkLNL7VJ2hf0/SPnQJ5v7PQseysF2kRAM/5jk1l6RtGtPiFsw
         CLvY4RnVvEJKXyJRuWuMsFkeOhYJFy/O89z/uuQctDfuSJiK8LyW5G1UK6zaBp9p0A9A
         /pJJrZWnKuHNnoYuv4HBSNhfwNgKO3I2gvq4OyQuLJiyOZKJrMQCmi3Icjx3ZqcqXnhN
         n/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766159136; x=1766763936;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wNypD57EGX2MX8ivTIXP0XbqOR/mFQo2ssZAJ4O2zXU=;
        b=VG8Ax1CgArwaBBvrsmWGkRgbqBqlJeMArs1/8gKNWpKYmjwIlEZOnIbrUp06tHkEQl
         +3OIoCFepBB1m/yHb08WnF3YV813JzELGyXuRKnXn08a76xfN0yaGHugovsDX0aU4KmK
         4b4NWxBo/Gld0J3iaITWhpfGZaIBgeBTqmaODHlRv1jPmeVlmi6XUOxovhN2WNXvh2hp
         kZSjbOeQPLIc6iD35bdfYDVtqcEkOjvw5EuJXzrmGJ+7gok/DGf/+C/huPW0hf4n/dJV
         9Bu2fLwhG3t8idPK7tA8iAkjGPMlE/oSzFGD1WoVkNyG4K8ux+N73f+hEAmoPnuqePH+
         uvOQ==
X-Forwarded-Encrypted: i=1; AJvYcCUs6GqHv5TqhE7JaLr5sb3wgFxjSdWv9/pY/FKlwumMytjEGFzhlN/qbJREuk0iZGa939qlHTvriXY/iP0ROw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyD06m+Zj+p3stYWcQ37zTmLidCRDFOk+/lXXG0K6i61yYmmzOY
	KYlRO7oTTWJuzbPtVi1ash6Ua61JgoAaeuUY94nY00Is6EoEqiZEVnKFHptqBm+BoVji5FBwhap
	Ykg==
X-Google-Smtp-Source: AGHT+IHXXBJOd4wvSdy3ALXfB4Mt0dokW3EvzdUSRwHOp88UE22ws+JWjg7YwUgEMwqGcjEmAiNPIAdtCQ==
X-Received: from wmco28.prod.google.com ([2002:a05:600c:a31c:b0:477:9976:8214])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:828c:b0:479:3a87:2092
 with SMTP id 5b1f17b1804b1-47d19598e86mr23981475e9.36.1766159135626; Fri, 19
 Dec 2025 07:45:35 -0800 (PST)
Date: Fri, 19 Dec 2025 16:39:53 +0100
In-Reply-To: <20251219154418.3592607-1-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251219154418.3592607-1-elver@google.com>
X-Mailer: git-send-email 2.52.0.322.g1dd061c0dc-goog
Message-ID: <20251219154418.3592607-5-elver@google.com>
Subject: [PATCH v5 04/36] Documentation: Add documentation for Compiler-Based
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
v5:
* Rename "context guard" -> "context lock".

v4:
* Rename capability -> context analysis.

v2:
* Remove cross-reference to Sparse, since we plan to remove Sparse
  support anyway.
* Mention __no_context_analysis should be avoided.
---
 Documentation/dev-tools/context-analysis.rst | 144 +++++++++++++++++++
 Documentation/dev-tools/index.rst            |   1 +
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/dev-tools/context-analysis.rst

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
new file mode 100644
index 000000000000..47eb547eb716
--- /dev/null
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -0,0 +1,144 @@
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
+user-definable "context locks". An obvious application is lock-safety checking
+for the kernel's various synchronization primitives (each of which represents a
+"context lock"), and checking that locking rules are not violated.
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
+The below describes the programming model around using context lock types.
+
+.. note::
+   Enabling context analysis can be seen as enabling a dialect of Linux C with
+   a Context System. Some valid patterns involving complex control-flow are
+   constrained (such as conditional acquisition and later conditional release
+   in the same function).
+
+Context analysis is a way to specify permissibility of operations to depend on
+context locks being held (or not held). Typically we are interested in
+protecting data and code in a critical section by requiring a specific context
+to be active, for example by holding a specific lock. The analysis ensures that
+callers cannot perform an operation without the required context being active.
+
+Context locks are associated with named structs, along with functions that
+operate on struct instances to acquire and release the associated context lock.
+
+Context locks can be held either exclusively or shared. This mechanism allows
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
+   Clang's analysis explicitly does not infer context locks acquired or
+   released by inline functions. It requires explicit annotations to (a) assert
+   that it's not a bug if a context lock is released or acquired, and (b) to
+   retain consistency between inline and non-inline function declarations.
+
+Supported Kernel Primitives
+~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+.. Currently the following synchronization primitives are supported:
+
+For context locks with an initialization function (e.g., `spin_lock_init()`),
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
+   :identifiers: context_lock_struct
+                 token_context_lock token_context_lock_instance
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
+   implementation of context lock types, and should be avoided in normal code.
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
2.52.0.322.g1dd061c0dc-goog


