Return-Path: <linux-wireless+bounces-22444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F36AA8DB8
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 959531884336
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 07:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECEEF1DC998;
	Mon,  5 May 2025 07:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="JHqn89a0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BB2A2AF1B
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 07:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746431930; cv=none; b=lAsNSESLxXY2dYgvqPXZB7s0MdRQix4D+nzNCArNIQZw6PIbI60G11nFc7uazYlf1CvIYY2UJX/p4C3/tANKQLBqixcE+gVl12Y8SLBBmm92a/ubZYu33GsMChI+vww8yzyRAe6UBTb9rPkqSyhqDONzx0o2ZAtbzLNC/WHZVJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746431930; c=relaxed/simple;
	bh=dOe8l+Llvy210iHKBBmHla0wpWpZJofKNqFi9rET1Os=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=cr1Kqi/Jt78pb7inaNSMBEVY4vCxwv0F1Hrcy9mEVP4El8n2mWavlVm4HEnFRNnIdfEmG4iJf3imQ5J5licNsqtqfl71uBUXZRzYgoNUEPyhShQ4rAGnQDikOZVLZlSggzHKMZSPADU7DcNSpnqR/JoS35vnYEf5PdO/V2yNjBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=JHqn89a0; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: bf4da150298611f0813e4fe1310efc19-20250505
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=taZZEqUj2wClc8QQrihONsE9LMiAtc55UAgYQjmLUfs=;
	b=JHqn89a03z7qNTyAnZbItai1HOEe23rgKPaqivSWMcRP/u9WOnyYPB9IIhqAZbLV6xaQPQcy3eHjovFg2YzKuJgBs7P1GqDkfPMKF24osudysldTI3GjpCzk7pTvRFAQJ4Klky2YnVKVfPLBglWyT3730MC5rJf3afarsW4OkBw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.2.1,REQID:6df0c221-f1cd-4a5a-a743-29a65a4e58ef,IP:0,UR
	L:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:-25
X-CID-META: VersionHash:0ef645f,CLOUDID:56f42e70-e08c-41ab-89e8-3ba0a33da853,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: bf4da150298611f0813e4fe1310efc19-20250505
Received: from mtkmbs09n1.mediatek.inc [(172.21.101.35)] by mailgw01.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1065570085; Mon, 05 May 2025 15:58:36 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS09N2.mediatek.inc (172.21.101.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Mon, 5 May 2025 15:58:34 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Mon, 5 May 2025 15:58:34 +0800
From: Allan Wang <allan.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>,
	<Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Allan Wang <allan.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7925: add rfkill_poll for hardware rfkill
Date: Mon, 5 May 2025 15:37:34 +0800
Message-ID: <20250505073734.3923790-1-allan.wang@mediatek.com>
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

Add mac80211 rfkill_poll ops to monitor hardware rfkill state
and state change will be updated.

Signed-off-by: Allan Wang <allan.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 16 ++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 39 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  4 ++
 5 files changed, 61 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 478cd1886736..e195d69f61f6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1298,6 +1298,7 @@ enum {
 	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
 	MCU_UNI_CMD_ALL_STA_INFO = 0x6e,
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
+	MCU_UNI_CMD_RADIO_STATUS = 0x80,
 	MCU_UNI_CMD_SDO = 0x88,
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 83f93f9e002c..65bf9aef2b5e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -334,6 +334,9 @@ int __mt7925_start(struct mt792x_phy *phy)
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT792x_WATCHDOG_TIME);
 
+	if (phy->chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN)
+		wiphy_rfkill_start_polling(mphy->hw->wiphy);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__mt7925_start);
@@ -2205,6 +2208,18 @@ static void mt7925_unassign_vif_chanctx(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
+static void mt7925_rfkill_poll(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(phy->dev);
+	ret = mt7925_mcu_wf_rf_pin_ctrl(phy);
+	mt792x_mutex_release(phy->dev);
+
+	wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);
+}
+
 const struct ieee80211_ops mt7925_ops = {
 	.tx = mt792x_tx,
 	.start = mt7925_start,
@@ -2265,6 +2280,7 @@ const struct ieee80211_ops mt7925_ops = {
 	.link_info_changed = mt7925_link_info_changed,
 	.change_vif_links = mt7925_change_vif_links,
 	.change_sta_links = mt7925_change_sta_links,
+	.rfkill_poll = mt7925_rfkill_poll,
 };
 EXPORT_SYMBOL_GPL(mt7925_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 286f602623c0..31fa092d2c8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -3633,6 +3633,45 @@ int mt7925_mcu_set_rate_txpower(struct mt76_phy *phy)
 	return 0;
 }
 
+int mt7925_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy)
+{
+#define UNI_CMD_RADIO_STATUS_GET	0
+	struct mt792x_dev *dev = phy->dev;
+	struct sk_buff *skb;
+	int ret;
+
+	struct {
+		__le16 tag;
+		__le16 len;
+		u8 rsv[4];
+	} __packed req = {
+		.tag = UNI_CMD_RADIO_STATUS_GET,
+		.len = cpu_to_le16(sizeof(req)),
+	};
+
+	struct mt7925_radio_status_event {
+		__le16 tag;
+		__le16 len;
+
+		u8 data;
+		u8 rsv[3];
+	} __packed * status;
+
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_UNI_CMD(RADIO_STATUS),
+					&req, sizeof(req), true, &skb);
+	if (ret)
+		return ret;
+
+	skb_pull(skb, sizeof(struct tlv));
+	status = (struct mt7925_radio_status_event *)skb->data;
+	ret = (int)status->data;
+
+	dev_kfree_skb(skb);
+
+	return ret;
+}
+
 int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 4e50f2597ccd..283a40badd28 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -365,5 +365,6 @@ int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_sta *sta,
 				     int link_id);
+int mt7925_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index c7b5dc1dbb34..b997cd8bf8d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -31,6 +31,10 @@ static void mt7925e_unregister_device(struct mt792x_dev *dev)
 {
 	int i;
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (dev->phy.chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN)
+		wiphy_rfkill_stop_polling(hw->wiphy);
 
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
-- 
2.45.2


