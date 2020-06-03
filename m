Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA2721ECB67
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 10:23:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgFCIXB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 04:23:01 -0400
Received: from mail.kernel.org ([198.145.29.99]:48574 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgFCIW6 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 04:22:58 -0400
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 04CEE207DA;
        Wed,  3 Jun 2020 08:22:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1591172578;
        bh=6rg6WOIWtJRVYT18qYbnB9TNZyjdNb6mtZSZLIOV0+4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fgcDZ7wjJe3YVnUlQFd0bqrgd9sLgh0pxR+/YHUopUIuCr50prR2s2MASqTqOQ+ob
         VTlRPNWw54E/NO0bhQkkPISvc7BByyd2KS24DfdM4xkLcOfDCUPPI4cWMQKYptwm81
         kMcVbUhJcq56rZso2UgXgM2aLLaNnu+ksMNrS//w=
Received: by pali.im (Postfix)
        id 51F8D6F0; Wed,  3 Jun 2020 10:22:56 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Ganapathi Bhat <ganapathi.bhat@nxp.com>,
        Amitkumar Karwar <amitkarwar@gmail.com>,
        Xinming Hu <huxinming820@gmail.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org,
        Hemantkumar Suthar <shemant@marvell.com>,
        Rakesh Parmar <rakeshp@marvell.com>,
        Zhaoyang Liu <liuzy@marvell.com>, Cathy Luo <cluo@marvell.com>
Subject: [PATCH 3/4] btmrvl: Fix firmware filename for sd8977 chipset
Date:   Wed,  3 Jun 2020 10:22:28 +0200
Message-Id: <20200603082229.15043-4-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200603082229.15043-1-pali@kernel.org>
References: <20200603082229.15043-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Firmware for sd8977 chipset is distributed by Marvell package and also as
part of the linux-firmware repository in filename sdsd8977_combo_v2.bin.

This patch fixes mwifiex driver to load correct firmware file for sd8977.

Fixes: 8c57983bf7a79 ("Bluetooth: btmrvl: add support for sd8977 chipset")
Signed-off-by: Pali Rohár <pali@kernel.org>
---
 drivers/bluetooth/btmrvl_sdio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_sdio.c b/drivers/bluetooth/btmrvl_sdio.c
index 0f3a020703ab..7aa2c94720bc 100644
--- a/drivers/bluetooth/btmrvl_sdio.c
+++ b/drivers/bluetooth/btmrvl_sdio.c
@@ -328,7 +328,7 @@ static const struct btmrvl_sdio_device btmrvl_sdio_sd8897 = {
 
 static const struct btmrvl_sdio_device btmrvl_sdio_sd8977 = {
 	.helper         = NULL,
-	.firmware       = "mrvl/sd8977_uapsta.bin",
+	.firmware       = "mrvl/sdsd8977_combo_v2.bin",
 	.reg            = &btmrvl_reg_8977,
 	.support_pscan_win_report = true,
 	.sd_blksz_fw_dl = 256,
@@ -1831,6 +1831,6 @@ MODULE_FIRMWARE("mrvl/sd8787_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8797_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8887_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8897_uapsta.bin");
-MODULE_FIRMWARE("mrvl/sd8977_uapsta.bin");
+MODULE_FIRMWARE("mrvl/sdsd8977_combo_v2.bin");
 MODULE_FIRMWARE("mrvl/sd8987_uapsta.bin");
 MODULE_FIRMWARE("mrvl/sd8997_uapsta.bin");
-- 
2.20.1

