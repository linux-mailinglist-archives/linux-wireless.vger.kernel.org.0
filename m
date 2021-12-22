Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F86547CCBD
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 06:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242622AbhLVF6X (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 00:58:23 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53448 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232036AbhLVF6X (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 00:58:23 -0500
X-UUID: b079e6c0b3b6476c8fb0c4c56cf76bba-20211222
X-UUID: b079e6c0b3b6476c8fb0c4c56cf76bba-20211222
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 137079001; Wed, 22 Dec 2021 13:58:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Wed, 22 Dec 2021 13:58:19 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Dec 2021 13:58:19 +0800
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
Subject: [PATCH 1/2] mt76: mt7921s: clear MT76_STATE_MCU_RUNNING immediately after reset
Date:   Wed, 22 Dec 2021 13:58:17 +0800
Message-ID: <f18bbe4b077e5e21c3fbb04c5ab84520142d567d.1640151776.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

clear the flag MT76_STATE_MCU_RUNNING immediately after reset to indicate
the MCU has already stopped working at the point. That is a preliminary
patch for the following patch to perform the register access in the
remaining reset handler using SDIO mailbox way instead of MCU command
because the RAM firmware is cleared out.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index ccaf8134cec7..e0f0d3a2b17e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -60,6 +60,8 @@ int mt7921s_wfsys_reset(struct mt7921_dev *dev)
 
 	sdio_release_host(sdio->func);
 
+	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
+
 	/* activate mt7921s again */
 	mt7921s_mcu_fw_pmctrl(dev);
 	mt7921s_mcu_drv_pmctrl(dev);
@@ -81,7 +83,6 @@ int mt7921s_init_reset(struct mt7921_dev *dev)
 	mt7921s_wfsys_reset(dev);
 
 	mt76_worker_enable(&dev->mt76.sdio.txrx_worker);
-	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	mt7921s_enable_irq(&dev->mt76);
 
@@ -114,7 +115,6 @@ int mt7921s_mac_reset(struct mt7921_dev *dev)
 	mt76_worker_enable(&dev->mt76.sdio.net_worker);
 
 	dev->fw_assert = false;
-	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	mt7921s_enable_irq(&dev->mt76);
 
-- 
2.25.1

