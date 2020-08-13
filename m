Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C982124380E
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Aug 2020 11:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726192AbgHMJ4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Aug 2020 05:56:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:35538 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726048AbgHMJ4H (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Aug 2020 05:56:07 -0400
Received: from localhost.localdomain (unknown [5.170.107.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74942206A4;
        Thu, 13 Aug 2020 09:56:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597312566;
        bh=mLH/pKol6stWrBmxdPnlwsEX1fhynhtWGSH/TtMaLYc=;
        h=From:To:Cc:Subject:Date:From;
        b=xHdSKxiDB3SCMLBqMfK0etaT3kruTPVofrH+J/WRnHauglspaLdUFRwY9fxNykPGg
         iJwopHkDeBgusMP1ntAeQTzgLW5zvDNpDxiZbgdwaNJQaR4ACCimkCiRE+dpYGhZot
         GjbJGe5falGh+e22p/rt3ziD5L0uP2al1//MByEg=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org
Subject: [PATCH] mt76: mt7663s: use NULL instead of 0 in sdio code
Date:   Thu, 13 Aug 2020 11:55:52 +0200
Message-Id: <10a6537df1c8a05c8fe68b9b779554fca45edeb7.1597312097.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Fix the following sparse warnings in mt7663s driver:

drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c:78:62: warning:
Using plain integer as NULL pointer
drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c:110:62: warning:
Using plain integer as NULL pointer
drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c:229:64: warning:
Using plain integer as NULL pointer
drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c:263:64: warning:
Using plain integer as NULL pointer

Fixes: a66cbdd6573d ("mt76: mt7615: introduce mt7663s support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c  | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
index 953b5893fa67..53fb6018d013 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_mcu.c
@@ -75,7 +75,7 @@ static int mt7663s_mcu_drv_pmctrl(struct mt7615_dev *dev)
 
 	sdio_claim_host(func);
 
-	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, 0);
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_CLR, MCR_WHLPCR, NULL);
 
 	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
 				 status & WHLPCR_IS_DRIVER_OWN, 2000, 1000000);
@@ -107,7 +107,7 @@ static int mt7663s_mcu_fw_pmctrl(struct mt7615_dev *dev)
 
 	sdio_claim_host(func);
 
-	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, 0);
+	sdio_writel(func, WHLPCR_FW_OWN_REQ_SET, MCR_WHLPCR, NULL);
 
 	ret = readx_poll_timeout(mt7663s_read_pcr, dev, status,
 				 !(status & WHLPCR_IS_DRIVER_OWN), 2000, 1000000);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
index c945b4e0320d..66d8652c756a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/sdio_txrx.c
@@ -226,7 +226,7 @@ void mt7663s_rx_work(struct work_struct *work)
 
 	/* disable interrupt */
 	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, 0);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_CLR, MCR_WHLPCR, NULL);
 	sdio_readsb(sdio->func, &intr, MCR_WHISR, sizeof(struct mt76s_intr));
 	sdio_release_host(sdio->func);
 
@@ -260,7 +260,7 @@ void mt7663s_rx_work(struct work_struct *work)
 
 	/* enable interrupt */
 	sdio_claim_host(sdio->func);
-	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, 0);
+	sdio_writel(sdio->func, WHLPCR_INT_EN_SET, MCR_WHLPCR, NULL);
 	sdio_release_host(sdio->func);
 }
 
-- 
2.26.2

