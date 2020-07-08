Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C9E2184E7
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jul 2020 12:26:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728148AbgGHK0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Jul 2020 06:26:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:33590 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgGHK0S (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Jul 2020 06:26:18 -0400
Received: from localhost.localdomain.com (unknown [151.48.133.17])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 61682206F6;
        Wed,  8 Jul 2020 10:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594203978;
        bh=CUOXOWrfN1ofxpKkBuSS6kwoWfVGf956UrSH1W8mer8=;
        h=From:To:Cc:Subject:Date:From;
        b=BgDRDfxqGx5Sje4HsLPJmXsbohODCmijSt8KGe7emOGzXt4V6Ou7scSqKkQ8oLX8P
         wJafXqPPLWfkIgPow77uK6WT7xpSk7gNx9Oge0k8fqjIfpuRJ9UYX3itDGKJ4RgL2p
         ypH+i4UUm7nMI5taK3InS8MxPan3jrFV1bRb5EnI=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH] mt76: mt7615: always compile mt7615_mcu_set_bss_pm
Date:   Wed,  8 Jul 2020 12:26:11 +0200
Message-Id: <d486c81f9902961539574d50348cbd29fd53760e.1594203928.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Move mt7615_mcu_set_bss_pm out of CONFIG_PM in order to fix the
following issue reported by kernel test robot

ERROR: modpost: "mt7615_mcu_set_bss_pm"
[drivers/net/wireless/mediatek/mt76/mt7615/mt7615-common.ko] undefined!

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 68 +++++++++----------
 1 file changed, 34 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index b6f9eadb265a..d6bedc7eb726 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -3527,40 +3527,6 @@ int mt7615_mcu_apply_tx_dpd(struct mt7615_phy *phy)
 	return ret;
 }
 
-#ifdef CONFIG_PM
-int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
-{
-	struct {
-		struct {
-			u8 hif_type; /* 0x0: HIF_SDIO
-				      * 0x1: HIF_USB
-				      * 0x2: HIF_PCIE
-				      */
-			u8 pad[3];
-		} __packed hdr;
-		struct hif_suspend_tlv {
-			__le16 tag;
-			__le16 len;
-			u8 suspend;
-		} __packed hif_suspend;
-	} req = {
-		.hif_suspend = {
-			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
-			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
-			.suspend = suspend,
-		},
-	};
-
-	if (mt76_is_mmio(&dev->mt76))
-		req.hdr.hif_type = 2;
-	else if (mt76_is_usb(&dev->mt76))
-		req.hdr.hif_type = 1;
-
-	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL,
-				   &req, sizeof(req), true);
-}
-EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
-
 int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 			  bool enable)
 {
@@ -3602,6 +3568,40 @@ int mt7615_mcu_set_bss_pm(struct mt7615_dev *dev, struct ieee80211_vif *vif,
 				   &req, sizeof(req), false);
 }
 
+#ifdef CONFIG_PM
+int mt7615_mcu_set_hif_suspend(struct mt7615_dev *dev, bool suspend)
+{
+	struct {
+		struct {
+			u8 hif_type; /* 0x0: HIF_SDIO
+				      * 0x1: HIF_USB
+				      * 0x2: HIF_PCIE
+				      */
+			u8 pad[3];
+		} __packed hdr;
+		struct hif_suspend_tlv {
+			__le16 tag;
+			__le16 len;
+			u8 suspend;
+		} __packed hif_suspend;
+	} req = {
+		.hif_suspend = {
+			.tag = cpu_to_le16(0), /* 0: UNI_HIF_CTRL_BASIC */
+			.len = cpu_to_le16(sizeof(struct hif_suspend_tlv)),
+			.suspend = suspend,
+		},
+	};
+
+	if (mt76_is_mmio(&dev->mt76))
+		req.hdr.hif_type = 2;
+	else if (mt76_is_usb(&dev->mt76))
+		req.hdr.hif_type = 1;
+
+	return __mt76_mcu_send_msg(&dev->mt76, MCU_UNI_CMD_HIF_CTRL,
+				   &req, sizeof(req), true);
+}
+EXPORT_SYMBOL_GPL(mt7615_mcu_set_hif_suspend);
+
 static int
 mt7615_mcu_set_wow_ctrl(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			bool suspend, struct cfg80211_wowlan *wowlan)
-- 
2.26.2

