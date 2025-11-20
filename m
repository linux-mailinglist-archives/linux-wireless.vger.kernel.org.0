Return-Path: <linux-wireless+bounces-29202-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3132BC74F55
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 16:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D1A6F4E8445
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Nov 2025 15:20:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 380E935E54A;
	Thu, 20 Nov 2025 15:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LyDiKVps"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C55535BDD3
	for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 15:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763651660; cv=none; b=YKw6a6JGudM8qoM7lhtvS4I5HKxu+DD9zQgknanElP5Tb65+qe9ZJ1U6EOorjjpFdgSF0NCdIdCjE/lmgGFCP5EYXrgp4lddNv3IpiHdLrwy6uLYA0IfipBGCPJnsx0BhH5MIK3SlvhJ583Da18YVzHfIey9dXuxWBVZ6Ej5yMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763651660; c=relaxed/simple;
	bh=oroLAEWKsCoLWto0z9ip7/65vBrTCj5wrpvh1Y5dmGQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qXGn+tom2jb1LWnPGcIJ8zUtNquriFE+pDAaLSCPZFjr5wG4NE+jfQv/iD9nasFwM0GrA/aGQyPhUR0r6qr4FNiTguoJ8EHbcBKFJ8iB7KmIixSSNTCn5TcbxBpHRl2Q6fB3J/rxgcXe9JuzU/nQ1gF5kkNhSXCqNSxQuh0vDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--elver.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LyDiKVps; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--elver.bounces.google.com
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-477939321e6so5996005e9.0
        for <linux-wireless@vger.kernel.org>; Thu, 20 Nov 2025 07:13:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1763651601; x=1764256401; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=hnrOsDiUA3Jbc7VaJ0HrkQb/VaIIv56J10QiPSfXr78=;
        b=LyDiKVpsp/H0VCK7XmsOfsvnukaz/aDTK33nvR2l0XJLY2Ongwj2zRAQeAJWwgD3Qb
         x+chhjFQ2L/M+nikyQpEAesK7svtMKR92admJt4fb4oSdDgf8Wj5Q2s7xn20tO+Lju/x
         NG+sDT+tesRuNKnYjhs23Delh2k3EDig/iqjtZYpAF92nHsqCfo1NP262xrAHFZLPmyE
         Q8sB4PdQ4GUUeYeVWjeS7Ru4TygNFLY+WRfVglFsmV27S9v+kjZBEKJEQVBEoH65wTe6
         OU7HFShtCuG97r6EZRMzSwlO6Kz2HfRub25QGWc4v5hjRwgiEgCJ6WC9E4p00zb4b+u3
         eInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763651601; x=1764256401;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnrOsDiUA3Jbc7VaJ0HrkQb/VaIIv56J10QiPSfXr78=;
        b=dYfsL9oVsxjP7vV5qxJjij9nIUgxuLHujUQESm028xKE4YcyVkyfI3UCCxh4avf/uS
         yreggYW40TCQWGDro8PIw2LYMmD4RtBAQDKJBdfaK0iSOlQk/7ImCnlHng1w5M7o9oUW
         K4vS7kDkleOY90Zs6wmugcdCqrfJavELn2CeiZ0LjtHT/Ug39jxzdrT0HaZjEu4pJe/k
         lFKbqAO7/c2ef58VN9GTL7Ej/pNUKtsy/aOBX2PFNNXqjW28RwwOop1S4+VlES2ibUJ3
         ehx5TUVokKk/elzlq73sZ0AinSGjrKEEnuj42u9jN6kHW/CHIYm86aA6w19RP3AdSbAt
         Pexw==
X-Forwarded-Encrypted: i=1; AJvYcCW9JLxs8Va5TkIV74DDfJchWjBbRuyB+geCPCn9zuXFg2DLTrUtBq6eWJn5rzhh3H8NwdkyWmv93uWWEbSBMA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwdjP4I9HZG6AP6ED8wr6j8WUlvNG6QnSBlQ3NZ/HLbuak6+A1i
	4gs8rkKsA+cydZuhhbg8ZuPry9dbhQtDlonsdBR4BIN+nWVKTwnczQ1FZ+ezRxmMpVGy7M+dLo6
	s8A==
X-Google-Smtp-Source: AGHT+IF2KXUxbQpTUel+F1ELb5KnxDtM6152cWlA0R8b9K2pzp4QmF2ka0XeKwauvotAPfHQh37yHGXwIg==
X-Received: from wmo9.prod.google.com ([2002:a05:600c:2309:b0:477:81d8:54c6])
 (user=elver job=prod-delivery.src-stubby-dispatcher) by 2002:a05:600c:4704:b0:477:7d94:5d0e
 with SMTP id 5b1f17b1804b1-477b8a9ab58mr32475085e9.27.1763651600324; Thu, 20
 Nov 2025 07:13:20 -0800 (PST)
