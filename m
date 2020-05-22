Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF81DE942
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:45:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730223AbgEVOpr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:48144 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgEVOpq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:46 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9D1A22053B;
        Fri, 22 May 2020 14:45:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158745;
        bh=WFuyUyhfF0r2NIDkbY75yLpDco7NYc0wVtuTNDsXGf4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o68/I4gQ9Zskbrv0XZqEAgSE4dXJ/pzXRdBWhxP0lKxz0F9wWU1del/rJ1fwqApo0
         o8N5NzfTnU0o/kJa1Gp+9rZYobdlZJDosuejulBUbMGbGpV6Bh4kg196AQR/Qor0zK
         6SX/7I03OBlaLyopYy/byBmYF+iAFb0nV89ZBT+Q=
Received: by pali.im (Postfix)
        id D74BD51E; Fri, 22 May 2020 16:45:43 +0200 (CEST)
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
Subject: [PATCH 02/11] mmc: sdio: Change macro names for Marvell 8688 modules
Date:   Fri, 22 May 2020 16:44:03 +0200
Message-Id: <20200522144412.19712-3-pali@kernel.org>
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

Add underscore as separator in Marvell 8688 macro names for better
readability and consistency.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/net/wireless/marvell/libertas/if_sdio.c | 2 +-
 include/linux/mmc/sdio_ids.h                    | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/marvell/libertas/if_sdio.c b/drivers/net/wireless/marvell/libertas/if_sdio.c
index acf61b93b782..44fbd0acb87a 100644
--- a/drivers/net/wireless/marvell/libertas/if_sdio.c
+++ b/drivers/net/wireless/marvell/libertas/if_sdio.c
@@ -65,7 +65,7 @@ static const struct sdio_device_id if_sdio_ids[] = {
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL,
 			SDIO_DEVICE_ID_MARVELL_LIBERTAS) },
 	{ SDIO_DEVICE(SDIO_VENDOR_ID_MARVELL,
-			SDIO_DEVICE_ID_MARVELL_8688WLAN) },
+			SDIO_DEVICE_ID_MARVELL_8688_WLAN) },
 	{ /* end: all zeroes */				},
 };
 
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 96f43e0dc78f..7e992a0e6cc0 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -56,8 +56,8 @@
 
 #define SDIO_VENDOR_ID_MARVELL			0x02df
 #define SDIO_DEVICE_ID_MARVELL_LIBERTAS		0x9103
-#define SDIO_DEVICE_ID_MARVELL_8688WLAN		0x9104
-#define SDIO_DEVICE_ID_MARVELL_8688BT		0x9105
+#define SDIO_DEVICE_ID_MARVELL_8688_WLAN	0x9104
+#define SDIO_DEVICE_ID_MARVELL_8688_BT		0x9105
 #define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
 #define SDIO_DEVICE_ID_MARVELL_8887_F0		0x9134
 
-- 
2.20.1

