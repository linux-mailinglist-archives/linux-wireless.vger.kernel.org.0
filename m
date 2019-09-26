Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBF2BF7E0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2019 19:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727892AbfIZRrp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Sep 2019 13:47:45 -0400
Received: from nbd.name ([46.4.11.11]:55250 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727826AbfIZRrg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Sep 2019 13:47:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=References:In-Reply-To:Message-Id:Date:Subject:To:From:Sender:
        Reply-To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=FaPWRtcvZt4wgu9SBJnKFlsj0MklFNZ4uMaHppXKDOk=; b=MuL4OyNu4kMLOdlwDklEto3YGu
        rqcTJEMvzoQ7TlpPkPf+VuFwCHfmWJ7ihpOqnjYuCNjpvMrtZOiv+i/Avc6B0QGJUVVYzNFp99cPT
        +D8MYT2FtcJvB0kTXu3i4Baim7PPBOe3ToerqOosvbDc/AuLtcj2BvTDExdngmzRi5Vc=;
Received: from p54ae9b80.dip0.t-ipconnect.de ([84.174.155.128] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1iDXra-0000yn-3b
        for linux-wireless@vger.kernel.org; Thu, 26 Sep 2019 19:47:34 +0200
Received: by maeck.local (Postfix, from userid 501)
        id B729F69B6A8A; Thu, 26 Sep 2019 19:47:32 +0200 (CEST)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 08/15] mt76: unify channel survey update code
Date:   Thu, 26 Sep 2019 19:47:25 +0200
Message-Id: <20190926174732.42375-8-nbd@nbd.name>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20190926174732.42375-1-nbd@nbd.name>
References: <20190926174732.42375-1-nbd@nbd.name>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Host time is used to calculate the channel active time on mt7603 and mt7615.
Use the same on mt76x02 and move the lock to core code to get rid of some
duplicated code.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 16 +++++++++++++--
 .../net/wireless/mediatek/mt76/mt7603/mac.c   | 15 +-------------
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 18 +++--------------
 .../net/wireless/mediatek/mt76/mt76x0/main.c  |  5 +----
 .../net/wireless/mediatek/mt76/mt76x02_mac.c  | 20 ++++++++++---------
 .../net/wireless/mediatek/mt76/mt76x02_mac.h  |  1 +
 .../wireless/mediatek/mt76/mt76x2/pci_main.c  |  5 +----
 .../wireless/mediatek/mt76/mt76x2/usb_main.c  |  5 +----
 8 files changed, 33 insertions(+), 52 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 5fcadd712f89..5aba8bc0b086 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -416,13 +416,25 @@ mt76_channel_state(struct mt76_dev *dev, struct ieee80211_channel *c)
 
 void mt76_update_survey(struct mt76_dev *dev)
 {
-	struct mt76_channel_state *state;
+	struct mt76_channel_state *state = dev->chan_state;
+	ktime_t cur_time;
+
+	if (!test_bit(MT76_STATE_RUNNING, &dev->state))
+		return;
+
+	spin_lock_bh(&dev->cc_lock);
 
 	if (dev->drv->update_survey)
 		dev->drv->update_survey(dev);
 
+	cur_time = ktime_get_boottime();
+	state->cc_active += ktime_to_us(ktime_sub(cur_time,
+						  dev->survey_time));
+	dev->survey_time = cur_time;
+
+	spin_unlock_bh(&dev->cc_lock);
+
 	if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME) {
-		state = mt76_channel_state(dev, dev->chandef.chan);
 		spin_lock_bh(&dev->rx_lock);
 		spin_lock(&dev->cc_lock);
 		state->cc_bss_rx += dev->cur_cc_bss_rx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index 8e6568d4505b..1497d5ec649e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1571,22 +1571,9 @@ void mt7603_update_channel(struct mt76_dev *mdev)
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 	struct mt76_channel_state *state;
-	ktime_t cur_time;
-	u32 busy;
-
-	if (!test_bit(MT76_STATE_RUNNING, &dev->mt76.state))
-		return;
 
 	state = mdev->chan_state;
-	busy = mt76_rr(dev, MT_MIB_STAT_CCA);
-
-	spin_lock_bh(&dev->mt76.cc_lock);
-	cur_time = ktime_get_boottime();
-	state->cc_busy += busy;
-	state->cc_active += ktime_to_us(ktime_sub(cur_time,
-						  dev->mt76.survey_time));
-	dev->mt76.survey_time = cur_time;
-	spin_unlock_bh(&dev->mt76.cc_lock);
+	state->cc_busy += mt76_rr(dev, MT_MIB_STAT_CCA);
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 81f45c4ccc26..271f36f4acb3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1263,23 +1263,11 @@ void mt7615_update_channel(struct mt76_dev *mdev)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt76_channel_state *state;
-	ktime_t cur_time;
-	u32 busy;
 
-	if (!test_bit(MT76_STATE_RUNNING, &mdev->state))
-		return;
-
-	state = mdev->chan_state;
 	/* TODO: add DBDC support */
-	busy = mt76_get_field(dev, MT_MIB_SDR16(0), MT_MIB_BUSY_MASK);
-
-	spin_lock_bh(&mdev->cc_lock);
-	cur_time = ktime_get_boottime();
-	state->cc_busy += busy;
-	state->cc_active += ktime_to_us(ktime_sub(cur_time,
-						  mdev->survey_time));
-	mdev->survey_time = cur_time;
-	spin_unlock_bh(&mdev->cc_lock);
+	state = mdev->chan_state;
+	state->cc_busy += mt76_get_field(dev, MT_MIB_SDR16(0),
+					 MT_MIB_BUSY_MASK);
 }
 
 void mt7615_mac_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
index efb7ca93863d..f7682bd2e5a8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/main.c
@@ -19,10 +19,7 @@ mt76x0_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76_set_channel(&dev->mt76);
 	mt76x0_phy_set_channel(dev, chandef);
 
-	/* channel cycle counters read-and-clear */
-	mt76_rr(dev, MT_CH_IDLE);
-	mt76_rr(dev, MT_CH_BUSY);
-
+	mt76x02_mac_cc_reset(dev);
 	mt76x02_edcca_init(dev);
 
 	if (mt76_is_mmio(dev)) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
index c987e57db0b4..e49d0136adbc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.c
@@ -984,17 +984,9 @@ void mt76x02_update_channel(struct mt76_dev *mdev)
 {
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
 	struct mt76_channel_state *state;
-	u32 active, busy;
 
 	state = mdev->chan_state;
-
-	busy = mt76_rr(dev, MT_CH_BUSY);
-	active = busy + mt76_rr(dev, MT_CH_IDLE);
-
-	spin_lock_bh(&dev->mt76.cc_lock);
-	state->cc_busy += busy;
-	state->cc_active += active;
-	spin_unlock_bh(&dev->mt76.cc_lock);
+	state->cc_busy += mt76_rr(dev, MT_CH_BUSY);
 }
 EXPORT_SYMBOL_GPL(mt76x02_update_channel);
 
@@ -1152,6 +1144,16 @@ void mt76x02_mac_work(struct work_struct *work)
 				     MT_MAC_WORK_INTERVAL);
 }
 
