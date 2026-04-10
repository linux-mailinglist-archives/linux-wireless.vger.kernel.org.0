Return-Path: <linux-wireless+bounces-34578-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2KXmHbrq2GkXjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34578-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:19:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 265EF3D69ED
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6BF80302C5CA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:18:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 766563C198C;
	Fri, 10 Apr 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PujwWQLA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CDEF3A3E8D;
	Fri, 10 Apr 2026 12:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823516; cv=none; b=mV1EwIWrnJjKV4EN0w82wQhK11qezHqqED77RRYJ1/82o7EczF5P//rhn8aqmaLZhK0/GLwShT3E3Tn7Y3YaHF8Ckn7/gZpdakiowsYYzRC0+tx3wZPsYXY65MjUNYEHknXeZE7FrKIdc1UE/g3FR8gosbq1elgZD2CWuLPI8V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823516; c=relaxed/simple;
	bh=Qxe5s7KoLSq5kG1N2smycXiRWybB8taeJTlNsbfy0fg=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=SuYLMO6gKlYYvAnjNGuRqiJ1pqLOOSrsBWh/ho6wjg28d+dFAU98jwoW55HsI1Vo9BBL6pZWqXbP75Ot9vOnl+jSewq0Cb3eDtr1wFOcbn4/eWCwK1LuXA74f2tw97ebuWz8tftzHX/ItaYBZR71Ve7WfuvG4DT598LWvUeYB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PujwWQLA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF48C2BC87;
	Fri, 10 Apr 2026 12:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823515;
	bh=Qxe5s7KoLSq5kG1N2smycXiRWybB8taeJTlNsbfy0fg=;
	h=Date:From:To:Cc:Subject:References:From;
	b=PujwWQLA2dOIyLlZvIM0oB1Wg7c5ZIyCwzH/XHGNRGehg+YFil6OmFstHyfDwz6a4
	 UXi7viGoUKPW4HP65M0H75qRplTYAji9Z6ikhUQOkcZXvM13Netjmq5O6I/+9+JQ+w
	 bxUrL+dmChTEREYE3VSmYBwXmygVivr7jmb4e0itrCIHXq31ae3WiG49uZ0Z2PTGdc
	 +od1M1yaD34oi/oFSPoyZ73JAQOxw0kf9oLJ4YVR9wqn75mlEWMpZuBIxST6yrXcHs
	 fYRNY0LFjGxQtZU4+RTQobyzbJWEzJNsARBCqXSJyY40dbr06WXMHmkuYa6yNGx2XV
	 5kZ5/s9dunCZA==
Date: Fri, 10 Apr 2026 14:18:32 +0200
Message-ID: <20260410120317.642797961@kernel.org>
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
Subject: [patch 01/38] percpu: Sanitize __percpu_qual include hell
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
	TAGGED_FROM(0.00)[bounces-34578-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 265EF3D69ED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Slapping __percpu_qual into the next available header is sloppy at best.

It's required by __percpu which is defined in compiler_types.h and that is
meant to be included without requiring a boatload of other headers so that
a struct or function declaration can contain a __percpu qualifier w/o
further prerequisites.

This implicit dependency on linux/percpu.h makes that impossible and causes
a major problem when trying to seperate headers.

Create asm/percpu_types.h and move it there. Include that from
compiler_types.h and the whole recursion problem goes away.

Signed-off-by: Thomas Gleixner <tglx@kernel.org
Cc: Arnd Bergmann <arnd@arndb.de>
---
 arch/x86/include/asm/percpu.h       |    5 -----
 arch/x86/include/asm/percpu_types.h |   17 +++++++++++++++++
 include/asm-generic/Kbuild          |    1 +
 include/asm-generic/percpu_types.h  |   20 ++++++++++++++++++++
 include/linux/compiler_types.h      |    1 +
 5 files changed, 39 insertions(+), 5 deletions(-)

--- a/arch/x86/include/asm/percpu.h
+++ b/arch/x86/include/asm/percpu.h
@@ -40,12 +40,10 @@
 #endif
 
 #define __percpu_prefix
-#define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
 
 #else /* !CONFIG_CC_HAS_NAMED_AS: */
 
 #define __percpu_prefix		__force_percpu_prefix
-#define __percpu_seg_override
 
 #endif /* CONFIG_CC_HAS_NAMED_AS */
 
@@ -82,7 +80,6 @@
 
 #define __force_percpu_prefix
 #define __percpu_prefix
-#define __percpu_seg_override
 
 #define PER_CPU_VAR(var)	(var)__percpu_rel
 
@@ -92,8 +89,6 @@
 # define __my_cpu_type(var)	typeof(var)
 # define __my_cpu_ptr(ptr)	(ptr)
 # define __my_cpu_var(var)	(var)
-
-# define __percpu_qual		__percpu_seg_override
 #else
 # define __my_cpu_type(var)	typeof(var) __percpu_seg_override
 # define __my_cpu_ptr(ptr)	(__my_cpu_type(*(ptr))*)(__force uintptr_t)(ptr)
--- /dev/null
+++ b/arch/x86/include/asm/percpu_types.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PERCPU_TYPES_H
+#define _ASM_X86_PERCPU_TYPES_H
+
+#if defined(CONFIG_SMP) && defined(CONFIG_CC_HAS_NAMED_AS)
+#define __percpu_seg_override	CONCATENATE(__seg_, __percpu_seg)
+#else /* !CONFIG_CC_HAS_NAMED_AS: */
+#define __percpu_seg_override
+#endif
+
+#if defined(CONFIG_USE_X86_SEG_SUPPORT) && defined(USE_TYPEOF_UNQUAL)
+#define __percpu_qual		__percpu_seg_override
+#endif
+
+#include <asm-generic/percpu_types.h>
+
+#endif
--- a/include/asm-generic/Kbuild
+++ b/include/asm-generic/Kbuild
@@ -44,6 +44,7 @@ mandatory-y += module.lds.h
 mandatory-y += msi.h
 mandatory-y += pci.h
 mandatory-y += percpu.h
+mandatory-y += percpu_types.h
 mandatory-y += pgalloc.h
 mandatory-y += preempt.h
 mandatory-y += rqspinlock.h
--- /dev/null
+++ b/include/asm-generic/percpu_types.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_GENERIC_PERCPU_TYPES_H_
+#define _ASM_GENERIC_PERCPU_TYPES_H_
+
+#ifndef __ASSEMBLER__
+/*
+ * __percpu_qual is the qualifier for the percpu named address space.
+ *
+ * Most arches use generic named address space for percpu variables but
+ * some arches define percpu variables in different named address space
+ * (on the x86 arch, percpu variable may be declared as being relative
+ * to the %fs or %gs segments using __seg_fs or __seg_gs named address
+ * space qualifier).
+ */
+#ifndef __percpu_qual
+# define __percpu_qual
+#endif
+
+#endif /* __ASSEMBLER__ */
+#endif /* _ASM_GENERIC_PERCPU_TYPES_H_ */
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -41,6 +41,7 @@
 # define BTF_TYPE_TAG(value) /* nothing */
 #endif
 
+#include <asm/percpu_types.h>
 #include <linux/compiler-context-analysis.h>
 
 /* sparse defines __CHECKER__; see Documentation/dev-tools/sparse.rst */


