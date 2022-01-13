Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3667E48D387
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Jan 2022 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232968AbiAMIX4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Jan 2022 03:23:56 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:56310 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232966AbiAMIX4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Jan 2022 03:23:56 -0500
X-UUID: 1ac8131802dd4bef938767349359bb03-20220113
X-UUID: 1ac8131802dd4bef938767349359bb03-20220113
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 415834181; Thu, 13 Jan 2022 16:23:54 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 13 Jan 2022 16:23:53 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 13 Jan 2022 16:23:52 +0800
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
Subject: [PATCH 3/3] mt76: mt7921s: run sleep mode by default
Date:   Thu, 13 Jan 2022 16:23:48 +0800
Message-ID: <9025e5bd5212cab4bd72fd76d35b205980499056.1642061035.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
References: <651a010d8ff888909b5b8363fa4b243aadc62d45.1642061035.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Apply sleep mode by default to reduce power consumption as possible.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index ad59ef9839dc..0166a5503aef 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -226,12 +226,8 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-
-	/* TODO: mt7921s run sleep mode on default  */
-	if (mt76_is_mmio(&dev->mt76)) {
-		dev->pm.enable = true;
-		dev->pm.ds_enable = true;
-	}
+	dev->pm.enable = true;
+	dev->pm.ds_enable = true;
 
 	if (mt76_is_sdio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
-- 
2.25.1

