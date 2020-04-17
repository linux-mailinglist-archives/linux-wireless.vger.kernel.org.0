Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9121AD7D2
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729397AbgDQHrX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:23 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37069 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729348AbgDQHrP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l9hF5020159, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l9hF5020159
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 17 Apr 2020 15:47:09 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:06 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 17 Apr 2020 15:47:05 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <pkshih@realtek.com>, <linux-wireless@vger.kernel.org>,
        <briannorris@chromium.org>, <kevin_yang@realtek.com>
Subject: [PATCH 39/40] rtw88: extract: remove the unused after extracting
Date:   Fri, 17 Apr 2020 15:46:52 +0800
Message-ID: <20200417074653.15591-40-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200417074653.15591-1-yhchuang@realtek.com>
References: <20200417074653.15591-1-yhchuang@realtek.com>
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
 drivers/net/wireless/realtek/rtw88/pci.c | 18 ------------------
 drivers/net/wireless/realtek/rtw88/pci.h |  4 ----
 2 files changed, 22 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 46aaac94287b..9e24c897c948 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1362,9 +1362,6 @@ static int rtw_pci_resume(struct device *dev)
 
 SIMPLE_DEV_PM_OPS(rtw_pci_pm, rtw_pci_suspend, rtw_pci_resume);
 EXPORT_SYMBOL(rtw_pci_pm);
-#define RTW_PM_OPS (&rtw_pci_pm)
-#else
-#define RTW_PM_OPS NULL
 #endif
 
 static int rtw_pci_claim(struct rtw_dev *rtwdev, struct pci_dev *pdev)
@@ -1597,21 +1594,6 @@ void rtw_pci_shutdown(struct pci_dev *pdev)
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
-	.driver.pm = RTW_PM_OPS,
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

