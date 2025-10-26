Return-Path: <linux-wireless+bounces-28285-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C17E6C0B03C
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 19:28:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 623624EB69E
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Oct 2025 18:28:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51402F0C68;
	Sun, 26 Oct 2025 18:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="oXCdWBef"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D476A202C30;
	Sun, 26 Oct 2025 18:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761503282; cv=none; b=b89XIOvmwmfgqV2rQqMzoYYIldCqsGWJDUrhZqasKRBbaFOO6GjnqJmeU2J63/nR756e98+OKhWch2x/pXn8ReCJAv9ynj0Xod/qrjD1HKdw2lc4plHylkJrdgO0ZDVb0gZ78Trb8zRkMz9ZtZIR+R6MMMVKrCZAQVTHlxvkJAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761503282; c=relaxed/simple;
	bh=rIFwJxfwTvpeOWM0RSVIgbkTg+0MDNJ3holbFfMWeKQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QSmgX364R70IjgDS08r3ghf32NdWW6/30PxLGIEFe8H2NZ7jY+rD0wgs1ei6Kr0dZ4zzjSD9Aj93AR06km/MrKinvA0vKXNAxGFBYaWuMRebCztvGBQd7jzFFNW0AwEnIUgjFDzf8rHEYj5TMsaXbxI1l15W00LcqX/HY9q3/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=oXCdWBef; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1761503225; x=1762803225;
	bh=YzhIdawRjO+AxQtjLDEcxwAEGsa8XhjWBxl0gSxmXBk=; h=From;
	b=oXCdWBefexpIjIu2/qhYmEu/vgffAyYS4FX4lWPOIW+y64TrsDE9IUg9OFhfytbmq
	 9Hsdp4InwQ0Z7GuTjmmjLa7x+UnRI6g5Vo0Zlzp0y+k6Al3CBfYN3RBZ0PbiDy7UMo
	 tNrjABO/hqDRu6ZKpYW8zML0em8iZG26hKpNxZDv8AUplvuJEIE5Oc3M+UNZXRJFZi
	 F5HgosUD+j6iN4U2f0Ry1mb4V3NnkjLxqRLS+ce0ixrHka6KZOHQ4vOWBjxZeqztPT
	 crFok3nG2e5KgJ5vSiv+ulUqrdrwd+Vwt+i8595pucDAVG9s333TBiBB1+WmSLD4kR
	 sCUC91xhxlnjw==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.16.1/8.16.1) with ESMTPS id 59QIR3Pt043068
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Sun, 26 Oct 2025 19:27:04 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
From: Karel Balej <balejk@matfyz.cz>
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
        linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mmc@vger.kernel.org
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Karel Balej <balejk@matfyz.cz>, Jeff Chen <jeff.chen_1@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
Subject: [DONOTAPPLY RFC PATCH v2 3/4] DONOTMERGE: net: mwifiex: fix timeouts with the SD8777 chip
Date: Sun, 26 Oct 2025 19:20:40 +0100
Message-ID: <20251026182602.26464-4-balejk@matfyz.cz>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251026182602.26464-1-balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It has been observed with the samsung,coreprimevelte smartphone which
uses this wireless chip that the driver would irrecoverably fail upon
certain operations, usually after timing out on a FW command such as
with these logs:

	[ 2101.209913] mwifiex_sdio mmc2:0001:1: mwifiex_cmd_timeout_func: Timeout cmd id = 0xa4, act = 0x0
	[ 2101.209941] mwifiex_sdio mmc2:0001:1: num_data_h2c_failure = 0
	[ 2101.209949] mwifiex_sdio mmc2:0001:1: num_cmd_h2c_failure = 0
	[ 2101.209957] mwifiex_sdio mmc2:0001:1: is_cmd_timedout = 1
	[ 2101.209964] mwifiex_sdio mmc2:0001:1: num_tx_timeout = 0
	[ 2101.209971] mwifiex_sdio mmc2:0001:1: last_cmd_index = 1
	[ 2101.209978] mwifiex_sdio mmc2:0001:1: last_cmd_id: 16 00 a4 00 75 00 a4 00 7f 00
	[ 2101.209988] mwifiex_sdio mmc2:0001:1: last_cmd_act: 00 00 00 00 02 00 00 00 00 00
	[ 2101.209995] mwifiex_sdio mmc2:0001:1: last_cmd_resp_index = 0
	[ 2101.210003] mwifiex_sdio mmc2:0001:1: last_cmd_resp_id: 16 80 a4 80 75 80 a4 80 7f 80
	[ 2101.210010] mwifiex_sdio mmc2:0001:1: last_event_index = 4
	[ 2101.210018] mwifiex_sdio mmc2:0001:1: last_event: 0b 00 0a 00 0b 00 0a 00 1c 00
	[ 2101.210025] mwifiex_sdio mmc2:0001:1: data_sent=1 cmd_sent=1
	[ 2101.210033] mwifiex_sdio mmc2:0001:1: ps_mode=1 ps_state=0
	[ 2101.210089] mwifiex_sdio mmc2:0001:1: failed to get signal information
	[ 2101.210761] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.210786] mwifiex_sdio mmc2:0001:1: failed to get signal information
	[ 2101.211162] mwifiex_sdio mmc2:0001:1: ===mwifiex driverinfo dump start===
	[ 2101.211178] mwifiex_sdio mmc2:0001:1: info: MWIFIEX VERSION: mwifiex 1.0 (14.75.33.p119)
	[ 2101.211202] mwifiex_sdio mmc2:0001:1: SDIO register dump start
	[ 2101.211482] mwifiex_sdio mmc2:0001:1: SDIO Func0 (0x0-0x9): 32 02 02 02 03 00 00 02 03 00
	[ 2101.211649] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x0-0x9): 02 3f 03 00 00 00 00 00 92 00
	[ 2101.211740] mwifiex_sdio mmc2:0001:1: SDIO Func1: (0x28) 00 (0x30) 08 (0x34) 07 (0x38) 11 (0x3c) 00
	[ 2101.211921] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x60-0x6a): dc fe 5f 81 ca 04 00 79 79 00 30
	[ 2101.314135] mwifiex_sdio mmc2:0001:1: SDIO Func1 (0x60-0x6a): dc fe 5f 81 ca 04 00 79 79 00 30
	[ 2101.314168] mwifiex_sdio mmc2:0001:1: SDIO register dump end
	[ 2101.314300] mwifiex_sdio mmc2:0001:1: ===mwifiex driverinfo dump end===
	[ 2101.314313] mwifiex_sdio mmc2:0001:1: == mwifiex dump information to /sys/class/devcoredump start
	[ 2101.314586] mwifiex_sdio mmc2:0001:1: == mwifiex dump information to /sys/class/devcoredump end
	[ 2101.314610] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.314638] mwifiex_sdio mmc2:0001:1: PREP_CMD: FW is in bad state
	[ 2101.317997] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318029] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318037] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318044] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318051] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318057] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318064] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318071] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318078] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318084] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.318091] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.318098] mwifiex_sdio mmc2:0001:1: deleting the crypto keys
	[ 2101.321278] mwifiex_sdio mmc2:0001:1: info: shutdown mwifiex...
	[ 2101.323214] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.323250] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.324427] mwifiex_sdio mmc2:0001:1: PREP_CMD: card is removed
	[ 2101.419786] mmc2: queuing unknown CIS tuple 0x50 [40 1e fd d1 c0 46 70 47 00 b5 23 48 24 49 01 60 24 48 24 49 01 60 24 49 08 47 1f 48 24 49 01 60] (32 bytes)
	[ 2101.460850] mmc2: queuing unknown CIS tuple 0x70 [53 f0 21 e3 1e ff 2f e1 10 1f 11 ee 00 00 50 e3 02 2a a0 e3 02 10 c1 01 02 10 81 11 10 1f 01 ee 1e ff 2f e1 01 00 a0 e3 f6 ff ff eb ea ff ff fa 48 00 9f e5 54 10 9f e5 54 20 9f e5 ef ff ff eb] (71 bytes)
	[ 2101.532495] mmc2: queuing unknown CIS tuple 0xe8 [2f 07 ee 1e ff 2f e1 0e 30 a0 e1 00 00 a0 e3 ea ff ff eb e5 ff ff fa 03 e0 a0 e1 2c 30 9f e5 13 ff 2f e1 00 10 80 e5 1a 9f 00 ee 12 ff 2f e1 04 21 00 80 c0 00 10 80 04 22 00 80 06 0a 46 02 48] (144 bytes)
	[ 2101.598922] mmc2: queuing unknown CIS tuple 0x9d [29 15 1d 01 00 4d 61 72 76 65 6c 6c 20 42 6c 75 65 74 6f 6f 74 68 20 44 65 76 69 63 65 00 00 ff 20 04 df 02 32 91 21 02 0c 00 22 2a 01 01 00 00 00 00 00 00 00 00 00 00 00 02 00 00 00 00 00 00] (162 bytes)
	[ 2101.599647] mmc2: tried to HW reset card, got error -2
	[ 2101.599699] mwifiex_sdio mmc2:0001:1: SDIO HW reset failed: -2

