Return-Path: <linux-wireless+bounces-34583-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEU+JV3r2GkFjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34583-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:21:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BFAA3D6CFA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B18CA3046FEB
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B38F73C943E;
	Fri, 10 Apr 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QXjWZmAy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86AC33BD64E;
	Fri, 10 Apr 2026 12:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823541; cv=none; b=Px7ny0ZNfiwxgo5HylHhqUqUuKw83r7is4ajUBW88OefDmadycMe1lMwz5t83SLtP78ThyF58bPPDiTOejddXP/WqIyrHMMCZfVp44/vB+IlrjgXzZ0czeuWfU9E+VxfQA1uhQxR2+uw/PcpUZ5lxByyTIr4gsyZ2Hh9Jbp7F6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823541; c=relaxed/simple;
	bh=tQOpQ/MIydS0DCislclXfYYGX/MLE87s4jSCgeL+WRY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=pDOilWArj3eB0SkYqjcthTQDUOBVBAXinuRPbsCLaqu0pNIYtd1vQDlERI6iqYlAWSLO02AWwo0qJAo+XcA6ZSezmKAUScm0HJCV8UFQd26RAhHU6z9wwO4n7EvS/gJZgOSYXMwx2PwQRY71LrXXq3f2huIgdg9OJ6O6cH0qA90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QXjWZmAy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90115C19425;
	Fri, 10 Apr 2026 12:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823541;
	bh=tQOpQ/MIydS0DCislclXfYYGX/MLE87s4jSCgeL+WRY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=QXjWZmAyCTkHp5kfenmZQLgv/6aaV3rIg6DEVvlyBDoQvhTKTRyPfm45H+KsvdAYy
	 VHZ0mkxMvX7NrAkZvm3k49raaKd2C+9wSQwjJDY1g6mCI0csX9QiI7H4JXm3HNueX3
	 EOv1ltqGraI125ajQJZTWidJZvX+BaYkMhFhYKyP7KvvAlz25RxVHq+2fEWi/RQGR8
	 Hcehq8u7DgPSnaFiQzuBhfPrBLqOhc8OPmg3byOKx6qYpgk7RPMNSknmgg5KdEM/9q
	 gq5iGE6+JxvJ8JrvjFxV3K0ttPe/RN2jOy+C/nJannjRPpT1rSSYryTOpfiapdmnXH
	 zppEqqCxX8IxA==
Date: Fri, 10 Apr 2026 14:18:57 +0200
Message-ID: <20260410120317.978403520@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
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
Subject: [patch 06/38] calibrate: Rework delay timer calibration
References: <20260410120044.031381086@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34583-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: 3BFAA3D6CFA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The header define in asm/timex,h and the naming of the function to read the
delay timer are confusing at best.

Convert it to a config switch selected by the archictures, which provide
the functionality, and rename the function to delay_read_timer(), which
makes the purpose clear. Move the declaration to linux/delay.h where it
belongs.

Remove the resulting empty asm/timex.h files as well.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/Kconfig                      |    3 +++
 arch/arm/Kconfig                  |    1 +
 arch/arm/include/asm/delay.h      |    1 -
 arch/arm/include/asm/timex.h      |    5 ++++-
 arch/arm/lib/delay.c              |   10 ++++------
 arch/hexagon/Kconfig              |    1 +
 arch/hexagon/include/asm/timex.h  |   20 --------------------
 arch/hexagon/kernel/time.c        |    8 +++++++-
 arch/openrisc/Kconfig             |    1 +
 arch/openrisc/include/asm/timex.h |    2 --
 arch/openrisc/lib/delay.c         |    9 ++++-----
 arch/riscv/Kconfig                |    1 +
 arch/riscv/include/asm/timex.h    |    8 --------
 arch/riscv/lib/delay.c            |    7 ++++++-
 arch/sparc/Kconfig                |    1 +
 arch/sparc/include/asm/timex_64.h |    2 --
 arch/sparc/kernel/time_64.c       |    4 ++--
 arch/x86/Kconfig                  |    1 +
 arch/x86/include/asm/timex.h      |    2 --
 arch/x86/lib/delay.c              |    8 +++-----
 include/asm-generic/timex.h       |    7 -------
 include/linux/delay.h             |    2 ++
 include/linux/timex.h             |    2 --
 init/calibrate.c                  |   19 +++++++++----------
 24 files changed, 50 insertions(+), 75 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -363,6 +363,9 @@ config ARCH_HAS_DMA_CLEAR_UNCACHED
 config ARCH_HAS_CPU_FINALIZE_INIT
 	bool
 
