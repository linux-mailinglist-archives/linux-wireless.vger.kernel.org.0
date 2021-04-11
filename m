Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4CE35B5C2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Apr 2021 17:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235878AbhDKPDO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 11 Apr 2021 11:03:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhDKPDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 11 Apr 2021 11:03:14 -0400
Received: from nbd.name (nbd.name [IPv6:2a01:4f8:221:3d45::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C5FC061574
        for <linux-wireless@vger.kernel.org>; Sun, 11 Apr 2021 08:02:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=EVFNlqwbFUI2iwHRuS4SVBBse8+jODOsGmpvhoxHXno=; b=mSINvmO5TQHSAUYn9jJQuRTFSv
        NFFUbHoi27YbQPDNkFso1MZNAYgFzauxJiErllgxdEGseihnBiFSHmpY37YM1i7EQhzVpQMFtQq6P
        xXLzadS6ivQbWGuMAZ/E6RlOWjUJeOhavzkkSB9otf161AD23S06IjiDyGVPhVMn7U/o=;
Received: from p4ff13c8d.dip0.t-ipconnect.de ([79.241.60.141] helo=localhost.localdomain)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1lVbc0-0000R9-4d
        for linux-wireless@vger.kernel.org; Sun, 11 Apr 2021 17:02:56 +0200
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: always add rx header translation tlv when adding stations
Date:   Sun, 11 Apr 2021 17:02:54 +0200
Message-Id: <20210411150254.9348-1-nbd@nbd.name>
X-Mailer: git-send-email 2.30.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Ensures that header translation is disabled for interfaces that do not support
it.

Fixes: bb1262e7199b ("mt76: mt7615: add support for rx decapsulation offload")
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 6 +-----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h | 3 +--
 3 files changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 6ca9e9840399..9b9f8d88e9bb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1008,6 +1008,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		if (sta)
 			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
 						    NULL, wtbl_hdr);
+		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, &msta->wcid, NULL,
+						   wtbl_hdr);
 	}
 
 	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
@@ -1136,7 +1138,7 @@ int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, sta, NULL, wtbl_hdr);
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, &msta->wcid, NULL, wtbl_hdr);
 
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
 				     true);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4892728ad9bb..443ec0a8bb7d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -393,11 +393,9 @@ mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
-					struct ieee80211_vif *vif,
-					struct ieee80211_sta *sta,
+					struct mt76_wcid *wcid,
 					void *sta_wtbl, void *wtbl_tlv)
 {
-	struct mt76_wcid *wcid;
 	struct wtbl_hdr_trans *htr;
 	struct tlv *tlv;
 
@@ -405,8 +403,6 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					     sizeof(*htr),
 					     wtbl_tlv, sta_wtbl);
 	htr = (struct wtbl_hdr_trans *)tlv;
-
-	wcid = (struct mt76_wcid *)sta->drv_priv;
 	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 6f9b7807305a..587097450416 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -937,8 +937,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
 				      void *wtbl_tlv);
 void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
-					struct ieee80211_vif *vif,
-					struct ieee80211_sta *sta,
+					struct mt76_wcid *wcid,
 					void *sta_wtbl, void *wtbl_tlv);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
 			     struct ieee80211_sta *sta,
-- 
2.30.1

