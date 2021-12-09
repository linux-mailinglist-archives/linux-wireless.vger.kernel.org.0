Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B80A46E8C7
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:06:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237556AbhLINKX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:23 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:50954 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237554AbhLINKX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:23 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D091B823B8
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B3FAC341C3;
        Thu,  9 Dec 2021 13:06:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055207;
        bh=1Ofh9K49qVrlcKsZg+mNy1wx4jQy1jSrLoDuDON1u5E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rGsoZp7KNd8bMsYBLipkhgWDFNHlL6pNXB8kADEYejA7m7eqwqGff1dzFXcICV9dX
         lBTszp41i2djVc1UnqtGQnQZA+ZgSnFGLqo8hiFkomH661/zVxgMZwXtO3dlSyLnab
         aBBdcJQAKj77p+OrlcMQoKo9hGPYrlUVjshOsngpHgQ5PulU9X9Pjwz/MmfytVKxxt
         ZVb9el8SZ0ekBTWfyAxfHkMt0JnEk1z7bYTWFkXJVvGmr5dW+INqQaP96JAjbQ7Hma
         BqbzE9YixCaVUVe2CN43vPNpmV3RlsodvLyASL5zvavSLNM/fqLGjVyFPXaUf+Y775
         yF618vNJENEng==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 1/7] mt76: connac: introduce MCU_EXT macros
Date:   Thu,  9 Dec 2021 14:06:23 +0100
Message-Id: <205688a20d28c1839865bc206ae8b3a1e815b059.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce MCU_EXT_CMD and MCU_EXT_QUERY macros in mt76_connac module.
This is a preliminary patch to reuse mt76_connac module in mt7915
driver.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 154 ++++++++----------
 .../wireless/mediatek/mt76/mt7615/testmode.c  |   4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |   4 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  16 +-
 .../net/wireless/mediatek/mt76/mt7921/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  76 +++------
 7 files changed, 113 insertions(+), 149 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index e519fd2879ec..82d625a16a62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -73,7 +73,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 			goto out;
 	}
 
-	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
 	if (ret)
 		goto out;
 
@@ -326,7 +326,7 @@ int mt7615_set_channel(struct mt7615_phy *phy)
 			goto out;
 	}
 
-	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
+	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 25f9cbe2cd61..397a8bb67ffb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -87,7 +87,7 @@ struct mt7663_fw_buf {
 void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 			 int cmd, int *wait_seq)
 {
-	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
 	struct mt7615_uni_txd *uni_txd;
 	struct mt7615_mcu_txd *mcu_txd;
 	u8 seq, q_idx, pkt_fmt;
@@ -142,28 +142,17 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->s2d_index = MCU_S2D_H2N;
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
+	mcu_txd->cid = mcu_cmd;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	switch (cmd & ~MCU_CMD_MASK) {
-	case MCU_FW_PREFIX:
-		mcu_txd->set_query = MCU_Q_NA;
-		mcu_txd->cid = mcu_cmd;
-		break;
-	case MCU_CE_PREFIX:
-		if (cmd & MCU_QUERY_MASK)
+	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
 			mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->cid = mcu_cmd;
-		break;
-	default:
-		mcu_txd->cid = MCU_CMD_EXT_CID;
-		if (cmd & MCU_QUERY_PREFIX)
-			mcu_txd->set_query = MCU_Q_QUERY;
-		else
-			mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->ext_cid = mcu_cmd;
-		mcu_txd->ext_cid_ack = 1;
-		break;
+		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
+	} else {
+		mcu_txd->set_query = MCU_Q_NA;
 	}
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_fill_msg);
@@ -184,42 +173,32 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	switch (cmd) {
-	case MCU_CMD_PATCH_SEM_CONTROL:
+	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
-		break;
-	case MCU_EXT_CMD_GET_TEMP:
+	} else if (cmd == MCU_EXT_CMD(GET_TEMP)) {
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)skb->data);
-		break;
-	case MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX:
+	} else if (cmd == MCU_EXT_QUERY(RF_REG_ACCESS)) {
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)&skb->data[8]);
-		break;
-	case MCU_UNI_CMD_DEV_INFO_UPDATE:
-	case MCU_UNI_CMD_BSS_INFO_UPDATE:
-	case MCU_UNI_CMD_STA_REC_UPDATE:
-	case MCU_UNI_CMD_HIF_CTRL:
-	case MCU_UNI_CMD_OFFLOAD:
-	case MCU_UNI_CMD_SUSPEND: {
+	} else if (cmd == MCU_UNI_CMD_DEV_INFO_UPDATE ||
+		   cmd == MCU_UNI_CMD_BSS_INFO_UPDATE ||
+		   cmd == MCU_UNI_CMD_STA_REC_UPDATE ||
+		   cmd == MCU_UNI_CMD_HIF_CTRL ||
+		   cmd == MCU_UNI_CMD_OFFLOAD ||
+		   cmd == MCU_UNI_CMD_SUSPEND) {
 		struct mt7615_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt7615_mcu_uni_event *)skb->data;
 		ret = le32_to_cpu(event->status);
