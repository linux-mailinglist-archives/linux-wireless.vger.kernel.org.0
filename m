Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B26619C8A8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Apr 2020 20:19:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389123AbgDBSTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 2 Apr 2020 14:19:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:52728 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388843AbgDBSTT (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 2 Apr 2020 14:19:19 -0400
Received: from localhost.localdomain.com (unknown [151.48.151.50])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0D58120675;
        Thu,  2 Apr 2020 18:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1585851559;
        bh=TDASILMJOLJvIv1cuIv5HOmWS3eSBCaZsUjDIpsETvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=anR4ZWPPMin/2h065nj2VBwTF44L/DkQR8FvJwqqncI6ar8d6JEaJ/kvubXcmfR54
         pLzR6f/XQpCqpiVvIzxYereAOvzfACAE8dyn4etCg0C+8BTNFFqd99ZGGcNNtTtr2j
         dOXqBHalYEeT2TT84KefhOSuWn5F6iFYg4+yyg+A=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, linux-wireless@vger.kernel.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH 4/9] mt76: mt7615: introduce __mt7663_load_firmware routine
Date:   Thu,  2 Apr 2020 20:18:51 +0200
Message-Id: <e3e930b199235f8aa628c437862647c5197569b9.1585851049.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1585851049.git.lorenzo@kernel.org>
References: <cover.1585851049.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce __mt7663_load_firmware routine to load firmware for usb
devices.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt7615/mcu.c   | 22 ++++++++++++++-----
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  1 +
 2 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 12759158e69a..dcd97606e827 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -2078,12 +2078,10 @@ static int mt7663_load_n9(struct mt7615_dev *dev, const char *name)
 	return ret;
 }
 
-static int mt7663_load_firmware(struct mt7615_dev *dev)
+int __mt7663_load_firmware(struct mt7615_dev *dev)
 {
 	int ret;
 
-	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
-
 	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
 	if (ret) {
 		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
@@ -2109,12 +2107,26 @@ static int mt7663_load_firmware(struct mt7615_dev *dev)
 		return -EIO;
 	}
 
-	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
-
 	dev_dbg(dev->mt76.dev, "Firmware init done\n");
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(__mt7663_load_firmware);
+
+static int mt7663_load_firmware(struct mt7615_dev *dev)
+{
+	int ret;
+
+	mt76_set(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
+
+	ret = __mt7663_load_firmware(dev);
+	if (ret)
+		return ret;
+
+	mt76_clear(dev, MT_WPDMA_GLO_CFG, MT_WPDMA_GLO_CFG_BYPASS_TX_SCH);
+
+	return 0;
+}
 
 int mt7615_mcu_init(struct mt7615_dev *dev)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index 35bfab58490e..c0bc4913eec4 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -460,5 +460,6 @@ int mt7615_mcu_set_sku_en(struct mt7615_phy *phy, bool enable);
 int mt7615_dfs_init_radar_detector(struct mt7615_phy *phy);
 
 int mt7615_init_debugfs(struct mt7615_dev *dev);
+int __mt7663_load_firmware(struct mt7615_dev *dev);
 
 #endif
-- 
2.25.1

