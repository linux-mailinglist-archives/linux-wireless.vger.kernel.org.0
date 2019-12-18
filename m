Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C12C124CC4
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2019 17:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727500AbfLRQI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Dec 2019 11:08:57 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:51435 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727480AbfLRQI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Dec 2019 11:08:56 -0500
Received: from isengard.tu-ilmenau.de (unknown [141.24.207.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 5E6C658007D;
        Wed, 18 Dec 2019 17:08:52 +0100 (CET)
From:   Markus Theil <markus.theil@tu-ilmenau.de>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        Stanislaw Gruszka <stf_xl@wp.pl>, kvalo@codeaurora.org,
        Markus Theil <markus.theil@tu-ilmenau.de>
Subject: [PATCH v10 6/6] mt76: mt76x02: add channel switch support for usb interfaces
Date:   Wed, 18 Dec 2019 17:07:54 +0100
Message-Id: <20191218160754.24111-7-markus.theil@tu-ilmenau.de>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
References: <20191218160754.24111-1-markus.theil@tu-ilmenau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch enables channel switch support on mt76 usb interfaces.

Signed-off-by: Markus Theil <markus.theil@tu-ilmenau.de>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 8 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index db79d9c673b1..1445fb22d93c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -216,6 +216,13 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 		IEEE80211_IFACE_ITER_RESUME_ALL,
 		mt76x02_update_beacon_iter, dev);
 
+	mt76_csa_check(&dev->mt76);
+
+	if (dev->mt76.csa_complete) {
+		mt76_csa_finish(&dev->mt76);
+		goto out;
+	}
+
 	nbeacons = hweight8(dev->mt76.beacon_mask);
 	mt76x02_enqueue_buffered_bc(dev, &data, N_BCN_SLOTS - nbeacons);
 
@@ -224,6 +231,7 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 		mt76x02_mac_set_beacon(dev, skb);
 	}
 
+out:
 	mt76_wr(dev, MT_BCN_BYPASS_MASK,
 		0xff00 | ~(0xff00 >> dev->beacon_data_count));
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 6073f8a4a8f6..dbda7fb6dab7 100644
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
2.24.1

