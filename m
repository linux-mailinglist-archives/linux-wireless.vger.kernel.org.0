Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1438A48F345
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jan 2022 00:57:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230304AbiANX4l (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Jan 2022 18:56:41 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:48214 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229779AbiANX4l (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Jan 2022 18:56:41 -0500
X-UUID: d9a12d22399744fca8ff03313c4f6f0d-20220115
X-UUID: d9a12d22399744fca8ff03313c4f6f0d-20220115
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 809052308; Sat, 15 Jan 2022 07:56:38 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 15 Jan 2022 07:56:36 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 15 Jan 2022 07:56:36 +0800
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
Subject: [PATCH v2 2/2] mt76: mt7921s: run sleep mode by default
Date:   Sat, 15 Jan 2022 07:56:33 +0800
Message-ID: <ddbc5499b76989c7d67fcbc31eb19ff535156dfa.1642204233.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
References: <c09673a115c39f7af692efb984a5dc0c75238a64.1642204233.git.objelf@gmail.com>
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
v1 -> v2: rebase on the top of
	  ("mt76: mt7921: toggle runtime-pm adding a monitor vif")
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 6059d8a0f227..fa6af85bba7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -226,14 +226,10 @@ int mt7921_register_device(struct mt7921_dev *dev)
 	dev->pm.idle_timeout = MT7921_PM_TIMEOUT;
 	dev->pm.stats.last_wake_event = jiffies;
 	dev->pm.stats.last_doze_event = jiffies;
-
-	/* TODO: mt7921s run sleep mode on default  */
-	if (mt76_is_mmio(&dev->mt76)) {
-		dev->pm.enable_user = true;
-		dev->pm.enable = true;
-		dev->pm.ds_enable_user = true;
-		dev->pm.ds_enable = true;
-	}
+	dev->pm.enable_user = true;
+	dev->pm.enable = true;
+	dev->pm.ds_enable_user = true;
+	dev->pm.ds_enable = true;
 
 	if (mt76_is_sdio(&dev->mt76))
 		hw->extra_tx_headroom += MT_SDIO_TXD_SIZE + MT_SDIO_HDR_SIZE;
-- 
2.25.1

