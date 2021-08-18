Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E28DB3EFF15
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Aug 2021 10:23:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbhHRIYA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 18 Aug 2021 04:24:00 -0400
Received: from mail.kernel.org ([198.145.29.99]:38402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238150AbhHRIYA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 18 Aug 2021 04:24:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1CF9961029;
        Wed, 18 Aug 2021 08:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1629275005;
        bh=lrpjMlBZ1+c30pHZNbaEyLUw/KqaZ8P7olUcW7Qb1oc=;
        h=From:To:Cc:Subject:Date:From;
        b=NSS4Il13kT/o1qVcHwsalwOHek2QEbn0Q7uHMS6ZhPCFTROcSPOCiSzNyfhwQE+ep
         SQ6gI7dqH4KEvZqPP9/EXFeMqRDgU5WNNdp+I0QjP+gFOB2LuYcM81lZD5rMgWl6JW
         ELa1q862a83+d7mFwkHs99yfzyLb9Hl58sI17K4Qn65aB7AQuoSuTljyHqVB4ZqXZz
         Zn84uaRpX1PXX7Ompglm8dmsHiC854G4Pew24PdfRL6VBCAYNwVdlFwagR1l6Dl9TR
         2aaChZOA9DXOlW+rfrdzyK0RpIzDcmXWvfXvEH7BqCX3MbNLLeeyVgR4ee/zKvq1mm
         aClEIVDKLuV9w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7921: update mib counters dumping phy stats
Date:   Wed, 18 Aug 2021 10:23:14 +0200
Message-Id: <3e43418eb41d14dbed1d37bf9dc13f1c1094f87a.1629274904.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7921 mac work can be idle for a long time due to runtime-pm so
update mib counters dumping phy stats

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 2 ++
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c     | 3 +--
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h  | 1 +
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 599e6e53e94f..11f8acf4f59e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -68,6 +68,8 @@ mt7921_ampdu_stat_read_phy(struct mt7921_phy *phy,
 	if (!phy)
 		return;
 
+	mt7921_mac_update_mib_stats(phy);
+
 	/* Tx ampdu stat */
 	for (i = 0; i < ARRAY_SIZE(range); i++)
 		range[i] = mt76_rr(dev, MT_MIB_ARNG(0, i));
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1ecb323a99fe..87f73acd181c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1487,8 +1487,7 @@ void mt7921_reset(struct mt76_dev *mdev)
 	queue_work(dev->mt76.wq, &dev->reset_work);
 }
 
-static void
-mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
+void mt7921_mac_update_mib_stats(struct mt7921_phy *phy)
 {
 	struct mt7921_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 547f777beb15..5aac76dba90c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -338,6 +338,7 @@ void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7921_mac_work(struct work_struct *work);
 void mt7921_mac_reset_work(struct work_struct *work);
+void mt7921_mac_update_mib_stats(struct mt7921_phy *phy);
 void mt7921_reset(struct mt76_dev *mdev);
 void mt7921_tx_cleanup(struct mt7921_dev *dev);
 int mt7921_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
-- 
2.31.1

