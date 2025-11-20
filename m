Return-Path: <linux-wireless+bounces-29214-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 450C8C76AB5
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Nov 2025 00:52:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 3C0252BF78
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 23:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10F37310774;
	Thu, 20 Nov 2025 23:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kWfxfh77"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA7A330F550
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 23:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763682722; cv=none; b=NG1yG+kDvQREYiId089lnd5u31IK9LF21nxomhShIcftOh3I3B9fJ4kzRi37Trr6VkKe3lObFYbDNci415GjYnOJNxS8AOq13/uFMtJDQEJ6HebgaHLezd2kFJaLMXs9UklxIQDSZYJolsQBuXPKcYchuDYeUhHStIKYf8OGFhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763682722; c=relaxed/simple;
	bh=j63KK1bea0KAW/i3SO0yLLlf6m4fWGvrLEtlDWsN5z8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TU64YhDiC92RfZ8J9WeEXpq2ATyubfXHbSVIS5F46yA1p5O66xMf8BPDWfOsyrB0DgVlwUPZQMUpEFKGFpCXXbbnV8ZJ0F4WFVvTGow5ZNVHMody5hCLx3dm1sUmCHSv12fYzzqubKXdRAbk/J5ij3Suou5FYioTgAdjGX/4vBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=kWfxfh77; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4779cb0a33fso14120735e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763682718; x=1764287518; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J9kvXa3Vdh1ip8zUpCqHWE2klTiidAnZMSHg4scU75Q=;
        b=kWfxfh77za/rlmtEYAjNomT6qRdAjpZbl000AS9cTmlrGI4mDLKAtwdWobEjsEN2Xn
         +Mt4OAaziu43xifr672NgsRRFw224pX7GmD6N1b8/RHD5llDO2TKDnzlyov2+U/HRZ7B
         bq9FnznSAIrmHMNxdEPkCMZVG7LoABNelI089mktQxWKdTgYD2A6z18ZJ3DOAsi8XUX9
         MMVll0dYf/EVLJeAMd3iA/mm+bYc2ZbCoWS9HW4H8K5eliARalMua9z0NMufLBF/dCRB
         TP0L/zHDZXnqFM+dX3VBljSn6mzFu1BUiS4zjZsa6m+1h9ZB5ScZr54RXVssoEdXg1iT
         5Tew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763682718; x=1764287518;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=J9kvXa3Vdh1ip8zUpCqHWE2klTiidAnZMSHg4scU75Q=;
        b=CPMDNOHXRwIgSycVMNAchvMzYujRjSzi2/tl3+tW2rsjIEbEGsn94pKm7ewQKRfT8k
         SGlkFPYzhh1MfNCefjbfzb393RzjFdn/hkTLUixiI2Ky1McgzBdE5XP1RHkLrGqOMqiX
         Q/COkW9NiLVUhUSkcoM0HP3k15vgodX1NTlHiL7uBOIWFpbhxA9/O+t1+ovXXrXcnkgI
         1Q2/JZR2g47ERXMpx+SebvvLwJMA+BqCg4u1aZStNNvZLNG7zA1W7X+PEXU2xkvFYf2t
         wA6x226TwB/TbfKi7H/J0tFvCtWLEnoKJACS4A+TESodmlYaAD1O/WE0hKLosqpTfh/p
         Vx4g==
X-Forwarded-Encrypted: i=1; AJvYcCXcPcv+g1s4Ny2YbhWRL+YrhoaplH+MsRE8f33hbRTWrVEmjLsIdfdH+7HCAYXSMtNwMwyG+6eb0y+qPBjoEA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7BUmuc+loeQQqI2R3dasZrr3zojh4tvoS3jKrF/UdVot71P93
	mT5MNT7sd5pEBSWOwaZWX/ukCCOE3aqgwxtSh1yg6aOsKLWP3JA5SDI2QZU42zNGbA==