-		break;
-	}
-	case MCU_CMD_REG_READ: {
+	} else if (cmd == MCU_CMD_REG_READ) {
 		struct mt7615_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt7615_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
-		break;
-	}
-	default:
-		break;
 	}
 
 	return ret;
@@ -253,8 +232,7 @@ u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
 		.address = cpu_to_le32(reg),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_QUERY(RF_REG_ACCESS),
 				 &req, sizeof(req), true);
 }
 
@@ -270,8 +248,8 @@ int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
 		.data = cpu_to_le32(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_REG_ACCESS, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_REG_ACCESS),
+				 &req, sizeof(req), false);
 }
 
 void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
@@ -658,8 +636,8 @@ mt7615_mcu_muar_config(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (enable)
 		ether_addr_copy(req.addr, addr);
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MUAR_UPDATE, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MUAR_UPDATE),
+				 &req, sizeof(req), true);
 }
 
 static int
@@ -702,7 +680,7 @@ mt7615_mcu_add_dev(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		return mt7615_mcu_muar_config(dev, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(DEV_INFO_UPDATE),
 				 &data, sizeof(data), true);
 }
 
@@ -771,7 +749,7 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	dev_kfree_skb(skb);
 
 out:
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(BCN_OFFLOAD), &req,
 				 sizeof(req), true);
 }
 
@@ -802,8 +780,8 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 		.band_idx = band,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PM_STATE_CTRL),
+				 &req, sizeof(req), true);
 }
 
 static int
@@ -944,7 +922,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		mt7615_mcu_bss_ext_tlv(skb, mvif);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
 static int
@@ -966,8 +944,8 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, true,
 				    NULL, wtbl_hdr);
 
-	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				    true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD(WTBL_UPDATE), true);
 	if (err < 0)
 		return err;
 
@@ -979,7 +957,7 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, true);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 static int
@@ -1001,7 +979,7 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, false);
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				    MCU_EXT_CMD_STA_REC_UPDATE, true);
+				    MCU_EXT_CMD(STA_REC_UPDATE), true);
 	if (err < 0 || !enable)
 		return err;
 
@@ -1014,8 +992,8 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, false,
 				    NULL, wtbl_hdr);
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				     true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(WTBL_UPDATE), true);
 }
 
 static int
@@ -1057,7 +1035,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 						   NULL, wtbl_hdr);
 	}
 
-	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
+	cmd = enable ? MCU_EXT_CMD(WTBL_UPDATE) : MCU_EXT_CMD(STA_REC_UPDATE);
 	skb = enable ? wskb : sskb;
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
@@ -1068,7 +1046,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		return err;
 	}
 
-	cmd = enable ? MCU_EXT_CMD_STA_REC_UPDATE : MCU_EXT_CMD_WTBL_UPDATE;
+	cmd = enable ? MCU_EXT_CMD(STA_REC_UPDATE) : MCU_EXT_CMD(WTBL_UPDATE);
 	skb = enable ? sskb : wskb;
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
@@ -1090,8 +1068,8 @@ mt7615_mcu_wtbl_update_hdr_trans(struct mt7615_dev *dev,
 
 	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
 					   wtbl_hdr);
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
-				     true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD(WTBL_UPDATE), true);
 }
 
 static const struct mt7615_mcu_ops wtbl_update_ops = {
@@ -1136,7 +1114,7 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 				    sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 static int
@@ -1179,7 +1157,7 @@ mt7615_mcu_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
 {
 	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
-				    MCU_EXT_CMD_STA_REC_UPDATE, false);
+				    MCU_EXT_CMD(STA_REC_UPDATE), false);
 }
 
 static int
