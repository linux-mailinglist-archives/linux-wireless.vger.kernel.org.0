Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC102100EB5
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Nov 2019 23:17:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726855AbfKRWRI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Nov 2019 17:17:08 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:40021 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726788AbfKRWRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Nov 2019 17:17:01 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 371F558007D;
        Mon, 18 Nov 2019 23:16:59 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v4 4/4] mt76: mt76x02: add channel switch support for usb interfaces
Date:   Mon, 18 Nov 2019 23:15:40 +0100
Message-Id: <20191118221540.14886-5-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191118221540.14886-1-markus.theil@tu-ilmenau.de>
References: <20191118221540.14886-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch enables channel switch support on mt76 usb interfaces.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 7 +++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c  | 7 +++++++
 3 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 8a2a90fb5663..891825043117 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -182,6 +182,12 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 	/* Prevent corrupt transmissions during update */
 	mt76_set(dev, MT_BCN_BYPASS_MASK, 0xffff);
 
+	mt76_csa_check(&dev->mt76);
+	if (dev->mt76.csa_complete) {
+		mt76_csa_finish(&dev->mt76);
+		goto out;
+	}
+
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
@@ -196,6 +202,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	mt76x02_mac_set_beacon_finish(dev);
 
+out:
 	mt76x02u_restart_pre_tbtt_timer(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 414b22399d93..3f95e5b24e1d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -174,7 +174,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		wiphy->reg_notifier = mt76x02_regd_notifier;
 		wiphy->iface_combinations = mt76x02_if_comb;
 		wiphy->n_iface_combinations = ARRAY_SIZE(mt76x02_if_comb);
-		wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 		/* init led callbacks */
 		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
@@ -184,6 +183,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		}
 	}
 
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index eb73cb856c81..a236b5249a86 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -100,6 +100,12 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 	return err;
 }
 
+static void mt76x2u_channel_switch_beacon(struct ieee80211_hw *hw,
+					  struct ieee80211_vif *vif,
+					  struct cfg80211_chan_def *chandef)
+{
+}
+
 const struct ieee80211_ops mt76x2u_ops = {
 	.tx = mt76x02_tx,
 	.start = mt76x2u_start,
@@ -121,4 +127,5 @@ const struct ieee80211_ops mt76x2u_ops = {
 	.get_survey = mt76_get_survey,
 	.set_tim = mt76_set_tim,
 	.release_buffered_frames = mt76_release_buffered_frames,
+	.channel_switch_beacon = mt76x2u_channel_switch_beacon,
 };
-- 
2.24.0

