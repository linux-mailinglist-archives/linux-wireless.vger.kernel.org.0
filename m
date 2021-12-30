Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 173AA482053
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 21:47:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242129AbhL3UrY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Dec 2021 15:47:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhL3UrY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Dec 2021 15:47:24 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1980C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 12:47:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97B076175E
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 20:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4F0AC36AE7;
        Thu, 30 Dec 2021 20:47:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640897242;
        bh=yNUPp+rot4IrD4b61dLI7v633eGWz1ZDmrYfpqFKotw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KRVB+c9+H/LCbrLGtzvK92AxEy1un9pxynWuF0/12BqiPRBoTapfRRQ38PcCcRyvl
         bVriRfZwvM4x9SYnQhodmDY5Kg134hiKleFd0piAB9EzHfuGWHacqw0tw743aYT9MZ
         qrHAZsc04mkUZ5vUE0zJANTJLm7aLHt4WOuxls0ESDar1ZwQQaCVCTMsAXaQitw1Y4
         mf+8UaXzw5it+JJsdw/mOTA2niaydVVOVt9ZbiDbbDPS+2zqRof56DJHXs/XeZsp+D
         1uWvOGU2DqoY0nYet49VbgzHbq82R+T1gwPN+S1QLFyIgp38zC6mTuZgMBb/sa6nMp
         Yr1Qf0e04BQlQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH 2/2] mt76: mt7615: fix a leftover race in runtime-pm
Date:   Thu, 30 Dec 2021 21:47:06 +0100
Message-Id: <3fd85e4025afdb6d37059071bcc18575ce3ef575.1640897147.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640897147.git.lorenzo@kernel.org>
References: <cover.1640897147.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible race in mt7615_pm_power_save_work() if rx/tx napi
schedules ps_work and we are currently accessing device register
on a different cpu.

Fixes: db928f1ab9789 ("mt76: mt7663: rely on mt76_connac_pm_ref/mt76_connac_pm_unref in tx/rx napi")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 2d81cbf2600c..bc72791cdcb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2131,6 +2131,14 @@ void mt7615_pm_power_save_work(struct work_struct *work)
 	    test_bit(MT76_HW_SCHED_SCANNING, &dev->mphy.state))
 		goto out;
 
+	if (mutex_is_locked(&dev->mt76.mutex))
+		/* if mt76 mutex is held we should not put the device
+		 * to sleep since we are currently accessing device
+		 * register map. We need to wait for the next power_save
+		 * trigger.
+		 */
+		goto out;
+
 	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
 		delta = dev->pm.last_activity + delta - jiffies;
 		goto out;
-- 
2.33.1

