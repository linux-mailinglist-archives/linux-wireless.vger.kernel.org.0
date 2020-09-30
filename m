Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBF827E87A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgI3MYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728149AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A94C0613D0
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=CcWEl1yAXbCdEc+XivDr/xE2Aj2OvYX3SKDx9rpXrqU=; b=K6LaxFd0xLDOQB9OUbKK35WN4p
        ipIbTX7PzSVJ2HBhWhE15TmzG6OBWrgT9EhFuf/ugcdcbBpKD8IM4Pz9Kyc6U7lZ8Nism/zB0EO5M
        VdR+rOq3Uquw0Oiqc2nDTGSnOMR8v2S28nj8P3Urqew9J0/MgJu7CFbZFy1wJzgLrOt0=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA2-0005MT-TT
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/10] mt76: rename __mt76_mcu_send_msg to mt76_mcu_send_msg
Date:   Wed, 30 Sep 2020 14:24:32 +0200
Message-Id: <20200930122441.64523-1-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for further cleanup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |   3 +-
 .../net/wireless/mediatek/mt76/mt7603/mcu.c   |  27 ++-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 183 +++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_mcu.c  |  11 +-
 .../net/wireless/mediatek/mt76/mt76x2/mcu.c   |  18 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 132 ++++++-------
 6 files changed, 187 insertions(+), 187 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b8765548e3a4..39adead17c00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -685,9 +685,8 @@ enum mt76_phy_type {
 #define mt76_wr_rp(dev, ...)	(dev)->mt76.bus->wr_rp(&((dev)->mt76), __VA_ARGS__)
 #define mt76_rd_rp(dev, ...)	(dev)->mt76.bus->rd_rp(&((dev)->mt76), __VA_ARGS__)
 
-#define mt76_mcu_send_msg(dev, ...)	(dev)->mt76.mcu_ops->mcu_send_msg(&((dev)->mt76), __VA_ARGS__)
 
-#define __mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
+#define mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
 #define __mt76_mcu_skb_send_msg(dev, ...)	(dev)->mcu_ops->mcu_skb_send_msg((dev), __VA_ARGS__)
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
 #define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
index a47a3a644ecc..ddef085f930d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mcu.c
@@ -114,8 +114,8 @@ mt7603_mcu_init_download(struct mt7603_dev *dev, u32 addr, u32 len)
 		.mode = cpu_to_le32(BIT(31)),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_TARGET_ADDRESS_LEN_REQ,
+				 &req, sizeof(req), true);
 }
 
 static int
@@ -127,8 +127,8 @@ mt7603_mcu_send_firmware(struct mt7603_dev *dev, const void *data, int len)
 		cur_len = min_t(int, 4096 - sizeof(struct mt7603_mcu_txd),
 				len);
 
-		ret = __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER,
-					  data, cur_len, false);
+		ret = mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER, data,
+					cur_len, false);
 		if (ret)
 			break;
 
@@ -150,15 +150,14 @@ mt7603_mcu_start_firmware(struct mt7603_dev *dev, u32 addr)
 		.addr = cpu_to_le32(addr),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
 }
 
 static int
 mt7603_mcu_restart(struct mt76_dev *dev)
 {
-	return __mt76_mcu_send_msg(dev, -MCU_CMD_RESTART_DL_REQ,
-				   NULL, 0, true);
+	return mt76_mcu_send_msg(dev, -MCU_CMD_RESTART_DL_REQ, NULL, 0, true);
 }
 
 static int mt7603_load_firmware(struct mt7603_dev *dev)
@@ -377,8 +376,8 @@ int mt7603_mcu_set_eeprom(struct mt7603_dev *dev)
 		data[i].val = eep[req_fields[i]];
 	}
 
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				  req, len, true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				req, len, true);
 	kfree(req);
 
 	return ret;
