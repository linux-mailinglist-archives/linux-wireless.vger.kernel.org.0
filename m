Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50C1A482052
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Dec 2021 21:47:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbhL3UrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Dec 2021 15:47:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242120AbhL3UrX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Dec 2021 15:47:23 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96B6C061574
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 12:47:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92AC4B81D0C
        for <linux-wireless@vger.kernel.org>; Thu, 30 Dec 2021 20:47:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18820C36AEB;
        Thu, 30 Dec 2021 20:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640897240;
        bh=KSnKXK1DNQwCsaL3ThC9UdTMyty2vZpwfSQGblqSP1o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1Ak+0jQE/TsazMfR+lggQH5CkcsxfedXfOc5a1fuAdWE8/REW7tpRGS4k82uhDC3
         2ZcL+9zmL+S/LrrRKCQRg4AyqJG66k8mMl55Z9D9UZMfANH7KV+T82iJaXebG43Oea
         2xGyGyXg1yeEmelgwbmGz4uvAPm7Zs5iKK6ZBTWPNPayAtapCH3KWD2byfkIR8sL53
         eN1d1AW5ox8rGM6ScW+Y06UoA2CZ1u05E7+Ues79hx/H4gAUAXz6xPtM2vo+zPaupv
         UHvNf/G+cz1WEC9c6Ub26gLIKjrOqYjiuxrgnBN9ECPHJSel9XZ9ly9u/O62BU2HdF
         MGMgPdNkMIG6A==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, deren.wu@mediatek.com
Subject: [PATCH 1/2] mt76: mt7921: fix a leftover race in runtime-pm
Date:   Thu, 30 Dec 2021 21:47:05 +0100
Message-Id: <65e65daddbcec420392befa3b4f9a6aaaea21315.1640897147.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1640897147.git.lorenzo@kernel.org>
References: <cover.1640897147.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix a possible race in mt7921_pm_power_save_work() if rx/tx napi
schedules ps_work and we are currently accessing device register
on a different cpu.

Fixes: 1d8efc741df8 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index defef3496246..0744f6e42ba3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1553,6 +1553,14 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 	    dev->fw_assert)
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

