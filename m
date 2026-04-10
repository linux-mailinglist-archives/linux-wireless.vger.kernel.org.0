Return-Path: <linux-wireless+bounces-34602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YIz8JQ/v2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:37:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 736183D7603
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 69B0A30738C9
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 765583C4573;
	Fri, 10 Apr 2026 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UsSMuuI0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 487C63C0635;
	Fri, 10 Apr 2026 12:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823634; cv=none; b=kw/y9sTZaHK2WHMZ+ZQVcYd7xeA1iV/G4DFWYHN7Iy6LsGlc2vOG+yc2OjKz0YILTY7Wx1dLvmstx5TfaKMQdzjyBJg1ERhEriFFpMjgbTp6Sepd06kZ3QKC9aVEVufYLbysYtiAyW7k9D4xWSqBhilcLwBWQ3EspQqxIJXmsPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823634; c=relaxed/simple;
	bh=dDZlZkUBE8Yoz+Mf4b2btSZILqeS3wHEYjrON1rjw6U=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=R1hxpitiGibTPOM97tROot1Zqqa5MbMQNqyMD9WJ4vbMqhGCthqmgyxefh6fbp12bryjN0Aps9ABZRY3pdFTkFDJtqz3dkgbNUJPPKXG22cT1s10FyMV5j6Nx7dX/b8MqvykHrIxJZwv7/hnKChgLr+hxA0spbHp1ALN+QTTUf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UsSMuuI0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59123C2BC87;
	Fri, 10 Apr 2026 12:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823634;
	bh=dDZlZkUBE8Yoz+Mf4b2btSZILqeS3wHEYjrON1rjw6U=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UsSMuuI0fLabe+4dL8zTL2gq7n1Qam6gWMJ4FfKEoBXmYXreb34mK0jfpqexOCcjk
	 URd+7aIYau5Paex32UCyAHBB1baazBC53HlWWmD8jGnelNjcRxfUYPATekVzRrqJDT
	 SM4YYaTAd2jF6zuzF3s9v75IAyeOupGmOZUxJte/r7FKLtBw0S1j/Gfer+oeitcrs9
	 GcWasj5F60hnX72mh29rwAv4UlAzszLEnt4a+71ByOcLxgUh/fQSei1PCaUTQnLPFS
	 AyV/TWXRXX6WJrt/PID7Ovi55s49ArxiVCGwFwMjqqfxuev0KPjerElNRcERH69T8a
	 bfdJGP+BHG9rw==
