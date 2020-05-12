Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61F181CF26D
	for <lists+linux-wireless@lfdr.de>; Tue, 12 May 2020 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729493AbgELKbg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 May 2020 06:31:36 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:36680 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729443AbgELKbg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 May 2020 06:31:36 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04CAVNFs8009941, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04CAVNFs8009941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 12 May 2020 18:31:23 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:31:23 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Tue, 12 May 2020 18:31:22 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>, <kevin_yang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v3 6/7] rtw88: extract: remove the unused after extracting
Date:   Tue, 12 May 2020 18:31:19 +0800
Message-ID: <20200512103120.5280-7-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200512103120.5280-1-yhchuang@realtek.com>
References: <20200512103120.5280-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

remove the unused about pci after extracting chip modules

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 15 ---------------
 drivers/net/wireless/realtek/rtw88/pci.h |  4 ----
 2 files changed, 19 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 2a188bbc6d5a..8228db9a5fc8 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1593,21 +1593,6 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(rtw_pci_shutdown);
 
-static const struct pci_device_id rtw_pci_id_table[] = {
-	{},
-};
-MODULE_DEVICE_TABLE(pci, rtw_pci_id_table);
-
-static struct pci_driver rtw_pci_driver = {
-	.name = "rtw_pci",
-	.id_table = rtw_pci_id_table,
-	.probe = rtw_pci_probe,
-	.remove = rtw_pci_remove,
-	.driver.pm = &rtw_pm_ops,
-	.shutdown = rtw_pci_shutdown,
-};
-module_pci_driver(rtw_pci_driver);
-
 MODULE_AUTHOR("Realtek Corporation");
 MODULE_DESCRIPTION("Realtek 802.11ac wireless PCI driver");
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 3ac4fb328d31..024c2bc275cb 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -5,10 +5,6 @@
 #ifndef __RTK_PCI_H_
 #define __RTK_PCI_H_
 
-#define RTK_PCI_DEVICE(vend, dev, hw_config)	\
-	PCI_DEVICE(vend, dev),			\
-	.driver_data = (kernel_ulong_t)&(hw_config),
-
 #define RTK_DEFAULT_TX_DESC_NUM 128
 #define RTK_BEQ_TX_DESC_NUM	256
 
-- 
2.17.1

