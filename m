Return-Path: <linux-wireless+bounces-34613-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GBLvHWrv2GnrjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34613-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:39:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 211FD3D76F1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 211C8303C617
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:30:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3071F3E3DB0;
	Fri, 10 Apr 2026 12:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z5xk9L5P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 069B13D16EF;
	Fri, 10 Apr 2026 12:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823687; cv=none; b=Iltf4HY8TVYdhxP/aCdfXoyHROkHGYJgBZJzzX1KgGnVL9+rUf1saoW1lJirwKGYkZ/G97g5Wv+zdDsOPboTxPrkLhCBrzRGfudI/7+e7TCous1Y+ukxZJ6qhfD3s90QditFN8DJi4DOH+H7qve7tEC8TRQFWjFZPjbdIdVN2lA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823687; c=relaxed/simple;
	bh=506UQ2xUMl1Z9eAzOmzEcIl1RJxUk5Zj30ohtcXoKMY=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=EQ2WoTuQYwMBEeLSfQR0xoasgwlKqgvpu0PgFB3SdJt0W9lfBUOYyBYYksD639tl24yoBCmF7hB22A0J4FV92lWHL1gi0Hz5GmO7NBhqgzMgZH9gdGaBOdVxcOMojdHa1W5KH2t4ODlmmIfm+ZIRBkMrx/MLR5UzSMebj5YwSMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z5xk9L5P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5EE3C19425;
	Fri, 10 Apr 2026 12:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823686;
	bh=506UQ2xUMl1Z9eAzOmzEcIl1RJxUk5Zj30ohtcXoKMY=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Z5xk9L5P21mRx0MY/8DBEFXub59mdEbOhszRMhCXrj2F4yR3gtSSMVH5Ys886C70h
	 ecuez10MlaZM3qSzOJIlSqs3GQHIX7r46PbtHbTSey1wj2Xf5OquvDCTW6/Y/BwsaZ
	 HOnECp9mbfgHCsi29AhbrdwXxEeghdlmA/P/QGWQbNRq0XZzEiWDbqYK6jtMl2Fqel
	 J/j1quCkWsAMuIIV68vkZDLkhw3pICkV08QoM7gE4lID3deNtskLbUzyP0Y6rIWxr9
	 E+31Ou3bfkNfr/XyUr2BTZMkGgo/VhX2L0FM/Xl0m04u+cc79US3jzI6GNXqNN3Dgi
	 kUVIHjYrNe9Wg==
Date: Fri, 10 Apr 2026 14:21:23 +0200
Message-ID: <20260410120320.011762129@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org,
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
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org
Subject: [patch 36/38] sparc: Select ARCH_HAS_RANDOM_ENTROPY for SPARC64
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34613-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
X-Rspamd-Queue-Id: 211FD3D76F1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The only remaining usage of get_cycles() is to provide random_get_entropy().

Switch sparc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
and providing random_get_entropy() in asm/random.h.

Remove asm/timex*.h as it has no functionality anymore.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
---
 arch/sparc/Kconfig                |    1 +
 arch/sparc/include/asm/random.h   |   15 +++++++++++++++
 arch/sparc/include/asm/timex.h    |    9 ---------
 arch/sparc/include/asm/timex_64.h |   15 ---------------
 arch/sparc/kernel/pcic.c          |    1 -
 arch/sparc/kernel/time_32.c       |    1 -
 arch/sparc/vdso/vclock_gettime.c  |    1 -
 7 files changed, 16 insertions(+), 27 deletions(-)

--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -71,6 +71,7 @@ config SPARC64
 	def_bool 64BIT
 	select ALTERNATE_USER_ADDRESS_SPACE
 	select ARCH_HAS_DELAY_TIMER
+	select ARCH_HAS_RANDOM_ENTROPY
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_KRETPROBES
--- /dev/null
+++ b/arch/sparc/include/asm/random.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _ASMsparc_RANDOM_H
+#define _ASMsparc_RANDOM_H
+
+#if defined(__sparc__) && defined(__arch64__)
+
+#include <asm/timer.h>
+
+static inline unsigned long random_get_entropy(void)
+{
+	return tick_ops->get_tick();
+}
+
+#endif
+#endif
--- a/arch/sparc/include/asm/timex.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef ___ASM_SPARC_TIMEX_H
-#define ___ASM_SPARC_TIMEX_H
-#if defined(__sparc__) && defined(__arch64__)
-#include <asm/timex_64.h>
-#else
-#include <asm-generic/timex.h>
-#endif
-#endif
--- a/arch/sparc/include/asm/timex_64.h
+++ b/arch/sparc/include/asm/timex_64.h
@@ -1,15 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * linux/include/asm/timex.h
- *
- * sparc64 architecture timex specifications
- */
-#ifndef _ASMsparc64_TIMEX_H
-#define _ASMsparc64_TIMEX_H
-
-#include <asm/timer.h>
-
-/* Getting on the cycle counter on sparc64. */
-#define get_cycles()	tick_ops->get_tick()
-
-#endif
--- a/arch/sparc/kernel/pcic.c
+++ b/arch/sparc/kernel/pcic.c
@@ -33,7 +33,6 @@
 #include <asm/oplib.h>
 #include <asm/prom.h>
 #include <asm/pcic.h>
-#include <asm/timex.h>
 #include <asm/timer.h>
 #include <linux/uaccess.h>
 #include <asm/irq_regs.h>
--- a/arch/sparc/kernel/time_32.c
+++ b/arch/sparc/kernel/time_32.c
@@ -37,7 +37,6 @@
 
 #include <asm/mc146818rtc.h>
 #include <asm/oplib.h>
-#include <asm/timex.h>
 #include <asm/timer.h>
 #include <asm/irq.h>
 #include <asm/io.h>
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -17,7 +17,6 @@
 #include <linux/string.h>
 #include <asm/io.h>
 #include <asm/unistd.h>
-#include <asm/timex.h>
 #include <asm/clocksource.h>
 #include <asm/vvar.h>
 


