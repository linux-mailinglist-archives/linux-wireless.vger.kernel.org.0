Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC2D2F600D
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jan 2021 12:31:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbhANLam (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jan 2021 06:30:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbhANLal (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:41 -0500
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3750C06179B
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jan 2021 03:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=Ml8ksTvydEU2jg63o0eFLIflp+jJ8R62foVuLK+DI38=; b=UnRIiw/7ThudxN4XoClHHvPO7r
        yiK41LuxQ7ApAdIIT6ySUydghAGEog4y4bLlY8eCLKfG1SpI4c5yEEekc0t7hWoTITqOMqWWq8sDy
        633x490q79ch5t9gqhr1n/T0h0HiTLRGLCKuAsoPVyLiJNOYGLlns8e5YreYkC7dKBZU=;
Received: from p54ae91f2.dip0.t-ipconnect.de ([84.174.145.242] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1l00oh-0001PU-6A
        for linux-wireless@vger.kernel.org; Thu, 14 Jan 2021 12:29:27 +0100
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 4/7] mt76: mt7915: rework mcu API
Date:   Thu, 14 Jan 2021 12:29:22 +0100
Message-Id: <20210114112925.87646-4-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20210114112925.87646-1-nbd@nbd.name>
References: <20210114112925.87646-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for passing flags for selecting the MCU target and query type
instead of trying to detect it based on the command id

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 128 ++++++++----------
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  15 ++
 .../wireless/mediatek/mt76/mt7915/testmode.c  |  20 +--
 4 files changed, 87 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 05dd75961d95..8b8d0d2d532b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -47,7 +47,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	}
 
 	mt7915_mcu_set_sku_en(phy, true);
-	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -283,7 +283,7 @@ int mt7915_set_channel(struct mt7915_phy *phy)
 	mt7915_init_dfs_state(phy);
 	mt76_set_channel(phy->mt76);
 
-	ret = mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_CHANNEL_SWITCH);
+	ret = mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(CHANNEL_SWITCH));
 	if (ret)
 		goto out;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index ad42e9b48d35..59a5ef2a0139 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -229,18 +229,14 @@ mt7915_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	if (seq != rxd->seq)
 		return -EAGAIN;
 
-	switch (cmd) {
-	case -MCU_CMD_PATCH_SEM_CONTROL:
+	if (cmd == MCU_CMD(PATCH_SEM_CONTROL)) {
 		skb_pull(skb, sizeof(*rxd) - 4);
 		ret = *skb->data;
-		break;
-	case MCU_EXT_CMD_THERMAL_CTRL:
+	} else if (cmd == MCU_EXT_CMD(THERMAL_CTRL)) {
 		skb_pull(skb, sizeof(*rxd) + 4);
 		ret = le32_to_cpu(*(__le32 *)skb->data);
-		break;
-	default:
+	} else {
 		skb_pull(skb, sizeof(struct mt7915_mcu_rxd));
-		break;
 	}
 
 	return ret;
@@ -264,7 +260,7 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (!seq)
 		seq = ++dev->mt76.mcu.msg_seq & 0xf;
 
-	if (cmd == -MCU_CMD_FW_SCATTER) {
+	if (cmd == MCU_CMD(FW_SCATTER)) {
 		txq = MT_MCUQ_FWDL;
 		goto exit;
 	}
@@ -292,27 +288,23 @@ mt7915_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	mcu_txd->pkt_type = MCU_PKT_ID;
 	mcu_txd->seq = seq;
 
-	if (cmd < 0) {
-		mcu_txd->set_query = MCU_Q_NA;
-		mcu_txd->cid = -cmd;
-	} else {
-		mcu_txd->cid = MCU_CMD_EXT_CID;
-		mcu_txd->ext_cid = cmd;
+	mcu_txd->cid = FIELD_GET(__MCU_CMD_FIELD_ID, cmd);
+	mcu_txd->set_query = MCU_Q_NA;
+	mcu_txd->ext_cid = FIELD_GET(__MCU_CMD_FIELD_EXT_ID, cmd);
+	if (mcu_txd->ext_cid) {
 		mcu_txd->ext_cid_ack = 1;
 
 		/* do not use Q_SET for efuse */
-		if (cmd == MCU_EXT_CMD_EFUSE_ACCESS)
+		if (cmd & __MCU_CMD_FIELD_QUERY)
 			mcu_txd->set_query = MCU_Q_QUERY;
 		else
 			mcu_txd->set_query = MCU_Q_SET;
 	}
 
-	if (cmd == MCU_EXT_CMD_MWDS_SUPPORT)
+	if (cmd & __MCU_CMD_FIELD_WA)
 		mcu_txd->s2d_index = MCU_S2D_H2C;
 	else
 		mcu_txd->s2d_index = MCU_S2D_H2N;
-	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
-		mcu_txd->set_query != MCU_Q_QUERY);
 
 exit:
 	if (wait_seq)
@@ -971,7 +963,7 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	if (enable)
 		ether_addr_copy(req.addr, addr);
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MUAR_UPDATE, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MUAR_UPDATE), &req,
 				 sizeof(req), true);
 }
 