@@ -424,8 +423,8 @@ static int mt7603_mcu_set_tx_power(struct mt7603_dev *dev)
 	memcpy(req.temp_comp_power, eep + MT_EE_STEP_NUM_NEG_6_7,
 	       sizeof(req.temp_comp_power));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_TX_POWER_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_TX_POWER_CTRL,
+				 &req, sizeof(req), true);
 }
 
 int mt7603_mcu_set_channel(struct mt7603_dev *dev)
@@ -470,8 +469,8 @@ int mt7603_mcu_set_channel(struct mt7603_dev *dev)
 	for (i = 0; i < ARRAY_SIZE(req.txpower); i++)
 		req.txpower[i] = tx_power;
 
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_CHANNEL_SWITCH,
-				  &req, sizeof(req), true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_CHANNEL_SWITCH, &req,
+				sizeof(req), true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 31b40fb83f6c..b2d1c9c26608 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -303,9 +303,9 @@ u32 mt7615_rf_rr(struct mt7615_dev *dev, u32 wf, u32 reg)
 		.address = cpu_to_le32(reg),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76,
-				   MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_RF_REG_ACCESS | MCU_QUERY_PREFIX,
+				 &req, sizeof(req), true);
 }
 
 int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
@@ -320,8 +320,8 @@ int mt7615_rf_wr(struct mt7615_dev *dev, u32 wf, u32 reg, u32 val)
 		.data = cpu_to_le32(val),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_REG_ACCESS, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RF_REG_ACCESS, &req,
+				 sizeof(req), false);
 }
 
 static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
@@ -645,8 +645,8 @@ static int mt7615_mcu_init_download(struct mt7615_dev *dev, u32 addr,
 		.mode = cpu_to_le32(mode),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TARGET_ADDRESS_LEN_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_TARGET_ADDRESS_LEN_REQ,
+				 &req, sizeof(req), true);
 }
 
 static int
@@ -685,8 +685,8 @@ mt7615_mcu_add_dev(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	};
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   &data, sizeof(data), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
+				 &data, sizeof(data), true);
 }
 
 static int
@@ -750,8 +750,8 @@ mt7615_mcu_add_beacon_offload(struct mt7615_dev *dev,
 	}
 	dev_kfree_skb(skb);
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_BCN_OFFLOAD, &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -781,8 +781,8 @@ mt7615_mcu_ctrl_pm_state(struct mt7615_dev *dev, int band, int state)
 		.band_idx = band,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL, &req,
+				 sizeof(req), true);
 }
 
 static struct sk_buff *
@@ -1586,7 +1586,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 	data = enable ? (void *)&dev_req : (void *)&basic_req;
 	len = enable ? sizeof(dev_req) : sizeof(basic_req);
 
-	err = __mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	err = mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
 	if (err < 0)
 		return err;
 
@@ -1594,7 +1594,7 @@ mt7615_mcu_uni_add_dev(struct mt7615_dev *dev,
 	data = enable ? (void *)&basic_req : (void *)&dev_req;
 	len = enable ? sizeof(basic_req) : sizeof(dev_req);
 
-	return __mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
+	return mt76_mcu_send_msg(&dev->mt76, cmd, data, len, true);
 }
 
 static int
@@ -1708,8 +1708,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	basic_req.basic.sta_idx = cpu_to_le16(mvif->sta.wcid.idx);
 	basic_req.basic.conn_state = !enable;
 
-	err = __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				  &basic_req, sizeof(basic_req), true);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				&basic_req, sizeof(basic_req), true);
 	if (err < 0)
 		return err;
 
@@ -1744,8 +1744,8 @@ mt7615_mcu_uni_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
 		rlm_req.rlm.sco = 3; /* SCB */
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				   &rlm_req, sizeof(rlm_req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &rlm_req, sizeof(rlm_req), true);
 }
 
 static int
@@ -1816,8 +1816,8 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	}
 	dev_kfree_skb(skb);
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+				 &req, sizeof(req), true);
 }
 
 static int
