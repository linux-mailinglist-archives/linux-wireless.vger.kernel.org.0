Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 302B91044BE
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 21:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727367AbfKTUFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 15:05:44 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49556 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727085AbfKTUFn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 15:05:43 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 0A0BA58007C;
        Wed, 20 Nov 2019 21:05:41 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH] mt76: fix fix ampdu locking
Date:   Wed, 20 Nov 2019 21:05:31 +0100
Message-Id: <20191120200531.11344-1-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The current ampdu locking code does not unlock its mutex in the early
return case. This patch fixes it.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt7603/main.c  | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt7615/main.c  | 6 ++++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c | 6 ++++--
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 281387c3f4f4..962e2822d19f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -569,6 +569,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u16 ssn = params->ssn;
 	u8 ba_size = params->buf_size;
 	struct mt76_txq *mtxq;
+	int ret = 0;
 
 	if (!txq)
 		return -EINVAL;
@@ -597,7 +598,8 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		mt7603_mac_tx_ba_reset(dev, msta->wcid.idx, tid, -1);
@@ -606,7 +608,7 @@ mt7603_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return ret;
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 240dab919327..070b03403894 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -484,6 +484,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
+	int ret = 0;
 
 	if (!txq)
 		return -EINVAL;
@@ -513,7 +514,8 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		mt7615_mcu_set_tx_ba(dev, params, 0);
@@ -522,7 +524,7 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return ret;
 }
 
 const struct ieee80211_ops mt7615_ops = {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index f58a3ebfa9d2..dac383ee8f4f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -356,6 +356,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	u16 tid = params->tid;
 	u16 ssn = params->ssn;
 	struct mt76_txq *mtxq;
+	int ret = 0;
 
 	if (!txq)
 		return -EINVAL;
@@ -385,7 +386,8 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		break;
 	case IEEE80211_AMPDU_TX_START:
 		mtxq->agg_ssn = IEEE80211_SN_TO_SEQ(ssn);
-		return IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		ret = IEEE80211_AMPDU_TX_START_IMMEDIATE;
+		break;
 	case IEEE80211_AMPDU_TX_STOP_CONT:
 		mtxq->aggr = false;
 		ieee80211_stop_tx_ba_cb_irqsafe(vif, sta->addr, tid);
@@ -393,7 +395,7 @@ int mt76x02_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 	mutex_unlock(&dev->mt76.mutex);
 
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(mt76x02_ampdu_action);
 
-- 
2.24.0

