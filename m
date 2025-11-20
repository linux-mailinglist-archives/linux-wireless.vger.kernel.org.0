Return-Path: <linux-wireless+bounces-29172-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EEA4C74D0B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 45EFA364186
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:03:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8483E2F362C;
	Thu, 20 Nov 2025 15:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="3Q7z3RPn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8752F25F1
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763650970; cv=none; b=W4tbz/XuzQAtub34LAWIqIwpXj11Z5no9PHAYgLLUVBwz+D1nyB2hJGv1DcBsAdxVTWKI1DUY+9xDf/pzOPB8k+Et42N4Vs5zOcLBrnt7e+sXGeUwGzNzBxe5rzDC3jLoVPb+O0UQpoi0/l6JNWa1q3B+18pnRO/BnOcfBzupow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763650970; c=relaxed/simple;
	bh=9h+sjG1QW8Lz6yXRIMLsc2hDcJzHqG0nR9fxoisBMwk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lHnTTjZNg+dCS8tdv/lgThXPE75+Kp/3m2y3Q7z1UD43TP4PTIGlyg6v7QV2kpkYuxbOck3HcjXYgfW6oIPHJFyYyYWHL4w91MJnrtMVXc4PZbXy81BVlAdsIFJAsFi5MIN5DI35qj/tuEJoAqS7EaaHAI6fpPcLszGpctDr7AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=3Q7z3RPn; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4779b432aecso6031385e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:02:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763650965; x=1764255765; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=299yB9vU7jRjUKLu8+l/HXcvl5VmnE8Y+0izxahilbE=;
        b=3Q7z3RPnHOF9e1ZFW2rDEws2MM1hBu9L+TQvui/sWl2GDYjXmFDFm4lsNHDXUTVwpS
         bMb1ZdkFPmqX7b7qc1gVaJXQgnexc20uOOa3UgHx66tO1v7dJWvec3F5uS+NDKiKxYfY
         XDaLw/F4n0DFRr0vPnsA8v1lli7BD1VUv7t5vyS/2D2uCyGM831A0+8n05AykIbV4M3Y
         3kiMVQ2qF4RLhX+5mZlJdFTL5lDfqMtmAxd69vHzbV7F7r5uuAP0qsC/I2Q7yLQgI6K/
         I8smFWO0IijrZ6FLItLGsMUdnN/MOL0DKfgSQwC9rMUTjgFikuHimmb8juALbHY8J+2v
         GcTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763650965; x=1764255765;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=299yB9vU7jRjUKLu8+l/HXcvl5VmnE8Y+0izxahilbE=;
        b=hbvsx9UqTg3zL9e4rgHmE09ZddY7CAjHg/5d37KDHIY/XiZPpiZNYEcfLQjQejSITY
         91dLNFIARAF3uA6t4J7mOPwLMCAu/g2P/k50jYCkJ5zr1DvHlt4mrYQd7EvX1mwxsA/y
         A9Rpkd81jV9bIzY1VnyQcOVvdzcl2+Hfjwrwe66SJCRKYcoNbcwUSve62kalVW8wcOzd
         Wi3Oj1wNsUvFKQrS5jkr+gluxcTSbQ4R2fVJzfseDQ1UH/xvOrsR5VpHpID+xYfT1hZd
         6vt9yH/clOBEG3qwqn4jHHTlsl19vPD0PmzrXypf0762/fepMXUZn8iRRwEXyeoCTdN/
         f/iw==
X-Forwarded-Encrypted: i=1; AJvYcCXQuhrgF8+wpL8JmtuWmtT7Ddy9sNkn7kAH5HZD58Z5VSAo5LedsdDvfnlatk4tfwFMnjPSiNHX6Y92/+XDkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvEdV74+eh6zKRnk/obDVE5KKc7AlnbmJEcxuapDnp3V3x4iwR
	LwOoaf9pp3TnITwt5aJ9u0res78oeNFwUEYhEXgluUnfD0dF7UsgkvoDYYFZZ+kIo2kkv8ToMMx
	Zhw==
