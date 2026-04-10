Return-Path: <linux-wireless+bounces-34606-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8B9bHH3y2GnrjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34606-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:52:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC0F3D7BAF
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2A7CD30DFD92
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 320C93DEFE6;
	Fri, 10 Apr 2026 12:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OB4z6rme"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A33C3DEAF7;
	Fri, 10 Apr 2026 12:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823654; cv=none; b=exciZ3bLp2yTQ2GG7EIg+Qu1qNClEWJChWdFsdkMsm5NQyWWW1GjLichkrp85nQ2RNRzMOItHbSEV/znOYeiWsdT8bnM8iCJBbQdcNLvviH+UaGn9TmpmiigvJ6EFkmFYicrjsQcjpUGcSUW/Z6ix+Whd4djDam3grcZrXNXQhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823654; c=relaxed/simple;
	bh=JK0/F7Ki9YiLWmMnKZ+Lr+3CWdB1is+mT2jM4Zqadew=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=l0/uDF8ZKepWFqTVUQyjbv4bVkf+ilIvp9iTmFsEZTbO3/gdXjQlrXxMcqDrVY+H9mavE6TJ3XEiDZUA1vnaFJs/IYnBj7JOki2fl+HcvbzlNQeLqf6x3SefbwVBy0KjGNqe1IqZH8bvP/ca30u2Shjr3CxHLw6PKCfWseB3jVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OB4z6rme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82A6BC2BCAF;
	Fri, 10 Apr 2026 12:20:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823653;
	bh=JK0/F7Ki9YiLWmMnKZ+Lr+3CWdB1is+mT2jM4Zqadew=;
	h=Date:From:To:Cc:Subject:References:From;
	b=OB4z6rmedzjF/tihT238p7staUYI70l/WLyVpYQgd3G/0qlK9BetgUNbHaxUOTJJk
	 qdDaLQwa1siZvXl47NXTJc0ORYA2dsT704qKM+lVSSRN4sldd+TbcnCJaaKLtMHkff
	 SfKJlNkL5h8guSKmd0Me9uWsWZCYIBa85rKbdrV18Ca38UzELO7GQROVPWzrTHMCfJ
	 QFdBWZuROAjUxl7+DX48sdEQxX7/xngz/AnUC+xaQ7wkdJF1oolh8aMOXz2mAve+hh
	 C3LVdoPqlu6sGEaRdYNI50vZs10DhqwpaJqHFXY4YWja3gycAdllpb8XCooIJE8rT+
	 LUw8ufY+z6WgQ==
Date: Fri, 10 Apr 2026 14:20:50 +0200
Message-ID: <20260410120319.528318344@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
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
Subject: [patch 29/38] nios2: Select ARCH_HAS_RANDOM_ENTROPY
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34606-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 6FC0F3D7BAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining non-architecture usage of get_cycles() is to provide
random_get_entropy().

Switch nios2 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Add 'asm/timex.h' includes to the relevant files, so the global include can
be removed once all architectures are converted over.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Dinh Nguyen <dinguyen@kernel.org>
---
 arch/nios2/Kconfig              |    1 +
 arch/nios2/include/asm/random.h |   14 ++++++++++++++
 arch/nios2/include/asm/timex.h  |    5 +----
 arch/nios2/kernel/time.c        |    4 ++--
 4 files changed, 18 insertions(+), 6 deletions(-)

--- a/arch/nios2/Kconfig
+++ b/arch/nios2/Kconfig
@@ -7,6 +7,7 @@ config NIOS2
 	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
 	select ARCH_HAS_DMA_SET_UNCACHED
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_NO_SWAP
 	select COMMON_CLK
 	select TIMER_OF
--- /dev/null
+++ b/arch/nios2/include/asm/random.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASM_NIOS2_RANDOM_H
+#define _ASM_NIOS2_RANDOM_H
+
+#include <asm/timex.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	unsigned long c = get_cycles();
+
+	return c ? c : random_get_entropy_fallback();
+}
+
+#endif
--- a/arch/nios2/include/asm/timex.h
+++ b/arch/nios2/include/asm/timex.h
@@ -5,9 +5,6 @@
 #ifndef _ASM_NIOS2_TIMEX_H
 #define _ASM_NIOS2_TIMEX_H
 
-extern cycles_t get_cycles(void);
-#define get_cycles get_cycles
-
-#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
+cycles_t get_cycles(void);
 
 #endif
--- a/arch/nios2/kernel/time.c
+++ b/arch/nios2/kernel/time.c
@@ -7,7 +7,6 @@
  * License. See the file "COPYING" in the main directory of this archive
  * for more details.
  */
-
 #include <linux/export.h>
 #include <linux/interrupt.h>
 #include <linux/clockchips.h>
@@ -19,6 +18,8 @@
 #include <linux/io.h>
 #include <linux/slab.h>
 
+#include <asm/timex.h>
+
 #define ALTR_TIMER_COMPATIBLE		"altr,timer-1.0"
 
 #define ALTERA_TIMER_STATUS_REG	0
@@ -112,7 +113,6 @@ cycles_t get_cycles(void)
 		return nios2_timer_read(&nios2_cs.cs);
 	return 0;
 }
-EXPORT_SYMBOL(get_cycles);
 
 static void nios2_timer_start(struct nios2_timer *timer)
 {


