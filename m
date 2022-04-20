Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6661F508500
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 11:31:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357745AbiDTJeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 05:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353295AbiDTJeQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 05:34:16 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E59DFE8
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 02:31:29 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 23K9VGOz8027337, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 23K9VGOz8027337
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 20 Apr 2022 17:31:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Wed, 20 Apr 2022 17:31:16 +0800
Received: from localhost (172.16.16.159) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.21; Wed, 20 Apr
 2022 17:31:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <tony0620emma@gmail.com>, <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <phhuang@realtek.com>
Subject: [PATCH 2/2] rtw88: pci: 8821c: Disable 21ce completion timeout
Date:   Wed, 20 Apr 2022 17:30:58 +0800
Message-ID: <20220420093058.31646-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420093058.31646-1-pkshih@realtek.com>
References: <20220420093058.31646-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.159]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/20/2022 09:17:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzQvMjAgpFekyCAwNzo1MDowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Po-Hao Huang <phhuang@realtek.com>

Disable this capability to avoid timeout errors on certain platforms.
Without it, pci bus might stuck and leads to disconnection.

Signed-off-by: Po-Hao Huang <phhuang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 33042b63a151e..3ef0de70af328 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -1482,12 +1482,15 @@ static void rtw_pci_interface_cfg(struct rtw_dev *rtwdev)
 
 static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 {
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
 	struct rtw_chip_info *chip = rtwdev->chip;
+	struct pci_dev *pdev = rtwpci->pdev;
 	const struct rtw_intf_phy_para *para;
 	u16 cut;
 	u16 value;
 	u16 offset;
 	int i;
+	int ret;
 
 	cut = BIT(0) << rtwdev->hal.cut_version;
 
@@ -1520,6 +1523,15 @@ static void rtw_pci_phy_cfg(struct rtw_dev *rtwdev)
 	}
 
 	rtw_pci_link_cfg(rtwdev);
+
+	/* Disable 8821ce completion timeout by default */
+	if (chip->id == RTW_CHIP_TYPE_8821C) {
+		ret = pcie_capability_set_word(pdev, PCI_EXP_DEVCTL2,
+					       PCI_EXP_DEVCTL2_COMP_TMOUT_DIS);
+		if (ret)
+			rtw_err(rtwdev, "failed to set PCI cap, ret = %d\n",
+				ret);
+	}
 }
 
 static int __maybe_unused rtw_pci_suspend(struct device *dev)
-- 
2.25.1