X-Google-Smtp-Source: AGHT+IFyISfz3EA+x8by8TiaBc8rX6DJ8mSkbxNkvS0Q/9XVzJVRXjpX7J/DtmASShfXFKhrcCebAsbPag==
X-Received: from wmbjj13.prod.google.com ([2002:a05:600c:6a0d:b0:477:9f68:c324])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:35c7:b0:46e:49fb:4776
 with SMTP id 5b1f17b1804b1-477b8954523mr34852375e9.11.1763650964345; Thu, 20
 Nov 2025 07:02:44 -0800 (PST)
Date: Thu, 20 Nov 2025 15:49:02 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120145835.3833031-2-elver@google.com>
Subject: [PATCH v4 00/35] Compiler-Based Context- and Locking-Analysis
From: Marco Elver <elver@google.com>
To: elver@google.com, Peter Zijlstra <peterz@infradead.org>, 
	Boqun Feng <boqun.feng@gmail.com>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, 
	Linus Torvalds <torvalds@linux-foundation.org>
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

Context Analysis is a language extension, which enables statically
checking that required contexts are active (or inactive) by acquiring
and releasing user-definable "context guards". An obvious application is
lock-safety checking for the kernel's various synchronization primitives
(each of which represents a "context guard"), and checking that locking
rules are not violated.

The feature requires Clang 22 (unreleased) or later. Clang originally
called the feature "Thread Safety Analysis" [1]. This was later changed
and the feature became more flexible, gaining the ability to define
custom "capabilities". Its foundations can be found in "Capability
Systems" [2], used to specify the permissibility of operations to depend
on some "capability" being held (or not held).

Because the feature is not just able to express "capabilities" related
to synchronization primitives, and "capability" is already overloaded in
the kernel, the naming chosen for the kernel departs from Clang's
"Thread Safety" and "capability" nomenclature; we refer to the feature
as "Context Analysis" to avoid confusion. The internal implementation
still makes references to Clang's terminology in a few places, such as
`-Wthread-safety` being the warning option that also still appears in
diagnostic messages.

Additional details can be found in the added kernel-doc documentation.
An LWN article covered v2 of the series: https://lwn.net/Articles/1012990/

 [1] https://clang.llvm.org/docs/ThreadSafetyAnalysis.html
 [2] https://www.cs.cornell.edu/talc/papers/capabilities.pdf

=== Development Approach ===

Prior art exists in the form of Sparse's Context Tracking. Locking
annotations on functions already exist sparsely, so the concept of
analyzing locking rules is not foreign to the kernel's codebase.

However, Clang's analysis is more complete vs. Sparse's, with the
typical trade-offs in static analysis: improved completeness is
sacrificed for more possible false positives or additional annotations
required by the programmer. Numerous options exist to disable or opt out
certain code from analysis.

This series initially aimed to retain compatibility with Sparse, which
can provide tree-wide analysis of a subset of the context analysis
introduced, but it was later decided to drop Sparse compatibility. For
the most part, the new (and old) keywords used for annotations remain
the same, and many of the pre-existing annotations remain valid.

One big question is how to enable this feature, given we end up with a
new dialect of C; two approaches have been considered:

  A. Tree-wide all-or-nothing approach. This approach requires tree-wide
     changes, adding annotations or selective opt-outs. Making more
     primitives context-analysis aware increases churn where maintainers
     are unfamiliar with the feature and the analysis is unable to deal
     with complex code patterns as-is.

Because we can't change the programming language (even if from one C
dialect to another) of the kernel overnight, a different approach might
cause less friction.

  B. A selective, incremental, and much less intrusive approach.
     Maintainers of subsystems opt in their modules or directories into
     context analysis (via Makefile):

       CONTEXT_ANALYSIS_foo.o := y	# foo.o only
       CONTEXT_ANALYSIS := y  		# all TUs

     Most (eventually all) synchronization primitives, and more
     context guards including ones that track "irq disabled",
     "preemption" disabled, etc. could be supported.

The approach taken by this series is B. This ensures that only
subsystems where maintainers are willing to deal with any warnings are
opted-in. Introducing the feature can be done incrementally, without
large tree-wide changes and adding numerous opt-outs and annotations to
the majority of code.

  Note: Bart Van Assche concurrently worked on enabling -Wthread-safety:
  https://lore.kernel.org/all/20250206175114.1974171-1-bvanassche@acm.org/
  Bart's work has shown what it might take to go with approach A
  (tree-wide, restricted to 'mutex' usage). This has shown that the
  analysis finds real issues when applied to enough subsystems!  We hope
  this serves as motivation to eventually enable the analysis in as many
  subsystems as possible, particularly subsystems that are not as easily
  tested by CI systems and test robots.

