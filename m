Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D165378F893
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Sep 2023 08:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238325AbjIAGbP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 1 Sep 2023 02:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235920AbjIAGbO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 1 Sep 2023 02:31:14 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D1019E
        for <linux-wireless@vger.kernel.org>; Thu, 31 Aug 2023 23:31:11 -0700 (PDT)
X-UUID: 20aae436489111eea33bb35ae8d461a2-20230901
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=0XUv38wLx30xOs5huiHsTT0ncas+2Q+QbFHiMrHPa0Y=;
        b=sYUh/eKVRG2nWbbordu14D9Agm63CKYMZF9JlZvDrCrsyu5kF3nT0W1jm6AOPLiMiyqOiI9e5CizPfKcuHtC2Y8AsXkcsn4aETxdf+vegm9MWiB7u7gHc08W2Q1nLIDCKI23Zwnjp5mZdAaOXfB8jaN1E81I9T/8uXusoHn+f6I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:9fa2aebc-be98-48e0-a42d-d5e1bda0f2fb,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:41ddff1f-33fd-4aaa-bb43-d3fd68d9d5ae,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 20aae436489111eea33bb35ae8d461a2-20230901
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1095622452; Fri, 01 Sep 2023 14:31:05 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 1 Sep 2023 14:30:45 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 1 Sep 2023 14:30:28 +0800
From:   Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Johannes Berg <johannes.berg@intel.com>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Money Wang <money.wang@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>,
        Benjamin Lin <benjamin-jw.lin@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
Subject: [PATCH v2 2/4] wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic
Date:   Thu, 31 Aug 2023 23:30:03 -0700
Message-ID: <ef87bde6ef590ce39515a683e33313d1434b3064.1693549298.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <7554d0a64ff480f1a185f381a59799158fe8bf23.1693549298.git.yi-chia.hsieh@mediatek.com>
References: <7554d0a64ff480f1a185f381a59799158fe8bf23.1693549298.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Per peer Tx/Rx statistic can only be obtained by querying WM when WED is
on. This patch switches to periodic event reporting in the case of WED
being enabled.

Signed-off-by: Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>
---
v2: split series
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 15 ++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  5 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 15 ++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 68 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 26 +++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 6 files changed, 130 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4543e5bf0482..ef49ad0ffc35 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1011,6 +1011,8 @@ enum {
 	MCU_UNI_EVENT_FW_LOG_2_HOST = 0x04,
 	MCU_UNI_EVENT_IE_COUNTDOWN = 0x09,
 	MCU_UNI_EVENT_RDD_REPORT = 0x11,
+	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
+	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
 };
 
 #define MCU_UNI_CMD_EVENT			BIT(1)
@@ -1224,6 +1226,8 @@ enum {
 	MCU_UNI_CMD_VOW = 0x37,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
+	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
+	MCU_UNI_CMD_ALL_STA_INFO = 0x6e,
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
 };
 
@@ -1302,6 +1306,17 @@ enum {
 	UNI_OFFLOAD_OFFLOAD_BMC_RPY_DETECT,
 };
 
+enum UNI_ALL_STA_INFO_TAG {
+	UNI_ALL_STA_TX_RATE,
+	UNI_ALL_STA_TX_STAT,
+	UNI_ALL_STA_TXRX_ADM_STAT,
+	UNI_ALL_STA_TXRX_AIR_TIME,
+	UNI_ALL_STA_DATA_TX_RETRY_COUNT,
+	UNI_ALL_STA_GI_MODE,
+	UNI_ALL_STA_TXRX_MSDU_COUNT,
+	UNI_ALL_STA_MAX_NUM
+};
+
 enum {
 	MT_NIC_CAP_TX_RESOURCE,
 	MT_NIC_CAP_TX_EFUSE_ADDR,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 0bdb5533847b..4e19d4f8c70b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2202,6 +2202,11 @@ void mt7996_mac_work(struct work_struct *work)
 		mphy->mac_work_count = 0;
 
 		mt7996_mac_update_stats(phy);
+
+		if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_ADM_STAT);
+			mt7996_mcu_get_all_sta_info(phy, UNI_ALL_STA_TXRX_MSDU_COUNT);
+		}
 	}
 
 	mutex_unlock(&mphy->dev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 07c13fcc187a..37128f7f6671 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -972,6 +972,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  struct station_info *sinfo)
 {
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
 
@@ -1003,6 +1004,20 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 
 	sinfo->avg_ack_signal = -(s8)ewma_avg_signal_read(&msta->avg_ack_signal);
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL_AVG);
+
+	if (mtk_wed_device_active(&phy->dev->mt76.mmio.wed)) {
+		sinfo->tx_bytes = msta->wcid.stats.tx_bytes;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BYTES64);
+
+		sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
+
+		sinfo->tx_packets = msta->wcid.stats.tx_packets;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
+
+		sinfo->rx_packets = msta->wcid.stats.rx_packets;
+		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_PACKETS);
+	}
 }
 
 static void mt7996_sta_rc_work(void *data, struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index 4a30db49ef33..923e6f006cee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -447,6 +447,54 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
 	}
 }
 
