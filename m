Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB561DE93E
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbgEVOpn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:48042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730036AbgEVOpn (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:43 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FCF9204EF;
        Fri, 22 May 2020 14:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158742;
        bh=hRb2VDYaeeagfmMwuXWOO5MTiJ36qdN4nrC0CGCu3qE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrqjOWo/J/e9nqoi7yNeP3vN8U5uj740diXbXu7bs4TXKUlq/Wfi+mfz8xQW2v7va
         UE5FWy17VeukuVoiZIHjzYXyVZvElDUFhPCwCXBb0Lnaf1D+85JNr0lkHuTgn2olws
         Zz2NEZtpFTLaUVIZ0OyqdWrQPDa5G9Esdeu3kbD0=
Received: by pali.im (Postfix)
        id CB79251E; Fri, 22 May 2020 16:45:40 +0200 (CEST)
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
Subject: [PATCH 01/11] mmc: sdio: Fix macro name for Marvell device with ID 0x9134
Date:   Fri, 22 May 2020 16:44:02 +0200
Message-Id: <20200522144412.19712-2-pali@kernel.org>
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

Marvell SDIO device ID 0x9134 is used in SDIO Common CIS (Card Information
Structure) and not in SDIO wlan function (with ID 1). SDIO Common CIS is
accessed by function ID 0.

So change this misleading macro name to SDIO_DEVICE_ID_MARVELL_8887_F0 as
it does not refer to wlan function. It refers to function 0.

Wlan module on this SDIO card is available at function ID 1 and is
identified by different SDIO device ID 0x9135. Kernel quirks for SDIO
devices are matched against device ID from SDIO Common CIS. Therefore
device ID used in quirk is correct, just has misleading name.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/mmc/core/quirks.h    | 2 +-
 include/linux/mmc/sdio_ids.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/quirks.h b/drivers/mmc/core/quirks.h
index 3dba15bccce2..472fa2fdcf13 100644
--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -139,7 +139,7 @@ static const struct mmc_fixup sdio_fixup_methods[] = {
 	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8797_F0,
 		   add_quirk, MMC_QUIRK_BROKEN_IRQ_POLLING),
 
-	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887WLAN,
+	SDIO_FIXUP(SDIO_VENDOR_ID_MARVELL, SDIO_DEVICE_ID_MARVELL_8887_F0,
 		   add_limit_rate_quirk, 150000000),
 
 	END_FIXUP
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 2e9a6e4634eb..96f43e0dc78f 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -59,7 +59,7 @@
 #define SDIO_DEVICE_ID_MARVELL_8688WLAN		0x9104
 #define SDIO_DEVICE_ID_MARVELL_8688BT		0x9105
 #define SDIO_DEVICE_ID_MARVELL_8797_F0		0x9128
-#define SDIO_DEVICE_ID_MARVELL_8887WLAN	0x9134
+#define SDIO_DEVICE_ID_MARVELL_8887_F0		0x9134
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
 
-- 
2.20.1

