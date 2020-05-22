Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E87711DE965
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730398AbgEVOqe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:46:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:48314 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730089AbgEVOpx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:53 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 05EF420727;
        Fri, 22 May 2020 14:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158752;
        bh=JuVtsoJtqiGRmlRjn0aQhleeQaWm700qqmuKFp/zUsM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KA9a1lxgJE9kGo8WzKl//DiDJ0mIhN5vTC2JDL6dMQ5+Zm9/Q5w7ftISDJaERGnsw
         WU7zCHsKRoAdfuF/WFi0DnRc7O+PXFrI8NmSYE5774cBV0eCl8oz+xEw8kDjsPAbmz
         iHLXemt9FudqdZVrtqvwWCywY1qzI8i/HFMoFqWo=
Received: by pali.im (Postfix)
        id 3FEBD51E; Fri, 22 May 2020 16:45:50 +0200 (CEST)
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
Subject: [PATCH 04/11] mmc: sdio: Move SDIO IDs from btmrvl driver to common include file
Date:   Fri, 22 May 2020 16:44:05 +0200
Message-Id: <20200522144412.19712-5-pali@kernel.org>
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

Define appropriate macro names for consistency with other Marvell macros.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 18 +++++++++---------
 include/linux/mmc/sdio_ids.h    |  8 ++++++++
 2 files changed, 17 insertions(+), 9 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f3a020703ab..a296f8526433 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -355,31 +355,31 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8997 = {
 
 static const struct sdio_device_id btmrvl_sdio_ids[] = {
 	/* Marvell SD8688 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9105),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8688_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8688 },
 	/* Marvell SD8787 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911A),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
 	/* Marvell SD8787 Bluetooth AMP device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x911B),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8787_BT_AMP),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8787 },
 	/* Marvell SD8797 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912A),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8797 },
 	/* Marvell SD8887 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9136),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8887 },
 	/* Marvell SD8897 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x912E),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8897_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8897 },
 	/* Marvell SD8977 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9146),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8977_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8977 },
 	/* Marvell SD8987 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x914A),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8987_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8987 },
 	/* Marvell SD8997 Bluetooth device */
-	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, 0x9142),
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8997_BT),
 			.driver_data = (unsigned long)&btmrvl_sdio_sd8997 },
 
 	{ }	/* Terminating entry */
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 90361ea7f5ed..1237e1048d06 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -60,16 +60,24 @@
 #define SDIO_DEVICE_ID_MARVELL_8688_BT		0x9105
 #define SDIO_DEVICE_ID_MARVELL_8786_WLAN	0x9116
 #define SDIO_DEVICE_ID_MARVELL_8787_WLAN	0x9119
+#define SDIO_DEVICE_ID_MARVELL_8787_BT		0x911a
+#define SDIO_DEVICE_ID_MARVELL_8787_BT_AMP	0x911b
 #define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
 #define SDIO_DEVICE_ID_MARVELL_8797_WLAN	0x9129
+#define SDIO_DEVICE_ID_MARVELL_8797_BT		0x912a
 #define SDIO_DEVICE_ID_MARVELL_8897_WLAN	0x912d
+#define SDIO_DEVICE_ID_MARVELL_8897_BT		0x912e
 #define SDIO_DEVICE_ID_MARVELL_8887_F0		0x9134
 #define SDIO_DEVICE_ID_MARVELL_8887_WLAN	0x9135
+#define SDIO_DEVICE_ID_MARVELL_8887_BT		0x9136
 #define SDIO_DEVICE_ID_MARVELL_8801_WLAN	0x9139
 #define SDIO_DEVICE_ID_MARVELL_8997_F0		0x9140
 #define SDIO_DEVICE_ID_MARVELL_8997_WLAN	0x9141
+#define SDIO_DEVICE_ID_MARVELL_8997_BT		0x9142
 #define SDIO_DEVICE_ID_MARVELL_8977_WLAN	0x9145
+#define SDIO_DEVICE_ID_MARVELL_8977_BT		0x9146
 #define SDIO_DEVICE_ID_MARVELL_8987_WLAN	0x9149
+#define SDIO_DEVICE_ID_MARVELL_8987_BT		0x914a
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 
-- 
2.20.1

