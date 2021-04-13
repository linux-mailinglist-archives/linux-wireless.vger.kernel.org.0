Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5AE35D74B
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 07:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244467AbhDMFfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 01:35:25 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:48147 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244195AbhDMFfY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 01:35:24 -0400
X-UUID: c8704437166a42389fffdcf3b9471e43-20210413
X-UUID: c8704437166a42389fffdcf3b9471e43-20210413
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1697646784; Tue, 13 Apr 2021 13:35:00 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n2.mediatek.inc (172.21.101.130) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 13 Apr 2021 13:34:58 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 13 Apr 2021 13:34:58 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 2/2] mt76: mt7915: fix memleak when mt7915_unregister_device()
Date:   Tue, 13 Apr 2021 13:34:57 +0800
Message-ID: <3bf5d5df8fcd20a8a093c2de849f527c28c6fc54.1618290080.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <519a81d0c36ab64750a39b1eac3cb86a09cb2f1d.1618290080.git.ryder.lee@mediatek.com>
References: <519a81d0c36ab64750a39b1eac3cb86a09cb2f1d.1618290080.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 1C05952F9C6A380AA889A5D17CC999E72F6B5A0625C5EB7C02979FA5D022D8B62000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt7915_tx_token_put() should get call before mt76_free_pending_txwi().

Fixes: f285dfb98562 ("mt76: mt7915: reset token when mac_reset happens")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 3f9f74aa8399..6322a92fd2d0 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -744,9 +744,8 @@ void mt7915_unregister_device(struct mt7915_dev *dev)
 	mt7915_unregister_ext_phy(dev);
 	mt76_unregister_device(&dev->mt76);
 	mt7915_mcu_exit(dev);
-	mt7915_dma_cleanup(dev);
-
 	mt7915_tx_token_put(dev);
+	mt7915_dma_cleanup(dev);
 
 	mt76_free_device(&dev->mt76);
 }
-- 
2.18.0

