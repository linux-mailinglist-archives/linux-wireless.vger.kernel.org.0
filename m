Return-Path: <linux-wireless+bounces-15943-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 657E19E6380
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 02:44:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21999286A0D
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Dec 2024 01:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA3F413C8FF;
	Fri,  6 Dec 2024 01:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="AxPGMRvg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7001C13C677
	for <linux-wireless@vger.kernel.org>; Fri,  6 Dec 2024 01:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733449458; cv=none; b=OBsFXDkUtK2bks17QJJB6JyDvqeORTOiz/qBW0Ck2Gepj/XboRu8i5TVcTjmSo1GGZFvI2DPuLBRIyvej9Jz8scC1ccDgg2EiPd0LoR+1kFmV+jBxU6DVHWmbZInvo33j02x7L4yr5zmOY3u+ULxLQ0FtLmlUQeeL6B5G2XdTsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733449458; c=relaxed/simple;
	bh=39QfCU4O7WYRJXGJoTgyojeHQ9WSlUZ/DIS7fmjOalg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nVmqqR7Dda0FahqrHTKzDuK0GcgolQ7Ci2vbdgSKkJ3+vcN8sQgLiWE5BpdpnDgTvR6JR0RqOp2nOJ7L2/QmyMexta1e/xtVXP+enlPkE3cXqY573DWGXaydKJ9ojRXmlJu/JO95OWA1Onm9T7ofQG9B376IQr1N6zfiuhuV/TM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=AxPGMRvg; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 964261dab37311ef99858b75a2457dd9-20241206
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=pRaT+yiiH3Zks5T/OFQYljNtsEpvsISL3Bcg8kyYZhM=;
	b=AxPGMRvgq7X6+ILfTbsP+wMBAAGDWa45bx8RrVSUa9jCuYg7EuI8akck92Q/7RDCJG7V815LcHaIwF8Jrb1IWy1yA0OcmgUm0jDAPn6wrVeg8D5r5upaxSYFTrsrhmMoio8U+5l1uJGO8SaNvqNPPZi+U64jtCcXaqrxpcxr2Qg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.45,REQID:f3541d3e-2539-46ce-b82c-802501296344,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6493067,CLOUDID:b66c833b-e809-4df3-83cd-88f012b9e9ba,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:11|1,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 964261dab37311ef99858b75a2457dd9-20241206
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
	(envelope-from <allan.wang@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 999813311; Fri, 06 Dec 2024 09:44:09 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 MTKMBS14N2.mediatek.inc (172.21.101.76) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 6 Dec 2024 09:44:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 6 Dec 2024 09:44:05 +0800
From: Allan Wang <allan.wang@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <mingyen.hsieh@mediatek.com>,
	<Sean.Wang@mediatek.com>, <Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Michael.Lo@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
	<posh.sun@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Allan Wang <allan.wang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: add rfkill_poll for hardware rfkill
Date: Fri, 6 Dec 2024 09:43:55 +0800
Message-ID: <20241206014355.32426-1-allan.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-Product-Ver: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-AS-Result: No-10--4.059100-8.000000
X-TMASE-MatchedRID: DsFl2sNdNIt7EGbCBtXNhxn0UD4GU5IqTJDl9FKHbrkAhmnHHeGnvQ2C
	UGzZxN2d+WFCrqyd+iLQi9sGSI+OA/7tF2P46phM4RtSDjG+z7Dq0SQ1Mgx5CMSiwizsgluQJbi
	CL/CCHU0LSUwrOItoaxfkX9Qis6H8J1+qhSigB/RLc5N+0s1+Dc1eA/uWJnkifc8MDDp7ngeBKS
	UXG3panUEe/bRpAYoLwEaWvAn5Aa70D0R+G5TTHBz2MDiYujy5CnETf9T87hYeH35Xwro9Lr68E
	aeLk+Nugr+k6BX7zKylEtDJyVR88h8TzIzimOwPC24oEZ6SpSk6XEE7Yhw4Fj7cByD4VoMcmwrH
	yKYG3ftQ4f02ncBtlEPwsSZBe4N21Wi7HlHI3tT5qToMxp3uKDL6veMFx03sVijDhtCR+yGfEbF
	qQlXAusGQYFMiVRG5ehcPPz6UzEWlb5ogMngNpHOTEn5IiRSOady5RJQR05c=
X-TM-AS-User-Approved-Sender: No
X-TM-AS-User-Blocked-Sender: No
X-TMASE-Result: 10--4.059100-8.000000
X-TMASE-Version: SMEX-14.0.0.3152-9.1.1006-23728.005
X-TM-SNTS-SMTP:
	0FAC51D0D0AFA8DEEBF6142166BEE00D2AFCF5BF44A56A5646D906BF70783C6C2000:8

Add mac80211 rfkill_poll ops to monitor hardware rfkill state
and state change will be updated.

Signed-off-by: Allan Wang <allan.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 18 ++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 21 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7921/mcu.h   |  5 +++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 ++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  4 ++++
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 7 files changed, 55 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 1b0e80dfc346..d3c03fb0d36a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1043,6 +1043,7 @@ enum {
 	MCU_EXT_EVENT_CSA_NOTIFY = 0x4f,
 	MCU_EXT_EVENT_WA_TX_STAT = 0x74,
 	MCU_EXT_EVENT_BCC_NOTIFY = 0x75,
+	MCU_EXT_EVENT_WF_RF_PIN_CTRL = 0x9a,
 	MCU_EXT_EVENT_MURU_CTRL = 0x9f,
 };
 
@@ -1251,6 +1252,7 @@ enum {
 	MCU_EXT_CMD_GROUP_PRE_CAL_INFO = 0xab,
 	MCU_EXT_CMD_DPD_PRE_CAL_INFO = 0xac,
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
+	MCU_EXT_CMD_WF_RF_PIN_CTRL = 0xbd,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 573a2cd7fe45..18daf2bee27b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -252,6 +252,11 @@ int __mt7921_start(struct mt792x_phy *phy)
 			return err;
 	}
 
+	if (phy->chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN) {
+		mt7921_mcu_wf_rf_pin_ctrl(phy, WF_RF_PIN_INIT);
+		wiphy_rfkill_start_polling(mphy->hw->wiphy);
+	}
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(__mt7921_start);
@@ -1398,6 +1403,18 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 	mt7921_abort_roc(mvif->phy, mvif);
 }
 