Date: Thu, 20 Nov 2025 16:09:48 +0100
In-Reply-To: <20251120151033.3840508-7-elver@google.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20251120145835.3833031-2-elver@google.com> <20251120151033.3840508-7-elver@google.com>
X-Mailer: git-send-email 2.52.0.rc1.455.g30608eb744-goog
Message-ID: <20251120151033.3840508-24-elver@google.com>
Subject: [PATCH v4 23/35] compiler-context-analysis: Remove __cond_lock()
 function-like helper
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

As discussed in [1], removing __cond_lock() will improve the readability
of trylock code. Now that Sparse context tracking support has been
removed, we can also remove __cond_lock().

Change existing APIs to either drop __cond_lock() completely, or make
use of the __cond_acquires() function attribute instead.

In particular, spinlock and rwlock implementations required switching
over to inline helpers rather than statement-expressions for their
trylock_* variants.

Link: https://lore.kernel.org/all/20250207082832.GU7145@noisy.programming.kicks-ass.net/ [1]
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
---
v2:
* New patch.
---
 Documentation/dev-tools/context-analysis.rst  |  2 -
 Documentation/mm/process_addrs.rst            |  6 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  6 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  5 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  4 +-
 include/linux/compiler-context-analysis.h     | 31 ----------
 include/linux/mm.h                            | 33 ++--------
 include/linux/rwlock.h                        | 11 +---
 include/linux/rwlock_api_smp.h                | 14 ++++-
 include/linux/rwlock_rt.h                     | 21 ++++---
 include/linux/sched/signal.h                  | 14 +----
 include/linux/spinlock.h                      | 45 +++++---------
 include/linux/spinlock_api_smp.h              | 20 ++++++
 include/linux/spinlock_api_up.h               | 61 ++++++++++++++++---
 include/linux/spinlock_rt.h                   | 26 ++++----
 kernel/signal.c                               |  4 +-
 kernel/time/posix-timers.c                    | 13 +---
 lib/dec_and_lock.c                            |  8 +--
 mm/memory.c                                   |  4 +-
 mm/pgtable-generic.c                          | 19 +++---
 tools/include/linux/compiler_types.h          |  2 -
 22 files changed, 162 insertions(+), 191 deletions(-)

diff --git a/Documentation/dev-tools/context-analysis.rst b/Documentation/dev-tools/context-analysis.rst
index 2936666651f3..e53f089d0c52 100644
--- a/Documentation/dev-tools/context-analysis.rst
+++ b/Documentation/dev-tools/context-analysis.rst
@@ -113,10 +113,8 @@ Keywords
                  __releases_shared
                  __acquire
                  __release
-                 __cond_lock
                  __acquire_shared
                  __release_shared
-                 __cond_lock_shared
                  __acquire_ret
                  __acquire_shared_ret
                  context_unsafe
diff --git a/Documentation/mm/process_addrs.rst b/Documentation/mm/process_addrs.rst
index be49e2a269e4..25d551a01f16 100644
--- a/Documentation/mm/process_addrs.rst
+++ b/Documentation/mm/process_addrs.rst
@@ -582,7 +582,7 @@ To access PTE-level page tables, a helper like :c:func:`!pte_offset_map_lock` or
 :c:func:`!pte_offset_map` can be used depending on stability requirements.
 These map the page table into kernel memory if required, take the RCU lock, and
 depending on variant, may also look up or acquire the PTE lock.
-See the comment on :c:func:`!__pte_offset_map_lock`.
+See the comment on :c:func:`!pte_offset_map_lock`.
 
 Atomicity
 ^^^^^^^^^
@@ -666,7 +666,7 @@ must be released via :c:func:`!pte_unmap_unlock`.
 .. note:: There are some variants on this, such as
    :c:func:`!pte_offset_map_rw_nolock` when we know we hold the PTE stable but
    for brevity we do not explore this.  See the comment for
-   :c:func:`!__pte_offset_map_lock` for more details.
+   :c:func:`!pte_offset_map_lock` for more details.
 
 When modifying data in ranges we typically only wish to allocate higher page
 tables as necessary, using these locks to avoid races or overwriting anything,
@@ -685,7 +685,7 @@ At the leaf page table, that is the PTE, we can't entirely rely on this pattern
 as we have separate PMD and PTE locks and a THP collapse for instance might have
 eliminated the PMD entry as well as the PTE from under us.
 
-This is why :c:func:`!__pte_offset_map_lock` locklessly retrieves the PMD entry
+This is why :c:func:`!pte_offset_map_lock` locklessly retrieves the PMD entry
 for the PTE, carefully checking it is as expected, before acquiring the
 PTE-specific lock, and then *again* checking that the PMD entry is as expected.
 
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
index 5232f66c2d52..12016bb00596 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.c
@@ -548,11 +548,11 @@ int iwl_trans_read_config32(struct iwl_trans *trans, u32 ofs,
 	return iwl_trans_pcie_read_config32(trans, ofs, val);
 }
 