+static void
+mt7996_mcu_rx_all_sta_info_event(struct mt7996_dev *dev, struct sk_buff *skb)
+{
+	struct mt7996_mcu_all_sta_info_event *res;
+	u16 i;
+
+	skb_pull(skb, sizeof(struct mt7996_mcu_rxd));
+
+	res = (struct mt7996_mcu_all_sta_info_event *)skb->data;
+
+	for (i = 0; i < le16_to_cpu(res->sta_num); i++) {
+		u8 ac;
+		u16 wlan_idx;
+		struct mt76_wcid *wcid;
+
+		switch (le16_to_cpu(res->tag)) {
+		case UNI_ALL_STA_TXRX_ADM_STAT:
+			wlan_idx = le16_to_cpu(res->adm_stat[i].wlan_idx);
+			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+
+			if (!wcid)
+				break;
+
+			for (ac = 0; ac < IEEE80211_NUM_ACS; ac++) {
+				wcid->stats.tx_bytes +=
+					le32_to_cpu(res->adm_stat[i].tx_bytes[ac]);
+				wcid->stats.rx_bytes +=
+					le32_to_cpu(res->adm_stat[i].rx_bytes[ac]);
+			}
+			break;
+		case UNI_ALL_STA_TXRX_MSDU_COUNT:
+			wlan_idx = le16_to_cpu(res->msdu_cnt[i].wlan_idx);
+			wcid = rcu_dereference(dev->mt76.wcid[wlan_idx]);
+
+			if (!wcid)
+				break;
+
+			wcid->stats.tx_packets +=
+				le32_to_cpu(res->msdu_cnt[i].tx_msdu_cnt);
+			wcid->stats.rx_packets +=
+				le32_to_cpu(res->msdu_cnt[i].rx_msdu_cnt);
+			break;
+		default:
+			break;
+		}
+	}
+}
+
 static void
 mt7996_mcu_rx_ext_event(struct mt7996_dev *dev, struct sk_buff *skb)
 {
@@ -491,6 +539,9 @@ mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	case MCU_UNI_EVENT_RDD_REPORT:
 		mt7996_mcu_rx_radar_detected(dev, skb);
 		break;
+	case MCU_UNI_EVENT_ALL_STA_INFO:
+		mt7996_mcu_rx_all_sta_info_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -3786,3 +3837,20 @@ int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val)
 	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(RRO), &req,
 				 sizeof(req), true);
 }
+
+int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag)
+{
+	struct mt7996_dev *dev = phy->dev;
+	struct {
+		u8 _rsv[4];
+
+		__le16 tag;
+		__le16 len;
+	} __packed req = {
+		.tag = cpu_to_le16(tag),
+		.len = cpu_to_le16(sizeof(req) - 4),
+	};
+
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WM_UNI_CMD(ALL_STA_INFO),
+				 &req, sizeof(req), false);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
index 078f82858621..5aece2046a9d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.h
@@ -153,6 +153,32 @@ struct mt7996_mcu_mib {
 	__le64 data;
 } __packed;
 
+struct mt7996_mcu_all_sta_info_event {
+	u8 rsv[4];
+	__le16 tag;
+	__le16 len;
+	u8 more;
+	u8 rsv2;
+	__le16 sta_num;
+	u8 rsv3[2];
+
+	union {
+		struct {
+			__le16 wlan_idx;
+			u8 rsv[2];
+			__le32 tx_bytes[IEEE80211_NUM_ACS];
+			__le32 rx_bytes[IEEE80211_NUM_ACS];
+		} adm_stat[];
+
+		struct {
+			__le16 wlan_idx;
+			u8 rsv[2];
+			__le32 tx_msdu_cnt;
+			__le32 rx_msdu_cnt;
+		} msdu_cnt[];
+	};
+} __packed;
+
 enum mt7996_chan_mib_offs {
 	UNI_MIB_OBSS_AIRTIME = 26,
 	UNI_MIB_NON_WIFI_TIME = 27,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index 7354e5cf8e67..cb67a2d4c6d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -402,6 +402,7 @@ int mt7996_mcu_fw_dbg_ctrl(struct mt7996_dev *dev, u32 module, u8 level);
 int mt7996_mcu_trigger_assert(struct mt7996_dev *dev);
 void mt7996_mcu_rx_event(struct mt7996_dev *dev, struct sk_buff *skb);
 void mt7996_mcu_exit(struct mt7996_dev *dev);
+int mt7996_mcu_get_all_sta_info(struct mt7996_phy *phy, u16 tag);
 
 static inline u8 mt7996_max_interface_num(struct mt7996_dev *dev)
 {
-- 
2.39.0

