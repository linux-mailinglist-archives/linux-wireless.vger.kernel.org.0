Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9199C104697
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Nov 2019 23:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726880AbfKTW2o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Nov 2019 17:28:44 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:49977 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726836AbfKTW2m (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Nov 2019 17:28:42 -0500
Received: from localhost.localdomain (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id EF312580082;
        Wed, 20 Nov 2019 23:28:39 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <sgruszka@redhat.com>,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v7 5/5] mt76: mt76x02: add channel switch support for usb interfaces
Date:   Wed, 20 Nov 2019 23:28:26 +0100
Message-Id: <20191120222826.14871-6-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191120222826.14871-1-markus.theil@tu-ilmenau.de>
References: <20191120222826.14871-1-markus.theil@tu-ilmenau.de>
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
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 0b3437a30b02..600938a4b0c9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -211,6 +211,12 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
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
@@ -225,6 +231,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 
 	mt76x02_mac_set_beacon_finish(dev);
 
+out:
 	mt76x02u_restart_pre_tbtt_timer(dev);
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 0960fc56b672..df381443cb52 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -166,7 +166,6 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		wiphy->reg_notifier = mt76x02_regd_notifier;
 		wiphy->iface_combinations = mt76x02_if_comb;
 		wiphy->n_iface_combinations = ARRAY_SIZE(mt76x02_if_comb);
-		wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 
 		/* init led callbacks */
 		if (IS_ENABLED(CONFIG_MT76_LEDS)) {
@@ -176,6 +175,7 @@ void mt76x02_init_device(struct mt76x02_dev *dev)
 		}
 	}
 
+	wiphy->flags |= WIPHY_FLAG_HAS_CHANNEL_SWITCH;
 	wiphy_ext_feature_set(wiphy, NL80211_EXT_FEATURE_VHT_IBSS);
 
 	hw->sta_data_size = sizeof(struct mt76x02_sta);
-- 
2.24.0

