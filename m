Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B9FC127A1FD
	for <lists+linux-wireless@lfdr.de>; Sun, 27 Sep 2020 19:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgI0RSz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726255AbgI0RSz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 27 Sep 2020 13:18:55 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 178B2C0613D3
        for <linux-wireless@vger.kernel.org>; Sun, 27 Sep 2020 10:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=MJqoXhL3soDaM1ZBpCMldQa5/uMHXsAuWbwif84zp/U=; b=kgCvPTc2gWzZLZ/W3C/p978Gvz
        kwTNNL54PSh0zC4iDabTpndrGkWpxDCFR1YpR+GVDKNE8zCQZ/w355zeR/cP6OAckYMoa1tIvwn9Q
        3f+IFocaihqh8rFSBT59ujcsexetpCJjs/OpXpV71tBdR4+04zewqKLSFg4gGePfKrWU=;
Received: from p4ff134da.dip0.t-ipconnect.de ([79.241.52.218] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1kMaK5-0002oU-MH
        for linux-wireless@vger.kernel.org; Sun, 27 Sep 2020 19:18:53 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/8] mt76: mt7915: add encap offload for 4-address mode stations
Date:   Sun, 27 Sep 2020 19:18:46 +0200
Message-Id: <20200927171852.48669-2-nbd@nbd.name>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200927171852.48669-1-nbd@nbd.name>
References: <20200927171852.48669-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable MWDS mode in firmware as well and fix txp->rept_wds_wcid for wcid >= 255

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  7 ++-
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  4 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 19 ++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 47 ++++++++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/mcu.h   |  2 +
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 ++
 7 files changed, 78 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 6bb162a2cdd3..b8765548e3a4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -185,6 +185,7 @@ struct mt76_queue_ops {
 enum mt76_wcid_flags {
 	MT_WCID_FLAG_CHECK_PS,
 	MT_WCID_FLAG_PS,
+	MT_WCID_FLAG_4ADDR,
 };
 
 #define MT76_N_WCIDS 288
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index c62fc1cd57b3..44a5b4f8e43c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -799,7 +799,7 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	tx_info->buf[1].skip_unmap = true;
 	tx_info->nbuf = MT_CT_DMA_BUF_NUM;
 
-	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+	txp->flags = cpu_to_le16(MT_CT_INFO_APPLY_TXD | MT_CT_INFO_FROM_HOST);
 
 	if (!key)
 		txp->flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
@@ -824,7 +824,10 @@ int mt7915_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	txp->token = cpu_to_le16(id);
-	txp->rept_wds_wcid = 0xff;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags))
+		txp->rept_wds_wcid = cpu_to_le16(wcid->idx);
+	else
+		txp->rept_wds_wcid = cpu_to_le16(0x3ff);
 	tx_info->skb = DMA_DUMMY_DATA;
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index c718c70aea94..456bb81790f5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -160,6 +160,7 @@ enum tx_mcu_port_q_idx {
 #define MT_CT_INFO_MGMT_FRAME		BIT(2)
 #define MT_CT_INFO_NONE_CIPHER_FRAME	BIT(3)
 #define MT_CT_INFO_HSR2_TX		BIT(4)
+#define MT_CT_INFO_FROM_HOST		BIT(7)
 
 #define MT_TXD_SIZE			(8 * 4)
 
@@ -255,8 +256,7 @@ struct mt7915_txp {
 	__le16 flags;
 	__le16 token;
 	u8 bss_idx;
-	u8 rept_wds_wcid;
-	u8 rsv;
+	__le16 rept_wds_wcid;
 	u8 nbuf;
 	__le32 buf[MT_TXP_MAX_BUF_NUM];
 	__le16 len[MT_TXP_MAX_BUF_NUM];
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 4cbeffeabbe1..58c2cd80140c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -173,6 +173,8 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 		mtxq->wcid = &mvif->sta.wcid;
 	}
 
+	vif->offload_flags |= IEEE80211_OFFLOAD_ENCAP_4ADDR;
+
 out:
 	mutex_unlock(&dev->mt76.mutex);
 
@@ -804,6 +806,22 @@ mt7915_sta_rc_update(struct ieee80211_hw *hw,
 	ieee80211_queue_work(hw, &dev->rc_work);
 }
 
+static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
+				 struct ieee80211_vif *vif,
+				 struct ieee80211_sta *sta,
+				 bool enabled)
+{
+	struct mt7915_dev *dev = mt7915_hw_dev(hw);
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+
+	if (enabled)
+		set_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+	else
+		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
+
+	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
+}
+
 const struct ieee80211_ops mt7915_ops = {
 	.tx = mt7915_tx,
 	.start = mt7915_start,
@@ -835,6 +853,7 @@ const struct ieee80211_ops mt7915_ops = {
 	.set_antenna = mt7915_set_antenna,
 	.set_coverage_class = mt7915_set_coverage_class,
 	.sta_statistics = mt7915_sta_statistics,
+	.sta_set_4addr = mt7915_sta_set_4addr,
 #ifdef CONFIG_MAC80211_DEBUGFS
 	.sta_add_debugfs = mt7915_sta_add_debugfs,
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 18dc3f5f1153..ffb774fc699f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -276,7 +276,10 @@ static int __mt7915_mcu_msg_send(struct mt7915_dev *dev, struct sk_buff *skb,
 			mcu_txd->set_query = MCU_Q_SET;
 	}
 
-	mcu_txd->s2d_index = MCU_S2D_H2N;
+	if (cmd == MCU_EXT_CMD_MWDS_SUPPORT)
+		mcu_txd->s2d_index = MCU_S2D_H2C;
+	else
+		mcu_txd->s2d_index = MCU_S2D_H2N;
 	WARN_ON(cmd == MCU_EXT_CMD_EFUSE_ACCESS &&
 		mcu_txd->set_query != MCU_Q_QUERY);
 
@@ -1693,6 +1696,7 @@ mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta,
 			      void *sta_wtbl, void *wtbl_tlv)
 {
+	struct mt7915_sta *msta;
 	struct wtbl_hdr_trans *htr = NULL;
 	struct tlv *tlv;
 
@@ -1704,6 +1708,33 @@ mt7915_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		htr->to_ds = true;
 	else
 		htr->from_ds = true;
+
+	if (!sta)
+		return;
+
+	msta = (struct mt7915_sta *)sta->drv_priv;
+	if (test_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
+}
+
+int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta)
+{
+	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb;
+
+	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL, MT7915_WTBL_UPDATE_MAX_SIZE);
+	if (!skb)
+		return -ENOMEM;
+
+	wtbl_hdr = mt7915_mcu_alloc_wtbl_req(dev, msta, WTBL_SET, NULL, &skb);
+	mt7915_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+
+	return __mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE, true);
 }
 
 int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
