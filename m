Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 362714823C4
	for <lists+linux-wireless@lfdr.de>; Fri, 31 Dec 2021 12:36:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbhLaLgO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 31 Dec 2021 06:36:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40226 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbhLaLgO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 31 Dec 2021 06:36:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E2340B81D72
        for <linux-wireless@vger.kernel.org>; Fri, 31 Dec 2021 11:36:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CE94C36AEA;
        Fri, 31 Dec 2021 11:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640950570;
        bh=0lv7bmaHgkW1YigwoZ315t0CBlNONLGdakWjZz605cw=;
        h=From:To:Cc:Subject:Date:From;
        b=U9Ym8jDuYnMCtr4iFZEtaflhBg2BGcvvXNTU82iRxIKiA7aWKdfqtAhTVcLkrBUwE
         8lF0sz5RtUKe0X/hv0VbQnNM8gdoQIBFzMphAY1Flm/2dWQ0wx6AbowlURs8R9pd0N
         K/EeES2xDUenJ/8Y1bcFH5NA/FuB3js84hkveWYX+XO0MjxqmlqBR6Q9dcGrwxQwJV
         N9bhkKWs3ztz4odhGodOt7XvgFbE/U3gSoPzWQB9dn6csiG65gfcV+0JPQZhl3KpYG
         RNmW30Ku+hepSRriqqHhzdg62uYjN97kD9EZf/bOsNhl2deVtK8W50+xQ34HgyRXj9
         ugl+nl8Ok+JpQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH] mt76: mt7921: do not always disable fw runtime-pm
Date:   Fri, 31 Dec 2021 12:36:02 +0100
Message-Id: <910ea351fa27e39b9116a3895090291235e24b4b.1640950454.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

After commit 'd430dffbe9dd ("mt76: mt7921: fix a possible race
enabling/disabling runtime-pm")', runtime-pm is always disabled in the
fw even if the user requests to enable it toggling debugfs node since
mt7921_pm_interface_iter routine will use pm->enable to configure the fw.
Fix the issue moving enable variable configuration before running
mt7921_pm_interface_iter routine.

Fixes: d430dffbe9dd ("mt76: mt7921: fix a possible race enabling/disabling runtime-pm")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
index 86fd7292b229..45a393070e46 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c
@@ -291,13 +291,12 @@ mt7921_pm_set(void *data, u64 val)
 	pm->enable = false;
 	mt76_connac_pm_wake(&dev->mphy, pm);
 
+	pm->enable = val;
 	ieee80211_iterate_active_interfaces(mt76_hw(dev),
 					    IEEE80211_IFACE_ITER_RESUME_ALL,
 					    mt7921_pm_interface_iter, dev);
 
 	mt76_connac_mcu_set_deep_sleep(&dev->mt76, pm->ds_enable);
-
-	pm->enable = val;
 	mt76_connac_power_save_sched(&dev->mphy, pm);
 out:
 	mutex_unlock(&dev->mt76.mutex);
-- 
2.33.1

