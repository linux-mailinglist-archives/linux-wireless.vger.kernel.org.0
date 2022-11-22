Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13B22633781
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Nov 2022 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232970AbiKVIwN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Nov 2022 03:52:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiKVIwH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Nov 2022 03:52:07 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E041340916
        for <linux-wireless@vger.kernel.org>; Tue, 22 Nov 2022 00:52:06 -0800 (PST)
X-UUID: 7b2a57afb7e74e37836a65086af90585-20221122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=pRqJV4snK0oVY8Rx/LUSDCitvG7/SqoZGC7x9qPmPhM=;
        b=oUPh4rnwZFfQxViFqCUTuhoHSpPsmrxrSIQF8bHDS8RYPa92t2DpU7A04IqXcQh/A84wdY9A425sDBKzq97b0OcgDCLuaAXHc5siFlMs8da+xClGW6jEQl1vVfwd7umUCNn8TPBz/7lSkzx/+gBBBQEWGjm3viJibinQXhUY9e0=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:c94fe550-4297-40b5-9866-9aff54104678,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTI
        ON:release,TS:70
X-CID-INFO: VERSION:1.1.12,REQID:c94fe550-4297-40b5-9866-9aff54104678,IP:0,URL
        :0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTI
        ON:quarantine,TS:70
X-CID-META: VersionHash:62cd327,CLOUDID:e75ff7f8-3a34-4838-abcf-dfedf9dd068e,B
        ulkID:2211221652028JUEB0VV,BulkQuantity:0,Recheck:0,SF:28|17|19|48,TC:nil,
        Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 7b2a57afb7e74e37836a65086af90585-20221122
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 432404785; Tue, 22 Nov 2022 16:51:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Tue, 22 Nov 2022 16:51:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 22 Nov 2022 16:51:59 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 8/9] wifi: mt76: mt7996: add module support
Date:   Tue, 22 Nov 2022 16:45:53 +0800
Message-ID: <20221122084554.9494-9-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20221122084554.9494-1-shayne.chen@mediatek.com>
References: <20221122084554.9494-1-shayne.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

(Split the big patch into smaller intermediate patches by functionality
for easier review. Refer to the cover letter for more info.)

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig  | 12 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt7996/Makefile |  6 ++++++
 2 files changed, 18 insertions(+)
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
 create mode 100644 drivers/net/wireless/mediatek/mt76/mt7996/Makefile

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
new file mode 100644
index 000000000000..5c5fc569e6d5
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: ISC
+config MT7996E
+	tristate "MediaTek MT7996 (PCIe) support"
+	select MT76_CONNAC_LIB
+	depends on MAC80211
+	depends on PCI
+	help
+	  This adds support for MT7996-based wireless PCIe devices,
+	  which support concurrent tri-band operation at 6GHz, 5GHz,
+	  and 2.4GHz IEEE 802.11be 4x4:4SS 4096-QAM, 320MHz channels.
+
+	  To compile this driver as a module, choose M here.
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/Makefile b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
new file mode 100644
index 000000000000..bcb9a3c53149
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: ISC
+
+obj-$(CONFIG_MT7996E) += mt7996e.o
+
+mt7996e-y := pci.o init.o dma.o eeprom.o main.o mcu.o mac.o \
+	     debugfs.o mmio.o
-- 
2.25.1

