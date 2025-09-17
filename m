Return-Path: <linux-wireless+bounces-27420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD36B7E409
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 14:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E22C1BC351C
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 05:36:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01E6B1494A8;
	Wed, 17 Sep 2025 05:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b="LEefuJXh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D460BA42
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 05:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=60.244.123.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758087387; cv=none; b=W+BpGeyeodhcSQqIZbmtPJPLTe8VbZLAHUveIVifZ0mh/ZKjs5OhSQk4udKSqZ1NK5KOB+UpqB9TyS3gdkd0uuqLcKv22GspAYuQ2E9Oa7rQcsQLIEVrg6ZjPigKmfnGIM9JLHQLxzmkQ6ilnYV5TAeeGXsaRw+XAkQY6csoHao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758087387; c=relaxed/simple;
	bh=CMXobuaG7zupU3wdBjUPissy5icg5An+sqT4vvYcsDQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jfj4TiuPhNYeg/7K6lhqaeWResPUWN/fREJjhRcQrNjqXqjpKPlHCqNpxrlo8ft/lD/AwssuNlrhPqPRML9p9BwZ2gPc39ovZSr9nmTVYhEW4/CIDN+ntEcSsC8PqL2sTcc84kx8XQ+XqJ311+uwwsUctDo/r2LiBMzJsWx2fBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com; spf=pass smtp.mailfrom=mediatek.com; dkim=pass (1024-bit key) header.d=mediatek.com header.i=@mediatek.com header.b=LEefuJXh; arc=none smtp.client-ip=60.244.123.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mediatek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mediatek.com
X-UUID: 3d2bd5cc938811f08d9e1119e76e3a28-20250917
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
	h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=+YNkTiTzV3j5UuyT6fJEnMntl49hId1F5ICyVqvtR0U=;
	b=LEefuJXhp4/zCChcAjB4oXWuzakree1RysibgJf+tdpfp7V0sLnQhuvFM7XRKIbIx+0LNV4XJpYAVffzWEHk2qK8JMo/9K5us1/BB1/Qbq8cNh1DaC8wtfIGT1Pd7pAbAirNnIAybPkPKXQWMLqQ7PR4RkH9NyIR55mnMD62BIw=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.4,REQID:20ce1854-7594-4b8d-9318-6352230ac0e4,IP:0,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:0
