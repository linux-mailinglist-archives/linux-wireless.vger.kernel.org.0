Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 944C6F6D8E
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2019 05:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726902AbfKKEZU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Nov 2019 23:25:20 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:36264 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbfKKEZU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Nov 2019 23:25:20 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id EACA960B72; Mon, 11 Nov 2019 04:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573446318;
        bh=RcK9pHRRt96unH/MIVK4xHvAlRqDPAqVKYYnTuF0V+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lb/StXWiya9IlBVHPCMkqlBIpHpBnc+sGFseeR3b7q7Fq+hDZEJiF8rSKCjyBfZ/h
         TrviiH5t6XBfKhHI8ui8ddlsDdXewWja6DeQqSOQnHY9DR28C9w8Ffg1Hz3NpsPJQC
         UEoV3b0eFrDorzyQv/qDidF8Xevxyf/E/B5aONYU=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F33B66092C;
        Mon, 11 Nov 2019 04:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1573446318;
        bh=RcK9pHRRt96unH/MIVK4xHvAlRqDPAqVKYYnTuF0V+Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lb/StXWiya9IlBVHPCMkqlBIpHpBnc+sGFseeR3b7q7Fq+hDZEJiF8rSKCjyBfZ/h
         TrviiH5t6XBfKhHI8ui8ddlsDdXewWja6DeQqSOQnHY9DR28C9w8Ffg1Hz3NpsPJQC
         UEoV3b0eFrDorzyQv/qDidF8Xevxyf/E/B5aONYU=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F33B66092C
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v2 2/2] ath10k: Don't call SCM interface for statically mapped msa region
Date:   Mon, 11 Nov 2019 09:55:08 +0530
Message-Id: <20191111042508.12628-3-govinds@codeaurora.org>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20191111042508.12628-1-govinds@codeaurora.org>
References: <20191111042508.12628-1-govinds@codeaurora.org>
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
index 637f83ef65f8..40ffc444ab7b 100644
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
 
+	if (of_property_read_bool(dev->of_node, "qcom,msa_fixed_perm"))
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