Date: Fri, 10 Apr 2026 14:20:31 +0200
Message-ID: <20260410120319.263143276@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
 linux-arm-kernel@lists.infradead.org,
 Arnd Bergmann <arnd@arndb.de>,
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
Subject: [patch 25/38] arm64: Select ARCH_HAS_RANDOM_ENTROPY
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
	FREEMAIL_CC(0.00)[arm.com,lists.infradead.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34602-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 736183D7603
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining usage of get_cycles() is to provide random_get_entropy().

Switch arm64 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

As a consequence this unearthed a nasty include dependecy hell where random
code including rqspinlock.h relies on a magic include of asm/arch_timer.h.
Including the headers in asm/random.h turned out to be impossible as well.

The only solution for now is to uninline random_get_entropy().  Fix up all
other dependencies on the content of asm/timex.h in those files which
really depend on it.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm64/Kconfig                      |    1 +
 arch/arm64/include/asm/io.h             |    5 +++--
 arch/arm64/include/asm/random.h         |   11 +++++++++++
 arch/arm64/include/asm/rqspinlock.h     |    1 +
 arch/arm64/include/asm/timex.h          |   18 ------------------
 arch/arm64/kernel/time.c                |    6 ++++++
 arch/arm64/kernel/topology.c            |    1 +
 arch/arm64/kernel/traps.c               |    1 +
 arch/arm64/kvm/emulate-nested.c         |    1 +
 arch/arm64/kvm/hyp/include/hyp/switch.h |    1 +
 arch/arm64/lib/delay.c                  |    1 +
 drivers/irqchip/irq-apple-aic.c         |    1 +
 12 files changed, 28 insertions(+), 20 deletions(-)

--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -45,6 +45,7 @@ config ARM64
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_DIRECT_MAP
--- a/arch/arm64/include/asm/io.h
+++ b/arch/arm64/include/asm/io.h
@@ -100,12 +100,13 @@ static __always_inline u64 __raw_readq(c
 ({									\
 	unsigned long tmp;						\
 									\
-	dma_rmb();								\
+	dma_rmb();							\
 									\
 	/*								\
 	 * Create a dummy control dependency from the IO read to any	\
 	 * later instructions. This ensures that a subsequent call to	\
-	 * udelay() will be ordered due to the ISB in get_cycles().	\
+	 * udelay() will be ordered due to the ISB in			\
+	 * arm_timer_read_counter().					\
 	 */								\
 	asm volatile("eor	%0, %1, %1\n"				\
 		     "cbnz	%0, ."					\
--- /dev/null
+++ b/arch/arm64/include/asm/random.h
@@ -0,0 +1,11 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2012 ARM Ltd.
+ */
+#ifndef __ASM_RANDOM_H
+#define __ASM_RANDOM_H
+
+/* Out of line to avoid recursive include hell */
+unsigned long random_get_entropy(void);
+
+#endif
--- a/arch/arm64/include/asm/rqspinlock.h
+++ b/arch/arm64/include/asm/rqspinlock.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_RQSPINLOCK_H
 #define _ASM_RQSPINLOCK_H
 
+#include <asm/arch_timer.h>
 #include <asm/barrier.h>
 
 /*
--- a/arch/arm64/include/asm/timex.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2012 ARM Ltd.
- */
-#ifndef __ASM_TIMEX_H
-#define __ASM_TIMEX_H
-
-#include <asm/arch_timer.h>
-
-/*
- * Use the current timer as a cycle counter since this is what we use for
- * the delay loop.
- */
-#define get_cycles()	arch_timer_read_counter()
-
-#include <asm-generic/timex.h>
-
-#endif
--- a/arch/arm64/kernel/time.c
+++ b/arch/arm64/kernel/time.c
@@ -29,6 +29,7 @@
 
 #include <clocksource/arm_arch_timer.h>
 
+#include <asm/arch_timer.h>
 #include <asm/thread_info.h>
 #include <asm/paravirt.h>
 
@@ -52,6 +53,11 @@ unsigned long profile_pc(struct pt_regs
 }
 EXPORT_SYMBOL(profile_pc);
 
+static unsigned long random_get_entropy(void)
+{
+	return arch_timer_read_counter();
+}
+
 void __init time_init(void)
 {
 	u32 arch_timer_rate;
--- a/arch/arm64/kernel/topology.c
+++ b/arch/arm64/kernel/topology.c
@@ -21,6 +21,7 @@
 #include <linux/sched/isolation.h>
 #include <linux/xarray.h>
 
+#include <asm/arch_timer.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/topology.h>
--- a/arch/arm64/kernel/traps.c
+++ b/arch/arm64/kernel/traps.c
@@ -30,6 +30,7 @@
 #include <linux/ubsan.h>
 #include <linux/cfi.h>
 
+#include <asm/arch_timer.h>
 #include <asm/atomic.h>
 #include <asm/bug.h>
 #include <asm/cpufeature.h>
--- a/arch/arm64/kvm/emulate-nested.c
+++ b/arch/arm64/kvm/emulate-nested.c
@@ -7,6 +7,7 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 
+#include <asm/arch_timer.h>
 #include <asm/kvm_emulate.h>
 #include <asm/kvm_nested.h>
 
--- a/arch/arm64/kvm/hyp/include/hyp/switch.h
+++ b/arch/arm64/kvm/hyp/include/hyp/switch.h
@@ -18,6 +18,7 @@
 
 #include <kvm/arm_psci.h>
 
+#include <asm/arch_timer.h>
 #include <asm/barrier.h>
 #include <asm/cpufeature.h>
 #include <asm/extable.h>
--- a/arch/arm64/lib/delay.c
+++ b/arch/arm64/lib/delay.c
@@ -14,6 +14,7 @@
 #include <linux/timex.h>
 
 #include <clocksource/arm_arch_timer.h>
+#include <asm/arch_timer.h>
 
 #define USECS_TO_CYCLES(time_usecs)			\
 	xloops_to_cycles((time_usecs) * 0x10C7UL)
--- a/drivers/irqchip/irq-apple-aic.c
+++ b/drivers/irqchip/irq-apple-aic.c
@@ -55,6 +55,7 @@
 #include <linux/jump_label.h>
 #include <linux/limits.h>
 #include <linux/of_address.h>
+#include <asm/arch_timer.h>
 #include <linux/slab.h>
 #include <asm/apple_m1_pmu.h>
 #include <asm/cputype.h>


