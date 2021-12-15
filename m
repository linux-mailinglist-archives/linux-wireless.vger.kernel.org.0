Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2193476485
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 22:25:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbhLOVZq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 16:25:46 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:48882 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229441AbhLOVZq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 16:25:46 -0500
X-UUID: 55221cc82be54164a5497c9c0613adcb-20211216
X-UUID: 55221cc82be54164a5497c9c0613adcb-20211216
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1772946277; Thu, 16 Dec 2021 05:25:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Dec 2021 05:25:41 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 05:25:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/4] mt76: mt7921s: make pm->suspended usage consistent
Date:   Thu, 16 Dec 2021 05:25:36 +0800
Message-ID: <57d752fc7ee5af393e2856d25ed701ce8fd01aed.1639602937.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <9813aaab7c86fbbdd160a8c421696a09deb559d3.1639602937.git.objelf@gmail.com>
References: <9813aaab7c86fbbdd160a8c421696a09deb559d3.1639602937.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Update pm->suspended usage to be consistent with mt7921e driver.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: refine the error handling path
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 84be229a899d..65d693902c22 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -278,7 +278,6 @@ static int mt7921s_resume(struct device *__dev)
 	struct mt76_dev *mdev = &dev->mt76;
 	int err;
 
-	pm->suspended = false;
 	clear_bit(MT76_STATE_SUSPEND, &mdev->phy.state);
 
 	err = mt7921_mcu_drv_pmctrl(dev);
@@ -294,7 +293,13 @@ static int mt7921s_resume(struct device *__dev)
 	if (!pm->ds_enable)
 		mt76_connac_mcu_set_deep_sleep(mdev, false);
 
-	return mt76_connac_mcu_set_hif_suspend(mdev, false);
+	err = mt76_connac_mcu_set_hif_suspend(mdev, false);
+	if (err)
+		return err;
+
+	pm->suspended = false;
+
+	return err;
 }
 
 static const struct dev_pm_ops mt7921s_pm_ops = {
-- 
2.25.1