-bool _iwl_trans_grab_nic_access(struct iwl_trans *trans)
+bool iwl_trans_grab_nic_access(struct iwl_trans *trans)
 {
 	return iwl_trans_pcie_grab_nic_access(trans);
 }
-IWL_EXPORT_SYMBOL(_iwl_trans_grab_nic_access);
+IWL_EXPORT_SYMBOL(iwl_trans_grab_nic_access);
 
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans)
diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
index a0cc5d7745e8..10b38d09cddf 100644
--- a/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
+++ b/drivers/net/wireless/intel/iwlwifi/iwl-trans.h
@@ -1063,11 +1063,7 @@ int iwl_trans_sw_reset(struct iwl_trans *trans);
 void iwl_trans_set_bits_mask(struct iwl_trans *trans, u32 reg,
 			     u32 mask, u32 value);
 
-bool _iwl_trans_grab_nic_access(struct iwl_trans *trans);
-
-#define iwl_trans_grab_nic_access(trans)		\
-	__cond_lock(nic_access,				\
-		    likely(_iwl_trans_grab_nic_access(trans)))
+bool iwl_trans_grab_nic_access(struct iwl_trans *trans);
 
 void __releases(nic_access)
 iwl_trans_release_nic_access(struct iwl_trans *trans);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
index 207c56e338dd..7b7b35e442f9 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/internal.h
@@ -553,10 +553,7 @@ void iwl_trans_pcie_free(struct iwl_trans *trans);
 void iwl_trans_pcie_free_pnvm_dram_regions(struct iwl_dram_regions *dram_regions,
 					   struct device *dev);
 
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
-#define _iwl_trans_pcie_grab_nic_access(trans, silent)		\
-	__cond_lock(nic_access_nobh,				\
-		    likely(__iwl_trans_pcie_grab_nic_access(trans, silent)))
+bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent);
 
 void iwl_trans_pcie_check_product_reset_status(struct pci_dev *pdev);
 void iwl_trans_pcie_check_product_reset_mode(struct pci_dev *pdev);
diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
index 59307b5df441..a45358841243 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/gen1_2/trans.c
@@ -2327,7 +2327,7 @@ EXPORT_SYMBOL(iwl_trans_pcie_reset);
  * This version doesn't disable BHs but rather assumes they're
  * already disabled.
  */
-bool __iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
+bool _iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans, bool silent)
 {
 	int ret;
 	struct iwl_trans_pcie *trans_pcie = IWL_TRANS_GET_PCIE_TRANS(trans);
@@ -2415,7 +2415,7 @@ bool iwl_trans_pcie_grab_nic_access(struct iwl_trans *trans)
 	bool ret;
 
 	local_bh_disable();
-	ret = __iwl_trans_pcie_grab_nic_access(trans, false);
+	ret = _iwl_trans_pcie_grab_nic_access(trans, false);
 	if (ret) {
 		/* keep BHs disabled until iwl_trans_pcie_release_nic_access */
 		return ret;
diff --git a/include/linux/compiler-context-analysis.h b/include/linux/compiler-context-analysis.h
index 6990cab7a4a9..03056f87a86f 100644
--- a/include/linux/compiler-context-analysis.h
+++ b/include/linux/compiler-context-analysis.h
@@ -329,24 +329,6 @@ static inline void _context_unsafe_alias(void **p) { }
  */
 #define __release(x)		__release_ctx_guard(x)
 
-/**
- * __cond_lock() - function that conditionally acquires a context guard
- *                 exclusively
- * @x: context guard instance pinter
- * @c: boolean expression
- *
- * Return: result of @c
- *
- * No-op function that conditionally acquires context guard instance @x
- * exclusively, if the boolean expression @c is true. The result of @c is the
- * return value; for example:
- *
- * .. code-block:: c
- *
- *	#define spin_trylock(l) __cond_lock(&lock, _spin_trylock(&lock))
- */
-#define __cond_lock(x, c)	__try_acquire_ctx_guard(x, c)
-
 /**
  * __must_hold_shared() - function attribute, caller must hold shared context guard
  *
@@ -405,19 +387,6 @@ static inline void _context_unsafe_alias(void **p) { }
  */
 #define __release_shared(x)	__release_shared_ctx_guard(x)
 
-/**
- * __cond_lock_shared() - function that conditionally acquires a context guard shared
- * @x: context guard instance pinter
- * @c: boolean expression
- *
- * Return: result of @c
- *
- * No-op function that conditionally acquires context guard instance @x with
- * shared access, if the boolean expression @c is true. The result of @c is the
- * return value.
- */
-#define __cond_lock_shared(x, c) __try_acquire_shared_ctx_guard(x, c)
-
 /**
  * __acquire_ret() - helper to acquire context guard of return value
  * @call: call expression
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 7c79b3369b82..d0c89022a823 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2813,15 +2813,8 @@ static inline pud_t pud_mkspecial(pud_t pud)
 }
 #endif	/* CONFIG_ARCH_SUPPORTS_PUD_PFNMAP */
 
-extern pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			       spinlock_t **ptl);
-static inline pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
-				    spinlock_t **ptl)
-{
-	pte_t *ptep;
-	__cond_lock(*ptl, ptep = __get_locked_pte(mm, addr, ptl));
-	return ptep;
-}
+extern pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+			     spinlock_t **ptl);
 
 #ifdef __PAGETABLE_P4D_FOLDED
 static inline int __p4d_alloc(struct mm_struct *mm, pgd_t *pgd,
@@ -3116,31 +3109,15 @@ static inline bool pagetable_pte_ctor(struct mm_struct *mm,
 	return true;
 }
 
-pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
-static inline pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,
-			pmd_t *pmdvalp)
-{
-	pte_t *pte;
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
 
-	__cond_lock(RCU, pte = ___pte_offset_map(pmd, addr, pmdvalp));
-	return pte;
-}
 static inline pte_t *pte_offset_map(pmd_t *pmd, unsigned long addr)
 {
 	return __pte_offset_map(pmd, addr, NULL);
 }
 
-pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp);
-static inline pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			unsigned long addr, spinlock_t **ptlp)
-{
-	pte_t *pte;
-
-	__cond_lock(RCU, __cond_lock(*ptlp,
-			pte = __pte_offset_map_lock(mm, pmd, addr, ptlp)));
-	return pte;
-}
+pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			   unsigned long addr, spinlock_t **ptlp);
 
 pte_t *pte_offset_map_ro_nolock(struct mm_struct *mm, pmd_t *pmd,
 				unsigned long addr, spinlock_t **ptlp);
diff --git a/include/linux/rwlock.h b/include/linux/rwlock.h
index a2f85a0356c4..53ba394e9c51 100644
--- a/include/linux/rwlock.h
+++ b/include/linux/rwlock.h
@@ -50,8 +50,8 @@ do {								\
  * regardless of whether CONFIG_SMP or CONFIG_PREEMPT are set. The various
  * methods are defined as nops in the case they are not required.
  */
-#define read_trylock(lock)	__cond_lock_shared(lock, _raw_read_trylock(lock))
-#define write_trylock(lock)	__cond_lock(lock, _raw_write_trylock(lock))
+#define read_trylock(lock)	_raw_read_trylock(lock)
+#define write_trylock(lock)	_raw_write_trylock(lock)
 
 #define write_lock(lock)	_raw_write_lock(lock)
 #define read_lock(lock)		_raw_read_lock(lock)
@@ -113,12 +113,7 @@ do {								\
 	} while (0)
 #define write_unlock_bh(lock)		_raw_write_unlock_bh(lock)
 
-#define write_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		local_irq_save(flags);			\
-		_raw_write_trylock(lock) ?		\
-		1 : ({ local_irq_restore(flags); 0; });	\
-	}))
+#define write_trylock_irqsave(lock, flags) _raw_write_trylock_irqsave(lock, &(flags))
 
 #ifdef arch_rwlock_is_contended
 #define rwlock_is_contended(lock) \
diff --git a/include/linux/rwlock_api_smp.h b/include/linux/rwlock_api_smp.h
index 6d5cc0b7be1f..d903b17c46ca 100644
--- a/include/linux/rwlock_api_smp.h
+++ b/include/linux/rwlock_api_smp.h
@@ -26,8 +26,8 @@ unsigned long __lockfunc _raw_read_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
 unsigned long __lockfunc _raw_write_lock_irqsave(rwlock_t *lock)
 							__acquires(lock);
-int __lockfunc _raw_read_trylock(rwlock_t *lock);
-int __lockfunc _raw_write_trylock(rwlock_t *lock);
+int __lockfunc _raw_read_trylock(rwlock_t *lock)	__cond_acquires_shared(true, lock);
+int __lockfunc _raw_write_trylock(rwlock_t *lock)	__cond_acquires(true, lock);
 void __lockfunc _raw_read_unlock(rwlock_t *lock)	__releases_shared(lock);
 void __lockfunc _raw_write_unlock(rwlock_t *lock)	__releases(lock);
 void __lockfunc _raw_read_unlock_bh(rwlock_t *lock)	__releases_shared(lock);
@@ -41,6 +41,16 @@ void __lockfunc
 _raw_write_unlock_irqrestore(rwlock_t *lock, unsigned long flags)
 							__releases(lock);
 
+static inline bool _raw_write_trylock_irqsave(rwlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	local_irq_save(*flags);
+	if (_raw_write_trylock(lock))
+		return true;
+	local_irq_restore(*flags);
+	return false;
+}
+
 #ifdef CONFIG_INLINE_READ_LOCK
 #define _raw_read_lock(lock) __raw_read_lock(lock)
 #endif
