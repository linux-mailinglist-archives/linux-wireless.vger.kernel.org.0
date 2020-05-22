Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 425241DE947
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730275AbgEVOpy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:48228 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgEVOpt (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:49 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7D03B2054F;
        Fri, 22 May 2020 14:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158748;
        bh=oq5ZCJlTZiGHXZ4dJp1898bt1twZklmXaQYyrfl6DbI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vmqgPZnAGbdGZkJnNBSQtvm5P4tXIor1R1Pr7WCRLRgBOTPbUAUjAK2he5uiCxego
         drlx24+IBOOCbkZ0FQZXlUX7+1xhSyWF7QVA/EDbp8DY1BW6O8OQqdkK71TbvkC8Ko
         kzc3sqKQHGdA/xvwycnU4auvcNvKyXeXMq7du2Io=
Received: by pali.im (Postfix)
        id A1CBE51E; Fri, 22 May 2020 16:45:46 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ulf Hansson <ulf.hansson@linaro.org>, linux-mmc@vger.kernel.org
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Kalle Valo <kvalo@codeaurora.org>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Xinming Hu <huxinming820@gmail.com>,
        linux-kernel@vger.kernel.org, ath10k@lists.infradead.org,
        b43-dev@lists.infradead.org, brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com, libertas-dev@lists.infradead.org,
        linux-wireless@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Subject: [PATCH 03/11] mmc: sdio: Move SDIO IDs from mwifiex driver to common include file
Date:   Fri, 22 May 2020 16:44:04 +0200
Message-Id: <20200522144412.19712-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200522144412.19712-1-pali@kernel.org>
References: <20200522144412.19712-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add _WLAN suffix to macro names for consistency with other Marvell macros.
These IDs represents wlan function of combo bt/wlan cards. Other functions
of these cards have different IDs.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/marvell/mwifiex/sdio.c | 38 +++++----------------
 include/linux/mmc/sdio_ids.h                | 10 ++++++
 2 files changed, 19 insertions(+), 29 deletions(-)

diff --git a/drivers/net/wireless/marvell/mwifiex/sdio.c b/drivers/net/wireless/marvell/mwifiex/sdio.c
index 6a2dcb01caf4..a042965962a2 100644
--- a/drivers/net/wireless/marvell/mwifiex/sdio.c
+++ b/drivers/net/wireless/marvell/mwifiex/sdio.c
@@ -480,45 +480,25 @@ static void mwifiex_sdio_coredump(struct device *dev)
 		schedule_work(&card->work);
 }
 
-/* Device ID for SD8786 */
-#define SDIO_DEVICE_ID_MARVELL_8786   (0x9116)
-/* Device ID for SD8787 */
-#define SDIO_DEVICE_ID_MARVELL_8787   (0x9119)
-/* Device ID for SD8797 */
-#define SDIO_DEVICE_ID_MARVELL_8797   (0x9129)
-/* Device ID for SD8897 */
-#define SDIO_DEVICE_ID_MARVELL_8897   (0x912d)
-/* Device ID for SD8887 */
-#define SDIO_DEVICE_ID_MARVELL_8887   (0x9135)
-/* Device ID for SD8801 */
-#define SDIO_DEVICE_ID_MARVELL_8801   (0x9139)
-/* Device ID for SD8977 */
-#define SDIO_DEVICE_ID_MARVELL_8977   (0x9145)
-/* Device ID for SD8987 */
-#define SDIO_DEVICE_ID_MARVELL_8987   (0x9149)
-/* Device ID for SD8997 */
-#define SDIO_DEVICE_ID_MARVELL_8997   (0x9141)
-
-
 /* WLAN IDs */
 static const struct sdio_device_id mwifiex_ids[] = {
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8786),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8786_WLAN),
 		.driver_data = (unsigned long) &mwifiex_sdio_sd8786},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_WLAN),
 		.driver_data = (unsigned long) &mwifiex_sdio_sd8787},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_WLAN),
 		.driver_data = (unsigned long) &mwifiex_sdio_sd8797},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8897),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8897_WLAN),
 		.driver_data = (unsigned long) &mwifiex_sdio_sd8897},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8887},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8801),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8801_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8801},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8977},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8987},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_WLAN),
 		.driver_data = (unsigned long)&mwifiex_sdio_sd8997},
 	{},
 };
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7e992a0e6cc0..90361ea7f5ed 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -58,8 +58,18 @@
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
 #define SDIO_DEVICE_ID_MARVELL_8688_WLAN	0x9104
 #define SDIO_DEVICE_ID_MARVELL_8688_BT		0x9105
+#define SDIO_DEVICE_ID_MARVELL_8786_WLAN	0x9116
+#define SDIO_DEVICE_ID_MARVELL_8787_WLAN	0x9119
 #define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
+#define SDIO_DEVICE_ID_MARVELL_8797_WLAN	0x9129
+#define SDIO_DEVICE_ID_MARVELL_8897_WLAN	0x912d
 #define SDIO_DEVICE_ID_MARVELL_8887_F0		0x9134
+#define SDIO_DEVICE_ID_MARVELL_8887_WLAN	0x9135
+#define SDIO_DEVICE_ID_MARVELL_8801_WLAN	0x9139
+#define SDIO_DEVICE_ID_MARVELL_8997_F0		0x9140
+#define SDIO_DEVICE_ID_MARVELL_8997_WLAN	0x9141
+#define SDIO_DEVICE_ID_MARVELL_8977_WLAN	0x9145
+#define SDIO_DEVICE_ID_MARVELL_8987_WLAN	0x9149
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 
-- 
2.20.1

