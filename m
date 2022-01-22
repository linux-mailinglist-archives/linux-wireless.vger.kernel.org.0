Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A807496CB8
	for <lists+linux-wireless@lfdr.de>; Sat, 22 Jan 2022 15:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbiAVOpt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 22 Jan 2022 09:45:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231322AbiAVOps (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 22 Jan 2022 09:45:48 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06589C06173B
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 06:45:47 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C1F64B801C1
        for <linux-wireless@vger.kernel.org>; Sat, 22 Jan 2022 14:45:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97E70C004E1;
        Sat, 22 Jan 2022 14:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642862744;
        bh=52ICxcGMIrkwScsKyfrjabmQiJ/IXsQRVn/oKR8+sEk=;
        h=From:To:Cc:Subject:Date:From;
        b=ESupmXDwEWGn+FBSRXI9nI23N0EaLcMZ1KqpmGyzlXl95oiidPZEECL3iQHsjEnjv
         GC7i/FUMwEjkRqdn2Bq/bJ3VmFW5mRHfDVsU3fr+7A36JRmAdUtQRTdV2gKWh5tWkk
         862uJ2dbrt6K7liaKAliYtb0adZ82Ph4+CZG5XDO+OINboSdNxQAhO9D1jNrjE6jaD
         XzmxUfqY32wFz3q3NUwtTnZ4gMccMaxb/d4clOpvEAJbWXF4nGXNYtpWpkzA9oqPLD
         Hex8d09A/KbZQVzODZvI7ROct8Vn9eTxxDM5hWgWToF123u65XKHCyZLgnoYGdcXAd
         ppnAs3r/LQlkA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7663s: flush runtime-pm queue after waking up the device
Date:   Sat, 22 Jan 2022 15:45:38 +0100
Message-Id: <a60f3d8c08c251b99a3591919732f71907d5166a.1642861435.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add missing mt76_connac_pm_dequeue_skbs routine waking up mt7663s device
from runtime-pm sleep state.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index beb4c8db157d..9970f06063e0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -2095,6 +2095,7 @@ void mt7615_pm_wake_work(struct work_struct *work)
 		int i;
 
 		if (mt76_is_sdio(mdev)) {
+			mt76_connac_pm_dequeue_skbs(mphy, &dev->pm);
 			mt76_worker_schedule(&mdev->sdio.txrx_worker);
 		} else {
 			mt76_for_each_q_rx(mdev, i)
-- 
2.34.1

