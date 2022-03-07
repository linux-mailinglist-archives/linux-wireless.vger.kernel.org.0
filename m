Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF4A14CF18E
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 07:06:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235461AbiCGGG5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 01:06:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235457AbiCGGGz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 01:06:55 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D37135F269
        for <linux-wireless@vger.kernel.org>; Sun,  6 Mar 2022 22:06:01 -0800 (PST)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.73 with qID 22765nzuE022541, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36504.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.71/5.88) with ESMTPS id 22765nzuE022541
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 7 Mar 2022 14:05:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36504.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Mon, 7 Mar 2022 14:05:48 +0800
Received: from localhost (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.20; Mon, 7 Mar
 2022 14:05:48 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 02/13] rtw89: pci: add struct rtw89_pci_info
Date:   Mon, 7 Mar 2022 14:04:46 +0800
Message-ID: <20220307060457.56789-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220307060457.56789-1-pkshih@realtek.com>
References: <20220307060457.56789-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 03/07/2022 05:48:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzMvNyCkV6TIIDAzOjQ5OjAw?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36504.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use this struct to implement chip::ops related to PCI interface.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h      | 7 +++++++
 drivers/net/wireless/realtek/rtw89/pci.c       | 1 +
 drivers/net/wireless/realtek/rtw89/pci.h       | 3 +++
 drivers/net/wireless/realtek/rtw89/rtw8852ae.c | 6 ++++++
 drivers/net/wireless/realtek/rtw89/rtw8852ce.c | 6 ++++++
 5 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index f066e6c24e80f..634fcc37eeaa9 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -13,6 +13,7 @@
 #include <net/mac80211.h>
 
 struct rtw89_dev;
+struct rtw89_pci_info;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -2281,8 +2282,13 @@ struct rtw89_chip_info {
 	u8 ps_mode_supported;
 };
 
+union rtw89_bus_info {
+	const struct rtw89_pci_info *pci;
+};
+
 struct rtw89_driver_info {
 	const struct rtw89_chip_info *chip;
+	union rtw89_bus_info bus;
 };
 
 enum rtw89_hcifc_mode {
@@ -2829,6 +2835,7 @@ struct rtw89_dev {
 	bool dbcc_en;
 	struct rtw89_hw_scan_info scan_info;
 	const struct rtw89_chip_info *chip;
+	const struct rtw89_pci_info *pci_info;
 	struct rtw89_hal hal;
 	struct rtw89_mac_info mac;
 	struct rtw89_fw_info fw;
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 6481085b958e7..9f2a23e79e5d1 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2937,6 +2937,7 @@ int rtw89_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	info = (const struct rtw89_driver_info *)id->driver_data;
 	rtwdev->chip = info->chip;
+	rtwdev->pci_info = info->bus.pci;
 
 	ret = rtw89_core_init(rtwdev);
 	if (ret) {
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 7f1ee1544688d..2b8bbfa77d1b3 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -382,6 +382,9 @@ enum rtw89_pcie_clkdly_hw {
 	PCIE_CLKDLY_HW_200US = 0x5,
 };
 
+struct rtw89_pci_info {
+};
+
 struct rtw89_pci_bd_ram {
 	u8 start_idx;
 	u8 max_num;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
index de93280e0f697..527c0bba0aa63 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ae.c
@@ -8,8 +8,14 @@
 #include "pci.h"
 #include "rtw8852a.h"
 
+static const struct rtw89_pci_info rtw8852a_pci_info = {
+};
+
 static const struct rtw89_driver_info rtw89_8852ae_info = {
 	.chip = &rtw8852a_chip_info,
+	.bus = {
+		.pci = &rtw8852a_pci_info,
+	},
 };
 
 static const struct pci_device_id rtw89_8852ae_id_table[] = {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
index ee700bba1eb10..f3ce71c822bc8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852ce.c
@@ -9,8 +9,14 @@
 #include "reg.h"
 #include "rtw8852c.h"
 
+static const struct rtw89_pci_info rtw8852c_pci_info = {
+};
+
 static const struct rtw89_driver_info rtw89_8852ce_info = {
 	.chip = &rtw8852c_chip_info,
+	.bus = {
+		.pci = &rtw8852c_pci_info,
+	},
 };
 
 static const struct pci_device_id rtw89_8852ce_id_table[] = {
-- 
2.25.1

