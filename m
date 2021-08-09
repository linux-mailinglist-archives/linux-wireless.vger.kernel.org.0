Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDA913E3EA4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Aug 2021 06:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhHIEFt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Aug 2021 00:05:49 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:45868 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbhHIEFs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Aug 2021 00:05:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1628481928; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=Vbpd/GuClOmGWBsNoX7W4sL/Zu3cwNTKNWcrglilN1g=; b=qo6PdhoRrw+DQymSzCgEl0tk4D4foIeLokiAjmpwLNqXhxyQokU+ntD+JnZW+rW7bLb+dnuS
 uADAf+E8NNfUydOtM2vNYxxrDWStZROB08IkjcGCbJ5s9hncbL9ixN5MGlNID3nGCgsxe4/z
 UZtMbRsPcyIXu2mz6aYJhXzbI6E=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 6110a982b14e7e2ecb658921 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 09 Aug 2021 04:05:22
 GMT
Sender: miaoqing=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8077CC433D3; Mon,  9 Aug 2021 04:05:22 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from miaoqing-HP-Z220-SFF-Workstation.ap.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: miaoqing)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4B476C433D3;
        Mon,  9 Aug 2021 04:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4B476C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=miaoqing@codeaurora.org
From:   Miaoqing Pan <miaoqing@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath9k-devel@qca.qualcomm.com, kvalo@codeaurora.org,
        dan.carpenter@oracle.com, linux-gpio@vger.kernel.org,
        Miaoqing Pan <miaoqing@codeaurora.org>
Subject: [PATCH] ath9k: fix sleeping in atomic context
Date:   Mon,  9 Aug 2021 12:05:16 +0800
Message-Id: <1628481916-15030-1-git-send-email-miaoqing@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The problem is that gpio_free() can sleep and the cfg_soc() can be
called with spinlocks held. One problematic call tree is:

--> ath_reset_internal() takes &sc->sc_pcu_lock spin lock
   --> ath9k_hw_reset()
      --> ath9k_hw_gpio_request_in()
         --> ath9k_hw_gpio_request()
            --> ath9k_hw_gpio_cfg_soc()

Remove gpio_free(), use error message instead, so we should make sure
there is no GPIO conflict.

Also remove ath9k_hw_gpio_free() from ath9k_hw_apply_gpio_override(),
as gpio_mask will never be set for SOC chips.

Signed-off-by: Miaoqing Pan <miaoqing@codeaurora.org>
---
 drivers/net/wireless/ath/ath9k/hw.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/hw.c b/drivers/net/wireless/ath/ath9k/hw.c
index 2ca3b86..172081f 100644
--- a/drivers/net/wireless/ath/ath9k/hw.c
+++ b/drivers/net/wireless/ath/ath9k/hw.c
@@ -1621,7 +1621,6 @@ static void ath9k_hw_apply_gpio_override(struct ath_hw *ah)
 		ath9k_hw_gpio_request_out(ah, i, NULL,
 					  AR_GPIO_OUTPUT_MUX_AS_OUTPUT);
 		ath9k_hw_set_gpio(ah, i, !!(ah->gpio_val & BIT(i)));
-		ath9k_hw_gpio_free(ah, i);
 	}
 }
 
@@ -2728,14 +2727,17 @@ static void ath9k_hw_gpio_cfg_output_mux(struct ath_hw *ah, u32 gpio, u32 type)
 static void ath9k_hw_gpio_cfg_soc(struct ath_hw *ah, u32 gpio, bool out,
 				  const char *label)
 {
+	int err;
+
 	if (ah->caps.gpio_requested & BIT(gpio))
 		return;
 
-	/* may be requested by BSP, free anyway */
-	gpio_free(gpio);
-
-	if (gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label))
+	err = gpio_request_one(gpio, out ? GPIOF_OUT_INIT_LOW : GPIOF_IN, label);
+	if (err) {
+		ath_err(ath9k_hw_common(ah), "request GPIO%d failed:%d\n",
+			gpio, err);
 		return;
+	}
 
 	ah->caps.gpio_requested |= BIT(gpio);
 }
-- 
2.7.4

