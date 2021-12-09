Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 334EB46E8CB
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:07:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237562AbhLINKe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:34 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51046 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237559AbhLINKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D544B823B9
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B27E4C341C3;
        Thu,  9 Dec 2021 13:06:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055218;
        bh=vzKMDumVUfbeuYv3wxKZNII7hB0Hp6b8zQ0qHUMf0aQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nQEHGfVOoL5893kRibcZoQZaMxGFaxpJe7+zoa75rHXqr3vgDW6Bp0s5njkshayaG
         pZj1M9ZPT2nMFmWlxKfR2txS2Oem2luz3ymjeaufGyu7000lqrp/zkFx4B2c1lgW5D
         L5fqXnyeqIxT+Hew1R0ef8q8ZTUX/gJK5UdLgI9mxuwZY57wsmjMYdABQVrWOcqMGK
         +HQxS/IIBMixPwXjiI4UMrFD735QOUxghfVz0fOrzhZZ0P5dEf1UWhXqswATFLjpUl
         WSY2WmMfnVfg1/Yq5xbYeIktq0E7V+UHFCm20jsvIgdxRThlSjk41glyvj8VcYley0
         bUkKbISoXi4pA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 5/7] mt76: connac: introduce MCU_CE_CMD macro
Date:   Thu,  9 Dec 2021 14:06:27 +0100
Message-Id: <c91bd20cb6966d68be870f21338359a37581ad36.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to MCU_EXT_CMD, introduce MCU_CE_CMD for CE commands

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 16 +++----
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 47 ++++++++++--------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 48 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 24 +++++-----
 .../wireless/mediatek/mt76/mt7921/testmode.c  |  4 +-
 5 files changed, 73 insertions(+), 66 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index fcbcfc9f5a04..58be537adb1f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -145,7 +145,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	mcu_txd->cid = mcu_cmd;
 	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
 		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
@@ -193,7 +193,7 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		skb_pull(skb, sizeof(*rxd));
 		event = (struct mt7615_mcu_uni_event *)skb->data;
 		ret = le32_to_cpu(event->status);
-	} else if (cmd == MCU_CMD_REG_READ) {
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
 		struct mt7615_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -2737,13 +2737,13 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
-				sizeof(req_hdr), false);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
 	if (err < 0 || !enable)
 		return err;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
 }
 
 int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
@@ -2762,6 +2762,6 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	phy->roc_grant = false;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_ROC),
+				 &req, sizeof(req), false);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4a693368a4bf..71896e56256e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -160,7 +160,8 @@ int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy)
 
 	memcpy(__skb_push(skb, sizeof(hdr)), &hdr, sizeof(hdr));
 
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_CMD_SET_CHAN_DOMAIN, false);
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_CE_CMD(SET_CHAN_DOMAIN),
+				     false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_channel_domain);
 
@@ -198,8 +199,8 @@ int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif)
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_SET_PS_PROFILE, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(SET_PS_PROFILE),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_vif_ps);
 
@@ -1519,7 +1520,8 @@ int mt76_connac_mcu_hw_scan(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		req->scan_func |= SCAN_FUNC_RANDOM_MAC;
 	}
 
-	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_START_HW_SCAN, false);
+	err = mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(START_HW_SCAN),
+				    false);
 	if (err < 0)
 		clear_bit(MT76_HW_SCANNING, &phy->state);
 
@@ -1547,8 +1549,8 @@ int mt76_connac_mcu_cancel_hw_scan(struct mt76_phy *phy,
 		ieee80211_scan_completed(phy->hw, &info);
 	}
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_CANCEL_HW_SCAN, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(CANCEL_HW_SCAN),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_cancel_hw_scan);
 
@@ -1634,7 +1636,8 @@ int mt76_connac_mcu_sched_scan_req(struct mt76_phy *phy,
 		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
 	}
 
-	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CMD_SCHED_SCAN_REQ, false);
+	return mt76_mcu_skb_send_msg(mdev, skb, MCU_CE_CMD(SCHED_SCAN_REQ),
+				     false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_req);
 
@@ -1654,8 +1657,8 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 	else
 		clear_bit(MT76_HW_SCHED_SCANNING, &phy->state);
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SCHED_SCAN_ENABLE, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SCHED_SCAN_ENABLE),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sched_scan_enable);
 
@@ -1667,8 +1670,8 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev)
 
 	memcpy(req.data, "assert", 7);
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
-				 false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_chip_config);
 
@@ -1680,8 +1683,8 @@ int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable)
 
 	snprintf(req.data, sizeof(req.data), "KeepFullPwr %d", !enable);
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_CHIP_CONFIG, &req, sizeof(req),
-				 false);
+	return mt76_mcu_send_msg(dev, MCU_CE_CMD(CHIP_CONFIG),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_deep_sleep);
 
@@ -1783,8 +1786,8 @@ int mt76_connac_mcu_get_nic_capability(struct mt76_phy *phy)
 	struct sk_buff *skb;
 	int ret, i;
 