@@ -1191,7 +1169,7 @@ mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
 
 	return mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76,
 						    vif, &msta->wcid,
-						    MCU_EXT_CMD_STA_REC_UPDATE);
+						    MCU_EXT_CMD(STA_REC_UPDATE));
 }
 
 static const struct mt7615_mcu_ops sta_update_ops = {
@@ -1694,8 +1672,8 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST, &data,
-				 sizeof(data), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(FW_LOG_2_HOST),
+				 &data, sizeof(data), true);
 }
 
 static int mt7615_mcu_cal_cache_apply(struct mt7615_dev *dev)
@@ -1707,7 +1685,7 @@ static int mt7615_mcu_cal_cache_apply(struct mt7615_dev *dev)
 		.cache_enable = true
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_CAL_CACHE, &data,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(CAL_CACHE), &data,
 				 sizeof(data), false);
 }
 
@@ -1977,7 +1955,7 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	skb_put_data(skb, eep + offset, eep_len);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
+				     MCU_EXT_CMD(EFUSE_BUFFER_MODE), true);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -2013,8 +1991,8 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	if (params->cw_max)
 		req.cw_max = cpu_to_le16(fls(params->cw_max));
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EDCA_UPDATE),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
@@ -2072,7 +2050,7 @@ int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
 	ADD_DBDC_ENTRY(DBDC_TYPE_MGMT, 1, 1);
 
 out:
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DBDC_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(DBDC_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -2082,8 +2060,8 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 		.operation = WTBL_RESET_ALL,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(WTBL_UPDATE),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
@@ -2103,8 +2081,8 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		.val = val,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_CTRL),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
@@ -2117,7 +2095,7 @@ int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 		.min_lpn = cpu_to_le16(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -2146,7 +2124,7 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 #undef  __req_field
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -2193,7 +2171,7 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 #undef __req_field_u32
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -2225,7 +2203,7 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 		req.pattern[i].start_time = cpu_to_le32(ts);
 	}
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_PATTERN,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_PATTERN),
 				 &req, sizeof(req), false);
 }
 
@@ -2394,8 +2372,8 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev)
 		u8 rsv[3];
 	} req = {};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
-				 sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(GET_TEMP),
+				 &req, sizeof(req), true);
 }
 
 int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
@@ -2415,8 +2393,8 @@ int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
 		.value = cpu_to_le32(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL),
+				 &req, sizeof(req), false);
 }
 
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
@@ -2434,8 +2412,8 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
-				 sizeof(req), true);
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL),
+				 &req, sizeof(req), true);
 }
 
 static int mt7615_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
@@ -2574,7 +2552,7 @@ int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy)
 
 out:
 	req.center_freq = cpu_to_le16(center_freq);
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RXDCOC_CAL, &req,
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RXDCOC_CAL), &req,
 				sizeof(req), true);
 
 	if ((chandef->width == NL80211_CHAN_WIDTH_80P80 ||
@@ -2695,8 +2673,8 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 
 out:
 	req.center_freq = cpu_to_le16(center_freq);
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXDPD_CAL, &req,
-				sizeof(req), true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXDPD_CAL),
+				&req, sizeof(req), true);
 
 	if ((chandef->width == NL80211_CHAN_WIDTH_80P80 ||
 	     chandef->width == NL80211_CHAN_WIDTH_160) && !req.is_freq2) {
@@ -2724,7 +2702,7 @@ int mt7615_mcu_set_rx_hdr_trans_blacklist(struct mt7615_dev *dev)
 		.etype = cpu_to_le16(ETH_P_PAE),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_HDR_TRANS),
 				 &req, sizeof(req), false);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index f374d89f50d0..a3d1cfa729ed 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -91,7 +91,7 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_SET_TX_POWER_CTRL, false);
+				     MCU_EXT_CMD(SET_TX_POWER_CTRL), false);
 }
 
 static void
