Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D6E1EF267
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jun 2020 09:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbgFEHrZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 5 Jun 2020 03:47:25 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:56931 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726024AbgFEHrY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 5 Jun 2020 03:47:24 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0557l5MR1005822, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0557l5MR1005822
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 5 Jun 2020 15:47:05 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 5 Jun 2020 15:47:05 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Fri, 5 Jun 2020 15:47:04 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <kernel@iuliancostan.com>, <linux-wireless@vger.kernel.org>,
        <i@outv.im>, <trevor@shartrec.com>
Subject: [PATCH v1] rtw88: pci: disable aspm for platform inter-op with module parameter
Date:   Fri, 5 Jun 2020 15:47:03 +0800
Message-ID: <20200605074703.32726-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB03.realtek.com.tw (172.21.6.96) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Some platforms cannot read the DBI register successfully for the
ASPM settings. After the read failed, the bus could be unstable,
and the device just became unavailable [1]. For those platforms,
the ASPM should be disabled. But as the ASPM can help the driver
to save the power consumption in power save mode, the ASPM is still
needed. So, add a module parameter for them to disable it, then
the device can still work, while others can benefit from the less
power consumption that brings by ASPM enabled.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=206411
[2] Note that my lenovo T430 is the same.

Fixes: 3dff7c6e3749 ("rtw88: allows to enable/disable HCI link PS mechanism")
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 8228db9a5fc8..3413973bc475 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -14,8 +14,11 @@
 #include "debug.h"
 
 static bool rtw_disable_msi;
+static bool rtw_pci_disable_aspm;
 module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
+module_param_named(disable_aspm, rtw_pci_disable_aspm, bool, 0644);
 MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
+MODULE_PARM_DESC(disable_aspm, "Set Y to disable PCI ASPM support");
 
 static u32 rtw_pci_tx_queue_idx_addr[] = {
 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
@@ -1200,6 +1203,9 @@ static void rtw_pci_clkreq_set(struct rtw_dev *rtwdev, bool enable)
 	u8 value;
 	int ret;
 
+	if (rtw_pci_disable_aspm)
+		return;
+
 	ret = rtw_dbi_read8(rtwdev, RTK_PCIE_LINK_CFG, &value);
 	if (ret) {
 		rtw_err(rtwdev, "failed to read CLKREQ_L1, ret=%d", ret);
@@ -1219,6 +1225,9 @@ static void rtw_pci_aspm_set(struct rtw_dev *rtwdev, bool enable)
 	u8 value;
 	int ret;
 
+	if (rtw_pci_disable_aspm)
+		return;
+
 	ret = rtw_dbi_read8(rtwdev, RTK_PCIE_LINK_CFG, &value);
 	if (ret) {
 		rtw_err(rtwdev, "failed to read ASPM, ret=%d", ret);
-- 
2.17.1

