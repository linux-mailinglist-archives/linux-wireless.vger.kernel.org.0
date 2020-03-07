Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04AB917CE25
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 13:31:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726193AbgCGMbH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 07:31:07 -0500
Received: from nbd.name ([46.4.11.11]:37946 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726043AbgCGMbG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 07:31:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject
        :To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=tgFP//2C2syOJjoc59fBNWRefYLN3Ajgrul0TosnT/8=; b=C1e5r5wyBYzjunHwAuiHfAdXwW
        4yf5dtWvf8iOO/9CIAR27arqfWJcULb8UuSf+CUza1TlVNuHiiYR7wUQ+qb9n2XPuRNps8BOsJQc8
        Q3e2jT/U87qP63yQM43dwr8lcVZ7iOdv3L1bFfw64/rzkrq50F+ZoFs662LHR7d2YEq0=;
Received: from p54ae9db9.dip0.t-ipconnect.de ([84.174.157.185] helo=maeck.lan)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1jAYbh-0002Qw-HW
        for linux-wireless@vger.kernel.org; Sat, 07 Mar 2020 13:31:05 +0100
Received: by maeck.lan (Postfix, from userid 501)
        id 01B107F17599; Sat,  7 Mar 2020 13:31:04 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix monitor injection of beacon frames
Date:   Sat,  7 Mar 2020 13:31:04 +0100
Message-Id: <20200307123104.86934-1-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When injecting beacon frames via monitor interface, they must not be sent to
the beacon hardware queue, because they don't follow normal hardware beacon tx
rules.
Fix sending them by adding a flag to mt7615_mac_write_txwi that selects the
beacon queue for tx, and use it only from mt7615_mcu_set_bcn.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c    | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 145366dbc39b..1fbd240c2b47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -503,7 +503,7 @@ mt7615_mac_tx_rate_val(struct mt7615_dev *dev,
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
-			  struct ieee80211_key_conf *key)
+			  struct ieee80211_key_conf *key, bool beacon)
 {
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
@@ -541,7 +541,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 		q_idx = wmm_idx * MT7615_MAX_WMM_SETS +
 			skb_get_queue_mapping(skb);
 		p_fmt = MT_TX_TYPE_CT;
-	} else if (ieee80211_is_beacon(fc)) {
+	} else if (beacon) {
 		if (ext_phy)
 			q_idx = MT_LMAC_BCN1;
 		else
@@ -1208,7 +1208,7 @@ int mt7615_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	mt7615_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, sta,
-			      pid, key);
+			      pid, key, false);
 
 	txp = txwi + MT_TXD_SIZE;
 	memset(txp, 0, sizeof(struct mt7615_txp_common));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7218a3041ead..b51a3cb247c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1476,7 +1476,7 @@ int mt7615_mcu_set_bcn(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 
 	mt7615_mac_write_txwi(dev, (__le32 *)(req.pkt), skb, wcid, NULL,
-			      0, NULL);
+			      0, NULL, true);
 	memcpy(req.pkt + MT_TXD_SIZE, skb->data, skb->len);
 	req.pkt_len = cpu_to_le16(MT_TXD_SIZE + skb->len);
 	req.tim_ie_pos = cpu_to_le16(MT_TXD_SIZE + offs.tim_offset);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index a84a9b4cbf4e..68c4f1683204 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -347,7 +347,7 @@ void mt7615_mac_sta_poll(struct mt7615_dev *dev);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 			  struct sk_buff *skb, struct mt76_wcid *wcid,
 			  struct ieee80211_sta *sta, int pid,
-			  struct ieee80211_key_conf *key);
+			  struct ieee80211_key_conf *key, bool beacon);
 void mt7615_mac_set_timing(struct mt7615_phy *phy);
 int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb);
 void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data);
-- 
2.24.0

