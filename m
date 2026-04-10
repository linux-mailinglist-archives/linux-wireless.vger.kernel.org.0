Return-Path: <linux-wireless+bounces-34614-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wCfvLffv2GnrjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34614-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:41:27 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D4183D780B
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 30D3E30BA5F5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECDB3E4C8B;
	Fri, 10 Apr 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jCHje7Cb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB53A3E9A;
	Fri, 10 Apr 2026 12:21:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823691; cv=none; b=J1oNwjvmCLnfKhTbJ1jbkpZaNX4tmeLT+0TZIFwTNp8+dEHXD0BAJ8LjTQrfNOb+rnZEclzZskWt4JrQZlUZIRmusc5t+RIGeXLATMQLLeSgMXsUTp6u3vg5dfM3XMTb9/8+GKomJApf4bJmOeStWzurRmtjGR5cJNHYMElP/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823691; c=relaxed/simple;
	bh=Q+IGONPkRqfayguG6Txkx/mXXA1oIi3CJxpKCndboyw=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=S/c/hFRyqUT9ZOjZCcPINvPUyNOdY7cwTs2sraNpsn4SqQK6UFfoUq3dAPEBmdtG1389mpHFucbvHdVSwQTiOXz45nbeuxA4QzRJxEbBnzU0VaLmJWOwryF2dOJHSSQdWcjAUxJlsIXnfAXKOvwDMErNg53LzEXKTV0PKvl42S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jCHje7Cb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A92C19421;
	Fri, 10 Apr 2026 12:21:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823691;
	bh=Q+IGONPkRqfayguG6Txkx/mXXA1oIi3CJxpKCndboyw=;
	h=Date:From:To:Cc:Subject:References:From;
	b=jCHje7Cbtua5yolIUEErxzzrufBxMW0LYt1Kl8DVF/tR3HVJLQOi/32jC1MsFj4sU
	 FuxQN5MUq6aUGx6W7VIPg9yzFSdqaZMbr1tHN5zCNxM830u3a1p54HzWCg2l8d0SzU
	 xyIH4nNx8yib1hODU1iz6RiEcKM7mp5gg40/5f4Y1z++7yY40Cew7vRxlBQZnDz2BW
	 SRGp9xUTNtuoCzThvYns7ndknYQX1oh8mSimdrkytbEv0fT97jYIikQFCA2/G5YDNs
	 jkUQfDUfGpJwZkehI6Gounl+WGkLz5eknKnsUFvTrSUQCfxc7Qg1pWGasV1G+9O2Ak
	 9A3OklGLFCHng==
Date: Fri, 10 Apr 2026 14:21:28 +0200
Message-ID: <20260410120320.081003009@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: x86@kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
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
Subject: [patch 37/38] x86: Select ARCH_HAS_RANDOM_ENTROPY
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
	FREEMAIL_CC(0.00)[kernel.org,arndb.de,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34614-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 6D4183D780B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining usage of get_cycles() is to provide random_get_entropy().

Switch x86 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
providing random_get_entropy() in asm/random.h.

Remove asm/timex.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: x86@kernel.org
---
 arch/x86/Kconfig              |    1 +
 arch/x86/include/asm/random.h |   16 ++++++++++++++++
 arch/x86/include/asm/timex.h  |   17 -----------------
 arch/x86/include/asm/tsc.h    |    9 ---------
 4 files changed, 17 insertions(+), 26 deletions(-)

--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -101,6 +101,7 @@ config X86
 	select ARCH_HAS_PREEMPT_LAZY
 	select ARCH_HAS_PTDUMP
 	select ARCH_HAS_PTE_SPECIAL
+	select ARCH_HAS_RANDOM_ENTROPY
 	select ARCH_HAS_HW_PTE_YOUNG
 	select ARCH_HAS_NONLEAF_PMD_YOUNG	if PGTABLE_LEVELS > 2
 	select ARCH_HAS_UACCESS_FLUSHCACHE	if X86_64
--- /dev/null
+++ b/arch/x86/include/asm/random.h
@@ -0,0 +1,16 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_RANDOM_H
+#define _ASM_X86_RANDOM_H
+
+#include <asm/processor.h>
+#include <asm/tsc.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	if (!IS_ENABLED(CONFIG_X86_TSC) &&
+	    !cpu_feature_enabled(X86_FEATURE_TSC))
+		return random_get_entropy_fallback();
+	return rdtsc();
+}
+
+#endif /* _ASM_X86_RANDOM_H */
--- a/arch/x86/include/asm/timex.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_TIMEX_H
-#define _ASM_X86_TIMEX_H
-
-#include <asm/processor.h>
-#include <asm/tsc.h>
-
-static inline unsigned long random_get_entropy(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return random_get_entropy_fallback();
-	return rdtsc();
-}
-#define random_get_entropy random_get_entropy
-
-#endif /* _ASM_X86_TIMEX_H */
--- a/arch/x86/include/asm/tsc.h
+++ b/arch/x86/include/asm/tsc.h
@@ -72,15 +72,6 @@ extern unsigned int tsc_khz;
 
 extern void disable_TSC(void);
 
-static inline cycles_t get_cycles(void)
-{
-	if (!IS_ENABLED(CONFIG_X86_TSC) &&
-	    !cpu_feature_enabled(X86_FEATURE_TSC))
-		return 0;
-	return rdtsc();
-}
-#define get_cycles get_cycles
-
 extern void tsc_early_init(void);
 extern void tsc_init(void);
 extern void mark_tsc_unstable(char *reason);


