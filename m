Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9FD3812F8EC
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2020 14:44:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgACNoc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 3 Jan 2020 08:44:32 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:47858 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727842AbgACNob (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 3 Jan 2020 08:44:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578059071; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=UlpiOoJT8j543QirBk1cXC1jCPY25M9dD9qGZjatIyI=; b=KdowJ11A7RK5XXg3xPyHITpwe/Y4qxP/yjYjtJUE9j1e9XT65GYx0Q4aLnWy1HpgA0pd+mMg
 GlTG3OaUPGaOKcYDhf55Hd6PRIjWCh3nIcONFJZ9/i9jIL1Tuhg2hKRoFY8WskdMUW8Qfu4D
 u2mfXsdaVsz3ixQZBjdqArQAV9o=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0f453b.7f7749dea7a0-smtp-out-n01;
 Fri, 03 Jan 2020 13:44:27 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E2B55C433CB; Fri,  3 Jan 2020 13:44:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from govinds-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 54B3FC4479C;
        Fri,  3 Jan 2020 13:44:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 54B3FC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     robh@kernel.org, devicetree@vger.kernel.org,
        ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v3 2/2] ath10k: Don't call SCM interface for statically mapped msa region
Date:   Fri,  3 Jan 2020 19:14:14 +0530
Message-Id: <20200103134414.15457-3-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200103134414.15457-1-govinds@codeaurora.org>
References: <20200103134414.15457-1-govinds@codeaurora.org>
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
index 637f83ef65f8..1b91de70c8d6 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -84,6 +84,9 @@ static int ath10k_qmi_setup_msa_permissions(struct ath10k_qmi *qmi)
 	int ret;
 	int i;
 
+	if (qmi->msa_fixed_perm)
+		return 0;
+
 	for (i = 0; i < qmi->nr_mem_region; i++) {
 		ret = ath10k_qmi_map_msa_permission(qmi, &qmi->mem_region[i]);
 		if (ret)
@@ -102,6 +105,9 @@ static void ath10k_qmi_remove_msa_permission(struct ath10k_qmi *qmi)
 {
 	int i;
 
+	if (qmi->msa_fixed_perm)
+		return;
+
 	for (i = 0; i < qmi->nr_mem_region; i++)
 		ath10k_qmi_unmap_msa_permission(qmi, &qmi->mem_region[i]);
 }
@@ -1018,6 +1024,9 @@ static int ath10k_qmi_setup_msa_resources(struct ath10k_qmi *qmi, u32 msa_size)
 		qmi->msa_mem_size = msa_size;
 	}
 
+	if (of_property_read_bool(dev->of_node, "qcom,msa-fixed-perm"))
+		qmi->msa_fixed_perm = true;
+
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "msa pa: %pad , msa va: 0x%p\n",
 		   &qmi->msa_pa,
 		   qmi->msa_va);
diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
index 40aafb875ed0..dc257375f161 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.h
+++ b/drivers/net/wireless/ath/ath10k/qmi.h
@@ -104,6 +104,7 @@ struct ath10k_qmi {
 	bool fw_ready;
 	char fw_build_timestamp[MAX_TIMESTAMP_LEN + 1];
 	struct ath10k_qmi_cal_data cal_data[MAX_NUM_CAL_V01];
+	bool msa_fixed_perm;
 };
 
 int ath10k_qmi_wlan_enable(struct ath10k *ar,
-- 
2.22.0
