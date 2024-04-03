Return-Path: <linux-wireless+bounces-5795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E353C896B12
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 11:52:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 125281C24828
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Apr 2024 09:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80595134CC8;
	Wed,  3 Apr 2024 09:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="Wd89HncC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8B76EB73
	for <linux-wireless@vger.kernel.org>; Wed,  3 Apr 2024 09:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712137953; cv=none; b=le8t0Kl5r6hhId/g/xvap4XVSGMGYM+DDbB80Yaw6zyHtf7TOmQ2OmB73uwqW3oncfYSLpuJ+XQtvIB5ZHccGRpAyupQqjch8xWCuhBLTBmNXTRLHP8OD/eijzxsGUH8j/X1J0rDf8Jfnnk6+JCpbQ96X1zLopU5phX7DOEOPZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712137953; c=relaxed/simple;
	bh=lbxUiISgJz4GO5tC8DjacOmjzrqbnJiUbyCFr4oEp8c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=W6INTPOFvLXQXmJIzZQIdoVXHaRrtAx1FgvIjwuf2uP7tR01sbWL28fmfNiPv2mqfkfKct1uMKcMdR1246XKLwWiX5m+iqZwj/WJM9BeC5RTogwUJb50fblYVTuhzg68RHclWyyJ6YR0mD/bK9SOwJ7ecToKeNuZyRsqRRbj2u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=Wd89HncC; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: da640e36f19f11eeb8927bc1f75efef4-20240403
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=qeWypaWPri9rAciaLOJ6QGFlszp1IkAwPLtsuqUh4/c=;
	b=Wd89HncCqiuuIDK5PxX1OwXkXXvpesZ1/x66C9pjCEfbLxYSsBTJbvfiJxaryt4zWn4HGFDRbpVN+exbNHPZ8AqnZDO8xoQtIRqBNLUOt2MXZve/32e5VPhRFRT/oVrHW0p6EPRBYFDKP7Zw4NtwFCH2QRR2fdnmWO4iVezgL7Y=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.37,REQID:5ca6bdb2-f830-46dc-841a-a5072c53824c,IP:0,U
	RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
	release,TS:0
X-CID-META: VersionHash:6f543d0,CLOUDID:a7034582-4f93-4875-95e7-8c66ea833d57,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
	RL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,
	SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: da640e36f19f11eeb8927bc1f75efef4-20240403
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 2021280097; Wed, 03 Apr 2024 17:52:16 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 3 Apr 2024 17:52:15 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 3 Apr 2024 17:52:15 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Soul.Huang@mediatek.com>, <Leon.Yen@mediatek.com>,
	<Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
	<robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
	<Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Rong Yan <rong.yan@mediatek.com>, Ming
 Yen Hsieh <mingyen.hsieh@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: cqm rssi low/high event notify
Date: Wed, 3 Apr 2024 17:52:14 +0800
Message-ID: <20240403095214.20596-1-mingyen.hsieh@mediatek.com>
X-Mailer: git-send-email 2.18.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

From: "Rong Yan" <rong.yan@mediatek.com>

The implementation amounts to setting the driver flag
IEEE80211_VIF_SUPPORTS_CQM_RSSI, and then providing
mechanisms for continuously updating enough information
to be able to provide notifications to userspace when
RSSI drops below a certain threshold

