Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0A907409E7
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Jun 2023 09:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231274AbjF1Hw7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 28 Jun 2023 03:52:59 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:39110 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231182AbjF1Hwg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 28 Jun 2023 03:52:36 -0400
X-UUID: 69d68724158211ee9cb5633481061a41-20230628
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gpJc5mprWGDVPDiVZ4pV46Kn+5Ei5LBjkcCQC2uFjSE=;
        b=nhGyZgTKdeh2ATeW0fmMZlhRolPiRUG7qhr+TXeZOqu99lf0Gcj4hmuqsRYkdi07pGq2sKwclBC9uqfIPaGd1YdD+XdfhC2MV1kPXHcdJIuAWM2wrIGS5EbUKMUoQMtyvqjU0/aNtsV10CeCF8lCNSaFfdzzGYBVbRF2sS4U8xI=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:f1a66fc3-8efe-416a-8c43-61ad7f8d0362,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:57ea7182-5a99-42ae-a2dd-e4afb731b474,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 69d68724158211ee9cb5633481061a41-20230628
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw01.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1082039237; Wed, 28 Jun 2023 15:07:16 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 28 Jun 2023 15:07:14 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 28 Jun 2023 15:07:14 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH 07/16] wifi: mt76: mt7921: rename mt7921_hif_ops in mt792x_hif_ops
Date:   Wed, 28 Jun 2023 15:05:53 +0800
Message-ID: <b404ccd5a7ab399d747cafebfdfce6227648e7cd.1687919628.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <cover.1687919628.git.deren.wu@mediatek.com>
References: <cover.1687919628.git.deren.wu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Lorenzo Bianconi <lorenzo@kernel.org>

This is a preliminary patch to introduce WiFi7 chipset support

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/sdio.c   | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c    | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 617aecd42544..e84c6a56d40e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -249,7 +249,7 @@ enum mt7921_eeprom_field {
 #define mt7921_mcu_init(dev)		((dev)->hif_ops->mcu_init(dev))
 #define __mt7921_mcu_drv_pmctrl(dev)	((dev)->hif_ops->drv_own(dev))
 #define	__mt7921_mcu_fw_pmctrl(dev)	((dev)->hif_ops->fw_own(dev))
-struct mt7921_hif_ops {
+struct mt792x_hif_ops {
 	int (*init_reset)(struct mt792x_dev *dev);
 	int (*reset)(struct mt792x_dev *dev);
 	int (*mcu_init)(struct mt792x_dev *dev);
@@ -278,7 +278,7 @@ struct mt792x_dev {
 
 	struct mt76_connac_pm pm;
 	struct mt76_connac_coredump coredump;
-	const struct mt7921_hif_ops *hif_ops;
+	const struct mt792x_hif_ops *hif_ops;
 
 	struct work_struct ipv6_ns_work;
 	/* IPv6 addresses for WoWLAN */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 517e4d541bdc..4227b5028a6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -247,7 +247,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt7921_update_channel,
 	};
-	static const struct mt7921_hif_ops mt7921_pcie_ops = {
+	static const struct mt792x_hif_ops mt7921_pcie_ops = {
 		.init_reset = mt7921e_init_reset,
 		.reset = mt7921e_mac_reset,
 		.mcu_init = mt7921e_mcu_init,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 86da0cbbdf3b..b438947c2bd8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -114,7 +114,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.rd_rp = mt76s_rd_rp,
 		.type = MT76_BUS_SDIO,
 	};
-	static const struct mt7921_hif_ops mt7921_sdio_ops = {
+	static const struct mt792x_hif_ops mt7921_sdio_ops = {
 		.init_reset = mt7921s_init_reset,
 		.reset = mt7921s_mac_reset,
 		.mcu_init = mt7921s_mcu_init,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 898cb1de9400..b02a6d03c645 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -191,7 +191,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt7921_update_channel,
 	};
-	static const struct mt7921_hif_ops hif_ops = {
+	static const struct mt792x_hif_ops hif_ops = {
 		.mcu_init = mt7921u_mcu_init,
 		.init_reset = mt7921u_init_reset,
 		.reset = mt7921u_mac_reset,
-- 
2.18.0

