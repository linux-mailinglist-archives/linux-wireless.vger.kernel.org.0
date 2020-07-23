Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D31F22AEBB
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Jul 2020 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728499AbgGWMLb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Jul 2020 08:11:31 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:62309 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728396AbgGWMLb (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Jul 2020 08:11:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1595506290; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=Dk0aGUdOPthT8VlN9Qh+Ev+sNukDGkYigjembz8orGk=; b=tHioEnkNv2cySGEwVzAjr25k/hZ/AH4NyJ/I/EoCoQ8o07bmxkEph26yVQjEmygAH71WuzAZ
 /jtBQfBwwYkKzEO7y39cAvLvseSxt/AWtxXKh3LS9OySUF7ZAZMp9Ms4Reytk3ECLeeJKizx
 Rli/wneUwcl/If7zZYmZGP6hFM4=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f197e673dbcb593a94679ad (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 23 Jul 2020 12:11:19
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 20D9FC433C9; Thu, 23 Jul 2020 12:11:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4120AC43391;
        Thu, 23 Jul 2020 12:11:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4120AC43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        akolli@codeaurora.org
Subject: [PATCH v4 2/3] ath11k: copy ce service configs to hw_params
Date:   Thu, 23 Jul 2020 17:41:03 +0530
Message-Id: <1595506264-6393-3-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1595506264-6393-1-git-send-email-akolli@codeaurora.org>
References: <1595506264-6393-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No functional changes, added target ce service configurations
to hw_params.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V3:
 - added ce svc configs in hw_params

 drivers/net/wireless/ath/ath11k/ahb.c  | 20 +++++++++++++++-----
 drivers/net/wireless/ath/ath11k/core.c |  8 +-------
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  2 ++
 4 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 7e9bfeaaf4d2..aa74d27e5871 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -152,7 +152,7 @@ static const struct ce_pipe_config target_ce_config_wlan[] = {
  * This table is derived from the CE_PCI TABLE, above.
  * It is passed to the Target at startup for use by firmware.
  */
-static const struct service_to_pipe target_service_to_ce_map_wlan[] = {
+static const struct service_to_pipe target_service_to_ce_map_wlan_ipq8074[] = {
 	{
 		.service_id = __cpu_to_le32(ATH11K_HTC_SVC_ID_WMI_DATA_VO),
 		.pipedir = __cpu_to_le32(PIPEDIR_OUT),	/* out = UL = host -> target */
@@ -644,8 +644,8 @@ static void ath11k_ahb_init_qmi_ce_config(struct ath11k_base *ab)
 
 	cfg->tgt_ce_len = ARRAY_SIZE(target_ce_config_wlan) - 1;
 	cfg->tgt_ce = target_ce_config_wlan;
-	cfg->svc_to_ce_map_len = ARRAY_SIZE(target_service_to_ce_map_wlan);
-	cfg->svc_to_ce_map = target_service_to_ce_map_wlan;
+	cfg->svc_to_ce_map_len = ab->hw_params.svc_to_ce_map_len;
+	cfg->svc_to_ce_map = ab->hw_params.svc_to_ce_map;
 }
 
 static void ath11k_ahb_free_ext_irq(struct ath11k_base *ab)
@@ -853,8 +853,8 @@ static int ath11k_ahb_map_service_to_pipe(struct ath11k_base *ab, u16 service_id
 	bool ul_set = false, dl_set = false;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(target_service_to_ce_map_wlan); i++) {
-		entry = &target_service_to_ce_map_wlan[i];
+	for (i = 0; i < ab->hw_params.svc_to_ce_map_len; i++) {
+		entry = &ab->hw_params.svc_to_ce_map[i];
 
 		if (__le32_to_cpu(entry->service_id) != service_id)
 			continue;
@@ -950,6 +950,16 @@ static int ath11k_ahb_probe(struct platform_device *pdev)
 		goto err_hal_srng_deinit;
 	}
 
+	ret = ath11k_init_hw_params(ab);
+	if (ret) {
+		ath11k_err(ab, "failed to get hw params %d\n", ret);
+		return ret;
+	}
+
+	ab->hw_params.svc_to_ce_map_len =
+			ARRAY_SIZE(target_service_to_ce_map_wlan_ipq8074);
+	ab->hw_params.svc_to_ce_map = target_service_to_ce_map_wlan_ipq8074;
+
 	ath11k_ahb_init_qmi_ce_config(ab);
 
 	ret = ath11k_core_init(ab);
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 38e830a2395b..0bf8bb1674dc 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -703,7 +703,7 @@ static void ath11k_core_restart(struct work_struct *work)
 	complete(&ab->driver_recovery);
 }
 
-static int ath11k_init_hw_params(struct ath11k_base *ab)
+int ath11k_init_hw_params(struct ath11k_base *ab)
 {
 	const struct ath11k_hw_params *hw_params = NULL;
 	int i;
@@ -746,12 +746,6 @@ int ath11k_core_init(struct ath11k_base *ab)
 	}
 	ab->tgt_rproc = prproc;
 
-	ret = ath11k_init_hw_params(ab);
-	if (ret) {
-		ath11k_err(ab, "failed to get hw params %d\n", ret);
-		return ret;
-	}
-
 	ret = ath11k_core_soc_create(ab);
 	if (ret) {
 		ath11k_err(ab, "failed to create soc core: %d\n", ret);
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b6ccd9f93853..98b994984c25 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -852,6 +852,7 @@ struct ath11k_peer *ath11k_peer_find_by_id(struct ath11k_base *ab, int peer_id);
 int ath11k_core_qmi_firmware_ready(struct ath11k_base *ab);
 int ath11k_core_init(struct ath11k_base *ath11k);
 void ath11k_core_deinit(struct ath11k_base *ath11k);
+int ath11k_init_hw_params(struct ath11k_base *ab);
 struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 				      enum ath11k_bus bus);
 void ath11k_core_free(struct ath11k_base *ath11k);
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index f31d53f6adb8..388cfb42ef93 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -116,6 +116,8 @@ struct ath11k_hw_params {
 	} fw;
 
 	const struct ath11k_hw_ops *hw_ops;
+	const struct service_to_pipe *svc_to_ce_map;
+	int svc_to_ce_map_len;
 };
 
 extern const struct ath11k_hw_ops ipq8074_ops;
-- 
2.7.4

