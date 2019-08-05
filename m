Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 699538129C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2019 08:56:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727552AbfHEG4O (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Aug 2019 02:56:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:56550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726423AbfHEG4O (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Aug 2019 02:56:14 -0400
Received: from localhost.localdomain (unknown [151.66.59.187])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 37834217F4;
        Mon,  5 Aug 2019 06:56:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1564988173;
        bh=kkUgabw6LZHE61YkJKArSM6MCKqfx65leWbkwLwUUfU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xaTIkQRlW/NYetK0d/csqreDFH6ijwpKqfuJBt+ndtXdRkiZ8VFm81nOu3/GIPx6k
         nO7sBSF1SdDSssL4GSCytCUYhWT+R627y/qfdrJy0kQPYJCoBqgFilTWRVVMj6Nvgn
         2kW9VVtArUkzSJ/dUWV3JJNNOTS0KbBZWNHIdmIQ=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sgruszka@redhat.com, ryder.lee@mediatek.com, royluo@google.com
Subject: [PATCH 3/3] mt76: mt7615: enable survey support
Date:   Mon,  5 Aug 2019 08:55:53 +0200
Message-Id: <308604db996fdd29908a29ff003685027163da68.1564987866.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1564987866.git.lorenzo@kernel.org>
References: <cover.1564987866.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce channel survey support for mt7615 driver

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mac.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7615/main.c  |  5 ++++
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  1 +
 .../net/wireless/mediatek/mt76/mt7615/regs.h  |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 1ab4a189e5eb..5c7c371840d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1237,6 +1237,29 @@ mt7615_mac_scs_check(struct mt7615_dev *dev)
 		mt7615_mac_set_default_sensitivity(dev);
 }
 
+void mt7615_update_channel(struct mt76_dev *mdev)
+{
+	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
+	struct mt76_channel_state *state;
+	ktime_t cur_time;
+	u32 busy;
+
+	if (!test_bit(MT76_STATE_RUNNING, &mdev->state))
+		return;
+
+	state = mt76_channel_state(mdev, mdev->chandef.chan);
+	/* TODO: add DBDC support */
+	busy = mt76_get_field(dev, MT_MIB_SDR16(0), MT_MIB_BUSY_MASK);
+
+	spin_lock_bh(&mdev->cc_lock);
+	cur_time = ktime_get_boottime();
+	state->cc_busy += busy;
+	state->cc_active += ktime_to_us(ktime_sub(cur_time,
+						  mdev->survey_time));
+	mdev->survey_time = cur_time;
+	spin_unlock_bh(&mdev->cc_lock);
+}
+
 void mt7615_mac_work(struct work_struct *work)
 {
 	struct mt7615_dev *dev;
@@ -1245,6 +1268,7 @@ void mt7615_mac_work(struct work_struct *work)
 						mac_work.work);
 
 	mutex_lock(&dev->mt76.mutex);
+	mt7615_update_channel(&dev->mt76);
 	if (++dev->mac_work_count == 5) {
 		mt7615_mac_scs_check(dev);
 		dev->mac_work_count = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 6b881e862595..7e263cf1d97d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -16,6 +16,7 @@ static int mt7615_start(struct ieee80211_hw *hw)
 {
 	struct mt7615_dev *dev = hw->priv;
 
+	dev->mt76.survey_time = ktime_get_boottime();
 	set_bit(MT76_STATE_RUNNING, &dev->mt76.state);
 	ieee80211_queue_delayed_work(mt76_hw(dev), &dev->mt76.mac_work,
 				     MT7615_WATCHDOG_TIME);
@@ -149,6 +150,9 @@ static int mt7615_set_channel(struct mt7615_dev *dev)
 
 	ret = mt7615_dfs_init_radar_detector(dev);
 	mt7615_mac_cca_stats_reset(dev);
+	dev->mt76.survey_time = ktime_get_boottime();
+	/* TODO: add DBDC support */
+	mt76_rr(dev, MT_MIB_SDR16(0));
 
 out:
 	clear_bit(MT76_RESET, &dev->mt76.state);
@@ -528,4 +532,5 @@ const struct ieee80211_ops mt7615_ops = {
 	.release_buffered_frames = mt76_release_buffered_frames,
 	.get_txpower = mt76_get_txpower,
 	.channel_switch_beacon = mt7615_channel_switch_beacon,
+	.get_survey = mt76_get_survey,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index c83d1d212ac9..03a8de27d368 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -224,6 +224,7 @@ static inline void mt7615_irq_disable(struct mt7615_dev *dev, u32 mask)
 	mt76_set_irq_mask(&dev->mt76, MT_INT_MASK_CSR, mask, 0);
 }
 
+void mt7615_update_channel(struct mt76_dev *mdev);
 void mt7615_mac_cca_stats_reset(struct mt7615_dev *dev);
 void mt7615_mac_set_scs(struct mt7615_dev *dev, bool enable);
 int mt7615_mac_write_txwi(struct mt7615_dev *dev, __le32 *txwi,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 9e82cb53fd60..e250607e0a80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -81,6 +81,7 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 		.sta_add = mt7615_sta_add,
 		.sta_assoc = mt7615_sta_assoc,
 		.sta_remove = mt7615_sta_remove,
+		.update_survey = mt7615_update_channel,
 	};
 	struct mt7615_dev *dev;
 	struct mt76_dev *mdev;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index 12fc12edf78c..b193814d5cf8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -255,6 +255,9 @@
 #define MT_MIB_RTS_RETRIES_COUNT_MASK	GENMASK(31, 16)
 #define MT_MIB_RTS_COUNT_MASK		GENMASK(15, 0)
 
+#define MT_MIB_SDR16(n)			MT_WF_MIB(0x48 + ((n) << 9))
+#define MT_MIB_BUSY_MASK		GENMASK(23, 0)
+
 #define MT_EFUSE_BASE			0x81070000
 #define MT_EFUSE_BASE_CTRL		0x000
 #define MT_EFUSE_BASE_CTRL_EMPTY	BIT(30)
-- 
2.21.0

