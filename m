Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C953A1F3CAA
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2020 15:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730160AbgFINdm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 9 Jun 2020 09:33:42 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45942 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728601AbgFINdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 9 Jun 2020 09:33:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591709619; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VmzIttl5OFbpzaIHJ1qo6kTcVqwP4i0EA5zvkkjat0g=; b=Rgw4ekCvoKWNB2u9hvx13xynMHUzYH59pqHkld+T4EmtzUQ3V54jvn3OeDgsIQHqSNwdQiur
 oTqhxIdX9BQwMaLViVKsOQ65vmAA3GWuKrOOwZQx68CnlV+FblhzktMe/8SV+QXlzWAgUpg9
 AdUpEU0l0T3Qz3r17waZ1oIt2HY=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5edf8fb13a8a8b20b8b1f442 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 09 Jun 2020 13:33:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EE45FC433CB; Tue,  9 Jun 2020 13:33:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0E646C433A1;
        Tue,  9 Jun 2020 13:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0E646C433A1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2 8/8] ath11k: Add bdf-addr in hw_params
Date:   Tue,  9 Jun 2020 19:03:01 +0530
Message-Id: <1591709581-18039-9-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
References: <1591709581-18039-1-git-send-email-akolli@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

bdf-addr is different for IPQ8074 and IPQ6018

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c | 2 ++
 drivers/net/wireless/ath/ath11k/hw.h   | 1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 6 +++---
 drivers/net/wireless/ath/ath11k/qmi.h  | 1 -
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 79ee97e91159..7d528677e3a3 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -27,6 +27,7 @@ static const struct ath11k_hw_params ath11k_hw_params_list[] = {
 			.cal_size =  IPQ8074_MAX_CAL_DATA_SZ,
 		},
 		.max_radios = 3,
+		.bdf_addr = 0x4B0C0000,
 		.hw_ops = &ipq8074_ops,
 	},
 	{
@@ -38,6 +39,7 @@ static const struct ath11k_hw_params ath11k_hw_params_list[] = {
 			.cal_size =  IPQ6018_MAX_CAL_DATA_SZ,
 		},
 		.max_radios = 2,
+		.bdf_addr = 0x4ABC0000,
 		.hw_ops = &ipq6018_ops,
 	},
 };
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index 5b5cd56c1aea..6d372eeb869c 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -115,6 +115,7 @@ struct ath11k_hw_ops {
 
 struct ath11k_hw_params {
 	const char *name;
+	u32 bdf_addr;
 	u16 dev_id;
 	u8 max_radios;
 	struct {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c00a99ad8dbc..e4198d3b0bae 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1681,8 +1681,8 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
 		case BDF_MEM_REGION_TYPE:
-			ab->qmi.target_mem[idx].paddr = ATH11K_QMI_BDF_ADDRESS;
-			ab->qmi.target_mem[idx].vaddr = ATH11K_QMI_BDF_ADDRESS;
+			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
+			ab->qmi.target_mem[idx].vaddr = ab->hw_params.bdf_addr;
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -1854,7 +1854,7 @@ static int ath11k_qmi_load_bdf(struct ath11k_base *ab)
 		return -ENOMEM;
 	memset(&resp, 0, sizeof(resp));
 
-	bdf_addr = ioremap(ATH11K_QMI_BDF_ADDRESS, ATH11K_QMI_BDF_MAX_SIZE);
+	bdf_addr = ioremap(ab->hw_params.bdf_addr, ATH11K_QMI_BDF_MAX_SIZE);
 	if (!bdf_addr) {
 		ath11k_warn(ab, "qmi ioremap error for BDF\n");
 		ret = -EIO;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3f7db642d869..a7a0a189cbe4 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -12,7 +12,6 @@
 #define ATH11K_HOST_VERSION_STRING		"WIN"
 #define ATH11K_QMI_WLANFW_TIMEOUT_MS		5000
 #define ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE	64
-#define ATH11K_QMI_BDF_ADDRESS			0x4B0C0000
 #define ATH11K_QMI_BDF_MAX_SIZE			(256 * 1024)
 #define ATH11K_QMI_CALDATA_OFFSET		(128 * 1024)
 #define ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01	128
-- 
2.7.4

