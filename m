Return-Path: <linux-wireless+bounces-34611-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QO1ZIxbv2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34611-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:37:42 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 116193D760A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:37:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B59F4302D50B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9FC03E3152;
	Fri, 10 Apr 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OA4RjUak"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF443C1417;
	Fri, 10 Apr 2026 12:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823677; cv=none; b=d2khFmSsUoxRQFxpKNZ7iS4uYm/w6pawChSZxKv8m+ytaK/E1NDFNURDM9tjF0r+DI2eKRe9rITBvCDw0e7rgqV3vSwZf2J/vmLdmnJYdmAzUD8K9FluKnZT02SQFA4kmN13dJppxIe2YSnIdGptNhj6vxafKlSH4d2tDIX9CWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823677; c=relaxed/simple;
	bh=8aVhqN+bsjtC+8iOVhItTcCo4nE5t4ex+cjOCvHOROg=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JwIb8lSbP7mj0wUuSp9lsSb4Sz70HTK+YpxSMJm0qtYdVd4oe3AgzviO+Ig7/L8oJqUNdeyAWs6ZA1KdeX/Ks31JCM794QTLN+J0FKJDcasdVfU4bYuLTvQX1eQYWfjSCiIU5eGk3G6wv9pVrf8KqwprFVfEb3qpEVujTxldPs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OA4RjUak; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57879C2BCB3;
	Fri, 10 Apr 2026 12:21:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823677;
	bh=8aVhqN+bsjtC+8iOVhItTcCo4nE5t4ex+cjOCvHOROg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OA4RjUakSKbHP7uZl9Rn6aI/7Qts08y1gdCxG4212yNJdVKaYLulTRlHhQ1giBOu6
	 tARhrIBIltPo7n2ZqupgbCjM222ynMbD+JMBXCcsIED9ns8vEth54JFbieyU26o9rm
	 KoQTgfYyoH0jSRf5j3OQodGQDBBjhAykp4Hy5bQdfGP0P88P76fnb883frBXWWU03q
	 P/YOEYqjXf/L4ccO74xjFbM3qOQBRFdrvTUVXM6TfNVPJX1ACluXAp6rS0x+D02XQB
	 ZfqSCQC8dN3KdQ34VmPvfFKRcfafCQ6soBJ+KtAS56vLrMJXpWDVh/K6XVrYMUGmaP
	 YaxQP6ppalRew==
Date: Fri, 10 Apr 2026 14:21:14 +0200
Message-ID: <20260410120319.853669871@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
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
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 34/38] riscv: Select ARCH_HAS_RANDOM_ENTROPY
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,arndb.de,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34611-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 116193D760A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining non-architecture usage of get_cycles() is to provide
random_get_entropy().

Switch riscv over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Add 'asm/timex.h' includes to the relevant files, so the global include can
be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>
Cc: linux-riscv@lists.infradead.org
---
 arch/riscv/Kconfig                         |    1 +
 arch/riscv/include/asm/random.h            |   25 +++++++++++++++++++++++++
 arch/riscv/include/asm/timex.h             |   13 -------------
 arch/riscv/kernel/unaligned_access_speed.c |    1 +
 arch/riscv/kvm/vcpu_timer.c                |    1 +
 arch/riscv/lib/delay.c                     |    1 +
 6 files changed, 29 insertions(+), 13 deletions(-)

--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -47,6 +47,7 @@ config RISCV
 	select ARCH_HAS_PREPARE_SYNC_CORE_CMD
 	select ARCH_HAS_PTDUMP if MMU
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SET_DIRECT_MAP if MMU
 	select ARCH_HAS_SET_MEMORY if MMU
 	select ARCH_HAS_STRICT_KERNEL_RWX if MMU && !XIP_KERNEL
--- /dev/null
+++ b/arch/riscv/include/asm/random.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_RISCV_RANDOM_H
+#define _ASM_RISCV_RANDOM_H
+
+#include <asm/timex.h>
+
+#ifdef CONFIG_RISCV_M_MODE
+/*
+ * Much like MIPS, we may not have a viable counter to use at an early point
+ * in the boot process. Unfortunately we don't have a fallback, so instead
+ * invoke the fallback function.
+ */
+static inline unsigned long random_get_entropy(void)
+{
+	if (unlikely(clint_time_val == NULL))
+		return random_get_entropy_fallback();
+	return get_cycles();
+}
+#else  /* !CONFIG_RISCV_M_MODE */
+static inline unsigned long random_get_entropy(void)
+{
+	return get_cycles();
+}
+#endif /* CONFIG_RISCV_M_MODE */
+#endif /* _ASM_RISCV_RANDOM_H */
--- a/arch/riscv/include/asm/timex.h
+++ b/arch/riscv/include/asm/timex.h
@@ -31,19 +31,6 @@ static inline u32 get_cycles_hi(void)
 #define get_cycles_hi get_cycles_hi
 #endif /* CONFIG_64BIT */
 
-/*
- * Much like MIPS, we may not have a viable counter to use at an early point
- * in the boot process. Unfortunately we don't have a fallback, so instead
- * we just return 0.
- */
-static inline unsigned long random_get_entropy(void)
-{
-	if (unlikely(clint_time_val == NULL))
-		return random_get_entropy_fallback();
-	return get_cycles();
-}
-#define random_get_entropy()	random_get_entropy()
-
 #else /* CONFIG_RISCV_M_MODE */
 
 static inline cycles_t get_cycles(void)
--- a/arch/riscv/kernel/unaligned_access_speed.c
+++ b/arch/riscv/kernel/unaligned_access_speed.c
@@ -12,6 +12,7 @@
 #include <linux/types.h>
 #include <asm/cpufeature.h>
 #include <asm/hwprobe.h>
+#include <asm/timex.h>
 #include <asm/vector.h>
 
 #include "copy-unaligned.h"
--- a/arch/riscv/kvm/vcpu_timer.c
+++ b/arch/riscv/kvm/vcpu_timer.c
@@ -14,6 +14,7 @@
 #include <asm/delay.h>
 #include <asm/kvm_nacl.h>
 #include <asm/kvm_vcpu_timer.h>
+#include <asm/timex.h>
 
 static u64 kvm_riscv_current_cycles(struct kvm_guest_timer *gt)
 {
--- a/arch/riscv/lib/delay.c
+++ b/arch/riscv/lib/delay.c
@@ -10,6 +10,7 @@
 #include <linux/export.h>
 
 #include <asm/processor.h>
+#include <asm/timex.h>
 
 /*
  * This is copies from arch/arm/include/asm/delay.h


