Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0DB2476487
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Dec 2021 22:25:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbhLOVZt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Dec 2021 16:25:49 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:58310 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229494AbhLOVZs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Dec 2021 16:25:48 -0500
X-UUID: 61b77604e0434e0887c10558ef17af96-20211216
X-UUID: 61b77604e0434e0887c10558ef17af96-20211216
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 384802463; Thu, 16 Dec 2021 05:25:44 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 16 Dec 2021 05:25:43 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 16 Dec 2021 05:25:43 +0800
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
Subject: [PATCH v2 4/4] mt76: mt7921s: fix suspend error with enlarging mcu timeout value
Date:   Thu, 16 Dec 2021 05:25:37 +0800
Message-ID: <4588a7770984fa6bc3cbf0a3fdcae0150ce63c22.1639602937.git.objelf@gmail.com>
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
v2: the same, just rebase the patchset
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

