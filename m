Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02635DE69
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 14:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbhDMMOT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 08:14:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:43918 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231329AbhDMMOS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 08:14:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0DFC1600D4;
        Tue, 13 Apr 2021 12:13:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618316039;
        bh=El0x2wWUEywg8Sq6LyhSCyV3rEE56ojTe4fLgQfoeH8=;
        h=From:To:Cc:Subject:Date:From;
        b=ggzUE4mazp4/58s+eE0kFJLVNHBEHHkKmV3l9RdebjIloXbOwBwIDWrnOdnMbNZTX
         Ov51RER4HqAUS7zIoLQYtHyUmhlh7jptVpMl8TpxQjveq8IPhmUtP3P6dxY6UPASEA
         bfOZML1Ug7e+7WTYAErhrCg4IIVfkDJLgoCxbZCUhSSu8K49fe6S3qkom03j2K/OBb
         wBwBGjdcmdxyUfhBuzYOs8aQT+h3uGR3ajMmoiBNWMrFVPDnDTYC8G+jzyQK8WQuy+
         FKr7myJTAIN97MbndTZsodXfaClWiXPyD6Pu8KP02RTStFNub9Ct6ZbikQRXKWaHVs
         bhYri+ro3TnKw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2] mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
Date:   Tue, 13 Apr 2021 14:13:54 +0200
Message-Id: <63d4a09e87c5ced03fc27aa1aa85a85144716ebf.1618315935.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to avoid memory leaks, clean the dma engine unloading the
module

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move mt7921_dma_cleanup before mt7921_mcu_exit
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 5bb0a7b9e9e5..94fe2eadf285 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -272,8 +272,9 @@ int mt7921_register_device(struct mt7921_dev *dev)
 void mt7921_unregister_device(struct mt7921_dev *dev)
 {
 	mt76_unregister_device(&dev->mt76);
-	mt7921_mcu_exit(dev);
 	mt7921_tx_token_put(dev);
+	mt7921_dma_cleanup(dev);
+	mt7921_mcu_exit(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
 	mt76_free_device(&dev->mt76);
-- 
2.30.2

