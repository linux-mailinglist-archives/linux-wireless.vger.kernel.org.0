Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5BF6127E875
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 14:24:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725776AbgI3MYp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727997AbgI3MYp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Sep 2020 08:24:45 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF696C061755
        for <linux-wireless@vger.kernel.org>; Wed, 30 Sep 2020 05:24:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=LE5ZbpayStrCO1lR9ugcFNRgwFfwUGCqk+YC+iTXnuM=; b=AdD9+dA+fT8kXzFSob0w8vI7tP
        YveIRsQ/ohg4aOv+D5y0ROycO89eg40MynGNQsLydkmeWJq97yvyUzJiEYzj8ot9FqzKXQ+te8bCr
        AghpQpeaCZ3YFrJ0m/MpXy9vwGwmlz84wvtuEI3Wvr/ewSZvJFITbsSDcwNBMBVu6WYs=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kNbA3-0005MT-5o
        for linux-wireless@vger.kernel.org; Wed, 30 Sep 2020 14:24:43 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/10] mt76: rename __mt76_mcu_skb_send_msg to mt76_mcu_skb_send_msg
Date:   Wed, 30 Sep 2020 14:24:33 +0200
Message-Id: <20200930122441.64523-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200930122441.64523-1-nbd@nbd.name>
References: <20200930122441.64523-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Preparation for further cleanup

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 76 +++++++++----------
 .../wireless/mediatek/mt76/mt7615/testmode.c  |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 53 ++++++-------
 4 files changed, 68 insertions(+), 67 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 39adead17c00..47cf3ecfa8c7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -687,7 +687,7 @@ enum mt76_phy_type {
 
 
 #define mt76_mcu_send_msg(dev, ...)	(dev)->mcu_ops->mcu_send_msg((dev), __VA_ARGS__)
-#define __mt76_mcu_skb_send_msg(dev, ...)	(dev)->mcu_ops->mcu_skb_send_msg((dev), __VA_ARGS__)
+#define mt76_mcu_skb_send_msg(dev, ...)	(dev)->mcu_ops->mcu_skb_send_msg((dev), __VA_ARGS__)
 #define mt76_mcu_restart(dev, ...)	(dev)->mt76.mcu_ops->mcu_restart(&((dev)->mt76))
 #define __mt76_mcu_restart(dev, ...)	(dev)->mcu_ops->mcu_restart((dev))
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b2d1c9c26608..48ac583a64e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -288,7 +288,7 @@ int mt7615_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	return __mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
+	return mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_msg_send);
 
@@ -1278,8 +1278,8 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	if (enable && mvif->omac_idx > EXT_BSSID_START)
 		mt7615_mcu_bss_ext_tlv(skb, mvif);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
 
 static int
@@ -1299,8 +1299,8 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, true, NULL, wtbl_hdr);
 
-	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				      MCU_EXT_CMD_WTBL_UPDATE, true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				    true);
 	if (err < 0)
 		return err;
 
@@ -1310,8 +1310,8 @@ mt7615_mcu_wtbl_tx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, true);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static int
@@ -1331,8 +1331,8 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, false);
 
-	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				      MCU_EXT_CMD_STA_REC_UPDATE, true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD_STA_REC_UPDATE, true);
 	if (err < 0 || !enable)
 		return err;
 
@@ -1343,8 +1343,8 @@ mt7615_mcu_wtbl_rx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, false, NULL, wtbl_hdr);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_WTBL_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
 }
 
 static int
@@ -1383,7 +1383,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
 	skb = enable ? wskb : sskb;
 
-	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
 	if (err < 0) {
 		skb = enable ? sskb : wskb;
 		dev_kfree_skb(skb);
@@ -1394,7 +1394,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 	cmd = enable ? MCU_EXT_CMD_STA_REC_UPDATE : MCU_EXT_CMD_WTBL_UPDATE;
 	skb = enable ? sskb : wskb;
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
 }
 
 static const struct mt7615_mcu_ops wtbl_update_ops = {
@@ -1432,8 +1432,8 @@ mt7615_mcu_sta_ba(struct mt7615_dev *dev,
 					     &skb);
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static int
@@ -1484,7 +1484,7 @@ mt7615_mcu_add_sta_cmd(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			mt7615_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, cmd, true);
 }
 
 static int
