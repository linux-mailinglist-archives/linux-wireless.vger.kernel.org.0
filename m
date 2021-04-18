Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E92363636C7
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235024AbhDRQqm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:46:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:49916 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232212AbhDRQql (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:46:41 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3EBFE613AC;
        Sun, 18 Apr 2021 16:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618764373;
        bh=Vd5R9A1ry2HAhGFDCr1riu0i8AWKuhyQDpw6Tx7ChJk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ri4jM2NAduqYFGr1XwvvHHQGPpDjNNHeuORvsVNQG4JqfneNLaWBccrc32xYJM4hN
         UxbDbZGYwnhT+GYS2dy6EBrPCBPuz27Aj1Nk/kSECigNTffhABNlsFM34jdk9IbcgV
         LY8USTreFLjHBjITdRjaoIRpRz4w3AxqISVrmZCjX8l68rRX5XYGO/MhHkF4gxam2L
         HN5UaVT2ebdEdAYCC9/JXdOK/WD3fBz7JihsdTHBdtwlh6LfL2fMsRFWo4/mI20Dgy
         QnNrJO42obQWeZrwR2yM7X7XCj9HX2AE1HVLIqD7RSl2s3/U7jRSy0XaCA2CgG0upR
         m+MXc2LHUXJ0w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH 13/19] mt76: connac: alaways wake the device before scanning
Date:   Sun, 18 Apr 2021 18:45:39 +0200
Message-Id: <02bf17b1a3a753a84bfad1662469e7647ee03d64.1618763001.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618763000.git.lorenzo@kernel.org>
References: <cover.1618763000.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

move scanning check from mt76_connac_power_save_sched routine
to mt7921_pm_power_save_work/mt7615_pm_power_save_work ones

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c      | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c | 8 --------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 4 ++++
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ad1e236727cb..adbc726149a9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1931,6 +1931,10 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 						pm.ps_work.work);
 
 	delta = dev->pm.idle_timeout;
+	if (test_bit(MT76_HW_SCANNING, &dev->mphy.state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &dev->mphy.state))
+		goto out;
+
 	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
 		delta = dev->pm.last_activity + delta - jiffies;
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index 32d664ac1e35..a263921d9f42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -17,10 +17,6 @@ int mt76_connac_pm_wake(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 	if (!test_bit(MT76_STATE_PM, &phy->state))
 		return 0;
 
-	if (test_bit(MT76_HW_SCANNING, &phy->state) ||
-	    test_bit(MT76_HW_SCHED_SCANNING, &phy->state))
-		return 0;
-
 	if (queue_work(dev->wq, &pm->wake_work))
 		reinit_completion(&pm->wake_cmpl);
 
@@ -46,10 +42,6 @@ void mt76_connac_power_save_sched(struct mt76_phy *phy,
 
 	pm->last_activity = jiffies;
 
-	if (test_bit(MT76_HW_SCANNING, &phy->state) ||
-	    test_bit(MT76_HW_SCHED_SCANNING, &phy->state))
-		return;
-
 	if (!test_bit(MT76_STATE_PM, &phy->state))
 		queue_delayed_work(dev->wq, &pm->ps_work, pm->idle_timeout);
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 5dcb574a2768..90ede75cfba8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1542,6 +1542,10 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 						pm.ps_work.work);
 
 	delta = dev->pm.idle_timeout;
+	if (test_bit(MT76_HW_SCANNING, &dev->mphy.state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &dev->mphy.state))
+		goto out;
+
 	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
 		delta = dev->pm.last_activity + delta - jiffies;
 		goto out;
-- 
2.30.2

