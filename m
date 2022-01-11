Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F00F48A8E1
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jan 2022 08:51:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348713AbiAKHvU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jan 2022 02:51:20 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44152 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1348710AbiAKHvT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jan 2022 02:51:19 -0500
X-UUID: 1e9275eab18141929d7c6a52294b6de1-20220111
X-UUID: 1e9275eab18141929d7c6a52294b6de1-20220111
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1324450976; Tue, 11 Jan 2022 15:51:16 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 11 Jan 2022 15:51:16 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 11 Jan
 2022 15:51:15 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS32.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Tue, 11 Jan 2022 15:51:14 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Xing Song <xing.song@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        "Evelyn Tsai" <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH 4/5] mt76: mt7915: add Kconfig entry for MT7986
Date:   Tue, 11 Jan 2022 15:51:07 +0800
Message-ID: <d63ae1dfe22f90e0a9fa4ccc01152e82287ea0da.1641886298.git.Bo.Jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
References: <351271a274dc236f027c58487df6b21c7dbf9fd0.1641886298.git.Bo.Jiao@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This enables building support for the MT7986 SoC built-in WLAN chip.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/Kconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
index b8b98cb..8db1ddc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/Kconfig
@@ -11,3 +11,14 @@ config MT7915E
 	  OFDMA, spatial reuse and dual carrier modulation.
 
 	  To compile this driver as a module, choose M here.
+
+config MT7986_WMAC
+	bool "MT7986 (SoC) WMAC support"
+	depends on MT7915E
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select REGMAP
+	default y
+	help
+	  This adds support for the built-in WMAC on MT7986 SoC devices
+	  which has the same feature set as a MT7915, but enables 6E
+	  support.
-- 
2.18.0

