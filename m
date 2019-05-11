Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8AB121A787
	for <lists+linux-wireless@lfdr.de>; Sat, 11 May 2019 12:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728558AbfEKKSZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 May 2019 06:18:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:36884 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728477AbfEKKSY (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 May 2019 06:18:24 -0400
Received: from localhost.localdomain (unknown [151.66.17.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 12608217D6;
        Sat, 11 May 2019 10:18:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1557569904;
        bh=pv0kdXkV/3VWKDOn3NdE7Ugd4BmGXe07DN7I1MYp3mA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EB4ZT6nzN8KOT4D/oh/sbqlq7mvGPZwq2OjcS4ieJk/gfQJkkj2eNIH7SqKGogE+6
         MU1s3wMmOVcGYwMmfBz3lcGmrTZLOlKmtRM6lk516fJ9KhGbk/HnJZOxi6VkArMlXl
         F0lnYyzvladtHHmIP2F+Y+rkmOJXmgDF+54WNrMc=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com
Subject: [PATCH 3/4] mt76: mt76x2: move mutex_lock inside mt76x2_set_channel
Date:   Sat, 11 May 2019 12:17:53 +0200
Message-Id: <1527e88fc4a307aa218f515811f2f2c15786caec.1557567465.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557567465.git.lorenzo@kernel.org>
References: <cover.1557567465.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a preliminary patch to run mt76x02_edcca_init atomically

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  | 16 ++++++++------
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  | 22 ++++++++++---------
 2 files changed, 21 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index e416eee6a306..3a1467326f4d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -54,14 +54,14 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	int ret;
 
 	cancel_delayed_work_sync(&dev->cal_work);
+	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
+	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
+	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
 	mt76_set_channel(&dev->mt76);
 
-	tasklet_disable(&dev->mt76.pre_tbtt_tasklet);
-	tasklet_disable(&dev->dfs_pd.dfs_tasklet);
-
 	mt76x2_mac_stop(dev, true);
 	ret = mt76x2_phy_set_channel(dev, chandef);
 
@@ -72,10 +72,12 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76x02_dfs_init_params(dev);
 
 	mt76x2_mac_resume(dev);
-	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
-	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
+	mutex_unlock(&dev->mt76.mutex);
+
+	tasklet_enable(&dev->dfs_pd.dfs_tasklet);
+	tasklet_enable(&dev->mt76.pre_tbtt_tasklet);
 
 	mt76_txq_schedule_all(&dev->mt76);
 
@@ -111,14 +113,14 @@ mt76x2_config(struct ieee80211_hw *hw, u32 changed)
 		}
 	}
 
+	mutex_unlock(&dev->mt76.mutex);
+
 	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
 		ieee80211_stop_queues(hw);
 		ret = mt76x2_set_channel(dev, &hw->conf.chandef);
 		ieee80211_wake_queues(hw);
 	}
 
-	mutex_unlock(&dev->mt76.mutex);
-
 	return ret;
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 3351b736603d..e4dfc3bea3c5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -48,21 +48,23 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	int err;
 
 	cancel_delayed_work_sync(&dev->cal_work);
+	dev->beacon_ops->pre_tbtt_enable(dev, false);
+
+	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
 
 	mt76_set_channel(&dev->mt76);
 
-	dev->beacon_ops->pre_tbtt_enable(dev, false);
-
 	mt76x2_mac_stop(dev, false);
 
 	err = mt76x2u_phy_set_channel(dev, chandef);
 
 	mt76x2_mac_resume(dev);
 
-	dev->beacon_ops->pre_tbtt_enable(dev, true);
-
 	clear_bit(MT76_RESET, &dev->mt76.state);
+	mutex_unlock(&dev->mt76.mutex);
+
+	dev->beacon_ops->pre_tbtt_enable(dev, true);
 	mt76_txq_schedule_all(&dev->mt76);
 
 	return err;
@@ -84,12 +86,6 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 		mt76_wr(dev, MT_RX_FILTR_CFG, dev->mt76.rxfilter);
 	}
 
-	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
-		ieee80211_stop_queues(hw);
-		err = mt76x2u_set_channel(dev, &hw->conf.chandef);
-		ieee80211_wake_queues(hw);
-	}
-
 	if (changed & IEEE80211_CONF_CHANGE_POWER) {
 		dev->mt76.txpower_conf = hw->conf.power_level * 2;
 
@@ -102,6 +98,12 @@ mt76x2u_config(struct ieee80211_hw *hw, u32 changed)
 
 	mutex_unlock(&dev->mt76.mutex);
 
+	if (changed & IEEE80211_CONF_CHANGE_CHANNEL) {
+		ieee80211_stop_queues(hw);
+		err = mt76x2u_set_channel(dev, &hw->conf.chandef);
+		ieee80211_wake_queues(hw);
+	}
+
 	return err;
 }
 
-- 
2.20.1

