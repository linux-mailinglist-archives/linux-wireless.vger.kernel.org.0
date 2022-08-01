Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32528586C40
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Aug 2022 15:50:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231923AbiHANu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Aug 2022 09:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231955AbiHANuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Aug 2022 09:50:25 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B38BF76
        for <linux-wireless@vger.kernel.org>; Mon,  1 Aug 2022 06:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659361824; x=1690897824;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=OqXZiX9gq6pGhLFYwdK1F8Ucu6j0mtnGUZaMYCUTQFU=;
  b=iYHcoe+iomedDHB72SpZnf8eXT9K+UJUamE4e6S92GpKp3iC4ZG7qtrN
   2tuSlmKW09ItkoK/QWyULN7XvWDlBP4XIkwzU7Plj83lUgkrfUkeIESLO
   44nLzIXZtHqc/ZqOd76eUyLzYQp4CJGfnh/Z10TnPOQK9WqIXBKZAF0IT
   M=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 01 Aug 2022 06:50:23 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Aug 2022 06:50:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 06:50:22 -0700
Received: from youghand-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 1 Aug 2022 06:50:21 -0700
From:   Youghandhar Chintala <quic_youghand@quicinc.com>
To:     <ath10k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>,
        Youghandhar Chintala <quic_youghand@quicinc.com>
Subject: [PATCH] wifi:ath10k: Set tx credit to one for WCN3990 snoc based devices
Date:   Mon, 1 Aug 2022 19:19:41 +0530
Message-ID: <20220801134941.15216-1-quic_youghand@quicinc.com>
X-Mailer: git-send-email 2.37.0
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Currently host can send two WMI commands at once.There is possibility to
cause SMMU issues or corruption, if host wants to initiate 2 DMA
transfers, it is possible when copy complete interrupt for first DMA
reaches host, CE has already updated SRRI (Source ring read index) for
both DMA transfers and is in the middle of 2nd DMA. Host uses SRRI
(Source ring read index) to interpret how many DMA’s have been completed
and tries to unmap/free both the DMA entries.Hence now it is limiting to
one.Because CE is  still in the middle of 2nd DMA which can cause these
issues when handling two DMA transfers.

This change will not impact other targets, as it is only for WCN3990.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.2.0-01387-QCAHLSWMTPLZ-1

Signed-off-by: Youghandhar Chintala <quic_youghand@quicinc.com>
---
 drivers/net/wireless/ath/ath10k/core.c | 16 ++++++++++++++++
 drivers/net/wireless/ath/ath10k/htc.c  | 10 +++++++---
 drivers/net/wireless/ath/ath10k/hw.h   |  2 ++
 3 files changed, 25 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 276954b70d63..d1ac64026cb3 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -98,6 +98,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = true,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA988X_HW_2_0_VERSION,
@@ -136,6 +137,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = true,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9887_HW_1_0_VERSION,
@@ -175,6 +177,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -209,6 +212,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.supports_peer_stats_info = true,
 		.dynamic_sar_support = true,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -247,6 +251,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA6174_HW_2_1_VERSION,
@@ -285,6 +290,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA6174_HW_3_0_VERSION,
@@ -323,6 +329,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA6174_HW_3_2_VERSION,
@@ -365,6 +372,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.supports_peer_stats_info = true,
 		.dynamic_sar_support = true,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA99X0_HW_2_0_DEV_VERSION,
@@ -409,6 +417,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9984_HW_1_0_DEV_VERSION,
@@ -460,6 +469,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9888_HW_2_0_DEV_VERSION,
@@ -508,6 +518,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9377_HW_1_0_DEV_VERSION,
@@ -546,6 +557,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -586,6 +598,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA9377_HW_1_1_DEV_VERSION,
@@ -617,6 +630,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.credit_size_workaround = true,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = QCA4019_HW_1_0_DEV_VERSION,
@@ -662,6 +676,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = false,
 		.hw_restart_disconnect = false,
+		.use_fw_tx_credits = true,
 	},
 	{
 		.id = WCN3990_HW_1_0_DEV_VERSION,
@@ -693,6 +708,7 @@ static const struct ath10k_hw_params ath10k_hw_params_list[] = {
 		.tx_stats_over_pktlog = false,
 		.dynamic_sar_support = true,
 		.hw_restart_disconnect = true,
+		.use_fw_tx_credits = false,
 	},
 };
 
diff --git a/drivers/net/wireless/ath/ath10k/htc.c b/drivers/net/wireless/ath/ath10k/htc.c
index fab398046a3f..cf55b4f7b280 100644
--- a/drivers/net/wireless/ath/ath10k/htc.c
+++ b/drivers/net/wireless/ath/ath10k/htc.c
@@ -947,13 +947,17 @@ int ath10k_htc_wait_target(struct ath10k_htc *htc)
 		return -ECOMM;
 	}
 
-	htc->total_transmit_credits = __le16_to_cpu(msg->ready.credit_count);
+	if (ar->hw_params.use_fw_tx_credits)
+		htc->total_transmit_credits = __le16_to_cpu(msg->ready.credit_count);
+	else
+		htc->total_transmit_credits = 1;
 	htc->target_credit_size = __le16_to_cpu(msg->ready.credit_size);
 
 	ath10k_dbg(ar, ATH10K_DBG_HTC,
-		   "Target ready! transmit resources: %d size:%d\n",
+		   "Target ready! transmit resources: %d size:%d actual credits:%d\n",
 		   htc->total_transmit_credits,
-		   htc->target_credit_size);
+		   htc->target_credit_size,
+		   msg->ready.credit_count);
 
 	if ((htc->total_transmit_credits == 0) ||
 	    (htc->target_credit_size == 0)) {
diff --git a/drivers/net/wireless/ath/ath10k/hw.h b/drivers/net/wireless/ath/ath10k/hw.h
index 93acf0dd580a..1b99f3a39a11 100644
--- a/drivers/net/wireless/ath/ath10k/hw.h
+++ b/drivers/net/wireless/ath/ath10k/hw.h
@@ -635,6 +635,8 @@ struct ath10k_hw_params {
 	bool dynamic_sar_support;
 
 	bool hw_restart_disconnect;
+
+	bool use_fw_tx_credits;
 };
 
 struct htt_resp;
-- 
2.37.0

