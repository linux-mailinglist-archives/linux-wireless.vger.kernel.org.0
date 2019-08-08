Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 570BB85CB1
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2019 10:22:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731839AbfHHIWw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Aug 2019 04:22:52 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:32919 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731281AbfHHIWw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Aug 2019 04:22:52 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x788McU0001628, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x788McU0001628
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 8 Aug 2019 16:22:38 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Thu, 8 Aug 2019 16:22:37 +0800
From:   <yhchuang@realtek.com>
To:     <jwboyer@kernel.org>
CC:     <linux-firmware@kernel.org>, <linux-wireless@vger.kernel.org>,
        <Larry.Finger@lwfinger.net>, <briannorris@chromium.org>,
        <arend.vanspriel@broadcom.com>
Subject: [PATCH v3 3/3] rtw88: add a README file
Date:   Thu, 8 Aug 2019 16:22:29 +0800
Message-ID: <1565252549-25524-4-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1565252549-25524-1-git-send-email-yhchuang@realtek.com>
References: <1565252549-25524-1-git-send-email-yhchuang@realtek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yan-Hsuan Chuang <yhchuang@realtek.com>

Add a README to describe the firmware usage, and support status

Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 rtw88/README | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)
 create mode 100644 rtw88/README

diff --git a/rtw88/README b/rtw88/README
new file mode 100644
index 0000000..7ee24b3
--- /dev/null
+++ b/rtw88/README
@@ -0,0 +1,28 @@
+
+ rtw88 firmware
+================
+
+This repository contains firmware images supported by Realtek's wireless
+driver rtw88. And some of the devices run with more than one firmware
+file. Basically, a "normal" firmware is necessary to be downloaded to
+the device.
+And another is called "wowlan" firmware, it should be loaded when a
+device is going to suspend. Which means driver will "re-download/swap"
+the firmware image. The wowlan firmware contains wake up functions that
+can recognize specific events and send a wake up signal to device if
+needed, and the system will resume to running state. During resume,
+driver will then swap the normal firmware back, return to running state.
+
+If any distros or platforms do not require wowlan feature, they can
+_only_ pick the normal firmware. And everything still works fine,
+except that the device cannot be waken from the wireless NICs.
+
+Currently supported devices with corresponding firmwares:
+
+RTL8822BE
+    rtw8822b_fw.bin
+
+RTL8822CE
+    rtw8822c_fw.bin
+    rtw8822c_wow_fw.bin
+
-- 
2.7.4