@@ -1930,8 +1930,8 @@ static int mt7615_mcu_send_firmware(struct mt7615_dev *dev, const void *data,
 	while (len > 0) {
 		cur_len = min_t(int, 4096 - dev->mt76.mcu_ops->headroom, len);
 
-		ret = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_SCATTER,
-					  data, cur_len, false);
+		ret = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_SCATTER, data,
+					cur_len, false);
 		if (ret)
 			break;
 
@@ -1956,14 +1956,13 @@ static int mt7615_mcu_start_firmware(struct mt7615_dev *dev, u32 addr,
 		.addr = cpu_to_le32(addr),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_restart(struct mt76_dev *dev)
 {
-	return __mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL,
-				   0, true);
+	return mt76_mcu_send_msg(dev, MCU_CMD_RESTART_DL_REQ, NULL, 0, true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_restart);
 
@@ -1975,8 +1974,8 @@ static int mt7615_mcu_patch_sem_ctrl(struct mt7615_dev *dev, bool get)
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
 }
 
 static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
@@ -1988,8 +1987,8 @@ static int mt7615_mcu_start_patch(struct mt7615_dev *dev)
 		.check_crc = 0,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
 }
 
 static int mt7615_load_patch(struct mt7615_dev *dev, u32 addr, const char *name)
@@ -2285,8 +2284,8 @@ int mt7615_mcu_fw_log_2_host(struct mt7615_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST,
-				   &data, sizeof(data), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST, &data,
+				 sizeof(data), true);
 }
 
 static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
@@ -2563,8 +2562,8 @@ int mt7615_mcu_set_mac_enable(struct mt7615_dev *dev, int band, bool enable)
 		.band = band,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val)
@@ -2583,8 +2582,8 @@ int mt7615_mcu_set_rts_thresh(struct mt7615_phy *phy, u32 val)
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
@@ -2620,8 +2619,8 @@ int mt7615_mcu_set_wmm(struct mt7615_dev *dev, u8 queue,
 	if (params->cw_max)
 		req.cw_max = cpu_to_le16(fls(params->cw_max));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
@@ -2679,8 +2678,8 @@ int mt7615_mcu_set_dbdc(struct mt7615_dev *dev)
 	ADD_DBDC_ENTRY(DBDC_TYPE_MGMT, 1, 1);
 
 out:
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DBDC_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DBDC_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
@@ -2689,8 +2688,8 @@ int mt7615_mcu_del_wtbl_all(struct mt7615_dev *dev)
 		.operation = WTBL_RESET_ALL,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_WTBL_UPDATE, &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_del_wtbl_all);
 
@@ -2711,8 +2710,8 @@ int mt7615_mcu_rdd_cmd(struct mt7615_dev *dev,
 		.val = val,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
@@ -2725,8 +2724,8 @@ int mt7615_mcu_set_fcc5_lpn(struct mt7615_dev *dev, int val)
 		.min_lpn = val,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
@@ -2741,8 +2740,8 @@ int mt7615_mcu_set_pulse_th(struct mt7615_dev *dev,
 
 	memcpy(&req.pulse, pulse, sizeof(*pulse));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
@@ -2759,8 +2758,8 @@ int mt7615_mcu_set_radar_th(struct mt7615_dev *dev, int index,
 
 	memcpy(&req.pattern, pattern, sizeof(*pattern));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
@@ -2790,8 +2789,8 @@ int mt7615_mcu_rdd_send_pattern(struct mt7615_dev *dev)
 					    i * dev->radar_pattern.period;
 	}
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_PATTERN,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_PATTERN,
+				 &req, sizeof(req), false);
 }
 
 static void mt7615_mcu_set_txpower_sku(struct mt7615_phy *phy, u8 *sku)
