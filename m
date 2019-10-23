Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED39E165F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2019 11:40:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404010AbfJWJk1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 23 Oct 2019 05:40:27 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:49104 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729191AbfJWJk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 23 Oct 2019 05:40:27 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 9E66260F61; Wed, 23 Oct 2019 09:40:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823625;
        bh=ZQsqHINW6xAB0KANIbCFsuyTLLk9RpKASFWISFomRSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mq7YdpaHsTwNRj3csiuNBsgJxQVhBM0kvEL8DPZZ2MVmJT8t7ix9TSb6OCxrt5H+A
         VqZPubHuCM+DLHmRBzbwsn2rAlCc8JLrBdol8n0d+k+qyLABUI8eUmDVJhl7JiBzVI
         4YJiS1i7ZJYG7TmK7ECnf73U2vZhab6kpSxM0aRU=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 898C760F5E;
        Wed, 23 Oct 2019 09:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1571823625;
        bh=ZQsqHINW6xAB0KANIbCFsuyTLLk9RpKASFWISFomRSg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mq7YdpaHsTwNRj3csiuNBsgJxQVhBM0kvEL8DPZZ2MVmJT8t7ix9TSb6OCxrt5H+A
         VqZPubHuCM+DLHmRBzbwsn2rAlCc8JLrBdol8n0d+k+qyLABUI8eUmDVJhl7JiBzVI
         4YJiS1i7ZJYG7TmK7ECnf73U2vZhab6kpSxM0aRU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 898C760F5E
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH 2/2] ath10k: Don't call SCM interface for statically mapped msa region
Date:   Wed, 23 Oct 2019 15:10:14 +0530
Message-Id: <20191023094014.28683-3-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191023094014.28683-1-govinds@codeaurora.org>
References: <20191023094014.28683-1-govinds@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For some targets ex: QCS404, SCM permissions for MSA region is
statically configured in TrustZone fw. Add SCM call disable option
for such targets to avoid duplicate permissions.

Testing: Tested on WCN3990 HW
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 9 +++++++++
 drivers/net/wireless/ath/ath10k/qmi.h | 1 +
 2 files changed, 10 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index da16874012c5..d43ec0183287 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -95,6 +95,9 @@ static int ath10k_qmi_setup_msa_permissions(struct ath10k_qmi *qmi)
 	int ret;
 	int i;
 
+	if (qmi->msa_fixed_perm)
+		return 0;
+
 	for (i = 0; i < qmi->nr_mem_region; i++) {
 		ret = ath10k_qmi_map_msa_permission(qmi, &qmi->mem_region[i]);
 		if (ret)
@@ -113,6 +116,9 @@ static void ath10k_qmi_remove_msa_permission(struct ath10k_qmi *qmi)
 {
 	int i;
 
+	if (qmi->msa_fixed_perm)
+		return;
+
 	for (i = 0; i < qmi->nr_mem_region; i++)
 		ath10k_qmi_unmap_msa_permission(qmi, &qmi->mem_region[i]);
 }
@@ -1021,6 +1027,9 @@ static int ath10k_qmi_setup_msa_resources(struct ath10k_qmi *qmi, u32 msa_size)
 		qmi->msa_mem_size = msa_size;
 	}
 
+	if (of_property_read_bool(dev->of_node, "qcom,msa_fixed_perm"))
+		qmi->msa_fixed_perm = true;
+
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "msa pa: %pad , msa va: 0x%p\n",
 		   &qmi->msa_pa,
 		   qmi->msa_va);
diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
index 4ab21b223aaf..3a039e6e29df 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.h
+++ b/drivers/net/wireless/ath/ath10k/qmi.h
@@ -115,6 +115,7 @@ struct ath10k_qmi {
 	bool fw_ready;
 	char fw_build_timestamp[MAX_TIMESTAMP_LEN + 1];
 	struct ath10k_qmi_cal_data cal_data[MAX_NUM_CAL_V01];
+	bool msa_fixed_perm;
 };
 
 int ath10k_qmi_wlan_enable(struct ath10k *ar,
-- 
2.22.0

