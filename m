Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD67040C9B2
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Sep 2021 18:04:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231978AbhIOQGG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Sep 2021 12:06:06 -0400
Received: from phobos.denx.de ([85.214.62.61]:46440 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229547AbhIOQGF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Sep 2021 12:06:05 -0400
Received: from localhost.localdomain (unknown [IPv6:2804:14c:485:504a:ce76:c689:f286:5053])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: festevam@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E89D682DB1;
        Wed, 15 Sep 2021 18:04:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1631721885;
        bh=5QcfJriUR7tBHXbkjChxykSToEa3TVi/rMd15wjjipU=;
        h=From:To:Cc:Subject:Date:From;
        b=kHG1Ga9KwbqbQ4suu3bYuA/3MdMhC995bMWbJ0KTBa9T8rBxbRCWLYDXC5DdNAn4X
         AIsvPuvp3Or3tPR4d+0CimoT4Wo8kY5c/bo4XlTGbsv1FuNZk6BUemGIxZfv/4kXB3
         si+OR6UDnSSUG3VBsHVBKt6pA6D5mjRmZ8RDsIQAaqCLWhIxadIr3Y2iNGuK0HRj2V
         /aBqOuzkEwCl+0TkPGGtqv6yibl/dlIs/2GJlHDe09MpC0BvwJOMfayYU+Ei8yEC/n
         bsGhIAg86VvyoSK2IkshXSoJTEWuHityUpOzP4ih5pbowMlp3JpXSWIxaJZqhucuFo
         XXIsYAq7Itv9g==
From:   Fabio Estevam <festevam@denx.de>
To:     kvalo@codeaurora.org
Cc:     wgong@codeaurora.org, ath10k@lists.infradead.org,
        linux-wireless@vger.kernel.org, erik.stromdahl@gmail.com,
        alagusankar@silex-india.com, Fabio Estevam <festevam@denx.de>
Subject: [PATCH] ath10k: Clean the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE flag
Date:   Wed, 15 Sep 2021 13:04:22 -0300
Message-Id: <20210915160422.2839595-1-festevam@denx.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On an imx6dl-pico-pi board with a QCA9377 SDIO chip, the following
errors are observed when the board works in STA mode:

Simply running "ssh user@192.168.0.1" causes:

[   55.824159] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.832169] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.838529] ath10k_sdio mmc1:0001:1: failed to push frame: -12
[   55.905863] ath10k_sdio mmc1:0001:1: failed to transmit packet, dropping: -12
[   55.913650] ath10k_sdio mmc1:0001:1: failed to submit frame: -12
[   55.919887] ath10k_sdio mmc1:0001:1: failed to push frame: -12

and it is not possible to connect via ssh to the other machine.

One user inspected the size of frames on Wireshark and reported
the followig:

"I was able to narrow the issue down to the mtu. If I set the mtu for
the wlan0 device to 1486 instead of 1500, the issue does not happen.

The size of frames that I see on Wireshark is exactly 1500 after
setting it to 1486."

Clearing the HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE avoids the problem and
the ssh command works successfully after that.

Tested with QCA9377 SDIO with firmware WLAN.TF.1.1.1-00061-QCATFSWPZ-1.

Fixes: 2f918ea98606 ("ath10k: enable alt data of TX path for sdio")
Signed-off-by: Fabio Estevam <festevam@denx.de>
---
 drivers/net/wireless/ath/ath10k/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 2f9be182fbfb..728a18b3b462 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -730,11 +730,7 @@ static int ath10k_init_sdio(struct ath10k *ar, enum ath10k_firmware_mode mode)
 		return ret;
 
 	param |= HI_ACS_FLAGS_SDIO_REDUCE_TX_COMPL_SET;
-
-	if (mode == ATH10K_FIRMWARE_MODE_NORMAL)
-		param |= HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
-	else
-		param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
+	param &= ~HI_ACS_FLAGS_ALT_DATA_CREDIT_SIZE;
 
 	if (mode == ATH10K_FIRMWARE_MODE_UTF)
 		param &= ~HI_ACS_FLAGS_SDIO_SWAP_MAILBOX_SET;
-- 
2.25.1

