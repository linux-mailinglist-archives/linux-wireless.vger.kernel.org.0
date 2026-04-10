Return-Path: <linux-wireless+bounces-34584-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEujMIXr2GlBjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34584-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:22:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C803D6D6F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 34DE9304B363
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:20:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB2CA3CAE99;
	Fri, 10 Apr 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RN1rF/li"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D053BD64E;
	Fri, 10 Apr 2026 12:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823546; cv=none; b=rHZxoBZ+bDfVoZ/eKqvYwfI6z/nNNdf0dFPM9e3f34jpUiObpn123ho4/kU8ZDcEWyH0UIDPuFhQdJrnioDLh5aBHJlWv4bm02d5lkwKcSh3jTKoj05wuKmAuMvsFYPd2JWC4ncwlVwUuIMxnOPQuF5cTurN4D0BYAxe5bpYoiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823546; c=relaxed/simple;
	bh=e1hr7RxQAtfkXxmpOByj9AnE8rprLs7FfW1VJuycE3U=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=JPqUytWaWBHysIZ3Aff2KqPjeJEN3vumceXGsXjSE7c/JaAIs9hZuj+ah+lBv0Q9xNAls4Pk8fXTMT+JYUTs3YgbVYiZuKkilFJ++N9c97UHUsQH8+K+iOcvEimqDGT3Kq4HfWRUC/dQTBILxnkcT0hogJiWXQlACRnVk5LEHXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RN1rF/li; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CDE4C2BCB3;
	Fri, 10 Apr 2026 12:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823546;
	bh=e1hr7RxQAtfkXxmpOByj9AnE8rprLs7FfW1VJuycE3U=;
	h=Date:From:To:Subject:References:cc:From;
	b=RN1rF/lik/IDDm6vfArIXRWDzYeJ5FOTg7VZhjC87W8dEFx4XOLkGFYYWGhN5FSAp
	 UgUW5oHG+RoyFDJ2Lb8wy9bLXZ629e0sIZHO26a4htp9GCeP67dTQge4t3eD4oDh93
	 1M2FHKCxNFZC0Fzd0yadwA9xaercjxCXri8tQar5sfr/ENoprWWJO3/MtUJLqRehkg
	 l/QzejVV1juchHtR/6u+RSlRsRj9VAJZETUAE3E4ZTRyX1FMMGjRx2pW1U9TsOYtOg
	 Iiw1IsbQmNZnTrKZs9AZodQQ0gykTA14aWPgbU/9QJFDHI9V1VA1cDQRoqdiQlL5WN
	 Y1nwRLUUSmSZw==
Date: Fri, 10 Apr 2026 14:19:03 +0200
Message-ID: <20260410120318.045532623@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 07/38] treewide: Consolidate cycles_t
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34584-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
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
X-Rspamd-Queue-Id: 72C803D6D6F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Most architectures define cycles_t as unsigned long execpt:

 - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.

 - parisc and mips define it as unsigned int

   parisc has no real reason to do so as there are only a few usage sites
   which either expand it to a 64-bit value or utilize only the lower
   32bits.

   mips has no real requirement either.

Move the typedef to types.h and provide a config switch to enforce the
64-bit type for x86.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 arch/Kconfig                       |    4 ++++
 arch/alpha/include/asm/timex.h     |    3 ---
 arch/arm/include/asm/timex.h       |    1 -
 arch/loongarch/include/asm/timex.h |    2 --
 arch/m68k/include/asm/timex.h      |    2 --
 arch/mips/include/asm/timex.h      |    2 --
 arch/nios2/include/asm/timex.h     |    2 --
 arch/parisc/include/asm/timex.h    |    2 --
 arch/powerpc/include/asm/timex.h   |    4 +---
 arch/riscv/include/asm/timex.h     |    2 --
 arch/s390/include/asm/timex.h      |    2 --
 arch/sparc/include/asm/timex_64.h  |    1 -
 arch/x86/Kconfig                   |    1 +
 arch/x86/include/asm/tsc.h         |    2 --
 include/asm-generic/timex.h        |    1 -
 include/linux/types.h              |    6 ++++++
 16 files changed, 12 insertions(+), 25 deletions(-)

--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -360,6 +360,10 @@ config ARCH_HAS_DMA_SET_UNCACHED
 config ARCH_HAS_DMA_CLEAR_UNCACHED
 	bool
 
+# cycles_t is always 64bit wide
+config ARCH_HAS_CYCLES_T_64
+	bool
+
 config ARCH_HAS_CPU_FINALIZE_INIT
 	bool
 
--- a/arch/alpha/include/asm/timex.h
+++ b/arch/alpha/include/asm/timex.h
@@ -15,9 +15,6 @@
  * But this only means we'll force a reschedule every 8 seconds or so,
  * which isn't an evil thing.
  */