@@ -2885,7 +2884,7 @@ int mt7615_mcu_set_chan_info(struct mt7615_phy *phy, int cmd)
 	else
 		mt7615_mcu_set_txpower_sku(phy, req.txpower_sku);
 
-	return __mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
 int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
@@ -2897,8 +2896,8 @@ int mt7615_mcu_get_temperature(struct mt7615_dev *dev, int index)
 		.action = index,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
-				   sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_GET_TEMP, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
@@ -2918,8 +2917,8 @@ int mt7615_mcu_set_test_param(struct mt7615_dev *dev, u8 param, bool test_mode,
 		.value = cpu_to_le32(val),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_ATE_CTRL, &req,
+				 sizeof(req), false);
 }
 
 int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
@@ -2936,8 +2935,9 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable)
 		.sku_enable = enable,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
-				   sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif)
@@ -2957,8 +2957,8 @@ int mt7615_mcu_set_vif_ps(struct mt7615_dev *dev, struct ieee80211_vif *vif)
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return -ENOTSUPP;
 
-	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_SET_PS_PROFILE,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_PS_PROFILE, &req,
+				 sizeof(req), false);
 }
 
 int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
@@ -3130,8 +3130,8 @@ int mt7615_mcu_cancel_hw_scan(struct mt7615_phy *phy,
 		ieee80211_scan_completed(phy->mt76->hw, &info);
 	}
 
-	return __mt76_mcu_send_msg(&dev->mt76,  MCU_CMD_CANCEL_HW_SCAN, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_CANCEL_HW_SCAN, &req,
+				 sizeof(req), false);
 }
 
 int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
@@ -3226,8 +3226,8 @@ int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
 	else
 		clear_bit(MT76_HW_SCHED_SCANNING, &phy->mt76->state);
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SCHED_SCAN_ENABLE, &req,
+				 sizeof(req), false);
 }
 
 static int mt7615_find_freq_idx(const u16 *freqs, int n_freqs, u16 cur)
@@ -3366,8 +3366,8 @@ int mt7615_mcu_apply_rx_dcoc(struct mt7615_phy *phy)
 
 out:
 	req.center_freq = cpu_to_le16(center_freq);
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RXDCOC_CAL, &req,
-				  sizeof(req), true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RXDCOC_CAL, &req,
+				sizeof(req), true);
 
 	if ((chandef->width == NL80211_CHAN_WIDTH_80P80 ||
 	     chandef->width == NL80211_CHAN_WIDTH_160) && !req.is_freq2) {
@@ -3487,8 +3487,8 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 
 out:
 	req.center_freq = cpu_to_le16(center_freq);
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXDPD_CAL, &req,
-				  sizeof(req), true);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXDPD_CAL, &req,
+				sizeof(req), true);
 
 	if ((chandef->width == NL80211_CHAN_WIDTH_80P80 ||
 	     chandef->width == NL80211_CHAN_WIDTH_160) && !req.is_freq2) {
@@ -3532,13 +3532,13 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	    !mt7615_firmware_offload(dev))
 		return -ENOTSUPP;
 
-	err = __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT,
-				  &req_hdr, sizeof(req_hdr), false);
+	err = mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_ABORT, &req_hdr,
+				sizeof(req_hdr), false);
 	if (err < 0 || !enable)
 		return err;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_BSS_CONNECTED, &req,
+				 sizeof(req), false);
 }
 
 #ifdef CONFIG_PM
@@ -3570,8 +3570,8 @@ int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
 	else if (mt76_is_usb(&dev->mt76))
 		req.hdr.hif_type = 1;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL, &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
 