@@ -1846,8 +1846,8 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, true, sta_wtbl,
 			       wtbl_hdr);
 
-	err =  __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+	err =  mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 	if (err < 0)
 		return err;
 
@@ -1857,8 +1857,8 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, true);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
 static int
@@ -1879,8 +1879,8 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 
 	mt7615_mcu_sta_ba_tlv(skb, params, enable, false);
 
-	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				      MCU_UNI_CMD_STA_REC_UPDATE, true);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_UNI_CMD_STA_REC_UPDATE, true);
 	if (err < 0 || !enable)
 		return err;
 
@@ -1898,8 +1898,8 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	mt7615_mcu_wtbl_ba_tlv(skb, params, enable, false, sta_wtbl,
 			       wtbl_hdr);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_UNI_CMD_STA_REC_UPDATE, true);
 }
 
 static int
@@ -2546,8 +2546,8 @@ int mt7615_mcu_set_eeprom(struct mt7615_dev *dev)
 	skb_put_data(skb, &req_hdr, sizeof(req_hdr));
 	skb_put_data(skb, eep + offset, eep_len);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_EFUSE_BUFFER_MODE, true);
 }
 EXPORT_SYMBOL_GPL(mt7615_mcu_set_eeprom);
 
@@ -3018,8 +3018,8 @@ int mt7615_mcu_set_channel_domain(struct mt7615_phy *phy)
 		skb_put_data(skb, &channel, sizeof(channel));
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_CMD_SET_CHAN_DOMAIN, false);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SET_CHAN_DOMAIN,
+				     false);
 }
 
 #define MT7615_SCAN_CHANNEL_TIME	60
@@ -3101,8 +3101,8 @@ int mt7615_mcu_hw_scan(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		req->scan_func = 1;
 	}
 
-	err = __mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
-				      false);
+	err = mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_START_HW_SCAN,
+				    false);
 	if (err < 0)
 		clear_bit(MT76_HW_SCANNING, &phy->mt76->state);
 
@@ -3202,8 +3202,8 @@ int mt7615_mcu_sched_scan_req(struct mt7615_phy *phy,
 		memcpy(skb_put(skb, sreq->ie_len), sreq->ie, sreq->ie_len);
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_CMD_SCHED_SCAN_REQ, false);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_CMD_SCHED_SCAN_REQ,
+				     false);
 }
 
 int mt7615_mcu_sched_scan_enable(struct mt7615_phy *phy,
@@ -3649,8 +3649,8 @@ mt7615_mcu_set_wow_pattern(struct mt7615_dev *dev,
 	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
 	memcpy(ptlv->mask, pattern->mask, pattern->pattern_len / 8);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_SUSPEND, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_SUSPEND,
+				     true);
 }
 
 static int
@@ -3822,8 +3822,8 @@ int mt7615_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
 	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_OFFLOAD, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
+				     true);
 }
 #endif /* CONFIG_PM */
 
@@ -3890,8 +3890,8 @@ int mt7615_mcu_update_arp_filter(struct ieee80211_hw *hw,
 		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_UNI_CMD_OFFLOAD, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_UNI_CMD_OFFLOAD,
+				     true);
 }
 
 int mt7615_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
index e4dc62314bae..1f3362880673 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/testmode.c
@@ -90,8 +90,8 @@ mt7615_tm_set_tx_power(struct mt7615_phy *phy)
 			data[ret - MT_EE_NIC_CONF_0] = tx_power[i];
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_SET_TX_POWER_CTRL, false);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_SET_TX_POWER_CTRL, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 63a9044f88d5..0600ca7016ee 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -396,7 +396,7 @@ mt7915_mcu_msg_send(struct mt76_dev *mdev, int cmd, const void *data,
 	if (!skb)
 		return -ENOMEM;
 
-	return __mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
+	return mt76_mcu_skb_send_msg(mdev, skb, cmd, wait_resp);
 }
 
 static void
