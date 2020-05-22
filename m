Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2C41DE94B
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgEVOp7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:48438 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730311AbgEVOp6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:58 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BFD8320727;
        Fri, 22 May 2020 14:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158757;
        bh=FK2cjUuXlz/7vUmgD5dr+Rxd2hc1F0f/Urz70jIMZa4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=R4RGsK78MnWMvmiJBT2se89kpkaB0qz25O7LIel5g4KT4tf6cSu6RGEEHAp9j9sjs
         sK/teQ9m8Di3KhBmn5dUiez6gg8GmzdC6PGfJXWc+BAeE8sq4+l4tHgwd1oVnYsNrC
         NNgAol6PCO16S/2N/bcbwUCFXI+seymMU3u2HK+Y=
Received: by pali.im (Postfix)
        id 049BC51E; Fri, 22 May 2020 16:45:56 +0200 (CEST)
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
Subject: [PATCH 06/11] mmc: sdio: Move SDIO IDs from smssdio driver to common include file
Date:   Fri, 22 May 2020 16:44:07 +0200
Message-Id: <20200522144412.19712-7-pali@kernel.org>
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

Define appropriate macro names for consistency with other Siano macros.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/media/mmc/siano/smssdio.c | 10 +++++-----
 include/linux/mmc/sdio_ids.h      |  5 +++++
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/media/mmc/siano/smssdio.c b/drivers/media/mmc/siano/smssdio.c
index def5e93849d2..065b572e0272 100644
--- a/drivers/media/mmc/siano/smssdio.c
+++ b/drivers/media/mmc/siano/smssdio.c
@@ -58,15 +58,15 @@ static const struct sdio_device_id smssdio_ids[] = {
 	 .driver_data = SMS1XXX_BOARD_SIANO_VEGA},
 	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_VENICE),
 	 .driver_data = SMS1XXX_BOARD_SIANO_VEGA},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, 0x302),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_MING),
 	.driver_data = SMS1XXX_BOARD_SIANO_MING},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, 0x500),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_PELE),
 	.driver_data = SMS1XXX_BOARD_SIANO_PELE},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, 0x600),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_RIO),
 	.driver_data = SMS1XXX_BOARD_SIANO_RIO},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, 0x700),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_DENVER_2160),
 	.driver_data = SMS1XXX_BOARD_SIANO_DENVER_2160},
-	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, 0x800),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_SIANO, SDIO_DEVICE_ID_SIANO_DENVER_1530),
 	.driver_data = SMS1XXX_BOARD_SIANO_DENVER_1530},
 	{ /* end: all zeroes */ },
 };
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index c9aca57d4dea..9ec675a7ac37 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -88,6 +88,11 @@
 #define SDIO_DEVICE_ID_SIANO_NICE		0x0202
 #define SDIO_DEVICE_ID_SIANO_VEGA_A0		0x0300
 #define SDIO_DEVICE_ID_SIANO_VENICE		0x0301
+#define SDIO_DEVICE_ID_SIANO_MING		0x0302
+#define SDIO_DEVICE_ID_SIANO_PELE		0x0500
+#define SDIO_DEVICE_ID_SIANO_RIO		0x0600
+#define SDIO_DEVICE_ID_SIANO_DENVER_2160	0x0700
+#define SDIO_DEVICE_ID_SIANO_DENVER_1530	0x0800
 #define SDIO_DEVICE_ID_SIANO_NOVA_A0		0x1100
 #define SDIO_DEVICE_ID_SIANO_STELLAR 		0x5347
 
-- 
2.20.1

