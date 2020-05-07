Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C68351C80C8
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:22:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725900AbgEGEWP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:22:15 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:34090 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbgEGEWP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:22:15 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474LwJ72027301, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474LwJ72027301
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:21:58 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:58 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:21:57 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <pkshih@realtek.com>,
        <bigeasy@linutronix.de>
Subject: [PATCH v2 9/9] rtw88: 8723d: Add 8723DE to Kconfig and Makefile
Date:   Thu, 7 May 2020 12:21:51 +0800
Message-ID: <20200507042151.15634-10-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507042151.15634-1-yhchuang@realtek.com>
References: <20200507042151.15634-1-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ping-Ke Shih <pkshih@realtek.com>

Since 8723D code is ready, we can build it.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Kconfig  | 10 ++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile |  1 +
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wireless/realtek/rtw88/Kconfig
index 33bd7ed797ff..7a5fa68945c4 100644
--- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -36,6 +36,16 @@ config RTW88_8822CE
 
 	  802.11ac PCIe wireless network adapter
 
+config RTW88_8723DE
+	bool "Realtek 8723DE PCI wireless network adapter"
+	depends on PCI
+	select RTW88_CORE
+	select RTW88_PCI
+	help
+	  Select this option will enable support for 8723DE chipset
+
+	  802.11n PCIe wireless network adapter
+
 config RTW88_DEBUG
 	bool "Realtek rtw88 debug support"
 	depends on RTW88_CORE
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index cac148d13cf1..385facc0dd20 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -20,6 +20,7 @@ rtw88-y += main.o \
 
 rtw88-$(CONFIG_RTW88_8822BE)	+= rtw8822b.o rtw8822b_table.o
 rtw88-$(CONFIG_RTW88_8822CE)	+= rtw8822c.o rtw8822c_table.o
+rtw88-$(CONFIG_RTW88_8723DE)	+= rtw8723d.o rtw8723d_table.o
 
 obj-$(CONFIG_RTW88_PCI)		+= rtwpci.o
 rtwpci-objs			:= pci.o
-- 
2.17.1