+config ARCH_HAS_DELAY_TIMER
+	bool
+
 # The architecture has a per-task state that includes the mm's PASID
 config ARCH_HAS_CPU_PASID
 	bool
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -11,6 +11,7 @@ config ARM
 	select ARCH_HAS_CPU_FINALIZE_INIT if MMU
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
+	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_DMA_ALLOC if MMU
 	select ARCH_HAS_DMA_OPS
 	select ARCH_HAS_DMA_WRITE_COMBINE if !ARM_DMA_MEM_BUFFERABLE
--- a/arch/arm/include/asm/delay.h
+++ b/arch/arm/include/asm/delay.h
@@ -91,7 +91,6 @@ extern void __loop_udelay(unsigned long
 extern void __loop_const_udelay(unsigned long);
 
 /* Delay-loop timer registration. */
-#define ARCH_HAS_READ_CURRENT_TIMER
 extern void register_current_timer_delay(const struct delay_timer *timer);
 
 #endif /* __ASSEMBLY__ */
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -10,7 +10,10 @@
 #define _ASMARM_TIMEX_H
 
 typedef unsigned long cycles_t;
-#define get_cycles()	({ cycles_t c; read_current_timer(&c) ? 0 : c; })
+// Temporary workaround
+bool delay_read_timer(unsigned long *t);
+
+#define get_cycles()	({ cycles_t c; delay_read_timer(&c) ? 0 : c; })
 #define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
 
 #endif
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -12,7 +12,6 @@
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
-#include <linux/timex.h>
 
 /*
  * Default to the loop-based delay implementation.
@@ -27,15 +26,14 @@ static const struct delay_timer *delay_t
 static bool delay_calibrated;
 static u64 delay_res;
 
-int read_current_timer(unsigned long *timer_val)
+bool delay_read_timer(unsigned long *timer_val)
 {
 	if (!delay_timer)
-		return -ENXIO;
-
+		return false;
 	*timer_val = delay_timer->read_current_timer();
-	return 0;
+	return true;
 }
-EXPORT_SYMBOL_GPL(read_current_timer);
+EXPORT_SYMBOL_GPL(delay_read_timer);
 
 static inline u64 cyc_to_ns(u64 cyc, u32 mult, u32 shift)
 {
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -5,6 +5,7 @@ comment "Linux Kernel Configuration for
 config HEXAGON
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_NO_PREEMPT
 	select ARCH_WANT_FRAME_POINTERS
--- a/arch/hexagon/include/asm/timex.h
+++ /dev/null
@@ -1,20 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (c) 2010-2011, The Linux Foundation. All rights reserved.
- */
-
-#ifndef _ASM_TIMEX_H
-#define _ASM_TIMEX_H
-
-#include <asm-generic/timex.h>
-#include <asm/hexagon_vm.h>
-
-#define ARCH_HAS_READ_CURRENT_TIMER
-
-static inline int read_current_timer(unsigned long *timer_val)
-{
-	*timer_val = __vmgettime();
-	return 0;
-}
-
-#endif
--- a/arch/hexagon/kernel/time.c
+++ b/arch/hexagon/kernel/time.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/init.h>
+#include <linux/delay.h>
 #include <linux/clockchips.h>
 #include <linux/clocksource.h>
 #include <linux/interrupt.h>
@@ -17,7 +18,6 @@
 #include <linux/of_irq.h>
 #include <linux/module.h>
 
-#include <asm/delay.h>
 #include <asm/hexagon_vm.h>
 #include <asm/time.h>
 
@@ -231,3 +231,9 @@ void __udelay(unsigned long usecs)
 		cpu_relax(); /*  not sure how this improves readability  */
 }
 EXPORT_SYMBOL(__udelay);
+
+bool delay_read_timer(unsigned long *timer_val)
+{
+	*timer_val = __vmgettime();
+	return true;
+}
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -7,6 +7,7 @@
 config OPENRISC
 	def_bool y
 	select ARCH_32BIT_OFF_T
+	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_DMA_SET_UNCACHED
 	select ARCH_HAS_DMA_CLEAR_UNCACHED
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
--- a/arch/openrisc/include/asm/timex.h
+++ b/arch/openrisc/include/asm/timex.h
@@ -25,6 +25,4 @@ static inline cycles_t get_cycles(void)
 }
 #define get_cycles get_cycles
 
