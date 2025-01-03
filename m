Return-Path: <linux-wireless+bounces-17050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DA87A009FF
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 14:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81A477A1AF2
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 13:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7221F9ED8;
	Fri,  3 Jan 2025 13:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="FM/su1Oa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57351157E6B
	for <linux-wireless@vger.kernel.org>; Fri,  3 Jan 2025 13:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735911898; cv=none; b=e4T620OsvmzF4i3RXsiXVYzB0WgCS07vhpnooUqi3qLf+cyKzD7pYRJ8j9xeoxxTlDogjpAC3ZPY4RUqIae1JmWhkQNXH9kcX7ud+aMUFzs3r68ym6pQAEoLs7wUa164Ti/5zWxVWYcTpNVjC6Yu7FCrpev5lcWY/vfsoctKzgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735911898; c=relaxed/simple;
	bh=86eaZPAwJkB8x1scEOZY7EUi3pykGS2fbfH/UOHts0I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TU8G1i9OKqyNhxcY4yxRh40DMGDV1dPnbVH0cIFc4YSQ6cHOb8SIPPerDDx/QXOmeQiDLW35OnR38HhsV6UUpNIgzurbI+Sbi1Z+/oxmxpMcC5KCyMwDryCA4uYWus2Ipf/f16jAJLICQqwwVEmErxX7iCwfrkBK/VUYGnzrYps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=FM/su1Oa; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: e7f7b00ec9d811ef99858b75a2457dd9-20250103
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=N9pKPNPgx8wQru1Mx45ZWBWFssBki6SvMzK0c2ZDGOE=;
	b=FM/su1OaFRjEz5fepOOQpe1uDo/dVlgHW/pk7pAgsdlWPJWtncANxLkNv60OUjbCFntQTk3enAEG6rXH+ManWjKE7lco/uD4ZzCpmOhELPI0NUx9cdUGjqugSrRRzjpy4zJPvwohEt3rxKRORyAOpaIGcl3U1vNsAHIokRltg2k=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.46,REQID:95944f90-0051-4243-b3aa-46cb39242ed2,IP:0,U
	RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
	N:release,TS:-25
X-CID-META: VersionHash:60aa074,CLOUDID:4baf5137-e11c-4c1a-89f7-e7a032832c40,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0|50,EDM:-3,IP:ni
	l,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES
	:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: e7f7b00ec9d811ef99858b75a2457dd9-20250103
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
	(envelope-from <quan.zhou@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1083669429; Fri, 03 Jan 2025 21:44:51 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 3 Jan 2025 21:44:50 +0800
Received: from mhfsdcap04.gcn.mediatek.inc (10.17.3.154) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 3 Jan 2025 21:44:49 +0800
From: Quan Zhou <quan.zhou@mediatek.com>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC: Sean Wang <sean.wang@mediatek.com>, Deren Wu <Deren.Wu@mediatek.com>,
	Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
	Leon Yen <Leon.Yen@mediatek.com>, Ming Yen Hsieh
	<mingyen.hsieh@mediatek.com>, Allan Wang <allan.wang@mediatek.com>, KM Lin
	<km.lin@mediatek.com>, Posh Sun <posh.sun@mediatek.com>, Shengxi Xu
	<shengxi.xu@mediatek.com>, Eric-SY Chang <Eric-SY.Chang@mediatek.com>, CH Yeh
	<ch.yeh@mediatek.com>, Robin Chiu <robin.chiu@mediatek.com>, linux-wireless
	<linux-wireless@vger.kernel.org>, linux-mediatek
	<linux-mediatek@lists.infradead.org>, Quan Zhou <quan.zhou@mediatek.com>
Subject: [patch] wifi: mt76: mt7925: add handler to hif suspend/resume event
Date: Fri, 3 Jan 2025 21:44:54 +0800
Message-ID: <3a0844ff5162142c4a9f3cf7104f75076ddd3b87.1735910562.git.quan.zhou@mediatek.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-MTK: N

When the system suspend or resume, the WiFi driver sends
an hif_ctrl command to the firmware and waits for an event.
Due to changes in the event format reported by the chip, the
current mt7925's driver does not account for these changes,
resulting in command timeout. Add flow to handle hif_ctrl
event to avoid command timeout. We also exented API
mt76_connac_mcu_set_hif_suspend for connac3 this time.

Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7615/sdio.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7615/usb.c   |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  6 +--
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  6 +--
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  4 +-
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 49 ++++++++++++++++++-
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 20 ++++++++
 .../net/wireless/mediatek/mt76/mt7925/pci.c   | 29 ++++++++---
 .../net/wireless/mediatek/mt76/mt7925/usb.c   | 20 ++++++--
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  2 +
 14 files changed, 127 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 376975388007..4f0c840ef93d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -1249,7 +1249,7 @@ static int mt7615_suspend(struct ieee80211_hw *hw,
 					    phy->mt76);
 
 	if (!mt7615_dev_running(dev))
-		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, true);
 
 	mt7615_mutex_release(dev);
 
