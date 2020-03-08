Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6204417D6B0
	for <lists+linux-wireless@lfdr.de>; Sun,  8 Mar 2020 23:09:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCHWJe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 8 Mar 2020 18:09:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:39646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726411AbgCHWJd (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 8 Mar 2020 18:09:33 -0400
Received: from localhost.localdomain (unknown [151.48.128.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3744120863;
        Sun,  8 Mar 2020 22:09:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583705373;
        bh=0u8kOuKU6XvmSCkVMurvFE9OJhBA+da2cLQp8IE3acQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omB4lXwnGcA3jPxnECjnBi1J1h+PBAZBo1+SQChaPPk7CQCaBTP4I7AXUsCg3Gg69
         95pKlkhmMAeV+Ijd3Jd3NZaHjKSM0/0x/RppM822+gKBIRW8PzOJmnrp1yV8D6AhoW
         ooZE/7YgzizZv1EfnyPutDchevmAt/VAgscMtn/g=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: [PATCH v2 16/25] mt76: mt7615: add mt7663e support to mt7615_{driver,firmware}_own
Date:   Sun,  8 Mar 2020 23:08:28 +0100
Message-Id: <f83881a8270b5699acd205dc1e99d9e3af8caefb.1583705012.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1583705012.git.lorenzo@kernel.org>
References: <cover.1583705012.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Extend mt7615_driver_own and mt7615_firmware_own in order to reuse
them adding mt7663e support to mt7615 driver

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Co-developed-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 4ce3d248182c..9d044f23340e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1175,11 +1175,13 @@ static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 
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
@@ -1190,9 +1192,12 @@ static int mt7615_driver_own(struct mt7615_dev *dev)
 
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

