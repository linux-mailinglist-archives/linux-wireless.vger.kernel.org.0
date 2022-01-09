Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73C9E48885C
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jan 2022 09:34:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiAIId5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Jan 2022 03:33:57 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39616 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229867AbiAIId5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Jan 2022 03:33:57 -0500
X-UUID: 324762a3ce5b4e3ca70be4fbd775b2b0-20220109
X-UUID: 324762a3ce5b4e3ca70be4fbd775b2b0-20220109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1977126466; Sun, 09 Jan 2022 16:33:53 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 9 Jan 2022 16:33:51 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sun, 9 Jan
 2022 16:33:51 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 9 Jan 2022 16:33:50 +0800
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
        <linux-mediatek@lists.infradead.org>,
        "Leon Yen" <leon.yen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: sdio: disable interrupt in mt76s_sdio_irq
Date:   Sun, 9 Jan 2022 16:33:50 +0800
Message-ID: <a8a84184942de2214979f46482c77c5921c40af5.1641716611.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It is unnecessary to keep the interrupt enabled in mt76s_sdio_irq because
the driver is already aware of the interrupt, schedules the
mt76s_txrx_worker to handle the corresponding actions, and eventually,
the interrupt would be enabled again when mt76s_txrx_worker finishes its
work.

So we can safely disable the interrupt in mt76s_sdio_irq as soon as
possible to increase the CPU productivity by dropping the redundant
interrupt triggers.

Note that sdio lock acquired/released would be handled in sdio_irq_work
at mmc driver so we don't take care in mt76s_sdio_irq at function driver.

Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Co-developed-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/sdio_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
index f2b46975d831..488ad7734d85 100644
--- a/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/sdio_txrx.c
@@ -349,6 +349,7 @@ void mt76s_sdio_irq(struct sdio_func *func)
 	    test_bit(MT76_MCU_RESET, &dev->phy.state))
 		return;
 
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
 	mt76_worker_schedule(&sdio->txrx_worker);
 }
 EXPORT_SYMBOL_GPL(mt76s_sdio_irq);
-- 
2.25.1

