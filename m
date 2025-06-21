Return-Path: <linux-wireless+bounces-24311-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5AAAE28D9
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 13:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CC627A99DE
	for <lists+linux-wireless@lfdr.de>; Sat, 21 Jun 2025 11:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E49821324E;
	Sat, 21 Jun 2025 11:35:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="rvkqfDKf";
	dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b="fhawEpOI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from magratgarlick.emantor.de (magratgarlick.emantor.de [78.46.208.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87431E570D;
	Sat, 21 Jun 2025 11:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.46.208.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750505709; cv=none; b=QwdZCiCB6UNDkwsCahuSWWWdaG/fPrtj/hKb7Wtz544BIAo40rbSeDt0toS07UHT3yQkKbvO7+FYyFxCsY/neUBXtKeDOv/UXweHKuLWq33wrLhD5gebnylonJs4gpsZkLc3X5reebvv7vItGpdI87J8Z6e+oVp5LMJE4nPYWo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750505709; c=relaxed/simple;
	bh=wtQdv7kksrOQPuEY+BaKisntblqSf0kwZEDIPm6kl9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J0PnuAnsozFI83Km/11zzkvxfAqLel/oufBAlBorucWOFevb5omVUdTHOvXs7xqx88gmOIaXJpzhGzD+OppxxYnIYg7uvLNp25NW8IdlIwPYtpa4FF7DcI9XknKHtBttaoolDdBXKxkX6mzt0C1Eh4vpEdrAble4ddP3VCTrN70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de; spf=pass smtp.mailfrom=czerwinskis.de; dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b=rvkqfDKf; dkim=pass (1024-bit key) header.d=czerwinskis.de header.i=@czerwinskis.de header.b=fhawEpOI; arc=none smtp.client-ip=78.46.208.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=czerwinskis.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=czerwinskis.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
	s=mail; t=1750505357;
	bh=wtQdv7kksrOQPuEY+BaKisntblqSf0kwZEDIPm6kl9c=;
	h=From:To:Cc:Subject:Date:From;
	b=rvkqfDKfFZxb3xOuEPo7zG5S0eEdwePwawZVcwrIrfMwhUfU/nbQY9yFKG2meg9Br
	 u+ANVyxxuUn+xWH8/Ht5ZmRK165P+vmS5G6k+rNscMuI4X+JnB9Cy5vk+uWV72TK5l
	 Z5AdztY8EMQgXwiFpX0eOp3lSllRgbTauz27ITiE=
Received: by magratgarlick.emantor.de (Postfix, from userid 114)
	id 4321096628; Sat, 21 Jun 2025 13:29:17 +0200 (CEST)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=czerwinskis.de;
	s=mail; t=1750505356;
	bh=wtQdv7kksrOQPuEY+BaKisntblqSf0kwZEDIPm6kl9c=;
	h=From:To:Cc:Subject:Date:From;
	b=fhawEpOI5rnHuiuSwfsdeMaxCMtU+QRnR5OnxKsfcF9JicQOix1YlhDP8GKQN+dUO
	 Y9rKgAHYvFa04gxplfhmrRN9LSIWorGlafhYYOLOjIQZORbaz6ELhtQn/bUZxoHdut
	 tbpVKScbXl9mF+yaE7AEe20eMhxuhqfM2o9RvkiQ=
Received: from localhost (unknown [IPv6:2a0e:c5c1:0:100:cc93:f0a3:c76:aa90])
	by magratgarlick.emantor.de (Postfix) with ESMTPSA id 07E3B96628;
	Sat, 21 Jun 2025 13:29:16 +0200 (CEST)
From: Rouven Czerwinski <rouven@czerwinskis.de>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
Cc: kernel@pengutronix.de,
	Rouven Czerwinski <rouven@czerwinskis.de>,
	linux-wireless@vger.kernel.org,
	brcm80211@lists.linux.dev,
	brcm80211-dev-list.pdl@broadcom.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] brcmfmac: remove unreachable poll mode for sdio
Date: Sat, 21 Jun 2025 13:29:10 +0200
Message-ID: <20250621112912.180436-1-rouven@czerwinskis.de>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sdio interface implements an unreachable poll mode. Remove it since
the code can't be reached, if the poll mode needs to be implemented it
can simply be resurrected using the usual git means.

Signed-off-by: Rouven Czerwinski <rouven@czerwinskis.de>
---
 .../broadcom/brcm80211/brcmfmac/sdio.c        | 48 +------------------
 1 file changed, 2 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
