Return-Path: <linux-wireless+bounces-34641-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kG85EkZm2Wm8pQgAu9opvQ
	(envelope-from <linux-wireless+bounces-34641-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:06:14 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A17EC3DCB60
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 23:06:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0C1EA301F98A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 20:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5CC13A6B93;
	Fri, 10 Apr 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uBb+aK4w"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91D2B37F8C5;
	Fri, 10 Apr 2026 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775854529; cv=none; b=SpiuEDxx354np/8mh7+pdNXetW0ks3Ls4PDmrLxPocr7P63k66hLR81zgJAwQv0db5flucmEggMOUVjvafIQae8JvaEgV5olflTMxZX4ZohpBtJWOEeApHi7QgvwlE7yZk34HXbxpZoBJFJmffwUdVLpXcghzU6ybxW15B6wyTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775854529; c=relaxed/simple;
	bh=NCLwUcavida6lTRmcWsaKb5HSspL1nWNySBxMvO4hO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=axDZ3ok7jmvbSO8WiiFFecMujCIaos94PQHn10ZAS1jNcaIe+ttHDe8/5uTtGdaOKewpJBqtSnBez4lF3Nuu/H1XzkOzqTNqKVEb6vfL04fMe0sZqj4NnfeZhbljOj5ng5bN3mUc0/Qx9CnH4lnWbaxww7CNADN2jrolKKRkPsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uBb+aK4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25D0DC19421;
	Fri, 10 Apr 2026 20:55:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775854529;
	bh=NCLwUcavida6lTRmcWsaKb5HSspL1nWNySBxMvO4hO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=uBb+aK4w3/2u4kyVJBiptzM0/JeHVU+h0LyuAGmXhRBB/wmY8nVPEGLrH6PIUauly
	 xZ5jhTx/pd4jDAH6N0E8699fbCvDPdRPvQ/1U9PBOdvPEbxrui2vDJcfwacrKBJbAt
	 K2KgH8S8N6W61I5bQqua5TC/HTbe1JJBDb2jmaIXqh11mio1s1ulWsCUgh1TEd2HU0
	 +ZMxNL6Px/beH32xwdxJ9u73C9h58Vy+EiUKACVtBOcR0D3eWoYoTnffZnDWdkv8Q1
	 Jq57olSI26FETBnKfPSYv2rHfBfCG49DcVZq8FGFKIXdb41avCYxrEXRj1YRJAzkeo
	 CA0Wg7vMsMitA==
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, Bernie Thompson
 <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso
 <tytso@mit.edu>, linux-ext4@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco
 Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: [patch V1.1 02/38] x86: Cleanup include recursion hell
In-Reply-To: <20260410120317.709923681@kernel.org>
References: <20260410120044.031381086@kernel.org>
 <20260410120317.709923681@kernel.org>
Date: Fri, 10 Apr 2026 22:55:25 +0200
Message-ID: <87ldeuzgaq.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Spamd-Result: default: False [4.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34641-lists,linux-wireless=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,body];
	RCPT_COUNT_TWELVE(0.00)[48];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglx@kernel.org,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.990];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A17EC3DCB60
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Including a random architecture specific header which requires global
headers just to avoid including that header at the two usage sites is
really beyond lazy and tasteless. Including global headers just to get the
__percpu macro from linux/compiler_types.h falls into the same category.

Remove the linux/percpu.h and asm/cpumask.h includes from msr.h and smp.h
and fix the resulting fallout by a simple forward struct declaration and by
including the x86 specific asm/cpumask.h header where it is actually
required.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
V1.1: Fix PARAVIRT_XXL fallout....
---
 arch/x86/include/asm/cache.h             |    1 +
 arch/x86/include/asm/msr.h               |    5 +++--
 arch/x86/include/asm/paravirt.h          |    3 ++-
 arch/x86/include/asm/pvclock.h           |    1 +
 arch/x86/include/asm/smp.h               |    2 --
 arch/x86/include/asm/vdso/gettimeofday.h |    5 ++---
 arch/x86/kernel/cpu/mce/core.c           |    1 +
 arch/x86/kernel/nmi.c                    |    1 +
 arch/x86/kernel/smpboot.c                |    1 +
 9 files changed, 12 insertions(+), 8 deletions(-)

