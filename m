Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD73F4369
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Aug 2021 04:27:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234779AbhHWC1l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 22 Aug 2021 22:27:41 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:50974 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S234692AbhHWC1k (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 22 Aug 2021 22:27:40 -0400
X-UUID: ca4d1e7c8e8c426aac0b7257d69cf96f-20210823
X-UUID: ca4d1e7c8e8c426aac0b7257d69cf96f-20210823
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 973707880; Mon, 23 Aug 2021 10:26:53 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs05n1.mediatek.inc (172.21.101.15) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 23 Aug 2021 10:26:52 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Aug 2021 10:26:52 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <robin.chiu@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <jemele@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: fix the inconsistent state between bind and unbind
Date:   Mon, 23 Aug 2021 10:26:51 +0800
Message-ID: <9c71befbdf8a97f72f4538c39a71041ccffbaf83.1629685207.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We shouldn't put back the device into fw own state after wifi reset at
driver unbind stage to fix the following error because that is not the
consistent state the current driver bind stage expects.

localhost ~ # echo 0000:01:00.0 > /sys/bus/pci/drivers/mt7921e/unbind
localhost ~ # echo 0000:01:00.0 > /sys/bus/pci/drivers/mt7921e/bind
...
[  481.172969] mt7921e 0000:01:00.0: ASIC revision: feed0000
[  482.133547] mt7921e: probe of 0000:01:00.0 failed with error -110
-bash: echo: write error: No such device

Fixes: c1af184ba830 ("mt76: mt7921: fix dma hang in rmmod")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 1f37e64b6038..3e84ef8f5358 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -279,7 +279,6 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 	mt7921_mcu_drv_pmctrl(dev);
 	mt7921_dma_cleanup(dev);
 	mt7921_mcu_exit(dev);
-	mt7921_mcu_fw_pmctrl(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
 	mt76_free_device(&dev->mt76);
-- 
2.25.1

