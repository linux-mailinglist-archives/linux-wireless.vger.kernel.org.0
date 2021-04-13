Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B61EF35D8CB
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 09:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238878AbhDMH07 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 03:26:59 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:49424 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230446AbhDMH0x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 03:26:53 -0400
X-UUID: dc8304c882da4c8ba8b66eb16e0725ad-20210413
X-UUID: dc8304c882da4c8ba8b66eb16e0725ad-20210413
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1425415315; Tue, 13 Apr 2021 15:26:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Apr 2021 15:26:25 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Apr 2021 15:26:25 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: only free skbs after mt7915_dma_reset() when reset happens
Date:   Tue, 13 Apr 2021 15:26:20 +0800
Message-ID: <6f531ab347f2c95ccc979b905e1882811dbf88fe.1618297567.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <1fc26bda42fcd85b4bcebc8520601c70b882aa34.1618297567.git.ryder.lee@mediatek.com>
References: <1fc26bda42fcd85b4bcebc8520601c70b882aa34.1618297567.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 0FBF8B1C5867ACE187B03BCE64CBA3125AD649F31450D63B2D80902F88F920552000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mt7915_mac_reset_work(), make sure freeing skbs after mt7915_dma_reset().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e61dfe966f0a..423f1b9202ce 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1627,12 +1627,12 @@ void mt7915_mac_reset_work(struct work_struct *work)
 
 	mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_STOPPED);
 
-	mt7915_tx_token_put(dev);
-	idr_init(&dev->token);
-
 	if (mt7915_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7915_dma_reset(dev);
 
+		mt7915_tx_token_put(dev);
+		idr_init(&dev->token);
+
 		mt76_wr(dev, MT_MCU_INT_EVENT, MT_MCU_INT_EVENT_DMA_INIT);
 		mt7915_wait_reset_state(dev, MT_MCU_CMD_RECOVERY_DONE);
 	}
-- 
2.18.0

