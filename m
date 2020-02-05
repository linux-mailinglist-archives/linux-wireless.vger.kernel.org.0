Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D26541526A4
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 08:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBEHJK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 02:09:10 -0500
Received: from rtits2.realtek.com ([211.75.126.72]:49341 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726838AbgBEHJK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 02:09:10 -0500
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID 0157952T008609, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTEXMB06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id 0157952T008609
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 5 Feb 2020 15:09:05 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:05 +0800
Received: from RTEXMB06.realtek.com.tw (172.21.6.99) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 5 Feb 2020 15:09:05 +0800
Received: from RTITCASV01.realtek.com.tw (172.21.6.18) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1779.2
 via Frontend Transport; Wed, 5 Feb 2020 15:09:04 +0800
Received: from localhost.localdomain (172.21.69.117) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Wed, 5 Feb 2020 15:09:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>
Subject: [PATCH 3/7] rtw88: pci: 8822c should set clock delay to zero
Date:   Wed, 5 Feb 2020 15:08:54 +0800
Message-ID: <20200205070858.15386-4-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200205070858.15386-1-yhchuang@realtek.com>
References: <20200205070858.15386-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.69.117]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Since RTL8822CE has enabled reference clock auto calibration,
there is no need to add any clock delay for covering the timing
gap of the reference clock.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 7 +++++++
 drivers/net/wireless/realtek/rtw88/pci.h | 1 +
 2 files changed, 8 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 1fbc14c149ec..9ac77aef708d 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1197,11 +1197,18 @@ static void rtw_pci_link_ps(struct rtw_dev *rtwdev, bool enter)
 
 static void rtw_pci_link_cfg(struct rtw_dev *rtwdev)
 {
+	struct rtw_chip_info *chip = rtwdev->chip;
 	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct pci_dev *pdev = rtwpci->pdev;
 	u16 link_ctrl;
 	int ret;
 
+	/* RTL8822CE has enabled REFCLK auto calibration, it does not need
+	 * to add clock delay to cover the REFCLK timing gap.
+	 */
+	if (chip->id == RTW_CHIP_TYPE_8822C)
+		rtw_dbi_write8(rtwdev, RTK_PCIE_CLKDLY_CTRL, 0);
+
 	/* Though there is standard PCIE configuration space to set the
 	 * link control register, but by Realtek's design, driver should
 	 * check if host supports CLKREQ/ASPM to enable the HW module.
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 1580cfc57361..cd4fcd064cdb 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -39,6 +39,7 @@
 #define RTK_PCIE_LINK_CFG	0x0719
 #define BIT_CLKREQ_SW_EN	BIT(4)
 #define BIT_L1_SW_EN		BIT(3)
+#define RTK_PCIE_CLKDLY_CTRL	0x0725
 
 #define BIT_PCI_BCNQ_FLAG	BIT(4)
 #define RTK_PCI_TXBD_DESA_BCNQ	0x308
-- 
2.17.1