@@ -1271,7 +1271,7 @@ static int mt7615_resume(struct ieee80211_hw *hw)
 	if (!running) {
 		int err;
 
-		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false, true);
 		if (err < 0) {
 			mt7615_mutex_release(dev);
 			return err;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 9f43e673518b..9a278589df4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -83,7 +83,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	hif_suspend = !test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 		      mt7615_firmware_offload(dev);
 	if (hif_suspend) {
-		err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+		err = mt76_connac_mcu_set_hif_suspend(mdev, true, true);
 		if (err)
 			return err;
 	}
@@ -131,7 +131,7 @@ static int mt7615_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	}
 	napi_enable(&mdev->tx_napi);
 	if (hif_suspend)
-		mt76_connac_mcu_set_hif_suspend(mdev, false);
+		mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 
 	return err;
 }
@@ -175,7 +175,7 @@ static int mt7615_pci_resume(struct pci_dev *pdev)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 	    mt7615_firmware_offload(dev))
-		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+		err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
index aebfc4576aa4..f56038cd4d3a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio.c
@@ -191,7 +191,7 @@ static int mt7663s_suspend(struct device *dev)
 	    mt7615_firmware_offload(mdev)) {
 		int err;
 
-		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, true);
+		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, true, true);
 		if (err < 0)
 			return err;
 	}
@@ -230,7 +230,7 @@ static int mt7663s_resume(struct device *dev)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &mdev->mphy.state) &&
 	    mt7615_firmware_offload(mdev))
-		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, false);
+		err = mt76_connac_mcu_set_hif_suspend(&mdev->mt76, false, true);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
index 5020af52c68c..4aa9fa1c4a23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb.c
@@ -225,7 +225,7 @@ static int mt7663u_suspend(struct usb_interface *intf, pm_message_t state)
 	    mt7615_firmware_offload(dev)) {
 		int err;
 
-		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, true);
 		if (err < 0)
 			return err;
 	}
@@ -253,7 +253,7 @@ static int mt7663u_resume(struct usb_interface *intf)
 
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state) &&
 	    mt7615_firmware_offload(dev))
-		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+		err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false, true);
 
 	return err;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4171710d645c..e522cc24e032 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2530,7 +2530,7 @@ mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_wow_ctrl);
 
-int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
+int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend, bool wait_resp)
 {
 	struct {
 		struct {
@@ -2562,7 +2562,7 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 		req.hdr.hif_type = 0;
 
 	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(HIF_CTRL), &req,
-				 sizeof(req), true);
+				 sizeof(req), wait_resp);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_hif_suspend);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 919194ab6265..5b29d3b94ba8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1050,6 +1050,7 @@ enum {
 /* unified event table */
 enum {
 	MCU_UNI_EVENT_RESULT = 0x01,
+	MCU_UNI_EVENT_HIF_CTRL = 0x03,
 	MCU_UNI_EVENT_FW_LOG_2_HOST = 0x04,
 	MCU_UNI_EVENT_ACCESS_REG = 0x6,
 	MCU_UNI_EVENT_IE_COUNTDOWN = 0x09,
@@ -1991,7 +1992,7 @@ int mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
 				     struct ieee80211_vif *vif,
 				     bool enable, u8 mdtim,
 				     bool wow_suspend);
-int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
+int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend, bool wait_resp);
 void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
 int mt76_connac_sta_state_dp(struct mt76_dev *dev,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index b76660325599..ba870e1b05fb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -439,7 +439,7 @@ static int mt7921_pci_suspend(struct device *device)
 	if (err < 0)
 		goto restore_suspend;
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true, true);
 	if (err)
 		goto restore_suspend;
 
@@ -485,7 +485,7 @@ static int mt7921_pci_suspend(struct device *device)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
-	mt76_connac_mcu_set_hif_suspend(mdev, false);
+	mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 
 restore_suspend:
 	pm->suspended = false;
@@ -536,7 +536,7 @@ static int mt7921_pci_resume(struct device *device)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 	if (err < 0)
 		goto failed;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 95f526f7bb99..45b9f35aab17 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -240,7 +240,7 @@ static int mt7921s_suspend(struct device *__dev)
 			   mt76s_txqs_empty(&dev->mt76), 5 * HZ);
 
 	/* It is supposed that SDIO bus is idle at the point */