(besides cmd id 0xa4 also 0xce is often seen in these dumps).

One of these operations which would cause the timeout reliably was
initiating a SSH connection into the phone over the WiFi and this was
used for tracking down the issue. The other known ones are heavier usage
of the XMPP client Dino on the phone and any more than basic browsing in
Firefox.

It was however verified that the mwifiex driver works without issues on
the vendor Samsung kernel with the proper support for the chip added,
although the stock Android on the phone doesn't use mwifiex but instead
a specialized driver for the chip which however is very similar to
mwifiex.

A support for the phone and it's components essential for the WiFi
function were thus backported to the v3.14 kernel on whose stable branch
the stock kernel was based and it was verified that the WiFi (namely SSH
over WiFi) also works there without timeouts. Afterwards, a bisect was
performed which first indicated the commit 808bbebcc8fc ("mwifiex: add
Tx status support for EAPOL packets") introduced in the v3.18-v3.19
cycle.

Reverting this commit (and the following one, commit 18ca43823f3c
("mwifiex: add Tx status support for ACTION frames"), to facilitate a
clean revert) fixed the timeouts for v3.19, but during the next cycle,
v3.19-v4.0, another breakage was introduced via commit 84b313b35f81
("mwifiex: make tx packet 64 byte DMA aligned").

Reverting all three commits fixed the timeouts on the current mainline
kernel also. This patch contains the minimal changes needed to achieve
that derived from the full revert commits.

Note that a few timeouts were still observed on mainline Linux even with
these changes, however they were all on a particular network and don't
have a known reproducer. On other networks, the chip performs flawlessly
as far as it was tested so far.

These changes also don't mitigate the observed firmware loading issues:

	[   68.698674] mwifiex_sdio mmc2:0001:1: FW download, write iomem (0) failed @ 208016
	[   68.698711] mwifiex_sdio mmc2:0001:1: prog_fw failed ret=0xffffffff

These were however also seen with the old kernels and as such are likely
caused either by some inherent incompatibility of the driver with the
chip in this regard or, more likely given their occasional nature, by an
issue at some other level, such as the stability of the SDIO (the
occurrence of the problem does seem to loosely correlate with the load
exerted on the phone while the FW loading is performed (i. e. mainly on
startup)).

Note that Bluetooth on the phone (provided by the same chip) has also
been seen crashing in a similar way as the WiFi without this patch,
although seemingly less frequently/deterministically, and a similar
change might thus be needed in the btmrvl driver if it is to be used for
the phone's BT without issues.

Signed-off-by: Karel Balej <balejk@matfyz.cz>
---
 drivers/net/wireless/marvell/mwifiex/fw.h     |  4 +---
 drivers/net/wireless/marvell/mwifiex/sta_tx.c | 10 ++--------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/fw.h b/drivers/net/wireless/marvell/mwifiex/fw.h
index e9e896606912..5c4c3363c7de 100644
--- a/drivers/net/wireless/marvell/mwifiex/fw.h
+++ b/drivers/net/wireless/marvell/mwifiex/fw.h
@@ -690,9 +690,7 @@ struct txpd {
 	u8 priority;
 	u8 flags;
 	u8 pkt_delay_2ms;
-	u8 reserved1[2];
-	u8 tx_token_id;
-	u8 reserved[2];
+	u8 reserved1;
 } __packed;
 
 struct rxpd {
diff --git a/drivers/net/wireless/marvell/mwifiex/sta_tx.c b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
index 9d0ef04ebe02..857eb22f4c24 100644
--- a/drivers/net/wireless/marvell/mwifiex/sta_tx.c
+++ b/drivers/net/wireless/marvell/mwifiex/sta_tx.c
@@ -41,8 +41,8 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 
 	pkt_type = mwifiex_is_skb_mgmt_frame(skb) ? PKT_TYPE_MGMT : 0;
 
-	pad = ((uintptr_t)skb->data - (sizeof(*local_tx_pd) + hroom)) &
-	       (MWIFIEX_DMA_ALIGN_SZ - 1);
+	pad = (4 - (((void *)skb->data - NULL) & 0x3)) % 4;
+
 	skb_push(skb, sizeof(*local_tx_pd) + pad);
 
 	local_tx_pd = (struct txpd *) skb->data;
@@ -58,12 +58,6 @@ void mwifiex_process_sta_txpd(struct mwifiex_private *priv,
 	local_tx_pd->pkt_delay_2ms =
 				mwifiex_wmm_compute_drv_pkt_delay(priv, skb);
 
-	if (tx_info->flags & MWIFIEX_BUF_FLAG_EAPOL_TX_STATUS ||
-	    tx_info->flags & MWIFIEX_BUF_FLAG_ACTION_TX_STATUS) {
-		local_tx_pd->tx_token_id = tx_info->ack_frame_id;
-		local_tx_pd->flags |= MWIFIEX_TXPD_FLAGS_REQ_TX_STATUS;
-	}
-
 	if (local_tx_pd->priority <
 	    ARRAY_SIZE(priv->wmm.user_pri_pkt_tx_ctrl))
 		/*
-- 
2.51.1