-#define ARCH_HAS_READ_CURRENT_TIMER
-
 #endif
--- a/arch/openrisc/lib/delay.c
+++ b/arch/openrisc/lib/delay.c
@@ -13,18 +13,17 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/delay.h>
 #include <linux/export.h>
 #include <linux/init.h>
-#include <linux/timex.h>
+
 #include <asm/param.h>
-#include <asm/delay.h>
-#include <asm/timex.h>
 #include <asm/processor.h>
 
-int read_current_timer(unsigned long *timer_value)
+bool delay_read_timer(unsigned long *timer_value)
 {
 	*timer_value = get_cycles();
-	return 0;
+	return true;
 }
 
 void __delay(unsigned long cycles)
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -29,6 +29,7 @@ config RISCV
 	select ARCH_HAS_DEBUG_VIRTUAL if MMU
 	select ARCH_HAS_DEBUG_VM_PGTABLE
 	select ARCH_HAS_DEBUG_WX
+	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_ELF_CORE_EFLAGS if BINFMT_ELF && ELF_CORE
 	select ARCH_HAS_FAST_MULTIPLIER
 	select ARCH_HAS_FORTIFY_SOURCE
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -80,12 +80,4 @@ static inline u64 get_cycles64(void)
 	return ((u64)hi << 32) | lo;
 }
 #endif /* CONFIG_64BIT */
-
-#define ARCH_HAS_READ_CURRENT_TIMER
-static inline int read_current_timer(unsigned long *timer_val)
-{
-	*timer_val = get_cycles();
-	return 0;
-}
-
 #endif /* _ASM_RISCV_TIMEX_H */
--- a/arch/riscv/lib/delay.c
+++ b/arch/riscv/lib/delay.c
@@ -6,7 +6,6 @@
 #include <linux/delay.h>
 #include <linux/math.h>
 #include <linux/param.h>
-#include <linux/timex.h>
 #include <linux/types.h>
 #include <linux/export.h>
 
@@ -109,3 +108,9 @@ void ndelay(unsigned long nsecs)
 	__delay(ncycles >> NDELAY_SHIFT);
 }
 EXPORT_SYMBOL(ndelay);
+
+bool delay_read_timer(unsigned long *timer_val)
+{
+	*timer_val = get_cycles();
+	return true;
+}
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -70,6 +70,7 @@ config SPARC32
 config SPARC64
 	def_bool 64BIT
 	select ALTERNATE_USER_ADDRESS_SPACE
+	select ARCH_HAS_DELAY_TIMER
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -13,6 +13,4 @@
 typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
 
-#define ARCH_HAS_READ_CURRENT_TIMER
-
 #endif
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -894,8 +894,8 @@ unsigned long long sched_clock(void)
 	return ((get_tick() * quotient) >> SPARC64_NSEC_PER_CYC_SHIFT) - offset;
 }
 
-int read_current_timer(unsigned long *timer_val)
+bool delay_read_timer(unsigned long *timer_val)
 {
 	*timer_val = get_tick();
-	return 0;
+	return true;
 }
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -81,6 +81,7 @@ config X86
 	select ARCH_HAS_CURRENT_STACK_POINTER
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
+	select ARCH_HAS_DELAY_TIMER
 	select ARCH_HAS_DEVMEM_IS_ALLOWED
 	select ARCH_HAS_DMA_OPS			if GART_IOMMU || XEN
 	select ARCH_HAS_EARLY_DEBUG		if KGDB
--- a/arch/x86/include/asm/timex.h
+++ b/arch/x86/include/asm/timex.h
@@ -14,6 +14,4 @@ static inline unsigned long random_get_e
 }
 #define random_get_entropy random_get_entropy
 
-#define ARCH_HAS_READ_CURRENT_TIMER
-
 #endif /* _ASM_X86_TIMEX_H */
--- a/arch/x86/lib/delay.c
+++ b/arch/x86/lib/delay.c
@@ -14,12 +14,10 @@
 
 #include <linux/export.h>
 #include <linux/sched.h>
-#include <linux/timex.h>
 #include <linux/preempt.h>
 #include <linux/delay.h>
 
 #include <asm/processor.h>
