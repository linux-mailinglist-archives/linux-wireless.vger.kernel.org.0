Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5D6287D789
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2019 10:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728413AbfHAI0f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 1 Aug 2019 04:26:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:42698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727854AbfHAI0e (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 1 Aug 2019 04:26:34 -0400
Received: from localhost.localdomain.com (nat-pool-mxp-t.redhat.com [149.6.153.186])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D367214DA;
        Thu,  1 Aug 2019 08:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564647993;
        bh=ozkDYgIsM5bE715QXrQM+LFz7Qg+0JXp6zwlbMgKhLU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KV6v9FJhUkIR71ycNOj8g7EmhUBLoL2dQ46UMeSdY3nDwTbxyODY9YawT0JPwMKS1
         hUE6jAYmXZDINBa1VdVXzzfr6xYHTDt66HtdUcHqoU3Na/OtSVrGWi8jn2IPLb8JdH
         bXe6cjK9UlgZ0o5PJhoFu9nDj7e72rXj/LbFmC44=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sgruszka@redhat.com,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] mt76: mt76x02: introduce mt76x02_pre_tbtt_enable and mt76x02_beacon_enable macros
Date:   Thu,  1 Aug 2019 10:26:22 +0200
Message-Id: <924586f0632ecd430a889dc0ad08b05dc788cd55.1564647482.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564647482.git.lorenzo@kernel.org>
References: <cover.1564647482.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Improve code readability introducing mt76x02_pre_tbtt_enable and
mt76x02_beacon_enable utility macros

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x0/main.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt76x02.h         | 5 +++++
 drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c  | 7 +++----
 drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c | 4 ++--
 4 files changed, 12 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index d7bf7bc15e52..3bc665643e51 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -14,7 +14,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	int ret;
 
 	cancel_delayed_work_sync(&dev->cal_work);
-	dev->beacon_ops->pre_tbtt_enable(dev, false);
+	mt76x02_pre_tbtt_enable(dev, false);
 	if (mt76_is_mmio(dev))
 		tasklet_disable(&dev->dfs_pd.dfs_tasklet);
 
@@ -31,7 +31,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 		mt76x02_dfs_init_params(dev);
 		tasklet_enable(&dev->dfs_pd.dfs_tasklet);
 	}
-	dev->beacon_ops->pre_tbtt_enable(dev, true);
+	mt76x02_pre_tbtt_enable(dev, true);
 
 	mt76_txq_schedule_all(&dev->mt76);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02.h b/drivers/net/wireless/mediatek/mt76/mt76x02.h
index f7fd53a1738a..0d562d8e4be0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02.h
@@ -75,6 +75,11 @@ struct mt76x02_beacon_ops {
 	void (*beacon_enable) (struct mt76x02_dev *, bool);
 };
 
+#define mt76x02_beacon_enable(dev, enable)	\
+	(dev)->beacon_ops->beacon_enable((dev), (enable))
+#define mt76x02_pre_tbtt_enable(dev, enable)	\
+	(dev)->beacon_ops->pre_tbtt_enable((dev), (enable))
+
 struct mt76x02_dev {
 	struct mt76_dev mt76; /* must be first */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
index d61c686e08de..089aab74ae99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_beacon.c
@@ -141,8 +141,7 @@ __mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev, u8 vif_idx,
 	      MT_BEACON_TIME_CFG_TBTT_EN |
 	      MT_BEACON_TIME_CFG_TIMER_EN;
 	mt76_rmw(dev, MT_BEACON_TIME_CFG, reg, reg * en);
-
-	dev->beacon_ops->beacon_enable(dev, en);
+	mt76x02_beacon_enable(dev, en);
 }
 
 void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
@@ -151,7 +150,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 	u8 vif_idx = ((struct mt76x02_vif *)vif->drv_priv)->idx;
 	struct sk_buff *skb = NULL;
 
-	dev->beacon_ops->pre_tbtt_enable(dev, false);
+	mt76x02_pre_tbtt_enable(dev, false);
 
 	if (mt76_is_usb(dev))
 		skb = ieee80211_beacon_get(mt76_hw(dev), vif);
@@ -161,7 +160,7 @@ void mt76x02_mac_set_beacon_enable(struct mt76x02_dev *dev,
 
 	__mt76x02_mac_set_beacon_enable(dev, vif_idx, val, skb);
 
-	dev->beacon_ops->pre_tbtt_enable(dev, true);
+	mt76x02_pre_tbtt_enable(dev, true);
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index e4dfc3bea3c5..7e9e44b96671 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -48,7 +48,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	int err;
 
 	cancel_delayed_work_sync(&dev->cal_work);
-	dev->beacon_ops->pre_tbtt_enable(dev, false);
+	mt76x02_pre_tbtt_enable(dev, false);
 
 	mutex_lock(&dev->mt76.mutex);
 	set_bit(MT76_RESET, &dev->mt76.state);
@@ -64,7 +64,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 	clear_bit(MT76_RESET, &dev->mt76.state);
 	mutex_unlock(&dev->mt76.mutex);
 
-	dev->beacon_ops->pre_tbtt_enable(dev, true);
+	mt76x02_pre_tbtt_enable(dev, true);
 	mt76_txq_schedule_all(&dev->mt76);
 
 	return err;
-- 
2.21.0