@@ -1013,7 +1005,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 	}
 out:
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
-				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
 /** starec & wtbl **/
@@ -1103,7 +1095,7 @@ int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return ret;
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 static void
@@ -1183,7 +1175,7 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	mt7915_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
 
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				    MCU_EXT_CMD_STA_REC_UPDATE, true);
+				    MCU_EXT_CMD(STA_REC_UPDATE), true);
 	if (ret)
 		return ret;
 
@@ -1195,7 +1187,7 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 	mt7915_mcu_sta_ba_tlv(skb, params, enable, tx);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
@@ -1531,7 +1523,7 @@ mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	mt7915_mcu_sta_muru_tlv(skb, sta);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 static void
@@ -1698,7 +1690,7 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
 	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
 
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD(WTBL_UPDATE),
 				     true);
 }
 
@@ -1723,7 +1715,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 static void
@@ -2011,7 +2003,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable, ebf);
 
 		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					  MCU_EXT_CMD_STA_REC_UPDATE, true);
+					  MCU_EXT_CMD(STA_REC_UPDATE), true);
 		if (r)
 			return r;
 	}
@@ -2027,7 +2019,7 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		mt7915_mcu_sta_bfee_tlv(skb, sta, phy);
 
 		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					  MCU_EXT_CMD_STA_REC_UPDATE, true);
+					  MCU_EXT_CMD(STA_REC_UPDATE), true);
 		if (r)
 			return r;
 	}
@@ -2195,7 +2187,7 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -2253,7 +2245,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
@@ -2299,7 +2291,7 @@ int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD_STA_REC_UPDATE, true);
+				     MCU_EXT_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
@@ -2341,7 +2333,7 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 		return mt7915_mcu_muar_config(phy, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(DEV_INFO_UPDATE),
 				 &data, sizeof(data), true);
 }
 
@@ -2434,7 +2426,7 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	dev_kfree_skb(skb);
 
 	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
-				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
 }
 
 static int mt7915_mcu_start_firmware(struct mt7915_dev *dev, u32 addr,
@@ -2448,7 +2440,7 @@ static int mt7915_mcu_start_firmware(struct mt7915_dev *dev, u32 addr,
 		.addr = cpu_to_le32(addr),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(FW_START_REQ), &req,
 				 sizeof(req), true);
 }
 
@@ -2461,7 +2453,7 @@ static int mt7915_mcu_restart(struct mt76_dev *dev)
 		.power_mode = 1,
 	};
 
-	return mt76_mcu_send_msg(dev, -MCU_CMD_NIC_POWER_CTRL, &req,
+	return mt76_mcu_send_msg(dev, MCU_CMD(NIC_POWER_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -2473,7 +2465,7 @@ static int mt7915_mcu_patch_sem_ctrl(struct mt7915_dev *dev, bool get)
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_SEM_CONTROL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(PATCH_SEM_CONTROL), &req,
 				 sizeof(req), true);
 }
 
@@ -2486,7 +2478,7 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
 		.check_crc = 0,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_FINISH_REQ, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD(PATCH_FINISH_REQ), &req,
 				 sizeof(req), true);
 }
 
@@ -2519,9 +2511,9 @@ static int mt7915_mcu_init_download(struct mt7915_dev *dev, u32 addr,
 	int attr;
 
 	if (req.addr == cpu_to_le32(MCU_PATCH_ADDRESS))
-		attr = -MCU_CMD_PATCH_START_REQ;
+		attr = MCU_CMD(PATCH_START_REQ);
 	else
-		attr = -MCU_CMD_TARGET_ADDRESS_LEN_REQ;
+		attr = MCU_CMD(TARGET_ADDRESS_LEN_REQ);
 
 	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
 }
@@ -2582,7 +2574,7 @@ static int mt7915_load_patch(struct mt7915_dev *dev)
 			goto out;
 		}
 
