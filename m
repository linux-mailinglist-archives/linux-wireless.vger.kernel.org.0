Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25693D728A
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Jul 2021 12:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbhG0KF2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 27 Jul 2021 06:05:28 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37648 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236063AbhG0KF1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 27 Jul 2021 06:05:27 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 16RA5MEu8009366, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36502.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 16RA5MEu8009366
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 27 Jul 2021 18:05:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36502.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2106.2; Tue, 27 Jul 2021 18:05:20 +0800
Received: from localhost (172.16.21.11) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2106.2; Tue, 27 Jul
 2021 18:05:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <timlee@realtek.com>
Subject: [PATCH] rtw88: 8822ce: set CLKREQ# signal to low during suspend
Date:   Tue, 27 Jul 2021 18:05:03 +0800
Message-ID: <20210727100503.31626-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.21.11]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2021 09:43:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIxLzcvMjcgpFekyCAwNjowMDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36502.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-AntiSpam-Outbound-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 5.9.20, Database issued on: 07/27/2021 09:51:29
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 165266 [Jul 27 2021]
X-KSE-AntiSpam-Info: Version: 5.9.20.0
X-KSE-AntiSpam-Info: Envelope from: pkshih@realtek.com
X-KSE-AntiSpam-Info: LuaCore: 449 449 5db59deca4a4f5e6ea34a93b13bc730e229092f4
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;realtek.com:7.1.1;127.0.0.199:7.1.2
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 07/27/2021 09:54:00
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Chin-Yen Lee <timlee@realtek.com>

We find the power sequence of system suspend flow don't meet
the criteria when using 8822CE-VR chip by rfe-type 6, because the
reference clock form host is sometimes late. To avoid the behavoir,
we keep CLKREQ# signal to low during suspend to make sure the reference
clock arrival in time.

Signed-off-by: Chin-Yen Lee <timlee@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 33 ++++++++++++++++++++++++
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 2 files changed, 34 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index e7d17ab8f113..0f95a9555aea 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1359,6 +1359,25 @@ static void rtw_pci_clkreq_set(struct rtw_dev *rtwdev, bool enable)
 	rtw_dbi_write8(rtwdev, RTK_PCIE_LINK_CFG, value);
 }
 
+static void rtw_pci_clkreq_pad_low(struct rtw_dev *rtwdev, bool enable)
+{
+	u8 value;
+	int ret;
+
+	ret = rtw_dbi_read8(rtwdev, RTK_PCIE_LINK_CFG, &value);
+	if (ret) {
+		rtw_err(rtwdev, "failed to read CLKREQ_L1, ret=%d", ret);
+		return;
+	}
+
+	if (enable)
+		value &= ~BIT_CLKREQ_N_PAD;
+	else
+		value |= BIT_CLKREQ_N_PAD;
+
+	rtw_dbi_write8(rtwdev, RTK_PCIE_LINK_CFG, value);
+}
+
 static void rtw_pci_aspm_set(struct rtw_dev *rtwdev, bool enable)
 {
 	u8 value;
@@ -1500,11 +1519,25 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 
 static int __maybe_unused rtw_pci_suspend(struct device *dev)
 {
+	struct ieee80211_hw *hw = dev_get_drvdata(dev);
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+
+	if (chip->id == RTW_CHIP_TYPE_8822C && efuse->rfe_option == 6)
+		rtw_pci_clkreq_pad_low(rtwdev, true);
 	return 0;
 }
 
 static int __maybe_unused rtw_pci_resume(struct device *dev)
 {
+	struct ieee80211_hw *hw = dev_get_drvdata(dev);
+	struct rtw_dev *rtwdev = hw->priv;
+	struct rtw_chip_info *chip = rtwdev->chip;
+	struct rtw_efuse *efuse = &rtwdev->efuse;
+
+	if (chip->id == RTW_CHIP_TYPE_8822C && efuse->rfe_option == 6)
+		rtw_pci_clkreq_pad_low(rtwdev, false);
 	return 0;
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 0ffae887527a..66f78eb7757c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -37,6 +37,7 @@
 #define RTK_PCIE_LINK_CFG	0x0719
 #define BIT_CLKREQ_SW_EN	BIT(4)
 #define BIT_L1_SW_EN		BIT(3)
+#define BIT_CLKREQ_N_PAD	BIT(0)
 #define RTK_PCIE_CLKDLY_CTRL	0x0725
 
 #define BIT_PCI_BCNQ_FLAG	BIT(4)
-- 
2.25.1