@@ -228,7 +228,7 @@ mt7615_tm_set_tx_frames(struct mt7615_phy *phy, bool en)
 	struct ieee80211_tx_info *info;
 	struct sk_buff *skb = phy->mt76->test.tx_skb;
 
-	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
 	mt7615_tm_set_tx_antenna(phy, en);
 	mt7615_tm_set_rx_enable(dev, !en);
 	if (!en || !skb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index e5e4af1b404c..d3fac18b8369 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -176,7 +176,7 @@ int mt76_connac_mcu_set_mac_enable(struct mt76_dev *dev, int band, bool enable,
 		.band = band,
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_EXT_CMD_MAC_INIT_CTRL, &req_mac,
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(MAC_INIT_CTRL), &req_mac,
 				 sizeof(req_mac), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_mac_enable);
@@ -218,7 +218,7 @@ int mt76_connac_mcu_set_rts_thresh(struct mt76_dev *dev, u32 val, u8 band)
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_EXT_CMD_PROTECT_CTRL, &req,
+	return mt76_mcu_send_msg(dev, MCU_EXT_CMD(PROTECT_CTRL), &req,
 				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_rts_thresh);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 388bfcef3b14..2c9aa82c2455 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -500,11 +500,19 @@ enum {
 #define MCU_FW_PREFIX				BIT(31)
 #define MCU_UNI_PREFIX				BIT(30)
 #define MCU_CE_PREFIX				BIT(29)
-#define MCU_QUERY_PREFIX			BIT(28)
 #define MCU_CMD_MASK				~(MCU_FW_PREFIX | MCU_UNI_PREFIX |	\
-						  MCU_CE_PREFIX | MCU_QUERY_PREFIX)
+						  MCU_CE_PREFIX)
 
-#define MCU_QUERY_MASK				BIT(16)
+#define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
+#define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
+#define __MCU_CMD_FIELD_QUERY			BIT(16)
+
+#define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
+							   MCU_CMD_##_t)
+#define MCU_EXT_CMD(_t)				(MCU_CMD(EXT_CID) | \
+						 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID,	\
+							    MCU_EXT_CMD_##_t))
+#define MCU_EXT_QUERY(_t)			(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_QUERY)
 
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
@@ -576,7 +584,7 @@ enum {
 	MCU_CMD_GET_NIC_CAPAB = MCU_CE_PREFIX | 0x8a,
 	MCU_CMD_SET_MU_EDCA_PARMS = MCU_CE_PREFIX | 0xb0,
 	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
-	MCU_CMD_REG_READ = MCU_CE_PREFIX | MCU_QUERY_MASK | 0xc0,
+	MCU_CMD_REG_READ = MCU_CE_PREFIX | __MCU_CMD_FIELD_QUERY | 0xc0,
 	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
 	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
 	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 5540b2d50679..32e48b7413a1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -233,7 +233,7 @@ int __mt7921_start(struct mt7921_phy *phy)
 	if (err)
 		return err;
 
-	err = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	err = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
 	if (err)
 		return err;
 
@@ -375,7 +375,7 @@ static int mt7921_set_channel(struct mt7921_phy *phy)
 
 	mt76_set_channel(phy->mt76);
 
-	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
+	ret = mt7921_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 8f58af4e29c6..bac9a9b424ea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -179,24 +179,20 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	switch (cmd) {
-	case MCU_CMD_PATCH_SEM_CONTROL:
+	if (cmd == MCU_CMD_PATCH_SEM_CONTROL) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
-		break;
-	case MCU_EXT_CMD_GET_TEMP:
+	} else if (cmd == MCU_EXT_CMD(GET_TEMP)) {
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
-		break;
-	case MCU_EXT_CMD_EFUSE_ACCESS:
+	} else if (cmd == MCU_EXT_CMD(EFUSE_ACCESS)) {
 		ret = mt7921_mcu_parse_eeprom(mdev, skb);
-		break;
-	case MCU_UNI_CMD_DEV_INFO_UPDATE:
-	case MCU_UNI_CMD_BSS_INFO_UPDATE:
-	case MCU_UNI_CMD_STA_REC_UPDATE:
-	case MCU_UNI_CMD_HIF_CTRL:
-	case MCU_UNI_CMD_OFFLOAD:
-	case MCU_UNI_CMD_SUSPEND: {
+	} else if (cmd == MCU_UNI_CMD_DEV_INFO_UPDATE ||
+		   cmd == MCU_UNI_CMD_BSS_INFO_UPDATE ||
+		   cmd == MCU_UNI_CMD_STA_REC_UPDATE ||
+		   cmd == MCU_UNI_CMD_HIF_CTRL ||
+		   cmd == MCU_UNI_CMD_OFFLOAD ||
+		   cmd == MCU_UNI_CMD_SUSPEND) {
 		struct mt7921_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -205,19 +201,14 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		/* skip invalid event */
 		if (mcu_cmd != event->cid)
 			ret = -EAGAIN;
-		break;
-	}
-	case MCU_CMD_REG_READ: {
+	} else if (cmd == MCU_CMD_REG_READ) {
 		struct mt7921_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt7921_mcu_reg_event *)skb->data;
 		ret = (int)le32_to_cpu(event->val);
-		break;
-	}
-	default:
+	} else {
 		skb_pull(skb, sizeof(struct mt7921_mcu_rxd));
-		break;
 	}
 
 	return ret;
