Return-Path: <linux-wireless+bounces-34605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCbXNyTw2GnrjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:42:12 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 391233D7848
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E34C53075032
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D3CA3DE451;
	Fri, 10 Apr 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e2TX+7hq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630EF3C5550;
	Fri, 10 Apr 2026 12:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823648; cv=none; b=bTFDZtI8i58c22GB7ZrRDbexW7De0cGka7T6cZ37WG+VG3LDigvctN96ERTHK0o5PnosNRvxJfUtRiq1Ukz0nRpyGwJ6Jd1PDSznPEdZ42UxoCKcRHx+Y4NguAAYyMxBBLZKjH7aMsvZ6QzkVPxixCAwB7Os1V74iAhmYcV1Srw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823648; c=relaxed/simple;
	bh=Rixu9UkxBpBa/pCcYjAm91Mos3e7PJEWty4VuN8Giko=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=R6q77D8xnCvZgJUekh19PkL3f1qAfRHkUeGlQkxTqUSaySS9Fe871v6lDDLZQqWbltMIQ7l9X5dWK0/0PGSjzvZE3a8js4pFgnI3sBxgKj6yCtKoRq6GrUeQExtya0BgJCkWB94pKKl7zRsvWfVLqr6yuLNd2UMvrvqvJKzCB2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e2TX+7hq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9315FC19425;
	Fri, 10 Apr 2026 12:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823648;
	bh=Rixu9UkxBpBa/pCcYjAm91Mos3e7PJEWty4VuN8Giko=;
	h=Date:From:To:Subject:References:cc:From;
	b=e2TX+7hqQyBiWzo8NI5NRXrCTX+aQLO1om6YbdKnBp1t6r+3gdVVwFgSRp0YguQNn
	 Jlc+qQUu+TDLRhNxs0vDUgKc/64bw4Xr/nrLXGcr9x8N+WxcYYAWKz/hetumLTTXiH
	 IOZQe6vf3JeallzAbQOuDlVku9VS3q2KBCLecHsxJ+DIPpUILukw8IDg9/7PZ2ubbz
	 C8W0nQsdyxy0TL4ubCO16dsYj5itsv1q3iQDjbYKDrJAHUzFBqI36jq5cjES+sc4w7
	 L7ELcmmojjtISrbWTN6OaCnE72An4bb94Nrrp4eO37cDQXx+zCdhzTRuhaN3nbGiT3
	 axWFURoe64Leg==
Date: Fri, 10 Apr 2026 14:20:45 +0200
Message-ID: <20260410120319.462206386@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 28/38] mips: Select ARCH_HAS_RANDOM_ENTROPY
References: <20260410120044.031381086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
cc: Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org,
 Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org,
 Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org,
 David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>,
 linux-fbdev@vger.kernel.org,
 "Theodore Tso" <tytso@mit.edu>,
 linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>,
 Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>,
 linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org,
 Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org,
 Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org,
 Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34605-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_TWELVE(0.00)[48];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 391233D7848
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining usage of get_cycles() is to provide random_get_entropy().

Switch mips over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

As a consequence this unearthed a nasty include dependency hell because
arbitrary code relies on a magic include of asm/timex.h. Including the
headers in asm/random.h turned out to be impossible as well.

