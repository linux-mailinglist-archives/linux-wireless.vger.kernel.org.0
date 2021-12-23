Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8F68047E2E6
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348118AbhLWMIM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348109AbhLWMIK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0C45C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A61DB81E21
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47FFBC36AE9;
        Thu, 23 Dec 2021 12:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261287;
        bh=c6A4bmKN23d/hrKRLRTiDSjihWFLC2PA+braPSib9tE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cNs7Mfo5s+w0okRSPeMTv5MRrAlpZnjR9QcYJfS45hIfe/9oGtPGU+vy/UrQYdSQI
         fRonwEezi/y2O/joHj7wXx4xLyDXrmY3cKm94Q1lleVLx8xdJNpJ2nFb9e1PwlYfy+
         mM+lOJlF7ohlt6QSMgJemv5e8lGJxQnPcAI1uB+GHd6ZLoWK3ee0HoYXLXCQke4KBx
         QHiyLMHgZw+vJMyxa3e7AetZ+x0eamNlVT11HRPzosnSWh+vJURxhaMDIEsJBLYHaE
         Dzpx64RIZt9CKTLlWr0GPdO9p4KsALlTj5XmdvEcUiisc0zIqPfCeTYHlT47qUj5xt
         UloxRt+MpiWxg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 03/15] mt76: connac: move mt76_connac_mcu_bss_ext_tlv in connac module
Date:   Thu, 23 Dec 2021 13:07:31 +0100
Message-Id: <a1fe0ef03be509bd661cbe5d8bdecab6b4da353a.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7915_mcu_bss_ext_tlv/mt7615_mcu_bss_ext_tlv in connac module
since it is shared between mt7615 and mt7915 drivers.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 22 +------------------
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 20 +++++++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  1 +
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 22 +------------------
 4 files changed, 23 insertions(+), 42 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7c48bce8becc..40b8cdc29ed3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -836,26 +836,6 @@ mt7615_mcu_bss_basic_tlv(struct sk_buff *skb, struct ieee80211_vif *vif,
 	return 0;
 }
 
-/* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
-#define BCN_TX_ESTIMATE_TIME (4096 + 20)
-static void
-mt7615_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7615_vif *mvif)
-{
-	struct bss_info_ext_bss *ext;
-	int ext_bss_idx, tsf_offset;
-	struct tlv *tlv;
-
-	ext_bss_idx = mvif->mt76.omac_idx - EXT_BSSID_START;
-	if (ext_bss_idx < 0)
-		return;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
-
-	ext = (struct bss_info_ext_bss *)tlv;
-	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
-	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
-}
-
 static int
 mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta, bool enable)
@@ -878,7 +858,7 @@ mt7615_mcu_add_bss(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 
 	if (enable && mvif->mt76.omac_idx >= EXT_BSSID_START &&
 	    mvif->mt76.omac_idx < REPEATER_BSSID_START)
-		mt7615_mcu_bss_ext_tlv(skb, mvif);
+		mt76_connac_mcu_bss_ext_tlv(skb, &mvif->mt76);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
 				     MCU_EXT_CMD(BSS_INFO_UPDATE), true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 44be4e65391b..93c5e4d0ea8c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -2612,5 +2612,25 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_add_key);
 
+/* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
+#define BCN_TX_ESTIMATE_TIME (4096 + 20)
+void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif)
+{
+	struct bss_info_ext_bss *ext;
+	int ext_bss_idx, tsf_offset;
+	struct tlv *tlv;
+
+	ext_bss_idx = mvif->omac_idx - EXT_BSSID_START;
+	if (ext_bss_idx < 0)
+		return;
+
+	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
+
+	ext = (struct bss_info_ext_bss *)tlv;
+	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
+	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
+}
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_ext_tlv);
+
 MODULE_AUTHOR("Lorenzo Bianconi <lorenzo@kernel.org>");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ec37225db5fe..84ab91decdb7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1593,6 +1593,7 @@ int mt76_connac_mcu_add_key(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			    struct ieee80211_key_conf *key, int mcu_cmd,
 			    struct mt76_wcid *wcid, enum set_key_cmd cmd);
 
+void mt76_connac_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt76_vif *mvif);
 void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 				  struct ieee80211_vif *vif);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 20dc4de75ee2..32a461182cdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -704,26 +704,6 @@ mt7915_mcu_bss_hw_amsdu_tlv(struct sk_buff *skb)
 	amsdu->enable = true;
 }
 
-static void
-mt7915_mcu_bss_ext_tlv(struct sk_buff *skb, struct mt7915_vif *mvif)
-{
-/* SIFS 20us + 512 byte beacon tranmitted by 1Mbps (3906us) */
-#define BCN_TX_ESTIMATE_TIME	(4096 + 20)
-	struct bss_info_ext_bss *ext;
-	int ext_bss_idx, tsf_offset;
-	struct tlv *tlv;
-
-	ext_bss_idx = mvif->mt76.omac_idx - EXT_BSSID_START;
-	if (ext_bss_idx < 0)
-		return;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, BSS_INFO_EXT_BSS, sizeof(*ext));
-
-	ext = (struct bss_info_ext_bss *)tlv;
-	tsf_offset = ext_bss_idx * BCN_TX_ESTIMATE_TIME;
-	ext->mbss_tsf_offset = cpu_to_le32(tsf_offset);
-}
-
 static void
 mt7915_mcu_bss_bmc_tlv(struct sk_buff *skb, struct mt7915_phy *phy)
 {
@@ -818,7 +798,7 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 
 		if (mvif->mt76.omac_idx >= EXT_BSSID_START &&
 		    mvif->mt76.omac_idx < REPEATER_BSSID_START)
-			mt7915_mcu_bss_ext_tlv(skb, mvif);
+			mt76_connac_mcu_bss_ext_tlv(skb, &mvif->mt76);
 	}
 out:
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-- 
2.33.1

