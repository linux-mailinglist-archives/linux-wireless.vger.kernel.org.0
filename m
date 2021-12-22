Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6FA3247CCBE
	for <lists+linux-wireless@lfdr.de>; Wed, 22 Dec 2021 06:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242624AbhLVF61 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 22 Dec 2021 00:58:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:53516 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232036AbhLVF60 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 22 Dec 2021 00:58:26 -0500
X-UUID: 63f418946b4f4ca0b0f04a16e370a6ce-20211222
X-UUID: 63f418946b4f4ca0b0f04a16e370a6ce-20211222
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 955502101; Wed, 22 Dec 2021 13:58:23 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 22 Dec 2021 13:58:21 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 22 Dec
 2021 13:58:21 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 22 Dec 2021 13:58:20 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 2/2] mt76: mt7921s: update mt7921s_wfsys_reset sequence
Date:   Wed, 22 Dec 2021 13:58:18 +0800
Message-ID: <b18e61c14e845af5c4ade2a0eb16acd388058c17.1640151776.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <f18bbe4b077e5e21c3fbb04c5ab84520142d567d.1640151776.git.objelf@gmail.com>
References: <f18bbe4b077e5e21c3fbb04c5ab84520142d567d.1640151776.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: YN Chen <YN.Chen@mediatek.com>

MT7921S firmware expects driver to clear out the firmware download state
before FW is downloaded again in WiFi reset procedure.

Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: YN Chen <YN.Chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/regs.h     | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
index cbd38122c510..411695f273cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/regs.h
@@ -454,6 +454,9 @@
 
 #define MT_DMASHDL_SCHED_SET(_n)	MT_DMA_SHDL(0x070 + ((_n) << 2))
 
+#define MT_CONN_STATUS			0x7c053c10
+#define MT_WIFI_PATCH_DL_STATE		BIT(0)
+
 #define MT_CONN_ON_LPCTL		0x7c060010
 #define PCIE_LPCR_HOST_OWN_SYNC		BIT(2)
 #define PCIE_LPCR_HOST_CLR_OWN		BIT(1)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
index e0f0d3a2b17e..4fd1d4765b04 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mac.c
@@ -63,6 +63,8 @@ int mt7921s_wfsys_reset(struct mt7921_dev *dev)
 	clear_bit(MT76_STATE_MCU_RUNNING, &dev->mphy.state);
 
 	/* activate mt7921s again */
+	mt7921s_mcu_drv_pmctrl(dev);
+	mt76_clear(dev, MT_CONN_STATUS, MT_WIFI_PATCH_DL_STATE);
 	mt7921s_mcu_fw_pmctrl(dev);
 	mt7921s_mcu_drv_pmctrl(dev);
 
-- 
2.25.1