The only solution for now is to uninline random_get_entropy().  Fix up all
other dependencies on the content of asm/timex.h in those files which
really depend on it.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/mips/Kconfig              |    1 
 arch/mips/generic/init.c       |    1 
 arch/mips/include/asm/random.h |    7 +++
 arch/mips/include/asm/timex.h  |   92 -----------------------------------------
 arch/mips/kernel/pm-cps.c      |    1 
 arch/mips/kernel/proc.c        |    1 
 arch/mips/kernel/relocate.c    |    1 
 arch/mips/kernel/time.c        |   53 +++++++++++++++++++++++
 arch/mips/lib/dump_tlb.c       |    1 
 arch/mips/mm/cache.c           |    1 
 10 files changed, 66 insertions(+), 93 deletions(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -19,6 +19,7 @@ config MIPS
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
 	select ARCH_HAS_GCOV_PROFILE_ALL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_KEEP_MEMBLOCK
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
--- a/arch/mips/generic/init.c
+++ b/arch/mips/generic/init.c
@@ -12,6 +12,7 @@
 #include <linux/of_fdt.h>
 
 #include <asm/bootinfo.h>
+#include <asm/cpu-type.h>
 #include <asm/fw/fw.h>
 #include <asm/irq_cpu.h>
 #include <asm/machine.h>
--- /dev/null
+++ b/arch/mips/include/asm/random.h
@@ -0,0 +1,7 @@
+/* SPDX-License-Identifier: GPL-v2.0-only */
+#ifndef _ASM_RANDOM_H
+#define _ASM_RANDOM_H
+
+unsigned long random_get_entropy(void);
+
+#endif /*  _ASM_RANDOM_H */
--- a/arch/mips/include/asm/timex.h
+++ /dev/null
@@ -1,92 +0,0 @@
-/*
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file "COPYING" in the main directory of this archive
- * for more details.
- *
- * Copyright (C) 1998, 1999, 2003 by Ralf Baechle
- * Copyright (C) 2014 by Maciej W. Rozycki
- */
-#ifndef _ASM_TIMEX_H
-#define _ASM_TIMEX_H
-
-#ifdef __KERNEL__
-
-#include <linux/compiler.h>
-
-#include <asm/cpu.h>
-#include <asm/cpu-features.h>
-#include <asm/mipsregs.h>
-#include <asm/cpu-type.h>
-
-/*
- * Standard way to access the cycle counter.
- * Currently only used on SMP for scheduling.
- *
- * Only the low 32 bits are available as a continuously counting entity.
- * But this only means we'll force a reschedule every 8 seconds or so,
- * which isn't an evil thing.
- *
- * We know that all SMP capable CPUs have cycle counters.
- */
-
-/*
- * On R4000/R4400 an erratum exists such that if the cycle counter is
- * read in the exact moment that it is matching the compare register,
- * no interrupt will be generated.
- *
- * There is a suggested workaround and also the erratum can't strike if
- * the compare interrupt isn't being used as the clock source device.
- * However for now the implementation of this function doesn't get these
- * fine details right.
- */
-static inline int can_use_mips_counter(unsigned int prid)
-{
-	int comp = (prid & PRID_COMP_MASK) != PRID_COMP_LEGACY;
-
-	if (__builtin_constant_p(cpu_has_counter) && !cpu_has_counter)
-		return 0;
-	else if (__builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r)
-		return 1;
-	else if (likely(!__builtin_constant_p(cpu_has_mips_r) && comp))
-		return 1;
-	/* Make sure we don't peek at cpu_data[0].options in the fast path! */
-	if (!__builtin_constant_p(cpu_has_counter))
-		asm volatile("" : "=m" (cpu_data[0].options));
-	if (likely(cpu_has_counter &&
-		   prid > (PRID_IMP_R4000 | PRID_REV_ENCODE_44(15, 15))))
-		return 1;
-	else
-		return 0;
-}
-
-static inline cycles_t get_cycles(void)
-{
-	if (can_use_mips_counter(read_c0_prid()))
-		return read_c0_count();
-	else
-		return 0;	/* no usable counter */
-}
-#define get_cycles get_cycles
-
-/*
- * Like get_cycles - but where c0_count is not available we desperately
- * use c0_random in an attempt to get at least a little bit of entropy.
- */
-static inline unsigned long random_get_entropy(void)
-{
-	unsigned int c0_random;
-
-	if (can_use_mips_counter(read_c0_prid()))
-		return read_c0_count();
-
-	if (cpu_has_3kex)
-		c0_random = (read_c0_random() >> 8) & 0x3f;
-	else
-		c0_random = read_c0_random() & 0x3f;
-	return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
-}
-#define random_get_entropy random_get_entropy
-
-#endif /* __KERNEL__ */
-
-#endif /*  _ASM_TIMEX_H */
--- a/arch/mips/kernel/pm-cps.c
+++ b/arch/mips/kernel/pm-cps.c
@@ -13,6 +13,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/cacheflush.h>
 #include <asm/cacheops.h>
+#include <asm/cpu-type.h>
 #include <asm/idle.h>
 #include <asm/mips-cps.h>
 #include <asm/mipsmtregs.h>
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -11,6 +11,7 @@
 #include <asm/bootinfo.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/idle.h>
 #include <asm/mipsregs.h>
 #include <asm/processor.h>
--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -13,7 +13,6 @@
 #include <asm/fw/fw.h>
 #include <asm/sections.h>
 #include <asm/setup.h>
-#include <asm/timex.h>
 #include <linux/elf.h>
 #include <linux/kernel.h>
 #include <linux/libfdt.h>
--- a/arch/mips/kernel/time.c
+++ b/arch/mips/kernel/time.c
@@ -2,6 +2,7 @@
 /*
  * Copyright 2001 MontaVista Software Inc.
  * Author: Jun Sun, jsun@mvista.com or jsun@junsun.net
+ * Copyright (C) 1998, 1999, 2003 by Ralf Baechle
  * Copyright (c) 2003, 2004  Maciej W. Rozycki
  *
  * Common time service routines for MIPS machines.
@@ -21,9 +22,12 @@
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 
+#include <asm/cpu.h>
 #include <asm/cpu-features.h>
 #include <asm/cpu-type.h>
 #include <asm/div64.h>
+#include <asm/mipsregs.h>
+#include <asm/random.h>
 #include <asm/time.h>
 
 #ifdef CONFIG_CPU_FREQ
@@ -150,6 +154,55 @@ static __init int cpu_has_mfc0_count_bug
 	return 0;
 }
 
+
+/*
+ * On R4000/R4400 an erratum exists such that if the cycle counter is
+ * read in the exact moment that it is matching the compare register,
+ * no interrupt will be generated.
+ *
+ * There is a suggested workaround and also the erratum can't strike if
+ * the compare interrupt isn't being used as the clock source device.
+ * However for now the implementation of this function doesn't get these
+ * fine details right.
+ */
+static inline int can_use_mips_counter(unsigned int prid)
+{
+	int comp = (prid & PRID_COMP_MASK) != PRID_COMP_LEGACY;
+
+	if (__builtin_constant_p(cpu_has_counter) && !cpu_has_counter)
+		return 0;
+	else if (__builtin_constant_p(cpu_has_mips_r) && cpu_has_mips_r)
+		return 1;
+	else if (likely(!__builtin_constant_p(cpu_has_mips_r) && comp))
+		return 1;
+	/* Make sure we don't peek at cpu_data[0].options in the fast path! */
+	if (!__builtin_constant_p(cpu_has_counter))
+		asm volatile("" : "=m" (cpu_data[0].options));
+	if (likely(cpu_has_counter &&
+		   prid > (PRID_IMP_R4000 | PRID_REV_ENCODE_44(15, 15))))
+		return 1;
+	else
+		return 0;
+}
+
+/*
+ * Like get_cycles - but where c0_count is not available we desperately
+ * use c0_random in an attempt to get at least a little bit of entropy.
+ */
+unsigned long random_get_entropy(void)
+{
+	unsigned int c0_random;
+
+	if (can_use_mips_counter(read_c0_prid()))
+		return read_c0_count();
+
+	if (cpu_has_3kex)
+		c0_random = (read_c0_random() >> 8) & 0x3f;
+	else
+		c0_random = read_c0_random() & 0x3f;
+	return (random_get_entropy_fallback() << 6) | (0x3f - c0_random);
+}
+
 void __init time_init(void)
 {
 	plat_time_init();
--- a/arch/mips/lib/dump_tlb.c
+++ b/arch/mips/lib/dump_tlb.c
@@ -8,6 +8,7 @@
 #include <linux/kernel.h>
 #include <linux/mm.h>
 
+#include <asm/cpu-type.h>
 #include <asm/hazards.h>
 #include <asm/mipsregs.h>
 #include <asm/mmu_context.h>
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -22,6 +22,7 @@
 #include <asm/processor.h>
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
+#include <asm/cpu-type.h>
 #include <asm/setup.h>
 #include <asm/pgtable.h>
 