-
-typedef unsigned int cycles_t;
-
 static inline cycles_t get_cycles (void)
 {
 	cycles_t ret;
--- a/arch/arm/include/asm/timex.h
+++ b/arch/arm/include/asm/timex.h
@@ -9,7 +9,6 @@
 #ifndef _ASMARM_TIMEX_H
 #define _ASMARM_TIMEX_H
 
-typedef unsigned long cycles_t;
 // Temporary workaround
 bool delay_read_timer(unsigned long *t);
 
--- a/arch/loongarch/include/asm/timex.h
+++ b/arch/loongarch/include/asm/timex.h
@@ -12,8 +12,6 @@
 #include <asm/cpu.h>
 #include <asm/cpu-features.h>
 
-typedef unsigned long cycles_t;
-
 #define get_cycles get_cycles
 
 static inline cycles_t get_cycles(void)
--- a/arch/m68k/include/asm/timex.h
+++ b/arch/m68k/include/asm/timex.h
@@ -7,8 +7,6 @@
 #ifndef _ASMm68K_TIMEX_H
 #define _ASMm68K_TIMEX_H
 
-typedef unsigned long cycles_t;
-
 static inline cycles_t get_cycles(void)
 {
 	return 0;
--- a/arch/mips/include/asm/timex.h
+++ b/arch/mips/include/asm/timex.h
@@ -29,8 +29,6 @@
  * We know that all SMP capable CPUs have cycle counters.
  */
 
-typedef unsigned int cycles_t;
-
 /*
  * On R4000/R4400 an erratum exists such that if the cycle counter is
  * read in the exact moment that it is matching the compare register,
--- a/arch/nios2/include/asm/timex.h
+++ b/arch/nios2/include/asm/timex.h
@@ -5,8 +5,6 @@
 #ifndef _ASM_NIOS2_TIMEX_H
 #define _ASM_NIOS2_TIMEX_H
 
-typedef unsigned long cycles_t;
-
 extern cycles_t get_cycles(void);
 #define get_cycles get_cycles
 
--- a/arch/parisc/include/asm/timex.h
+++ b/arch/parisc/include/asm/timex.h
@@ -9,8 +9,6 @@
 
 #include <asm/special_insns.h>
 
-typedef unsigned long cycles_t;
-
 static inline cycles_t get_cycles(void)
 {
 	return mfctl(16);
--- a/arch/powerpc/include/asm/timex.h
+++ b/arch/powerpc/include/asm/timex.h
@@ -11,9 +11,7 @@
 #include <asm/cputable.h>
 #include <asm/vdso/timebase.h>
 
-typedef unsigned long cycles_t;
-
-static inline cycles_t get_cycles(void)
+ostatic inline cycles_t get_cycles(void)
 {
 	return mftb();
 }
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -8,8 +8,6 @@
 
 #include <asm/csr.h>
 
-typedef unsigned long cycles_t;
-
 #ifdef CONFIG_RISCV_M_MODE
 
 #include <asm/clint.h>
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -177,8 +177,6 @@ static inline void local_tick_enable(uns
 	set_clock_comparator(get_lowcore()->clock_comparator);
 }
 
-typedef unsigned long cycles_t;
-
 static __always_inline unsigned long get_tod_clock(void)
 {
 	union tod_clock clk;
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -10,7 +10,6 @@
 #include <asm/timer.h>
 
 /* Getting on the cycle counter on sparc64. */
-typedef unsigned long cycles_t;
 #define get_cycles()	tick_ops->get_tick()
 
 #endif
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -79,6 +79,7 @@ config X86
 	select ARCH_HAS_CPU_FINALIZE_INIT
 	select ARCH_HAS_CPU_PASID		if IOMMU_SVA
 	select ARCH_HAS_CURRENT_STACK_POINTER
+	select ARCH_HAS_CYCLES_T_64
 	select ARCH_HAS_DEBUG_VIRTUAL
 	select ARCH_HAS_DEBUG_VM_PGTABLE	if !X86_PAE
 	select ARCH_HAS_DELAY_TIMER
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -67,8 +67,6 @@ static __always_inline u64 rdtsc_ordered
 /*
  * Standard way to access the cycle counter.
  */
-typedef unsigned long long cycles_t;
-
 extern unsigned int cpu_khz;
 extern unsigned int tsc_khz;
 
--- a/include/asm-generic/timex.h
+++ b/include/asm-generic/timex.h
@@ -5,7 +5,6 @@
 /*
  * If you have a cycle counter, return the value here.
  */
-typedef unsigned long cycles_t;
 #ifndef get_cycles
 static inline cycles_t get_cycles(void)
 {
--- a/include/linux/types.h
+++ b/include/linux/types.h
@@ -270,5 +270,11 @@ struct rcuwait {
 	struct task_struct __rcu *task;
 };
 
+#ifdef CONFIG_ARCH_HAS_CYCLES_T_64
+typedef unsigned long long	cycles_t;
+#else
+typedef unsigned long		cycles_t;
+#endif
+
 #endif /*  __ASSEMBLY__ */
 #endif /* _LINUX_TYPES_H */


