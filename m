Return-Path: <linux-wireless+bounces-34582-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WB4mBMjr2GlGjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34582-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:23:36 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B373D6E27
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 155283074CD9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:19:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47BB3C73E3;
	Fri, 10 Apr 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LfuXj06c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B9A3BD64E;
	Fri, 10 Apr 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823536; cv=none; b=W1Qr3EFm5UGIa8+7VGnvp+jyjq5XcRJmCSUT3OjmmaLcA7t1LGusJKtmdnEL/coTVvLqd3A/QvbHhvQsPsfRtj/zh3JZIdy7/4XefjCy31AB/F81YjtOBJ6DotylwWSk35xFRGUR1yM2OPQVL8rYqSxiBeNYBpEqT3colElxGSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823536; c=relaxed/simple;
	bh=5QVlF6IfS2lfQjmpis0ghbno4R+SPdTSC+UKXWlrbwM=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=s+jMIW8X6tv3SR24xiHvCQIVb+RnsoalvkJ5hSvifaCBT8VZmF5FUBosC33gZrsItSzgWWQzimEbjDTQCv95E7wfNws8fbCoRG/BlSh6MBYeikgyplc/qkgUluYJSbGi638+SpUIAfpx4JK2ZRDii0yvyWjFuyfqNtBrQQPIL98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LfuXj06c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2ABB2C2BCB0;
	Fri, 10 Apr 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823536;
	bh=5QVlF6IfS2lfQjmpis0ghbno4R+SPdTSC+UKXWlrbwM=;
	h=Date:From:To:Subject:References:cc:From;
	b=LfuXj06c5pJdrLIRQZOGGUnvC0/7H7T958xB88dpTHpJCnzTPWKuOvuVXAdy6Ak37
	 q3NsmsuJzmcCS4AtrQC6BBqMKLBV6i7NYvY31kVUwAJ1fUk5DiH1UvcZhqx6Zvfgxu
	 CGnnZL59E7B5pPEKoSA2vv7lFrz68ryBNvlt7/he9gTUf+7cGk/WAoXUpUjNZe0UmE
	 dP1W1cGxClFkhCm5BU3vACeJkyoHuX3oJ0uOmck90IwaQnQkpQKPURmYasy2VBvUvQ
	 oOQV5XFs6UHn87rkBmH0n2LYh6YtwROpX/B/rCdI1TFAoh7Z5miPuEptvyhsFFD5GH
	 nRoQ9tRI1uYXg==
