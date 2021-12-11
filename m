Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 894994714BF
	for <lists+linux-wireless@lfdr.de>; Sat, 11 Dec 2021 17:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhLKQbl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Dec 2021 11:31:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53974 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231395AbhLKQbl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Dec 2021 11:31:41 -0500
X-UUID: 067fca5ab1b241bb8bdc4356659bb27a-20211212
X-UUID: 067fca5ab1b241bb8bdc4356659bb27a-20211212
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 123356996; Sun, 12 Dec 2021 00:31:37 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sun, 12 Dec 2021 00:31:35 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 12 Dec 2021 00:31:35 +0800
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
Subject: [PATCH 2/2] mt76: mt7921s: fix suspend error with enlarging mcu timeout value
Date:   Sun, 12 Dec 2021 00:31:30 +0800
Message-ID: <13f6e51cd22a8a18e8f14e1213c299805ce37e14.1639239996.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <87100999ebfd6e205e655a6355a3990ff89d3945.1639239996.git.objelf@gmail.com>
References: <87100999ebfd6e205e655a6355a3990ff89d3945.1639239996.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Fix the false positive suspend error that may occur on mt7921s
with enlarging mcu timeout value.

The reason why we have to enlarge mcu timeout from HZ / 3 to HZ is
we should consider the additional overhead caused by running
concurrently with btmtksdio (a MT7921 bluetooth SDIO driver) that
would compete for the same SDIO bus in process context to complete
the suspend procedure.

Fixes: 48fab5bbef40 ("mt76: mt7921: introduce mt7921s support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 1227d626e9d3..be87e134216b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -239,7 +239,7 @@ int mt7921_mcu_fill_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	case MCU_UNI_CMD_HIF_CTRL:
 	case MCU_UNI_CMD_SUSPEND:
 	case MCU_UNI_CMD_OFFLOAD:
-		mdev->mcu.timeout = HZ / 3;
+		mdev->mcu.timeout = HZ;
 		break;
 	default:
 		mdev->mcu.timeout = 3 * HZ;
-- 
2.25.1

