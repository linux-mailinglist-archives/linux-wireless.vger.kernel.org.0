Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EBDE8BF7DB
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbfIZRrm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:42 -0400
Received: from nbd.name ([46.4.11.11]:55248 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727827AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=l5C1QekK0Ir662dxIC9EX+bEBywEnVBn/SD2ATbPhrI=; b=tEso1y+knUoYqPGs5WqP51DVmM
        HDoX8BkXHoy4b/UDSWbSVR3tCltHFauVAogjJd3aQ/f0eD5s/ctS4d1bVuG70ZdrXQNeXaqSg/t5H
        N9YmChSOKJRw/ZsMJjo2LMnpogQ+jA/gV6sbcmGyTEO18grVRg3CZyGT+RYi6JbERXfg=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000ym-2C
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B614B69B6A87; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/15] mt76: store current channel survey_state in struct mt76_dev
Date:   Thu, 26 Sep 2019 19:47:21 +0200
Message-Id: <20190926174732.42375-4-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt76_channel_state() from mt76.h to mac80211.c
Preparation for updating channel state from more places in the drivers/core

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 24 +++++++++++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 16 +------------
 .../net/wireless/mediatek/mt76/mt7603/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7615/mac.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  |  2 +-
 5 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index cc301216e527..aefdd22d74ef 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -180,6 +180,7 @@ mt76_init_sband(struct mt76_dev *dev, struct mt76_sband *msband,
 	sband->bitrates = rates;
 	sband->n_bitrates = n_rates;
 	dev->chandef.chan = &sband->channels[0];
+	dev->chan_state = &msband->chan[0];
 
 	ht_cap = &sband->ht_cap;
 	ht_cap->ht_supported = true;
@@ -398,11 +399,25 @@ bool mt76_has_tx_pending(struct mt76_dev *dev)
 }
 EXPORT_SYMBOL_GPL(mt76_has_tx_pending);
 
+static struct mt76_channel_state *
+mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
+{
+	struct mt76_sband *msband;
+	int idx;
+
+	if (c->band == NL80211_BAND_2GHZ)
+		msband = &dev->sband_2g;
+	else
+		msband = &dev->sband_5g;
+
+	idx = c - &msband->sband.channels[0];
+	return &msband->chan[idx];
+}
+
 void mt76_set_channel(struct mt76_dev *dev)
 {
 	struct ieee80211_hw *hw = dev->hw;
 	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
-	struct mt76_channel_state *state;
 	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 	int timeout = HZ / 5;
 
@@ -412,14 +427,13 @@ void mt76_set_channel(struct mt76_dev *dev)
 		dev->drv->update_survey(dev);
 
 	dev->chandef = *chandef;
+	dev->chan_state = mt76_channel_state(dev, chandef->chan);
 
 	if (!offchannel)
 		dev->main_chan = chandef->chan;
 
-	if (chandef->chan != dev->main_chan) {
-		state = mt76_channel_state(dev, chandef->chan);
-		memset(state, 0, sizeof(*state));
-	}
+	if (chandef->chan != dev->main_chan)
+		memset(dev->chan_state, 0, sizeof(*dev->chan_state));
 }
 EXPORT_SYMBOL_GPL(mt76_set_channel);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index af71773c2d55..3e4ababcae9b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -423,6 +423,7 @@ struct mt76_dev {
 	struct cfg80211_chan_def chandef;
 	struct ieee80211_channel *main_chan;
 
+	struct mt76_channel_state *chan_state;
 	spinlock_t lock;
 	spinlock_t cc_lock;
 
@@ -603,21 +604,6 @@ static inline u16 mt76_rev(struct mt76_dev *dev)
 #define mt76_queue_tx_cleanup(dev, ...)	(dev)->mt76.queue_ops->tx_cleanup(&((dev)->mt76), __VA_ARGS__)
 #define mt76_queue_kick(dev, ...)	(dev)->mt76.queue_ops->kick(&((dev)->mt76), __VA_ARGS__)
 
-static inline struct mt76_channel_state *
-mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
-{
-	struct mt76_sband *msband;
-	int idx;
-
-	if (c->band == NL80211_BAND_2GHZ)
-		msband = &dev->sband_2g;
-	else
-		msband = &dev->sband_5g;
-
-	idx = c - &msband->sband.channels[0];
-	return &msband->chan[idx];
-}
-
 struct mt76_dev *mt76_alloc_device(struct device *pdev, unsigned int size,
 				   const struct ieee80211_ops *ops,
 				   const struct mt76_driver_ops *drv_ops);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 44d093943588..3d160230d929 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1491,7 +1491,7 @@ void mt7603_update_channel(struct mt76_dev *mdev)
 	if (!test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
 		return;
 
-	state = mt76_channel_state(&dev->mt76, dev->mt76.chandef.chan);
+	state = mdev->chan_state;
 	busy = mt76_rr(dev, MT_MIB_STAT_PSCCA);
 
 	spin_lock_bh(&dev->mt76.cc_lock);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 88271524fb83..9189a86d7825 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1269,7 +1269,7 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 	if (!test_bit(MT76_STATE_RUNNING, &mdev->state))
 		return;
 
-	state = mt76_channel_state(mdev, mdev->chandef.chan);
+	state = mdev->chan_state;
 	/* TODO: add DBDC support */
 	busy = mt76_get_field(dev, MT_MIB_SDR16(0), MT_MIB_BUSY_MASK);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index 9d2795c1e943..f73ec17e5f47 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -986,7 +986,7 @@ void mt76x02_update_channel(struct mt76_dev *mdev)
 	struct mt76_channel_state *state;
 	u32 active, busy;
 
-	state = mt76_channel_state(&dev->mt76, dev->mt76.chandef.chan);
+	state = mdev->chan_state;
 
 	busy = mt76_rr(dev, MT_CH_BUSY);
 	active = busy + mt76_rr(dev, MT_CH_IDLE);
-- 
2.17.0

