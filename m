Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D7BB46D4CC
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Dec 2021 14:50:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232719AbhLHNxf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Dec 2021 08:53:35 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:11106 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbhLHNxe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Dec 2021 08:53:34 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1638971402; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=wmQ6CY3IRk6LqFmi/5O3ikzFR96ha2o07pccedWxgww=; b=wBJllQDKrdaJJD5R2965cJD2LB4qYg0RKym2WQ2qwIG6VwD6/oA0Pn4Tdvp1H4napxit194M
 CYczB2xX0nB5o5/nFcRlzyGrvADARBgadesnQUCq/9572HwZxeuvZ6SLhAMc41t1hyQayEkp
 qhMtIN/5lAdCbM5iThV8cXTM9RQ=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61b0b8094c698e2e8117bd61 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 08 Dec 2021 13:50:01
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8163AC4338F; Wed,  8 Dec 2021 13:50:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
Received: from akolli-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1F1ACC4360C;
        Wed,  8 Dec 2021 13:49:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 1F1ACC4360C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Seevalamuthu Mariappan <seevalam@codeaurora.org>,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH v2] ath11k: Change qcn9074 fw to operate in mode-2
Date:   Wed,  8 Dec 2021 19:19:50 +0530
Message-Id: <1638971390-7160-1-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Seevalamuthu Mariappan <seevalam@codeaurora.org>

In mode-2 QCN9074 firmware uses 15MB of host memory and firmware
request 1MB size segements in QMI, whereas in mode-0 firmware
uses 45MB of host memory and each segment is of 2MB size.
In mode-2 firmware operates with reduced number of vdevs and peers.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01838-QCAHKSWPL_SILICONZ-1

Signed-off-by: Seevalamuthu Mariappan <seevalam@codeaurora.org>
Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
V2:
  - add num_vdevs, num_peers to hw params (Kalle)

 drivers/net/wireless/ath/ath11k/core.c | 18 ++++++++++++++++++
 drivers/net/wireless/ath/ath11k/hw.h   |  9 ++++++---
 drivers/net/wireless/ath/ath11k/qmi.c  |  2 +-
 3 files changed, 25 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 1d983fde6fc9..470c932e30cf 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -79,6 +79,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = true,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -134,6 +137,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = true,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -188,6 +194,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_ipq8074),
 		.fix_l1ss = true,
@@ -242,6 +251,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = false,
 		.supports_sta_ps = false,
 		.cold_boot_calib = false,
+		.fw_mem_mode = 2,
+		.num_vdevs = 8,
+		.num_peers = 128,
 		.supports_suspend = false,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_qcn9074),
 		.fix_l1ss = true,
@@ -296,6 +308,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
@@ -349,6 +364,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 		.idle_ps = true,
 		.supports_sta_ps = true,
 		.cold_boot_calib = false,
+		.fw_mem_mode = 0,
+		.num_vdevs = 16 + 1,
+		.num_peers = 512,
 		.supports_suspend = true,
 		.hal_desc_sz = sizeof(struct hal_rx_desc_wcn6855),
 		.fix_l1ss = false,
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index fe6e0cb9476c..c17631924481 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -12,9 +12,9 @@
 /* Target configuration defines */
 
 /* Num VDEVS per radio */
-#define TARGET_NUM_VDEVS	(16 + 1)
+#define TARGET_NUM_VDEVS	(ab->hw_params.num_vdevs)
 
-#define TARGET_NUM_PEERS_PDEV	(512 + TARGET_NUM_VDEVS)
+#define TARGET_NUM_PEERS_PDEV	(ab->hw_params.num_peers + TARGET_NUM_VDEVS)
 
 /* Num of peers for Single Radio mode */
 #define TARGET_NUM_PEERS_SINGLE		(TARGET_NUM_PEERS_PDEV)
@@ -26,7 +26,7 @@
 #define TARGET_NUM_PEERS_DBS_SBS	(3 * TARGET_NUM_PEERS_PDEV)
 
 /* Max num of stations (per radio) */
-#define TARGET_NUM_STATIONS	512
+#define TARGET_NUM_STATIONS	(ab->hw_params.num_peers)
 
 #define TARGET_NUM_PEERS(x)	TARGET_NUM_PEERS_##x
 #define TARGET_NUM_PEER_KEYS	2
@@ -173,6 +173,9 @@ struct ath11k_hw_params {
 	bool idle_ps;
 	bool supports_sta_ps;
 	bool cold_boot_calib;
+	int fw_mem_mode;
+	u32 num_vdevs;
+	u32 num_peers;
 	bool supports_suspend;
 	u32 hal_desc_sz;
 	bool fix_l1ss;
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 625d525a86b9..3b9ba0e03a66 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2877,7 +2877,7 @@ int ath11k_qmi_init_service(struct ath11k_base *ab)
 	memset(&ab->qmi.target_mem, 0, sizeof(struct target_mem_chunk));
 	ab->qmi.ab = ab;
 
-	ab->qmi.target_mem_mode = ATH11K_QMI_TARGET_MEM_MODE_DEFAULT;
+	ab->qmi.target_mem_mode = ab->hw_params.fw_mem_mode;
 	ret = qmi_handle_init(&ab->qmi.handle, ATH11K_QMI_RESP_LEN_MAX,
 			      &ath11k_qmi_ops, ath11k_qmi_msg_handlers);
 	if (ret < 0) {
-- 
2.7.4