-		ret = mt76_mcu_send_firmware(&dev->mt76, -MCU_CMD_FW_SCATTER,
+		ret = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					     dl, len);
 		if (ret) {
 			dev_err(dev->mt76.dev, "Failed to send patch\n");
@@ -2651,7 +2643,7 @@ mt7915_mcu_send_ram_firmware(struct mt7915_dev *dev,
 			return err;
 		}
 
-		err = mt76_mcu_send_firmware(&dev->mt76, -MCU_CMD_FW_SCATTER,
+		err = mt76_mcu_send_firmware(&dev->mt76, MCU_CMD(FW_SCATTER),
 					     data + offset, len);
 		if (err) {
 			dev_err(dev->mt76.dev, "Failed to send firmware.\n");
@@ -2781,7 +2773,7 @@ int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST, &data,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(FW_LOG_2_HOST), &data,
 				 sizeof(data), true);
 }
 
@@ -2799,7 +2791,7 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 		.level = level,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_DBG_CTRL, &data,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(FW_DBG_CTRL), &data,
 				 sizeof(data), false);
 }
 
@@ -2812,7 +2804,7 @@ static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 		.enable = enabled
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MWDS_SUPPORT, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_WA_EXT_CMD(MWDS_SUPPORT), &req,
 				 sizeof(req), false);
 }
 
@@ -2885,12 +2877,12 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band,
 	};
 	int ret;
 
-	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RX_HDR_TRANS),
 				&req_trans, sizeof(req_trans), false);
 	if (ret)
 		return ret;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(MAC_INIT_CTRL),
 				 &req_mac, sizeof(req_mac), true);
 }
 
@@ -2906,7 +2898,7 @@ int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable)
 		.enable = enable + 1,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SCS_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SCS_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -2926,7 +2918,7 @@ int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val)
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PROTECT_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -2937,7 +2929,7 @@ int mt7915_mcu_update_edca(struct mt7915_dev *dev, void *param)
 	size_t len = sizeof(*req) -
 		     (IEEE80211_NUM_ACS - num) * sizeof(struct edca);
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EDCA_UPDATE), req,
 				 len, true);
 }
 
@@ -3002,7 +2994,7 @@ int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter)
 		.band_idx = band,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(PM_STATE_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -3023,7 +3015,7 @@ int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
 		.val = val,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -3038,7 +3030,7 @@ int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val)
 		.min_lpn = cpu_to_le16(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -3069,7 +3061,7 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 #undef __req_field
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -3121,7 +3113,7 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 #undef __req_field_u32
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_RDD_TH), &req,
 				 sizeof(req), true);
 }
 
@@ -3181,7 +3173,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 	else
 		req.switch_reason = CH_SWITCH_NORMAL;
 
-	if (cmd == MCU_EXT_CMD_CHANNEL_SWITCH)
+	if (cmd == MCU_EXT_CMD(CHANNEL_SWITCH))
 		req.rx_streams = hweight8(req.rx_streams);
 
 	if (chandef->width == NL80211_CHAN_WIDTH_80P80) {
@@ -3226,7 +3218,7 @@ static int mt7915_mcu_set_eeprom_flash(struct mt7915_dev *dev)
 		skb_put_data(skb, eep, eep_len);
 
 		ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					    MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
+					    MCU_EXT_CMD(EFUSE_BUFFER_MODE), true);
 		if (ret)
 			return ret;
 	}
@@ -3244,7 +3236,7 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 	if (dev->flash_mode)
 		return mt7915_mcu_set_eeprom_flash(dev);
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(EFUSE_BUFFER_MODE),
 				 &req, sizeof(req), true);
 }
 
@@ -3258,7 +3250,7 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 	int ret;
 	u8 *buf;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_QUERY(EFUSE_ACCESS), &req,
 				sizeof(req), true, &skb);
 	if (ret)
 		return ret;
@@ -3283,7 +3275,7 @@ int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
 		.action = index,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_THERMAL_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(THERMAL_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -3301,7 +3293,7 @@ int mt7915_mcu_get_tx_rate(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
 		.dump_group = cpu_to_le16(1),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -3330,7 +3322,7 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 		req.val[i] = hw->conf.power_level * 2 + delta[i];
 
 	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -3352,7 +3344,7 @@ int mt7915_mcu_set_test_param(struct mt7915_dev *dev, u8 param, bool test_mode,
 		.enable = en,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -3371,7 +3363,7 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL), &req,
 				 sizeof(req), true);
 }
 
@@ -3388,7 +3380,7 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
 		.band = band,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SER_TRIGGER,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SER_TRIGGER),
 				 &req, sizeof(req), false);
 }
 
@@ -3406,7 +3398,7 @@ int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
 		.ibf = dev->ibf,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
 				 sizeof(req), true);
 }
 
@@ -3425,7 +3417,7 @@ int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev)
 		.snd_mode = MT_BF_PROCESSING,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(TXBF_ACTION), &req,
 				 sizeof(req), true);
 }
 
@@ -3450,7 +3442,7 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		.val = cpu_to_le32(enable),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(SET_SPR), &req,
 				 sizeof(req), true);
 }
 