-	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CMD_GET_NIC_CAPAB, NULL,
-					0, true, &skb);
+	ret = mt76_mcu_send_and_get_msg(phy->dev, MCU_CE_CMD(GET_NIC_CAPAB),
+					NULL, 0, true, &skb);
 	if (ret)
 		return ret;
 
@@ -2042,7 +2045,8 @@ mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
 		memcpy(skb->data, &tx_power_tlv, sizeof(tx_power_tlv));
 
 		err = mt76_mcu_skb_send_msg(dev, skb,
-					    MCU_CMD_SET_RATE_TX_POWER, false);
+					    MCU_CE_CMD(SET_RATE_TX_POWER),
+					    false);
 		if (err < 0)
 			return err;
 	}
@@ -2134,8 +2138,8 @@ int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 		.bss_idx = mvif->idx,
 	};
 
-	return mt76_mcu_send_msg(phy->dev, MCU_CMD_SET_P2P_OPPPS, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(phy->dev, MCU_CE_CMD(SET_P2P_OPPPS),
+				 &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_p2p_oppps);
 
@@ -2461,8 +2465,8 @@ u32 mt76_connac_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
 		.addr = cpu_to_le32(offset),
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_CE_QUERY(REG_READ), &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_rr);
 
@@ -2476,7 +2480,8 @@ void mt76_connac_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
 		.val = cpu_to_le32(val),
 	};
 
-	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
+	mt76_mcu_send_msg(dev, MCU_CE_CMD(REG_WRITE), &req,
+			  sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_reg_wr);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 655dfd955310..039e228e0435 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -497,13 +497,11 @@ enum {
 #define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
 						 MCU_CMD_QUERY)
 
-#define MCU_CE_PREFIX				BIT(29)
-#define MCU_CMD_MASK				~(MCU_CE_PREFIX)
-
 #define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
 #define __MCU_CMD_FIELD_QUERY			BIT(16)
 #define __MCU_CMD_FIELD_UNI			BIT(17)
+#define __MCU_CMD_FIELD_CE			BIT(18)
 
 #define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CMD_##_t)