=== Initial Uses ===

With this initial series, the following synchronization primitives are
supported: `raw_spinlock_t`, `spinlock_t`, `rwlock_t`, `mutex`,
`seqlock_t`, `bit_spinlock`, RCU, SRCU (`srcu_struct`), `rw_semaphore`,
`local_lock_t`, `ww_mutex`.

To demonstrate use of the feature on real kernel code, the series also
enables context analysis for the following subsystems:

	* kernel/kcov
	* kernel/kcsan
	* kernel/sched/
	* lib/rhashtable
	* lib/stackdepot
	* mm/kfence
	* security/tomoyo
    	* crypto/

The initial benefits are static detection of violations of locking
rules. As more context guards are supported, we would see more static
checking beyond what regular C can provide, all while remaining easy
(and quick) to use via the Clang compiler.

  Note: The kernel already provides dynamic analysis tools Lockdep and
  KCSAN for lock-safety checking and data-race detection respectively.
  Unlike those, Clang's context analysis is a compile-time static
  analysis with no runtime impact. The static analysis complements
  existing dynamic analysis tools, as it may catch some issues before
  even getting into a running kernel, but is *not* a replacement for
  whole-kernel testing with the dynamic analysis tools enabled!

=== Appendix ===

A Clang version that supports `-Wthread-safety-pointer` and the new
alias-analysis of context-guard pointers is required (from this version
onwards):

	https://github.com/llvm/llvm-project/commit/7ccb5c08f0685d4787f12c3224a72f0650c5865e

The minimum required release version will be Clang 22.

This series is also available at this Git tree:

	https://git.kernel.org/pub/scm/linux/kernel/git/melver/linux.git/log/?h=ctx-analysis/dev

=== Changelog ===

v4:

  - Rename capability -> context analysis, per Linus's suggestion:
    https://lore.kernel.org/all/CAHk-=wgd-Wcp0GpYaQnU7S9ci+FvFmaNw1gm75mzf0ZWdNLxvw@mail.gmail.com/

  - Minor fixes.

v3: https://lore.kernel.org/all/20250918140451.1289454-1-elver@google.com/

  - Bump min. Clang version to 22+ (unreleased), which now supports:

	* re-entrancy via __attribute__((reentrant_capability));
	* basic form of capability alias analysis - which is the
	  biggest improvement since v2.

    This was the result of conclusions from this discussion:
    https://lore.kernel.org/all/CANpmjNPquO=W1JAh1FNQb8pMQjgeZAKCPQUAd7qUg=5pjJ6x=Q@mail.gmail.com/

  - Rename __asserts_cap/__assert_cap to __assumes_cap/__assume_cap.

  - Switch to DECLARE_LOCK_GUARD_1_ATTRS().

  - Add __acquire_ret and __acquire_shared_ret helper macros - can be
    used to define function-like macros that return objects which
    contains a held capabilities. Works now because of capability alias
    analysis.

  - Add capability_unsafe_alias() helper, where the analysis rightfully
    points out we're doing strange things with aliases but we don't
    care.

  - Support multi-argument attributes.

  - Enable for kernel/sched/{core,fair}.c, kernel/kcsan.
  - Drop drivers/tty changes (revisit later).

