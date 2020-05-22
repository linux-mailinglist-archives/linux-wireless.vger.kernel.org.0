Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0F4A1DE948
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2020 16:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730297AbgEVOp5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 May 2020 10:45:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:48352 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730061AbgEVOp4 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 May 2020 10:45:56 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5D853204EF;
        Fri, 22 May 2020 14:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590158755;
        bh=fmZWyu8S8zz/WmoFW+uWpo4sd9DDFs+iV3itMZTeMR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oMliYZS+G4ZRp+xBCR+xbnXAAMh7UGnCuzkwQYS8ohlmf0AGqMfMh9j9ot4+ycbiY
         BpMyLY2icnsETEivqZGwzx8hDkx4nycPgULF3ulzlTbwmq7TlKa+/mc+4p6bGNAJ34
         ElE/GMzYjlMwFIJE448OlJo78KRdeVt+IEEreRpE=
Received: by pali.im (Postfix)
        id 93A9A51E; Fri, 22 May 2020 16:45:53 +0200 (CEST)
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
Subject: [PATCH 05/11] mmc: sdio: Move SDIO IDs from btmtksdio driver to common include file
Date:   Fri, 22 May 2020 16:44:06 +0200
Message-Id: <20200522144412.19712-6-pali@kernel.org>
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
 drivers/bluetooth/btmtksdio.c | 4 ++--
 include/linux/mmc/sdio_ids.h  | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmtksdio.c b/drivers/bluetooth/btmtksdio.c
index 519788c442ca..bff095be2f97 100644
--- a/drivers/bluetooth/btmtksdio.c
+++ b/drivers/bluetooth/btmtksdio.c
@@ -51,9 +51,9 @@ static const struct btmtksdio_data mt7668_data = {
 };
 
 static const struct sdio_device_id btmtksdio_table[] = {
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7663),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7663),
 	 .driver_data = (kernel_ulong_t)&mt7663_data },
-	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, 0x7668),
+	{SDIO_DEVICE(SDIO_VENDOR_ID_MEDIATEK, SDIO_DEVICE_ID_MEDIATEK_MT7668),
 	 .driver_data = (kernel_ulong_t)&mt7668_data },
 	{ }	/* Terminating entry */
 };
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 1237e1048d06..c9aca57d4dea 100644
--- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -80,6 +80,8 @@
 #define SDIO_DEVICE_ID_MARVELL_8987_BT		0x914a
 
 #define SDIO_VENDOR_ID_MEDIATEK			0x037a
+#define SDIO_DEVICE_ID_MEDIATEK_MT7663		0x7663
+#define SDIO_DEVICE_ID_MEDIATEK_MT7668		0x7668
 
 #define SDIO_VENDOR_ID_SIANO			0x039a
 #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
-- 
2.20.1

