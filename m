Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74226393487
	for <lists+linux-wireless@lfdr.de>; Thu, 27 May 2021 19:06:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236849AbhE0RHe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 May 2021 13:07:34 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39210 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S235298AbhE0RHe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 May 2021 13:07:34 -0400
X-UUID: fb85061c1c9f471981337b2fa898d6e4-20210528
X-UUID: fb85061c1c9f471981337b2fa898d6e4-20210528
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2021564134; Fri, 28 May 2021 01:05:58 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 28 May 2021 01:05:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 28 May 2021 01:05:56 +0800
From:   <Deren.Wu@mediatek.com>
To:     <Deren.Wu@mediatek.com>, <nbd@nbd.name>,
        <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: update statistic in active mode only
Date:   Fri, 28 May 2021 01:05:33 +0800
Message-ID: <9337f7947e1f0921ffb6b4af541d29af9a0a9394.1622112237.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

wakeup chip every 250ms may cause huge power consumption

try to update statistic counter only if in active status only,
and it would lead fewer power cost

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index e29d4fdab572..212832b34674 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -1459,13 +1459,15 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 {
 	struct mt7921_dev *dev;
 	unsigned long delta;
+	struct mt76_phy *mphy;
 
 	dev = (struct mt7921_dev *)container_of(work, struct mt7921_dev,
 						pm.ps_work.work);
+	mphy = dev->phy.mt76;
 
 	delta = dev->pm.idle_timeout;
-	if (test_bit(MT76_HW_SCANNING, &dev->mphy.state) ||
-	    test_bit(MT76_HW_SCHED_SCANNING, &dev->mphy.state))
+	if (test_bit(MT76_HW_SCANNING, &mphy->state) ||
+	    test_bit(MT76_HW_SCHED_SCANNING, &mphy->state))
 		goto out;
 
 	if (time_is_after_jiffies(dev->pm.last_activity + delta)) {
@@ -1473,8 +1475,10 @@ void mt7921_pm_power_save_work(struct work_struct *work)
 		goto out;
 	}
 
-	if (!mt7921_mcu_fw_pmctrl(dev))
+	if (!mt7921_mcu_fw_pmctrl(dev)) {
+		cancel_delayed_work_sync(&mphy->mac_work);
 		return;
+	}
 out:
 	queue_delayed_work(dev->mt76.wq, &dev->pm.ps_work, delta);
 }
-- 
2.18.0

