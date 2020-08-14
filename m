Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0E7E244C83
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 18:15:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbgHNQPw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 12:15:52 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:64702 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726377AbgHNQPw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 12:15:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597421750; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=tugiyLjHI13IMAzVFcWndMuzqZvtYZQCgCipJ8Z0TT4=; b=YCgdNl/ah0+dO3FH6Ao9Q7dH3F9FTaaog65uM+4bZpUzmEsggGE8Fd9DOplNkB5wYbj33+Kd
 BNlDlN4vJY1KmuXDgi6MxgkTrT1xGMUo4ZVV3D1Pii1H39ET5oeZuMhEKESJ7pVr11a86k6b
 Olanx/xto7XIWcb2UyAPmdBx/WA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5f36b8b603528d4024b2af3a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 16:15:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 98E96C433CA; Fri, 14 Aug 2020 16:15:49 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAC09C433C6;
        Fri, 14 Aug 2020 16:15:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAC09C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: move enable_pll_clk call to ath10k_core_start()
Date:   Fri, 14 Aug 2020 19:15:45 +0300
Message-Id: <1597421745-4329-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There's no reason to have call for enable_pll_clk in ath10k_bmi_start(), move
it to ath10k_core_start() instead. This way it's possible to call
ath10k_bmi_start() from sdio.c during firmware dump creation. And also the
function call is more visible when it's in core.c.

No functional changes, compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/bmi.c  | 8 --------
 drivers/net/wireless/ath/ath10k/core.c | 7 +++++++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/bmi.c b/drivers/net/wireless/ath/ath10k/bmi.c
index 5b6db6e66f65..8b9d537c8900 100644
--- a/drivers/net/wireless/ath/ath10k/bmi.c
+++ b/drivers/net/wireless/ath/ath10k/bmi.c
@@ -12,17 +12,9 @@
 
 void ath10k_bmi_start(struct ath10k *ar)
 {
-	int ret;
-
 	ath10k_dbg(ar, ATH10K_DBG_BMI, "bmi start\n");
 
 	ar->bmi.done_sent = false;
-
-	/* Enable hardware clock to speed up firmware download */
-	if (ar->hw_params.hw_ops->enable_pll_clk) {
-		ret = ar->hw_params.hw_ops->enable_pll_clk(ar);
-		ath10k_dbg(ar, ATH10K_DBG_BMI, "bmi enable pll ret %d\n", ret);
-	}
 }
 
 int ath10k_bmi_done(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 22b6937ac225..029ae1c4d8dc 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2614,6 +2614,13 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		      ar->running_fw->fw_file.fw_features)) {
 		ath10k_bmi_start(ar);
 
+		/* Enable hardware clock to speed up firmware download */
+		if (ar->hw_params.hw_ops->enable_pll_clk) {
+			status = ar->hw_params.hw_ops->enable_pll_clk(ar);
+			ath10k_dbg(ar, ATH10K_DBG_BOOT, "boot enable pll ret %d\n",
+				   status);
+		}
+
 		if (ath10k_init_configure_target(ar)) {
 			status = -EINVAL;
 			goto err;
-- 
2.7.4

