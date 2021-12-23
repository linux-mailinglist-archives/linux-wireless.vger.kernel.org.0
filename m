Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3047E2EF
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Dec 2021 13:08:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348128AbhLWMIW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Dec 2021 07:08:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348129AbhLWMIU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Dec 2021 07:08:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76835C061401
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 04:08:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 415E5B81E21
        for <linux-wireless@vger.kernel.org>; Thu, 23 Dec 2021 12:08:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07F18C36AE5;
        Thu, 23 Dec 2021 12:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640261298;
        bh=NUWI8QgcWNwp8D6a+zBqLC1HS9iNGjD+40XlDHl2gC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xsl/brraAjl64RS0L+VBXX7h96TqQlD2yJBRvRtdrWc8UmorWNgmPtjvD5EiH+3vn
         UtxT2HOccAloXPASclld91AJQ/05twgao+HtRJgUfQG4qTSj4xPwLyFjIQ4kAu7set
         W77SxMM+lCuQ9K5A676gzyr0+Q6XGZKk3AtjUlOajJAkTUPhFOg2ZT0xkIJybBVeSV
         BCQHttadZbQs3+cookymD/N06zsr6R4DXlSYoXtsEdsQkn0THnfp5cJ5LT/buUODOB
         usyWyRAekwdXBkSTV1Pa4dLvRFlrAEN1QYmByQWuwLP5bF+q3n1BfVthoENg65kfzT
         QccUNSaGfcosQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com
Subject: [PATCH 10/15] mt76: mt7915: rely on mt76_connac_mcu_sta_uapsd
Date:   Thu, 23 Dec 2021 13:07:38 +0100
Message-Id: <c038c4e51749a0046a57ef32d8b8851c6b096cec.1640260901.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640260901.git.lorenzo@kernel.org>
References: <cover.1640260901.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76_connac_mcu_sta_uapsd routine in mt7915 and remove
duplicated code.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  |  6 ++--
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  2 ++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 34 +------------------
 3 files changed, 6 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index b25f4ab44ad6..bf2f1ff01e4a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -418,9 +418,8 @@ void mt76_connac_mcu_sta_basic_tlv(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_basic_tlv);
 
-static void
-mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta)
+void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta)
 {
 	struct sta_rec_uapsd *uapsd;
 	struct tlv *tlv;
@@ -449,6 +448,7 @@ mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 	}
 	uapsd->max_sp = sta->max_sp;
 }
+EXPORT_SYMBOL_GPL(mt76_connac_mcu_sta_uapsd);
 
 void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index f3c809a3ddb9..8d1be17886af 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1601,4 +1601,6 @@ int mt76_connac_mcu_bss_basic_tlv(struct sk_buff *skb,
 				  struct ieee80211_sta *sta,
 				  struct mt76_phy *phy, u8 wlan_idx,
 				  bool enable);
+void mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta);
 #endif /* __MT76_CONNAC_MCU_H */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index fc1602105dfc..dcaff00b2a04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -912,38 +912,6 @@ mt7915_mcu_sta_he_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 	he->pkt_ext = 2;
 }
 
-static void
-mt7915_mcu_sta_uapsd_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
-		     struct ieee80211_vif *vif)
-{
-	struct sta_rec_uapsd *uapsd;
-	struct tlv *tlv;
-
-	if (vif->type != NL80211_IFTYPE_AP || !sta->wme)
-		return;
-
-	tlv = mt76_connac_mcu_add_tlv(skb, STA_REC_APPS, sizeof(*uapsd));
-	uapsd = (struct sta_rec_uapsd *)tlv;
-
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VO) {
-		uapsd->dac_map |= BIT(3);
-		uapsd->tac_map |= BIT(3);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_VI) {
-		uapsd->dac_map |= BIT(2);
-		uapsd->tac_map |= BIT(2);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BE) {
-		uapsd->dac_map |= BIT(1);
-		uapsd->tac_map |= BIT(1);
-	}
-	if (sta->uapsd_queues & IEEE80211_WMM_IE_STA_QOSINFO_AC_BK) {
-		uapsd->dac_map |= BIT(0);
-		uapsd->tac_map |= BIT(0);
-	}
-	uapsd->max_sp = sta->max_sp;
-}
-
 static void
 mt7915_mcu_sta_muru_tlv(struct sk_buff *skb, struct ieee80211_sta *sta,
 			struct ieee80211_vif *vif)
@@ -1829,7 +1797,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		/* starec vht */
 		mt7915_mcu_sta_vht_tlv(skb, sta);
 		/* starec uapsd */
-		mt7915_mcu_sta_uapsd_tlv(skb, sta, vif);
+		mt76_connac_mcu_sta_uapsd(skb, vif, sta);
 	}
 
 	ret = mt7915_mcu_sta_wtbl_tlv(dev, skb, vif, sta);
-- 
2.33.1

