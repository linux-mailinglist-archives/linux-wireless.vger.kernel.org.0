Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699E910DE0D
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbfK3Paw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:52 -0500
Received: from nbd.name ([46.4.11.11]:56074 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727213AbfK3Pau (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=3Axqf+qXkOPylbU3x2qUgxTg2ybxbJemIhaMlBzNePw=; b=OmSWT+ODWQ0ESKjufCpTkXPlaa
        R1mM3izhtF4sCqtwamHp68Xp+RdCyU41NuIF705RjCcZwFAbxPYUA/a8yFoIGbQUTVF+FrBP2FGqh
        K2Ll6ACluAIAsHRX8+jxeMCmrW9xM7Gnj4IWsSoHo53n4YpxP893L1CVp4IX82Kqb4rE=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iR-Rg
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0D67E721EBEC; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 03/29] mt76: add support for an extra wiphy in the rx path
Date:   Sat, 30 Nov 2019 16:30:19 +0100
Message-Id: <20191130153045.28105-3-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 20 +++++++++++++------
 drivers/net/wireless/mediatek/mt76/mt76.h     | 11 ++++++++++
 2 files changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 39b409556083..0c2a11172203 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -563,8 +563,12 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 }
 EXPORT_SYMBOL(mt76_wcid_key_setup);
 
-static struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
+static void
+mt76_rx_convert(struct mt76_dev *dev, struct sk_buff *skb,
+		struct ieee80211_hw **hw,
+		struct ieee80211_sta **sta)
 {
+
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(skb);
 	struct mt76_rx_status mstat;
 
@@ -589,7 +593,8 @@ static struct ieee80211_sta *mt76_rx_convert(struct sk_buff *skb)
 	memcpy(status->chain_signal, mstat.chain_signal,
 	       sizeof(mstat.chain_signal));
 
-	return wcid_to_sta(mstat.wcid);
+	*sta = wcid_to_sta(mstat.wcid);
+	*hw = mt76_phy_hw(dev, mstat.ext_phy);
 }
 
 static int
@@ -715,12 +720,14 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 	struct mt76_rx_status *status = (struct mt76_rx_status *)skb->cb;
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
 	struct ieee80211_sta *sta;
+	struct ieee80211_hw *hw;
 	struct mt76_wcid *wcid = status->wcid;
 	bool ps;
 	int i;
 
+	hw = mt76_phy_hw(dev, status->ext_phy);
 	if (ieee80211_is_pspoll(hdr->frame_control) && !wcid) {
-		sta = ieee80211_find_sta_by_ifaddr(dev->hw, hdr->addr2, NULL);
+		sta = ieee80211_find_sta_by_ifaddr(hw, hdr->addr2, NULL);
 		if (sta)
 			wcid = status->wcid = (struct mt76_wcid *)sta->drv_priv;
 	}
@@ -778,7 +785,7 @@ mt76_check_sta(struct mt76_dev *dev, struct sk_buff *skb)
 
 		mtxq = (struct mt76_txq *)sta->txq[i]->drv_priv;
 		if (!skb_queue_empty(&mtxq->retry_q))
-			ieee80211_schedule_txq(dev->hw, sta->txq[i]);
+			ieee80211_schedule_txq(hw, sta->txq[i]);
 	}
 }
 
@@ -786,6 +793,7 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 		      struct napi_struct *napi)
 {
 	struct ieee80211_sta *sta;
+	struct ieee80211_hw *hw;
 	struct sk_buff *skb;
 
 	spin_lock(&dev->rx_lock);
@@ -795,8 +803,8 @@ void mt76_rx_complete(struct mt76_dev *dev, struct sk_buff_head *frames,
 			continue;
 		}
 
-		sta = mt76_rx_convert(skb);
-		ieee80211_rx_napi(dev->hw, sta, skb, napi);
+		mt76_rx_convert(dev, skb, &hw, &sta);
+		ieee80211_rx_napi(hw, sta, skb, napi);
 	}
 	spin_unlock(&dev->rx_lock);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 2a01d2c0445b..705d25f9778a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -433,6 +433,7 @@ struct mt76_rx_status {
 
 	u8 iv[6];
 
+	u8 ext_phy:1;
 	u8 aggr:1;
 	u8 tid;
 	u16 seqno;
@@ -457,6 +458,8 @@ struct mt76_phy {
 struct mt76_dev {
 	struct mt76_phy phy; /* must be first */
 
+	struct mt76_phy *phy2;
+
 	struct ieee80211_hw *hw;
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
@@ -640,6 +643,14 @@ void mt76_seq_puts_array(struct seq_file *file, const char *str,
 int mt76_eeprom_init(struct mt76_dev *dev, int len);
 void mt76_eeprom_override(struct mt76_dev *dev);
 
+static inline struct ieee80211_hw *
+mt76_phy_hw(struct mt76_dev *dev, bool phy_ext)
+{
+	if (phy_ext && dev->phy2)
+		return dev->phy2->hw;
+	return dev->phy.hw;
+}
+
 static inline u8 *
 mt76_get_txwi_ptr(struct mt76_dev *dev, struct mt76_txwi_cache *t)
 {
-- 
2.24.0

