Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C9BD41DE958
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730418AbgEVOqH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:46:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:48604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730357AbgEVOqF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:46:05 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E68F12053B;
        Fri, 22 May 2020 14:46:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158765;
        bh=9vrfLJZTL8WRQ1zupaCKPmQrLZnRZD1ZGr/IqCu0zrg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=jK2flk8kqtjnzRkud16YaMP5KNZWB2D/e0eVyzKP27T567icbolifPhI0j0G+ve+Y
         H6h8Xme+lxQmSFqw8laWH/FDENfb0FnxwRdGJDoqspL0SBjr8THw6h8twJq4I/UXhy
         XiLnCTKBOSl/T1MRltWqSS2+25W73HEc0UC85IPc=
Received: by pali.im (Postfix)
        id 2D0B651E; Fri, 22 May 2020 16:46:03 +0200 (CEST)
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
Subject: [PATCH 09/11] mmc: sdio: Move SDIO IDs from b43-sdio driver to common include file
Date:   Fri, 22 May 2020 16:44:10 +0200
Message-Id: <20200522144412.19712-10-pali@kernel.org>
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

Define appropriate macro names for consistency with other macros.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/broadcom/b43/sdio.c | 4 ++--
 include/linux/mmc/sdio_ids.h             | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/broadcom/b43/sdio.c b/drivers/net/wireless/broadcom/b43/sdio.c
index 881a7938c494..02b0cfd535ab 100644
--- a/drivers/net/wireless/broadcom/b43/sdio.c
+++ b/drivers/net/wireless/broadcom/b43/sdio.c
@@ -180,8 +180,8 @@ static void b43_sdio_remove(struct sdio_func *func)
 }
 
 static const struct sdio_device_id b43_sdio_ids[] = {
-	{ SDIO_DEVICE(0x02d0, 0x044b) }, /* Nintendo Wii WLAN daughter card */
-	{ SDIO_DEVICE(0x0092, 0x0004) }, /* C-guys, Inc. EW-CG1102GC */
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_BROADCOM, SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII) },
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_CGUYS, SDIO_DEVICE_ID_CGUYS_EW_CG1102GC) },
 	{ },
 };
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 2894f7739acc..8e7a0683b927 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -25,6 +25,9 @@
  * Vendors and devices.  Sort key: vendor first, device next.
  */
 
+#define SDIO_VENDOR_ID_CGUYS			0x0092
+#define SDIO_DEVICE_ID_CGUYS_EW_CG1102GC	0x0004
+
 #define SDIO_VENDOR_ID_ATHEROS			0x0271
 #define SDIO_DEVICE_ID_ATHEROS_AR6003_00	0x0300
 #define SDIO_DEVICE_ID_ATHEROS_AR6003_01	0x0301
@@ -37,6 +40,7 @@
 #define SDIO_DEVICE_ID_ATHEROS_QCA9377		0x0701
 
 #define SDIO_VENDOR_ID_BROADCOM			0x02d0
+#define SDIO_DEVICE_ID_BROADCOM_NINTENDO_WII	0x044b
 #define SDIO_DEVICE_ID_BROADCOM_43143		0xa887
 #define SDIO_DEVICE_ID_BROADCOM_43241		0x4324
 #define SDIO_DEVICE_ID_BROADCOM_4329		0x4329
-- 
2.20.1

