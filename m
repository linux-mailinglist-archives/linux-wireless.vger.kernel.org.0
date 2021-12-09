Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA36446E8CA
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Dec 2021 14:07:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbhLINKd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Dec 2021 08:10:33 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:39102 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237560AbhLINKd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Dec 2021 08:10:33 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A295ACE25AD
        for <linux-wireless@vger.kernel.org>; Thu,  9 Dec 2021 13:06:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 391CBC004DD;
        Thu,  9 Dec 2021 13:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055215;
        bh=KIijYv5Tz5xcyoAp0bpgLlGpENx2hiNsMgQDIu6dguA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cJzDCpE2MNvX8UhRAjHbmXk/ULPPEQjgxeQh3qNZ83puOKRzYzHXAXma/Xqejxbb/
         cnTpWEalfMqEOhuDIkePcJf2yqyZV4StTIr6cu7OEfrqJOpiOpGQUm522IZJ3eBpcE
         pqs91cH6lU61Ru+7w1W3YwNlF2bZLFP0M+uL8kBrL1Tp1lFi/lAE4nm95jjppA8G29
         lLy63gVQuKd6JHKyxbW0md4OqjUZU25ogGJ0nmrLaNb/r/V0BqWcOfjR1LPrL5TTvw
         v9OUjCupPBWPFiE+qIuS13+r7YFr4fL/IJDBPUqoOe8ac1SYAPQKOvNREveW6Q08Zn
         ZzixX6WlQog1g==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, deren.wu@mediatek.com,
        ryder.lee@mediatek.com, evelyn.tsai@mediatek.com
Subject: [PATCH 4/7] mt76: connac: introduce MCU_UNI_CMD macro
Date:   Thu,  9 Dec 2021 14:06:26 +0100
Message-Id: <0d3d98c9d8f94befa5a1b2155d1cb01cfa5ca9d8.1639054861.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1639054861.git.lorenzo@kernel.org>
References: <cover.1639054861.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to MCU_EXT_CMD, introduce MCU_UNI_CMD for unified commands

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 26 +++++------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 44 ++++++++++---------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 19 ++++----
 .../net/wireless/mediatek/mt76/mt7921/main.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 36 +++++++--------
 5 files changed, 64 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2232afed7291..fcbcfc9f5a04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -103,7 +103,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	if (wait_seq)
 		*wait_seq = seq;
 
-	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
 
 	if (cmd != MCU_CMD_FW_SCATTER) {
@@ -124,7 +124,7 @@ void mt7615_mcu_fill_msg(struct mt7615_dev *dev, struct sk_buff *skb,
 	      FIELD_PREP(MT_TXD1_PKT_FMT, pkt_fmt);
 	txd[1] = cpu_to_le32(val);
 
-	if (cmd & MCU_UNI_PREFIX) {
+	if (cmd & __MCU_CMD_FIELD_UNI) {
 		uni_txd = (struct mt7615_uni_txd *)txd;
 		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
 		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
@@ -182,12 +182,12 @@ int mt7615_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 	} else if (cmd == MCU_EXT_QUERY(RF_REG_ACCESS)) {
 		skb_pull(skb, sizeof(*rxd));
 		ret = le32_to_cpu(*(__le32 *)&skb->data[8]);
-	} else if (cmd == MCU_UNI_CMD_DEV_INFO_UPDATE ||
-		   cmd == MCU_UNI_CMD_BSS_INFO_UPDATE ||
-		   cmd == MCU_UNI_CMD_STA_REC_UPDATE ||
-		   cmd == MCU_UNI_CMD_HIF_CTRL ||
-		   cmd == MCU_UNI_CMD_OFFLOAD ||
-		   cmd == MCU_UNI_CMD_SUSPEND) {
+	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
+		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		   cmd == MCU_UNI_CMD(OFFLOAD) ||
+		   cmd == MCU_UNI_CMD(SUSPEND)) {
 		struct mt7615_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -1263,7 +1263,7 @@ mt7615_mcu_uni_add_beacon_offload(struct mt7615_dev *dev,
 	dev_kfree_skb(skb);
 
 out:
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
 				 &req, sizeof(req), true);
 }
 
@@ -1292,7 +1292,7 @@ mt7615_mcu_uni_add_sta(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable)
 {
 	return __mt7615_mcu_add_sta(phy->mt76, vif, sta, enable,
-				    MCU_UNI_CMD_STA_REC_UPDATE, true);
+				    MCU_UNI_CMD(STA_REC_UPDATE), true);
 }
 
 static int
@@ -1326,7 +1326,7 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, false);
 
 	err = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				    MCU_UNI_CMD_STA_REC_UPDATE, true);