v2: https://lore.kernel.org/all/20250304092417.2873893-1-elver@google.com/

  - Remove Sparse context tracking support - after the introduction of
    Clang support, so that backports can skip removal of Sparse support.

  - Remove __cond_lock() function-like helper.

  - ww_mutex support.

  - -Wthread-safety-addressof was reworked and committed in upstream
    Clang as -Wthread-safety-pointer.

  - Make __cond_acquires() and __cond_acquires_shared() take abstract
    value, since compiler only cares about zero and non-zero.

  - Rename __var_guarded_by to simply __guarded_by. Initially the idea
    was to be explicit about if the variable itself or the pointed-to
    data is guarded, but in the long-term, making this shorter might be
    better.

  - Likewise rename __ref_guarded_by to __pt_guarded_by.

  - Introduce common header warning suppressions - this is a better
    solution than guarding header inclusions with disable_ +
    enable_capability_analysis(). Header suppressions are disabled when
    selecting CONFIG_WARN_CAPABILITY_ANALYSIS_ALL=y. This bumps the
    minimum Clang version required to 20+.

  - Make the data_race() macro imply disabled capability analysis.
    Writing capability_unsafe(data_race(..)) is unnecessarily verbose
    and data_race() on its own already indicates something subtly unsafe
    is happening.  This change was made after analysis of a finding in
    security/tomoyo.

  - Enable analysis in the following subsystems as additional examples
    of larger subsystem. Where it was obvious, the __guarded_by
    attribute was added to lock-guarded variables to improve coverage.

    	* drivers/tty
	* security/tomoyo
    	* crypto/

RFC v1: https://lore.kernel.org/lkml/20250206181711.1902989-1-elver@google.com

