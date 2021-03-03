Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CFD232C11E
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Mar 2021 01:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236255AbhCCVQx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Mar 2021 16:16:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:47292 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230192AbhCCKwp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Mar 2021 05:52:45 -0500
X-UUID: 0ae14174d7c54da898002d780a630461-20210303
X-UUID: 0ae14174d7c54da898002d780a630461-20210303
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1680221614; Wed, 03 Mar 2021 18:38:07 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 3 Mar 2021 18:38:05 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 3 Mar 2021 18:38:05 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/4] mt76: mt7615: check mcu returned values in mt7615_ops
Date:   Wed, 3 Mar 2021 18:38:02 +0800
Message-ID: <4c525684a97f4316acecd1e83804d90ebb8dbe96.1614753100.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
References: <a379bb8534b2b8c24e30313b97aa8cfdf79c315b.1614753100.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 34AC0F9BC6CAC3822917163FFD95B87102834EADC3CEA35DBD22757D73E366502000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Properly check returned values from mcu utility routines in
mt7615_ops.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 54 +++++++++++++------
 1 file changed, 37 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 68accb37ea28..1564bcdde2d3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -29,6 +29,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
 	bool running;
+	int ret;
 
 	if (!mt7615_wait_for_mcu_init(dev))
 		return -EIO;
@@ -38,21 +39,38 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	running = mt7615_dev_running(dev);
 
 	if (!running) {
-		mt7615_mcu_set_pm(dev, 0, 0);
-		mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
+		ret = mt7615_mcu_set_pm(dev, 0, 0);
+		if (ret)
+			goto out;
+
+		ret = mt76_connac_mcu_set_mac_enable(&dev->mt76, 0, true, false);
+		if (ret)
+			goto out;
+
 		mt7615_mac_enable_nf(dev, 0);
 	}
 
 	if (phy != &dev->phy) {
-		mt7615_mcu_set_pm(dev, 1, 0);
-		mt76_connac_mcu_set_mac_enable(&dev->mt76, 1, true, false);
+		ret = mt7615_mcu_set_pm(dev, 1, 0);
+		if (ret)
+			goto out;
+
+		ret = mt76_connac_mcu_set_mac_enable(&dev->mt76, 1, true, false);
+		if (ret)
+			goto out;
+
 		mt7615_mac_enable_nf(dev, 1);
 	}
 
-	if (mt7615_firmware_offload(dev))
-		mt76_connac_mcu_set_channel_domain(phy->mt76);
+	if (mt7615_firmware_offload(dev)) {
+		ret = mt76_connac_mcu_set_channel_domain(phy->mt76);
+		if (ret)
+			goto out;
+	}
 
-	mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	ret = mt7615_mcu_set_chan_info(phy, MCU_EXT_CMD_SET_RX_PATH);
+	if (ret)
+		goto out;
 
 	set_bit(MT76_STATE_RUNNING, &phy->mt76->state);
 
@@ -62,6 +80,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 	if (!running)
 		mt7615_mac_reset_counters(dev);
 
+out:
 	mt7615_mutex_release(dev);
 
 	return 0;
@@ -715,13 +734,13 @@ static int mt7615_set_rts_threshold(struct ieee80211_hw *hw, u32 val)
 {
 	struct mt7615_dev *dev = mt7615_hw_dev(hw);
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
-	int band = phy != &dev->phy;
+	int err, band = phy != &dev->phy;
 
 	mt7615_mutex_acquire(dev);
-	mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, band);
+	err = mt76_connac_mcu_set_rts_thresh(&dev->mt76, val, band);
 	mt7615_mutex_release(dev);
 
-	return 0;
+	return err;
 }
 
 static int
@@ -749,16 +768,16 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_RX_START:
 		mt76_rx_aggr_start(&dev->mt76, &msta->wcid, tid, ssn,
 				   params->buf_size);
-		mt7615_mcu_add_rx_ba(dev, params, true);
+		ret = mt7615_mcu_add_rx_ba(dev, params, true);
 		break;
 	case IEEE80211_AMPDU_RX_STOP:
 		mt76_rx_aggr_stop(&dev->mt76, &msta->wcid, tid);
-		mt7615_mcu_add_rx_ba(dev, params, false);
+		ret = mt7615_mcu_add_rx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_OPERATIONAL:
 		mtxq->aggr = true;
 		mtxq->send_bar = false;
-		mt7615_mcu_add_tx_ba(dev, params, true);
+		ret = mt7615_mcu_add_tx_ba(dev, params, true);
 		ssn = mt7615_mac_get_sta_tid_sn(dev, msta->wcid.idx, tid);
 		ieee80211_send_bar(vif, sta->addr, tid,
 				   IEEE80211_SN_TO_SEQ(ssn));
@@ -766,7 +785,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	case IEEE80211_AMPDU_TX_STOP_FLUSH:
 	case IEEE80211_AMPDU_TX_STOP_FLUSH_CONT:
 		mtxq->aggr = false;
-		mt7615_mcu_add_tx_ba(dev, params, false);
+		ret = mt7615_mcu_add_tx_ba(dev, params, false);
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		ssn = mt7615_mac_get_sta_tid_sn(dev, msta->wcid.idx, tid);
@@ -775,7 +794,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
-		mt7615_mcu_add_tx_ba(dev, params, false);
+		ret = mt7615_mcu_add_tx_ba(dev, params, false);
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
 		break;
 	}
@@ -1085,6 +1104,7 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 					   struct ieee80211_vif *vif)
 {
 	struct mt7615_phy *phy = mt7615_hw_phy(hw);
+	int err;
 
 	if (!test_and_clear_bit(MT76_STATE_ROC, &phy->mt76->state))
 		return 0;
@@ -1093,10 +1113,10 @@ static int mt7615_cancel_remain_on_channel(struct ieee80211_hw *hw,
 	cancel_work_sync(&phy->roc_work);
 
 	mt7615_mutex_acquire(phy->dev);
-	mt7615_mcu_set_roc(phy, vif, NULL, 0);
+	err = mt7615_mcu_set_roc(phy, vif, NULL, 0);
 	mt7615_mutex_release(phy->dev);
 
-	return 0;
+	return err;
 }
 
 static void mt7615_sta_set_decap_offload(struct ieee80211_hw *hw,
-- 
2.18.0

