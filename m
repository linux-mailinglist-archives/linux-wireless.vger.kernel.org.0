Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A67578C26
	for <lists+linux-wireless@lfdr.de>; Mon, 18 Jul 2022 22:52:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbiGRUw0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 18 Jul 2022 16:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234980AbiGRUwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 18 Jul 2022 16:52:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AA97326D6
        for <linux-wireless@vger.kernel.org>; Mon, 18 Jul 2022 13:52:24 -0700 (PDT)
X-UUID: ae476c31a51a4f5e9c0b6d1a37ca3aa8-20220719
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.8,REQID:a1cdb392-5ec7-4988-beb8-b47e91ed2450,OB:0,LO
        B:10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.8,REQID:a1cdb392-5ec7-4988-beb8-b47e91ed2450,OB:0,LOB:
        10,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:0f94e32,CLOUDID:80164e33-b9e4-42b8-b28a-6364427c76bb,C
        OID:681906c2c761,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: ae476c31a51a4f5e9c0b6d1a37ca3aa8-20220719
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1759691411; Tue, 19 Jul 2022 04:52:19 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 19 Jul 2022 04:52:17 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Tue, 19 Jul 2022 04:52:17 +0800
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
Subject: [PATCH 3/3] mt76: mt7663s: fix the deadlock caused by sdio->stat_work
Date:   Tue, 19 Jul 2022 04:52:15 +0800
Message-ID: <106a510630a27440b49170e9586f9dfbe831848e.1658176763.git.sean.wang@kernel.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <aa7d7ed8f3a817525ab8c7b736f1ce52490a835e.1658176763.git.sean.wang@kernel.org>
References: <aa7d7ed8f3a817525ab8c7b736f1ce52490a835e.1658176763.git.sean.wang@kernel.org>
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

Because wake_work and sdio->stat_work share the same workqueue mt76->wq,
if sdio->stat_work cannot acquire the mutex lock such as that was possibly
held up by mt7615_mutex_acquire, we should exit immediately and schedule
another stat_work to avoid blocking the mt7615_mutex_acquire.

Also, if mt7615_mutex_acquire was called by sdio->stat_work self, the wake
would be blocked by itself, so we have to changing into an unblocking wake
(directly wakeup via mt7615_mcu_drv_pmctrl, not via the wake_work) in the
context.

Fixes: a66cbdd6573d ("mt76: mt7615: introduce mt7663s support")
Co-developed-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7615/usb_sdio.c  | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
index 0052d103e276..5991b23e0d13 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/usb_sdio.c
@@ -157,10 +157,29 @@ bool mt7663_usb_sdio_tx_status_data(struct mt76_dev *mdev, u8 *update)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
-	mt7615_mutex_acquire(dev);
+	if (!mutex_trylock(&mdev->mutex)) {
+		/* Because wake_work and stat_work share the same workqueue
+		 * mt76->wq, if sdio->stat_work cannot acquire the mutex lock,
+		 * we should exit immediately and schedule another stat_work
+		 * to avoid blocking the wake_work.
+		 */
+		struct work_struct *stat_work;
+
+		stat_work = mt76_is_sdio(mdev) ? &mdev->sdio.stat_work :
+			    &mdev->usb.stat_work;
+		queue_work(dev->mt76.wq, stat_work);
+
+		goto out;
+	}
+
+	mt7615_mcu_set_drv_ctrl(dev);
+
 	mt7615_mac_sta_poll(dev);
-	mt7615_mutex_release(dev);
 
+	mt76_connac_power_save_sched(&mdev->phy, &dev->pm);
+	mutex_unlock(&mdev->mutex);
+
+out:
 	return false;
 }
 EXPORT_SYMBOL_GPL(mt7663_usb_sdio_tx_status_data);
-- 
2.25.1