+				    MCU_UNI_CMD(STA_REC_UPDATE), true);
 	if (err < 0 || !enable)
 		return err;
 
@@ -1347,7 +1347,7 @@ mt7615_mcu_uni_rx_ba(struct mt7615_dev *dev,
 				    sta_wtbl, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+				     MCU_UNI_CMD(STA_REC_UPDATE), true);
 }
 
 static int
@@ -1359,7 +1359,7 @@ mt7615_mcu_sta_uni_update_hdr_trans(struct mt7615_dev *dev,
 
 	return mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76,
 						    vif, &msta->wcid,
-						    MCU_UNI_CMD_STA_REC_UPDATE);
+						    MCU_UNI_CMD(STA_REC_UPDATE));
 }
 
 static const struct mt7615_mcu_ops uni_update_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index d3fac18b8369..4a693368a4bf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1071,7 +1071,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 
 	memcpy(dev_req.tlv.omac_addr, vif->addr, ETH_ALEN);
 
-	cmd = enable ? MCU_UNI_CMD_DEV_INFO_UPDATE : MCU_UNI_CMD_BSS_INFO_UPDATE;
+	cmd = enable ? MCU_UNI_CMD(DEV_INFO_UPDATE) : MCU_UNI_CMD(BSS_INFO_UPDATE);
 	data = enable ? (void *)&dev_req : (void *)&basic_req;
 	len = enable ? sizeof(dev_req) : sizeof(basic_req);
 
@@ -1079,7 +1079,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 	if (err < 0)
 		return err;
 
-	cmd = enable ? MCU_UNI_CMD_BSS_INFO_UPDATE : MCU_UNI_CMD_DEV_INFO_UPDATE;
+	cmd = enable ? MCU_UNI_CMD(BSS_INFO_UPDATE) : MCU_UNI_CMD(DEV_INFO_UPDATE);
 	data = enable ? (void *)&basic_req : (void *)&dev_req;
 	len = enable ? sizeof(basic_req) : sizeof(dev_req);
 
@@ -1131,7 +1131,8 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 	mt76_connac_mcu_wtbl_ba_tlv(dev, skb, params, enable, tx, sta_wtbl,
 				    wtbl_hdr);
 
-	ret = mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_STA_REC_UPDATE, true);
+	ret = mt76_mcu_skb_send_msg(dev, skb,
+				    MCU_UNI_CMD(STA_REC_UPDATE), true);
 	if (ret)
 		return ret;
 
@@ -1141,8 +1142,8 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_STA_REC_UPDATE,
-				     true);
+	return mt76_mcu_skb_send_msg(dev, skb,
+				     MCU_UNI_CMD(STA_REC_UPDATE), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
 
@@ -1348,7 +1349,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	basic_req.basic.sta_idx = cpu_to_le16(wcid->idx);
 	basic_req.basic.conn_state = !enable;
 
-	err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE, &basic_req,
+	err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &basic_req,
 				sizeof(basic_req), true);
 	if (err < 0)
 		return err;
@@ -1386,7 +1387,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 
 		mt76_connac_mcu_uni_bss_he_tlv(phy, vif,
 					       (struct tlv *)&he_req.he);
-		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE,
+		err = mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE),
 					&he_req, sizeof(he_req), true);
 		if (err < 0)
 			return err;
@@ -1424,7 +1425,7 @@ int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 	else if (rlm_req.rlm.control_channel > rlm_req.rlm.center_chan)
 		rlm_req.rlm.sco = 3; /* SCB */
 
-	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD_BSS_INFO_UPDATE, &rlm_req,
+	return mt76_mcu_send_msg(mdev, MCU_UNI_CMD(BSS_INFO_UPDATE), &rlm_req,
 				 sizeof(rlm_req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_uni_add_bss);
@@ -2114,7 +2115,7 @@ int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
 		memcpy(addr, &info->arp_addr_list[i], sizeof(__be32));
 	}
 
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_OFFLOAD, true);
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(OFFLOAD), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_arp_filter);
 
@@ -2220,7 +2221,8 @@ int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 	memcpy(gtk_tlv->kck, key->kck, NL80211_KCK_LEN);
 	memcpy(gtk_tlv->replay_ctr, key->replay_ctr, NL80211_REPLAY_CTR_LEN);
 
-	return mt76_mcu_skb_send_msg(phy->dev, skb, MCU_UNI_CMD_OFFLOAD, true);
+	return mt76_mcu_skb_send_msg(phy->dev, skb,
+				     MCU_UNI_CMD(OFFLOAD), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_update_gtk_rekey);
 
