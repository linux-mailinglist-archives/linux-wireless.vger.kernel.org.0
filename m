Return-Path: <linux-wireless+bounces-24310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15C46AE28D7
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 13:35:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2EFA27A8D3E
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 11:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EA6206F2A;
	Sat, 21 Jun 2025 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="HxOCC+8j";
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="bklw8Df8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [78.46.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87F61F3BAE;
	Sat, 21 Jun 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505707; cv=none; b=bmvow/0pFq72/cCoRo7UxFhSs0Ogw0yGeh4j6KeKPTkfI3M7DYuMAsFMTbDN9CT4VINIO28I5+rxpt4yLAYIWjKsjVKsiDmIuPV/Pz3DSOPGY5p7gD6YbP0WcFKzSppy0QRgUdT+a25CclIoNCRwv5vIbwz+iKm1AjO+KXMMj0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505707; c=relaxed/simple;
	bh=zOTrb3kuMMd0YVV8FliK7cqEdxGgOmIKIt+TlxhEpCE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=My+bVD1E8LkxY/3DuLT74pkLHl6OowPkIwZyyk1eqhF/aOuWP3IL8YYvt1uQDEaglUBjPB5HOGAV+oBparsiSOy8xi+6imJVVMUkyzH4S25Ss0DqOGv5aZ2vsKf5aZTZGePaHb8+bIuninlCfc5llA2ssliemvfyN3NPtJ05YFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de; spf=pass smtp.mailfrom=czerwinskis.de; dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b=HxOCC+8j; dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b=bklw8Df8; arc=none smtp.client-ip=78.46.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=czerwinskis.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
	s=mail; t=1750505359;
	bh=zOTrb3kuMMd0YVV8FliK7cqEdxGgOmIKIt+TlxhEpCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HxOCC+8jVMMmYEVE5Y4ROVGsjXQRlyPFSavGrtOkqkIJ6cIMp7GVPJXhod+/bpZLm
	 A9iKD28mLEUA5Sc52gvkK2ozRM3NcVd17qpxKmCUtG4K2zax3gFhcIDMIGuRblnyLo
	 AIqap+rrDlwwwBcMUokOqA8aBIj9J1jnfIy1EqJM=
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
	id 7156E96984; Sat, 21 Jun 2025 13:29:19 +0200 (CEST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
	s=mail; t=1750505358;
	bh=zOTrb3kuMMd0YVV8FliK7cqEdxGgOmIKIt+TlxhEpCE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bklw8Df8JfO4eK+Rh3rbd0QcvX4/g/JIQJZinyaXdUeOZeA2wEi0vfnMX3PRIlAfC
	 SlEQIIVLDpqkYlT/AQUZe3VcakY+dBqYF4OjW+LmueCxdURiaEXV9hfLSnf880uxtS
	 aGOH6l3yK9g2GYbeO4SGxnaf+8GYhrhQHauQY6iI=
Received: from localhost (unknown [IPv6:2a0e:c5c1:0:100:cc93:f0a3:c76:aa90])
	by magratgarlick.emantor.de (Postfix) with ESMTPSA id 5C3399697B;
	Sat, 21 Jun 2025 13:29:18 +0200 (CEST)
From: Rouven Czerwinski <rouven@czerwinskis.de>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <rouven@czerwinskis.de>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] brcmfmac: remove always true variable and code
Date: Sat, 21 Jun 2025 13:29:11 +0200
Message-ID: <20250621112912.180436-2-rouven@czerwinskis.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250621112912.180436-1-rouven@czerwinskis.de>
References: <20250621112912.180436-1-rouven@czerwinskis.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bus->intr variable was always set to true inside the probe attach
function, remove it. Also remove the code that depends on the variable
to be set on false.

Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 25 -------------------
 1 file changed, 25 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index 26e09a7acb02..861c7f51b4cd 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -474,7 +474,6 @@ struct brcmf_sdio {
 
 	u8 sdpcm_ver;	/* Bus protocol reported by dongle */
 
-	bool intr;		/* Use interrupts */
 	atomic_t ipend;		/* Device interrupt is pending */
 	uint spurious;		/* Count of spurious interrupts */
 
@@ -2327,8 +2326,6 @@ static uint brcmf_sdio_sendfromq(struct brcmf_sdio *bus, uint maxframes)
 {
 	struct sk_buff *pkt;
 	struct sk_buff_head pktq;
-	u32 intstat_addr = bus->sdio_core->base + SD_REG(intstatus);
-	u32 intstatus = 0;
 	int ret = 0, prec_out, i;
 	uint cnt = 0;
 	u8 tx_prec_map, pkt_num;
@@ -2361,21 +2358,6 @@ static uint brcmf_sdio_sendfromq(struct brcmf_sdio *bus, uint maxframes)
 		ret = brcmf_sdio_txpkt(bus, &pktq, SDPCM_DATA_CHANNEL);
 
 		cnt += i;
-
-		/* In poll mode, need to check for other events */
-		if (!bus->intr) {
-			/* Check device status, signal pending interrupt */
-			sdio_claim_host(bus->sdiodev->func1);
-			intstatus = brcmf_sdiod_readl(bus->sdiodev,
-						      intstat_addr, &ret);
-			sdio_release_host(bus->sdiodev->func1);
-
-			bus->sdcnt.f2txdata++;
-			if (ret != 0)
-				break;
-			if (intstatus & bus->hostintmask)
-				atomic_set(&bus->ipend, 1);
-		}
 	}
 
 	/* Deflow-control stack if needed */
@@ -3653,10 +3635,6 @@ void brcmf_sdio_isr(struct brcmf_sdio *bus, bool in_isr)
 			brcmf_err("failed backplane access\n");
 		}
 
-	/* Disable additional interrupts (is this needed now)? */
-	if (!bus->intr)
-		brcmf_err("isr w/o interrupt configured!\n");
-
 	bus->dpc_triggered = true;
 	queue_work(bus->brcmf_wq, &bus->datawork);
 }
@@ -4037,9 +4015,6 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 	bus->rxhdr = (u8 *) roundup((unsigned long)&bus->hdrbuf[0],
 				    bus->head_align);
 
-	/* Set the poll and/or interrupt flags */
-	bus->intr = true;
-
 	return 0;
 
 fail:
-- 
2.49.0


