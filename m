Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E59E857C007
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Jul 2022 00:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbiGTWZ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 18:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiGTWZ6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 18:25:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5D55B6
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 15:25:51 -0700 (PDT)
X-UUID: 644307b5d3ab4422a7d1bcd47ab8712e-20220721
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:1bbe364b-8c76-4435-bbdd-1c4a301cad63,OB:30,L
        OB:10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,
        ACTION:release,TS:95
X-CID-INFO: VERSION:1.1.8,REQID:1bbe364b-8c76-4435-bbdd-1c4a301cad63,OB:30,LOB
        :10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,
        ACTION:quarantine,TS:95
X-CID-META: VersionHash:0f94e32,CLOUDID:5b9f06d8-5d6d-4eaf-a635-828a3ee48b7c,C
        OID:dfdc1513ed4c,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: 644307b5d3ab4422a7d1bcd47ab8712e-20220721
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 802798640; Thu, 21 Jul 2022 06:25:42 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Thu, 21 Jul 2022 06:25:42 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Thu, 21 Jul 2022 06:25:41 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH v2 3/4] mt76: mt7921u: fix race issue between reset and suspend/resume
Date:   Thu, 21 Jul 2022 06:25:39 +0800
Message-ID: <983945d762b95c0259cc8d7702e5e25fffcc0ef0.1658355599.git.sean.wang@kernel.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <5f835553ee8b76e4a4ed83f9562eaa0b1a24c1e6.1658355599.git.sean.wang@kernel.org>
References: <5f835553ee8b76e4a4ed83f9562eaa0b1a24c1e6.1658355599.git.sean.wang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

It is unexpected that the reset work is running simultaneously with
the suspend or resume context and it is possible that reset work is still
running even after mt7921 is suspended if we don't fix the race issue.

Thus, the suspend procedure should be waiting until the reset is completed
at the beginning and ignore the subsequent the reset requests.

In case there is an error that happens during either suspend or resume
handler, we will schedule a reset task to recover the error before
returning the error code to ensure we can immediately fix the error there.

Fixes: df3e4143ba8a ("mt76: mt7921u: add suspend/resume support")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: use flush_work instead of cancel_work_sync
---
 .../net/wireless/mediatek/mt76/mt7921/usb.c   | 28 ++++++++++++++++---
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index dd3b8884e162..613d5cefffc7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -300,11 +300,15 @@ static void mt7921u_disconnect(struct usb_interface *usb_intf)
 static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 {
 	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	struct mt76_connac_pm *pm = &dev->pm;
 	int err;
 
+	pm->suspended = true;
+	flush_work(&dev->reset_work);
+
 	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, true);
 	if (err)
-		return err;
+		goto failed;
 
 	mt76u_stop_rx(&dev->mt76);
 	mt76u_stop_tx(&dev->mt76);
@@ -312,11 +316,20 @@ static int mt7921u_suspend(struct usb_interface *intf, pm_message_t state)
 	set_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
 
 	return 0;
+
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt7921_reset(&dev->mt76);
+
+	return err;
 }
 
 static int mt7921u_resume(struct usb_interface *intf)
 {
 	struct mt7921_dev *dev = usb_get_intfdata(intf);
+	struct mt76_connac_pm *pm = &dev->pm;
 	bool reinit = true;
 	int err, i;
 
@@ -338,16 +351,23 @@ static int mt7921u_resume(struct usb_interface *intf)
 	if (reinit || mt7921_dma_need_reinit(dev)) {
 		err = mt7921u_dma_init(dev, true);
 		if (err)
-			return err;
+			goto failed;
 	}
 
 	clear_bit(MT76_STATE_SUSPEND, &dev->mphy.state);
 
 	err = mt76u_resume_rx(&dev->mt76);
 	if (err < 0)
-		return err;
+		goto failed;
+
+	err = mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+failed:
+	pm->suspended = false;
+
+	if (err < 0)
+		mt7921_reset(&dev->mt76);
 
-	return mt76_connac_mcu_set_hif_suspend(&dev->mt76, false);
+	return err;
 }
 #endif /* CONFIG_PM */
 
-- 
2.25.1

