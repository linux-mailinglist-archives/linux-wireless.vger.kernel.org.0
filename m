Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF24D379265
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 17:19:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbhEJPUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 11:20:13 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:58495 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234302AbhEJPSu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 11:18:50 -0400
X-UUID: 4089e40365ae45598466a19bc2a598f5-20210510
X-UUID: 4089e40365ae45598466a19bc2a598f5-20210510
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1153437198; Mon, 10 May 2021 23:15:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 10 May 2021 23:14:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 May 2021 23:14:58 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <yenlinlai@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 4/9] mt76: mt7921: enable deep sleep at runtime
Date:   Mon, 10 May 2021 23:14:52 +0800
Message-ID: <1620659697-12048-4-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
References: <1620659697-12048-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Enable the deep sleep mode with that firmware is able to trap into
the doze state at runtime to reduce the power consumption further.

The deep sleep mode is not allowed in the STA state transition with
the firmware to have the fast connection experience as we've done in
the full power mode

Reviewed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt76_connac_mcu.c  | 20 +++++++++++++
 .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 ++
 .../net/wireless/mediatek/mt76/mt7921/init.c  |  6 +++-
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 28 +++++++++++++++++--
 4 files changed, 54 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 7b8f8e6f431d..542d7d9f1f52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -1596,6 +1596,26 @@ int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable)
 }
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_set_deep_sleep);
 
+int mt76_connac_sta_state_dp(struct mt76_dev *dev,
+			     enum ieee80211_sta_state old_state,
+			     enum ieee80211_sta_state new_state)
+{
+	if ((old_state == IEEE80211_STA_ASSOC &&
+	     new_state == IEEE80211_STA_AUTHORIZED) ||
+	    (old_state == IEEE80211_STA_NONE &&
+	     new_state == IEEE80211_STA_NOTEXIST))
+		mt76_connac_mcu_set_deep_sleep(dev, true);
+
+	if ((old_state == IEEE80211_STA_NOTEXIST &&
+	     new_state == IEEE80211_STA_NONE) ||
+	    (old_state == IEEE80211_STA_AUTHORIZED &&
+	     new_state == IEEE80211_STA_ASSOC))
+		mt76_connac_mcu_set_deep_sleep(dev, false);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_connac_sta_state_dp);
+
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
 				    struct mt76_connac_coredump *coredump)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 01fc9f2c2f4a..3ed2fb5e1389 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1032,6 +1032,9 @@ int mt76_connac_mcu_update_gtk_rekey(struct ieee80211_hw *hw,
 int mt76_connac_mcu_set_hif_suspend(struct mt76_dev *dev, bool suspend);
 void mt76_connac_mcu_set_suspend_iter(void *priv, u8 *mac,
 				      struct ieee80211_vif *vif);
+int mt76_connac_sta_state_dp(struct mt76_dev *dev,
+			     enum ieee80211_sta_state old_state,
+			     enum ieee80211_sta_state new_state);
 int mt76_connac_mcu_chip_config(struct mt76_dev *dev);
 int mt76_connac_mcu_set_deep_sleep(struct mt76_dev *dev, bool enable);
 void mt76_connac_mcu_coredump_event(struct mt76_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 6947d98287c0..cd68721314fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -250,7 +250,11 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	return mt7921_init_debugfs(dev);
+	ret = mt7921_init_debugfs(dev);
+	if (ret)
+		return ret;
+
+	return mt76_connac_mcu_set_deep_sleep(&dev->mt76, dev->pm.enable);
 }
 
 void mt7921_unregister_device(struct mt7921_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 39b3e769925e..5dbccbefe047 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -848,6 +848,31 @@ mt7921_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			      IEEE80211_STA_NOTEXIST);
 }
 
+static int mt7921_sta_state(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_sta *sta,
+			    enum ieee80211_sta_state old_state,
+			    enum ieee80211_sta_state new_state)
+{
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (dev->pm.enable) {
+		mt7921_mutex_acquire(dev);
+		mt76_connac_sta_state_dp(&dev->mt76, old_state, new_state);
+		mt7921_mutex_release(dev);
+	}
+
+	if (old_state == IEEE80211_STA_AUTH &&
+	    new_state == IEEE80211_STA_ASSOC) {
+		return mt7921_sta_add(hw, vif, sta);
+	} else if (old_state == IEEE80211_STA_ASSOC &&
+		   new_state == IEEE80211_STA_AUTH) {
+		return mt7921_sta_remove(hw, vif, sta);
+	}
+
+	return 0;
+}
+
 static int
 mt7921_get_stats(struct ieee80211_hw *hw,
 		 struct ieee80211_low_level_stats *stats)
@@ -1191,8 +1216,7 @@ const struct ieee80211_ops mt7921_ops = {
 	.conf_tx = mt7921_conf_tx,
 	.configure_filter = mt7921_configure_filter,
 	.bss_info_changed = mt7921_bss_info_changed,
-	.sta_add = mt7921_sta_add,
-	.sta_remove = mt7921_sta_remove,
+	.sta_state = mt7921_sta_state,
 	.sta_pre_rcu_remove = mt76_sta_pre_rcu_remove,
 	.set_key = mt7921_set_key,
 	.sta_set_decap_offload = mt7921_sta_set_decap_offload,
-- 
2.25.1

