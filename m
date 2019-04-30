Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 36656F99D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727617AbfD3NMS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:12:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:58406 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NMS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:12:18 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8B04620835;
        Tue, 30 Apr 2019 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556629937;
        bh=0lM9mG5yupS/9PSblirWI6nSFfMK94txP9FcIgw4P0E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1xZ9DHLz3T8+wNMp4fNhQz8pWg1IjrNjbZYqy4fXDdFK8vgNMqVE25kKq45/p9Py
         7BbzmmKAsOW8IliHA17CswVc4AOom1ClqzdsYj7v6YA6612IgeSr8SSHo2nJ3JZgi8
         YUqevpqLdeVtPLihEsecbmJsrjt95SnYprIGhzWc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v3 3/3] mt76: do not enable/disable pre_tbtt_tasklet in scan_start/scan_complete
Date:   Tue, 30 Apr 2019 15:12:03 +0200
Message-Id: <b3156cb6a99c6c9df7f2b78be46ac4963afbd8be.1556629547.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556629547.git.lorenzo@kernel.org>
References: <cover.1556629547.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not enable/disable pre_tbtt_tasklet tasklet in
mt76x02_sw_scan/mt76x02_sw_scan_complete since it is already done
setting the operating channel. Do run tbtt_tasklet while the device is
offchannel

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt76x02_util.c     | 5 -----
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 8f899b8aa9fe..7b7163bc3b62 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -30,6 +30,9 @@ static void mt76x02_pre_tbtt_tasklet(unsigned long arg)
 	struct sk_buff *skb;
 	int i;
 
+	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		return;
+
 	mt76x02_resync_beacon_timer(dev);
 
 	ieee80211_iterate_active_interfaces_atomic(mt76_hw(dev),
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
index 5b6ac1b364e1..6b89f7eab26c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_usb_core.c
@@ -178,6 +178,9 @@ static void mt76x02u_pre_tbtt_work(struct work_struct *work)
 	if (!dev->mt76.beacon_mask)
 		return;
 
+	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		return;
+
 	mt76x02_resync_beacon_timer(dev);
 
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
index 12724e96b290..ad5323447ed4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_util.c
@@ -593,8 +593,6 @@ void mt76x02_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76x02_dev *dev = hw->priv;
 
-	if (mt76_is_mmio(dev))
-		tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 	set_bit(MT76_SCANNING, &dev->mt76.state);
 }
 EXPORT_SYMBOL_GPL(mt76x02_sw_scan);
@@ -605,9 +603,6 @@ void mt76x02_sw_scan_complete(struct ieee80211_hw *hw,
 	struct mt76x02_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
-	if (mt76_is_mmio(dev))
-		tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
-
 	if (dev->cal.gain_init_done) {
 		/* Restore AGC gain and resume calibration after scanning. */
 		dev->cal.low_gain = -1;
-- 
2.20.1

