Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41C5979EB6F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Sep 2023 16:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbjIMOoj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 13 Sep 2023 10:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241455AbjIMOof (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 13 Sep 2023 10:44:35 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DD391
        for <linux-wireless@vger.kernel.org>; Wed, 13 Sep 2023 07:44:30 -0700 (PDT)
X-UUID: 07162c62524411ee8051498923ad61e6-20230913
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=RPFKVw2WS6o8/mbKJj2N9/jDGUwGomR2ZOT5TMsQNYQ=;
        b=r4LDoai53JThu7xB9b3j+O+VSlSjHzkYtGN8dgxFy1XuvRYUqP4apOXj/i6ZJXjlEfMS1Q1eUPpgfZl7QPCdvNsEEZ98X/RLPx1oK30COH7xGHbHHUhlVJAyS9aP04F/XUNyKZYz+bvG/pB26JfXHhOERut39RRNAx8HTBa51vI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.31,REQID:d91b6abb-ab55-4a33-bd56-99734f985ca9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:0ad78a4,CLOUDID:4122e613-4929-4845-9571-38c601e9c3c9,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 07162c62524411ee8051498923ad61e6-20230913
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 198383018; Wed, 13 Sep 2023 22:44:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 13 Sep 2023 22:44:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 13 Sep 2023 22:44:21 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2 03/17] wifi: mt76: mt7925: add mt7925.h
Date:   Wed, 13 Sep 2023 22:43:31 +0800
Message-ID: <3c8254d2e724f901ee0e3f3fd66d3672b8a1c42f.1694595134.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1694595134.git.deren.wu@mediatek.com>
References: <cover.1694595134.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Patches split into one patch per file for easier review, but the final
commit will be one big patch. See the cover letter for more info.)

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7925/mt7925.h    | 325 ++++++++++++++++++
 1 file changed, 325 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
