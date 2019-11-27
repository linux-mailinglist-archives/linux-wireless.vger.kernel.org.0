Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2771310B0DF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Nov 2019 15:08:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727007AbfK0OIv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Nov 2019 09:08:51 -0500
Received: from a27-21.smtp-out.us-west-2.amazonses.com ([54.240.27.21]:34200
        "EHLO a27-21.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726984AbfK0OIv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Nov 2019 09:08:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1574863730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References;
        bh=64BURzLVhnTTAIOhav36ipJI49SeL7XluX01SmcnhH0=;
        b=oUHAFsyW1WSFQ24QGQDBMYLeIPoKmcGLaxvh53eTyrwdZRfHl/8CwgIwIIjvQb8D
        P8mjXCTwM+RsttdrWumSTOVIV3by8I5AdgRmFkT4ArPV5Up3WcOcmMPEzeXVkTFR2Yr
        cYfX7AOWoFdXzVTcE81KTWfkKFZeRfSQM23XqM/8=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=gdwg2y3kokkkj5a55z2ilkup5wp5hhxx; d=amazonses.com; t=1574863730;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:Feedback-ID;
        bh=64BURzLVhnTTAIOhav36ipJI49SeL7XluX01SmcnhH0=;
        b=bSQXFZ3paxy4yHW5z6g7VtmI2wndqSPpdmWa+x5M3ATvhYjYghf9LFxukQH4Pi5J
        y3HmxMPVNVCmS9VVnd8lDfrdyqdP6OYYCqslavM11e0bVOSfS6jodmx8P1vmKNzZsw3
        JbUgsrm1QKM5zRDyFTSEOWxnRBr9iPvHsUGO8JgM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2F77BC447AC
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     linux-wireless@vger.kernel.org
Cc:     ath11k@lists.infradead.org
Subject: [PATCH 03/10] ath11k: qmi clean up in ath11k_qmi_wlanfw_wlan_cfg_send()
Date:   Wed, 27 Nov 2019 14:08:50 +0000
Message-ID: <0101016ead31767d-ef497a3d-49b6-4206-aba4-5a340b55c9bc-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
References: <1574863720-25728-1-git-send-email-kvalo@codeaurora.org>
X-SES-Outgoing: 2019.11.27-54.240.27.21
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Anilkumar Kolli <akolli@codeaurora.org>

Use pipe_id id instead of ret in for loop.

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ce.h  |  9 +++++++--
 drivers/net/wireless/ath/ath11k/qmi.c | 28 +++++++++++++---------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ce.h b/drivers/net/wireless/ath/ath11k/ce.h
index 6174eac84410..e355dfda48bf 100644
--- a/drivers/net/wireless/ath/ath11k/ce.h
+++ b/drivers/net/wireless/ath/ath11k/ce.h
@@ -57,7 +57,12 @@ void ath11k_ce_byte_swap(void *mem, u32 len);
 
 struct ath11k_base;
 
-/* Establish a mapping between a service/direction and a pipe. */
+/*
+ * Establish a mapping between a service/direction and a pipe.
+ * Configuration information for a Copy Engine pipe and services.
+ * Passed from Host to Target through QMI message and must be in
+ * little endian format.
+ */
 struct service_to_pipe {
 	__le32 service_id;
 	__le32 pipedir;
@@ -66,7 +71,7 @@ struct service_to_pipe {
 
 /*
  * Configuration information for a Copy Engine pipe.
- * Passed from Host to Target during startup (one per CE).
+ * Passed from Host to Target through QMI message during startup (one per CE).
  *
  * NOTE: Structure is shared between Host software and Target firmware!
  */
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index adf41f28a231..2377895a58ec 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -2016,7 +2016,7 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 	struct ce_pipe_config *ce_cfg;
 	struct service_to_pipe *svc_cfg;
 	struct qmi_txn txn = {};
-	int ret = 0;
+	int ret = 0, pipe_num;
 
 	ce_cfg	= (struct ce_pipe_config *)ab->qmi.ce_cfg.tgt_ce;
 	svc_cfg	= (struct service_to_pipe *)ab->qmi.ce_cfg.svc_to_ce_map;
@@ -2033,24 +2033,22 @@ static int ath11k_qmi_wlanfw_wlan_cfg_send(struct ath11k_base *ab)
 
 	req->tgt_cfg_valid = 1;
 	/* This is number of CE configs */
-	req->tgt_cfg_len = ((ab->qmi.ce_cfg.tgt_ce_len) /
-				(sizeof(struct ce_pipe_config))) - 1;
-	for (ret = 0; ret <= req->tgt_cfg_len ; ret++) {
-		req->tgt_cfg[ret].pipe_num = ce_cfg[ret].pipenum;
-		req->tgt_cfg[ret].pipe_dir = ce_cfg[ret].pipedir;
-		req->tgt_cfg[ret].nentries = ce_cfg[ret].nentries;
-		req->tgt_cfg[ret].nbytes_max = ce_cfg[ret].nbytes_max;
-		req->tgt_cfg[ret].flags = ce_cfg[ret].flags;
+	req->tgt_cfg_len = ab->qmi.ce_cfg.tgt_ce_len;
+	for (pipe_num = 0; pipe_num <= req->tgt_cfg_len ; pipe_num++) {
+		req->tgt_cfg[pipe_num].pipe_num = ce_cfg[pipe_num].pipenum;
+		req->tgt_cfg[pipe_num].pipe_dir = ce_cfg[pipe_num].pipedir;
+		req->tgt_cfg[pipe_num].nentries = ce_cfg[pipe_num].nentries;
+		req->tgt_cfg[pipe_num].nbytes_max = ce_cfg[pipe_num].nbytes_max;
+		req->tgt_cfg[pipe_num].flags = ce_cfg[pipe_num].flags;
 	}
 
 	req->svc_cfg_valid = 1;
 	/* This is number of Service/CE configs */
-	req->svc_cfg_len = (ab->qmi.ce_cfg.svc_to_ce_map_len) /
-				(sizeof(struct service_to_pipe));
-	for (ret = 0; ret < req->svc_cfg_len; ret++) {
-		req->svc_cfg[ret].service_id = svc_cfg[ret].service_id;
-		req->svc_cfg[ret].pipe_dir = svc_cfg[ret].pipedir;
-		req->svc_cfg[ret].pipe_num = svc_cfg[ret].pipenum;
+	req->svc_cfg_len = ab->qmi.ce_cfg.svc_to_ce_map_len;
+	for (pipe_num = 0; pipe_num < req->svc_cfg_len; pipe_num++) {
+		req->svc_cfg[pipe_num].service_id = svc_cfg[pipe_num].service_id;
+		req->svc_cfg[pipe_num].pipe_dir = svc_cfg[pipe_num].pipedir;
+		req->svc_cfg[pipe_num].pipe_num = svc_cfg[pipe_num].pipenum;
 	}
 	req->shadow_reg_valid = 0;
 	req->shadow_reg_v2_valid = 0;
-- 
2.7.4

