Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F19D1FB340
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:01:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbgFPOBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:22812 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729215AbgFPOBj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316097; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=7E2tPoTEexHYdV+YW9E58VHRqyghxDOqe8MmNh4fimw=; b=fE33blPzRz2WtzlYe1E26QT4e7SYPJ7BTmZcv/mv7O5WIbwnQEOJ9O4VeSNybtnCNYE3K1cj
 0h5IGILADoIoM+8WC4OUt616DhABkaDJSrR5cT0Gqwk4/4OYRDJ8NOesMUwHbp+x7ykLzZQX
 /aKZf2i1B0RweAiLw5peYoLUvXA=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5ee8d0a2ad153efa34c63de4 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:06
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 38A64C433A0; Tue, 16 Jun 2020 14:01:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 24BBAC4339C;
        Tue, 16 Jun 2020 14:01:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 24BBAC4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/12] ath11k: convert ath11k_hw_params to an array
Date:   Tue, 16 Jun 2020 17:00:45 +0300
Message-Id: <1592316055-24958-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Convert to ath11k_hw_params to an array to make it possible add new hardware in
the future, for example IPQ6018 or QCA6390.

No functional changes. Compile tested only.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 46 ++++++++++++++++++++++++++++------
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 905cd8beaf28..92d7925ad0f4 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -17,12 +17,15 @@ unsigned int ath11k_debug_mask;
 module_param_named(debug_mask, ath11k_debug_mask, uint, 0644);
 MODULE_PARM_DESC(debug_mask, "Debugging mask");
 
-static const struct ath11k_hw_params ath11k_hw_params = {
-	.name = "ipq8074",
-	.fw = {
-		.dir = IPQ8074_FW_DIR,
-		.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
-		.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
+static const struct ath11k_hw_params ath11k_hw_params[] = {
+	{
+		.hw_rev = ATH11K_HW_IPQ8074,
+		.name = "ipq8074 hw2.0",
+		.fw = {
+			.dir = IPQ8074_FW_DIR,
+			.board_size = IPQ8074_MAX_BOARD_DATA_SZ,
+			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
+		},
 	},
 };
 
@@ -717,6 +720,30 @@ static void ath11k_core_restart(struct work_struct *work)
 	complete(&ab->driver_recovery);
 }
 
+static int ath11k_init_hw_params(struct ath11k_base *ab)
+{
+	const struct ath11k_hw_params *hw_params = NULL;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(ath11k_hw_params); i++) {
+		hw_params = &ath11k_hw_params[i];
+
+		if (hw_params->hw_rev == ab->hw_rev)
+			break;
+	}
+
+	if (i == ARRAY_SIZE(ath11k_hw_params)) {
+		ath11k_err(ab, "Unsupported hardware version: 0x%x\n", ab->hw_rev);
+		return -EINVAL;
+	}
+
+	ab->hw_params = *hw_params;
+
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "Hardware name %s\n", ab->hw_params.name);
+
+	return 0;
+}
+
 int ath11k_core_init(struct ath11k_base *ab)
 {
 	struct device *dev = ab->dev;
@@ -735,7 +762,12 @@ int ath11k_core_init(struct ath11k_base *ab)
 		return -EINVAL;
 	}
 	ab->tgt_rproc = prproc;
-	ab->hw_params = ath11k_hw_params;
+
+	ret = ath11k_init_hw_params(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to get hw params %d\n", ret);
+		return ret;
+	}
 
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f7f070af233c..f95ad31d3d6c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -106,6 +106,7 @@ enum ath11k_bus {
 
 struct ath11k_hw_params {
 	const char *name;
+	u16 hw_rev;
 	struct {
 		const char *dir;
 		size_t board_size;
-- 
2.7.4