-#include <asm/delay.h>
 #include <asm/timer.h>
 #include <asm/mwait.h>
 
@@ -189,13 +187,13 @@ void use_mwaitx_delay(void)
 	delay_fn = delay_halt;
 }
 
-int read_current_timer(unsigned long *timer_val)
+bool delay_read_timer(unsigned long *timer_val)
 {
 	if (delay_fn == delay_tsc) {
 		*timer_val = rdtsc();
-		return 0;
+		return true;
 	}
-	return -1;
+	return false;
 }
 
 void __delay(unsigned long loops)
--- a/include/asm-generic/timex.h
+++ b/include/asm-generic/timex.h
@@ -13,11 +13,4 @@ static inline cycles_t get_cycles(void)
 }
 #endif
 
-/*
- * Architectures are encouraged to implement read_current_timer
- * and define this in order to avoid the expensive delay loop
- * calibration during boot.
- */
-#undef ARCH_HAS_READ_CURRENT_TIMER
-
 #endif /* __ASM_GENERIC_TIMEX_H */
--- a/include/linux/delay.h
+++ b/include/linux/delay.h
@@ -17,6 +17,8 @@ extern unsigned long loops_per_jiffy;
 
 #include <asm/delay.h>
 
+bool delay_read_timer(unsigned long *t);
+
 /*
  * Using udelay() for intervals greater than a few milliseconds can
  * risk overflow for high loops_per_jiffy (high bogomips) machines. The
--- a/include/linux/timex.h
+++ b/include/linux/timex.h
@@ -156,8 +156,6 @@ extern int do_clock_adjtime(const clocki
 
 extern void hardpps(const struct timespec64 *, const struct timespec64 *);
 
-int read_current_timer(unsigned long *timer_val);
-
 /* The clock frequency of the i8253/i8254 PIT */
 #define PIT_TICK_RATE 1193182ul
 
--- a/init/calibrate.c
+++ b/init/calibrate.c
@@ -13,7 +13,6 @@
 #include <linux/printk.h>
 #include <linux/smp.h>
 #include <linux/stddef.h>
-#include <linux/timex.h>
 
 unsigned long lpj_fine;
 unsigned long preset_lpj;
@@ -25,9 +24,9 @@ static int __init lpj_setup(char *str)
 
 __setup("lpj=", lpj_setup);
 
-#ifdef ARCH_HAS_READ_CURRENT_TIMER
+#ifdef CONFIG_ARCH_HAS_DELAY_TIMER
 
-/* This routine uses the read_current_timer() routine and gets the
+/* This routine uses the delay_read_timer() routine and gets the
  * loops per jiffy directly, instead of guessing it using delay().
  * Also, this code tries to handle non-maskable asynchronous events
  * (like SMIs)
@@ -48,13 +47,13 @@ static unsigned long calibrate_delay_dir
 	int min = -1;
 	int i;
 
-	if (read_current_timer(&pre_start) < 0 )
+	if (!delay_read_timer(&pre_start))
 		return 0;
 
 	/*
 	 * A simple loop like
 	 *	while ( jiffies < start_jiffies+1)
-	 *		start = read_current_timer();
+	 *		start = delay_read_timer();
 	 * will not do. As we don't really know whether jiffy switch
 	 * happened first or timer_value was read first. And some asynchronous
 	 * event can happen between these two events introducing errors in lpj.
@@ -72,22 +71,22 @@ static unsigned long calibrate_delay_dir
 
 	for (i = 0; i < MAX_DIRECT_CALIBRATION_RETRIES; i++) {
 		pre_start = 0;
-		read_current_timer(&start);
+		delay_read_timer(&start);
 		start_jiffies = jiffies;
 		while (time_before_eq(jiffies, start_jiffies + 1)) {
 			pre_start = start;
-			read_current_timer(&start);
+			delay_read_timer(&start);
 		}
-		read_current_timer(&post_start);
+		delay_read_timer(&post_start);
 
 		pre_end = 0;
 		end = post_start;
 		while (time_before_eq(jiffies, start_jiffies + 1 +
 					       DELAY_CALIBRATION_TICKS)) {
 			pre_end = end;
-			read_current_timer(&end);
+			delay_read_timer(&end);
 		}
-		read_current_timer(&post_end);
+		delay_read_timer(&post_end);
 
 		timer_rate_max = (post_end - pre_start) /
 					DELAY_CALIBRATION_TICKS;


