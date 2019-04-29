Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B9749DD75
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727538AbfD2INQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:33570 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:16 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D74B3206BF;
        Mon, 29 Apr 2019 08:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525594;
        bh=5IBHuyr0DnzvkYjSogOH64/+S5ruliz7h1k2haezQL8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=0Z5uCgcH4A+GakuYQKEi/h4oVELGeXvhZGijbivjYm5vJoobp+2oMHgf3ymd7haCE
         R2kOnPZAVPQNN4TVu0zdomw7FC5d8gFAyJtqJ5BYw+BCR+b2xc5DKvhb8oy4JOoC+Y
         VtltkFhIPSACR/l3vgQ0IEupd3JS/ACj+omlJQX8=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 2/5] mt76: move beacon_int in mt76_dev
Date:   Mon, 29 Apr 2019 10:12:59 +0200
Message-Id: <b8cf051ffd3ec47235bb45a0c28d7c107d834d69.1556525110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556525110.git.lorenzo@kernel.org>
References: <cover.1556525110.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move beacon_int in mt76_dev data structure since it is used by
all drivers

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76.h             | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c       | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/main.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h    | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02.h          | 1 -
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 2 +-
 9 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 75a0d150a224..be0ca4af7254 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -469,6 +469,8 @@ struct mt76_dev {
 	u8 antenna_mask;
 	u16 chainmask;
 
+	int beacon_int;
+
 	struct mt76_sband sband_2g;
 	struct mt76_sband sband_5g;
 	struct debugfs_blob_wrapper eeprom;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index 1b6c3f32bc1b..64e15d566283 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -156,7 +156,7 @@ void mt7603_beacon_set_timer(struct mt7603_dev *dev, int idx, int intval)
 		return;
 	}
 
-	dev->beacon_int = intval;
+	dev->mt76.beacon_int = intval;
 	mt76_wr(dev, MT_TBTT,
 		FIELD_PREP(MT_TBTT_PERIOD, intval) | MT_TBTT_CAL_ENABLE);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 2fd63597d305..a5a881738d83 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1268,7 +1268,7 @@ static void mt7603_dma_sched_reset(struct mt7603_dev *dev)
 
 static void mt7603_mac_watchdog_reset(struct mt7603_dev *dev)
 {
-	int beacon_int = dev->beacon_int;
+	int beacon_int = dev->mt76.beacon_int;
 	u32 mask = dev->mt76.mmio.irqmask;
 	int i;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 18a33d921601..9be9ae02103e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -544,7 +544,7 @@ mt7603_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt7603_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
-	mt7603_beacon_set_timer(dev, -1, dev->beacon_int);
+	mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index 3816f1e8ae70..a2cda08ca70b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -109,7 +109,6 @@ struct mt7603_dev {
 
 	ktime_t survey_time;
 	ktime_t ed_time;
-	int beacon_int;
 
 	struct mt76_queue q_rx;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index dfd3a4f1a624..dde1f64390ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -106,7 +106,6 @@ struct mt76x02_dev {
 	u8 beacon_data_mask;
 
 	u8 tbtt_count;
-	u16 beacon_int;
 
 	u32 tx_hang_reset;
 	u8 tx_hang_check;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index 0c232d02f189..985a9b5d0e45 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -167,7 +167,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 void
 mt76x02_resync_beacon_timer(struct mt76x02_dev *dev)
 {
-	u32 timer_val = dev->beacon_int << 4;
+	u32 timer_val = dev->mt76.beacon_int << 4;
 
 	dev->tbtt_count++;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 818b96064dec..81cebd92a4e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -147,7 +147,7 @@ static void mt76x02u_restart_pre_tbtt_timer(struct mt76x02_dev *dev)
 	dev_dbg(dev->mt76.dev, "TSF: %llu us TBTT %u us\n", tsf, tbtt);
 
 	/* Convert beacon interval in TU (1024 usec) to nsec */
-	time = ((1000000000ull * dev->beacon_int) >> 10);
+	time = ((1000000000ull * dev->mt76.beacon_int) >> 10);
 
 	/* Adjust time to trigger hrtimer 8ms before TBTT */
 	if (tbtt < PRE_TBTT_USEC)
@@ -217,7 +217,7 @@ static void mt76x02u_beacon_enable(struct mt76x02_dev *dev, bool en)
 {
 	int i;
 
-	if (WARN_ON_ONCE(!dev->beacon_int))
+	if (WARN_ON_ONCE(!dev->mt76.beacon_int))
 		return;
 
 	if (en) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 5d656fea1dde..ad5323447ed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -645,7 +645,7 @@ void mt76x02_bss_info_changed(struct ieee80211_hw *hw,
 		mt76_rmw_field(dev, MT_BEACON_TIME_CFG,
 			       MT_BEACON_TIME_CFG_INTVAL,
 			       info->beacon_int << 4);
-		dev->beacon_int = info->beacon_int;
+		dev->mt76.beacon_int = info->beacon_int;
 	}
 
 	if (changed & BSS_CHANGED_BEACON_ENABLED)
-- 
2.20.1

