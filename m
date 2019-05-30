Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A6C2EA5F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2019 03:51:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727314AbfE3BvB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 29 May 2019 21:51:01 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:48602 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3BvB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 29 May 2019 21:51:01 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 5ABB86077A; Thu, 30 May 2019 01:51:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559181060;
        bh=Xnovgrnh7liuRwbqkCJd299d7uMVnRRBq/RGfcDJ8ks=;
        h=From:To:Cc:Subject:Date:From;
        b=U4voDM/t3iEoYEOz67zJfjwgs3g/J+Q1rvq9CsOQ6z/o44luQr1Ml7D28vfDlGHRf
         cMXox77S0DMXAqZUeaVynJN+0Mn3uWh7+L3UMI8/VPwDDunPemjJeg2J4TmT1Zo5Vd
         CHf7lv8EGljkMJtwV0l/mkQ8qfrCy9CJY2+123Y8=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from smtp.codeaurora.org (unknown [180.166.53.21])
        (using TLSv1 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1A5216029B;
        Thu, 30 May 2019 01:50:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1559181060;
        bh=Xnovgrnh7liuRwbqkCJd299d7uMVnRRBq/RGfcDJ8ks=;
        h=From:To:Cc:Subject:Date:From;
        b=U4voDM/t3iEoYEOz67zJfjwgs3g/J+Q1rvq9CsOQ6z/o44luQr1Ml7D28vfDlGHRf
         cMXox77S0DMXAqZUeaVynJN+0Mn3uWh7+L3UMI8/VPwDDunPemjJeg2J4TmT1Zo5Vd
         CHf7lv8EGljkMJtwV0l/mkQ8qfrCy9CJY2+123Y8=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1A5216029B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=miaoqing@codeaurora.org
Received: by smtp.codeaurora.org (sSMTP sendmail emulation); Thu, 30 May 2019 09:50:47 +0800
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] ath10k: fix PCIE device wake up failed
Date:   Thu, 30 May 2019 09:49:20 +0800
Message-Id: <1559180960-13565-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Observed PCIE device wake up failed after ~120 iterations of
soft-reboot test. The error message is
"ath10k_pci 0000:01:00.0: failed to wake up device : -110"

The call trace as below:
ath10k_pci_probe -> ath10k_pci_force_wake -> ath10k_pci_wake_wait ->
ath10k_pci_is_awake

Once trigger the device to wake up, we will continuously check the RTC
state until it returns RTC_STATE_V_ON or timeout.

But for QCA99x0 chips, we use wrong value for RTC_STATE_V_ON.
Occasionally, we get 0x7 on the fist read, we thought as a failure
case, but actually is the right value, also verified with the spec.
So fix the issue by changing RTC_STATE_V_ON from 0x5 to 0x7, passed
~2000 iterations.

Tested HW: QCA9984

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/hw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/hw.c b/drivers/net/wireless/ath/ath10k/hw.c
index ad082b7..b242085 100644
--- a/drivers/net/wireless/ath/ath10k/hw.c
+++ b/drivers/net/wireless/ath/ath10k/hw.c
@@ -158,7 +158,7 @@
 };
 
 const struct ath10k_hw_values qca99x0_values = {
-	.rtc_state_val_on		= 5,
+	.rtc_state_val_on		= 7,
 	.ce_count			= 12,
 	.msi_assign_ce_max		= 12,
 	.num_target_ce_config_wlan	= 10,
-- 
1.9.1

