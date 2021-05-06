Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D9C38375A01
	for <lists+linux-wireless@lfdr.de>; Thu,  6 May 2021 20:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbhEFSOu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 6 May 2021 14:14:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:59966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231585AbhEFSOr (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 6 May 2021 14:14:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9F2F161157;
        Thu,  6 May 2021 18:13:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620324828;
        bh=/2ChN45EG6OC1YnpxIs4gH6r4dcQvf8t+Ki9txeLYw0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Y4p95vnFtNyTcNl2I/BOcGseOijd2wvBCo3cYQnH92DNiLSnXnCJWIYvnu3eJC9QE
         gMSKIhDbdw9/fOXOSkvOVAqw5fI12fAgZA7NUTgEMQ3TYV9qzemYgek+4whv7E8qE0
         qIIzgTWoC5am/lpRWPnm2iquNa5YXyjcgeEbJzN95Z+Ci9Y9meUoZOQdpWhCaOO9hb
         n0NTp3ft5fAsQ3Jm10EbZbCfN1FxTGCSV2awJDg23gS5RAUu2L2Bnhp9a1YDui/bsM
         n7hK/JUo1FwP7YuofdK3A8+wmgOvAlj+yGCuDublWMU67A8RtjB+hULb7u6XM40fEb
         xYaVpLhevwA8Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 2/4] mt76: connac: add missing configuration in mt76_connac_mcu_wtbl_hdr_trans_tlv
Date:   Thu,  6 May 2021 20:13:33 +0200
Message-Id: <a968f7061e4936d619e5906f3f6eb2d6baee95b2.1620322988.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1620322988.git.lorenzo@kernel.org>
References: <cover.1620322988.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing configuration parameters in mt76_connac_mcu_wtbl_hdr_trans_tlv
routine

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  8 ++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  1 +
 3 files changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3c1528ed2110..359d5bd8ed60 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1037,8 +1037,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		if (sta)
 			mt76_connac_mcu_wtbl_ht_tlv(&dev->mt76, wskb, sta,
 						    NULL, wtbl_hdr);
-		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, &msta->wcid, NULL,
-						   wtbl_hdr);
+		mt76_connac_mcu_wtbl_hdr_trans_tlv(wskb, vif, &msta->wcid,
+						   NULL, wtbl_hdr);
 	}
 
 	cmd = enable ? MCU_EXT_CMD_WTBL_UPDATE : MCU_EXT_CMD_STA_REC_UPDATE;
@@ -1167,8 +1167,8 @@ int mt7615_mcu_sta_update_hdr_trans(struct mt7615_dev *dev,
 	if (IS_ERR(wtbl_hdr))
 		return PTR_ERR(wtbl_hdr);
 
-	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, &msta->wcid, NULL, wtbl_hdr);
-
+	mt76_connac_mcu_wtbl_hdr_trans_tlv(skb, vif, &msta->wcid, NULL,
+					   wtbl_hdr);
 	return mt76_mcu_skb_send_msg(&dev->mt76, skb, MCU_EXT_CMD_WTBL_UPDATE,
 				     true);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index fe0ab5e5ff81..95dcd43c2cf9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -393,6 +393,7 @@ mt76_connac_mcu_sta_uapsd(struct sk_buff *skb, struct ieee80211_vif *vif,
 }
 
 void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
+					struct ieee80211_vif *vif,
 					struct mt76_wcid *wcid,
 					void *sta_wtbl, void *wtbl_tlv)
 {
@@ -404,6 +405,16 @@ void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
 					     wtbl_tlv, sta_wtbl);
 	htr = (struct wtbl_hdr_trans *)tlv;
 	htr->no_rx_trans = !test_bit(MT_WCID_FLAG_HDR_TRANS, &wcid->flags);
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		htr->to_ds = true;
+	else
+		htr->from_ds = true;
+
+	if (test_bit(MT_WCID_FLAG_4ADDR, &wcid->flags)) {
+		htr->to_ds = true;
+		htr->from_ds = true;
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_wtbl_hdr_trans_tlv);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index a1096861d04a..f0493924fa89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -969,6 +969,7 @@ void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
 				      void *wtbl_tlv);
 void mt76_connac_mcu_wtbl_hdr_trans_tlv(struct sk_buff *skb,
+					struct ieee80211_vif *vif,
 					struct mt76_wcid *wcid,
 					void *sta_wtbl, void *wtbl_tlv);
 void mt76_connac_mcu_sta_tlv(struct mt76_phy *mphy, struct sk_buff *skb,
-- 
2.30.2