Date: Fri, 10 Apr 2026 14:18:52 +0200
Message-ID: <20260410120317.910770161@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 05/38] treewide: Remove CLOCK_TICK_RATE
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34582-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[synopsys.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C0B373D6E27
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This has been scheduled for removal more than a decade ago and the comments
related to it have been dutifully ignored. The last dependencies are gone.

Remove it along with various now empty asm/timex.h files.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/alpha/include/asm/timex.h      |    4 ----
 arch/arc/include/asm/timex.h        |   15 ---------------
 arch/arm/mach-omap1/Kconfig         |    2 +-
 arch/hexagon/include/asm/timex.h    |    3 ---
 arch/m68k/include/asm/timex.h       |   15 ---------------
 arch/microblaze/include/asm/timex.h |   13 -------------
 arch/mips/include/asm/timex.h       |    8 --------
 arch/openrisc/include/asm/timex.h   |    3 ---
 arch/parisc/include/asm/timex.h     |    2 --
 arch/powerpc/include/asm/timex.h    |    2 --
 arch/s390/include/asm/timex.h       |    2 --
 arch/sh/include/asm/timex.h         |   24 ------------------------
 arch/sparc/include/asm/timex.h      |    2 +-
 arch/sparc/include/asm/timex_32.h   |   14 --------------
 arch/sparc/include/asm/timex_64.h   |    2 --
 arch/um/include/asm/timex.h         |    9 ---------
 arch/x86/include/asm/timex.h        |    3 ---
 17 files changed, 2 insertions(+), 121 deletions(-)

--- a/arch/alpha/include/asm/timex.h
+++ b/arch/alpha/include/asm/timex.h
@@ -7,10 +7,6 @@
 #ifndef _ASMALPHA_TIMEX_H
 #define _ASMALPHA_TIMEX_H
 
-/* With only one or two oddballs, we use the RTC as the ticker, selecting
-   the 32.768kHz reference clock, which nicely divides down to our HZ.  */
-#define CLOCK_TICK_RATE	32768
-
 /*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
--- a/arch/arc/include/asm/timex.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2004, 2007-2010, 2011-2012 Synopsys, Inc. (www.synopsys.com)
- */
-
-#ifndef _ASM_ARC_TIMEX_H
-#define _ASM_ARC_TIMEX_H
-
-#define CLOCK_TICK_RATE	80000000 /* slated to be removed */
-
-#include <asm-generic/timex.h>
-
-/* XXX: get_cycles() to be implemented with RTSC insn */
-
-#endif /* _ASM_ARC_TIMEX_H */
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -74,7 +74,7 @@ config OMAP_32K_TIMER
 	  currently only available for OMAP16XX, 24XX, 34XX, OMAP4/5 and DRA7XX.
 
 	  On OMAP2PLUS this value is only used for CONFIG_HZ and
-	  CLOCK_TICK_RATE compile time calculation.
+	  timer frequency compile time calculation.
 	  The actual timer selection is done in the board file
 	  through the (DT_)MACHINE_START structure.
 
--- a/arch/hexagon/include/asm/timex.h
+++ b/arch/hexagon/include/asm/timex.h
@@ -9,9 +9,6 @@
 #include <asm-generic/timex.h>
 #include <asm/hexagon_vm.h>
 
-/* Using TCX0 as our clock.  CLOCK_TICK_RATE scheduled to be removed. */
-#define CLOCK_TICK_RATE              19200
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 static inline int read_current_timer(unsigned long *timer_val)
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -7,21 +7,6 @@
 #ifndef _ASMm68K_TIMEX_H
 #define _ASMm68K_TIMEX_H
 
-#ifdef CONFIG_COLDFIRE
-/*
- * CLOCK_TICK_RATE should give the underlying frequency of the tick timer
- * to make ntp work best.  For Coldfires, that's the main clock.
- */
-#include <asm/coldfire.h>
-#define CLOCK_TICK_RATE	MCF_CLK
-#else
-/*
- * This default CLOCK_TICK_RATE is probably wrong for many 68k boards
- * Users of those boards will need to check and modify accordingly
- */
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-#endif
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/microblaze/include/asm/timex.h
+++ /dev/null
@@ -1,13 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * Copyright (C) 2006 Atmark Techno, Inc.
- */
-
-#ifndef _ASM_MICROBLAZE_TIMEX_H
-#define _ASM_MICROBLAZE_TIMEX_H
-
-#include <asm-generic/timex.h>
-
-#define CLOCK_TICK_RATE 1000 /* Timer input freq. */
-
-#endif /* _ASM_TIMEX_H */
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -19,14 +19,6 @@
 #include <asm/cpu-type.h>
 
 /*
- * This is the clock rate of the i8253 PIT.  A MIPS system may not have
- * a PIT by the symbol is used all over the kernel including some APIs.
- * So keeping it defined to the number for the PIT is the only sane thing
- * for now.
- */
-#define CLOCK_TICK_RATE 1193182
-
-/*
  * Standard way to access the cycle counter.
  * Currently only used on SMP for scheduling.
  *
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -25,9 +25,6 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-/* This isn't really used any more */
-#define CLOCK_TICK_RATE 1000
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -9,8 +9,6 @@
 
 #include <asm/special_insns.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -11,8 +11,6 @@
 #include <asm/cputable.h>
 #include <asm/vdso/timebase.h>
 
-#define CLOCK_TICK_RATE	1024000 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static inline cycles_t get_cycles(void)
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -177,8 +177,6 @@ static inline void local_tick_enable(uns
 	set_clock_comparator(get_lowcore()->clock_comparator);
 }
 
-#define CLOCK_TICK_RATE		1193180 /* Underlying HZ */
-
 typedef unsigned long cycles_t;
 
 static __always_inline unsigned long get_tod_clock(void)
--- a/arch/sh/include/asm/timex.h
+++ /dev/null
@@ -1,24 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm-sh/timex.h
- *
- * sh architecture timex specifications
- */
-#ifndef __ASM_SH_TIMEX_H
-#define __ASM_SH_TIMEX_H
-
-/*
- * Only parts using the legacy CPG code for their clock framework
- * implementation need to define their own Pclk value. If provided, this
- * can be used for accurately setting CLOCK_TICK_RATE, otherwise we
- * simply fall back on the i8253 PIT value.
- */
-#ifdef CONFIG_SH_PCLK_FREQ
-#define CLOCK_TICK_RATE		(CONFIG_SH_PCLK_FREQ / 4) /* Underlying HZ */
-#else
-#define CLOCK_TICK_RATE		1193180
-#endif
-
-#include <asm-generic/timex.h>
-
-#endif /* __ASM_SH_TIMEX_H */
--- a/arch/sparc/include/asm/timex.h
+++ b/arch/sparc/include/asm/timex.h
@@ -4,6 +4,6 @@
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/timex_64.h>
 #else
-#include <asm/timex_32.h>
+#include <asm-generic/timex.h>
 #endif
 #endif
--- a/arch/sparc/include/asm/timex_32.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm/timex.h
- *
- * sparc architecture timex specifications
- */
-#ifndef _ASMsparc_TIMEX_H
-#define _ASMsparc_TIMEX_H
-
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
-#include <asm-generic/timex.h>
-
-#endif
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -9,8 +9,6 @@
 
 #include <asm/timer.h>
 
-#define CLOCK_TICK_RATE	1193180 /* Underlying HZ */
-
 /* Getting on the cycle counter on sparc64. */
 typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
--- a/arch/um/include/asm/timex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __UM_TIMEX_H
-#define __UM_TIMEX_H
-
-#define CLOCK_TICK_RATE (HZ)
-
-#include <asm-generic/timex.h>
-
-#endif
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -14,9 +14,6 @@ static inline unsigned long random_get_e
 }
 #define random_get_entropy random_get_entropy
 
-/* Assume we use the PIT time source for the clock tick */
-#define CLOCK_TICK_RATE		PIT_TICK_RATE
-
 #define ARCH_HAS_READ_CURRENT_TIMER
 
 #endif /* _ASM_X86_TIMEX_H */


