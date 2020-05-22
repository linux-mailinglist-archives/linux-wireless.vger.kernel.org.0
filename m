Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF7E01DE95A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730481AbgEVOqR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:46:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:48762 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgEVOqK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:46:10 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 10128204EF;
        Fri, 22 May 2020 14:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158770;
        bh=xL0iNQA61zcd+Iy+CRhN4KujKqVvoopu6rrafJslSYk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=07CBE6yL8mB6BaiAGeIP8E7u9ppDj+LFMIN/lwK1oOqis9HVXDBWiw0o7lfNXmqHr
         Mx2GhHNv2HSkmgoMWqwlC1uQjSC3ZDKZYHc3LoXCGV1sI14emQwsPiwa1cwjAM/rGf
         j5NOZPFFqtZBYD1I2MUSa3Of1aRp/BZXdQ9CdSzE=
Received: by pali.im (Postfix)
        id 3863B51E; Fri, 22 May 2020 16:46:08 +0200 (CEST)
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
Subject: [PATCH 11/11] mmc: sdio: Sort all SDIO IDs in common include file
Date:   Fri, 22 May 2020 16:44:12 +0200
Message-Id: <20200522144412.19712-12-pali@kernel.org>
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

Fix ordering of SDIO IDs to conform to the comment above, which says vendor
first, device next.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 include/linux/mmc/sdio_ids.h | 43 ++++++++++++++++++------------------
 1 file changed, 22 insertions(+), 21 deletions(-)

diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index b19200aea56a..15ed8ce9d394 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -25,9 +25,23 @@
  * Vendors and devices.  Sort key: vendor first, device next.
  */
 
+#define SDIO_VENDOR_ID_STE			0x0020
+#define SDIO_DEVICE_ID_STE_CW1200		0x2280
+
+#define SDIO_VENDOR_ID_INTEL			0x0089
+#define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX	0x1402
+#define SDIO_DEVICE_ID_INTEL_IWMC3200WIFI	0x1403
+#define SDIO_DEVICE_ID_INTEL_IWMC3200TOP	0x1404
+#define SDIO_DEVICE_ID_INTEL_IWMC3200GPS	0x1405
+#define SDIO_DEVICE_ID_INTEL_IWMC3200BT		0x1406
+#define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX_2G5	0x1407
+
 #define SDIO_VENDOR_ID_CGUYS			0x0092
 #define SDIO_DEVICE_ID_CGUYS_EW_CG1102GC	0x0004
 
+#define SDIO_VENDOR_ID_TI			0x0097
+#define SDIO_DEVICE_ID_TI_WL1271		0x4076
+
 #define SDIO_VENDOR_ID_ATHEROS			0x0271
 #define SDIO_DEVICE_ID_ATHEROS_AR6003_00	0x0300
 #define SDIO_DEVICE_ID_ATHEROS_AR6003_01	0x0301
@@ -41,34 +55,26 @@
 
 #define SDIO_VENDOR_ID_BROADCOM			0x02d0
 #define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII	0x044b
-#define SDIO_DEVICE_ID_BROADCOM_43143		0xa887
 #define SDIO_DEVICE_ID_BROADCOM_43241		0x4324
 #define SDIO_DEVICE_ID_BROADCOM_4329		0x4329
 #define SDIO_DEVICE_ID_BROADCOM_4330		0x4330
 #define SDIO_DEVICE_ID_BROADCOM_4334		0x4334
-#define SDIO_DEVICE_ID_BROADCOM_43340		0xa94c
-#define SDIO_DEVICE_ID_BROADCOM_43341		0xa94d
 #define SDIO_DEVICE_ID_BROADCOM_4335_4339	0x4335
 #define SDIO_DEVICE_ID_BROADCOM_4339		0x4339
-#define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
-#define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
-#define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
 #define SDIO_DEVICE_ID_BROADCOM_4345		0x4345
-#define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 #define SDIO_DEVICE_ID_BROADCOM_4354		0x4354
+#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359	0x4355
 #define SDIO_DEVICE_ID_BROADCOM_4356		0x4356
 #define SDIO_DEVICE_ID_BROADCOM_4359		0x4359
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_4373	0x4373
 #define SDIO_DEVICE_ID_BROADCOM_CYPRESS_43012	0xa804
-#define SDIO_DEVICE_ID_BROADCOM_CYPRESS_89359	0x4355
-
-#define SDIO_VENDOR_ID_INTEL			0x0089
-#define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX	0x1402
-#define SDIO_DEVICE_ID_INTEL_IWMC3200WIFI	0x1403
-#define SDIO_DEVICE_ID_INTEL_IWMC3200TOP	0x1404
-#define SDIO_DEVICE_ID_INTEL_IWMC3200GPS	0x1405
-#define SDIO_DEVICE_ID_INTEL_IWMC3200BT		0x1406
-#define SDIO_DEVICE_ID_INTEL_IWMC3200WIMAX_2G5	0x1407
+#define SDIO_DEVICE_ID_BROADCOM_43143		0xa887
+#define SDIO_DEVICE_ID_BROADCOM_43340		0xa94c
+#define SDIO_DEVICE_ID_BROADCOM_43341		0xa94d
+#define SDIO_DEVICE_ID_BROADCOM_43362		0xa962
+#define SDIO_DEVICE_ID_BROADCOM_43364		0xa9a4
+#define SDIO_DEVICE_ID_BROADCOM_43430		0xa9a6
+#define SDIO_DEVICE_ID_BROADCOM_43455		0xa9bf
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
@@ -112,12 +118,7 @@
 #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
 #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347
 
-#define SDIO_VENDOR_ID_TI			0x0097
-#define SDIO_DEVICE_ID_TI_WL1271		0x4076
 #define SDIO_VENDOR_ID_TI_WL1251		0x104c
 #define SDIO_DEVICE_ID_TI_WL1251		0x9066
 
-#define SDIO_VENDOR_ID_STE			0x0020
-#define SDIO_DEVICE_ID_STE_CW1200		0x2280
-
 #endif /* LINUX_MMC_SDIO_IDS_H */
-- 
2.20.1