-	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
+	err = mt76_connac_mcu_set_hif_suspend(mdev, true, true);
 	if (err)
 		goto restore_worker;
 
@@ -258,7 +258,7 @@ static int mt7921s_suspend(struct device *__dev)
 restore_txrx_worker:
 	mt76_worker_enable(&mdev->sdio.net_worker);
 	mt76_worker_enable(&mdev->sdio.txrx_worker);
-	mt76_connac_mcu_set_hif_suspend(mdev, false);
+	mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 
 restore_worker:
 	mt76_worker_enable(&mdev->tx_worker);
@@ -302,7 +302,7 @@ static int mt7921s_resume(struct device *__dev)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false, true);
 failed:
 	pm->suspended = false;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index e3459295ad88..fe9751851ff7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -260,7 +260,7 @@ static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 	pm->suspended = true;
 	flush_work(&dev->reset_work);
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, true);
 	if (err)
 		goto failed;
 
@@ -310,7 +310,7 @@ static int mt7921u_resume(struct usb_interface *intf)
 	if (err < 0)
 		goto failed;
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false, true);
 failed:
 	pm->suspended = false;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index d4d3ecf863c4..e80707f534b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -39,7 +39,6 @@ int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
 		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
-		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
 		   cmd == MCU_UNI_CMD(OFFLOAD) ||
 		   cmd == MCU_UNI_CMD(SUSPEND)) {
 		struct mt7925_mcu_uni_event *event;
@@ -341,6 +340,51 @@ static void mt7925_mcu_roc_handle_grant(struct mt792x_dev *dev,
 		  jiffies + msecs_to_jiffies(duration));
 }
 
+static void
+mt7925_mcu_handle_hif_ctrl_basic(struct mt792x_dev *dev, struct tlv *tlv)
+{
+	struct mt7925_mcu_hif_ctrl_basic_tlv *basic;
+
+	basic = (struct mt7925_mcu_hif_ctrl_basic_tlv *)tlv;
+
+	if (basic->hifsuspend) {
+		if (basic->hif_tx_traffic_status == HIF_TRAFFIC_IDLE &&
+		    basic->hif_rx_traffic_status == HIF_TRAFFIC_IDLE)
+			/* success */
+			dev->hif_idle = true;
+		else
+			/* busy */
+			/* invalid */
+			dev->hif_idle = false;
+	} else {
+		dev->hif_resumed = true;
+	}
+	wake_up(&dev->wait);
+}
+
+static void
+mt7925_mcu_uni_hif_ctrl_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct tlv *tlv;
+	u32 tlv_len;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	tlv = (struct tlv *)skb->data;
+	tlv_len = skb->len;
+
+	while (tlv_len > 0 && le16_to_cpu(tlv->len) <= tlv_len) {
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_HIF_CTRL_BASIC:
+			mt7925_mcu_handle_hif_ctrl_basic(dev, tlv);
+			break;
+		default:
+			break;
+		}
+		tlv_len -= le16_to_cpu(tlv->len);
+		tlv = (struct tlv *)((char *)(tlv) + le16_to_cpu(tlv->len));
+	}
+}
+
 static void
 mt7925_mcu_uni_roc_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
@@ -487,6 +531,9 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 	rxd = (struct mt7925_mcu_rxd *)skb->data;
 
 	switch (rxd->eid) {
+	case MCU_UNI_EVENT_HIF_CTRL:
+		mt7925_mcu_uni_hif_ctrl_event(dev, skb);
+		break;
 	case MCU_UNI_EVENT_FW_LOG_2_HOST:
 		mt7925_mcu_uni_debug_msg_event(dev, skb);
 		break;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index a7325ec13c70..8707b5d04743 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -27,6 +27,26 @@
 
 #define MCU_UNI_EVENT_ROC  0x27
 
+#define HIF_TRAFFIC_IDLE 0x2
+
+enum {
+	UNI_EVENT_HIF_CTRL_BASIC = 0,
+	UNI_EVENT_HIF_CTRL_TAG_NUM
+};
+
+struct mt7925_mcu_hif_ctrl_basic_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 cid;
+	u8 pad[3];
+	u32 status;
+	u8 hif_type;
+	u8 hif_tx_traffic_status;
+	u8 hif_rx_traffic_status;
+	u8 hifsuspend;
+	u8 rsv[4];
+} __packed;
+
 enum {
 	UNI_ROC_ACQUIRE,
 	UNI_ROC_ABORT,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 5c9282b76522..f36893e20c61 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -442,9 +442,10 @@ static int mt7925_pci_suspend(struct device *device)
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i, err;
+	int i, err, ret;
 
 	pm->suspended = true;
+	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
 	cancel_delayed_work_sync(&pm->ps_work);
 	cancel_work_sync(&pm->wake_work);
@@ -463,9 +464,13 @@ static int mt7925_pci_suspend(struct device *device)
 	 */
 	mt7925_mcu_set_deep_sleep(dev, true);
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, true);
-	if (err)
+	mt76_connac_mcu_set_hif_suspend(mdev, true, false);
+	ret = wait_event_timeout(dev->wait,
+				 dev->hif_idle, 3 * HZ);
+	if (!ret) {
+		err = -ETIMEDOUT;
 		goto restore_suspend;
+	}
 
 	napi_disable(&mdev->tx_napi);
 	mt76_worker_disable(&mdev->tx_worker);