new file mode 100644
index 000000000000..1133d95383ca
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -0,0 +1,325 @@
+/* SPDX-License-Identifier: ISC */
+/* Copyright (C) 2023 MediaTek Inc. */
+
+#ifndef __MT7925_H
+#define __MT7925_H
+
+#include "../mt792x.h"
+#include "regs.h"
+
+#define MT7925_BEACON_RATES_TBL		25
+
+#define MT7925_TX_RING_SIZE		2048
+#define MT7925_TX_MCU_RING_SIZE		256
+#define MT7925_TX_FWDL_RING_SIZE	128
+
+#define MT7925_RX_RING_SIZE		1536
+#define MT7925_RX_MCU_RING_SIZE		512
+
+#define MT7925_EEPROM_SIZE		3584
+#define MT7925_TOKEN_SIZE		8192
+
+#define MT7925_EEPROM_BLOCK_SIZE	16
+
+#define MT7925_SKU_RATE_NUM		161
+#define MT7925_SKU_MAX_DELTA_IDX	MT7925_SKU_RATE_NUM
+#define MT7925_SKU_TABLE_SIZE		(MT7925_SKU_RATE_NUM + 1)
+
+#define MT7925_SDIO_HDR_TX_BYTES	GENMASK(15, 0)
+#define MT7925_SDIO_HDR_PKT_TYPE	GENMASK(17, 16)
+
+#define MCU_UNI_EVENT_ROC  0x27
+
+enum {
+	UNI_ROC_ACQUIRE,
+	UNI_ROC_ABORT,
+	UNI_ROC_NUM
+};
+
+enum mt7925_roc_req {
+	MT7925_ROC_REQ_JOIN,
+	MT7925_ROC_REQ_ROC,
+	MT7925_ROC_REQ_NUM
+};
+
+enum {
+	UNI_EVENT_ROC_GRANT = 0,
+	UNI_EVENT_ROC_TAG_NUM
+};
+
+struct mt7925_roc_grant_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 bss_idx;
+	u8 tokenid;
+	u8 status;
+	u8 primarychannel;
+	u8 rfsco;
+	u8 rfband;
+	u8 channelwidth;
+	u8 centerfreqseg1;
+	u8 centerfreqseg2;
+	u8 reqtype;
+	u8 dbdcband;
+	u8 rsv[1];
+	__le32 max_interval;
+} __packed;
+
+struct mt7925_beacon_loss_tlv {
+	__le16 tag;
+	__le16 len;
+	u8 reason;
+	u8 nr_btolink;
+	u8 pad[2];
+} __packed;
+
+struct mt7925_uni_beacon_loss_event {
+	struct {
+		u8 bss_idx;
+		u8 pad[3];
+	} __packed hdr;
+	struct mt7925_beacon_loss_tlv beacon_loss;
+} __packed;
+
+#define to_rssi(field, rxv)		((FIELD_GET(field, rxv) - 220) / 2)
+#define to_rcpi(rssi)			(2 * (rssi) + 220)
+
+enum mt7925_txq_id {
+	MT7925_TXQ_BAND0,
+	MT7925_TXQ_BAND1,
+	MT7925_TXQ_MCU_WM = 15,
+	MT7925_TXQ_FWDL,
+};
+
+enum mt7925_rxq_id {
+	MT7925_RXQ_BAND0 = 2,
+	MT7925_RXQ_BAND1,
+	MT7925_RXQ_MCU_WM = 0,
+	MT7925_RXQ_MCU_WM2, /* for tx done */
+};
+
+enum {
+	MODE_OPEN = 0,
+	MODE_SHARED = 1,
+	MODE_WPA = 3,
+	MODE_WPA_PSK = 4,
+	MODE_WPA_NONE = 5,
+	MODE_WPA2 = 6,
+	MODE_WPA2_PSK = 7,
+	MODE_WPA3_SAE = 11,
+};
+
+enum {
+	MT7925_CLC_POWER,
+	MT7925_CLC_CHAN,
+	MT7925_CLC_MAX_NUM,
+};
+
+struct mt7925_clc_rule {
+	u8 alpha2[2];
+	u8 type[2];
+	u8 seg_idx;
+	u8 rsv[3];
+} __packed;
+
+struct mt7925_clc_segment {
+	u8 idx;
+	u8 rsv1[3];
+	u32 offset;
+	u32 len;
+	u8 rsv2[4];
+} __packed;
+
+struct mt7925_clc {
+	__le32 len;
+	u8 idx;
+	u8 ver;
+	u8 nr_country;
+	u8 type;
+	u8 nr_seg;
+	u8 rsv[7];
+	u8 data[];
+} __packed;
+
+enum mt7925_eeprom_field {
+	MT_EE_CHIP_ID =		0x000,
+	MT_EE_VERSION =		0x002,
+	MT_EE_MAC_ADDR =	0x004,
+	__MT_EE_MAX =		0x9ff
+};
+
+enum {
+	TXPWR_USER,
+	TXPWR_EEPROM,
+	TXPWR_MAC,
+	TXPWR_MAX_NUM,
+};
+
+struct mt7925_txpwr {
+	s8 cck[4][2];
+	s8 ofdm[8][2];
+	s8 ht20[8][2];
+	s8 ht40[9][2];
+	s8 vht20[12][2];
+	s8 vht40[12][2];
+	s8 vht80[12][2];
+	s8 vht160[12][2];
+	s8 he26[12][2];
+	s8 he52[12][2];
+	s8 he106[12][2];
+	s8 he242[12][2];
+	s8 he484[12][2];
+	s8 he996[12][2];
+	s8 he996x2[12][2];
+	s8 eht26[16][2];
+	s8 eht52[16][2];
+	s8 eht106[16][2];
+	s8 eht242[16][2];
+	s8 eht484[16][2];
+	s8 eht996[16][2];
+	s8 eht996x2[16][2];
+	s8 eht996x4[16][2];
+	s8 eht26_52[16][2];
+	s8 eht26_106[16][2];
+	s8 eht484_242[16][2];
+	s8 eht996_484[16][2];
+	s8 eht996_484_242[16][2];
+	s8 eht996x2_484[16][2];
+	s8 eht996x3[16][2];
+	s8 eht996x3_484[16][2];
+};
+
+extern const struct ieee80211_ops mt7925_ops;
+
+int __mt7925_start(struct mt792x_phy *phy);
+int mt7925_register_device(struct mt792x_dev *dev);
+void mt7925_unregister_device(struct mt792x_dev *dev);
+int mt7925_run_firmware(struct mt792x_dev *dev);
+int mt7925_mcu_set_bss_pm(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			  bool enable);
+int mt7925_mcu_sta_update(struct mt792x_dev *dev, struct ieee80211_sta *sta,
+			  struct ieee80211_vif *vif, bool enable,
+			  enum mt76_sta_info_state state);
+int mt7925_mcu_set_chan_info(struct mt792x_phy *phy, u16 tag);
+int mt7925_mcu_set_tx(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+int mt7925_mcu_set_eeprom(struct mt792x_dev *dev);
+int mt7925_mcu_get_rx_rate(struct mt792x_phy *phy, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta, struct rate_info *rate);
+int mt7925_mcu_fw_log_2_host(struct mt792x_dev *dev, u8 ctrl);
+void mt7925_mcu_rx_event(struct mt792x_dev *dev, struct sk_buff *skb);
+int mt7925_mcu_chip_config(struct mt792x_dev *dev, const char *cmd);
+int mt7925_mcu_set_rxfilter(struct mt792x_dev *dev, u32 fif,
+			    u8 bit_op, u32 bit_map);
+static inline void
+mt7925_skb_add_usb_sdio_hdr(struct mt792x_dev *dev, struct sk_buff *skb,
+			    int type)
+{
+	u32 hdr, len;
+
+	len = mt76_is_usb(&dev->mt76) ? skb->len : skb->len + sizeof(hdr);
+	hdr = FIELD_PREP(MT7925_SDIO_HDR_TX_BYTES, len) |
+	      FIELD_PREP(MT7925_SDIO_HDR_PKT_TYPE, type);
+
+	put_unaligned_le32(hdr, skb_push(skb, sizeof(hdr)));
+}
+
+void mt7925_stop(struct ieee80211_hw *hw);
+int mt7925_mac_init(struct mt792x_dev *dev);
+int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta);
+bool mt7925_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
+void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			  struct ieee80211_sta *sta);
+void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
+void mt7925_mac_reset_work(struct work_struct *work);
+int mt7925e_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+			   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+			   struct ieee80211_sta *sta,
+			   struct mt76_tx_info *tx_info);
+
+void mt7925_tx_token_put(struct mt792x_dev *dev);
+bool mt7925_rx_check(struct mt76_dev *mdev, void *data, int len);
+void mt7925_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
+			 struct sk_buff *skb, u32 *info);
+void mt7925_stats_work(struct work_struct *work);
+void mt7925_set_stream_he_eht_caps(struct mt792x_phy *phy);
+int mt7925_init_debugfs(struct mt792x_dev *dev);
+
+int mt7925_mcu_set_beacon_filter(struct mt792x_dev *dev,
+				 struct ieee80211_vif *vif,
+				 bool enable);
+int mt7925_mcu_uni_tx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+int mt7925_mcu_uni_rx_ba(struct mt792x_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable);
+void mt7925_scan_work(struct work_struct *work);
+void mt7925_roc_work(struct work_struct *work);
+int mt7925_mcu_uni_bss_ps(struct mt792x_dev *dev, struct ieee80211_vif *vif);
+void mt7925_coredump_work(struct work_struct *work);
+int mt7925_get_txpwr_info(struct mt792x_dev *dev, u8 band_idx,
+			  struct mt7925_txpwr *txpwr);
+void mt7925_mac_set_fixed_rate_table(struct mt792x_dev *dev,
+				     u8 tbl_idx, u16 rate_idx);
+void mt7925_mac_write_txwi(struct mt76_dev *dev, __le32 *txwi,
+			   struct sk_buff *skb, struct mt76_wcid *wcid,
+			   struct ieee80211_key_conf *key, int pid,
+			   enum mt76_txq_id qid, u32 changed);
+void mt7925_txwi_free(struct mt792x_dev *dev, struct mt76_txwi_cache *t,
+		      struct ieee80211_sta *sta, bool clear_status,
+		      struct list_head *free_list);
+int mt7925_mcu_parse_response(struct mt76_dev *mdev, int cmd,
+			      struct sk_buff *skb, int seq);
+
+int mt7925e_mac_reset(struct mt792x_dev *dev);
+int mt7925e_mcu_init(struct mt792x_dev *dev);
+void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data);
+void mt7925_set_runtime_pm(struct mt792x_dev *dev);
+void mt7925_mcu_set_suspend_iter(void *priv, u8 *mac,
+				 struct ieee80211_vif *vif);
+void mt7925_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
+					struct ieee80211_vif *vif);
+void mt7925_set_ipv6_ns_work(struct work_struct *work);
+
+int mt7925_mcu_set_sniffer(struct mt792x_dev *dev, struct ieee80211_vif *vif,
+			   bool enable);
+int mt7925_mcu_config_sniffer(struct mt792x_vif *vif,
+			      struct ieee80211_chanctx_conf *ctx);
+
+int mt7925_usb_sdio_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
+				   enum mt76_txq_id qid, struct mt76_wcid *wcid,
+				   struct ieee80211_sta *sta,
+				   struct mt76_tx_info *tx_info);
+void mt7925_usb_sdio_tx_complete_skb(struct mt76_dev *mdev,
+				     struct mt76_queue_entry *e);
+bool mt7925_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update);
+
+int mt7925_mcu_uni_add_beacon_offload(struct mt792x_dev *dev,
+				      struct ieee80211_hw *hw,
+				      struct ieee80211_vif *vif,
+				      bool enable);
+int mt7925_set_tx_sar_pwr(struct ieee80211_hw *hw,
+			  const struct cfg80211_sar_specs *sar);
+
+int mt7925_mcu_regval(struct mt792x_dev *dev, u32 regidx, u32 *val, bool set);
+int mt7925_mcu_set_clc(struct mt792x_dev *dev, u8 *alpha2,
+		       enum environment_cap env_cap);
+int mt7925_mcu_set_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+		       struct ieee80211_channel *chan, int duration,
+		       enum mt7925_roc_req type, u8 token_id);
+int mt7925_mcu_abort_roc(struct mt792x_phy *phy, struct mt792x_vif *vif,
+			 u8 token_id);
+int mt7925_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
+			    int cmd, int *wait_seq);
+int mt7925_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
+		       struct mt76_connac_sta_key_conf *sta_key_conf,
+		       struct ieee80211_key_conf *key, int mcu_cmd,
+		       struct mt76_wcid *wcid, enum set_key_cmd cmd);
+int mt7925_mcu_set_rts_thresh(struct mt792x_phy *phy, u32 val);
+int mt7925_mcu_wtbl_update_hdr_trans(struct mt792x_dev *dev,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta);
+
+#endif
-- 
2.18.0