--- a/arch/x86/include/asm/cache.h
+++ b/arch/x86/include/asm/cache.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_CACHE_H
 #define _ASM_X86_CACHE_H
 
+#include <vdso/page.h>
 #include <linux/linkage.h>
 
 /* L1 cache line size */
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -8,12 +8,11 @@
 
 #include <asm/asm.h>
 #include <asm/errno.h>
-#include <asm/cpumask.h>
 #include <uapi/asm/msr.h>
 #include <asm/shared/msr.h>
 
+#include <linux/compiler_types.h>
 #include <linux/types.h>
-#include <linux/percpu.h>
 
 struct msr_info {
 	u32			msr_no;
@@ -256,6 +255,8 @@ int msr_set_bit(u32 msr, u8 bit);
 int msr_clear_bit(u32 msr, u8 bit);
 
 #ifdef CONFIG_SMP
+struct cpumask;
+
 int rdmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 *l, u32 *h);
 int wrmsr_on_cpu(unsigned int cpu, u32 msr_no, u32 l, u32 h);
 int rdmsrq_on_cpu(unsigned int cpu, u32 msr_no, u64 *q);
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -16,9 +16,10 @@
 
 #ifndef __ASSEMBLER__
 #include <linux/types.h>
-#include <linux/cpumask.h>
 #include <asm/frame.h>
 
+struct cpumask;
+
 /* The paravirtualized I/O functions */
 static inline void slow_down_io(void)
 {
--- a/arch/x86/include/asm/pvclock.h
+++ b/arch/x86/include/asm/pvclock.h
@@ -2,6 +2,7 @@
 #ifndef _ASM_X86_PVCLOCK_H
 #define _ASM_X86_PVCLOCK_H
 
+#include <asm/barrier.h>
 #include <asm/clocksource.h>
 #include <asm/pvclock-abi.h>
 
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -5,8 +5,6 @@
 #include <linux/cpumask.h>
 #include <linux/thread_info.h>
 
-#include <asm/cpumask.h>
-
 DECLARE_PER_CPU_CACHE_HOT(int, cpu_number);
 
 DECLARE_PER_CPU_READ_MOSTLY(cpumask_var_t, cpu_sibling_map);
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -11,13 +11,12 @@
 #define __ASM_VDSO_GETTIMEOFDAY_H
 
 #ifndef __ASSEMBLER__
-
+#include <clocksource/hyperv_timer.h>
 #include <uapi/linux/time.h>
+
 #include <asm/vgtod.h>
 #include <asm/unistd.h>
-#include <asm/msr.h>
 #include <asm/pvclock.h>
-#include <clocksource/hyperv_timer.h>
 #include <asm/vdso/sys_call.h>
 
 #define VDSO_HAS_TIME 1
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -48,6 +48,7 @@
 #include <linux/vmcore_info.h>
 
 #include <asm/fred.h>
+#include <asm/cpumask.h>
 #include <asm/cpu_device_id.h>
 #include <asm/processor.h>
 #include <asm/traps.h>
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -26,6 +26,7 @@
 #include <linux/sched/clock.h>
 #include <linux/kvm_types.h>
 
+#include <asm/cpumask.h>
 #include <asm/cpu_entry_area.h>
 #include <asm/traps.h>
 #include <asm/mach_traps.h>
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -70,6 +70,7 @@
 #include <asm/irq.h>
 #include <asm/realmode.h>
 #include <asm/cpu.h>
+#include <asm/cpumask.h>
 #include <asm/numa.h>
 #include <asm/tlbflush.h>
 #include <asm/mtrr.h>

