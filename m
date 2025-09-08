Return-Path: <linux-wireless+bounces-27072-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F49B48284
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 04:13:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98DFF3A3C98
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 02:13:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA981DFE12;
	Mon,  8 Sep 2025 02:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Lxqbpopa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF29C1DF246
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 02:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757297595; cv=none; b=N0+oskhBkcAkJ75alw6WKUMAG+5Bl2ej7aabXJDMrplc+ZnRciLuhWPk1MHWQqgoazErDOHSHbg4Hi64CNxeNmE973Lmm80YyToe20Vc0WrLP+6p8o+OO2XeBeat6JrQzro6LoQxWQOA/M7fMlToJviMEk80TSv4R0nUnfngrg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757297595; c=relaxed/simple;
	bh=jKvsDaY/IclrVZWuudO2IJARe7jG8BMTHkK4puI1yhM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CXUUPiTPI4MZKenQRoSH1JgUfryLYYjYLJr4nCVOWnZC1DC48ci2I/TPrBg9cQzM1uPY7Q3UxHv6u3DiIceK+60GAzs715CwuJ9Bi19CjVmCrtgxqzjJD0pVb+TAmHUtF4S13KwyVyghsYqvtn5+zkiCU2zTOYGD596CwVdvtio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Lxqbpopa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 5aa8120e8c5911f0bd5779446731db89-20250908
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=F7hI9EiGHlZx/K0lv9Z+BNrTQdL6SJOgNctxwa19W7Q=;
	b=LxqbpopaoZSGIr1gVDQafcXMMuaZTP3YeEpYafTgD5SmXnGatHrTsnpmxbJlhTdQ7fNM0ArQG9XQL23jX9FsPI8oOATk4O1lIgCodiJMPgITFznZE8Weo+twAgv3sp3gxT/vDEWzrMjR+NaAduUBui2RKnchPV7jDBtQSHqrIas=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.3,REQID:1b957283-8d6c-4e4d-8eaa-c3d82a87d049,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:f1326cf,CLOUDID:1f880bf8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:-5,Content:0|15|50,EDM:-3,IP:
	nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,L
	ES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 5aa8120e8c5911f0bd5779446731db89-20250908
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 156241547; Mon, 08 Sep 2025 10:13:04 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 8 Sep 2025 10:13:02 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 8 Sep 2025 10:13:02 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: refine the txpower flow initialization flow
Date: Mon, 8 Sep 2025 10:13:02 +0800
Message-ID: <20250908021303.1755732-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>

Refactor the initialization and reset flow for tx power setting to
eliminate redundant configurations

Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c  |  5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 14 --------------
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c  |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt792x.h      |  1 -
 4 files changed, 7 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index 57bcbb938f53..8640e4ba7bc0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -1306,7 +1306,6 @@ void mt7925_mac_reset_work(struct work_struct *work)
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
-	dev->sar_inited = false;
 
 	for (i = 0; i < 10; i++) {
 		mutex_lock(&dev->mt76.mutex);
@@ -1335,6 +1334,10 @@ void mt7925_mac_reset_work(struct work_struct *work)
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7925_vif_connect_iter, NULL);
 	mt76_connac_power_save_sched(&dev->mt76.phy, pm);
+
+	mt792x_mutex_acquire(dev);
+	mt7925_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
+	mt792x_mutex_release(dev);
 }
 
 void mt7925_coredump_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index da3cb2909e61..afde0343bab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -311,7 +311,6 @@ void mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy)
 int __mt7925_start(struct mt792x_phy *phy)
 {
 	struct mt76_phy *mphy = phy->mt76;
-	struct mt792x_dev *dev = phy->dev;
 	int err;
 
 	err = mt7925_mcu_set_channel_domain(mphy);
@@ -322,13 +321,6 @@ int __mt7925_start(struct mt792x_phy *phy)
 	if (err)
 		return err;
 
-	if (!dev->sar_inited) {
-		err = mt7925_set_tx_sar_pwr(mphy->hw, NULL);
-		if (err)
-			return err;
-		dev->sar_inited = true;
-	}
-
 	mt792x_mac_reset_counters(phy);
 	set_bit(MT76_STATE_RUNNING, &mphy->state);
 
@@ -1730,13 +1722,7 @@ static int mt7925_set_sar_specs(struct ieee80211_hw *hw,
 	int err;
 
 	mt792x_mutex_acquire(dev);
-	err = mt7925_mcu_set_clc(dev, dev->mt76.alpha2,
-				 dev->country_ie_env);
-	if (err < 0)
-		goto out;
-
 	err = mt7925_set_tx_sar_pwr(hw, sar);
-out:
 	mt792x_mutex_release(dev);
 
 	return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 6b6cadaf1654..66b35ef004fc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -928,7 +928,6 @@ static int mt7925_load_clc(struct mt792x_dev *dev, const char *fw_name)
 		}
 	}
 
-	ret = mt7925_mcu_set_clc(dev, "00", ENVIRON_INDOOR);
 out:
 	release_firmware(fw);
 
@@ -3987,6 +3986,8 @@ mt7925_mcu_rate_txpower_band(struct mt76_phy *phy,
 
 int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy)
 {
+	struct mt76_dev *mdev = phy->dev;
+	struct mt792x_dev *dev = mt792x_hw_dev(mdev->hw);
 	int err;
 
 	if (phy->cap.has_2ghz) {
@@ -4003,7 +4004,7 @@ int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy)
 			return err;
 	}
 
-	if (phy->cap.has_6ghz) {
+	if (phy->cap.has_6ghz && dev->phy.clc_chan_conf) {
 		err = mt7925_mcu_rate_txpower_band(phy,
 						   NL80211_BAND_6GHZ);
 		if (err < 0)
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index aea11713b20a..f22fe982eafb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -236,7 +236,6 @@ struct mt792x_dev {
 	bool aspm_supported:1;
 	bool hif_idle:1;
 	bool hif_resumed:1;
-	bool sar_inited:1;
 	bool regd_change:1;
 	wait_queue_head_t wait;
 
-- 
2.34.1


