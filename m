Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6FD47E2EE
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348121AbhLWMIV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:21 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39518 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348123AbhLWMIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:20 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3414E61E2E
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A238C36AEA;
        Thu, 23 Dec 2021 12:08:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261299;
        bh=zUA29Zfj0+peSQnkULpoH4LXGaZzFk+o+hittqjeDlQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgdqvsOpAeEowLZy4HbD5kjFRwgAHpdHlqeC/FsP8wjPErnfpw3+xCo6Sm6R+yLDZ
         /MsIRvhGB++WzUpbexH8vRFysFPM2nBfX7Pc/VIPM6IOmmQ2XeCsg036bn8DfFp+PH
         PNhM273A6CCGEQBM848sLkv8l7N7tr9oRvmASrvg4OvnRLeH80ndCVXMYjq5qb4MyG
         z8P8sFH+QSdccyNK7zhXx37uWqC697DH+g3UCCygB9UB9H+5NR/JCXzZ9tzRzs10av
         d9EdI3XSDmhYEaOjPOQ5AK4ot9ks6py+7X8Y8RS+z11MPZKkb7qdwyjpVtCyYypAc7
         hMoF9edWsg2ng==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 11/15] mt76: mt7915: rely on mt76_connac_mcu_wtbl_smps_tlv
Date:   Thu, 23 Dec 2021 13:07:39 +0100
Message-Id: <32f11040634e08dc537f7658a92baeeb2727d1a3.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_wtbl_smps_tlv routine in mt7915
and remove duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c    | 11 +++++------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h    |  3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c | 17 ++---------------
 3 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index bf2f1ff01e4a..769b3da486cc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -861,9 +861,9 @@ void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_tlv);
 
-static void
-mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			      void *sta_wtbl, void *wtbl_tlv)
+void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
+				   struct ieee80211_sta *sta,
+				   void *sta_wtbl, void *wtbl_tlv)
 {
 	struct wtbl_smps *smps;
 	struct tlv *tlv;
@@ -871,10 +871,9 @@ mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
 					     wtbl_tlv, sta_wtbl);
 	smps = (struct wtbl_smps *)tlv;
-
-	if (sta->smps_mode == IEEE80211_SMPS_DYNAMIC)
-		smps->smps = true;
+	smps->smps = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_smps_tlv);
 
 void mt76_connac_mcu_wtbl_ht_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				 struct ieee80211_sta *sta, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8d1be17886af..68754f4aa1bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1603,4 +1603,7 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 				  bool enable);
 void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta);
+void mt76_connac_mcu_wtbl_smps_tlv(struct sk_buff *skb,
+				   struct ieee80211_sta *sta,
+				   void *sta_wtbl, void *wtbl_tlv);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index dcaff00b2a04..9794a0383748 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1022,19 +1022,6 @@ mt7915_mcu_sta_amsdu_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	msta->wcid.amsdu = true;
 }
 
-static void
-mt7915_mcu_wtbl_smps_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-			 void *sta_wtbl, void *wtbl_tlv)
-{
-	struct wtbl_smps *smps;
-	struct tlv *tlv;
-
-	tlv = mt76_connac_mcu_add_nested_tlv(skb, WTBL_SMPS, sizeof(*smps),
-					     wtbl_tlv, sta_wtbl);
-	smps = (struct wtbl_smps *)tlv;
-	smps->smps = (sta->smps_mode == IEEE80211_SMPS_DYNAMIC);
-}
-
 static void
 mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta, void *sta_wtbl,
@@ -1075,7 +1062,7 @@ mt7915_mcu_wtbl_ht_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 			ht->af = max_t(u8, ht->af, af);
 	}
 
-	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
+	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_tlv);
 }
 
 static void
@@ -1509,7 +1496,7 @@ int mt7915_mcu_add_smps(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt7915_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
+	mt76_connac_mcu_wtbl_smps_tlv(skb, sta, sta_wtbl, wtbl_hdr);
 
 	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				    MCU_EXT_CMD(STA_REC_UPDATE), true);
-- 
2.33.1

