Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C727732C114
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbhCCVQr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:47 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44190 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1356498AbhCCKrj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 05:47:39 -0500
X-UUID: 4c81aa0874e4496b99d54a60b8144632-20210303
X-UUID: 4c81aa0874e4496b99d54a60b8144632-20210303
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 561527874; Wed, 03 Mar 2021 18:38:06 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Mar 2021 18:38:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 18:38:04 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 3/4] mt76: mt7915: check mcu returned values in mt7915_ops
Date:   Wed, 3 Mar 2021 18:38:01 +0800
Message-ID: <76a1830344d468e229e2b16badaabe707c8756b3.1614753100.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
References: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly check returned values from mcu utility routines in
mt7915_ops.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 58 ++++++++++++++-----
 1 file changed, 42 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index bb49ea9307e0..255f87aa1830 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -25,6 +25,7 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
 	bool running;
+	int ret;
 
 	flush_work(&dev->init_work);
 
@@ -33,21 +34,44 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	running = mt7915_dev_running(dev);
 
 	if (!running) {
-		mt7915_mcu_set_pm(dev, 0, 0);
-		mt7915_mcu_set_mac(dev, 0, true, true);
-		mt7915_mcu_set_scs(dev, 0, true);
+		ret = mt7915_mcu_set_pm(dev, 0, 0);
+		if (ret)
+			goto out;
+
+		ret = mt7915_mcu_set_mac(dev, 0, true, true);
+		if (ret)
+			goto out;
+
+		ret = mt7915_mcu_set_scs(dev, 0, true);
+		if (ret)
+			goto out;
+
 		mt7915_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
-		mt7915_mcu_set_pm(dev, 1, 0);
-		mt7915_mcu_set_mac(dev, 1, true, true);
-		mt7915_mcu_set_scs(dev, 1, true);
+		ret = mt7915_mcu_set_pm(dev, 1, 0);
+		if (ret)
+			goto out;
+
+		ret = mt7915_mcu_set_mac(dev, 1, true, true);
+		if (ret)
+			goto out;
+
+		ret = mt7915_mcu_set_scs(dev, 1, true);
+		if (ret)
+			goto out;
+
 		mt7915_mac_enable_nf(dev, 1);
 	}
 
-	mt7915_mcu_set_sku_en(phy, true);
-	mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
+	ret = mt7915_mcu_set_sku_en(phy, true);
+	if (ret)
+		goto out;
+
+	ret = mt7915_mcu_set_chan_info(phy, MCU_EXT_CMD(SET_RX_PATH));
+	if (ret)
+		goto out;
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -58,9 +82,10 @@ static int mt7915_start(struct ieee80211_hw *hw)
 	if (!running)
 		mt7915_mac_reset_counters(phy);
 
+out:
 	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return ret;
 }
 
 static void mt7915_stop(struct ieee80211_hw *hw)
@@ -631,12 +656,13 @@ static int mt7915_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7915_dev *dev = mt7915_hw_dev(hw);
 	struct mt7915_phy *phy = mt7915_hw_phy(hw);
+	int ret;
 
 	mutex_lock(&dev->mt76.mutex);
-	mt7915_mcu_set_rts_thresh(phy, val);
+	ret = mt7915_mcu_set_rts_thresh(phy, val);
 	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return ret;
 }
 
 static int
@@ -663,22 +689,22 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
 				   params->buf_size);
-		mt7915_mcu_add_rx_ba(dev, params, true);
+		ret = mt7915_mcu_add_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
-		mt7915_mcu_add_rx_ba(dev, params, false);
+		ret = mt7915_mcu_add_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7915_mcu_add_tx_ba(dev, params, true);
+		ret = mt7915_mcu_add_tx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->ampdu_state);
-		mt7915_mcu_add_tx_ba(dev, params, false);
+		ret = mt7915_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		set_bit(tid, &msta->ampdu_state);
@@ -687,7 +713,7 @@ mt7915_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		clear_bit(tid, &msta->ampdu_state);
-		mt7915_mcu_add_tx_ba(dev, params, false);
+		ret = mt7915_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
-- 
2.18.0