@@ -2246,8 +2248,8 @@ mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		},
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(OFFLOAD), &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -2272,8 +2274,8 @@ mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		},
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_OFFLOAD, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(OFFLOAD), &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -2302,8 +2304,8 @@ mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
 		},
 	};
 
-	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_SUSPEND, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
+				 sizeof(req), true);
 }
 
 static int
@@ -2337,7 +2339,7 @@ mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
 	memcpy(ptlv->pattern, pattern->pattern, pattern->pattern_len);
 	memcpy(ptlv->mask, pattern->mask, DIV_ROUND_UP(pattern->pattern_len, 8));
 
-	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD_SUSPEND, true);
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SUSPEND), true);
 }
 
 static int
@@ -2389,8 +2391,8 @@ mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	else if (mt76_is_sdio(dev))
 		req.wow_ctrl_tlv.wakeup_hif = WOW_GPIO;
 
-	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_SUSPEND, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
+				 sizeof(req), true);
 }
 
 int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
@@ -2423,8 +2425,8 @@ int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 	else if (mt76_is_sdio(dev))
 		req.hdr.hif_type = 0;
 
-	return mt76_mcu_send_msg(dev, MCU_UNI_CMD_HIF_CTRL, &req, sizeof(req),
-				 true);
+	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(HIF_CTRL), &req,
+				 sizeof(req), true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_hif_suspend);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index c6b653c3e249..655dfd955310 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -497,13 +497,13 @@ enum {
 #define MCU_CMD_UNI_EXT_ACK			(MCU_CMD_ACK | MCU_CMD_UNI | \
 						 MCU_CMD_QUERY)
 
-#define MCU_UNI_PREFIX				BIT(30)
 #define MCU_CE_PREFIX				BIT(29)
-#define MCU_CMD_MASK				~(MCU_UNI_PREFIX | MCU_CE_PREFIX)
+#define MCU_CMD_MASK				~(MCU_CE_PREFIX)
 
 #define __MCU_CMD_FIELD_ID			GENMASK(7, 0)
 #define __MCU_CMD_FIELD_EXT_ID			GENMASK(15, 8)
 #define __MCU_CMD_FIELD_QUERY			BIT(16)
+#define __MCU_CMD_FIELD_UNI			BIT(17)
 
 #define MCU_CMD(_t)				FIELD_PREP(__MCU_CMD_FIELD_ID,		\
 							   MCU_CMD_##_t)
