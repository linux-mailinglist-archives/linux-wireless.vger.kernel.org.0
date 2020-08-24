Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8503E25037D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Aug 2020 18:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728663AbgHXQpo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Aug 2020 12:45:44 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:56105 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727996AbgHXQou (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Aug 2020 12:44:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598287489; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XiOSYn7qD/a5lz3qBnbNEO9crTrCdOuxVtOrwtPLdC0=; b=AJT5B34NJiMtTYqMTry/CHQp/hCzL3UojVne/i4utAE0gTPv5gXF6PZmuKSxGuj9cJq5fNBx
 VFXnTCX2p9bhylrHUCtVm71W6MCh8DCLtm7n0d6qXhtYiQ/MP6P3YTgPcBp+NOEIoJf1ekBB
 OcpuFVbzugjgRCS0zjvIkvwEHB8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f43ee805bce3a955f6285f6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Aug 2020 16:44:48
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 848B2C433CA; Mon, 24 Aug 2020 16:44:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9365C433C6;
        Mon, 24 Aug 2020 16:44:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9365C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v6 2/3] ath11k: copy ce service configs to hw_params
Date:   Mon, 24 Aug 2020 22:14:29 +0530
Message-Id: <1598287470-1871-3-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
References: <1598287470-1871-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No functional changes, added target ce service configurations to hw_params.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V3:
 - added ce svc configs in hw_params

 drivers/net/wireless/ath/ath11k/ahb.c  | 14 +++++++++-----
 drivers/net/wireless/ath/ath11k/core.c |  6 ------
 drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 8466c62a83d6..a45a7d62f283 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -159,7 +159,7 @@ static const struct ce_pipe_config target_ce_config_wlan[] = {
  * This table is derived from the CE_PCI TABLE, above.
  * It is passed to the Target at startup for use by firmware.
  */
-static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
+static const struct service_to_pipe target_service_to_ce_map_wlan_ipq8074[] = {
 	{
 		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
 		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
@@ -579,8 +579,8 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 
 	cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
 	cfg->tgt_ce = target_ce_config_wlan;
-	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
-	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
+	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
+	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
 	ab->qmi.service_ins_id = ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074;
 }
 
@@ -789,8 +789,8 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	bool ul_set = false, dl_set = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
-		entry = &target_service_to_ce_map_wlan[i];
+	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params.svc_to_ce_map[i];
 
 		if (__le32_to_cpu(entry->service_id) != service_id)
 			continue;
@@ -890,6 +890,10 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		goto err_hal_srng_deinit;
 	}
 
+	ab->hw_params.svc_to_ce_map_len =
+			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
+	ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
+
 	ath11k_ahb_init_qmi_ce_config(ab);
 
 	ret = ath11k_core_init(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 437b1123a34f..61a6f395c436 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -812,12 +812,6 @@ int ath11k_core_init(struct ath11k_base *ab)
 		return ret;
 	}
 
-	ret = ath11k_init_hw_params(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to get hw params %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index d15fa7fd6d5d..ebe691cb4a13 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -129,6 +129,8 @@ struct ath11k_hw_params {
 	} fw;
 
 	const struct ath11k_hw_ops *hw_ops;
+	const struct service_to_pipe *svc_to_ce_map;
+	int svc_to_ce_map_len;
 
 	const struct ath11k_hw_ring_mask *ring_mask;
 
-- 
2.7.4