@@ -514,6 +512,10 @@ enum {
 #define MCU_UNI_CMD(_t)				(__MCU_CMD_FIELD_UNI |			\
 						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							    MCU_UNI_CMD_##_t))
+#define MCU_CE_CMD(_t)				(__MCU_CMD_FIELD_CE |			\
+						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
+							   MCU_CE_CMD_##_t))
+#define MCU_CE_QUERY(_t)			(MCU_CE_CMD(_t) | __MCU_CMD_FIELD_QUERY)
 
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
@@ -590,26 +592,26 @@ enum {
 
 /* offload mcu commands */
 enum {
-	MCU_CMD_TEST_CTRL = MCU_CE_PREFIX | 0x01,
-	MCU_CMD_START_HW_SCAN = MCU_CE_PREFIX | 0x03,
-	MCU_CMD_SET_PS_PROFILE = MCU_CE_PREFIX | 0x05,
-	MCU_CMD_SET_CHAN_DOMAIN = MCU_CE_PREFIX | 0x0f,
-	MCU_CMD_SET_BSS_CONNECTED = MCU_CE_PREFIX | 0x16,
-	MCU_CMD_SET_BSS_ABORT = MCU_CE_PREFIX | 0x17,
-	MCU_CMD_CANCEL_HW_SCAN = MCU_CE_PREFIX | 0x1b,
-	MCU_CMD_SET_ROC = MCU_CE_PREFIX | 0x1d,
-	MCU_CMD_SET_P2P_OPPPS = MCU_CE_PREFIX | 0x33,
-	MCU_CMD_SET_RATE_TX_POWER = MCU_CE_PREFIX | 0x5d,
-	MCU_CMD_SCHED_SCAN_ENABLE = MCU_CE_PREFIX | 0x61,
-	MCU_CMD_SCHED_SCAN_REQ = MCU_CE_PREFIX | 0x62,
-	MCU_CMD_GET_NIC_CAPAB = MCU_CE_PREFIX | 0x8a,
-	MCU_CMD_SET_MU_EDCA_PARMS = MCU_CE_PREFIX | 0xb0,
-	MCU_CMD_REG_WRITE = MCU_CE_PREFIX | 0xc0,
-	MCU_CMD_REG_READ = MCU_CE_PREFIX | __MCU_CMD_FIELD_QUERY | 0xc0,
-	MCU_CMD_CHIP_CONFIG = MCU_CE_PREFIX | 0xca,
-	MCU_CMD_FWLOG_2_HOST = MCU_CE_PREFIX | 0xc5,
-	MCU_CMD_GET_WTBL = MCU_CE_PREFIX | 0xcd,
-	MCU_CMD_GET_TXPWR = MCU_CE_PREFIX | 0xd0,
+	MCU_CE_CMD_TEST_CTRL = 0x01,
+	MCU_CE_CMD_START_HW_SCAN = 0x03,
+	MCU_CE_CMD_SET_PS_PROFILE = 0x05,
+	MCU_CE_CMD_SET_CHAN_DOMAIN = 0x0f,
+	MCU_CE_CMD_SET_BSS_CONNECTED = 0x16,
+	MCU_CE_CMD_SET_BSS_ABORT = 0x17,
+	MCU_CE_CMD_CANCEL_HW_SCAN = 0x1b,
+	MCU_CE_CMD_SET_ROC = 0x1d,
+	MCU_CE_CMD_SET_P2P_OPPPS = 0x33,
+	MCU_CE_CMD_SET_RATE_TX_POWER = 0x5d,
+	MCU_CE_CMD_SCHED_SCAN_ENABLE = 0x61,
+	MCU_CE_CMD_SCHED_SCAN_REQ = 0x62,
+	MCU_CE_CMD_GET_NIC_CAPAB = 0x8a,
+	MCU_CE_CMD_SET_MU_EDCA_PARMS = 0xb0,
+	MCU_CE_CMD_REG_WRITE = 0xc0,
+	MCU_CE_CMD_REG_READ = 0xc0,
+	MCU_CE_CMD_CHIP_CONFIG = 0xca,
+	MCU_CE_CMD_FWLOG_2_HOST = 0xc5,
+	MCU_CE_CMD_GET_WTBL = 0xcd,
+	MCU_CE_CMD_GET_TXPWR = 0xd0,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index e2fcd175f7d4..da77e4697c9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -163,8 +163,8 @@ mt7921_mcu_parse_eeprom(struct mt76_dev *dev, struct sk_buff *skb)
 int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 			      struct sk_buff *skb, int seq)
 {
+	int mcu_cmd = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
 	struct mt7921_mcu_rxd *rxd;
-	int mcu_cmd = cmd & MCU_CMD_MASK;
 	int ret = 0;
 
 	if (!skb) {
@@ -201,7 +201,7 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		/* skip invalid event */
 		if (mcu_cmd != event->cid)
 			ret = -EAGAIN;
-	} else if (cmd == MCU_CMD_REG_READ) {
+	} else if (cmd == MCU_CE_QUERY(REG_READ)) {
 		struct mt7921_mcu_reg_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -274,7 +274,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	mcu_txd->s2d_index = MCU_S2D_H2N;
 	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
 
-	if (mcu_txd->ext_cid || (cmd & MCU_CE_PREFIX)) {
+	if (mcu_txd->ext_cid || (cmd & __MCU_CMD_FIELD_CE)) {
 		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
@@ -897,8 +897,8 @@ int mt7921_mcu_fw_log_2_host(struct mt7921_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FWLOG_2_HOST, &data,
-				 sizeof(data), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(FWLOG_2_HOST),
+				 &data, sizeof(data), false);
 }
 
 int mt7921_run_firmware(struct mt7921_dev *dev)
@@ -1023,8 +1023,8 @@ int mt7921_mcu_set_tx(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 		e->timer = q->mu_edca_timer;
 	}
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_MU_EDCA_PARMS, &req_mu,
-				 sizeof(req_mu), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_MU_EDCA_PARMS),
+				 &req_mu, sizeof(req_mu), false);
 }
 
 int mt7921_mcu_set_chan_info(struct mt7921_phy *phy, int cmd)
@@ -1228,13 +1228,13 @@ mt7921_mcu_set_bss_pm(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
-	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
-				sizeof(req_hdr), false);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_ABORT),
+				&req_hdr, sizeof(req_hdr), false);
 	if (err < 0 || !enable)
 		return err;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
-				 sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(SET_BSS_CONNECTED),
+				 &req, sizeof(req), false);
 }
 
 int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
@@ -1344,7 +1344,7 @@ int mt7921_get_txpwr_info(struct mt7921_dev *dev, struct mt7921_txpwr *txpwr)
 	struct sk_buff *skb;
 	int ret;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_GET_TXPWR,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(GET_TXPWR),
 					&req, sizeof(req), true, &skb);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 8bd43879dd6f..bdec8684ce94 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -66,7 +66,7 @@ mt7921_tm_set(struct mt7921_dev *dev, struct mt7921_tm_cmd *req)
 	if (!mt76_testmode_enabled(phy))
 		goto out;
 
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TEST_CTRL, &cmd,
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL), &cmd,
 				sizeof(cmd), false);
 	if (ret)
 		goto out;
@@ -95,7 +95,7 @@ mt7921_tm_query(struct mt7921_dev *dev, struct mt7921_tm_cmd *req,
 	struct sk_buff *skb;
 	int ret;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CMD_TEST_CTRL,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_CE_CMD(TEST_CTRL),
 					&cmd, sizeof(cmd), true, &skb);
 	if (ret)
 		goto out;
-- 
2.31.1

