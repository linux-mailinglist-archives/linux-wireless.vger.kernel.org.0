Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47E316162
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbhBJIr2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:28 -0500
Received: from so15.mailgun.net ([198.61.254.15]:46844 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230182AbhBJIng (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946578; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=2TP8qvWrDlpsJ33CkHR3Ln6RM1J+7f5c7dJpOmArdiQ=; b=Vjpox51T6j3fyTpo2no7UWLYyjmT/5kRqJAbxOP7S81nit3edgoQE4dv4rHmIG+M+nZogc+s
 DIHDmqVPEVfs4fbBT6VQGKoj5UzkDpfYN8Dcdr7xh5j9FT1aKWu08q4N7XI3KrPrpX6V7Wwl
 b+rIuFe67aC5L/n/4MDtIWHTkRM=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 60239c7734db06ef79f407b8 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:31
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A5CB4C43462; Wed, 10 Feb 2021 08:42:31 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 92FECC433CA;
        Wed, 10 Feb 2021 08:42:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 92FECC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 04/11] ath11k: Update memory segment count for qcn9074
Date:   Wed, 10 Feb 2021 14:12:03 +0530
Message-Id: <1612946530-28504-5-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN9074 FW requests three types memory segments during the boot,
	qmi mem seg type 1 of size 15728640
	qmi mem seg type 4 of size 3735552
	qmi mem seg type 3 of size 1048576
Segment type 3 is for M3 coredump memory.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 2 +-
 drivers/net/wireless/ath/ath11k/qmi.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0db623ff4bb9..104eabd8df02 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1760,7 +1760,7 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 						  &chunk->paddr,
 						  GFP_KERNEL);
 		if (!chunk->vaddr) {
-			if (ab->qmi.mem_seg_count <= 2) {
+			if (ab->qmi.mem_seg_count <= ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT) {
 				ath11k_dbg(ab, ATH11K_DBG_QMI,
 					   "qmi dma allocation failed (%d B type %u), will try later with small size\n",
 					    chunk->size,
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 1797c3b59f48..a7d01c295e77 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -26,6 +26,7 @@
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
 #define ATH11K_QMI_CALDB_SIZE			0x480000
 #define ATH11K_QMI_BDF_EXT_STR_LENGTH		0x20
+#define ATH11K_QMI_FW_MEM_REQ_SEGMENT_CNT	3
 
 #define QMI_WLFW_REQUEST_MEM_IND_V01		0x0035
 #define QMI_WLFW_FW_MEM_READY_IND_V01		0x0037
@@ -141,6 +142,7 @@ struct ath11k_qmi {
 #define QMI_IPQ8074_FW_MEM_MODE				0xFF
 #define HOST_DDR_REGION_TYPE				0x1
 #define BDF_MEM_REGION_TYPE				0x2
+#define M3_DUMP_REGION_TYPE				0x3
 #define CALDB_MEM_REGION_TYPE				0x4
 
 struct qmi_wlanfw_host_cap_req_msg_v01 {
-- 
2.7.4