X-Gm-Gg: ASbGnctSUPX70ka0/9XHgUSN9xuFNGkKtdz5PvIoi9MIC+qvrh5xcDdcYK0ua8/KRwD
	V5Ef3HK3hSUbHvKoluDyLPiyrPk6Y+A8V1hreEA6dniM9FssEpOXmvUl3fLvXMRjmJoGRs9PG6r
	aPZ9bLUDMVdrJCC0tiLJr+gzvQJtJYJwv9fG4rBCb+E2b+hgyyXEtqZGIU8zLiVT+Bplgp4Dr0v
	FiSxVriPrIPT6AJUx9uPvrf/+dWhYNBxqsqoIQDzqQnHmUqzB/xkcwl2t3/sAY2l/At3yUErjbZ
	IegxY3dcwLBZUyw+J4RyrYc4PucDLuaJjQFGc9Lu7ZmoiK/gQumKeXJvNiCwhpEPAAKFX5vUpJc
	BCunFhMlNL51CkpsFAn8E4YPuc78Ngi7+EsIrtEOfDhlTQpkSuY8mi2Db0Qobe0L6GMUvQ7bJW0
	Q1vSJGtTD+UzdI/o5FO6be0GIk/OIrBNb7anIPjhpivbpcNvLE990ipWG+T7o=
X-Google-Smtp-Source: AGHT+IHBj+lRJ2Qie5tQgt4+bdQcT9clHmhVuJ221UEaEkB+U77QKJJ8z44sTbdZcE/IcTJPd+pPPw==
X-Received: by 2002:a05:600c:1909:b0:477:b642:9dc6 with SMTP id 5b1f17b1804b1-477c020137fmr3256875e9.34.1763682717840;
        Thu, 20 Nov 2025 15:51:57 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:2834:9:3b7e:2c14:f733:1774])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a97213b8sm72914765e9.1.2025.11.20.15.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 15:51:56 -0800 (PST)
Date: Fri, 21 Nov 2025 00:51:48 +0100
From: Marco Elver <elver@google.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>,
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
Subject: Re: [PATCH v4 02/35] compiler-context-analysis: Add infrastructure
 for Context Analysis with Clang
Message-ID: <aR-plHrWDMqRRlcI@elver.google.com>
References: <20251120145835.3833031-2-elver@google.com>
 <20251120145835.3833031-4-elver@google.com>
 <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whyKteNtcLON-gScv6tu8ssvKWdNw-k371ufDrjOv374g@mail.gmail.com>
User-Agent: Mutt/2.2.13 (2024-03-09)

On Thu, Nov 20, 2025 at 10:14AM -0800, Linus Torvalds wrote:
> On Thu, 20 Nov 2025 at 07:13, Marco Elver <elver@google.com> wrote:
[..]
> > +#if defined(WARN_CONTEXT_ANALYSIS)
> 
> Note the 400+ added lines to this header...
> 
[..]
> Please let's *not* do it this way, where the header contents basically
> get enabled or not based on a compiler flag, but then everybody
> includes this 400+ line file whether they need it or not.

Note, there are a good amount of kernel-doc comments in there, so we
have 125 real code lines.

% cloc include/linux/compiler-context-analysis.h
       1 text file.
       1 unique file.
       0 files ignored.

github.com/AlDanial/cloc v 2.06  T=0.01 s (97.1 files/s, 41646.9 lines/s)
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C/C++ Header                     1             37            267            125
-------------------------------------------------------------------------------

> Can we please just make the header file *itself* not have any
> conditionals, and what happens is that the header file is included (or
> not) using a pattern something like
> 
>    -include $(srctree)/include/linux/$(context-analysis-header)
> 
> instead.
> 
> IOW, we'd have three different header files entirely: the "no context
> analysis", the "sparse" and the "clang context analysis" header, and
> instead of having a "-DWARN_CONTEXT_ANALYSIS" define, we'd just
> include the appropriate header automatically.
> 
> We already use that "-include" pattern for <linux/kconfig.h> and
> <linux/compiler-version.h>. It's probably what we should have done for
> <linux/compiler.h> and friends too.
> 
> The reason I react to things like this is that I've actually seen just
> the parsing of header files being a surprisingly big cost in build
> times. People think that optimizations are expensive, and yes, some of
> them really are, but when a lot of the code we parse is never actually
> *used*, but just hangs out in header files that gets included by
> everybody, the parsing overhead tends to be noticeable. There's a
> reason why most C compilers end up integrating the C pre-processor: it
> avoids parsing and tokenizing things multiple times.
> 
> The other reason is that I often use "git grep" for looking up
> definitions of things, and when there are multiple definitions of the
> same thing, I actually find it much more informative when they are in
> two different files than when I see two different definitions (or
> declarations) in the same file and then I have to go look at what the
> #ifdef condition is. In contrast, when it's something where there are
> per-architecture definitions, you *see* that, because the grep results
> come from different header files.
> 
> I dunno. This is not a huge deal, but I do think that it would seem to
> be much simpler and more straightforward to treat this as a kind of "N
> different baseline header files" than as "include this one header file
> in everything, and then we'll have #ifdef's for the configuration".
> 
> Particularly when that config is not even a global config, but a per-file one.
> 
> Hmm? Maybe there's some reason why this suggestion is very
> inconvenient, but please at least consider it.

