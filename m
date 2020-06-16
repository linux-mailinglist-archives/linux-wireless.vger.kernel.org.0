Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3461FB347
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729154AbgFPOB4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:56 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:19811 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729136AbgFPOBy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316113; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XBCKJdFGqhrKOxUMpRsjnZo3rubFE5QV6CUVbi66uJA=; b=qFMKfX17/9sB2KYLxzV6KY59N9cybUecmrxpS63/iNyP7fOfoqXgwPtYqPi9mq0dWKXsnqdd
 ZQvYAMfJ8wRbuIn/zv8zAPGaHbVJRH327KgEvC1N02jsEFRAy32yfGJu4mYCKZU2CwIf5nfv
 fKH0xunhXTUqsvWrsZP2mHc4sBQ=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5ee8d0a20206ad41d1b8e55a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 31DA7C433A1; Tue, 16 Jun 2020 14:01:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F0E5AC433A1;
        Tue, 16 Jun 2020 14:01:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F0E5AC433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/12] ath11k: ahb: call ath11k_core_init() before irq configuration
Date:   Tue, 16 Jun 2020 17:00:44 +0300
Message-Id: <1592316055-24958-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

This is needed to init .max_radios in hw_params and onfigure external
interrupts for available pdev_ids.

Compile tested only.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 30092841ac46..2ea6da7682ce 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -951,15 +951,15 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 
 	ath11k_ahb_init_qmi_ce_config(ab);
 
-	ret = ath11k_ahb_config_irq(ab);
+	ret = ath11k_core_init(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to configure irq: %d\n", ret);
+		ath11k_err(ab, "failed to init core: %d\n", ret);
 		goto err_ce_free;
 	}
 
-	ret = ath11k_core_init(ab);
+	ret = ath11k_ahb_config_irq(ab);
 	if (ret) {
-		ath11k_err(ab, "failed to init core: %d\n", ret);
+		ath11k_err(ab, "failed to configure irq: %d\n", ret);
 		goto err_ce_free;
 	}
 
-- 
2.7.4