@@ -1095,8 +1095,8 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			mt7915_mcu_bss_ext_tlv(skb, mvif);
 	}
 
-	return __mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
-				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&phy->dev->mt76, skb,
+				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
 
 /** starec & wtbl **/
@@ -1177,8 +1177,8 @@ int mt7915_mcu_add_key(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (ret)
 		return ret;
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static void
@@ -1257,8 +1257,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 					     &skb);
 	mt7915_mcu_wtbl_ba_tlv(skb, params, enable, tx, sta_wtbl, wtbl_hdr);
 
-	ret = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				      MCU_EXT_CMD_STA_REC_UPDATE, true);
+	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				    MCU_EXT_CMD_STA_REC_UPDATE, true);
 	if (ret)
 		return ret;
 
@@ -1269,8 +1269,8 @@ mt7915_mcu_sta_ba(struct mt7915_dev *dev,
 
 	mt7915_mcu_sta_ba_tlv(skb, params, enable, tx);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
@@ -1605,8 +1605,8 @@ mt7915_mcu_add_mu(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	/* starec muru */
 	mt7915_mcu_sta_muru_tlv(skb, sta);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static void
@@ -1773,7 +1773,8 @@ int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
 	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
 	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
+				     true);
 }
 
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -1796,8 +1797,8 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 					     &skb);
 	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static void
@@ -2098,8 +2099,8 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 		mt7915_mcu_sta_bfer_tlv(skb, sta, vif, phy, enable);
 
-		r = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					    MCU_EXT_CMD_STA_REC_UPDATE, true);
+		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					  MCU_EXT_CMD_STA_REC_UPDATE, true);
 		if (r)
 			return r;
 	}
@@ -2114,8 +2115,8 @@ mt7915_mcu_add_txbf(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 		mt7915_mcu_sta_bfee_tlv(skb, sta, phy);
 
-		r = __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-					    MCU_EXT_CMD_STA_REC_UPDATE, true);
+		r = mt76_mcu_skb_send_msg(&dev->mt76, skb,
+					  MCU_EXT_CMD_STA_REC_UPDATE, true);
 		if (r)
 			return r;
 	}
@@ -2282,8 +2283,8 @@ int mt7915_mcu_add_rate_ctrl(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 
 	mt7915_mcu_sta_rate_ctrl_tlv(skb, dev, vif, sta);
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 static int
@@ -2370,8 +2371,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			mt7915_mcu_wtbl_ht_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 	}
 
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
@@ -2416,8 +2417,8 @@ int mt7915_mcu_set_fixed_rate(struct mt7915_dev *dev,
 		ra->phy.sgi = ra->phy.mcs * 15;
 
 out:
-	return __mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				       MCU_EXT_CMD_STA_REC_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
+				     MCU_EXT_CMD_STA_REC_UPDATE, true);
 }
 
 int mt7915_mcu_add_dev_info(struct mt7915_phy *phy,
@@ -2551,8 +2552,8 @@ int mt7915_mcu_add_beacon(struct ieee80211_hw *hw,
 	mt7915_mcu_beacon_cont(dev, rskb, skb, bcn, &offs);
 	dev_kfree_skb(skb);
 
-	return __mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
-				       MCU_EXT_CMD_BSS_INFO_UPDATE, true);
+	return mt76_mcu_skb_send_msg(&phy->dev->mt76, rskb,
+				     MCU_EXT_CMD_BSS_INFO_UPDATE, true);
 }
 
 static int mt7915_mcu_send_firmware(struct mt7915_dev *dev, const void *data,
-- 
2.28.0

