Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57DC535DA37
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Apr 2021 10:40:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242837AbhDMIlD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 13 Apr 2021 04:41:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53576 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242475AbhDMIk4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 13 Apr 2021 04:40:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 59D6E61369;
        Tue, 13 Apr 2021 08:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618303237;
        bh=R1WTGq79CWegA5MkSWLVr4LBK2ORVEnUlexA2bqMBCQ=;
        h=From:To:Cc:Subject:Date:From;
        b=kUoPAw1An96keJdzXtruH1cgzaWUt1R8Rlb6lRJMqW+Brd7lZdsyccYxWEqDqeWPp
         yXk2bDY1g82NVcCQM8ytCZP6SrmscdJ3Y0SW5FLJjTPgZprJ2aYrU1qI4McRxSsyki
         Cn33Bz0nm0DJkaqeaKJMNvw8HTIk44cEw/zaFXz82fX3GxAKDEFIP9OpzAPR3hauDU
         z2Wijm3qBzULGk31me2wbQ/qXx+tWUYpf4tluUu0dqY/FqxZsEwAHc5mENkLNUYF0v
         JrGQwuX5FwUILC2vjvVw/loZmcK5OQ6YvBwN2JChO/5T3Tm//e2xUAEUdkkhs30O4+
         wZjJsxprRRR2Q==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7921: add mt7921_dma_cleanup in mt7921_unregister_device
Date:   Tue, 13 Apr 2021 10:40:33 +0200
Message-Id: <e78ac49fa2e22c034b934f4ee433b5476e22706c.1618302972.git.lorenzo@kernel.org>
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
 drivers/net/wireless/mediatek/mt76/mt7921/init.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index a20a3233fdc6..a1ed3e71b299 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -290,6 +290,7 @@ void mt7921_unregister_device(struct mt7921_dev *dev)
 	mt76_unregister_device(&dev->mt76);
 	mt7921_mcu_exit(dev);
 	mt7921_tx_token_put(dev);
+	mt7921_dma_cleanup(dev);
 
 	tasklet_disable(&dev->irq_tasklet);
 	mt76_free_device(&dev->mt76);
-- 
2.30.2

