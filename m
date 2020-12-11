Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35A3A2D7EFB
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 20:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388061AbgLKTBa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 14:01:30 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:33851 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730455AbgLKTBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 14:01:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607713259; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=o9PcRpZB4zI+OtTPqPohwWOpugPzrjk8iU/0SqPU0Qs=; b=RPRzp7LREb+J+3Yci6/QOE92eRH6+ZJMLUr5dfFxvrAVjheKKkldSwRfvtPh1sgm+90SmRzf
 PoR9urMRsHfnyzOZl4fXY/rb462shkFKsTUNOtDsRdwD8b4CPt6xc79VEq6Z8l4zRCtNq7h7
 IuW0BU5SEqM/CXP5eQP8ECNABeM=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fd3c1c853d7c5ba602f53d3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 19:00:24
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 03D73C433CA; Fri, 11 Dec 2020 19:00:24 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1521EC433C6;
        Fri, 11 Dec 2020 19:00:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1521EC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        briannorris@chromium.org, dianders@chromium.org,
        kuabhs@chromium.org, youghand@codeaurora.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Fix error handling in case of CE pipe init failure
Date:   Sat, 12 Dec 2020 00:30:10 +0530
Message-Id: <1607713210-18320-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently if the copy engine pipe init fails for snoc based
chipsets, the rri is not freed.

Fix this error handling for copy engine pipe init
failure.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Fixes: 4945af5b264f ("ath10k: enable SRRI/DRRI support on ddr for WCN3990")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index fd41f25..daae470 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1045,12 +1045,13 @@ static int ath10k_snoc_hif_power_up(struct ath10k *ar,
 	ret = ath10k_snoc_init_pipes(ar);
 	if (ret) {
 		ath10k_err(ar, "failed to initialize CE: %d\n", ret);
-		goto err_wlan_enable;
+		goto err_free_rri;
 	}
 
 	return 0;
 
-err_wlan_enable:
+err_free_rri:
+	ath10k_ce_free_rri(ar);
 	ath10k_snoc_wlan_disable(ar);
 
 	return ret;
-- 
2.7.4

