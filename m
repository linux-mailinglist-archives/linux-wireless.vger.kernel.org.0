Return-Path: <linux-wireless+bounces-6078-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFFAC89EE1C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 11:00:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FCA2284137
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Apr 2024 09:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFBE13D8B2;
	Wed, 10 Apr 2024 09:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="PsKIy8AU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE70713D297
	for <linux-wireless@vger.kernel.org>; Wed, 10 Apr 2024 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.61.82.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739600; cv=none; b=pGSKS+97XESoL5yxm32/Agb2HJ01Ep5r0k10T0HBHXeEdSx6P6ox6DkmebheouNNrZebE/ffTwzdBKF/9PSBR+eDVc9R+osFOrSpf4PWHPSQlA0fjAE5jZuctiHOYeeC9klOgZBVs+y6qeatCb7PG1tRCP9I3sy/Ztxj9R5O/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739600; c=relaxed/simple;
	bh=xouM1eXfq2lxMlqjLMfqWQoXflTAbGf6QmEbhv7Bhzw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KjvIHEFluIBKiLZ2BJ6pWz/y62/7sXFZj/ZKj057qHiuVoA/jBpVNYL66IlbB84yE6fnBS1B9AdZOA2BlEGHzexqOatIawOZIz4uxyGhqc1ZYEcVBJ1q5BaCDtBOHsTrltiBvQzxVwx+gWP3Ac49UcoUXtvTLOBNg1raR92XVx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=PsKIy8AU; arc=none smtp.client-ip=210.61.82.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: b1dc9bb2f71811ee935d6952f98a51a9-20240410
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=PFhJxH4CaslXbdhzI7BUJ/XXbZzgyd0FQyEp/joVvY4=;
	b=PsKIy8AUTl3gSNLi42+KIlLHD+S/jqE0ZtoFhuhQT0ILFklSxd0CEWORlX+L5yxc3GHAqXg+F5nGrbUk+asqXxTWaDDNaZbiaCos9dK9OZxFdX/d0RD3LqWOa/E6MOWbTeGMhVo/v5j3GKb81MVyActRZjwe1MfIxVs7261gkVk=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:05ba95f5-7c3e-42cf-84b3-2d6f53c7f804,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:6f543d0,CLOUDID:06cabefa-ed05-4274-9204-014369d201e8,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: b1dc9bb2f71811ee935d6952f98a51a9-20240410
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1337047986; Wed, 10 Apr 2024 16:59:53 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 10 Apr 2024 16:59:51 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 10 Apr 2024 16:59:51 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Quan Zhou <quan.zhou@mediatek.com>, Felix Fietkau <nbd@nbd.name>, Lorenzo
 Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	linux-wireless <linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Shengxi Xu <shengxi.xu@mediatek.com>,
	Hao Zhang <hao.zhang@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921e: add LED control support
Date: Wed, 10 Apr 2024 16:58:51 +0800
Message-ID: <b376f88ab9fd69a5e4ba4bbd2c9fff3ef53b8968.1712735769.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

From: Hao Zhang <hao.zhang@mediatek.com>

Introduce wifi LED switch control, add flow to Control a wifi
gpio pin based on the status of WIFI radio, if the pin is connected
to an LED, the LED will indicate the status of the WiFi radio.

Signed-off-by: Hao Zhang <hao.zhang@mediatek.com>
Co-developed-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 26 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 14 ++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  5 ++++
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  8 +++++-
 5 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 836cc4d5b1d2..4c2de556dee1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1189,6 +1189,7 @@ enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
 	MCU_EXT_CMD_RF_REG_ACCESS = 0x02,
 	MCU_EXT_CMD_RF_TEST = 0x04,
