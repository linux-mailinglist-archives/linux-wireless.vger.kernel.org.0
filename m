Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993EF36949E
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 16:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238948AbhDWO17 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 10:27:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48772 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231220AbhDWO16 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 10:27:58 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0B54661458;
        Fri, 23 Apr 2021 14:27:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619188042;
        bh=aITc/pZfy1qNBuVq26SnstCbkA/88XdjtDeFYLQaN9k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GaXeIqDidi4LlD68CjZJNrWbhu+7dobfvkCDB2eZIgLLZOtEPDui9Mkda1vm+fRiE
         GddMXK5/Bt7YULCvBZphD14ZC1+wLNfqCZAQSFIA4g7ed+Itcnl9g1CMZFqrpWv6gJ
         K13BaCGXgwwNWgrKU4qTvFJYH5QG7Kg06r8pNfIngi5hIa3Mb6m2iWCIpKA/bfywZm
         VgrQKc0WGyHHsViobNz6F0Fl4x7cBmf2meU+LzSYvZrXKPtaXpvKFttZw+d1sUoXtq
         uWX0RAV5OCXs7cSQuCHdhUyUB0VF1zmXPb2EK1v9UXGDxpd1YQBhGmKwhvspjUVmLO
         BuYEAFlPjGtdQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, kvalo@codeaurora.org
Subject: [PATCH 2/3] mt76: connac: do not schedule wake_work if the runtime-pm is disabled
Date:   Fri, 23 Apr 2021 16:27:10 +0200
Message-Id: <aad9ade1a25f45084cbc2aa66e5ff9a268043ff3.1619187875.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1619187875.git.lorenzo@kernel.org>
References: <cover.1619187875.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following crash due to a call to mt7921_pm_wake_work if the
device has pm disabled or does not support runtime-pm

[    8.412590] mt7921e 0000:01:00.0: HW/SW Version: 0x8a108a10, Build
[    8.413660] WARNING: CPU: 0 PID: 20 at __queue_delayed_work+0x84/0xb0
[    8.481831] CPU: 0 PID: 20 Comm: kworker/u4:1 Not tainted 5.10.31 #0
[    8.488175] Hardware name: MediaTek MT7622 RFB1 board (DT)
[    8.493663] Workqueue: mt76 mt7921_pm_wake_work [mt7921e]
[    8.499055] pstate: 60000085 (nZCv daIf -PAN -UAO -TCO BTYPE=--)
[    8.505052] pc : __queue_delayed_work+0x84/0xb0
[    8.509574] lr : queue_delayed_work_on+0x54/0x78
[    8.514180] sp : ffffffc010bcbd20
[    8.517485] x29: ffffffc010bcbd20 x28: 0000000000000000
[    8.522790] x27: ffffff800015a148 x26: ffffffc0108acae0
[    8.528094] x25: 0000000000000000 x24: ffffff80056b4208
[    8.533399] x23: ffffff80056b26e0 x22: ffffff80056b26e0
[    8.538703] x21: ffffff80056b45f8 x20: ffffff80056b5dc8
[    8.544006] x19: 0000000000000000 x18: 000000000000000e
[    8.549310] x17: 0000000000000001 x16: 0000000000000019
[    8.554614] x15: 0000000000000033 x14: ffffffffffffffff
[    8.559919] x13: ffffffffffffffff x12: 0000000000000000
[    8.565223] x11: 0000000000000040 x10: 0000000000000820
[    8.570528] x9 : 0000b3c738feafd6 x8 : ffffff801feb7c80
[    8.575832] x7 : ffffff80056b4808 x6 : 0000000000000000
[    8.581136] x5 : ffffff80056b2888 x4 : 0000000fffffffe0
[    8.586441] x3 : 000000000000003e x2 : ffffff80056b2868
[    8.591745] x1 : 0000000000000000 x0 : 0000000000000002
[    8.597049] Call trace:
[    8.599488]  __queue_delayed_work+0x84/0xb0
[    8.603662]  queue_delayed_work_on+0x54/0x78
[    8.607947]  ieee80211_queue_delayed_work+0x30/0x50 [mac80211]
[    8.613774]  mt7921_pm_wake_work+0xa0/0xe0 [mt7921e]
[    8.618730]  process_one_work+0x1fc/0x398
[    8.622730]  worker_thread+0x150/0x4e0
[    8.626472]  kthread+0x120/0x128
[    8.629693]  ret_from_fork+0x10/0x18

Fixes: 129fac01ffe85 ("mt76: connac: introduce wake counter for fw_pmctrl synchronization")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76_connac.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
index 6c889b90fd12..2b1150bf8d3d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac.h
@@ -103,6 +103,9 @@ mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 {
 	bool ret = false;
 
+	if (!pm->enable)
+		return true;
+
 	spin_lock_bh(&pm->wake.lock);
 	if (test_bit(MT76_STATE_PM, &phy->state))
 		goto out;
@@ -118,6 +121,9 @@ mt76_connac_pm_ref(struct mt76_phy *phy, struct mt76_connac_pm *pm)
 static inline void
 mt76_connac_pm_unref(struct mt76_connac_pm *pm)
 {
+	if (!pm->enable)
+		return;
+
 	spin_lock_bh(&pm->wake.lock);
 	pm->wake.count--;
 	pm->last_activity = jiffies;
-- 
2.30.2

