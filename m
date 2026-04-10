Return-Path: <linux-wireless+bounces-34601-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKBXDxDu2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34601-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:33:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E0193D7333
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 46802304F7E6
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18B8C3DC4B4;
	Fri, 10 Apr 2026 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UacNbv5z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D217D3CD8B5;
	Fri, 10 Apr 2026 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823629; cv=none; b=fgvGLK9QvpNS98Bhjjb9i0aTw8UZr7f90SuvH9ZMi+Vk2hZlWBZiIJYLNylxpXVVqmmFZ6iqQ75K/6ejzKFn/ynDla28rTlQg52xPyxf6N9cS5FrCSdLc25KENkK2rL+xmBwgMlVN6HkwB9I1mSPXGzjcU8lCaazIqyPZ6Qdngw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823629; c=relaxed/simple;
	bh=Xj914OB0ywB5KtjAdUFbVTIri4m7J0/9GAWloccpVyg=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=H2GCUz2KT+SoxPKaVXy8PbUO11xism9fwtAnwZeYciKxJ5yDNWqp6Qxcv/fyBHruroV1S/2dMo2plV68PJE/P63fyNuFdIoio0Qgz9Pq6Ia1Om55rtGtGzGUSGICMv+tHDOI9YgF6PacuUwIr/FYBcHzzfYuQnycW4XMI3F4Czo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UacNbv5z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8258C2BCAF;
	Fri, 10 Apr 2026 12:20:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823629;
	bh=Xj914OB0ywB5KtjAdUFbVTIri4m7J0/9GAWloccpVyg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=UacNbv5zzA6AzbAlRM4n4U5NaKejyQd8mANj0iWZ5RQiRAJWixjyMgZjbiDhDTyzO
	 ay62PPnTA47MG/rmdeWa/4KfjNAnW4xtTzJ34RAhThlg0KY8nNByGNrsu9zE469dPQ
	 hWtTJvAZ4ZE2brA8ZCckIrkzYMvi5clv/chlzjJ3PYteh92RUSFzhMNQu3+ZTJTDCI
	 kJ6mPTSZ1AZhD1XvkSSEOtM9nEZR/77fxCsYwUjbpiFSE3ESK6EP7pbE6Ao/WrdTRD
	 AlaT3EdsheI/WmWdaf0zz7rbsJUIcktKioLIztC89PcrEqXmxk39mPCnXjzI5yFh8X
	 xNx6W4PqnkQAQ==
Date: Fri, 10 Apr 2026 14:20:26 +0200
Message-ID: <20260410120319.197793115@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Russell King <linux@armlinux.org.uk>,
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
Subject: [patch 24/38] ARM: Select ARCH_HAS_RANDOM_ENTROPY
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[armlinux.org.uk,lists.infradead.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34601-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 9E0193D7333
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining usage of get_cycles() is to provide
random_get_entropy().

Switch ARM over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org
---
 arch/arm/Kconfig              |    1 +
 arch/arm/include/asm/random.h |   14 ++++++++++++++
 arch/arm/include/asm/timex.h  |   18 ------------------
 arch/arm/lib/delay.c          |    4 ++--
 4 files changed, 17 insertions(+), 20 deletions(-)

--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -22,6 +22,7 @@ config ARM
 	select ARCH_HAS_MEMBARRIER_SYNC_CORE
 	select ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	select ARCH_HAS_PTE_SPECIAL if ARM_LPAE
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_SETUP_DMA_OPS
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_STACKWALK
--- /dev/null
+++ b/arch/arm/include/asm/random.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASMARM_RANDOM_H
+#define _ASMARM_RANDOM_H
+
+bool delay_read_timer(unsigned long *t);
+
+static inline unsigned long random_get_entropy(void)
+{
+	unsigned long t;
+
+	return delay_read_timer(&t) ? t : random_get_entropy_fallback();
+}
+
+#endif
--- a/arch/arm/include/asm/timex.h
+++ /dev/null
@@ -1,18 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- *  arch/arm/include/asm/timex.h
- *
- *  Copyright (C) 1997,1998 Russell King
- *
- *  Architecture Specific TIME specifications
- */
-#ifndef _ASMARM_TIMEX_H
-#define _ASMARM_TIMEX_H
-
-// Temporary workaround
-bool delay_read_timer(unsigned long *t);
-
-#define get_cycles()	({ cycles_t c; delay_read_timer(&c) ? 0 : c; })
-#define random_get_entropy() (((unsigned long)get_cycles()) ?: random_get_entropy_fallback())
-
-#endif
--- a/arch/arm/lib/delay.c
+++ b/arch/arm/lib/delay.c
@@ -42,9 +42,9 @@ static inline u64 cyc_to_ns(u64 cyc, u32
 
 static void __timer_delay(unsigned long cycles)
 {
-	cycles_t start = get_cycles();
+	cycles_t start = delay_timer->read_current_timer();
 
-	while ((get_cycles() - start) < cycles)
+	while ((delay_timer->read_current_timer() - start) < cycles)
 		cpu_relax();
 }
 


