Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35D267409FC
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbjF1Hz7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:55:59 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:52802 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230119AbjF1HyJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:54:09 -0400
X-UUID: a710593a158211eeb20a276fd37b9834-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kML7G+8Bth1kltEWVNQy0KsEdLims37RCLMhSIy1u0I=;
        b=TAvjaIonXDVNRNpGE9i0QihTWsJ6gCsk1zvUtdy8qyw9ZXwgqCnBKzm1u8StyxvpnOnRlmV2K5SZfVEem/863rtTmUaH/kvscYhtXTpf6c1ZsQigONYPrhlxf6WZWaGYloR6MdGtVOkum5BFLv+ww/wM34Nkb0JibBSGCN6B4s0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:c0947c4a-caea-4604-aeeb-5cf10679093f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.27,REQID:c0947c4a-caea-4604-aeeb-5cf10679093f,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:01c9525,CLOUDID:a7764f0d-26a8-467f-b838-f99719a9c083,B
        ulkID:230628150859QCHCC1IV,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_FAS,TF_CID_SPAM_FSD,TF_CID_SPAM_SNR,TF_CID_SPAM_SDM,
        TF_CID_SPAM_ASC
X-UUID: a710593a158211eeb20a276fd37b9834-20230628
Received: from mtkmbs14n2.mediatek.inc [(172.21.101.76)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 642980684; Wed, 28 Jun 2023 15:08:58 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:08:57 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:08:57 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 02/11] wifi: mt76: mt7921: move hif_ops macro in mt792x.h
Date:   Wed, 28 Jun 2023 15:07:15 +0800
Message-ID: <876e6c838920bae1208a89237c6fdb23613c4e23.1687920269.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687920269.git.deren.wu@mediatek.com>
References: <cover.1687920269.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

Move the following hif_ops macro in mt792x.h:
- mt7925_init_reset
- mt7925_dev_reset
- mt7925_mcu_init
- __mt7925_mcu_drv_pmctrl
- __mt7925_mcu_fw_pmctrl

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/init.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   | 6 ------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c      | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/testmode.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt792x.h          | 6 ++++++
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
index 0a6f8f42b2e4..6b8e31110fdf 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
@@ -107,7 +107,7 @@ static int __mt7921_init_hardware(struct mt792x_dev *dev)
 	 * which should be set before firmware download stage.
 	 */
 	mt76_wr(dev, MT_SWDEF_MODE, MT_SWDEF_NORMAL_MODE);
-	ret = mt7921_mcu_init(dev);
+	ret = mt792x_mcu_init(dev);
 	if (ret)
 		goto out;
 
@@ -133,7 +133,7 @@ static int mt7921_init_hardware(struct mt792x_dev *dev)
 		if (!ret)
 			break;
 
-		mt7921_init_reset(dev);
+		mt792x_init_reset(dev);
 	}
 
 	if (i == MT7921_MCU_INIT_RETRY_COUNT) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 70382194825a..25d853a75a23 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -672,7 +672,7 @@ void mt7921_mac_reset_work(struct work_struct *work)
 
 	for (i = 0; i < 10; i++) {
 		mutex_lock(&dev->mt76.mutex);
-		ret = mt7921_dev_reset(dev);
+		ret = mt792x_dev_reset(dev);
 		mutex_unlock(&dev->mt76.mutex);
 
 		if (!ret)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index ed02fa48841c..9bfa79893b10 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -482,9 +482,9 @@ static int mt7921_load_firmware(struct mt792x_dev *dev)
 
 	if (mt76_is_sdio(&dev->mt76)) {
 		/* activate again */
-		ret = __mt7921_mcu_fw_pmctrl(dev);
+		ret = __mt792x_mcu_fw_pmctrl(dev);
 		if (!ret)
-			ret = __mt7921_mcu_drv_pmctrl(dev);
+			ret = __mt792x_mcu_drv_pmctrl(dev);
 	}
 
 	ret = mt76_connac2_load_ram(&dev->mt76, mt7921_ram_name(dev), NULL);
@@ -953,7 +953,7 @@ int mt7921_mcu_drv_pmctrl(struct mt792x_dev *dev)
 	if (!test_bit(MT76_STATE_PM, &mphy->state))
 		goto out;
 
-	err = __mt7921_mcu_drv_pmctrl(dev);
+	err = __mt792x_mcu_drv_pmctrl(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
@@ -975,7 +975,7 @@ int mt7921_mcu_fw_pmctrl(struct mt792x_dev *dev)
 	if (mt76_connac_skip_fw_pmctrl(mphy, pm))
 		goto out;
 
-	err = __mt7921_mcu_fw_pmctrl(dev);
+	err = __mt792x_mcu_fw_pmctrl(dev);
 out:
 	mutex_unlock(&pm->mutex);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index b797d8bab5e2..86b8c98e3f69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -159,12 +159,6 @@ enum mt7921_eeprom_field {
 
 #define MT_EE_HW_TYPE_ENCAP			BIT(0)
 
-#define mt7921_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
-#define mt7921_dev_reset(dev)		((dev)->hif_ops->reset(dev))
-#define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
-#define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
-#define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
-
 enum {
 	TXPWR_USER,
 	TXPWR_EEPROM,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index d11406c87df7..7e9bb1879f9c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -46,7 +46,7 @@ static void mt7921e_unregister_device(struct mt792x_dev *dev)
 	cancel_work_sync(&dev->reset_work);
 
 	mt76_connac2_tx_token_put(&dev->mt76);
-	__mt7921_mcu_drv_pmctrl(dev);
+	__mt792x_mcu_drv_pmctrl(dev);
 	mt792x_dma_cleanup(dev);
 	mt792x_wfsys_reset(dev);
 	skb_queue_purge(&dev->mt76.mcu.res_q);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
index 3c2165095ddd..e838d93477c1 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/testmode.c
@@ -57,7 +57,7 @@ mt7921_tm_set(struct mt792x_dev *dev, struct mt7921_tm_cmd *req)
 		pm->enable = false;
 		cancel_delayed_work_sync(&pm->ps_work);
 		cancel_work_sync(&pm->wake_work);
-		__mt7921_mcu_drv_pmctrl(dev);
+		__mt792x_mcu_drv_pmctrl(dev);
 
 		phy->test.state = MT76_TM_STATE_ON;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt792x.h b/drivers/net/wireless/mediatek/mt76/mt792x.h
index 894fb0fe8cba..1c2829cd954d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt792x.h
+++ b/drivers/net/wireless/mediatek/mt76/mt792x.h
@@ -127,6 +127,12 @@ struct mt792x_irq_map {
 	} rx;
 };
 
+#define mt792x_init_reset(dev)		((dev)->hif_ops->init_reset(dev))
+#define mt792x_dev_reset(dev)		((dev)->hif_ops->reset(dev))
+#define mt792x_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
+#define __mt792x_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
+#define	__mt792x_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
+
 struct mt792x_hif_ops {
 	int (*init_reset)(struct mt792x_dev *dev);
 	int (*reset)(struct mt792x_dev *dev);
-- 
2.18.0

