Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C94B1C80C4
	for <lists+linux-wireless@lfdr.de>; Thu,  7 May 2020 06:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgEGETx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 May 2020 00:19:53 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:33906 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725793AbgEGETx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 May 2020 00:19:53 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0474JlER2026833, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb06.realtek.com.tw[172.21.6.99])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0474JlER2026833
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 7 May 2020 12:19:47 +0800
Received: from RTEXMB04.realtek.com.tw (172.21.6.97) by
 RTEXMB06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:19:47 +0800
Received: from localhost.localdomain (172.21.68.128) by
 RTEXMB04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Thu, 7 May 2020 12:19:47 +0800
From:   <yhchuang@realtek.com>
To:     <jwboyer@kernel.org>
CC:     <linux-wireless@vger.kernel.org>, <linux-firmware@vger.kernel.org>
Subject: [PATCH] rtw88: update firmware information and README
Date:   Thu, 7 May 2020 12:19:45 +0800
Message-ID: <20200507041945.15491-1-yhchuang@realtek.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.128]
X-ClientProxiedBy: RTEXMB02.realtek.com.tw (172.21.6.95) To
 RTEXMB04.realtek.com.tw (172.21.6.97)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

The rtw88/README should claim support for RTL8723DE devices, add them.

And also there will have confusion that the 802.11ac driver rtw88
supports an 802.11n device RTL8723DE, add the information to WHENCE.

To prevent some fo the distros not including WOW firmware but have WOW
support and cannot load firmware at the end, add a note for it.

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 WHENCE       | 8 ++++++++
 rtw88/README | 3 +++
 2 files changed, 11 insertions(+)

diff --git a/WHENCE b/WHENCE
index 010d1f8..4fe51b2 100644
--- a/WHENCE
+++ b/WHENCE
@@ -2872,6 +2872,14 @@ File: rtw88/rtw8723d_fw.bin
 
 Licence: Redistributable. See LICENCE.rtlwifi_firmware.txt for details.
 
+    These firmware should be put under /lib/firmware/rtw88/
+    And note that the rtw88 driver is able to support wake-on-wireless LAN
+    for RTL8822C devices, after kernel v5.6+. So, make sure the firmware
+    rtw88/rtw8822c_wow_fw.bin is also packed, otherwise the firmware load
+    fail could be a problem.
+    Although RTL8723D devices are 802.11n device, they are also supported
+    by rtw88 because the hardware arch is similar.
+
 --------------------------------------------------------------------------
 
 Driver: rtl8192ee - Realtek 802.11n WLAN driver for RTL8192EE
diff --git a/rtw88/README b/rtw88/README
index 7ee24b3..b2992be 100644
--- a/rtw88/README
+++ b/rtw88/README
@@ -26,3 +26,6 @@ RTL8822CE
     rtw8822c_fw.bin
     rtw8822c_wow_fw.bin
 
+RTL8723DE
+    rtw8723d_fw.bin
+
-- 
2.17.1

