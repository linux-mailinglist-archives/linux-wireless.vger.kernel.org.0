Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC76147C114
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Dec 2021 14:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhLUN50 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Dec 2021 08:57:26 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:41494 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235373AbhLUN5Z (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Dec 2021 08:57:25 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5F3BCB811BE
        for <linux-wireless@vger.kernel.org>; Tue, 21 Dec 2021 13:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5960CC36AEA;
        Tue, 21 Dec 2021 13:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640095043;
        bh=HTGUh1wxK0aSCU501JaapdzxR6d52kkCl7yfWa55bJo=;
        h=From:To:Cc:Subject:Date:From;
        b=t3aNN88rzVCEHbUELZ5jBNiSvMsJRiy5PxcEIY/I29Wt/yfqME9ec9qpjDj3OBY1D
         a8WtWIErj9ZppCnku3BWMfnD7u9lzL1/UYP+6rA9MRmPQtxvBfedd94bTTEMr9R3Xa
         ZB+ei1j5M/ofVsHJMrrr+QXqHaLvND46frSzDVvbQwEBdFELA3qSUlh0BOifMYjrtX
         KRDecmZ61UioK00MmOfcoKobJLLrog5Dek318CgjtnInVW86Vzntar0LxCUWh7hnRk
         ShNR/WAKWaWvE9rcGkT8H5pPqQ5cbjA0pfwsA7K7EMHqdTA0UzTq+/LAzEaYLfzr0e
         OfWAvRMWPOP9w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     kvalo@kernel.org
Cc:     nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, deren.wu@mediatek.com,
        sean.wang@mediatek.com, sven@narfation.org
Subject: [PATCH wireless-drivers] mt76: mt7921: fix a possible race enabling/disabling runtime-pm
Date:   Tue, 21 Dec 2021 14:57:09 +0100
Message-Id: <0f3e075a2033dc05f09dab4059e5be8cbdccc239.1640094847.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible race enabling/disabling runtime-pm between
mt7921_pm_set() and mt7921_poll_rx() since mt7921_pm_wake_work()
always schedules rx-napi callback and it will trigger
mt7921_pm_power_save_work routine putting chip to in low-power state
during mt7921_pm_set processing.

Suggested-by: Deren Wu <deren.wu@mediatek.com>
Tested-by: Deren Wu <deren.wu@mediatek.com>
Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  3 ---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  | 12 +++++++++---
 2 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index af43bcb54578..306e9eaea917 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -7,9 +7,6 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
 	struct mt76_dev *dev = phy->dev;
 
-	if (!pm->enable)
-		return 0;
-
 	if (mt76_is_usb(dev))
 		return 0;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 7cdfdf83529f..86fd7292b229 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -276,7 +276,7 @@ mt7921_pm_set(void *data, u64 val)
 	struct mt7921_dev *dev = data;
 	struct mt76_connac_pm *pm = &dev->pm;
 
-	mt7921_mutex_acquire(dev);
+	mutex_lock(&dev->mt76.mutex);
 
 	if (val == pm->enable)
 		goto out;
@@ -285,7 +285,11 @@ mt7921_pm_set(void *data, u64 val)
 		pm->stats.last_wake_event = jiffies;
 		pm->stats.last_doze_event = jiffies;
 	}
-	pm->enable = val;
+	/* make sure the chip is awake here and ps_work is scheduled
+	 * just at end of the this routine.
+	 */
+	pm->enable = false;
+	mt76_connac_pm_wake(&dev->mphy, pm);
 
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
@@ -293,8 +297,10 @@ mt7921_pm_set(void *data, u64 val)
 
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
 
+	pm->enable = val;
+	mt76_connac_power_save_sched(&dev->mphy, pm);
 out:
-	mt7921_mutex_release(dev);
+	mutex_unlock(&dev->mt76.mutex);
 
 	return 0;
 }
-- 
2.33.1