@@ -3613,8 +3613,8 @@ mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	else if (mt76_is_usb(&dev->mt76))
 		req.wow_ctrl_tlv.wakeup_hif = 1;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -3678,8 +3678,8 @@ mt7615_mcu_set_suspend_mode(struct mt7615_dev *dev,
 		},
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_SUSPEND, &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -3705,8 +3705,8 @@ mt7615_mcu_set_gtk_rekey(struct mt7615_dev *dev,
 		},
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -3731,8 +3731,8 @@ mt7615_mcu_set_arp_filter(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 		},
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_OFFLOAD, &req,
+				 sizeof(req), true);
 }
 
 void mt7615_mcu_set_suspend_iter(void *priv, u8 *mac,
@@ -3843,8 +3843,8 @@ int mt7615_mcu_set_roc(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	phy->roc_grant = false;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_ROC, &req,
+				 sizeof(req), false);
 }
 
 int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
@@ -3912,8 +3912,8 @@ int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 	if (!mt7615_firmware_offload(dev))
 		return -ENOTSUPP;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_P2P_OPPPS,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_CMD_SET_P2P_OPPPS, &req,
+				 sizeof(req), false);
 }
 
 u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
@@ -3925,8 +3925,8 @@ u32 mt7615_mcu_reg_rr(struct mt76_dev *dev, u32 offset)
 		.addr = cpu_to_le32(offset),
 	};
 
-	return __mt76_mcu_send_msg(dev, MCU_CMD_REG_READ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(dev, MCU_CMD_REG_READ, &req, sizeof(req),
+				 true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_reg_rr);
 
@@ -3940,7 +3940,6 @@ void mt7615_mcu_reg_wr(struct mt76_dev *dev, u32 offset, u32 val)
 		.val = cpu_to_le32(val),
 	};
 
-	__mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE,
-			    &req, sizeof(req), false);
+	mt76_mcu_send_msg(dev, MCU_CMD_REG_WRITE, &req, sizeof(req), false);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_reg_wr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
index 267058086a90..1c2e3d16f89c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mcu.c
@@ -89,7 +89,8 @@ int mt76x02_mcu_function_select(struct mt76x02_dev *dev, enum mcu_function func,
 	if (func != Q_SELECT)
 		wait = true;
 
-	return mt76_mcu_send_msg(dev, CMD_FUN_SET_OP, &msg, sizeof(msg), wait);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_FUN_SET_OP, &msg,
+				 sizeof(msg), wait);
 }
 EXPORT_SYMBOL_GPL(mt76x02_mcu_function_select);
 
@@ -103,8 +104,8 @@ int mt76x02_mcu_set_radio_state(struct mt76x02_dev *dev, bool on)
 		.level = cpu_to_le32(0),
 	};
 
-	return mt76_mcu_send_msg(dev, CMD_POWER_SAVING_OP, &msg, sizeof(msg),
-				 false);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_POWER_SAVING_OP, &msg,
+				 sizeof(msg), false);
 }
 EXPORT_SYMBOL_GPL(mt76x02_mcu_set_radio_state);
 
@@ -123,8 +124,8 @@ int mt76x02_mcu_calibrate(struct mt76x02_dev *dev, int type, u32 param)
 	if (is_mt76x2e)
 		mt76_rmw(dev, MT_MCU_COM_REG0, BIT(31), 0);
 
-	ret = mt76_mcu_send_msg(dev, CMD_CALIBRATION_OP, &msg, sizeof(msg),
-				true);
+	ret = mt76_mcu_send_msg(&dev->mt76, CMD_CALIBRATION_OP, &msg,
+				sizeof(msg), true);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
index 9635c04ce032..3c2738903d7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/mcu.c
@@ -33,13 +33,14 @@ int mt76x2_mcu_set_channel(struct mt76x02_dev *dev, u8 channel, u8 bw,
 	};
 
 	/* first set the channel without the extension channel info */
-	mt76_mcu_send_msg(dev, CMD_SWITCH_CHANNEL_OP, &msg, sizeof(msg), true);
+	mt76_mcu_send_msg(&dev->mt76, CMD_SWITCH_CHANNEL_OP, &msg,
+			  sizeof(msg), true);
 
 	usleep_range(5000, 10000);
 
 	msg.ext_chan = 0xe0 + bw_index;
