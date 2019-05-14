Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7001F1C900
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2019 14:48:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbfENMsm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 May 2019 08:48:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:33968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726036AbfENMsm (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 May 2019 08:48:42 -0400
Received: from lore-desk-wlan.redhat.com (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B100520881;
        Tue, 14 May 2019 12:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557838120;
        bh=kxnE46J7d2X67fLKKEcm0ZoO+eVOET2YehxYgQRaVM8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=y9/j2wXZ57EqHJsUsmj78Uxq57Cd/kajXLqP3uGOmv7cVUINmLsaEnjGuFdvKab10
         1A/IkQiIhBa79ryYxWdpRajJkl0PRRUDW4O0zZ5eJ11JhK0DlyGlRTVX0hklI5FDtf
         6JSWbNzjDxmuk3VcHWwaLo8O9uaMmRhS0hePi0Gk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH] mt76: move mt76_insert_ccmp_hdr in mt76-module
Date:   Tue, 14 May 2019 14:48:31 +0200
Message-Id: <99370eaa04916a871b6cc2413ae00e1370e09292.1557838049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557838049.git.lorenzo@kernel.org>
References: <cover.1557838049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_insert_ccmp_hdr in mac80211.c and rename it in
mt76_insert_ccmp_hdr since it is shared between mt7603 and mt7615
drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 ++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 26 +------------------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 25 +-----------------
 4 files changed, 26 insertions(+), 49 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5b6a81ee457e..e70507a4b14d 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -820,3 +820,26 @@ mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set)
 	return 0;
 }
 EXPORT_SYMBOL_GPL(mt76_set_tim);
+
+void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id)
+{
+	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
+	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
+	u8 *hdr, *pn = status->iv;
+
+	__skb_push(skb, 8);
+	memmove(skb->data, skb->data + 8, hdr_len);
+	hdr = skb->data + hdr_len;
+
+	hdr[0] = pn[5];
+	hdr[1] = pn[4];
+	hdr[2] = 0;
+	hdr[3] = 0x20 | (key_id << 6);
+	hdr[4] = pn[3];
+	hdr[5] = pn[2];
+	hdr[6] = pn[1];
+	hdr[7] = pn[0];
+
+	status->flag &= ~RX_FLAG_IV_STRIPPED;
+}
+EXPORT_SYMBOL_GPL(mt76_insert_ccmp_hdr);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index fc4169c83e76..8edf476f9f2f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -750,6 +750,7 @@ void mt76_csa_check(struct mt76_dev *dev);
 void mt76_csa_finish(struct mt76_dev *dev);
 
 int mt76_set_tim(struct ieee80211_hw *hw, struct ieee80211_sta *sta, bool set);
+void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
 
 /* internal */
 void mt76_tx_free(struct mt76_dev *dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 0ccba5926b68..5c09b2dbf3fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -418,30 +418,6 @@ mt7603_rx_get_wcid(struct mt7603_dev *dev, u8 idx, bool unicast)
 	return &sta->vif->sta.wcid;
 }
 
-static void
-mt7603_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
-	u8 *pn = status->iv;
-	u8 *hdr;
-
-	__skb_push(skb, 8);
-	memmove(skb->data, skb->data + 8, hdr_len);
-	hdr = skb->data + hdr_len;
-
-	hdr[0] = pn[5];
-	hdr[1] = pn[4];
-	hdr[2] = 0;
-	hdr[3] = 0x20 | (key_id << 6);
-	hdr[4] = pn[3];
-	hdr[5] = pn[2];
-	hdr[6] = pn[1];
-	hdr[7] = pn[0];
-
-	status->flag &= ~RX_FLAG_IV_STRIPPED;
-}
-
 int
 mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 {
@@ -580,7 +556,7 @@ mt7603_mac_fill_rx(struct mt7603_dev *dev, struct sk_buff *skb)
 	if (insert_ccmp_hdr) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
-		mt7603_insert_ccmp_hdr(skb, key_id);
+		mt76_insert_ccmp_hdr(skb, key_id);
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index b8f48d10f27a..1d6ebea17132 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -61,29 +61,6 @@ static int mt7615_get_rate(struct mt7615_dev *dev,
 	return 0;
 }
 
-static void mt7615_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id)
-{
-	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
-	int hdr_len = ieee80211_get_hdrlen_from_skb(skb);
-	u8 *pn = status->iv;
-	u8 *hdr;
-
-	__skb_push(skb, 8);
-	memmove(skb->data, skb->data + 8, hdr_len);
-	hdr = skb->data + hdr_len;
-
-	hdr[0] = pn[5];
-	hdr[1] = pn[4];
-	hdr[2] = 0;
-	hdr[3] = 0x20 | (key_id << 6);
-	hdr[4] = pn[3];
-	hdr[5] = pn[2];
-	hdr[6] = pn[1];
-	hdr[7] = pn[0];
-
-	status->flag &= ~RX_FLAG_IV_STRIPPED;
-}
-
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 {
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
@@ -225,7 +202,7 @@ int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 	if (insert_ccmp_hdr) {
 		u8 key_id = FIELD_GET(MT_RXD1_NORMAL_KEY_ID, rxd1);
 
-		mt7615_insert_ccmp_hdr(skb, key_id);
+		mt76_insert_ccmp_hdr(skb, key_id);
 	}
 
 	hdr = (struct ieee80211_hdr *)skb->data;
-- 
2.20.1