index cf26ab15ee0c..26e09a7acb02 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/sdio.c
@@ -404,7 +404,6 @@ struct brcmf_sdio_hdrinfo {
 struct brcmf_sdio_count {
 	uint intrcount;		/* Count of device interrupt callbacks */
 	uint lastintrs;		/* Count as of last watchdog timer */
-	uint pollcnt;		/* Count of active polls */
 	uint regfails;		/* Count of R_REG failures */
 	uint tx_sderrs;		/* Count of tx attempts with sd errors */
 	uint fcqueued;		/* Tx packets that got queued */
@@ -476,11 +475,8 @@ struct brcmf_sdio {
 	u8 sdpcm_ver;	/* Bus protocol reported by dongle */
 
 	bool intr;		/* Use interrupts */
-	bool poll;		/* Use polling */
 	atomic_t ipend;		/* Device interrupt is pending */
 	uint spurious;		/* Count of spurious interrupts */
-	uint pollrate;		/* Ticks between device polls */
-	uint polltick;		/* Tick counter */
 
 #ifdef DEBUG
 	uint console_interval;
@@ -3178,7 +3174,7 @@ static int brcmf_debugfs_sdio_count_read(struct seq_file *seq, void *data)
 
 	seq_printf(seq,
 		   "intrcount:    %u\nlastintrs:    %u\n"
-		   "pollcnt:      %u\nregfails:     %u\n"
+		   "pollcnt:       0\nregfails:     %u\n"
 		   "tx_sderrs:    %u\nfcqueued:     %u\n"
 		   "rxrtx:        %u\nrx_toolong:   %u\n"
 		   "rxc_errors:   %u\nrx_hdrfail:   %u\n"
@@ -3192,7 +3188,7 @@ static int brcmf_debugfs_sdio_count_read(struct seq_file *seq, void *data)
 		   "tx_ctlpkts:   %lu\nrx_ctlerrs:   %lu\n"
 		   "rx_ctlpkts:   %lu\nrx_readahead: %lu\n",
 		   sdcnt->intrcount, sdcnt->lastintrs,
-		   sdcnt->pollcnt, sdcnt->regfails,
+		   sdcnt->regfails,
 		   sdcnt->tx_sderrs, sdcnt->fcqueued,
 		   sdcnt->rxrtx, sdcnt->rx_toolong,
 		   sdcnt->rxc_errors, sdcnt->rx_hdrfail,
@@ -3669,43 +3665,6 @@ static void brcmf_sdio_bus_watchdog(struct brcmf_sdio *bus)
 {
 	brcmf_dbg(TIMER, "Enter\n");
 
-	/* Poll period: check device if appropriate. */
-	if (!bus->sr_enabled &&
-	    bus->poll && (++bus->polltick >= bus->pollrate)) {
-		u32 intstatus = 0;
-
-		/* Reset poll tick */
-		bus->polltick = 0;
-
-		/* Check device if no interrupts */
-		if (!bus->intr ||
-		    (bus->sdcnt.intrcount == bus->sdcnt.lastintrs)) {
-
-			if (!bus->dpc_triggered) {
-				u8 devpend;
-
-				sdio_claim_host(bus->sdiodev->func1);
-				devpend = brcmf_sdiod_func0_rb(bus->sdiodev,
-						  SDIO_CCCR_INTx, NULL);
-				sdio_release_host(bus->sdiodev->func1);
-				intstatus = devpend & (INTR_STATUS_FUNC1 |
-						       INTR_STATUS_FUNC2);
-			}
-
-			/* If there is something, make like the ISR and
-				 schedule the DPC */
-			if (intstatus) {
-				bus->sdcnt.pollcnt++;
-				atomic_set(&bus->ipend, 1);
-
-				bus->dpc_triggered = true;
-				queue_work(bus->brcmf_wq, &bus->datawork);
-			}
-		}
-
-		/* Update interrupt tracking */
-		bus->sdcnt.lastintrs = bus->sdcnt.intrcount;
-	}
 #ifdef DEBUG
 	/* Poll for console output periodically */
 	if (bus->sdiodev->state == BRCMF_SDIOD_DATA && BRCMF_FWCON_ON() &&
@@ -4080,9 +4039,6 @@ brcmf_sdio_probe_attach(struct brcmf_sdio *bus)
 
 	/* Set the poll and/or interrupt flags */
 	bus->intr = true;
-	bus->poll = false;
-	if (bus->poll)
-		bus->pollrate = 1;
 
 	return 0;
 
-- 
2.49.0