X-CID-META: VersionHash:1ca6b93,CLOUDID:b3ac62f8-ebfe-43c9-88c9-80cb93f22ca4,B
	ulkID:nil,BulkQuantity:0,Recheck:0,SF:102|836,TC:-5,Content:0|15|50,EDM:-3
	,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV
	:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 3d2bd5cc938811f08d9e1119e76e3a28-20250917
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
	(envelope-from <mingyen.hsieh@mediatek.com>)
	(Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
	with ESMTP id 1711057517; Wed, 17 Sep 2025 13:36:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.39; Wed, 17 Sep 2025 13:36:18 +0800
Received: from mtksitap99.mediatek.inc (10.233.130.16) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1258.39 via Frontend Transport; Wed, 17 Sep 2025 13:36:18 +0800
From: Mingyen Hsieh <mingyen.hsieh@mediatek.com>
To: <nbd@nbd.name>, <lorenzo@kernel.org>
CC: <deren.wu@mediatek.com>, <Sean.Wang@mediatek.com>,
	<Leon.Yen@mediatek.com>, <Michael.Lo@mediatek.com>,
	<allan.wang@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
	<km.lin@mediatek.com>, <Quan.Zhou@mediatek.com>, <Ryder.Lee@mediatek.com>,
	<Shayne.Chen@mediatek.com>, <linux-wireless@vger.kernel.org>,
	<linux-mediatek@lists.infradead.org>, Jack Kao <jack.kao@mediatek.com>, "Ming
 Yen Hsieh" <mingyen.hsieh@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7925: cqm rssi low/high event notify
Date: Wed, 17 Sep 2025 13:36:17 +0800
Message-ID: <20250917053617.497393-1-mingyen.hsieh@mediatek.com>
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

From: Jack Kao <jack.kao@mediatek.com>

The implementation amounts to setting the driver flag
IEEE80211_VIF_SUPPORTS_CQM_RSSI, and then providing
mechanisms for continuously updating enough information
to be able to provide notifications to userspace when
RSSI drops below a certain threshold

Signed-off-by: Jack Kao <jack.kao@mediatek.com>
Signed-off-by: Ming Yen Hsieh <mingyen.hsieh@mediatek.com>
---
v2: fix build err for parameter of mt7925_mcu_set_rssimonitor()
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +
 .../net/wireless/mediatek/mt76/mt7925/main.c  |  6 ++
 .../net/wireless/mediatek/mt76/mt7925/mcu.c   | 82 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7925/mcu.h   |  8 ++
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  7 ++
 5 files changed, 105 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index b30245ce009a..fd1189e74920 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1063,6 +1063,7 @@ enum {
 	MCU_UNI_EVENT_ROC = 0x27,
 	MCU_UNI_EVENT_TX_DONE = 0x2d,
 	MCU_UNI_EVENT_THERMAL = 0x35,
+	MCU_UNI_EVENT_RSSI_MONITOR = 0x41,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
 	MCU_UNI_EVENT_WED_RRO = 0x57,
 	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
@@ -1301,6 +1302,7 @@ enum {
 	MCU_UNI_CMD_THERMAL = 0x35,
 	MCU_UNI_CMD_VOW = 0x37,
 	MCU_UNI_CMD_FIXED_RATE_TABLE = 0x40,
+	MCU_UNI_CMD_RSSI_MONITOR = 0x41,
 	MCU_UNI_CMD_ICS = 0x49,
 	MCU_UNI_CMD_TESTMODE_CTRL = 0x46,
 	MCU_UNI_CMD_RRO = 0x57,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index eef9fae6a733..8ba27bc6a1ac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -431,6 +431,9 @@ mt7925_add_interface(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 		goto out;
 
 	vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
+	if (phy->chip_cap & MT792x_CHIP_CAP_RSSI_NOTIFY_EVT_EN)
+		vif->driver_flags |= IEEE80211_VIF_SUPPORTS_CQM_RSSI;
+
 out:
 	mt792x_mutex_release(dev);
 
@@ -1949,6 +1952,9 @@ static void mt7925_link_info_changed(struct ieee80211_hw *hw,
 		mt7925_mcu_set_eht_pp(mvif->phy->mt76, &mconf->mt76,
 				      link_conf, NULL);
 
+	if (changed & BSS_CHANGED_CQM)
+		mt7925_mcu_set_rssimonitor(dev, vif);
+
 	mt792x_mutex_release(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 930a8cb83701..8b92d55926e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -595,6 +595,56 @@ mt7925_mcu_tx_done_event(struct mt792x_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7925_mcu_rssi_monitor_iter(void *priv, u8 *mac,
+			     struct ieee80211_vif *vif)
+{
+	struct mt7925_uni_rssi_monitor_event *event = priv;
+	enum nl80211_cqm_rssi_threshold_event nl_event;
+	s32 rssi = le32_to_cpu(event->rssi);
+
+	if (vif->type != NL80211_IFTYPE_STATION)
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
+mt7925_mcu_rssi_monitor_event(struct mt792x_dev *dev, struct sk_buff *skb)
+{
+	struct tlv *tlv;
+	u32 tlv_len;
+	struct mt7925_uni_rssi_monitor_event *event;
+
+	skb_pull(skb, sizeof(struct mt7925_mcu_rxd) + 4);
+	tlv = (struct tlv *)skb->data;
+	tlv_len = skb->len;
+
+	while (tlv_len > 0 && le16_to_cpu(tlv->len) <= tlv_len) {
+		switch (le16_to_cpu(tlv->tag)) {
+		case UNI_EVENT_RSSI_MONITOR_INFO:
+			event = (struct mt7925_uni_rssi_monitor_event *)skb->data;
+			ieee80211_iterate_active_interfaces_atomic(dev->mt76.hw,
+								   IEEE80211_IFACE_ITER_RESUME_ALL,
+								   mt7925_mcu_rssi_monitor_iter,
+								   event);
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
 mt7925_mcu_uni_debug_msg_event(struct mt792x_dev *dev, struct sk_buff *skb)
 {
@@ -704,6 +754,9 @@ mt7925_mcu_uni_rx_unsolicited_event(struct mt792x_dev *dev,
 	case MCU_UNI_EVENT_BSS_BEACON_LOSS:
 		mt7925_mcu_connection_loss_event(dev, skb);
 		break;
+	case MCU_UNI_EVENT_RSSI_MONITOR:
+		mt7925_mcu_rssi_monitor_event(dev, skb);
+		break;
 	case MCU_UNI_EVENT_COREDUMP:
 		dev->fw_assert = true;
 		mt76_connac_mcu_coredump_event(&dev->mt76, skb, &dev->coredump);
@@ -4087,3 +4140,32 @@ int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
 	return mt76_mcu_send_msg(&phy->dev->mt76, MCU_UNI_CMD(BAND_CONFIG),
 				 &req, sizeof(req), true);
 }
+
+int mt7925_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt792x_bss_conf *mconf = mt792x_link_conf_to_mconf(&vif->bss_conf);
+	struct {
+		struct {
+			u8 bss_idx;
+			u8 pad[3];
+		} __packed hdr;
+		__le16 tag;
+		__le16 len;
+		u8 enable;
+		s8 cqm_rssi_high;
+		s8 cqm_rssi_low;
+		u8 rsv;
+	} req = {
+		.hdr = {
+			.bss_idx = mconf->mt76.idx,
+		},
+		.tag = cpu_to_le16(UNI_CMD_RSSI_MONITOR_SET),
+		.len = cpu_to_le16(sizeof(req) - 4),
+		.enable = vif->cfg.assoc,
+		.cqm_rssi_high = (s8)(vif->bss_conf.cqm_rssi_thold + vif->bss_conf.cqm_rssi_hyst),
+		.cqm_rssi_low = (s8)(vif->bss_conf.cqm_rssi_thold - vif->bss_conf.cqm_rssi_hyst),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(RSSI_MONITOR), &req,
+				 sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
index 416b3b717095..fad5369cbf1e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.h
@@ -152,6 +152,14 @@ enum {
 	UNI_EVENT_SCAN_DONE_NLO = 3,
 };
 
+enum {
+	UNI_CMD_RSSI_MONITOR_SET = 0,
+};
+
+enum {
+	UNI_EVENT_RSSI_MONITOR_INFO = 0,
+};
+
 enum connac3_mcu_cipher_type {
 	CONNAC3_CIPHER_NONE = 0,
 	CONNAC3_CIPHER_WEP40 = 1,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 4b8775f5204f..b8ccdc0e2772 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -103,6 +103,12 @@ struct mt7925_uni_beacon_loss_event {
 	struct mt7925_beacon_loss_tlv beacon_loss;
 } __packed;
 
+struct mt7925_uni_rssi_monitor_event {
+		__le16 tag;
+		__le16 len;
+		__le32 rssi;
+} __packed;
+
 #define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
 #define to_rcpi(rssi)			(2 * (rssi) + 220)
 
@@ -373,4 +379,5 @@ int mt7925_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 int mt7925_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *msg,
 			 struct netlink_callback *cb, void *data, int len);
 
+int mt7925_mcu_set_rssimonitor(struct mt792x_dev *dev, struct ieee80211_vif *vif);
 #endif
-- 
2.34.1