diff --git a/include/linux/rwlock_rt.h b/include/linux/rwlock_rt.h
index 2723abbe0e7a..f5fd96e0800e 100644
--- a/include/linux/rwlock_rt.h
+++ b/include/linux/rwlock_rt.h
@@ -26,11 +26,11 @@ do {							\
 } while (0)
 
 extern void rt_read_lock(rwlock_t *rwlock)	__acquires_shared(rwlock);
-extern int rt_read_trylock(rwlock_t *rwlock);
+extern int rt_read_trylock(rwlock_t *rwlock)	__cond_acquires_shared(true, rwlock);
 extern void rt_read_unlock(rwlock_t *rwlock)	__releases_shared(rwlock);
 extern void rt_write_lock(rwlock_t *rwlock)	__acquires(rwlock);
 extern void rt_write_lock_nested(rwlock_t *rwlock, int subclass)	__acquires(rwlock);
-extern int rt_write_trylock(rwlock_t *rwlock);
+extern int rt_write_trylock(rwlock_t *rwlock)	__cond_acquires(true, rwlock);
 extern void rt_write_unlock(rwlock_t *rwlock)	__releases(rwlock);
 
 static __always_inline void read_lock(rwlock_t *rwlock)
@@ -59,7 +59,7 @@ static __always_inline void read_lock_irq(rwlock_t *rwlock)
 		flags = 0;				\
 	} while (0)
 
-#define read_trylock(lock)	__cond_lock_shared(lock, rt_read_trylock(lock))
+#define read_trylock(lock)	rt_read_trylock(lock)
 
 static __always_inline void read_unlock(rwlock_t *rwlock)
 	__releases_shared(rwlock)
@@ -123,14 +123,15 @@ static __always_inline void write_lock_irq(rwlock_t *rwlock)
 		flags = 0;				\
 	} while (0)
 
-#define write_trylock(lock)	__cond_lock(lock, rt_write_trylock(lock))
+#define write_trylock(lock)	rt_write_trylock(lock)
 
-#define write_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		typecheck(unsigned long, flags);	\
-		flags = 0;				\
-		rt_write_trylock(lock);			\
-	}))
+static __always_inline bool _write_trylock_irqsave(rwlock_t *rwlock, unsigned long *flags)
+	__cond_acquires(true, rwlock)
+{
+	*flags = 0;
+	return rt_write_trylock(rwlock);
+}
+#define write_trylock_irqsave(lock, flags) _write_trylock_irqsave(lock, &(flags))
 
 static __always_inline void write_unlock(rwlock_t *rwlock)
 	__releases(rwlock)
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 7d6449982822..a63f65aa5bdd 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -737,18 +737,8 @@ static inline int thread_group_empty(struct task_struct *p)
 #define delay_group_leader(p) \
 		(thread_group_leader(p) && !thread_group_empty(p))
 
-extern struct sighand_struct *__lock_task_sighand(struct task_struct *task,
-							unsigned long *flags);
-
-static inline struct sighand_struct *lock_task_sighand(struct task_struct *task,
-						       unsigned long *flags)
-{
-	struct sighand_struct *ret;
-
-	ret = __lock_task_sighand(task, flags);
-	(void)__cond_lock(&task->sighand->siglock, ret);
-	return ret;
-}
+extern struct sighand_struct *lock_task_sighand(struct task_struct *task,
+						unsigned long *flags);
 
 static inline void unlock_task_sighand(struct task_struct *task,
 						unsigned long *flags)
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 274d866a0be3..77b215c4124d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -213,7 +213,7 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
  * various methods are defined as nops in the case they are not
  * required.
  */
-#define raw_spin_trylock(lock)	__cond_lock(lock, _raw_spin_trylock(lock))
+#define raw_spin_trylock(lock)	_raw_spin_trylock(lock)
 
 #define raw_spin_lock(lock)	_raw_spin_lock(lock)
 
@@ -284,22 +284,11 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 	} while (0)
 #define raw_spin_unlock_bh(lock)	_raw_spin_unlock_bh(lock)
 
-#define raw_spin_trylock_bh(lock) \
-	__cond_lock(lock, _raw_spin_trylock_bh(lock))
+#define raw_spin_trylock_bh(lock)	_raw_spin_trylock_bh(lock)
 
-#define raw_spin_trylock_irq(lock)			\
-	__cond_lock(lock, ({				\
-		local_irq_disable();			\
-		_raw_spin_trylock(lock) ?		\
-		1 : ({ local_irq_enable(); 0;  });	\
-	}))
+#define raw_spin_trylock_irq(lock)	_raw_spin_trylock_irq(lock)
 
