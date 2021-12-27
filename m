Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF06747FD3F
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Dec 2021 14:09:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232922AbhL0NJP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Dec 2021 08:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbhL0NJO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Dec 2021 08:09:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CBABC06173E
        for <linux-wireless@vger.kernel.org>; Mon, 27 Dec 2021 05:09:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1AE9160FF8
        for <linux-wireless@vger.kernel.org>; Mon, 27 Dec 2021 13:09:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96EB1C36AEA;
        Mon, 27 Dec 2021 13:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640610553;
        bh=fq3WybTeZrVniTutpifyxcmOUF3+FDU3s+3O6YkeTJk=;
        h=From:To:Cc:Subject:Date:From;
        b=bCkdfPDOk1VaWt7n6ktaCkVqFEF602P9mAr9P6LJe86SWSvgB/crtjzQ0PgdkUmSt
         5hOrg7HhT5MTFmGCQpXduDwC/DnO6SG9S55+L8ehw8WoXu7MGOhtLoxZ8Q4wPOngpb
         Mdpb31iM9G+vUtPV46E7qyXdMcZghL1BEGdM3oVdWSggyr5n/pykDwtBM7I2PByYBO
         2O/V1gd+VBu4FJgsy9hVG3vbRj97oQNH1ctU6UEu+/Xph2vm854E72NiMAoK4+2LDo
         OjSlbo+tPX8AF/dVJGwyFVVfjVmp0vGjSUEM6dWnatlhpolAfzxPlUkZmoW97MlBmL
         uStydi66f3mOg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7615: fix a possible race enabling/disabling runtime-pm
Date:   Mon, 27 Dec 2021 14:08:52 +0100
Message-Id: <9c15fb4f3924ef3b0f8efdc5012d5a027876e3b1.1640610438.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to mt7921 driver, fix a possible race enabling/disabling
runtime-pm between mt7615_pm_set() and mt7615_poll_rx().
mt7615_pm_wake_work() always schedules rx-napi callback and it will
trigger mt7615_pm_power_save_work routine putting the chip in low-power
state even if we are disabling runtime-pm deferring the actual chip wake
at the next access.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/debugfs.c   | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
index b53528014fbc..ca7efca1543f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c
@@ -105,10 +105,10 @@ mt7615_pm_set(void *data, u64 val)
 	if (!mt7615_firmware_offload(dev) || mt76_is_usb(&dev->mt76))
 		return -EOPNOTSUPP;
 
-	if (val == pm->enable)
-		return 0;
+	mutex_lock(&dev->mt76.mutex);
 
-	mt7615_mutex_acquire(dev);
+	if (val == pm->enable)
+		goto out;
 
 	if (dev->phy.n_beacon_vif) {
 		ret = -EBUSY;
@@ -119,9 +119,16 @@ mt7615_pm_set(void *data, u64 val)
 		pm->stats.last_wake_event = jiffies;
 		pm->stats.last_doze_event = jiffies;
 	}
+	/* make sure the chip is awake here and ps_work is scheduled
+	 * just at end of the this routine.
+	 */
+	pm->enable = false;
+	mt76_connac_pm_wake(&dev->mphy, pm);
+
 	pm->enable = val;
+	mt76_connac_power_save_sched(&dev->mphy, pm);
 out:
-	mt7615_mutex_release(dev);
+	mutex_unlock(&dev->mt76.mutex);
 
 	return ret;
 }
-- 
2.33.1