-	return mt76_mcu_send_msg(dev, CMD_SWITCH_CHANNEL_OP, &msg, sizeof(msg),
-				 true);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_SWITCH_CHANNEL_OP, &msg,
+				 sizeof(msg), true);
 }
 EXPORT_SYMBOL_GPL(mt76x2_mcu_set_channel);
 
@@ -66,7 +67,8 @@ int mt76x2_mcu_load_cr(struct mt76x02_dev *dev, u8 type, u8 temp_level,
 	msg.cfg = cpu_to_le32(val);
 
 	/* first set the channel without the extension channel info */
-	return mt76_mcu_send_msg(dev, CMD_LOAD_CR, &msg, sizeof(msg), true);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_LOAD_CR, &msg, sizeof(msg),
+				 true);
 }
 EXPORT_SYMBOL_GPL(mt76x2_mcu_load_cr);
 
@@ -84,8 +86,8 @@ int mt76x2_mcu_init_gain(struct mt76x02_dev *dev, u8 channel, u32 gain,
 	if (force)
 		msg.channel |= cpu_to_le32(BIT(31));
 
-	return mt76_mcu_send_msg(dev, CMD_INIT_GAIN_OP, &msg, sizeof(msg),
-				 true);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_INIT_GAIN_OP, &msg,
+				 sizeof(msg), true);
 }
 EXPORT_SYMBOL_GPL(mt76x2_mcu_init_gain);
 
@@ -100,7 +102,7 @@ int mt76x2_mcu_tssi_comp(struct mt76x02_dev *dev,
 		.data = *tssi_data,
 	};
 
-	return mt76_mcu_send_msg(dev, CMD_CALIBRATION_OP, &msg, sizeof(msg),
-				 true);
+	return mt76_mcu_send_msg(&dev->mt76, CMD_CALIBRATION_OP, &msg,
+				 sizeof(msg), true);
 }
 EXPORT_SYMBOL_GPL(mt76x2_mcu_tssi_comp);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f42a54cd8d45..63a9044f88d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1056,8 +1056,8 @@ mt7915_mcu_muar_config(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 	if (enable)
 		ether_addr_copy(req.addr, addr);
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MUAR_UPDATE,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MUAR_UPDATE, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
@@ -2308,8 +2308,8 @@ mt7915_mcu_add_group(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		.val = cpu_to_le32(mvif->idx % 16),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_DRR_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_DRR_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -2459,8 +2459,8 @@ int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
 		return mt7915_mcu_muar_config(phy, vif, false, enable);
 
 	memcpy(data.tlv.omac_addr, vif->addr, ETH_ALEN);
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
-				   &data, sizeof(data), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_DEV_INFO_UPDATE,
+				 &data, sizeof(data), true);
 }
 
 static void
@@ -2564,8 +2564,8 @@ static int mt7915_mcu_send_firmware(struct mt7915_dev *dev, const void *data,
 		cur_len = min_t(int, 4096 - sizeof(struct mt7915_mcu_txd),
 				len);
 
-		ret = __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER,
-					  data, cur_len, false);
+		ret = mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_SCATTER, data,
+					cur_len, false);
 		if (ret)
 			break;
 
@@ -2588,8 +2588,8 @@ static int mt7915_mcu_start_firmware(struct mt7915_dev *dev, u32 addr,
 		.addr = cpu_to_le32(addr),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_FW_START_REQ, &req,
+				 sizeof(req), true);
 }
 
 static int mt7915_mcu_restart(struct mt76_dev *dev)
@@ -2601,8 +2601,8 @@ static int mt7915_mcu_restart(struct mt76_dev *dev)
 		.power_mode = 1,
 	};
 
-	return __mt76_mcu_send_msg(dev, -MCU_CMD_NIC_POWER_CTRL, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(dev, -MCU_CMD_NIC_POWER_CTRL, &req,
+				 sizeof(req), false);
 }
 
 static int mt7915_mcu_patch_sem_ctrl(struct mt7915_dev *dev, bool get)