-#define raw_spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		local_irq_save(flags);			\
-		_raw_spin_trylock(lock) ?		\
-		1 : ({ local_irq_restore(flags); 0; }); \
-	}))
+#define raw_spin_trylock_irqsave(lock, flags) _raw_spin_trylock_irqsave(lock, &(flags))
 
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
@@ -433,8 +422,12 @@ static __always_inline int spin_trylock_irq(spinlock_t *lock)
 	return raw_spin_trylock_irq(&lock->rlock);
 }
 
-#define spin_trylock_irqsave(lock, flags)			\
-	__cond_lock(lock, raw_spin_trylock_irqsave(spinlock_check(lock), flags))
+static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock) __no_context_analysis
+{
+	return raw_spin_trylock_irqsave(spinlock_check(lock), *flags);
+}
+#define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flags))
 
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
@@ -512,23 +505,17 @@ static inline int rwlock_needbreak(rwlock_t *lock)
  * Decrements @atomic by 1.  If the result is 0, returns true and locks
  * @lock.  Returns false for all other cases.
  */
-extern int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock);
-#define atomic_dec_and_lock(atomic, lock) \
-		__cond_lock(lock, _atomic_dec_and_lock(atomic, lock))
+extern int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock) __cond_acquires(true, lock);
 
 extern int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
-					unsigned long *flags);
-#define atomic_dec_and_lock_irqsave(atomic, lock, flags) \
-		__cond_lock(lock, _atomic_dec_and_lock_irqsave(atomic, lock, &(flags)))
+					unsigned long *flags) __cond_acquires(true, lock);
+#define atomic_dec_and_lock_irqsave(atomic, lock, flags) _atomic_dec_and_lock_irqsave(atomic, lock, &(flags))
 
-extern int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock);
-#define atomic_dec_and_raw_lock(atomic, lock) \
-		__cond_lock(lock, _atomic_dec_and_raw_lock(atomic, lock))
+extern int atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock) __cond_acquires(true, lock);
 
 extern int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
-					unsigned long *flags);
-#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) \
-		__cond_lock(lock, _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags)))
+					    unsigned long *flags) __cond_acquires(true, lock);
+#define atomic_dec_and_raw_lock_irqsave(atomic, lock, flags) _atomic_dec_and_raw_lock_irqsave(atomic, lock, &(flags))
 
 int __alloc_bucket_spinlocks(spinlock_t **locks, unsigned int *lock_mask,
 			     size_t max_size, unsigned int cpu_mult,
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index 7e7d7d373213..bda5e7a390cd 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -95,6 +95,26 @@ static inline int __raw_spin_trylock(raw_spinlock_t *lock)
 	return 0;
 }
 
+static __always_inline bool _raw_spin_trylock_irq(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	local_irq_disable();
+	if (_raw_spin_trylock(lock))
+		return true;
+	local_irq_enable();
+	return false;
+}
+
+static __always_inline bool _raw_spin_trylock_irqsave(raw_spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	local_irq_save(*flags);
+	if (_raw_spin_trylock(lock))
+		return true;
+	local_irq_restore(*flags);
+	return false;
+}
+
 /*
  * If lockdep is enabled then we use the non-preemption spin-ops
  * even on CONFIG_PREEMPTION, because lockdep assumes that interrupts are
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index 018f5aabc1be..a9d5c7c66e03 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -24,14 +24,11 @@
  * flags straight, to suppress compiler warnings of unused lock
  * variables, and to add the proper checker annotations:
  */
-#define ___LOCK_void(lock) \
-  do { (void)(lock); } while (0)
-
 #define ___LOCK_(lock) \
-  do { __acquire(lock); ___LOCK_void(lock); } while (0)
+  do { __acquire(lock); (void)(lock); } while (0)
 
 #define ___LOCK_shared(lock) \
