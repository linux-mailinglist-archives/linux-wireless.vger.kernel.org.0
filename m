Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4EF85BC55
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2019 15:04:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbfGANEx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Jul 2019 09:04:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726329AbfGANEx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Jul 2019 09:04:53 -0400
Received: from lore-desk-wlan.lan (unknown [151.66.13.64])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45D85214AE;
        Mon,  1 Jul 2019 13:04:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1561986292;
        bh=bms4cfIjtHfQJGtL4rdF+eucyqlz+sI24l5WbrPAiWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=yTL63+PYqzhNgpd1T0HVm8xgZd3tinwIqmD+1F1nOChhIFoNMGmkN2Mf+Jb3iN1CK
         su1RDy3HRBjhbjyIBM6jVieLZTeHaFFABI+FJ9yLk+VOxoaAeLSmnPuf5tUVEhkIjo
         +qEo06RzFCQm0cEYT2PiPwTdRjMVeS6EC/rQ+Sog=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, s.gottschall@newmedia-net.de,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com,
        royluo@google.com
Subject: [PATCH 2/2] mt76: mt7615: add BIP_CMAC_128 cipher support
Date:   Mon,  1 Jul 2019 15:04:40 +0200
Message-Id: <9a82f28d2ff3139baa5dd3cfcbd9ce75eb8a8cf7.1561985981.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1561985981.git.lorenzo@kernel.org>
References: <cover.1561985981.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable hw support for BIP_CMAC_128 cipher

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 5 +++--
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c  | 9 +++++++--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c | 1 +
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 3 +++
 4 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index ec9efb79985f..f1cc18c22252 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -487,9 +487,10 @@ void mt76_wcid_key_setup(struct mt76_dev *dev, struct mt76_wcid *wcid,
 	if (!key)
 		return;
 
-	if (key->cipher == WLAN_CIPHER_SUITE_CCMP)
-		wcid->rx_check_pn = true;
+	if (key->cipher != WLAN_CIPHER_SUITE_CCMP)
+		return;
 
+	wcid->rx_check_pn = true;
 	for (i = 0; i < IEEE80211_NUM_TIDS; i++) {
 		ieee80211_get_key_rx_seq(key, i, &seq);
 		memcpy(wcid->rx_key_pn[i], seq.ccmp.pn, sizeof(seq.ccmp.pn));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 08cc3f46b011..e75167f25a5d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -309,6 +309,7 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(skb);
 	struct ieee80211_tx_rate *rate = &info->control.rates[0];
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+	bool multicast = is_multicast_ether_addr(hdr->addr1);
 	struct ieee80211_vif *vif = info->control.vif;
 	int tx_count = 8;
 	u8 fc_type, fc_stype, p_fmt, q_idx, omac_idx = 0;
@@ -360,8 +361,12 @@ int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
 
 	val = FIELD_PREP(MT_TXD2_FRAME_TYPE, fc_type) |
 	      FIELD_PREP(MT_TXD2_SUB_TYPE, fc_stype) |
-	      FIELD_PREP(MT_TXD2_MULTICAST,
-			 is_multicast_ether_addr(hdr->addr1));
+	      FIELD_PREP(MT_TXD2_MULTICAST, multicast);
+	if (key)
+		val |= FIELD_PREP(MT_TXD2_BIP,
+				  multicast &&
+				  ieee80211_is_robust_mgmt_frame(skb) &&
+				  key->cipher == WLAN_CIPHER_SUITE_AES_CMAC);
 	txwi[2] = cpu_to_le32(val);
 
 	if (!(info->flags & IEEE80211_TX_CTL_AMPDU))
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 8fefcfba83b1..ceda05135211 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -188,6 +188,7 @@ static int mt7615_set_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 	case WLAN_CIPHER_SUITE_GCMP:
 	case WLAN_CIPHER_SUITE_GCMP_256:
 	case WLAN_CIPHER_SUITE_SMS4:
+	case WLAN_CIPHER_SUITE_AES_CMAC:
 		break;
 	default:
 		return -EOPNOTSUPP;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 06d146198e33..e28af003d118 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -908,6 +908,8 @@ mt7615_get_key_info(struct ieee80211_key_conf *key, u8 *key_data)
 		return MT_CIPHER_GCMP_256;
 	case WLAN_CIPHER_SUITE_SMS4:
 		return MT_CIPHER_WAPI;
+	case WLAN_CIPHER_SUITE_AES_CMAC:
+		return MT_CIPHER_BIP_CMAC_128;
 	default:
 		return MT_CIPHER_NONE;
 	}
@@ -940,6 +942,7 @@ int mt7615_mcu_set_wtbl_key(struct mt7615_dev *dev, int wcid,
 		if (cipher == MT_CIPHER_NONE)
 			return -EOPNOTSUPP;
 
+		req.key.ikv = (cipher == MT_CIPHER_BIP_CMAC_128);
 		req.key.rkv = 1;
 		req.key.cipher_id = cipher;
 		req.key.key_id = key->keyidx;
-- 
2.21.0

