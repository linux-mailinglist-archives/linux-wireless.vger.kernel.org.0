Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10C9847E2F2
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348130AbhLWMI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348135AbhLWMIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:25 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34B9BC061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:25 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C947761E2E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AC96C36AE5;
        Thu, 23 Dec 2021 12:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261304;
        bh=BxJyuOf3ujCSYuYZqpSF6jGVcQ95Ar17PVxUM520kc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QPTK9XgS5KDD1hg3hx43kmqdFUWPs3tsMVjeQk/RJ1Gc4egyRmmC2jruHY1u+B19y
         qCW8IfT0Lz5TcOIo49qJ8fax00Vu9yTbdtKRUb3dh3qo82oZw5I+ebno2A74K5Ie9Z
         4JVrMCHz90aJq0e1PT/rIiw2DYFEkihF18oZMyrb5EvhgIjshUenV6bj2HsvM3ytp4
         /+gJ+sQMDQCy83U4apFmRwP8DLJf78WpTmam4d9xQ0wHsMNOsV9oxMcFxEUyLPPk9X
         WBePrXmNDcCFQGG3NGJapVTigyn/00bUXxhkHjsVoQQy4AkTQHsG5azUEOXzkUo3o0
         +K8bgNN9wd2ZQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 14/15] mt76: connac: move mt76_connac_mcu_wtbl_update_hdr_trans in connac module
Date:   Thu, 23 Dec 2021 13:07:42 +0100
Message-Id: <c5114427f62bc4050738dc4639d8130d6f95e9ff.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_connac_mcu_wtbl_update_hdr_trans routine in mt76-connac module
since it is shared between mt7915 and mt7615 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 14 +----------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 19 +++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +++
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  4 ++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 24 -------------------
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  3 ---
 6 files changed, 25 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 2bb8eb804883..31f40e5ead10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -945,19 +945,7 @@ mt7615_mcu_wtbl_update_hdr_trans(struct mt7615_dev *dev,
 				 struct ieee80211_vif *vif,
 				 struct ieee80211_sta *sta)
 {
-	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct sk_buff *skb = NULL;
-
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
-						  WTBL_SET, NULL, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
-					   wtbl_hdr);
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(WTBL_UPDATE), true);
+	return mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
 static const struct mt7615_mcu_ops wtbl_update_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 425414d803f4..33ea01486035 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -507,6 +507,25 @@ int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_update_hdr_trans);
 
+int mt76_connac_mcu_wtbl_update_hdr_trans(struct mt76_dev *dev,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta)
+{
+	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
+	struct wtbl_req_hdr *wtbl_hdr;
+	struct sk_buff *skb = NULL;
+
+	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(dev, wcid, WTBL_SET, NULL,
+						  &skb);
+	if (IS_ERR(wtbl_hdr))
+		return PTR_ERR(wtbl_hdr);
+
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, wcid, NULL, wtbl_hdr);
+
+	return mt76_mcu_skb_send_msg(dev, skb, MCU_EXT_CMD(WTBL_UPDATE), true);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_update_hdr_trans);
+
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev,
 				      struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 3b642be4d101..2c41d81c230e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1512,6 +1512,9 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 					 struct ieee80211_vif *vif,
 					 struct mt76_wcid *wcid, int cmd);
+int mt76_connac_mcu_wtbl_update_hdr_trans(struct mt76_dev *dev,
+					  struct ieee80211_vif *vif,
+					  struct ieee80211_sta *sta);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
 			     struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 1f6c09b34536..a6553a8298c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1093,7 +1093,7 @@ static void mt7915_sta_set_4addr(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_4ADDR, &msta->wcid.flags);
 
-	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
+	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
 static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
@@ -1109,7 +1109,7 @@ static void mt7915_sta_set_decap_offload(struct ieee80211_hw *hw,
 	else
 		clear_bit(MT_WCID_FLAG_HDR_TRANS, &msta->wcid.flags);
 
-	mt7915_mcu_sta_update_hdr_trans(dev, vif, sta);
+	mt76_connac_mcu_wtbl_update_hdr_trans(&dev->mt76, vif, sta);
 }
 
 static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 95e80c45607d..06458384f62e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1052,30 +1052,6 @@ mt7915_mcu_sta_wtbl_tlv(struct mt7915_dev *dev, struct sk_buff *skb,
 	return 0;
 }
 
-int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta)
-{
-	struct mt7915_sta *msta = (struct mt7915_sta *)sta->drv_priv;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct sk_buff *skb;
-
-	skb = mt76_mcu_msg_alloc(&dev->mt76, NULL,
-				 MT76_CONNAC_WTBL_UPDATE_MAX_SIZE);
-	if (!skb)
-		return -ENOMEM;
-
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
-						  WTBL_SET, NULL, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
-					   wtbl_hdr);
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD(WTBL_UPDATE),
-				     true);
-}
-
 static inline bool
 mt7915_is_ebf_supported(struct mt7915_phy *phy, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, bool bfee)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index fe1c7a41ca79..3be14a6a0604 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -407,9 +407,6 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 			    struct ieee80211_vif *vif, int enable);
 int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, bool enable);
-int mt7915_mcu_sta_update_hdr_trans(struct mt7915_dev *dev,
-				    struct ieee80211_vif *vif,
-				    struct ieee80211_sta *sta);
 int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool add);
-- 
2.33.1

