Return-Path: <linux-wireless+bounces-34586-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKfuMXbs2GlGjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34586-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:26:30 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1DA3D6F8D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:26:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9DF503068D2F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A83C13FF;
	Fri, 10 Apr 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pacXAmHL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9463BFE40;
	Fri, 10 Apr 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823555; cv=none; b=UPss8nVAuMTAN3pnwUYX6yCZ7+jJvr73arfBZPYO+xfwireSSUjyXhJH5TGQ2piRT0WZ92UY7H4aQYrc7Qc8Cit5Y9Q5MA5vJJm9sY507ms2K6bYHWG+JcnaZWwfSTv1kk9NrryoJL3WAkgfkOi6yy0gieHgOqbowiG02E8toGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823555; c=relaxed/simple;
	bh=qtG4jYoFMBUH8Rv5LkkLsBrvbBwuDbTX1269QfkLCzw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=NuZWGs7c9F/nxYYh4xjAHr15mr+jzC5d2SbzM+zhw7jfOaF+82PzmSsSMf8h9ydKzttuf868rQzsgbwMXH/vxT5bnYS7OCppCwbArnZR/UoKblIV+tH7WwMhHqTjeR08UbE5jTwi+0XeOJrDD2f626jOLL4+5inCrBf4sWCCJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pacXAmHL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BE3EC2BC87;
	Fri, 10 Apr 2026 12:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823555;
	bh=qtG4jYoFMBUH8Rv5LkkLsBrvbBwuDbTX1269QfkLCzw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=pacXAmHLAMseTev4RAQUAZDfRzJFeJXjwMW3x14w8vUm7ybikBbtslQQu96s/8Sq0
	 a3pcIexn/gzfbwI2qYLuXSTx/gSXbmVwhuUFKfTY31pSFVH71nhoebkIPAnwJfmArK
	 tPmJiCD8oWRaoY6EByg0L3DGpV75oKKW/C5lmUUCoaSznEsjUHpS9yyQByZ5hUlH3x
	 P8NYw39byMTR2ebfPveTfvTFbDgwqYFvegEj7/kJQbjlvVeppRrN8YtOduabfxNT6E
	 Yw4oV6JDjGSLEpWghPJGJFmnCci2PXJh9wjpVWvhGUbODkplfUDbeuEJIVIN1zibiF
	 mC2OEaJT1jHhg==
Date: Fri, 10 Apr 2026 14:19:12 +0200
Message-ID: <20260410120318.187521447@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Arnd Bergmann <arnd@arndb.de>,
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
Subject: [patch 09/38] iommu/vt-d: Use sched_clock() instead of get_cycles()
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34586-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.intel.com,lists.linux.dev,arndb.de,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linux.dev:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D1DA3D6F8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Calculating the timeout from get_cycles() is a historical leftover without
any functional requirement.

Use ktime_get() instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
Cc: Lu Baolu <baolu.lu@linux.intel.com>
Cc: iommu@lists.linux.dev
---
 arch/x86/include/asm/iommu.h |    3 ---
 drivers/iommu/intel/dmar.c   |    4 ++--
 drivers/iommu/intel/iommu.h  |    8 ++++++--
 3 files changed, 8 insertions(+), 7 deletions(-)

--- a/arch/x86/include/asm/iommu.h
+++ b/arch/x86/include/asm/iommu.h
@@ -18,9 +18,6 @@ extern bool x86_swiotlb_enable;
 #define x86_swiotlb_enable false
 #endif
 
-/* 10 seconds */
-#define DMAR_OPERATION_TIMEOUT ((cycles_t) tsc_khz*10*1000)
-
 static inline int __init
 arch_rmrr_sanity_check(struct acpi_dmar_reserved_memory *rmrr)
 {
--- a/drivers/iommu/intel/dmar.c
+++ b/drivers/iommu/intel/dmar.c
@@ -1606,9 +1606,9 @@ void qi_flush_pasid_cache(struct intel_i
  */
 void dmar_disable_qi(struct intel_iommu *iommu)
 {
+	ktime_t start_time = ktime_get();
 	unsigned long flags;
 	u32 sts;
-	cycles_t start_time = get_cycles();
 
 	if (!ecap_qis(iommu->ecap))
 		return;
@@ -1624,7 +1624,7 @@ void dmar_disable_qi(struct intel_iommu
 	 */
 	while ((readl(iommu->reg + DMAR_IQT_REG) !=
 		readl(iommu->reg + DMAR_IQH_REG)) &&
-		(DMAR_OPERATION_TIMEOUT > (get_cycles() - start_time)))
+	       (DMAR_OPERATION_TIMEOUT > (ktime_get() - start_time)))
 		cpu_relax();
 
 	iommu->gcmd &= ~DMA_GCMD_QIE;
--- a/drivers/iommu/intel/iommu.h
+++ b/drivers/iommu/intel/iommu.h
@@ -23,6 +23,7 @@
 #include <linux/xarray.h>
 #include <linux/perf_event.h>
 #include <linux/pci.h>
+#include <linux/timekeeping.h>
 #include <linux/generic_pt/iommu.h>
 
 #include <asm/iommu.h>
@@ -360,14 +361,17 @@
 /* PERFINTRSTS_REG */
 #define DMA_PERFINTRSTS_PIS	((u32)1)
 
+#define DMAR_OPERATION_TIMEOUT  (((ktime_t)10) * NSEC_PER_SEC)
+
 #define IOMMU_WAIT_OP(iommu, offset, op, cond, sts)			\
 do {									\
-	cycles_t start_time = get_cycles();				\
+	ktime_t start_time = ktime_get();				\
+									\
 	while (1) {							\
 		sts = op(iommu->reg + offset);				\
 		if (cond)						\
 			break;						\
-		if (DMAR_OPERATION_TIMEOUT < (get_cycles() - start_time))\
+		if (DMAR_OPERATION_TIMEOUT < (ktime_get() - start_time))\
 			panic("DMAR hardware is malfunctioning\n");	\
 		cpu_relax();						\
 	}								\