Fair points; I gave this a shot, as a patch on top so we can skip the
Sparse version.

Reduced version below:
-------------------------------------------------------------------------------
Language                     files          blank        comment           code
-------------------------------------------------------------------------------
C/C++ Header                     1             26            189             80
-------------------------------------------------------------------------------

My suspicion (or I'm doing it wrong): there really isn't all that much
we can conditionally -include, because we need at least the no-op stubs
everywhere regardless because of annotations provided by common headers
(spinlock, mutex, rcu, etc. etc.).

If we assume that in the common case we need the no-op macros
everywhere, thus every line in <linux/compiler-context-analysis.h> is
required in the common case with the below version, the below experiment
should be be close to what we can achieve.

However, it might still be worthwhile for the code organization aspect?

Thoughts?

Thanks,
-- Marco

------ >8 ------

From: Marco Elver <elver@google.com>
Date: Thu, 20 Nov 2025 22:37:52 +0100
Subject: [PATCH] compiler-context-analysis: Move Clang definitions to separate
 header

In the interest of improving compile-times, it makes sense to move the
conditionally enabled definitions when the analysis is enabled to a
separate file and include it only with -include.

A very unscientific comparison, on a system with 72 CPUs; before:

  125.67 wallclock secs = ( 5681.04 usr secs + 367.63 sys secs / 4815.83% CPU )

After:

  125.61 wallclock secs = ( 5684.80 usr secs + 366.53 sys secs / 4817.95% CPU )

[ Work in progress - with this version, there is no measurable
  difference in compile times. ]

Signed-off-by: Marco Elver <elver@google.com>
---
 Documentation/dev-tools/context-analysis.rst  |  10 +-
 .../linux/compiler-context-analysis-clang.h   | 144 ++++++++++++++++++
 include/linux/compiler-context-analysis.h     | 136 +----------------
 scripts/Makefile.context-analysis             |   3 +-
 4 files changed, 153 insertions(+), 140 deletions(-)
 create mode 100644 include/linux/compiler-context-analysis-clang.h

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index e53f089d0c52..71b9c5e57eb4 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -99,10 +99,7 @@ Keywords
 ~~~~~~~~
 
 .. kernel-doc:: include/linux/compiler-context-analysis.h
-   :identifiers: context_guard_struct
-                 token_context_guard token_context_guard_instance
-                 __guarded_by __pt_guarded_by
-                 __must_hold
+   :identifiers: __must_hold
                  __must_not_hold
                  __acquires
                  __cond_acquires
@@ -119,6 +116,11 @@ Keywords
                  __acquire_shared_ret
                  context_unsafe
                  __context_unsafe
+
+.. kernel-doc:: include/linux/compiler-context-analysis-clang.h
+   :identifiers: __guarded_by __pt_guarded_by
+                 context_guard_struct
+                 token_context_guard token_context_guard_instance
                  disable_context_analysis enable_context_analysis
 
 .. note::
diff --git a/include/linux/compiler-context-analysis-clang.h b/include/linux/compiler-context-analysis-clang.h
new file mode 100644
index 000000000000..534a41a25596
--- /dev/null
+++ b/include/linux/compiler-context-analysis-clang.h
@@ -0,0 +1,144 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros and attributes for compiler-based static context analysis that map to
+ * Clang's "Thread Safety Analysis".
+ */
+
+#ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_CLANG_H
+#define _LINUX_COMPILER_CONTEXT_ANALYSIS_CLANG_H
+
+#ifndef WARN_CONTEXT_ANALYSIS
+#error "This header should not be included"
+#endif
+
+/*
+ * These attributes define new context guard (Clang: capability) types.
+ * Internal only.
+ */
+#define __ctx_guard_type(name)			__attribute__((capability(#name)))
+#define __reentrant_ctx_guard			__attribute__((reentrant_capability))
+#define __acquires_ctx_guard(...)		__attribute__((acquire_capability(__VA_ARGS__)))
+#define __acquires_shared_ctx_guard(...)	__attribute__((acquire_shared_capability(__VA_ARGS__)))
+#define __try_acquires_ctx_guard(ret, var)	__attribute__((try_acquire_capability(ret, var)))
+#define __try_acquires_shared_ctx_guard(ret, var) __attribute__((try_acquire_shared_capability(ret, var)))
+#define __releases_ctx_guard(...)		__attribute__((release_capability(__VA_ARGS__)))
+#define __releases_shared_ctx_guard(...)	__attribute__((release_shared_capability(__VA_ARGS__)))
+#define __assumes_ctx_guard(...)		__attribute__((assert_capability(__VA_ARGS__)))
+#define __assumes_shared_ctx_guard(...)	__attribute__((assert_shared_capability(__VA_ARGS__)))
+#define __returns_ctx_guard(var)		__attribute__((lock_returned(var)))
+
+/*
+ * The below are used to annotate code being checked. Internal only.
+ */
+#define __excludes_ctx_guard(...)		__attribute__((locks_excluded(__VA_ARGS__)))
+#define __requires_ctx_guard(...)		__attribute__((requires_capability(__VA_ARGS__)))
+#define __requires_shared_ctx_guard(...)	__attribute__((requires_shared_capability(__VA_ARGS__)))
+
+/**
+ * __guarded_by - struct member and globals attribute, declares variable
+ *                only accessible within active context
+ *
+ * Declares that the struct member or global variable is only accessible within
+ * the context entered by the given context guard. Read operations on the data
+ * require shared access, while write operations require exclusive access.
+ *
+ * .. code-block:: c
+ *
+ *	struct some_state {
+ *		spinlock_t lock;
+ *		long counter __guarded_by(&lock);
+ *	};
+ */
+#define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
+
+/**
+ * __pt_guarded_by - struct member and globals attribute, declares pointed-to
+ *                   data only accessible within active context
+ *
+ * Declares that the data pointed to by the struct member pointer or global
+ * pointer is only accessible within the context entered by the given context
+ * guard. Read operations on the data require shared access, while write
+ * operations require exclusive access.
+ *
+ * .. code-block:: c
+ *
+ *	struct some_state {
+ *		spinlock_t lock;
+ *		long *counter __pt_guarded_by(&lock);
+ *	};
+ */
+#define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)))
+
+/**
+ * context_guard_struct() - declare or define a context guard struct
+ * @name: struct name
+ *
+ * Helper to declare or define a struct type that is also a context guard.
+ *
+ * .. code-block:: c
+ *
+ *	context_guard_struct(my_handle) {
+ *		int foo;
+ *		long bar;
+ *	};
+ *
+ *	struct some_state {
+ *		...
+ *	};
+ *	// ... declared elsewhere ...
+ *	context_guard_struct(some_state);
+ *
+ * Note: The implementation defines several helper functions that can acquire
+ * and release the context guard.
+ */
+#define context_guard_struct(name, ...)								\
+	struct __ctx_guard_type(name) __VA_ARGS__ name;							\
+	static __always_inline void __acquire_ctx_guard(const struct name *var)				\
+		__attribute__((overloadable)) __no_context_analysis __acquires_ctx_guard(var) { }	\
+	static __always_inline void __acquire_shared_ctx_guard(const struct name *var)			\
+		__attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_guard(var) { } \
+	static __always_inline bool __try_acquire_ctx_guard(const struct name *var, bool ret)		\
+		__attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_guard(1, var)	\
+	{ return ret; }											\
+	static __always_inline bool __try_acquire_shared_ctx_guard(const struct name *var, bool ret)	\
+		__attribute__((overloadable)) __no_context_analysis __try_acquires_shared_ctx_guard(1, var) \
+	{ return ret; }											\
+	static __always_inline void __release_ctx_guard(const struct name *var)				\
+		__attribute__((overloadable)) __no_context_analysis __releases_ctx_guard(var) { }	\
+	static __always_inline void __release_shared_ctx_guard(const struct name *var)			\
+		__attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_guard(var) { } \
+	static __always_inline void __assume_ctx_guard(const struct name *var)				\
+		__attribute__((overloadable)) __assumes_ctx_guard(var) { }				\
+	static __always_inline void __assume_shared_ctx_guard(const struct name *var)			\
+		__attribute__((overloadable)) __assumes_shared_ctx_guard(var) { }			\
+	struct name
+
+/**
+ * disable_context_analysis() - disables context analysis
+ *
+ * Disables context analysis. Must be paired with a later
+ * enable_context_analysis().
+ */
+#define disable_context_analysis()				\
+	__diag_push();						\
+	__diag_ignore_all("-Wunknown-warning-option", "")	\
+	__diag_ignore_all("-Wthread-safety", "")		\
+	__diag_ignore_all("-Wthread-safety-pointer", "")
+
+/**
+ * enable_context_analysis() - re-enables context analysis
+ *
+ * Re-enables context analysis. Must be paired with a prior
+ * disable_context_analysis().
+ */
+#define enable_context_analysis() __diag_pop()
+
+/**
+ * __no_context_analysis - function attribute, disables context analysis
+ *
+ * Function attribute denoting that context analysis is disabled for the
+ * whole function. Prefer use of `context_unsafe()` where possible.
+ */
+#define __no_context_analysis	__attribute__((no_thread_safety_analysis))
+
+#endif /* _LINUX_COMPILER_CONTEXT_ANALYSIS_CLANG_H */
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 03056f87a86f..33ad367fef3f 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -6,140 +6,7 @@
 #ifndef _LINUX_COMPILER_CONTEXT_ANALYSIS_H
 #define _LINUX_COMPILER_CONTEXT_ANALYSIS_H
 
-#if defined(WARN_CONTEXT_ANALYSIS)
-
-/*
- * These attributes define new context guard (Clang: capability) types.
- * Internal only.
- */
-# define __ctx_guard_type(name)			__attribute__((capability(#name)))
-# define __reentrant_ctx_guard			__attribute__((reentrant_capability))
-# define __acquires_ctx_guard(...)		__attribute__((acquire_capability(__VA_ARGS__)))
-# define __acquires_shared_ctx_guard(...)	__attribute__((acquire_shared_capability(__VA_ARGS__)))
-# define __try_acquires_ctx_guard(ret, var)	__attribute__((try_acquire_capability(ret, var)))
-# define __try_acquires_shared_ctx_guard(ret, var) __attribute__((try_acquire_shared_capability(ret, var)))
-# define __releases_ctx_guard(...)		__attribute__((release_capability(__VA_ARGS__)))
-# define __releases_shared_ctx_guard(...)	__attribute__((release_shared_capability(__VA_ARGS__)))
-# define __assumes_ctx_guard(...)		__attribute__((assert_capability(__VA_ARGS__)))
-# define __assumes_shared_ctx_guard(...)	__attribute__((assert_shared_capability(__VA_ARGS__)))
-# define __returns_ctx_guard(var)		__attribute__((lock_returned(var)))
-
-/*
- * The below are used to annotate code being checked. Internal only.
- */
-# define __excludes_ctx_guard(...)		__attribute__((locks_excluded(__VA_ARGS__)))
-# define __requires_ctx_guard(...)		__attribute__((requires_capability(__VA_ARGS__)))
-# define __requires_shared_ctx_guard(...)	__attribute__((requires_shared_capability(__VA_ARGS__)))
-
-/**
- * __guarded_by - struct member and globals attribute, declares variable
- *                only accessible within active context
- *
- * Declares that the struct member or global variable is only accessible within
- * the context entered by the given context guard. Read operations on the data
- * require shared access, while write operations require exclusive access.
- *
- * .. code-block:: c
- *
- *	struct some_state {
- *		spinlock_t lock;
- *		long counter __guarded_by(&lock);
- *	};
- */
-# define __guarded_by(...)		__attribute__((guarded_by(__VA_ARGS__)))
-
-/**
- * __pt_guarded_by - struct member and globals attribute, declares pointed-to
- *                   data only accessible within active context
- *
- * Declares that the data pointed to by the struct member pointer or global
- * pointer is only accessible within the context entered by the given context
- * guard. Read operations on the data require shared access, while write
- * operations require exclusive access.
- *
- * .. code-block:: c
- *
- *	struct some_state {
- *		spinlock_t lock;
- *		long *counter __pt_guarded_by(&lock);
- *	};
- */
-# define __pt_guarded_by(...)		__attribute__((pt_guarded_by(__VA_ARGS__)))
-
-/**
- * context_guard_struct() - declare or define a context guard struct
- * @name: struct name
- *
- * Helper to declare or define a struct type that is also a context guard.
- *
- * .. code-block:: c
- *
- *	context_guard_struct(my_handle) {
- *		int foo;
- *		long bar;
- *	};
- *
- *	struct some_state {
- *		...
- *	};
- *	// ... declared elsewhere ...
- *	context_guard_struct(some_state);
- *
- * Note: The implementation defines several helper functions that can acquire
- * and release the context guard.
- */
-# define context_guard_struct(name, ...)								\
-	struct __ctx_guard_type(name) __VA_ARGS__ name;							\
-	static __always_inline void __acquire_ctx_guard(const struct name *var)				\
-		__attribute__((overloadable)) __no_context_analysis __acquires_ctx_guard(var) { }	\
-	static __always_inline void __acquire_shared_ctx_guard(const struct name *var)			\
-		__attribute__((overloadable)) __no_context_analysis __acquires_shared_ctx_guard(var) { } \
-	static __always_inline bool __try_acquire_ctx_guard(const struct name *var, bool ret)		\
-		__attribute__((overloadable)) __no_context_analysis __try_acquires_ctx_guard(1, var)	\
-	{ return ret; }											\
-	static __always_inline bool __try_acquire_shared_ctx_guard(const struct name *var, bool ret)	\
-		__attribute__((overloadable)) __no_context_analysis __try_acquires_shared_ctx_guard(1, var) \
-	{ return ret; }											\
-	static __always_inline void __release_ctx_guard(const struct name *var)				\
-		__attribute__((overloadable)) __no_context_analysis __releases_ctx_guard(var) { }	\
-	static __always_inline void __release_shared_ctx_guard(const struct name *var)			\
-		__attribute__((overloadable)) __no_context_analysis __releases_shared_ctx_guard(var) { } \
-	static __always_inline void __assume_ctx_guard(const struct name *var)				\
-		__attribute__((overloadable)) __assumes_ctx_guard(var) { }				\
-	static __always_inline void __assume_shared_ctx_guard(const struct name *var)			\
-		__attribute__((overloadable)) __assumes_shared_ctx_guard(var) { }			\
-	struct name
-
-/**
- * disable_context_analysis() - disables context analysis
- *
- * Disables context analysis. Must be paired with a later
- * enable_context_analysis().
- */
-# define disable_context_analysis()				\
-	__diag_push();						\
-	__diag_ignore_all("-Wunknown-warning-option", "")	\
-	__diag_ignore_all("-Wthread-safety", "")		\
-	__diag_ignore_all("-Wthread-safety-pointer", "")
-
-/**
- * enable_context_analysis() - re-enables context analysis
- *
- * Re-enables context analysis. Must be paired with a prior
- * disable_context_analysis().
- */
-# define enable_context_analysis() __diag_pop()
-
-/**
- * __no_context_analysis - function attribute, disables context analysis
- *
- * Function attribute denoting that context analysis is disabled for the
- * whole function. Prefer use of `context_unsafe()` where possible.
- */
-# define __no_context_analysis	__attribute__((no_thread_safety_analysis))
-
-#else /* !WARN_CONTEXT_ANALYSIS */
-
+#if !defined(WARN_CONTEXT_ANALYSIS)
 # define __ctx_guard_type(name)
 # define __reentrant_ctx_guard
 # define __acquires_ctx_guard(...)
@@ -168,7 +35,6 @@
 # define disable_context_analysis()
 # define enable_context_analysis()
 # define __no_context_analysis
-
 #endif /* WARN_CONTEXT_ANALYSIS */
 
 /**
diff --git a/scripts/Makefile.context-analysis b/scripts/Makefile.context-analysis
index cd3bb49d3f09..6f94b555af14 100644
--- a/scripts/Makefile.context-analysis
+++ b/scripts/Makefile.context-analysis
@@ -2,7 +2,8 @@
 
 context-analysis-cflags := -DWARN_CONTEXT_ANALYSIS		\
 	-fexperimental-late-parse-attributes -Wthread-safety	\
-	-Wthread-safety-pointer -Wthread-safety-beta
+	-Wthread-safety-pointer -Wthread-safety-beta		\
+	-include $(srctree)/include/linux/compiler-context-analysis-clang.h
 
 ifndef CONFIG_WARN_CONTEXT_ANALYSIS_ALL
 context-analysis-cflags += --warning-suppression-mappings=$(srctree)/scripts/context-analysis-suppression.txt
-- 
2.52.0.rc2.455.g230fcf2819-goog

