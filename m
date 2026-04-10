Return-Path: <linux-wireless+bounces-34588-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oFciIlLs2GlGjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34588-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:25:54 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 71AA43D6F23
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:25:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3875F304489F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA3383D093F;
	Fri, 10 Apr 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uunn/bCq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B0F3C6A5F;
	Fri, 10 Apr 2026 12:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823565; cv=none; b=khBC9WsQQp4PBB1nP7lNqMcne0HAzWXEi5O1gcXdEeLR0ZhlpN5hMFWt/o1CmLVsckQEogH0ow50GK+/O0c8Wq9Y40bfolcOP9m2unAGdXrcFWeNAhrhGWZKJxhP1oe8+IBtod6MEvW9mW/MkMkG/nMGWr7BB9+RP9YxrZ+sVZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823565; c=relaxed/simple;
	bh=tLIpqPCaUi8Lfeqau43+rfn7UZ8vuvPykTPYNUPuuyU=;
	h=Date:Message-ID:From:To:Subject:References:MIME-Version:
	 Content-Type:cc; b=Jres9KWGihZd5HOXSG0kMYg/4Kndf3yrmtzyIvjR5YFsu6dLX5IaSU3wf8SIcDtfqUKAy+d493f3WHmB60G3yl2Clu7iiM9Dur0GEYVGUHS1Nh5D1erBf4kZRN1ikcJq6ypIDGcNahOSK3yUgwUtC2EOerc+gStYHuNFV3cYUO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uunn/bCq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A057C2BCB3;
	Fri, 10 Apr 2026 12:19:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823565;
	bh=tLIpqPCaUi8Lfeqau43+rfn7UZ8vuvPykTPYNUPuuyU=;
	h=Date:From:To:Subject:References:cc:From;
	b=uunn/bCqpDYdqH3aqiI0+2U/qm27AeTQwxnXbKYibcvcv2ZEX2J7abPlER3gpmuTw
	 CBdP5mMh40n2zp7Tno2Q99U//gHXFdOV0IBNQapDNZb3rSYwBD5TySsxa/Td7SLyaZ
	 p+uL6Iv9jGq9ZtmZnt8i06X/J571L31cWnZuiDLMRsOKbpHdih8iJDMdVxjdr+94oH
	 +kfrO2pFRZtB2b/jp8TX3WQWaL7ksYC/uaT6tTAybV37imt1fhiAkDjh2EPTnuViku
	 1P4aDmEJtrdQSxbhtiFRIYbjrzGEHTE4V2Fb8MxeAUFtdhNoavN7essScQIWwWoRqs
	 j/BFBM5JmmtDw==
Date: Fri, 10 Apr 2026 14:19:21 +0200
Message-ID: <20260410120318.320727701@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [patch 11/38] misc: sgi-gru: Remove get_cycles() [ab]use
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-34588-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,vger.kernel.org,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 71AA43D6F23
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Calculating a timeout from get_cycles() is a historical leftover without
any functional requirement.

Use ktime_get() instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
---
 drivers/misc/sgi-gru/gruhandles.c   |   20 ++++++++------------
 drivers/misc/sgi-gru/grukservices.c |    3 ++-
 drivers/misc/sgi-gru/grutlbpurge.c  |    5 ++---
 3 files changed, 12 insertions(+), 16 deletions(-)

--- a/drivers/misc/sgi-gru/gruhandles.c
+++ b/drivers/misc/sgi-gru/gruhandles.c
@@ -6,26 +6,22 @@
  */
 
 #include <linux/kernel.h>
+#include <linux/timekeeping.h>
 #include "gru.h"
 #include "grulib.h"
 #include "grutables.h"
 
-/* 10 sec */
 #include <linux/sync_core.h>
-#include <asm/tsc.h>
-#define GRU_OPERATION_TIMEOUT	((cycles_t) tsc_khz*10*1000)
-#define CLKS2NSEC(c)		((c) * 1000000 / tsc_khz)
+
+#define GRU_OPERATION_TIMEOUT_NSEC	(((ktime_t)10 * NSEC_PER_SEC))
 
 /* Extract the status field from a kernel handle */
 #define GET_MSEG_HANDLE_STATUS(h)	(((*(unsigned long *)(h)) >> 16) & 3)
 
 struct mcs_op_statistic mcs_op_statistics[mcsop_last];
 
-static void update_mcs_stats(enum mcs_op op, unsigned long clks)
+static void update_mcs_stats(enum mcs_op op, unsigned long nsec)
 {
-	unsigned long nsec;
-
-	nsec = CLKS2NSEC(clks);
 	atomic_long_inc(&mcs_op_statistics[op].count);
 	atomic_long_add(nsec, &mcs_op_statistics[op].total);
 	if (mcs_op_statistics[op].max < nsec)
@@ -58,21 +54,21 @@ static void report_instruction_timeout(v
 
 static int wait_instruction_complete(void *h, enum mcs_op opc)
 {
+	ktime_t start_time = ktime_get();
 	int status;
-	unsigned long start_time = get_cycles();
 
 	while (1) {
 		cpu_relax();
 		status = GET_MSEG_HANDLE_STATUS(h);
 		if (status != CCHSTATUS_ACTIVE)
 			break;
-		if (GRU_OPERATION_TIMEOUT < (get_cycles() - start_time)) {
+		if (GRU_OP_TIMEOUT_NSEC < (ktime_get() - start_time)) {
 			report_instruction_timeout(h);
-			start_time = get_cycles();
+			start_time = ktime_get();
 		}
 	}
 	if (gru_options & OPT_STATS)
-		update_mcs_stats(opc, get_cycles() - start_time);
+		update_mcs_stats(opc, (unsigned long)(ktime_get() - start_time));
 	return status;
 }
 
--- a/drivers/misc/sgi-gru/grukservices.c
+++ b/drivers/misc/sgi-gru/grukservices.c
@@ -20,6 +20,7 @@
 #include <linux/uaccess.h>
 #include <linux/delay.h>
 #include <linux/export.h>
+#include <linux/random.h>
 #include <asm/io_apic.h>
 #include "gru.h"
 #include "grulib.h"
@@ -1106,7 +1107,7 @@ static int quicktest3(unsigned long arg)
 	int ret = 0;
 
 	memset(buf2, 0, sizeof(buf2));
-	memset(buf1, get_cycles() & 255, sizeof(buf1));
+	memset(buf1, get_random_u32() & 255, sizeof(buf1));
 	gru_copy_gpa(uv_gpa(buf2), uv_gpa(buf1), BUFSIZE);
 	if (memcmp(buf1, buf2, BUFSIZE)) {
 		printk(KERN_DEBUG "GRU:%d quicktest3 error\n", smp_processor_id());
--- a/drivers/misc/sgi-gru/grutlbpurge.c
+++ b/drivers/misc/sgi-gru/grutlbpurge.c
@@ -22,13 +22,12 @@
 #include <linux/delay.h>
 #include <linux/timex.h>
 #include <linux/srcu.h>
+#include <linux/random.h>
 #include <asm/processor.h>
 #include "gru.h"
 #include "grutables.h"
 #include <asm/uv/uv_hub.h>
 
-#define gru_random()	get_cycles()
-
 /* ---------------------------------- TLB Invalidation functions --------
  * get_tgh_handle
  *
@@ -49,7 +48,7 @@ static inline int get_off_blade_tgh(stru
 	int n;
 
 	n = GRU_NUM_TGH - gru->gs_tgh_first_remote;
-	n = gru_random() % n;
+	n = get_random_u32() % n;
 	n += gru->gs_tgh_first_remote;
 	return n;
 }