@@ -228,7 +219,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 			    int cmd, int *wait_seq)
 {
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
-	int txd_len, mcu_cmd = cmd & MCU_CMD_MASK;
+	int txd_len, mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
 	struct mt7921_uni_txd *uni_txd;
 	struct mt7921_mcu_txd *mcu_txd;
 	__le32 *txd;
@@ -283,34 +274,20 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 					       MT_TX_MCU_PORT_RX_Q0));
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
+	mcu_txd->cid = mcu_cmd;
+	mcu_txd->s2d_index = MCU_S2D_H2N;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	switch (cmd & ~MCU_CMD_MASK) {
-	case MCU_FW_PREFIX:
-		mcu_txd->set_query = MCU_Q_NA;
-		mcu_txd->cid = mcu_cmd;
-		break;
-	case MCU_CE_PREFIX:
-		if (cmd & MCU_QUERY_MASK)
-			mcu_txd->set_query = MCU_Q_QUERY;
-		else
-			mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->cid = mcu_cmd;
-		break;
-	default:
-		mcu_txd->cid = MCU_CMD_EXT_CID;
-		if (cmd & MCU_QUERY_PREFIX || cmd == MCU_EXT_CMD_EFUSE_ACCESS)
+	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
 			mcu_txd->set_query = MCU_Q_SET;
-		mcu_txd->ext_cid = mcu_cmd;
-		mcu_txd->ext_cid_ack = 1;
-		break;
+		mcu_txd->ext_cid_ack = !!mcu_txd->ext_cid;
+	} else {
+		mcu_txd->set_query = MCU_Q_NA;
 	}
 
-	mcu_txd->s2d_index = MCU_S2D_H2N;
-	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
-		mcu_txd->set_query != MCU_Q_QUERY);
-
 exit:
 	if (wait_seq)
 		*wait_seq = seq;
@@ -1025,8 +1002,8 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 			e->cw_max = cpu_to_le16(10);
 	}
 
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
-				sizeof(req), true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EDCA_UPDATE),
+				&req, sizeof(req), true);
 	if (ret)
 		return ret;
 
@@ -1098,7 +1075,7 @@ int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
 
-	if (cmd == MCU_EXT_CMD_CHANNEL_SWITCH)
+	if (cmd == MCU_EXT_CMD(CHANNEL_SWITCH))
 		req.rx_streams = hweight8(req.rx_streams);
 
 	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
@@ -1121,7 +1098,7 @@ int mt7921_mcu_set_eeprom(struct mt7921_dev *dev)
 		.format = EE_FORMAT_WHOLE,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EFUSE_BUFFER_MODE),
 				 &req, sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7921_mcu_set_eeprom);
@@ -1136,8 +1113,9 @@ int mt7921_mcu_get_eeprom(struct mt7921_dev *dev, u32 offset)
 	int ret;
 	u8 *buf;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
-					sizeof(req), true, &skb);
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76,
+					MCU_EXT_QUERY(EFUSE_ACCESS),
+					&req, sizeof(req), true, &skb);
 	if (ret)
 		return ret;
 
-- 
2.31.1

