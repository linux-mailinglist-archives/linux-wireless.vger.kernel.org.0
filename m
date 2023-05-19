Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E61FE708E34
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjESDP2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230192AbjESDP0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32284B1
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:24 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3FAr54004817, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3FAr54004817
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:15:10 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 19 May 2023 11:15:19 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:18 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 7/7] wifi: rtw89: 8851b: add 8851be to Makefile and Kconfig
Date:   Fri, 19 May 2023 11:15:00 +0800
Message-ID: <20230519031500.21087-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519031500.21087-1-pkshih@realtek.com>
References: <20230519031500.21087-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Since 8851BE is ready, so add 8851BE to Makefile and Kconfig. Currently,
it can support STA, AP and monitor modes with good performance.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/Kconfig  | 14 ++++++++++++++
 drivers/net/wireless/realtek/rtw89/Makefile |  9 +++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/Kconfig b/drivers/net/wireless/realtek/rtw89/Kconfig
index 2b20cf8bbf3aa..90ffbab7cc4c6 100644
--- a/drivers/net/wireless/realtek/rtw89/Kconfig
+++ b/drivers/net/wireless/realtek/rtw89/Kconfig
@@ -16,6 +16,9 @@ config RTW89_CORE
 config RTW89_PCI
 	tristate
 
+config RTW89_8851B
+	tristate
+
 config RTW89_8852A
 	tristate
 
@@ -25,6 +28,17 @@ config RTW89_8852B
 config RTW89_8852C
 	tristate
 
+config RTW89_8851BE
+	tristate "Realtek 8851BE PCI wireless network (Wi-Fi 6) adapter"
+	depends on PCI
+	select RTW89_CORE
+	select RTW89_PCI
+	select RTW89_8851B
+	help
+	  Select this option will enable support for 8851BE chipset
+
+	  802.11ax PCIe wireless network (Wi-Fi 6) adapter
+
 config RTW89_8852AE
 	tristate "Realtek 8852AE PCI wireless network (Wi-Fi 6) adapter"
 	depends on PCI
diff --git a/drivers/net/wireless/realtek/rtw89/Makefile b/drivers/net/wireless/realtek/rtw89/Makefile
index 99e870d6a7d7d..41940099af1b6 100644
--- a/drivers/net/wireless/realtek/rtw89/Makefile
+++ b/drivers/net/wireless/realtek/rtw89/Makefile
@@ -18,6 +18,15 @@ rtw89_core-y += core.o \
 
 rtw89_core-$(CONFIG_PM) += wow.o
 
+obj-$(CONFIG_RTW89_8851B) += rtw89_8851b.o
+rtw89_8851b-objs := rtw8851b.o \
+		    rtw8851b_table.o \
+		    rtw8851b_rfk.o \
+		    rtw8851b_rfk_table.o
+
+obj-$(CONFIG_RTW89_8851BE) += rtw89_8851be.o
+rtw89_8851be-objs := rtw8851be.o
+
 obj-$(CONFIG_RTW89_8852A) += rtw89_8852a.o
 rtw89_8852a-objs := rtw8852a.o \
 		    rtw8852a_table.o \
-- 
2.25.1

