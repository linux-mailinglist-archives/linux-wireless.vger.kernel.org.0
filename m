Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E69DB217A2E
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jul 2020 23:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgGGVXY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jul 2020 17:23:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:33470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728879AbgGGVXX (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jul 2020 17:23:23 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A4E5D20720;
        Tue,  7 Jul 2020 21:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594157002;
        bh=8Euv1uSfyHgSUBLj4B51Gd91uG2qpZkiBGX9vfcGJ5M=;
        h=From:To:Cc:Subject:Date:From;
        b=e3LL2G3xNgqDaVZLwzGz+Sk2WfUvIr2lps4NPqi5wnAcKCOZ6SQWI66r8eVcwUVjv
         YHFQNGA3GyIAC8PTcJCqIU6JYPb0CBVzgELxdwY+RmB0Uaox6wwEf3WVYDmkfqAHT7
         /iqXJ2oPGGWSR1bWMlp9CkHpYbgLVRnPvNK6K9Sk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: avoid scheduling runtime-pm during hw scan
Date:   Tue,  7 Jul 2020 23:23:11 +0200
Message-Id: <de8d6171b6d40ba993da6795cc414b1171847f8b.1594156813.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Do not schedule ps_work during hw scanning or hw scheduled frequency
scan

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index ea9128b4ae09..f0034e87c600 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -1908,12 +1908,21 @@ void mt7615_pm_power_save_sched(struct mt7615_dev *dev)
 {
 	struct mt76_phy *mphy = dev->phy.mt76;
 
-	if (!mt7615_firmware_offload(dev) ||
-	    !dev->pm.enable || !mt76_is_mmio(mphy->dev) ||
-	    !test_bit(MT76_STATE_RUNNING, &mphy->state))
+	if (!mt7615_firmware_offload(dev))
+		return;
+
+	if (!mt76_is_mmio(mphy->dev))
+		return;
+
+	if (!dev->pm.enable || !test_bit(MT76_STATE_RUNNING, &mphy->state))
 		return;
 
 	dev->pm.last_activity = jiffies;
+
+	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
+		return;
+
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work,
 				   dev->pm.idle_timeout);
-- 
2.26.2

