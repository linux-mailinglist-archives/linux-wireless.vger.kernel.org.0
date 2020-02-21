Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E01AA166B4F
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 01:08:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729450AbgBUAII (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Feb 2020 19:08:08 -0500
Received: from mail.kernel.org ([198.145.29.99]:38660 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729373AbgBUAII (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Feb 2020 19:08:08 -0500
Received: from localhost.localdomain (unknown [151.48.137.85])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E33F02071E;
        Fri, 21 Feb 2020 00:08:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1582243688;
        bh=JcxRaMKasCZYwhfpda96e/oMh6PCWx7SSFh3NDps9b8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IQcb8n99CfSPcAI9l0l+EgZhPY0eY2CczAU6dQCu5L/NOMFFZC58mHvK/U0GKwh12
         sdEXSVetKvfJnBi78Xi8fascSdbWwv1QR0SqzdFpiP02rNJ2cb8iFQvXdHAnX2hHly
         OU5cGVsM4WVQxpU35z0pL8NmATKATeyOufcU17WU=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, linux-wireless@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com
Subject: [PATCH 4/8] mt76: mt7615: add mt7663e support to mt7615_{driver,firmware}_own
Date:   Fri, 21 Feb 2020 01:07:31 +0100
Message-Id: <e8eec6e893dea5750a906b354757210de69afa9a.1582243031.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1582243031.git.lorenzo@kernel.org>
References: <cover.1582243031.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mt7615_driver_own and mt7615_firmware_own in order to reuse them adding
mt7663e support to mt7615 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 1b8c8da56b84..a244585d78df 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -371,11 +371,13 @@ static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
 {
-	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_DRV_OWN);
+	u32 addr;
+
+	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
 
 	mt7622_trigger_hif_int(dev, true);
-	if (!mt76_poll_msec(dev, MT_CFG_LPCR_HOST,
-			    MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
+	if (!mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
@@ -386,9 +388,12 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 
 static int mt7615_firmware_own(struct mt7615_dev *dev)
 {
+	u32 addr;
+
+	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
 	mt7622_trigger_hif_int(dev, true);
 
-	mt76_wr(dev, MT_CFG_LPCR_HOST, MT_CFG_LPCR_HOST_FW_OWN);
+	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_FW_OWN);
 
 	if (is_mt7622(&dev->mt76) &&
 	    !mt76_poll_msec(dev, MT_CFG_LPCR_HOST,
-- 
2.24.1