@@ -3477,7 +3469,7 @@ int mt7915_mcu_get_rx_rate(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	int ret;
 	int i;
 
-	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD_PHY_STAT_INFO,
+	ret = mt76_mcu_send_and_get_msg(&dev->mt76, MCU_EXT_CMD(PHY_STAT_INFO),
 					&req, sizeof(req), true, &skb);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 95ac3c418808..bd136ca29d0d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -225,6 +225,12 @@ enum {
 	MCU_S2D_H2CN
 };
 
+
+#define __MCU_CMD_FIELD_ID	GENMASK(7, 0)
+#define __MCU_CMD_FIELD_EXT_ID	GENMASK(15, 8)
+#define __MCU_CMD_FIELD_QUERY	BIT(16)
+#define __MCU_CMD_FIELD_WA	BIT(17)
+
 enum {
 	MCU_CMD_TARGET_ADDRESS_LEN_REQ = 0x01,
 	MCU_CMD_FW_START_REQ = 0x02,
@@ -271,6 +277,15 @@ enum {
 	MCU_EXT_CMD_PHY_STAT_INFO = 0xad,
 };
 
+#define MCU_CMD(_t)		FIELD_PREP(__MCU_CMD_FIELD_ID, MCU_CMD_##_t)
+#define MCU_EXT_CMD(_t)		(MCU_CMD(EXT_CID) | \
+				 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID, \
+					    MCU_EXT_CMD_##_t))
+#define MCU_EXT_QUERY(_t)	(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_QUERY)
+
+#define MCU_WA_CMD(_t)		(MCU_CMD(_t) | __MCU_CMD_FIELD_WA)
+#define MCU_WA_EXT_CMD(_t)	(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_WA)
+
 enum {
 	PATCH_SEM_RELEASE,
 	PATCH_SEM_GET
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
index 012e3cb00612..7fb2170a9561 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/testmode.c
@@ -78,7 +78,7 @@ mt7915_tm_set_tx_power(struct mt7915_phy *phy)
 		req.tx_power = tx_power[0];
 
 	ret = mt76_mcu_send_msg(&dev->mt76,
-				MCU_EXT_CMD_TX_POWER_FEATURE_CTRL,
+				MCU_EXT_CMD(TX_POWER_FEATURE_CTRL),
 				&req, sizeof(req), false);
 
 	return ret;
@@ -95,7 +95,7 @@ mt7915_tm_set_freq_offset(struct mt7915_phy *phy, bool en, u32 val)
 		.param.freq.freq_offset = cpu_to_le32(val),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -112,7 +112,7 @@ mt7915_tm_mode_ctrl(struct mt7915_dev *dev, bool enable)
 	};
 
 	return mt76_mcu_send_msg(&dev->mt76,
-				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL,
+				 MCU_EXT_CMD(TX_POWER_FEATURE_CTRL),
 				 &req, sizeof(req), false);
 }
 
@@ -128,7 +128,7 @@ mt7915_tm_set_trx(struct mt7915_phy *phy, int type, bool en)
 		.param.trx.band = phy != &dev->phy,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -143,7 +143,7 @@ mt7915_tm_clean_hwq(struct mt7915_phy *phy, u8 wcid)
 		.param.clean.band = phy != &dev->phy,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -161,7 +161,7 @@ mt7915_tm_set_slot_time(struct mt7915_phy *phy, u8 slot_time, u8 sifs)
 		.param.slot.band = phy != &dev->phy,
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(ATE_CTRL), &req,
 				 sizeof(req), false);
 }
 
@@ -418,7 +418,7 @@ mt7915_tm_update_channel(struct mt7915_phy *phy)
 	mt7915_set_channel(phy);
 	mutex_lock(&phy->dev->mt76.mutex);
 
-	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
 }
 
 static void
@@ -489,7 +489,7 @@ mt7915_tm_rf_switch_mode(struct mt7915_dev *dev, u32 oper)
 		.op.op_mode = cpu_to_le32(oper),
 	};
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_TEST, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_TEST), &req,
 				 sizeof(req), true);
 }
 
@@ -601,7 +601,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	if (!en) {
 		int ret;
 
-		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_TEST, &req,
+		ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_TEST), &req,
 					sizeof(req), true);
 		if (ret)
 			return ret;
@@ -612,7 +612,7 @@ mt7915_tm_set_tx_cont(struct mt7915_phy *phy, bool en)
 	mt7915_tm_rf_switch_mode(dev, RF_OPER_RF_TEST);
 	mt7915_tm_update_channel(phy);
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_TEST, &req,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD(RF_TEST), &req,
 				 sizeof(req), true);
 }
 
-- 
2.28.0