@@ -511,6 +511,9 @@ enum {
 						 FIELD_PREP(__MCU_CMD_FIELD_EXT_ID,	\
 							    MCU_EXT_CMD_##_t))
 #define MCU_EXT_QUERY(_t)			(MCU_EXT_CMD(_t) | __MCU_CMD_FIELD_QUERY)
+#define MCU_UNI_CMD(_t)				(__MCU_CMD_FIELD_UNI |			\
+						 FIELD_PREP(__MCU_CMD_FIELD_ID,		\
+							    MCU_UNI_CMD_##_t))
 
 enum {
 	MCU_EXT_CMD_EFUSE_ACCESS = 0x01,
@@ -563,12 +566,12 @@ enum {
 };
 
 enum {
-	MCU_UNI_CMD_DEV_INFO_UPDATE = MCU_UNI_PREFIX | 0x01,
-	MCU_UNI_CMD_BSS_INFO_UPDATE = MCU_UNI_PREFIX | 0x02,
-	MCU_UNI_CMD_STA_REC_UPDATE = MCU_UNI_PREFIX | 0x03,
-	MCU_UNI_CMD_SUSPEND = MCU_UNI_PREFIX | 0x05,
-	MCU_UNI_CMD_OFFLOAD = MCU_UNI_PREFIX | 0x06,
-	MCU_UNI_CMD_HIF_CTRL = MCU_UNI_PREFIX | 0x07,
+	MCU_UNI_CMD_DEV_INFO_UPDATE = 0x01,
+	MCU_UNI_CMD_BSS_INFO_UPDATE = 0x02,
+	MCU_UNI_CMD_STA_REC_UPDATE = 0x03,
+	MCU_UNI_CMD_SUSPEND = 0x05,
+	MCU_UNI_CMD_OFFLOAD = 0x06,
+	MCU_UNI_CMD_HIF_CTRL = 0x07,
 };
 
 enum {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 32e48b7413a1..3effe22f69c0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1332,7 +1332,7 @@ static void mt7921_sta_set_decap_offload(struct ieee80211_hw *hw,
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
 	mt76_connac_mcu_sta_update_hdr_trans(&dev->mt76, vif, &msta->wcid,
-					     MCU_UNI_CMD_STA_REC_UPDATE);
+					     MCU_UNI_CMD(STA_REC_UPDATE));
 }
 
 static int mt7921_set_sar_specs(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index cb29e0c3e3c7..e2fcd175f7d4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -187,12 +187,12 @@ int mt7921_mcu_parse_response(struct mt76_dev *mdev, int cmd,
 		ret = le32_to_cpu(*(__le32 *)skb->data);
 	} else if (cmd == MCU_EXT_CMD(EFUSE_ACCESS)) {
 		ret = mt7921_mcu_parse_eeprom(mdev, skb);
-	} else if (cmd == MCU_UNI_CMD_DEV_INFO_UPDATE ||
-		   cmd == MCU_UNI_CMD_BSS_INFO_UPDATE ||
-		   cmd == MCU_UNI_CMD_STA_REC_UPDATE ||
-		   cmd == MCU_UNI_CMD_HIF_CTRL ||
-		   cmd == MCU_UNI_CMD_OFFLOAD ||
-		   cmd == MCU_UNI_CMD_SUSPEND) {
+	} else if (cmd == MCU_UNI_CMD(DEV_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(BSS_INFO_UPDATE) ||
+		   cmd == MCU_UNI_CMD(STA_REC_UPDATE) ||
+		   cmd == MCU_UNI_CMD(HIF_CTRL) ||
+		   cmd == MCU_UNI_CMD(OFFLOAD) ||
+		   cmd == MCU_UNI_CMD(SUSPEND)) {
 		struct mt7921_mcu_uni_event *event;
 
 		skb_pull(skb, sizeof(*rxd));
@@ -226,16 +226,12 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	u32 val;
 	u8 seq;
 
-	switch (cmd) {
-	case MCU_UNI_CMD_HIF_CTRL:
-	case MCU_UNI_CMD_SUSPEND:
-	case MCU_UNI_CMD_OFFLOAD:
+	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
+	    cmd == MCU_UNI_CMD(SUSPEND) ||
+	    cmd == MCU_UNI_CMD(OFFLOAD))
 		mdev->mcu.timeout = HZ / 3;
-		break;
-	default:
+	else
 		mdev->mcu.timeout = 3 * HZ;
-		break;
-	}
 
 	seq = ++dev->mt76.mcu.msg_seq & 0xf;
 	if (!seq)
@@ -244,7 +240,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (cmd == MCU_CMD_FW_SCATTER)
 		goto exit;
 
-	txd_len = cmd & MCU_UNI_PREFIX ? sizeof(*uni_txd) : sizeof(*mcu_txd);
+	txd_len = cmd & __MCU_CMD_FIELD_UNI ? sizeof(*uni_txd) : sizeof(*mcu_txd);
 	txd = (__le32 *)skb_push(skb, txd_len);
 
 	val = FIELD_PREP(MT_TXD0_TX_BYTES, skb->len) |
@@ -256,7 +252,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	      FIELD_PREP(MT_TXD1_HDR_FORMAT, MT_HDR_FORMAT_CMD);
 	txd[1] = cpu_to_le32(val);
 
-	if (cmd & MCU_UNI_PREFIX) {
+	if (cmd & __MCU_CMD_FIELD_UNI) {
 		uni_txd = (struct mt7921_uni_txd *)txd;
 		uni_txd->len = cpu_to_le16(skb->len - sizeof(uni_txd->txd));
 		uni_txd->option = MCU_CMD_UNI_EXT_ACK;
@@ -561,7 +557,7 @@ int mt7921_mcu_add_key(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 		return ret;
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_UNI_CMD_STA_REC_UPDATE, true);
+				     MCU_UNI_CMD(STA_REC_UPDATE), true);
 }
 
 int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
@@ -1160,7 +1156,7 @@ int mt7921_mcu_uni_bss_ps(struct mt7921_dev *dev, struct ieee80211_vif *vif)
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return -EOPNOTSUPP;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
 				 &ps_req, sizeof(ps_req), true);
 }
 
@@ -1196,7 +1192,7 @@ mt7921_mcu_uni_bss_bcnft(struct mt7921_dev *dev, struct ieee80211_vif *vif,
 	if (vif->type != NL80211_IFTYPE_STATION)
 		return 0;
 
-	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_BSS_INFO_UPDATE,
+	return mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD(BSS_INFO_UPDATE),
 				 &bcnft_req, sizeof(bcnft_req), true);
 }
 
@@ -1251,7 +1247,7 @@ int mt7921_mcu_sta_update(struct mt7921_dev *dev, struct ieee80211_sta *sta,
 		.sta = sta,
 		.vif = vif,
 		.enable = enable,
-		.cmd = MCU_UNI_CMD_STA_REC_UPDATE,
+		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
 		.state = state,
 		.offload_fw = true,
 		.rcpi = to_rcpi(rssi),
-- 
2.31.1

