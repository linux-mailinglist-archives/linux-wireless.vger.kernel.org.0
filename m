Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8C1AD7CE
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Apr 2020 09:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729390AbgDQHrW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Apr 2020 03:47:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:37070 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729350AbgDQHrQ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Apr 2020 03:47:16 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 03H7l9kD5020220, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 03H7l9kD5020220
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
Subject: [PATCH 40/40] rtw88: rename rtw88.ko/rtwpci.ko to rtw88_core.ko/rtw88_pci.ko
Date:   Fri, 17 Apr 2020 15:46:53 +0800
Message-ID: <20200417074653.15591-41-yhchuang@realtek.com>
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

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Rename the name of the kernel module for rtw88's core and pci.
Add proper prefix 'rtw88_' to easily recognize them, also can
avoid confusion with other drivers. (ex. r8822be in staging)

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/Makefile | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wireless/realtek/rtw88/Makefile
index 9e3e95360089..f31e78a6f146 100644
--- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
 
-obj-$(CONFIG_RTW88_CORE)	+= rtw88.o
-rtw88-y += main.o \
+obj-$(CONFIG_RTW88_CORE)	+= rtw88_core.o
+rtw88_core-y += main.o \
 	   mac80211.o \
 	   util.o \
 	   debug.o \
@@ -37,5 +37,5 @@ rtw88_8723d-objs		:= rtw8723d.o rtw8723d_table.o
 obj-$(CONFIG_RTW88_8723DE)	+= rtw88_8723de.o
 rtw88_8723de-objs		:= rtw8723de.o
 
-obj-$(CONFIG_RTW88_PCI)		+= rtwpci.o
-rtwpci-objs			:= pci.o
+obj-$(CONFIG_RTW88_PCI)		+= rtw88_pci.o
+rtw88_pci-objs			:= pci.o
-- 
2.17.1