@@ -2613,8 +2613,8 @@ static int mt7915_mcu_patch_sem_ctrl(struct mt7915_dev *dev, bool get)
 		.op = cpu_to_le32(get ? PATCH_SEM_GET : PATCH_SEM_RELEASE),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_SEM_CONTROL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_SEM_CONTROL, &req,
+				 sizeof(req), true);
 }
 
 static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
@@ -2626,8 +2626,8 @@ static int mt7915_mcu_start_patch(struct mt7915_dev *dev)
 		.check_crc = 0,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_FINISH_REQ,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, -MCU_CMD_PATCH_FINISH_REQ, &req,
+				 sizeof(req), true);
 }
 
 static int mt7915_driver_own(struct mt7915_dev *dev)
@@ -2663,7 +2663,7 @@ static int mt7915_mcu_init_download(struct mt7915_dev *dev, u32 addr,
 	else
 		attr = -MCU_CMD_TARGET_ADDRESS_LEN_REQ;
 
-	return __mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, attr, &req, sizeof(req), true);
 }
 
 static int mt7915_load_patch(struct mt7915_dev *dev)
@@ -2919,8 +2919,8 @@ int mt7915_mcu_fw_log_2_host(struct mt7915_dev *dev, u8 ctrl)
 		.ctrl_val = ctrl
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST,
-				   &data, sizeof(data), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_LOG_2_HOST, &data,
+				 sizeof(data), true);
 }
 
 int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
@@ -2937,8 +2937,8 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 		.level = level,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_DBG_CTRL,
-				   &data, sizeof(data), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_FW_DBG_CTRL, &data,
+				 sizeof(data), false);
 }
 
 static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
@@ -2950,8 +2950,8 @@ static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
 		.enable = enabled
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MWDS_SUPPORT,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MWDS_SUPPORT, &req,
+				 sizeof(req), false);
 }
 
 int mt7915_mcu_init(struct mt7915_dev *dev)
@@ -3023,13 +3023,13 @@ int mt7915_mcu_set_mac(struct mt7915_dev *dev, int band,
 	};
 	int ret;
 
-	ret = __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
-				  &req_trans, sizeof(req_trans), false);
+	ret = mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RX_HDR_TRANS,
+				&req_trans, sizeof(req_trans), false);
 	if (ret)
 		return ret;
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
-				   &req_mac, sizeof(req_mac), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MAC_INIT_CTRL,
+				 &req_mac, sizeof(req_mac), true);
 }
 
 int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable)
@@ -3044,8 +3044,8 @@ int mt7915_mcu_set_scs(struct mt7915_dev *dev, u8 band, bool enable)
 		.enable = enable + 1,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SCS_CTRL, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SCS_CTRL, &req,
+				 sizeof(req), false);
 }
 
 int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val)
@@ -3064,8 +3064,8 @@ int mt7915_mcu_set_rts_thresh(struct mt7915_phy *phy, u32 val)
 		.pkt_thresh = cpu_to_le32(0x2),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PROTECT_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
@@ -3118,8 +3118,8 @@ int mt7915_mcu_set_tx(struct mt7915_dev *dev, struct ieee80211_vif *vif)
 		else
 			e->cw_max = cpu_to_le16(10);
 	}
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE,
-				  &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EDCA_UPDATE, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter)
@@ -3149,8 +3149,8 @@ int mt7915_mcu_set_pm(struct mt7915_dev *dev, int band, int enter)
 		.band_idx = band,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_PM_STATE_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
@@ -3170,8 +3170,8 @@ int mt7915_mcu_rdd_cmd(struct mt7915_dev *dev,
 		.val = val,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val)
