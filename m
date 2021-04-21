Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE1C6366963
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Apr 2021 12:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235062AbhDUKoh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 21 Apr 2021 06:44:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:42394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234175AbhDUKoh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 21 Apr 2021 06:44:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4885961447;
        Wed, 21 Apr 2021 10:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619001844;
        bh=4F/mdA+8KiAVNOjwmzy4t0tGyd6Otl8pt7KMdgaZ5D8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fhvs+Q8H9wOv9aq2XTZuwiogfW6IVzlrQTKTN0jMcWtGpPVrLFxBliJWg8IZJyBzl
         Wkhz8RVW/9Xz4EUzs1AOszI2rKY/QMkO1vtsXQJgEwKbYqWBl7ptc7LHXnC8bp4k95
         Ulik+o0fjDPn0qumvj5tkDJ69xNV+rcMAcQKUE19zh7DT7117sdnF6AyE0u/BIWl2m
         Al6cmUtotP/MHugvueBTUohEOPvoCeTu19Kn9mB5Ro7YSW/X7CBPZVi78SFg2myv+4
         Pn2LKnYrxMRD4zPU6ilFwUvi/Ms6EpFAeX0UlZtcigCUqvuixXadLU2KeqYprjKqYj
         aruAj6qPCdU7Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 3/4] mt76: connac: unschedule mac_work before going to sleep
Date:   Wed, 21 Apr 2021 12:43:50 +0200
Message-Id: <18ad0bd853e0ff135d5eef10e4e9fd192d5535bf.1619001617.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619001617.git.lorenzo@kernel.org>
References: <cover.1619001617.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to wake the device less frequently and so reduce power
consumpation, unschedule mac_work before going to sleep

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 2 ++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 4 +++-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 ++
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index d11375661875..f81a17d56008 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1912,6 +1912,8 @@ void mt7615_pm_wake_work(struct work_struct *work)
 			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 		mt76_queue_tx_cleanup(dev, dev->mt76.q_mcu[MT_MCUQ_WM], false);
+		ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+					     MT7615_WATCHDOG_TIME);
 	}
 
 	ieee80211_wake_queues(mphy->hw);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 66f1667481e6..b32f26c1f8b3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -42,8 +42,10 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 
 	pm->last_activity = jiffies;
 
-	if (!test_bit(MT76_STATE_PM, &phy->state))
+	if (!test_bit(MT76_STATE_PM, &phy->state)) {
+		cancel_delayed_work(&phy->mac_work);
 		queue_delayed_work(dev->wq, &pm->ps_work, pm->idle_timeout);
+	}
 }
 EXPORT_SYMBOL_GPL(mt76_connac_power_save_sched);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 72d04b229e6b..09f60a68ac73 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1492,6 +1492,8 @@ void mt7921_pm_wake_work(struct work_struct *work)
 			napi_schedule(&dev->mt76.napi[i]);
 		mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 		mt7921_tx_cleanup(dev);
+		ieee80211_queue_delayed_work(mphy->hw, &mphy->mac_work,
+					     MT7921_WATCHDOG_TIME);
 	}
 
 	ieee80211_wake_queues(mphy->hw);
-- 
2.30.2

