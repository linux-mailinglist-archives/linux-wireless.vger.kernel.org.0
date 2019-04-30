Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8E87F99B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727402AbfD3NMQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 09:12:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:58386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726264AbfD3NMQ (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 09:12:16 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9495A21734;
        Tue, 30 Apr 2019 13:12:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556629935;
        bh=6w4g/HNfSF4MmqaWmPd5rJKFGBzfl0aLogsYCHFcpoA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dFarUz6TLh1zJuf3v2el59qCArRC/0JuPAPaV5lznnef5+M0BYH4fFX7xqJZjdRvC
         NMFfQSPlVe26G+4En1Ahiz9vYIJk7Y0yku5G/lVg1Ky7Xo4rahxKYWpOFS0HKYJ5lG
         N8ZZDV2L02HyLnhwPQgNrP2jkGQtQsMgdLCDtzBI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v3 2/3] mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel
Date:   Tue, 30 Apr 2019 15:12:02 +0200
Message-Id: <16f5dd831b105f53bbdb4071f51090407831139d.1556629547.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556629547.git.lorenzo@kernel.org>
References: <cover.1556629547.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Disable pre_tbtt_tasklet tasklet before setting the operating channel.
Enable/disable beacon_timer in mt7603_set_channel

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7603/beacon.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7603/main.c   | 8 ++++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
index f3e7406e731f..58e68fbdbf75 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/beacon.c
@@ -72,6 +72,9 @@ void mt7603_pre_tbtt_tasklet(unsigned long arg)
 	struct sk_buff *skb;
 	int i, nframes;
 
+	if (mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL)
+		return;
+
 	data.dev = dev;
 	__skb_queue_head_init(&data.q);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index be5d43050100..0a0334dc40d5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -133,10 +133,12 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	bool failed = false;
 
 	cancel_delayed_work_sync(&dev->mt76.mac_work);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
 
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
+	mt7603_beacon_set_timer(dev, -1, 0);
 	mt76_set_channel(&dev->mt76);
 	mt7603_mac_stop(dev);
 
@@ -186,8 +188,12 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt7603_init_edcca(dev);
 
 out:
+	if (!(mt76_hw(dev)->conf.flags & IEEE80211_CONF_OFFCHANNEL))
+		mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
 	mutex_unlock(&dev->mt76.mutex);
 
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
+
 	if (failed)
 		mt7603_mac_work(&dev->mt76.mac_work.work);
 
@@ -535,7 +541,6 @@ mt7603_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7603_dev *dev = hw->priv;
 
 	set_bit(MT76_SCANNING, &dev->mt76.state);
-	mt7603_beacon_set_timer(dev, -1, 0);
 }
 
 static void
@@ -544,7 +549,6 @@ mt7603_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt7603_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
-	mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
 }
 
 static void
-- 
2.20.1

