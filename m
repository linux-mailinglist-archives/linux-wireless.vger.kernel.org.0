Return-Path: <linux-wireless+bounces-14921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 467AA9BCB50
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 12:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B742EB211B6
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2024 11:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0026F1D279B;
	Tue,  5 Nov 2024 11:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="o5dssEIm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AF771D2716
	for <linux-wireless@vger.kernel.org>; Tue,  5 Nov 2024 11:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805030; cv=none; b=VQTH1SeSEiih9j4vEW30rOXAYGV/uD12SwIZiuJ+1c0kuP8pBJXg7Yz07ynyiLS0Laum6dg2EI47oAlLNEfuh8yhRyYYafAP+p3FqaWNfwcnVLVb8AaghizkpRFTu2S96Y49yhRcmaiLF+FAD9nEu+Dbncir0hsuvKRrXIPBJJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805030; c=relaxed/simple;
	bh=Rk/L/b5a1SYIOXYwBXB3IfXyFIJZViPjAxbw2r+wGPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vCH8oUMyLeOKblYWRG/R38HYjdX+0xqU2U8EJgmcabAiGb2vPlPGIAaZxb0jKauemZV168ZE3CqdKl2zMKdndBBvVHyMZBYk17cJ79J3HNHupVGaRirSpTJ2hG0rzE0H06Qi0KE12fj4iyPnOr9L+CbpiUAupMib4A3dQ0pPZ6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=o5dssEIm; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 8b1a62469b6611efb88477ffae1fc7a5-20241105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=RSz7cs1n97k6WaksJyKwqqco8iIMeAqTrUt8H55VRcs=;
	b=o5dssEIm7AwhLtRfbuOaAGpvmaoE61E9OP3hPOxurHwxmJYD1uROrd+rbyP22nKILG/mhwzEAT5N/0Rb9Q2lghffm2fv5/cDEB3fIy7HSoY5KIRoVzJBEJ+KSFaE1riWAhedSzRjbAVacTt05trdF9Xnqr3lQd8Z2dGddN2GjEs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.42,REQID:8c8b7fff-6044-4764-9b92-59c7cf672e83,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:b0fcdc3,CLOUDID:903f9407-7990-429c-b1a0-768435f03014,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 8b1a62469b6611efb88477ffae1fc7a5-20241105
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 339990393; Tue, 05 Nov 2024 19:10:19 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 5 Nov 2024 19:10:18 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 5 Nov 2024 19:10:18 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Michael Lo
	<michael.lo@mediatek.corp-partner.google.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: config the dwell time by firmware
Date: Tue, 5 Nov 2024 19:10:16 +0800
Message-ID: <20241105111016.23564-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: Michael Lo <michael.lo@mediatek.corp-partner.google.com>

To optimize the scan time of mt7925, remove the dwell time
setting for the scan command and let it be controlled by
the firmware as mt7921.

Signed-off-by: Michael Lo <michael.lo@mediatek.corp-partner.google.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 0c2a2337c313..4226baf3cfcb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -2643,14 +2643,12 @@ int mt7925_mcu_set_dbdc(struct mt76_phy *phy)
 	return err;
 }
 
-#define MT76_CONNAC_SCAN_CHANNEL_TIME		60
-
 int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_scan_request *scan_req)
 {
 	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
 	struct cfg80211_scan_request *sreq = &scan_req->req;
-	int n_ssids = 0, err, i, duration;
+	int n_ssids = 0, err, i;
 	struct ieee80211_channel **scan_list = sreq->channels;
 	struct mt76_dev *mdev = phy->dev;
 	struct mt76_connac_mcu_scan_channel *chan;
@@ -2686,14 +2684,6 @@ int mt7925_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	req->scan_type = sreq->n_ssids ? 1 : 0;
 	req->probe_req_num = sreq->n_ssids ? 2 : 0;
 
-	duration = MT76_CONNAC_SCAN_CHANNEL_TIME;
-	/* increase channel time for passive scan */
-	if (!sreq->n_ssids)
-		duration *= 2;
-	req->timeout_value = cpu_to_le16(sreq->n_channels * duration);
-	req->channel_min_dwell_time = cpu_to_le16(duration);
-	req->channel_dwell_time = cpu_to_le16(duration);
-
 	tlv = mt76_connac_mcu_add_tlv(skb, UNI_SCAN_SSID, sizeof(*ssid));
 	ssid = (struct scan_ssid_tlv *)tlv;
 	for (i = 0; i < sreq->n_ssids; i++) {
-- 
2.45.2