Signed-off-by: Rong Yan <rong.yan@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  6 ++
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  5 ++
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 61 +++++++++++++++++++
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
 drivers/net/wireless/mediatek/mt76/mt792x.h   |  1 +
 5 files changed, 74 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 657a4d1f856b..8a6642495d62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1004,6 +1004,7 @@ enum {
 	MCU_EVENT_CH_PRIVILEGE = 0x18,
 	MCU_EVENT_SCHED_SCAN_DONE = 0x23,
 	MCU_EVENT_DBG_MSG = 0x27,
+	MCU_EVENT_RSSI_NOTIFY = 0x96,
 	MCU_EVENT_TXPWR = 0xd0,
 	MCU_EVENT_EXT = 0xed,
 	MCU_EVENT_RESTART_DL = 0xef,
@@ -1303,6 +1304,7 @@ enum {
 	MCU_CE_CMD_SCHED_SCAN_ENABLE = 0x61,
 	MCU_CE_CMD_SCHED_SCAN_REQ = 0x62,
 	MCU_CE_CMD_GET_NIC_CAPAB = 0x8a,
+	MCU_CE_CMD_RSSI_MONITOR = 0xa1,
 	MCU_CE_CMD_SET_MU_EDCA_PARMS = 0xb0,
 	MCU_CE_CMD_REG_WRITE = 0xc0,
 	MCU_CE_CMD_REG_READ = 0xc0,
@@ -1448,6 +1450,10 @@ struct mt76_connac_beacon_loss_event {
 	u8 pad[2];
 } __packed;
 
+struct mt76_connac_rssi_notify_event {
+	s32 rssi[4];
+} __packed;
+
 struct mt76_connac_mcu_bss_event {
 	u8 bss_idx;
 	u8 is_absent;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index ca36de34171b..afcda7c481e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -310,6 +310,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	}
 
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
+		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
 out:
 	mt792x_mutex_release(dev);
 
@@ -679,6 +681,9 @@ static void mt7921_bss_info_changed(struct ieee80211_hw *hw,
 	if (changed & BSS_CHANGED_PS)
 		mt7921_mcu_uni_bss_ps(dev, vif);
 
+	if (changed & BSS_CHANGED_CQM)
+		mt7921_mcu_set_rssimonitor(dev, vif);
+
 	if (changed & BSS_CHANGED_ASSOC) {
 		mt7921_mcu_sta_update(dev, NULL, vif, true,
 				      MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8b4ce32a2cd1..5ccef867b4b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -253,6 +253,42 @@ mt7921_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	mt7921_mac_add_txs(dev, event->txs);
 }
 
+static void
+mt7921_mcu_rssi_monitor_iter(void *priv, u8 *mac,
+			     struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct mt76_connac_rssi_notify_event *event = priv;
+	enum nl80211_cqm_rssi_threshold_event nl_event;
+	s32 rssi = le32_to_cpu(event->rssi[mvif->mt76.idx]);
+
+	if (!rssi)
+		return;
+
+	if (!(vif->driver_flags & IEEE80211_VIF_SUPPORTS_CQM_RSSI))
+		return;
+
+	if (rssi > vif->bss_conf.cqm_rssi_thold)
+		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_HIGH;
+	else
+		nl_event = NL80211_CQM_RSSI_THRESHOLD_EVENT_LOW;
+
+	ieee80211_cqm_rssi_notify(vif, nl_event, rssi, GFP_KERNEL);
+}
+
+static void
+mt7921_mcu_rssi_monitor_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct mt76_connac_rssi_notify_event *event;
+
+	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
+	event = (struct mt76_connac_rssi_notify_event *)skb->data;
+
+	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
+						   IEEE80211_IFACE_ITER_RESUME_ALL,
+						   mt7921_mcu_rssi_monitor_iter, event);
+}
+
 static void
 mt7921_mcu_rx_unsolicited_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
@@ -281,6 +317,9 @@ mt7921_mcu_rx_unsolicited_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_TX_DONE:
 		mt7921_mcu_tx_done_event(dev, skb);
 		break;
+	case MCU_EVENT_RSSI_NOTIFY:
+		mt7921_mcu_rssi_monitor_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -327,6 +366,7 @@ void mt7921_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
+	    rxd->eid == MCU_EVENT_RSSI_NOTIFY ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_TX_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
@@ -1391,3 +1431,24 @@ int mt7921_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_RX_FILTER),
 				 &data, sizeof(data), false);
 }
+
+int mt7921_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
+	struct {
+		u8 enable;
+		s8 cqm_rssi_high;
+		s8 cqm_rssi_low;
+		u8 bss_idx;
+		u16 duration;
+		u8 rsv2[2];
+	} __packed data = {
+		.enable = vif->cfg.assoc,
+		.cqm_rssi_high = vif->bss_conf.cqm_rssi_thold + vif->bss_conf.cqm_rssi_hyst,
+		.cqm_rssi_low = vif->bss_conf.cqm_rssi_thold - vif->bss_conf.cqm_rssi_hyst,
+		.bss_idx = mvif->mt76.idx,
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(RSSI_MONITOR),
+				 &data, sizeof(data), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 3016636d18c6..62617589a84f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -323,4 +323,5 @@ int mt7921_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 int mt7921_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
 			 u8 token_id);
 void mt7921_roc_abort_sync(struct mt792x_dev *dev);
+int mt7921_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif);
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index a8556de3d480..4c14e2c5da5b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -26,6 +26,7 @@
 #define MT792x_FW_CAP_CNM	BIT(7)
 
 #define MT792x_CHIP_CAP_CLC_EVT_EN BIT(0)
+#define MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN BIT(1)
 
 /* NOTE: used to map mt76_rates. idx may change if firmware expands table */
 #define MT792x_BASIC_RATES_TBL	11
-- 
2.18.0