-  do { __acquire_shared(lock); ___LOCK_void(lock); } while (0)
+  do { __acquire_shared(lock); (void)(lock); } while (0)
 
 #define __LOCK(lock, ...) \
   do { preempt_disable(); ___LOCK_##__VA_ARGS__(lock); } while (0)
@@ -78,10 +75,56 @@
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
 #define _raw_read_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags, shared)
 #define _raw_write_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
-#define _raw_spin_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_read_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_write_trylock(lock)			({ __LOCK(lock, void); 1; })
-#define _raw_spin_trylock_bh(lock)		({ __LOCK_BH(lock, void); 1; })
+
+static __always_inline int _raw_spin_trylock(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_bh(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK_BH(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_irq(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQ(lock);
+	return 1;
+}
+
+static __always_inline int _raw_spin_trylock_irqsave(raw_spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQSAVE(lock, *(flags));
+	return 1;
+}
+
+static __always_inline int _raw_read_trylock(rwlock_t *lock)
+	__cond_acquires_shared(true, lock)
+{
+	__LOCK(lock, shared);
+	return 1;
+}
+
+static __always_inline int _raw_write_trylock(rwlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK(lock);
+	return 1;
+}
+
+static __always_inline int _raw_write_trylock_irqsave(rwlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQSAVE(lock, *(flags));
+	return 1;
+}
+
 #define _raw_spin_unlock(lock)			__UNLOCK(lock)
 #define _raw_read_unlock(lock)			__UNLOCK(lock, shared)
 #define _raw_write_unlock(lock)			__UNLOCK(lock)
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 817a1e331cd1..348db067c318 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -37,8 +37,8 @@ extern void rt_spin_lock_nested(spinlock_t *lock, int subclass)	__acquires(lock)
 extern void rt_spin_lock_nest_lock(spinlock_t *lock, struct lockdep_map *nest_lock) __acquires(lock);
 extern void rt_spin_unlock(spinlock_t *lock)	__releases(lock);
 extern void rt_spin_lock_unlock(spinlock_t *lock);
-extern int rt_spin_trylock_bh(spinlock_t *lock);
-extern int rt_spin_trylock(spinlock_t *lock);
+extern int rt_spin_trylock_bh(spinlock_t *lock) __cond_acquires(true, lock);
+extern int rt_spin_trylock(spinlock_t *lock) __cond_acquires(true, lock);
 
 static __always_inline void spin_lock(spinlock_t *lock)
 	__acquires(lock)
@@ -130,21 +130,19 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 	rt_spin_unlock(lock);
 }
 
-#define spin_trylock(lock)				\
-	__cond_lock(lock, rt_spin_trylock(lock))
+#define spin_trylock(lock)	rt_spin_trylock(lock)
 
-#define spin_trylock_bh(lock)				\
-	__cond_lock(lock, rt_spin_trylock_bh(lock))
+#define spin_trylock_bh(lock)	rt_spin_trylock_bh(lock)
 
-#define spin_trylock_irq(lock)				\
-	__cond_lock(lock, rt_spin_trylock(lock))
+#define spin_trylock_irq(lock)	rt_spin_trylock(lock)
 
-#define spin_trylock_irqsave(lock, flags)		\
-	__cond_lock(lock, ({				\
-		typecheck(unsigned long, flags);	\
-		flags = 0;				\
-		rt_spin_trylock(lock);			\
-	}))
+static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned long *flags)
+	__cond_acquires(true, lock)
+{
+	*flags = 0;
+	return rt_spin_trylock(lock);
+}
+#define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flags))
 
 #define spin_is_contended(lock)		(((void)(lock), 0))
 
diff --git a/kernel/signal.c b/kernel/signal.c
index fe9190d84f28..9ff96a341e42 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1355,8 +1355,8 @@ int zap_other_threads(struct task_struct *p)
 	return count;
 }
 
-struct sighand_struct *__lock_task_sighand(struct task_struct *tsk,
-					   unsigned long *flags)
+struct sighand_struct *lock_task_sighand(struct task_struct *tsk,
+					 unsigned long *flags)
 {
 	struct sighand_struct *sighand;
 
diff --git a/kernel/time/posix-timers.c b/kernel/time/posix-timers.c
index 56e17b625c72..afb63b2cdc98 100644
--- a/kernel/time/posix-timers.c
+++ b/kernel/time/posix-timers.c
@@ -66,14 +66,7 @@ static const struct k_clock clock_realtime, clock_monotonic;
 #error "SIGEV_THREAD_ID must not share bit with other SIGEV values!"
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id);
-
-#define lock_timer(tid)							\
-({	struct k_itimer *__timr;					\
-	__cond_lock(&__timr->it_lock, __timr = __lock_timer(tid));	\
-	__timr;								\
-})
-
+static struct k_itimer *lock_timer(timer_t timer_id);
 static inline void unlock_timer(struct k_itimer *timr)
 {
 	if (likely((timr)))
@@ -85,7 +78,7 @@ static inline void unlock_timer(struct k_itimer *timr)
 
 #define scoped_timer				(scope)
 
-DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), __lock_timer(id), timer_t id);
+DEFINE_CLASS(lock_timer, struct k_itimer *, unlock_timer(_T), lock_timer(id), timer_t id);
 DEFINE_CLASS_IS_COND_GUARD(lock_timer);
 
 static struct timer_hash_bucket *hash_bucket(struct signal_struct *sig, unsigned int nr)
@@ -600,7 +593,7 @@ COMPAT_SYSCALL_DEFINE3(timer_create, clockid_t, which_clock,
 }
 #endif
 
-static struct k_itimer *__lock_timer(timer_t timer_id)
+static struct k_itimer *lock_timer(timer_t timer_id)
 {
 	struct k_itimer *timr;
 
diff --git a/lib/dec_and_lock.c b/lib/dec_and_lock.c
index 1dcca8f2e194..8c7c398fd770 100644
--- a/lib/dec_and_lock.c
+++ b/lib/dec_and_lock.c
@@ -18,7 +18,7 @@
  * because the spin-lock and the decrement must be
  * "atomic".
  */
-int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
+int atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 {
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
@@ -32,7 +32,7 @@ int _atomic_dec_and_lock(atomic_t *atomic, spinlock_t *lock)
 	return 0;
 }
 
-EXPORT_SYMBOL(_atomic_dec_and_lock);
+EXPORT_SYMBOL(atomic_dec_and_lock);
 
 int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
 				 unsigned long *flags)
