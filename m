Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC3D1B174C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2020 22:41:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726296AbgDTUlG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Apr 2020 16:41:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:50074 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725774AbgDTUlG (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Apr 2020 16:41:06 -0400
Received: from localhost.localdomain.com (unknown [151.48.159.126])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E476920782;
        Mon, 20 Apr 2020 20:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587415266;
        bh=GLxEuUpZmPKLyF7Fii7QgCUvp5vaU8CMWydqEtmidRg=;
        h=From:To:Cc:Subject:Date:From;
        b=mZGpqWAjNORBSQX+UZhS2xAHYaW6sa2pF8ghKvGRoP4RSH/hGuqFPduVMlJ5qZ6y/
         t9SkQQOuCUOoBSJxW8mbeDEY6cN4wMNDURFkJLocL2VasZQKjo0EW6mopmTbpuzIoV
         xVwgKOP1yhcYjWeXCnNCnehNV75Y9Id1fQ+oox4c=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org
Subject: [PATCH] mt76: mt7615: fix mt7615_driver_own routine
Date:   Mon, 20 Apr 2020 22:40:55 +0200
Message-Id: <f2010f464d9927ecb1e43c727f50de968f714a6a.1587414726.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce MT_PCIE_DOORBELL_PUSH register to fix mt7615_driver_own
routine for mt7663e

Fixes: f40ac0f3d3c0 ("mt76: mt7615: introduce mt7663e support")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c  | 6 +++++-
 drivers/net/wireless/mediatek/mt76/mt7615/regs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 7081bc4723ee..b3cc04ce84be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -1686,16 +1686,20 @@ static void mt7622_trigger_hif_int(struct mt7615_dev *dev, bool en)
 
 static int mt7615_driver_own(struct mt7615_dev *dev)
 {
+	struct mt76_dev *mdev = &dev->mt76;
 	u32 addr;
 
-	addr = is_mt7663(&dev->mt76) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
+	addr = is_mt7663(mdev) ? MT_PCIE_DOORBELL_PUSH : MT_CFG_LPCR_HOST;
 	mt76_wr(dev, addr, MT_CFG_LPCR_HOST_DRV_OWN);
 
 	mt7622_trigger_hif_int(dev, true);
+
+	addr = is_mt7663(mdev) ? MT_CONN_HIF_ON_LPCTL : MT_CFG_LPCR_HOST;
 	if (!mt76_poll_msec(dev, addr, MT_CFG_LPCR_HOST_FW_OWN, 0, 3000)) {
 		dev_err(dev->mt76.dev, "Timeout for driver own\n");
 		return -EIO;
 	}
+
 	mt7622_trigger_hif_int(dev, false);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
index ab3c6b77df07..054831ecad68 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/regs.h
@@ -68,6 +68,7 @@ enum mt7615_reg_base {
 #define MT_HIF2_BASE			0xf0000
 #define MT_HIF2(ofs)			(MT_HIF2_BASE + (ofs))
 #define MT_PCIE_IRQ_ENABLE		MT_HIF2(0x188)
+#define MT_PCIE_DOORBELL_PUSH		MT_HIF2(0x1484)
 
 #define MT_CFG_LPCR_HOST		MT_HIF(0x1f0)
 #define MT_CFG_LPCR_HOST_FW_OWN		BIT(0)
-- 
2.25.3

