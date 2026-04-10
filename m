Return-Path: <linux-wireless+bounces-34589-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHltJ9Ts2GlLjwgAu9opvQ
	(envelope-from <linux-wireless+bounces-34589-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:28:04 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 574873D7076
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 14:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 03D02305CB9D
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Apr 2026 12:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BDE3C2770;
	Fri, 10 Apr 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bpuk5rSR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD3528469A;
	Fri, 10 Apr 2026 12:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775823570; cv=none; b=i8C6HH9w41IcaD2pHkJzFVDvm8Kf2Dmc3ORiZruIwEqFryN9zAKY9rVGfYCHklK4hQMNxpOj4+vEEvoF06hPITbkJBYQuPO4PCvLTr/Of9YFjeMi6OFHVKUDry8yXi7wKq78aT1QhwC+tY/+fNSqbMFCo2rC93kJEAthThoodk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775823570; c=relaxed/simple;
	bh=gx3RztExl/RgjhE+RVjeBSM72TbSvLK5CUYrt3EY96I=;
	h=Date:Message-ID:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=RAdwQj2oHkZDVwPH6SQGf4m/Z3+LYM14OcVhlwl7wo5p5LdSs14XHR5KR8wGmfM0pdZfolek6ptPlgoIs0vN9i5pKTibZovdb2dSeOXmHjjH0PKDmJ+ElW5uR2doYSf7RfVZbYsulE20FnKas9qCQ6pr8JUO1VVz7hYCzHE3BnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bpuk5rSR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B4F4C2BCB0;
	Fri, 10 Apr 2026 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775823570;
	bh=gx3RztExl/RgjhE+RVjeBSM72TbSvLK5CUYrt3EY96I=;
	h=Date:From:To:Cc:Subject:References:From;
	b=Bpuk5rSRR/rs1jSmitZH/KfJL+3TNuP+dz9xwjVC8e1YVix0oW3s2Pp/y+L8X9oHD
	 FfGXk8B3TY0jbEAZNS2FVq5qwscSTPNozRdmP6S1az7QsSRwh37CnHDegYmWg/dUhl
	 oXkQ09dlNxtpDlZfCfFVBtb5yeQYcj5dZxd8vIShSLkbr1gWWPlcdAHe/FZpu8mplV
	 u5Y93dLHQf7k/6QZkYgksDu7FYlgnX/m++LNPEYIEnDd7dRmUlTkWsJQwVidroG1Bi
	 MdGUi4KzTqg9X+Zn0ce3HiuHIaE9YE1XVzPbK1ak8XvacDL5nVhYnRULjmYf5QSMQ0
	 DvaPTMl303Xmg==
Date: Fri, 10 Apr 2026 14:19:27 +0200
Message-ID: <20260410120318.386500288@kernel.org>
User-Agent: quilt/0.68
From: Thomas Gleixner <tglx@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: linux-wireless@vger.kernel.org,
 Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>,
 iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>,
 netdev@vger.kernel.org,
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
Subject: [patch 12/38] wifi: wil6210: Replace get_cyles() usage
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
	FREEMAIL_CC(0.00)[vger.kernel.org,arndb.de,kernel.org,linux.intel.com,lists.linux.dev,pengutronix.de,gondor.apana.org.au,kvack.org,infradead.org,plugable.com,mit.edu,linux-foundation.org,gmail.com,google.com,googlegroups.com,alumni.ethz.ch,zx2c4.com,linaro.org,armlinux.org.uk,lists.infradead.org,arm.com,linux-m68k.org,lists.linux-m68k.org,southpole.se,gmx.de,ellerman.id.au,lists.ozlabs.org,linux.ibm.com,davemloft.net];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-34589-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 574873D7076
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

There is no reason why this debug code requires to use get_cycles() for
timing purposes.

Use ktime_get() instead.

Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Cc: linux-wireless@vger.kernel.org
---
 drivers/net/wireless/ath/wil6210/debugfs.c   |    2 +-
 drivers/net/wireless/ath/wil6210/txrx.c      |    6 +++---
 drivers/net/wireless/ath/wil6210/txrx_edma.c |    4 ++--
 drivers/net/wireless/ath/wil6210/wil6210.h   |    3 ++-
 4 files changed, 8 insertions(+), 7 deletions(-)

--- a/drivers/net/wireless/ath/wil6210/debugfs.c
+++ b/drivers/net/wireless/ath/wil6210/debugfs.c
@@ -151,7 +151,7 @@ static int ring_show(struct seq_file *s,
 			char name[10];
 			char sidle[10];
 			/* performance monitoring */
-			cycles_t now = get_cycles();
+			ktime_t now = ktime_get();
 			uint64_t idle = txdata->idle * 100;
 			uint64_t total = now - txdata->begin;
 
--- a/drivers/net/wireless/ath/wil6210/txrx.c
+++ b/drivers/net/wireless/ath/wil6210/txrx.c
@@ -1976,7 +1976,7 @@ static int __wil_tx_vring_tso(struct wil
 	used = wil_ring_used_tx(vring);
 	if (wil_val_in_range(wil->ring_idle_trsh,
 			     used, used + descs_used)) {
-		txdata->idle += get_cycles() - txdata->last_idle;
+		txdata->idle += ktime_get() - txdata->last_idle;
 		wil_dbg_txrx(wil,  "Ring[%2d] not idle %d -> %d\n",
 			     vring_index, used, used + descs_used);
 	}
@@ -2129,7 +2129,7 @@ static int __wil_tx_ring(struct wil6210_
 	used = wil_ring_used_tx(ring);
 	if (wil_val_in_range(wil->ring_idle_trsh,
 			     used, used + nr_frags + 1)) {
-		txdata->idle += get_cycles() - txdata->last_idle;
+		txdata->idle += ktime_get() - txdata->last_idle;
 		wil_dbg_txrx(wil,  "Ring[%2d] not idle %d -> %d\n",
 			     ring_index, used, used + nr_frags + 1);
 	}
@@ -2531,7 +2531,7 @@ int wil_tx_complete(struct wil6210_vif *
 			     used_new, used_before_complete)) {
 		wil_dbg_txrx(wil, "Ring[%2d] idle %d -> %d\n",
 			     ringid, used_before_complete, used_new);
-		txdata->last_idle = get_cycles();
+		txdata->last_idle = ktime_get();
 	}
 
 	/* shall we wake net queues? */
--- a/drivers/net/wireless/ath/wil6210/txrx_edma.c
+++ b/drivers/net/wireless/ath/wil6210/txrx_edma.c
@@ -1286,7 +1286,7 @@ int wil_tx_sring_handler(struct wil6210_
 				     used_new, used_before_complete)) {
 			wil_dbg_txrx(wil, "Ring[%2d] idle %d -> %d\n",
 				     ring_id, used_before_complete, used_new);
-			txdata->last_idle = get_cycles();
+			txdata->last_idle = ktime_get();
 		}
 
 again:
@@ -1499,7 +1499,7 @@ static int __wil_tx_ring_tso_edma(struct
 	used = wil_ring_used_tx(ring);
 	if (wil_val_in_range(wil->ring_idle_trsh,
 			     used, used + descs_used)) {
-		txdata->idle += get_cycles() - txdata->last_idle;
+		txdata->idle += ktime_get() - txdata->last_idle;
 		wil_dbg_txrx(wil,  "Ring[%2d] not idle %d -> %d\n",
 			     ring_index, used, used + descs_used);
 	}
--- a/drivers/net/wireless/ath/wil6210/wil6210.h
+++ b/drivers/net/wireless/ath/wil6210/wil6210.h
@@ -14,6 +14,7 @@
 #include <linux/timex.h>
 #include <linux/types.h>
 #include <linux/irqreturn.h>
+#include <linux/timekeeping.h>
 #include "wmi.h"
 #include "wil_platform.h"
 #include "fw.h"
@@ -632,7 +633,7 @@ struct wil_txrx_ops {
 struct wil_ring_tx_data {
 	bool dot1x_open;
 	int enabled;
-	cycles_t idle, last_idle, begin;
+	ktime_t idle, last_idle, begin;
 	u8 agg_wsize; /* agreed aggregation window, 0 - no agg */
 	u16 agg_timeout;
 	u8 agg_amsdu;