@@ -50,7 +50,7 @@ int _atomic_dec_and_lock_irqsave(atomic_t *atomic, spinlock_t *lock,
 }
 EXPORT_SYMBOL(_atomic_dec_and_lock_irqsave);
 
-int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
+int atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
 {
 	/* Subtract 1 from counter unless that drops it to 0 (ie. it was 1) */
 	if (atomic_add_unless(atomic, -1, 1))
@@ -63,7 +63,7 @@ int _atomic_dec_and_raw_lock(atomic_t *atomic, raw_spinlock_t *lock)
 	raw_spin_unlock(lock);
 	return 0;
 }
-EXPORT_SYMBOL(_atomic_dec_and_raw_lock);
+EXPORT_SYMBOL(atomic_dec_and_raw_lock);
 
 int _atomic_dec_and_raw_lock_irqsave(atomic_t *atomic, raw_spinlock_t *lock,
 				     unsigned long *flags)
diff --git a/mm/memory.c b/mm/memory.c
index b59ae7ce42eb..1741953142e6 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -2215,8 +2215,8 @@ static pmd_t *walk_to_pmd(struct mm_struct *mm, unsigned long addr)
 	return pmd;
 }
 
-pte_t *__get_locked_pte(struct mm_struct *mm, unsigned long addr,
-			spinlock_t **ptl)
+pte_t *get_locked_pte(struct mm_struct *mm, unsigned long addr,
+		      spinlock_t **ptl)
 {
 	pmd_t *pmd = walk_to_pmd(mm, addr);
 
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index 567e2d084071..808f18d68279 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -278,7 +278,7 @@ static unsigned long pmdp_get_lockless_start(void) { return 0; }
 static void pmdp_get_lockless_end(unsigned long irqflags) { }
 #endif
 
-pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
+pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp)
 {
 	unsigned long irqflags;
 	pmd_t pmdval;
@@ -330,13 +330,12 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
 }
 
 /*
- * pte_offset_map_lock(mm, pmd, addr, ptlp), and its internal implementation
- * __pte_offset_map_lock() below, is usually called with the pmd pointer for
- * addr, reached by walking down the mm's pgd, p4d, pud for addr: either while
- * holding mmap_lock or vma lock for read or for write; or in truncate or rmap
- * context, while holding file's i_mmap_lock or anon_vma lock for read (or for
- * write). In a few cases, it may be used with pmd pointing to a pmd_t already
- * copied to or constructed on the stack.
+ * pte_offset_map_lock(mm, pmd, addr, ptlp) is usually called with the pmd
+ * pointer for addr, reached by walking down the mm's pgd, p4d, pud for addr:
+ * either while holding mmap_lock or vma lock for read or for write; or in
+ * truncate or rmap context, while holding file's i_mmap_lock or anon_vma lock
+ * for read (or for write). In a few cases, it may be used with pmd pointing to
+ * a pmd_t already copied to or constructed on the stack.
  *
  * When successful, it returns the pte pointer for addr, with its page table
  * kmapped if necessary (when CONFIG_HIGHPTE), and locked against concurrent
@@ -387,8 +386,8 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
  * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
  * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
  */
-pte_t *__pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
-			     unsigned long addr, spinlock_t **ptlp)
+pte_t *pte_offset_map_lock(struct mm_struct *mm, pmd_t *pmd,
+			   unsigned long addr, spinlock_t **ptlp)
 {
 	spinlock_t *ptl;
 	pmd_t pmdval;
diff --git a/tools/include/linux/compiler_types.h b/tools/include/linux/compiler_types.h
index d09f9dc172a4..067a5b4e0f7b 100644
--- a/tools/include/linux/compiler_types.h
+++ b/tools/include/linux/compiler_types.h
@@ -20,7 +20,6 @@
 # define __releases(x)	__attribute__((context(x,1,0)))
 # define __acquire(x)	__context__(x,1)
 # define __release(x)	__context__(x,-1)
-# define __cond_lock(x,c)	((c) ? ({ __acquire(x); 1; }) : 0)
 #else /* __CHECKER__ */
 /* context/locking */
 # define __must_hold(x)
@@ -28,7 +27,6 @@
 # define __releases(x)
 # define __acquire(x)	(void)0
 # define __release(x)	(void)0
-# define __cond_lock(x,c) (c)
 #endif /* __CHECKER__ */
 
 /* Compiler specific macros. */
-- 
2.52.0.rc1.455.g30608eb744-goog


