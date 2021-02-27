Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37AD0326C22
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Feb 2021 08:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhB0HlO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 27 Feb 2021 02:41:14 -0500
Received: from mailgw01.mediatek.com ([210.61.82.183]:58077 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229849AbhB0HlN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 27 Feb 2021 02:41:13 -0500
X-UUID: e4d99241a3a14e83b92c10887fa4eadc-20210227
X-UUID: e4d99241a3a14e83b92c10887fa4eadc-20210227
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1093846120; Sat, 27 Feb 2021 15:40:31 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 27 Feb 2021 15:40:24 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 27 Feb 2021 15:40:24 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 4/5] mt76: mt7915: stop ext_phy queue when mac reset happens
Date:   Sat, 27 Feb 2021 15:39:45 +0800
Message-ID: <20a4b03ba4a347a76df67291680704dfdb7da5d6.1614411256.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
References: <d6f2573790582538e8ba82f87a4c35329692ee32.1614411256.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Stop Tx burst for ext_phy after mac reset.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6b6ea33bd320..c653cd01b8d8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1607,9 +1607,10 @@ void mt7915_mac_reset_work(struct work_struct *work)
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
 	wake_up(&dev->mt76.mcu.wait);
 	cancel_delayed_work_sync(&dev->mphy.mac_work);
-	if (phy2)
+	if (phy2) {
+		set_bit(MT76_RESET, &phy2->mt76->state);
 		cancel_delayed_work_sync(&phy2->mt76->mac_work);
-
+	}
 	/* lock/unlock all queues to ensure that no tx is pending */
 	mt76_txq_schedule_all(&dev->mphy);
 	if (ext_phy)
@@ -1637,6 +1638,8 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	clear_bit(MT76_MCU_RESET, &dev->mphy.state);
 	clear_bit(MT76_RESET, &dev->mphy.state);
+	if (phy2)
+		clear_bit(MT76_RESET, &phy2->mt76->state);
 
 	mt76_worker_enable(&dev->mt76.tx_worker);
 	napi_enable(&dev->mt76.tx_napi);
-- 
2.18.0