+void mt76x02_mac_cc_reset(struct mt76x02_dev *dev)
+{
+	dev->mt76.survey_time = ktime_get_boottime();
+
+	/* channel cycle counters read-and-clear */
+	mt76_rr(dev, MT_CH_BUSY);
+	mt76_rr(dev, MT_CH_IDLE);
+}
+EXPORT_SYMBOL_GPL(mt76x02_mac_cc_reset);
+
 void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *addr)
 {
 	idx &= 7;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
index b687341236c0..48de8eb82856 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mac.h
@@ -193,6 +193,7 @@ void mt76x02_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 void mt76x02_update_channel(struct mt76_dev *mdev);
 void mt76x02_mac_work(struct work_struct *work);
 
+void mt76x02_mac_cc_reset(struct mt76x02_dev *dev);
 void mt76x02_mac_set_bssid(struct mt76x02_dev *dev, u8 idx, const u8 *addr);
 int mt76x02_mac_set_beacon(struct mt76x02_dev *dev, u8 vif_idx,
 			   struct sk_buff *skb);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
index 385960dca906..1387f3172d7f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci_main.c
@@ -52,10 +52,7 @@ mt76x2_set_channel(struct mt76x02_dev *dev, struct cfg80211_chan_def *chandef)
 	mt76x2_mac_stop(dev, true);
 	ret = mt76x2_phy_set_channel(dev, chandef);
 
-	/* channel cycle counters read-and-clear */
-	mt76_rr(dev, MT_CH_IDLE);
-	mt76_rr(dev, MT_CH_BUSY);
-
+	mt76x02_mac_cc_reset(dev);
 	mt76x02_dfs_init_params(dev);
 
 	mt76x2_mac_resume(dev);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
index 1e6f78760dd8..a76a40dcd261 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_main.c
@@ -49,10 +49,7 @@ mt76x2u_set_channel(struct mt76x02_dev *dev,
 
 	err = mt76x2u_phy_set_channel(dev, chandef);
 
-	/* channel cycle counters read-and-clear */
-	mt76_rr(dev, MT_CH_IDLE);
-	mt76_rr(dev, MT_CH_BUSY);
-
+	mt76x02_mac_cc_reset(dev);
 	mt76x2_mac_resume(dev);
 
 	clear_bit(MT76_RESET, &dev->mt76.state);
-- 
2.17.0

