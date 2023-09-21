Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D9BE7AA2C6
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Sep 2023 23:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbjIUV3i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 21 Sep 2023 17:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjIUV3V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 21 Sep 2023 17:29:21 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0191F39
        for <linux-wireless@vger.kernel.org>; Thu, 21 Sep 2023 14:04:27 -0700 (PDT)
X-UUID: 6f6b8dbe58c211ee8051498923ad61e6-20230922
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=JEmBur8IrWF7H3eaG1P6OqGIJv6H+pdRVpteKFJh99M=;
        b=oyfGmZc3r46lg+EoUC3HFxW2FtNuG/+Oc8Onr21k+0oTFM25VFbstNWfo6JGzuItashSpAO0HxzsDOrR/aE0p9hakO65S/kbSJV0QQ4YBtl3My1rH1aH1WRxEgMtdewpdEd0BND8shH1I90N8RF0vRoJ/cOJhaf6axQqVi6UN1M=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:7d1e2a46-c096-4f08-84fb-2f47429eeae1,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:15324fc3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: 6f6b8dbe58c211ee8051498923ad61e6-20230922
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <yi-chia.hsieh@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 420651810; Fri, 22 Sep 2023 05:04:21 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 22 Sep 2023 05:04:19 +0800
Received: from mussdccf250.mussds.eus.mediatek.inc (10.73.250.250) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Fri, 22 Sep 2023 05:04:17 +0800
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
        Yi-Chia Hsieh <yi-chia.hsieh@mediatek.com>,
        Money Wang <Money.Wang@mediatek.com>
Subject: [PATCH v3 2/4] wifi: mt76: mt7996: Add mcu commands for getting sta tx statistic
Date:   Thu, 21 Sep 2023 14:04:01 -0700
Message-ID: <058e5e4daa9c89c52ce119825343ac3bd7b70a15.1695329286.git.yi-chia.hsieh@mediatek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <d698600dc16fc3880e75dd24e2338ac21d51a45a.1695329286.git.yi-chia.hsieh@mediatek.com>
References: <d698600dc16fc3880e75dd24e2338ac21d51a45a.1695329286.git.yi-chia.hsieh@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no
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
Signed-off-by: Money Wang <Money.Wang@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Evelyn Tsai <evelyn.tsai@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2: split series
---
v3: rebase and fix "build error: flexible array member in union"
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 15 ++++
 .../net/wireless/mediatek/mt76/mt7996/mac.c   |  5 ++
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 15 ++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.c   | 68 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7996/mcu.h   | 26 +++++++
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  1 +
 6 files changed, 130 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 9bc97a35fc1d..e97adaf9976c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1022,6 +1022,8 @@ enum {
 	MCU_UNI_EVENT_ROC = 0x27,
 	MCU_UNI_EVENT_TX_DONE = 0x2d,
 	MCU_UNI_EVENT_NIC_CAPAB = 0x43,
+	MCU_UNI_EVENT_PER_STA_INFO = 0x6d,
+	MCU_UNI_EVENT_ALL_STA_INFO = 0x6e,
 };
 
 #define MCU_UNI_CMD_EVENT			BIT(1)
@@ -1240,6 +1242,8 @@ enum {
 	MCU_UNI_CMD_VOW = 0x37,
 	MCU_UNI_CMD_RRO = 0x57,
 	MCU_UNI_CMD_OFFCH_SCAN_CTRL = 0x58,
+	MCU_UNI_CMD_PER_STA_INFO = 0x6d,
+	MCU_UNI_CMD_ALL_STA_INFO = 0x6e,
 	MCU_UNI_CMD_ASSERT_DUMP = 0x6f,
 };
 
@@ -1320,6 +1324,17 @@ enum {
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
index d442746c8d96..c792b5e0f6f8 100644
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
index 0072809ae617..ce16637b45ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -969,6 +969,7 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 				  struct ieee80211_sta *sta,
 				  struct station_info *sinfo)
 {
+	struct mt7996_phy *phy = mt7996_hw_phy(hw);
 	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
 	struct rate_info *txrate = &msta->wcid.rate;
 
@@ -1000,6 +1001,20 @@ static void mt7996_sta_statistics(struct ieee80211_hw *hw,
 
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
index 12bf4e5038b5..bf917beb9439 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -449,6 +449,54 @@ mt7996_mcu_ie_countdown(struct mt7996_dev *dev, struct sk_buff *skb)
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
@@ -493,6 +541,9 @@ mt7996_mcu_uni_rx_unsolicited_event(struct mt7996_dev *dev, struct sk_buff *skb)
 	case MCU_UNI_EVENT_RDD_REPORT:
 		mt7996_mcu_rx_radar_detected(dev, skb);
 		break;
+	case MCU_UNI_EVENT_ALL_STA_INFO:
+		mt7996_mcu_rx_all_sta_info_event(dev, skb);
+		break;
 	default:
 		break;
 	}
@@ -4013,3 +4064,20 @@ int mt7996_mcu_set_rro(struct mt7996_dev *dev, u16 tag, u8 val)
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
index e4b31228ba0d..a88f6af323da 100644
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
+		} adm_stat[0];
+
+		struct {
+			__le16 wlan_idx;
+			u8 rsv[2];
+			__le32 tx_msdu_cnt;
+			__le32 rx_msdu_cnt;
+		} msdu_cnt[0];
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