Marco Elver (35):
  compiler_types: Move lock checking attributes to
    compiler-context-analysis.h
  compiler-context-analysis: Add infrastructure for Context Analysis
    with Clang
  compiler-context-analysis: Add test stub
  Documentation: Add documentation for Compiler-Based Context Analysis
  checkpatch: Warn about context_unsafe() without comment
  cleanup: Basic compatibility with context analysis
  lockdep: Annotate lockdep assertions for context analysis
  locking/rwlock, spinlock: Support Clang's context analysis
  compiler-context-analysis: Change __cond_acquires to take return value
  locking/mutex: Support Clang's context analysis
  locking/seqlock: Support Clang's context analysis
  bit_spinlock: Include missing <asm/processor.h>
  bit_spinlock: Support Clang's context analysis
  rcu: Support Clang's context analysis
  srcu: Support Clang's context analysis
  kref: Add context-analysis annotations
  locking/rwsem: Support Clang's context analysis
  locking/local_lock: Include missing headers
  locking/local_lock: Support Clang's context analysis
  locking/ww_mutex: Support Clang's context analysis
  debugfs: Make debugfs_cancellation a context guard struct
  compiler-context-analysis: Remove Sparse support
  compiler-context-analysis: Remove __cond_lock() function-like helper
  compiler-context-analysis: Introduce header suppressions
  compiler: Let data_race() imply disabled context analysis
  MAINTAINERS: Add entry for Context Analysis
  kfence: Enable context analysis
  kcov: Enable context analysis
  kcsan: Enable context analysis
  stackdepot: Enable context analysis
  rhashtable: Enable context analysis
  printk: Move locking annotation to printk.c
  security/tomoyo: Enable context analysis
  crypto: Enable context analysis
  sched: Enable context analysis for core.c and fair.c

 Documentation/dev-tools/context-analysis.rst  | 146 +++++
 Documentation/dev-tools/index.rst             |   1 +
 Documentation/dev-tools/sparse.rst            |  19 -
 Documentation/mm/process_addrs.rst            |   6 +-
 MAINTAINERS                                   |  11 +
 Makefile                                      |   1 +
 crypto/Makefile                               |   2 +
 crypto/acompress.c                            |   6 +-
 crypto/algapi.c                               |   2 +
 crypto/api.c                                  |   1 +
 crypto/crypto_engine.c                        |   2 +-
 crypto/drbg.c                                 |   5 +
 crypto/internal.h                             |   2 +-
 crypto/proc.c                                 |   3 +
 crypto/scompress.c                            |  24 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   6 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   5 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |   4 +-
 fs/dlm/lock.c                                 |   2 +-
 include/crypto/internal/acompress.h           |   7 +-
 include/crypto/internal/engine.h              |   2 +-
 include/linux/bit_spinlock.h                  |  24 +-
 include/linux/cleanup.h                       |  17 +
 include/linux/compiler-context-analysis.h     | 429 +++++++++++++
 include/linux/compiler.h                      |   2 +
 include/linux/compiler_types.h                |  18 +-
 include/linux/console.h                       |   4 +-
 include/linux/debugfs.h                       |  12 +-
 include/linux/kref.h                          |   2 +
 include/linux/list_bl.h                       |   2 +
 include/linux/local_lock.h                    |  45 +-
 include/linux/local_lock_internal.h           |  73 ++-
 include/linux/lockdep.h                       |  12 +-
 include/linux/mm.h                            |  33 +-
 include/linux/mutex.h                         |  35 +-
 include/linux/mutex_types.h                   |   4 +-
 include/linux/rcupdate.h                      |  90 +--
 include/linux/refcount.h                      |   6 +-
 include/linux/rhashtable.h                    |  14 +-
 include/linux/rwlock.h                        |  22 +-
 include/linux/rwlock_api_smp.h                |  43 +-
 include/linux/rwlock_rt.h                     |  44 +-
 include/linux/rwlock_types.h                  |  10 +-
 include/linux/rwsem.h                         |  66 +-
 include/linux/sched.h                         |   6 +-
 include/linux/sched/signal.h                  |  16 +-
 include/linux/sched/task.h                    |   5 +-
 include/linux/sched/wake_q.h                  |   3 +
 include/linux/seqlock.h                       |  24 +
 include/linux/seqlock_types.h                 |   5 +-
 include/linux/spinlock.h                      |  89 ++-
 include/linux/spinlock_api_smp.h              |  34 +-
 include/linux/spinlock_api_up.h               | 112 +++-
 include/linux/spinlock_rt.h                   |  37 +-
 include/linux/spinlock_types.h                |  10 +-
 include/linux/spinlock_types_raw.h            |   5 +-
 include/linux/srcu.h                          |  64 +-
 include/linux/srcutiny.h                      |   4 +
 include/linux/srcutree.h                      |   6 +-
 include/linux/ww_mutex.h                      |  22 +-
 kernel/Makefile                               |   2 +
 kernel/kcov.c                                 |  36 +-
 kernel/kcsan/Makefile                         |   2 +
 kernel/kcsan/report.c                         |  11 +-
 kernel/printk/printk.c                        |   2 +
 kernel/sched/Makefile                         |   3 +
 kernel/sched/core.c                           |  89 ++-
 kernel/sched/fair.c                           |   9 +-
 kernel/sched/sched.h                          | 110 +++-
 kernel/signal.c                               |   4 +-
 kernel/time/posix-timers.c                    |  13 +-
 lib/Kconfig.debug                             |  44 ++
 lib/Makefile                                  |   6 +
 lib/dec_and_lock.c                            |   8 +-
 lib/rhashtable.c                              |   5 +-
 lib/stackdepot.c                              |  20 +-
 lib/test_context-analysis.c                   | 596 ++++++++++++++++++
 mm/kfence/Makefile                            |   2 +
 mm/kfence/core.c                              |  20 +-
 mm/kfence/kfence.h                            |  14 +-
 mm/kfence/report.c                            |   4 +-
 mm/memory.c                                   |   4 +-
 mm/pgtable-generic.c                          |  19 +-
 net/ipv4/tcp_sigpool.c                        |   2 +-
 scripts/Makefile.context-analysis             |  11 +
 scripts/Makefile.lib                          |  10 +
 scripts/checkpatch.pl                         |   7 +
 scripts/context-analysis-suppression.txt      |  33 +
 security/tomoyo/Makefile                      |   2 +
 security/tomoyo/common.c                      |  52 +-
 security/tomoyo/common.h                      |  77 +--
 security/tomoyo/domain.c                      |   1 +
 security/tomoyo/environ.c                     |   1 +
 security/tomoyo/file.c                        |   5 +
 security/tomoyo/gc.c                          |  28 +-
 security/tomoyo/mount.c                       |   2 +
 security/tomoyo/network.c                     |   3 +
 tools/include/linux/compiler_types.h          |   2 -
 99 files changed, 2377 insertions(+), 592 deletions(-)
 create mode 100644 Documentation/dev-tools/context-analysis.rst
 create mode 100644 include/linux/compiler-context-analysis.h
 create mode 100644 lib/test_context-analysis.c
 create mode 100644 scripts/Makefile.context-analysis
 create mode 100644 scripts/context-analysis-suppression.txt

-- 
2.52.0.rc1.455.g30608eb744-goog


