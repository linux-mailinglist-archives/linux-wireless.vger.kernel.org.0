Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4B847E2EB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239577AbhLWMIR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348119AbhLWMIQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:16 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D2E7C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BD85EB81F6D
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BEDC36AE5;
        Thu, 23 Dec 2021 12:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261293;
        bh=C538nIjQqSQO5qe3AOFcYJvRMgcsmEyS2++CN27y8yE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRYGkG1bxbfCIjUiUN87AKDjdOSsFZgkrAkWAKjrqBJPjYCKYbVFABO9hWDgQiNYr
         55M+SjdQh8PJvvxkksL050uqRB2hLchL8pCZ8szFY3R57iOcpnja8nzr3ML6wvpjxm
         QBIntsrHJnw8T6ztxif998+UDcyclvAqKGJaW62mCwIxqIOMoU86fDJIZ5e9INJIyd
         +UZB4QXIx8ezgG0iQleN4RsNClehkVGS6w/ZBJctR0u3LBpLT6IqQmszf8SoRN0Ydb
         kg1qRrxm4u3IFggaVxb/wDxe41L20urkQcA0++QKb1ZuIixoiiM14sZ6jGcFOgSMbV
         ENxVF4+jw+mdA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 07/15] mt76: mt7915: rely on mt76_connac_mcu_sta_ba
Date:   Thu, 23 Dec 2021 13:07:35 +0100
Message-Id: <85bed04a0c3899f65fdb8231c7c0376bdf145501.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_sta_ba routine in mt7915 and remove duplicated
code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   |  3 +-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  8 +--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 +-
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 58 +++++--------------
 .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  2 +
 5 files changed, 21 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3bec99f08009..45c16f5f39a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1191,7 +1191,8 @@ mt7615_mcu_uni_tx_ba(struct mt7615_dev *dev,
 	struct mt7615_sta *sta = (struct mt7615_sta *)params->sta->drv_priv;
 
 	return mt76_connac_mcu_sta_ba(&dev->mt76, &sta->vif->mt76, params,
-				      enable, true);
+				      MCU_UNI_CMD(STA_REC_UPDATE), enable,
+				      true);
 }
 
 static int
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 1b56c2956d29..14bfbbb3114e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1148,7 +1148,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba_tlv);
 
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 			   struct ieee80211_ampdu_params *params,
-			   bool enable, bool tx)
+			   int cmd, bool enable, bool tx)
 {
 	struct mt76_wcid *wcid = (struct mt76_wcid *)params->sta->drv_priv;
 	struct wtbl_req_hdr *wtbl_hdr;
@@ -1171,8 +1171,7 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 	mt76_connac_mcu_wtbl_ba_tlv(dev, skb, params, enable, tx, sta_wtbl,
 				    wtbl_hdr);
 
-	ret = mt76_mcu_skb_send_msg(dev, skb,
-				    MCU_UNI_CMD(STA_REC_UPDATE), true);
+	ret = mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 	if (ret)
 		return ret;
 
@@ -1182,8 +1181,7 @@ int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 
 	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
 
-	return mt76_mcu_skb_send_msg(dev, skb,
-				     MCU_UNI_CMD(STA_REC_UPDATE), true);
+	return mt76_mcu_skb_send_msg(dev, skb, cmd, true);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_ba);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index ccae578922f6..f3c809a3ddb9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1532,7 +1532,7 @@ int mt76_connac_mcu_uni_add_dev(struct mt76_phy *phy,
 				bool enable);
 int mt76_connac_mcu_sta_ba(struct mt76_dev *dev, struct mt76_vif *mvif,
 			   struct ieee80211_ampdu_params *params,
-			   bool enable, bool tx);
+			   int cmd, bool enable, bool tx);
 int mt76_connac_mcu_uni_add_bss(struct mt76_phy *phy,
 				struct ieee80211_vif *vif,
 				struct mt76_wcid *wcid,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index f56fc4c82fe6..ef81b3ff48f9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -742,63 +742,31 @@ int mt7915_mcu_add_bss_info(struct mt7915_phy *phy,
 }
 
 /** starec & wtbl **/
-static int
-mt7915_mcu_sta_ba(struct mt7915_dev *dev,
-		  struct ieee80211_ampdu_params *params,
-		  bool enable, bool tx)
+int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
+			 struct ieee80211_ampdu_params *params,
+			 bool enable)
 {
 	struct mt7915_sta *msta = (struct mt7915_sta *)params->sta->drv_priv;
 	struct mt7915_vif *mvif = msta->vif;
-	struct wtbl_req_hdr *wtbl_hdr;
-	struct tlv *sta_wtbl;
-	struct sk_buff *skb;
-	int ret;
 
-	if (enable && tx && !params->amsdu)
+	if (enable && !params->amsdu)
 		msta->wcid.amsdu = false;
 
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	sta_wtbl = mt76_connac_mcu_add_tlv(skb, STA_REC_WTBL,
-					   sizeof(struct tlv));
-	wtbl_hdr = mt76_connac_mcu_alloc_wtbl_req(&dev->mt76, &msta->wcid,
-						  WTBL_SET, sta_wtbl, &skb);
-	if (IS_ERR(wtbl_hdr))
-		return PTR_ERR(wtbl_hdr);
-
-	mt76_connac_mcu_wtbl_ba_tlv(&dev->mt76, skb, params, enable, tx,
-				    sta_wtbl, wtbl_hdr);
-	ret = mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				    MCU_EXT_CMD(STA_REC_UPDATE), true);
-	if (ret)
-		return ret;
-
-	skb = mt76_connac_mcu_alloc_sta_req(&dev->mt76, &mvif->mt76,
-					    &msta->wcid);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	mt76_connac_mcu_sta_ba_tlv(skb, params, enable, tx);
-
-	return mt76_mcu_skb_send_msg(&dev->mt76, skb,
-				     MCU_EXT_CMD(STA_REC_UPDATE), true);
-}
-
-int mt7915_mcu_add_tx_ba(struct mt7915_dev *dev,
-			 struct ieee80211_ampdu_params *params,
-			 bool enable)
-{
-	return mt7915_mcu_sta_ba(dev, params, enable, true);
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				      MCU_EXT_CMD(STA_REC_UPDATE),
+				      enable, true);
 }
 
 int mt7915_mcu_add_rx_ba(struct mt7915_dev *dev,
 			 struct ieee80211_ampdu_params *params,
 			 bool enable)
 {
-	return mt7915_mcu_sta_ba(dev, params, enable, false);
+	struct mt7915_sta *msta = (struct mt7915_sta *)params->sta->drv_priv;
+	struct mt7915_vif *mvif = msta->vif;
+
+	return mt76_connac_mcu_sta_ba(&dev->mt76, &mvif->mt76, params,
+				      MCU_EXT_CMD(STA_REC_UPDATE),
+				      enable, false);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index d014e574ce6a..b0022713c469 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -429,6 +429,7 @@ int mt7921_mcu_uni_tx_ba(struct mt7921_dev *dev,
 		msta->wcid.amsdu = false;
 
 	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
 				      enable, true);
 }
 
@@ -439,6 +440,7 @@ int mt7921_mcu_uni_rx_ba(struct mt7921_dev *dev,
 	struct mt7921_sta *msta = (struct mt7921_sta *)params->sta->drv_priv;
 
 	return mt76_connac_mcu_sta_ba(&dev->mt76, &msta->vif->mt76, params,
+				      MCU_UNI_CMD(STA_REC_UPDATE),
 				      enable, false);
 }
 
-- 
2.33.1