@@ -509,8 +514,11 @@ static int mt7925_pci_suspend(struct device *device)
 	if (!pm->ds_enable)
 		mt7925_mcu_set_deep_sleep(dev, false);
 
-	mt76_connac_mcu_set_hif_suspend(mdev, false);
-
+	mt76_connac_mcu_set_hif_suspend(mdev, false, false);
+	ret = wait_event_timeout(dev->wait,
+				 dev->hif_resumed, 3 * HZ);
+	if (!ret)
+		err = -ETIMEDOUT;
 restore_suspend:
 	pm->suspended = false;
 
@@ -526,8 +534,9 @@ static int mt7925_pci_resume(struct device *device)
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt76_connac_pm *pm = &dev->pm;
-	int i, err;
+	int i, err, ret;
 
+	dev->hif_idle = false;
 	err = mt792x_mcu_drv_pmctrl(dev);
 	if (err < 0)
 		goto failed;
@@ -556,9 +565,13 @@ static int mt7925_pci_resume(struct device *device)
 	napi_schedule(&mdev->tx_napi);
 	local_bh_enable();
 
-	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
-	if (err < 0)
+	mt76_connac_mcu_set_hif_suspend(mdev, false, false);
+	ret = wait_event_timeout(dev->wait,
+				 dev->hif_resumed, 3 * HZ);
+	if (!ret) {
+		err = -ETIMEDOUT;
 		goto failed;
+	}
 
 	/* restore previous ds setting */
 	if (!pm->ds_enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 682db1bab21c..4dfbc1b6cfdd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -243,14 +243,19 @@ static int mt7925u_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct mt792x_dev *dev = usb_get_intfdata(intf);
 	struct mt76_connac_pm *pm = &dev->pm;
-	int err;
+	int err, ret;
 
 	pm->suspended = true;
+	dev->hif_resumed = false;
 	flush_work(&dev->reset_work);
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
-	if (err)
+	mt76_connac_mcu_set_hif_suspend(&dev->mt76, true, false);
+	ret = wait_event_timeout(dev->wait,
+				 dev->hif_idle, 3 * HZ);
+	if (!ret) {
+		err = -ETIMEDOUT;
 		goto failed;
+	}
 
 	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
@@ -271,8 +276,9 @@ static int mt7925u_resume(struct usb_interface *intf)
 	struct mt792x_dev *dev = usb_get_intfdata(intf);
 	struct mt76_connac_pm *pm = &dev->pm;
 	bool reinit = true;
-	int err, i;
+	int err, i, ret;
 
+	dev->hif_idle = false;
 	for (i = 0; i < 10; i++) {
 		u32 val = mt76_rr(dev, MT_WF_SW_DEF_CR_USB_MCU_EVENT);
 
@@ -298,7 +304,11 @@ static int mt7925u_resume(struct usb_interface *intf)
 	if (err < 0)
 		goto failed;
 
-	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+	mt76_connac_mcu_set_hif_suspend(&dev->mt76, false, false);
+	ret = wait_event_timeout(dev->wait,
+				 dev->hif_resumed, 3 * HZ);
+	if (!ret)
+		err = -ETIMEDOUT;
 failed:
 	pm->suspended = false;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 3f989e83f252..1b612d123d9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -222,6 +222,8 @@ struct mt792x_dev {
 	bool has_eht:1;
 	bool regd_in_progress:1;
 	bool aspm_supported:1;
+	bool hif_idle:1;
+	bool hif_resumed:1;
 	wait_queue_head_t wait;
 
 	struct work_struct init_work;
-- 
2.46.0


