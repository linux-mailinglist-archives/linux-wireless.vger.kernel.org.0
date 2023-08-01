Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B309476B799
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Aug 2023 16:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234767AbjHAOeP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Aug 2023 10:34:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbjHAOeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Aug 2023 10:34:10 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A85981FEF
        for <linux-wireless@vger.kernel.org>; Tue,  1 Aug 2023 07:34:01 -0700 (PDT)
X-UUID: 70076cf6307811ee9cb5633481061a41-20230801
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=eH9OWPWAjU+s3RPRgiIIkH34EZX+7q2g7h8oWEofK0g=;
        b=uFyQtVWyQhagB5w8TAuwobehmpwSPwozllDvcyHJrC7aSLUkjVgKTBqMmMVZhUkpepxD4Q6xDdDo9EKXuguh7rPnKLp+bmgJZxTiLbvIBsjyqoLF1C2HXe18rRzYR0bpRNLLicz4+jLoXf6cAlgdT0TGqNBX08oB8mhuMfIEtTA=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.30,REQID:9138487f-ae70-4996-90c4-d6af83ee9aa9,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.30,REQID:9138487f-ae70-4996-90c4-d6af83ee9aa9,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:1fcc6f8,CLOUDID:1dfbc5a0-0933-4333-8d4f-6c3c53ebd55b,B
        ulkID:230801223353OG07GVHK,BulkQuantity:0,Recheck:0,SF:48|38|29|28|17|19,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: 70076cf6307811ee9cb5633481061a41-20230801
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 509439661; Tue, 01 Aug 2023 22:33:52 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 MTKMBS14N1.mediatek.inc (172.21.101.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 1 Aug 2023 22:33:51 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Tue, 1 Aug 2023 22:33:51 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 3/8] wifi: mt76: connac: export functions for mt7925
Date:   Tue, 1 Aug 2023 22:30:27 +0800
Message-ID: <5cf4d8dcdd43892474ffc02a07859475c81bf367.1690863143.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1690863143.git.deren.wu@mediatek.com>
References: <cover.1690863143.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7925 rely on the similar functionalities in connac layer.
Export them for mt7925 reuse.

This is a preliminary patch to support mt7925 driver.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 19 ++++++++++++-------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  | 12 ++++++++++++
 2 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 21456692e790..dfbe31ae4b14 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -746,7 +746,7 @@ mt76_connac_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta)
 	he->pkt_ext = 2;
 }
 
-static void
+void
 mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta)
 {
 	struct ieee80211_sta_he_cap *he_cap = &sta->deflink.he_cap;
@@ -778,6 +778,7 @@ mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta)
 
 	he->pkt_ext = IEEE80211_HE_PHY_CAP9_NOMINAL_PKT_PADDING_16US;
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_he_tlv_v2);
 
 static u8
 mt76_connac_get_phy_mode_v2(struct mt76_phy *mphy, struct ieee80211_vif *vif,
@@ -2088,9 +2089,9 @@ mt76_connac_mcu_build_sku(struct mt76_dev *dev, s8 *sku,
 	}
 }
 
-static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
-				   struct ieee80211_channel *chan,
-				   s8 target_power)
+s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
+			    struct ieee80211_channel *chan,
+			    s8 target_power)
 {
 	struct mt76_dev *dev = phy->dev;
 	struct ieee80211_supported_band *sband;
@@ -2127,6 +2128,7 @@ static s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
 
 	return target_power;
 }
+EXPORT_SYMBOL_GPL(mt76_connac_get_ch_power);
 
 static int
 mt76_connac_mcu_rate_txpower_band(struct mt76_phy *phy,
@@ -2458,7 +2460,7 @@ mt76_connac_mcu_set_arp_filter(struct mt76_dev *dev, struct ieee80211_vif *vif,
 				 sizeof(req), true);
 }
 
-static int
+int
 mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			      bool suspend)
 {
@@ -2483,8 +2485,9 @@ mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(OFFLOAD), &req,
 				 sizeof(req), true);
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_gtk_rekey);
 
-static int
+int
 mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
 				 struct ieee80211_vif *vif,
 				 bool enable, u8 mdtim,
@@ -2513,6 +2516,7 @@ mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
 	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
 				 sizeof(req), true);
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_suspend_mode);
 
 static int
 mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
@@ -2548,7 +2552,7 @@ mt76_connac_mcu_set_wow_pattern(struct mt76_dev *dev,
 	return mt76_mcu_skb_send_msg(dev, skb, MCU_UNI_CMD(SUSPEND), true);
 }
 
-static int
+int
 mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 			     bool suspend, struct cfg80211_wowlan *wowlan)
 {
@@ -2600,6 +2604,7 @@ mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	return mt76_mcu_send_msg(dev, MCU_UNI_CMD(SUSPEND), &req,
 				 sizeof(req), true);
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_wow_ctrl);
 
 int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 19be8556cd3c..879a66564c54 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1807,6 +1807,7 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 int mt76_connac_mcu_sta_update_hdr_trans(struct mt76_dev *dev,
 					 struct ieee80211_vif *vif,
 					 struct mt76_wcid *wcid, int cmd);
+void mt76_connac_mcu_sta_he_tlv_v2(struct sk_buff *skb, struct ieee80211_sta *sta);
 int mt76_connac_mcu_wtbl_update_hdr_trans(struct mt76_dev *dev,
 					  struct ieee80211_vif *vif,
 					  struct ieee80211_sta *sta);
@@ -1866,9 +1867,17 @@ int mt76_connac_mcu_sched_scan_enable(struct mt76_phy *phy,
 int mt76_connac_mcu_update_arp_filter(struct mt76_dev *dev,
 				      struct mt76_vif *vif,
 				      struct ieee80211_bss_conf *info);
+int mt76_connac_mcu_set_gtk_rekey(struct mt76_dev *dev, struct ieee80211_vif *vif,
+				  bool suspend);
+int mt76_connac_mcu_set_wow_ctrl(struct mt76_phy *phy, struct ieee80211_vif *vif,
+				 bool suspend, struct cfg80211_wowlan *wowlan);
 int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct cfg80211_gtk_rekey_data *key);
+int mt76_connac_mcu_set_suspend_mode(struct mt76_dev *dev,
+				     struct ieee80211_vif *vif,
+				     bool enable, u8 mdtim,
+				     bool wow_suspend);
 int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
 void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
@@ -1879,6 +1888,9 @@ int mt76_connac_mcu_chip_config(struct mt76_dev *dev);
 int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable);
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump);
+s8 mt76_connac_get_ch_power(struct mt76_phy *phy,
+			    struct ieee80211_channel *chan,
+			    s8 target_power);
 int mt76_connac_mcu_set_rate_txpower(struct mt76_phy *phy);
 int mt76_connac_mcu_set_p2p_oppps(struct ieee80211_hw *hw,
 				  struct ieee80211_vif *vif);
-- 
2.18.0