+	MCU_EXT_CMD_ID_RADIO_ON_OFF_CTRL = 0x05,
 	MCU_EXT_CMD_PM_STATE_CTRL = 0x07,
 	MCU_EXT_CMD_CHANNEL_SWITCH = 0x08,
 	MCU_EXT_CMD_SET_TX_POWER_CTRL = 0x11,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ca36de34171b..ac2174b345cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -242,6 +242,15 @@ int __mt7921_start(struct mt792x_phy *phy)
 
 	ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
 				     MT792x_WATCHDOG_TIME);
+	if (mt76_is_mmio(mphy->dev)) {
+		err = mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_LED_CTRL_ENABLE);
+		if (err)
+			return err;
+
+		err = mt7921_mcu_radio_led_ctrl(phy->dev, EXT_CMD_RADIO_ON_LED);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -259,6 +268,21 @@ static int mt7921_start(struct ieee80211_hw *hw)
 	return err;
 }
 
+static void mt7921_stop(struct ieee80211_hw *hw)
+{
+	struct mt792x_dev *dev = mt792x_hw_dev(hw);
+	int err = 0;
+
+	mt792x_mutex_acquire(dev);
+	if (mt76_is_mmio(&dev->mt76))
+		err = mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
+	mt792x_mutex_release(dev);
+	if (err)
+		return;
+
+	mt792x_stop(hw);
+}
+
 static int
 mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 {
@@ -1372,7 +1396,7 @@ static void mt7921_mgd_complete_tx(struct ieee80211_hw *hw,
 const struct ieee80211_ops mt7921_ops = {
 	.tx = mt792x_tx,
 	.start = mt7921_start,
-	.stop = mt792x_stop,
+	.stop = mt7921_stop,
 	.add_interface = mt7921_add_interface,
 	.remove_interface = mt792x_remove_interface,
 	.config = mt7921_config,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8b4ce32a2cd1..2ebf0ffe78d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -606,6 +606,20 @@ int mt7921_run_firmware(struct mt792x_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt7921_run_firmware);
 
+int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value)
+{
+	struct {
+		u8 ctrlid;
+		u8 rsv[3];
+	} __packed req = {
+		.ctrlid = value,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ID_RADIO_ON_OFF_CTRL),
+				&req, sizeof(req), false);
+}
+EXPORT_SYMBOL_GPL(mt7921_mcu_radio_led_ctrl);
+
 int mt7921_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif)
 {
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 3016636d18c6..07023eb9e5b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -27,6 +27,10 @@
 #define MCU_UNI_EVENT_ROC  0x27
 #define MCU_UNI_EVENT_CLC  0x80
 
+#define EXT_CMD_RADIO_LED_CTRL_ENABLE   0x1
+#define EXT_CMD_RADIO_ON_LED            0x2
+#define EXT_CMD_RADIO_OFF_LED           0x3
+
 enum {
 	UNI_ROC_ACQUIRE,
 	UNI_ROC_ABORT,
@@ -196,6 +200,7 @@ int mt7921_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl);
 void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
 int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 			    u8 bit_op, u32 bit_map);
+int mt7921_mcu_radio_led_ctrl(struct mt792x_dev *dev, u8 value);
 
 static inline u32
 mt7921_reg_map_l1(struct mt792x_dev *dev, u32 addr)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 0b69b225bc16..f768e9389ac6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -427,6 +427,10 @@ static int mt7921_pci_suspend(struct device *device)
 	wait_event_timeout(dev->wait,
 			   !dev->regd_in_progress, 5 * HZ);
 
+	err = mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_OFF_LED);
+	if (err < 0)
+		goto restore_suspend;
+
 	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
 	if (err)
 		goto restore_suspend;
@@ -525,9 +529,11 @@ static int mt7921_pci_resume(struct device *device)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
 	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	if (err < 0)
+		goto failed;
 
 	mt7921_regd_update(dev);
-
+	err = mt7921_mcu_radio_led_ctrl(dev, EXT_CMD_RADIO_ON_LED);
 failed:
 	pm->suspended = false;
 
-- 
2.18.0