@@ -3185,8 +3185,8 @@ int mt7915_mcu_set_fcc5_lpn(struct mt7915_dev *dev, int val)
 		.min_lpn = val,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
@@ -3201,8 +3201,8 @@ int mt7915_mcu_set_pulse_th(struct mt7915_dev *dev,
 
 	memcpy(&req.pulse, pulse, sizeof(*pulse));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
@@ -3219,8 +3219,8 @@ int mt7915_mcu_set_radar_th(struct mt7915_dev *dev, int index,
 
 	memcpy(&req.pattern, pattern, sizeof(*pattern));
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_RDD_TH, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
@@ -3272,7 +3272,7 @@ int mt7915_mcu_set_chan_info(struct mt7915_phy *phy, int cmd)
 		req.center_ch2 = ieee80211_frequency_to_channel(freq2);
 	}
 
-	return __mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, cmd, &req, sizeof(req), true);
 }
 
 int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
@@ -3286,8 +3286,8 @@ int mt7915_mcu_set_eeprom(struct mt7915_dev *dev)
 		.format = EE_FORMAT_WHOLE,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_BUFFER_MODE,
+				 &req, sizeof(req), true);
 }
 
 int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
@@ -3296,8 +3296,8 @@ int mt7915_mcu_get_eeprom(struct mt7915_dev *dev, u32 offset)
 		.addr = cpu_to_le32(round_down(offset, 16)),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
-				   sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_EFUSE_ACCESS, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
@@ -3312,8 +3312,8 @@ int mt7915_mcu_get_temperature(struct mt7915_dev *dev, int index)
 		.action = index,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_THERMAL_CTRL, &req,
-				   sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_THERMAL_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_get_rate_info(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
@@ -3330,8 +3330,8 @@ int mt7915_mcu_get_rate_info(struct mt7915_dev *dev, u32 cmd, u16 wlan_idx)
 		.dump_group = cpu_to_le16(1),
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RATE_CTRL, &req,
-				   sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_RATE_CTRL, &req,
+				 sizeof(req), false);
 }
 
 int mt7915_mcu_set_sku(struct mt7915_phy *phy)
@@ -3358,9 +3358,9 @@ int mt7915_mcu_set_sku(struct mt7915_phy *phy)
 	for (i = 0; i < MT7915_SKU_RATE_NUM; i++)
 		req.val[i] = hw->conf.power_level * 2 + delta[i];
 
-	return __mt76_mcu_send_msg(&dev->mt76,
-				   MCU_EXT_CMD_TX_POWER_FEATURE_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
@@ -3377,9 +3377,9 @@ int mt7915_mcu_set_sku_en(struct mt7915_phy *phy, bool enable)
 		.sku_enable = enable,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76,
-				   MCU_EXT_CMD_TX_POWER_FEATURE_CTRL,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76,
+				 MCU_EXT_CMD_TX_POWER_FEATURE_CTRL, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
@@ -3395,8 +3395,8 @@ int mt7915_mcu_set_ser(struct mt7915_dev *dev, u8 action, u8 set, u8 band)
 		.band = band,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SER_TRIGGER,
-				   &req, sizeof(req), false);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SER_TRIGGER,
+				 &req, sizeof(req), false);
 }
 
 int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
@@ -3413,8 +3413,8 @@ int mt7915_mcu_set_txbf_type(struct mt7915_dev *dev)
 		.ibf = false,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev)
@@ -3432,8 +3432,8 @@ int mt7915_mcu_set_txbf_sounding(struct mt7915_dev *dev)
 		.snd_mode = MT_BF_PROCESSING,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_TXBF_ACTION, &req,
+				 sizeof(req), true);
 }
 
 int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -3457,6 +3457,6 @@ int mt7915_mcu_add_obss_spr(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		.val = enable,
 	};
 
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR,
-				   &req, sizeof(req), true);
+	return mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_SET_SPR, &req,
+				 sizeof(req), true);
 }
-- 
2.28.0

