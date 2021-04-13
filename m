Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1A3335D989
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 10:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbhDMIAf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 04:00:35 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:45725 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230271AbhDMIAd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 04:00:33 -0400
X-UUID: a70d75a4288f4ef6989e2bce33a09400-20210413
X-UUID: a70d75a4288f4ef6989e2bce33a09400-20210413
Received: from mtkcas07.mediatek.inc [(172.21.101.84)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 731366077; Tue, 13 Apr 2021 16:00:10 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Apr 2021 16:00:09 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Apr 2021 16:00:09 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 1/2] mt76: mt7615: only free skbs after mt7615_dma_reset() when reset happens
Date:   Tue, 13 Apr 2021 16:00:06 +0800
Message-ID: <f5e1b4bf7a66f4e3705bfd673e82b9dd21d41e9a.1618300405.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In mt7615_mac_reset_work(), make sure freeing skbs after mt7615_dma_reset().

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
changes since v2: 
- split v1 into two patches
- remove original mt7615_tx_token_put.
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
index 7694391603dd..baaf734c6950 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci_mac.c
@@ -304,12 +304,12 @@ void mt7615_mac_reset_work(struct work_struct *work)
 
 	mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_STOPPED);
 
-	mt7615_tx_token_put(dev);
-	idr_init(&dev->token);
-
 	if (mt7615_wait_reset_state(dev, MT_MCU_CMD_RESET_DONE)) {
 		mt7615_dma_reset(dev);
 
+		mt7615_tx_token_put(dev);
+		idr_init(&dev->token);
+
 		mt76_wr(dev, MT_WPDMA_MEM_RNG_ERR, 0);
 
 		mt7615_hif_int_event_trigger(dev, MT_MCU_INT_EVENT_PDMA_INIT);
-- 
2.18.0

