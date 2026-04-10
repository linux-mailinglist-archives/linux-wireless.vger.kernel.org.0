Return-Path: <linux-wireless+bounces-34609-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SFITFo3y2GnrjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34609-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:52:29 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 555123D7BC5
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:52:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 7465E30E0904
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42A543E1206;
	Fri, 10 Apr 2026 12:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uoiHjWjo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD6C3C1413;
	Fri, 10 Apr 2026 12:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823668; cv=none; b=IbLGk1L/E6nOM5Vsb6/rI0/XomR+RgXkuNIqPCT2qdw/h6cozWQ3z9uPf8eHYDNda1Q7Pt/jGVhFmosiTgDhqLLWuw4heO0c/nF0C0lVGJkAUxmZ460xJbU6jrrdooN6HcVFnwiz6Ag7JN2zi6j8x8MvkQlsntNBgYeTq7mQ2YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823668; c=relaxed/simple;
	bh=ql5fkS0UEXw/nBMHEudu1ngsgqvxlZvUknLeTtAAGUU=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=m3KWOeIb+RkssioSPSmun5zFtPW/ZFmiAb9L0exrDr64p2CzZauXSF2rVyaVIpnrUS3tCGWItPASIt0UZWVqbr+dyp/coEQeojoKWRqI0wSCZxMzd9NeCN2AuGdnAxl7PQ6Di7+DUYIoawIpYDY7eMC0CKb1HYVxka4zRwhUjOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uoiHjWjo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7FAAC19421;
	Fri, 10 Apr 2026 12:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823667;
	bh=ql5fkS0UEXw/nBMHEudu1ngsgqvxlZvUknLeTtAAGUU=;
	h=Date:From:To:Cc:Subject:References:From;
	b=uoiHjWjoWcWN7Tw6xiUbL/Io/RlHzIChPqiGJJ7RtYjsrncirPNTd0U6jsMefBLBl
	 PuEP8rIYZGWPrDUGiB7D/1OZBxXBypGlDQEoNlUgfhKncfE0Vht3vVd8dR09fIJYz6
	 LaRap+OM72T7ij93UcDxrSAuxRJvyqDUwai7p79fd01gYNQNCFb6LttF4gur8fMl1Z
	 TmanYlU2xNYAREOAaMNh8AIeZ2WEpNPx/37VkP03IexczKkHFgtDwEiwY8TvmgoUyG
	 zdqSX2TqLhRdpCyZVVz2iZYLDeqcR5cB1pNHnjTlrpzblDMQ8i7KXktiKriMpSMGuM
	 +dQ/qJxaC9obA==
Date: Fri, 10 Apr 2026 14:21:04 +0200
Message-ID: <20260410120319.723429844@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org,
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
 Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
Subject: [patch 32/38] powerpc/spufs: Use mftb() directly
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[ellerman.id.au,lists.ozlabs.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34609-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
X-Rspamd-Queue-Id: 555123D7BC5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no reason to indirect via get_cycles(), which is about to be
removed.

Use mftb() directly.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
---
 arch/powerpc/platforms/cell/spufs/switch.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/arch/powerpc/platforms/cell/spufs/switch.c
+++ b/arch/powerpc/platforms/cell/spufs/switch.c
@@ -34,6 +34,7 @@
 #include <asm/spu_priv1.h>
 #include <asm/spu_csa.h>
 #include <asm/mmu_context.h>
+#include <asm/time.h>
 
 #include "spufs.h"
 
@@ -279,7 +280,7 @@ static inline void save_timebase(struct
 	 *    Read PPE Timebase High and Timebase low registers
 	 *    and save in CSA.  TBD.
 	 */
-	csa->suspend_time = get_cycles();
+	csa->suspend_time = mftb();
 }
 
 static inline void remove_other_spu_access(struct spu_state *csa,
@@ -1261,7 +1262,7 @@ static inline void setup_decr(struct spu
 	 *     in LSCSA.
 	 */
 	if (csa->priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING) {
-		cycles_t resume_time = get_cycles();
+		cycles_t resume_time = mftb();
 		cycles_t delta_time = resume_time - csa->suspend_time;
 
 		csa->lscsa->decr_status.slot[0] = SPU_DECR_STATUS_RUNNING;


