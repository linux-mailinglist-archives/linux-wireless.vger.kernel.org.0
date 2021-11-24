Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0304A45C185
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Nov 2021 14:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345498AbhKXNTV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Nov 2021 08:19:21 -0500
Received: from phobos.denx.de ([85.214.62.61]:54428 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346005AbhKXNOf (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Nov 2021 08:14:35 -0500
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:e573:ff9b:725:6f6b])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 2E835812A2;
        Wed, 24 Nov 2021 14:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1637759483;
        bh=pvE9ogzQNqGhHkwS6ssMiCv7c3mA6R8LTIYSlH47Uig=;
        h=From:To:Cc:Subject:Date:From;
        b=u992Zdo84qzBKJH5ru0QbcvuGOZ2k0LmMKk3//QH7Qr+r4i9adOQJioiZhEFqOoip
         /cx4bcbq9QOEE6HE0wuvDNHJeZFsLo8WNjhUC3BIW7J9F4v2uXdajIiim4H+c3lGNY
         PEpRgF+6QEJRNq48mrMI9B4KdNyqxwoYX+bgWT1IrOnUbWTMSoBhwr9TZrgnddD8U6
         i6iYV/6y3XCSoxI6MVNrvkxYB3PcaxM2odAaK7z4Qv+lvjzqD5b21r/iwZ2mud5rS4
         DJX4t91PoCESvw9dsVzRtaZAk6MulPLuRbysX5WbXq4Cm/i//q9us7AIWirTgpOJPa
         W9CWDyrThUeLg==
From:   Fabio Estevam <festevam@denx.de>
To:     kvalo@codeaurora.org
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org, Fabio Estevam <festevam@denx.de>
Subject: [PATCH v3] ath10k: Fix the MTU size on QCA9377 SDIO
Date:   Wed, 24 Nov 2021 10:10:47 -0300
Message-Id: <20211124131047.713756-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On an imx6dl-pico-pi board with a QCA9377 SDIO chip, simply trying to
connect via ssh to another machine causes:

[   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
[   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12

, leading to an ssh connection failure.

One user inspected the size of frames on Wireshark and reported
the followig:

"I was able to narrow the issue down to the mtu. If I set the mtu for
the wlan0 device to 1486 instead of 1500, the issue does not happen.

The size of frames that I see on Wireshark is exactly 1500 after
setting it to 1486."

Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
the ssh command works successfully after that.

Introduce a 'credit_size_workaround' field to ath10k_hw_params for
the QCA9377 SDIO, so that the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE
is not set in this case.

Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.

Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
Changes since v2:
- Set the credit_size_workaround field as true for QCA9377 SDIO.

 drivers/net/wireless/ath/ath10k/core.c | 4 +++-
 drivers/net/wireless/ath/ath10k/hw.h   | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 72a366aa9f60..8a325ae97b0e 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -571,6 +571,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.ast_skid_limit = 0x10,
 		.num_wds_entries = 0x20,
 		.uart_pin_workaround = true,
+		.credit_size_workaround = true,
 		.dynamic_sar_support = false,
 	},
 	{
@@ -715,6 +716,7 @@ static void ath10k_send_suspend_complete(struct ath10k *ar)
 
 static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 {
+	bool mtu_workaround = ar->hw_params.credit_size_workaround;
 	int ret;
 	u32 param = 0;
 
@@ -732,7 +734,7 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 
 	param |= HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
 
-	if (mode == ATH10K_FIRMWARE_MODE_NORMAL)
+	if (mode == ATH10K_FIRMWARE_MODE_NORMAL && !mtu_workaround)
 		param |= HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
 	else
 		param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 6b03c7787e36..591ef7416b61 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -618,6 +618,9 @@ struct ath10k_hw_params {
 	 */
 	bool uart_pin_workaround;
 
+	/* Workaround for the credit size calculation */
+	bool credit_size_workaround;
+
 	/* tx stats support over pktlog */
 	bool tx_stats_over_pktlog;
 
-- 
2.25.1