@@ -2867,6 +2898,19 @@ int mt7915_mcu_fw_dbg_ctrl(struct mt7915_dev *dev, u32 module, u8 level)
 				   &data, sizeof(data), false);
 }
 
+static int mt7915_mcu_set_mwds(struct mt7915_dev *dev, bool enabled)
+{
+	struct {
+		u8 enable;
+		u8 _rsv[3];
+	} __packed req = {
+		.enable = enabled
+	};
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_EXT_CMD_MWDS_SUPPORT,
+				   &req, sizeof(req), false);
+}
+
 int mt7915_mcu_init(struct mt7915_dev *dev)
 {
 	static const struct mt76_mcu_ops mt7915_mcu_ops = {
@@ -2889,6 +2933,7 @@ int mt7915_mcu_init(struct mt7915_dev *dev)
 
 	set_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	mt7915_mcu_fw_log_2_host(dev, 0);
+	mt7915_mcu_set_mwds(dev, 1);
 
 	return 0;
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
index 7c4b4d6ad918..109647eea01d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.h
@@ -201,6 +201,7 @@ enum {
 	MCU_EXT_CMD_EDCA_UPDATE = 0x27,
 	MCU_EXT_CMD_DEV_INFO_UPDATE = 0x2A,
 	MCU_EXT_CMD_THERMAL_CTRL = 0x2c,
+	MCU_EXT_CMD_WTBL_UPDATE = 0x32,
 	MCU_EXT_CMD_SET_DRR_CTRL = 0x36,
 	MCU_EXT_CMD_SET_RDD_CTRL = 0x3a,
 	MCU_EXT_CMD_PROTECT_CTRL = 0x3e,
@@ -208,6 +209,7 @@ enum {
 	MCU_EXT_CMD_RX_HDR_TRANS = 0x47,
 	MCU_EXT_CMD_SET_RX_PATH = 0x4e,
 	MCU_EXT_CMD_TX_POWER_FEATURE_CTRL = 0x58,
+	MCU_EXT_CMD_MWDS_SUPPORT = 0x80,
 	MCU_EXT_CMD_SET_SER_TRIGGER = 0x81,
 	MCU_EXT_CMD_SCS_CTRL = 0x82,
 	MCU_EXT_CMD_RATE_CTRL = 0x87,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ee419dd515ab..0ed439ecf787 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -289,6 +289,9 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable);
 int mt7915_mcu_add_sta_adv(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, bool enable);
+int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
+				    struct ieee80211_vif *vif,
+				    struct ieee80211_sta *sta);
 int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
-- 
2.28.0

