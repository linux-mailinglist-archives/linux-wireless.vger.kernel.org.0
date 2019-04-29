Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E8DA0DD79
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Apr 2019 10:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727561AbfD2INY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Apr 2019 04:13:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33628 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727439AbfD2INY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Apr 2019 04:13:24 -0400
Received: from localhost.localdomain (unknown [151.66.22.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E4858206BF;
        Mon, 29 Apr 2019 08:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556525603;
        bh=IUHRsVcaJNrBDbvIzXB7Vi12fzSsh3tns/loE4eVwaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=b9z5dO/QOZ4jxwBWiXFIgbBBxqviCIm1MoKXIoCx2q7q/U9d4hc0SXaHtSNlzkHJ2
         tiaSWhSQeHUTL+7+QqxojeSEd8kaXC64Pv0WL3ww4y5Z9kHU3T60J1hHOtjc80pBLh
         8wXe5aNwJDDczBnto2vSFoukutSZnFwnoMBu7/TM=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH v2 5/5] mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel
Date:   Mon, 29 Apr 2019 10:13:02 +0200
Message-Id: <ad6f286f30e8d9080320164a5551c2ee37bd6a95.1556525110.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1556525110.git.lorenzo@kernel.org>
References: <cover.1556525110.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7603/main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index be5d43050100..d879efc5a216 100644
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
 
@@ -186,8 +188,11 @@ mt7603_set_channel(struct mt7603_dev *dev, struct cfg80211_chan_def *def)
 	mt7603_init_edcca(dev);
 
 out:
+	mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
 	mutex_unlock(&dev->mt76.mutex);
 
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
+
 	if (failed)
 		mt7603_mac_work(&dev->mt76.mac_work.work);
 
@@ -535,7 +540,6 @@ mt7603_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt7603_dev *dev = hw->priv;
 
 	set_bit(MT76_SCANNING, &dev->mt76.state);
-	mt7603_beacon_set_timer(dev, -1, 0);
 }
 
 static void
@@ -544,7 +548,6 @@ mt7603_sw_scan_complete(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
 	struct mt7603_dev *dev = hw->priv;
 
 	clear_bit(MT76_SCANNING, &dev->mt76.state);
-	mt7603_beacon_set_timer(dev, -1, dev->mt76.beacon_int);
 }
 
 static void
-- 
2.20.1