+static void mt7921_rfkill_poll(struct ieee80211_hw *hw)
+{
+	struct mt792x_phy *phy = mt792x_hw_phy(hw);
+	int ret = 0;
+
+	mt792x_mutex_acquire(phy->dev);
+	ret = mt7921_mcu_wf_rf_pin_ctrl(phy, WF_RF_PIN_POLL);
+	mt792x_mutex_release(phy->dev);
+
+	wiphy_rfkill_set_hw_state(hw->wiphy, ret ? false : true);
+}
+
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt792x_tx,
 	.start = mt7921_start,
@@ -1457,6 +1474,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.unassign_vif_chanctx = mt792x_unassign_vif_chanctx,
 	.mgd_prepare_tx = mt7921_mgd_prepare_tx,
 	.mgd_complete_tx = mt7921_mgd_complete_tx,
+	.rfkill_poll = mt7921_rfkill_poll,
 };
 EXPORT_SYMBOL_GPL(mt7921_ops);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ddc5986086d9..5472a2765ab1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -61,6 +61,12 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt76_connac_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
+	} else if (cmd == MCU_EXT_CMD(WF_RF_PIN_CTRL)) {
+		struct mt7921_wf_rf_pin_ctrl_event *event;
+
+		skb_pull(skb, sizeof(*rxd));
+		event = (struct mt7921_wf_rf_pin_ctrl_event *)skb->data;
+		ret = (int)le32_to_cpu(event->result);
 	} else {
 		skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
 	}
@@ -1427,6 +1433,21 @@ int mt7921_mcu_get_temperature(struct mt792x_phy *phy)
 				 sizeof(req), true);
 }
 
+int mt7921_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy, u8 action)
+{
+	struct mt792x_dev *dev = phy->dev;
+	struct {
+		u8 action;
+		u8 value;
+	} req = {
+		.action = action,
+		.value = 0,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(WF_RF_PIN_CTRL), &req,
+				 sizeof(req), action ? true : false);
+}
+
 int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
index f9a259ee6b82..2834c6c53e58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.h
@@ -74,6 +74,11 @@ struct mt7921_txpwr_event {
 	struct mt7921_txpwr txpwr;
 } __packed;
 
+struct mt7921_wf_rf_pin_ctrl_event {
+	u8 result;
+	u8 value;
+} __packed;
+
 enum {
 	TM_SWITCH_MODE,
 	TM_SET_AT_CMD,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 16c89815c0b8..5a221579b092 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -31,6 +31,9 @@
 #define EXT_CMD_RADIO_ON_LED            0x2
 #define EXT_CMD_RADIO_OFF_LED           0x3
 
+#define WF_RF_PIN_INIT		0x0
+#define WF_RF_PIN_POLL		0x1
+
 enum {
 	UNI_ROC_ACQUIRE,
 	UNI_ROC_ABORT,
@@ -202,6 +205,7 @@ void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
 int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
 int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value);
+int mt7921_mcu_wf_rf_pin_ctrl(struct mt792x_phy *phy, u8 action);
 
 static inline u32
 mt7921_reg_map_l1(struct mt792x_dev *dev, u32 addr)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 67723c22aea6..b76660325599 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -42,6 +42,10 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 {
 	int i;
 	struct mt76_connac_pm *pm = &dev->pm;
+	struct ieee80211_hw *hw = mt76_hw(dev);
+
+	if (dev->phy.chip_cap & MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN)
+		wiphy_rfkill_stop_polling(hw->wiphy);
 
 	cancel_work_sync(&dev->init_work);
 	mt76_unregister_device(&dev->mt76);
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index ab12616ec2b8..11c57b9c7bb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -28,6 +28,7 @@
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
 #define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
 #define MT792x_CHIP_CAP_MLO_EVT_EN BIT(2)
+#define MT792x_CHIP_CAP_WF_RF_PIN_CTRL_EVT_EN BIT(3)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
-- 
2.45.2


