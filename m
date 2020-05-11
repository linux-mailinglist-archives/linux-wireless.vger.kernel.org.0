Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C54E91CD15C
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 07:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728355AbgEKFsU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 01:48:20 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:50590 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726161AbgEKFsU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 01:48:20 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 04B5m30t9020762, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 04B5m30t9020762
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 11 May 2020 13:48:03 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 13:48:02 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Mon, 11 May 2020 13:48:02 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>, <kevin_yang@realtek.com>,
        <briannorris@chromium.org>
Subject: [PATCH v2 2/7] rtw88: extract: export symbols about pci interface
Date:   Mon, 11 May 2020 13:47:55 +0800
Message-ID: <20200511054800.27422-3-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200511054800.27422-1-yhchuang@realtek.com>
References: <20200511054800.27422-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

In the current design, chip entry points are built into
the pci module. That makes the pci module depend on chips.
According to dependence, once the pci module is loaded,
kernel will load chip functionalities, including those that
may not be currently used.

We plan to split chip entry points from the pci module.
Thence we export pci symbols that will be used in chip
entry point modules.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 493903e0562e..cf742c9a5105 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1361,8 +1361,9 @@ static int rtw_pci_resume(struct device *dev)
 	return 0;
 }
 
-static SIMPLE_DEV_PM_OPS(rtw_pm_ops, rtw_pci_suspend, rtw_pci_resume);
-#define RTW_PM_OPS (&rtw_pm_ops)
+SIMPLE_DEV_PM_OPS(rtw_pci_pm, rtw_pci_suspend, rtw_pci_resume);
+EXPORT_SYMBOL(rtw_pci_pm);
+#define RTW_PM_OPS (&rtw_pci_pm)
 #else
 #define RTW_PM_OPS NULL
 #endif
@@ -1478,8 +1479,8 @@ static void rtw_pci_free_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
 	pci_free_irq_vectors(pdev);
 }
 
-static int rtw_pci_probe(struct pci_dev *pdev,
-			 const struct pci_device_id *id)
+int rtw_pci_probe(struct pci_dev *pdev,
+		  const struct pci_device_id *id)
 {
 	struct ieee80211_hw *hw;
 	struct rtw_dev *rtwdev;
@@ -1556,8 +1557,9 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 
 	return ret;
 }
+EXPORT_SYMBOL(rtw_pci_probe);
 
-static void rtw_pci_remove(struct pci_dev *pdev)
+void rtw_pci_remove(struct pci_dev *pdev)
 {
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct rtw_dev *rtwdev;
@@ -1577,8 +1579,9 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
+EXPORT_SYMBOL(rtw_pci_remove);
 
-static void rtw_pci_shutdown(struct pci_dev *pdev)
+void rtw_pci_shutdown(struct pci_dev *pdev)
 {
 	struct ieee80211_hw *hw = pci_get_drvdata(pdev);
 	struct rtw_dev *rtwdev;
@@ -1593,6 +1596,7 @@ static void rtw_pci_shutdown(struct pci_dev *pdev)
 	if (chip->ops->shutdown)
 		chip->ops->shutdown(rtwdev);
 }
+EXPORT_SYMBOL(rtw_pci_shutdown);
 
 static const struct pci_device_id rtw_pci_id_table[] = {
 #ifdef CONFIG_RTW88_8822BE
-- 
2.17.1

