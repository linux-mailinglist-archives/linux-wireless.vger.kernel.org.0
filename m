Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFBE92A93C7
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Nov 2020 11:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgKFKLK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Nov 2020 05:11:10 -0500
Received: from z5.mailgun.us ([104.130.96.5]:46404 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726165AbgKFKLK (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Nov 2020 05:11:10 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604657468; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=bDEzQ1lyrL3NBodqASatSGKGzBBR2Nefr5ygBZoZ6Oo=; b=N2GrM5c6T4/KH0X4rsu2+WUtB4gT4WKfO41b0u2GtjkPPgwqlqOjs8KDhX4WhTf2vVCoYZwY
 e1X7WPYrlvcJ+QHqiWlo5qVxtuIx0pIcodNxdzjbjfT8uIsMePbWcZ5i1N0Ul9+hXtWVrQhc
 8Ep8hvvklYTdPKH0N/gXfndeYKE=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5fa5212c1baf490ee957318e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 06 Nov 2020 10:10:52
 GMT
Sender: vnaralas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 02599C433F0; Fri,  6 Nov 2020 10:10:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: vnaralas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 265EBC433CB;
        Fri,  6 Nov 2020 10:10:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 265EBC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=vnaralas@codeaurora.org
From:   Venkateswara Naralasetty <vnaralas@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Venkateswara Naralasetty <vnaralas@codeaurora.org>
Subject: [PATCH] ath10k: add target IRAM recovery feature support
Date:   Fri,  6 Nov 2020 15:40:42 +0530
Message-Id: <1604657442-23674-1-git-send-email-vnaralas@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This target IRAM recovery feature support is to copy target
IRAM contents available at ATH10K_MEM_REGION_TYPE_REG to host
memory for back up after firmware loaded. Target IRAM contents
are copied to wmi memory chunks allocated for the
WMI_IRAM_RECOVERY_HOST_MEM_REQ_ID and provide the wmi chunks
address to the firmware through wmi init command.

If firmware detects andy IRAM corruption through periodic
checksum validation, It will download the IRAM contents back
from the provided wmi memory chunks address using hif_memcpy.

This IRAM recovery feature prevent target assert in case of
unexpected target IRAM corruptions.

This patch also introduce a new feature flag 'iram-recovery' for
backward compatibility.

Tested-on: QCA9888 10.4-3.9.0.2-00094

Signed-off-by: Venkateswara Naralasetty <vnaralas@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 83 ++++++++++++++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/core.h |  3 ++
 drivers/net/wireless/ath/ath10k/wmi.h  |  2 +
 3 files changed, 88 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 419b06b..796107b 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -651,6 +651,7 @@ static const char *const ath10k_core_fw_feature_str[] = {
 	[ATH10K_FW_FEATURE_NON_BMI] = "non-bmi",
 	[ATH10K_FW_FEATURE_SINGLE_CHAN_INFO_PER_CHANNEL] = "single-chan-info-per-channel",
 	[ATH10K_FW_FEATURE_PEER_FIXED_RATE] = "peer-fixed-rate",
+	[ATH10K_FW_FEATURE_IRAM_RECOVERY] = "iram-recovery",
 };
 
 static unsigned int ath10k_core_get_fw_feature_str(char *buf,
@@ -2604,6 +2605,78 @@ static int ath10k_core_compat_services(struct ath10k *ar)
 	return 0;
 }
 
+#define TGT_IRAM_READ_PER_ITR (8 * 1024)
+
+static int ath10k_core_copy_target_iram(struct ath10k *ar)
+{
+	const struct ath10k_hw_mem_layout *hw_mem;
+	const struct ath10k_mem_region *tmp, *mem_region = NULL;
+	dma_addr_t paddr;
+	void *vaddr = NULL;
+	u8 num_read_itr;
+	int i, ret;
+	u32 len, remaining_len;
+
+	hw_mem = ath10k_coredump_get_mem_layout(ar);
+	if (!hw_mem)
+		return -ENOMEM;
+
+	for (i = 0; i < hw_mem->region_table.size; i++) {
+		tmp = &hw_mem->region_table.regions[i];
+		if (tmp->type == ATH10K_MEM_REGION_TYPE_REG) {
+			mem_region = tmp;
+			break;
+		}
+	}
+
+	if (!mem_region)
+		return -ENOMEM;
+
+	for (i = 0; i < ar->wmi.num_mem_chunks; i++) {
+		if (ar->wmi.mem_chunks[i].req_id ==
+		    WMI_IRAM_RECOVERY_HOST_MEM_REQ_ID) {
+			vaddr = ar->wmi.mem_chunks[i].vaddr;
+			len = ar->wmi.mem_chunks[i].len;
+			break;
+		}
+	}
+
+	if (!vaddr || !len) {
+		ath10k_warn(ar, "No allocated memory for IRAM back up");
+		return -ENOMEM;
+	}
+
+	len = (len < mem_region->len) ? len : mem_region->len;
+	paddr = mem_region->start;
+	num_read_itr = len / TGT_IRAM_READ_PER_ITR;
+	remaining_len = len % TGT_IRAM_READ_PER_ITR;
+	for (i = 0; i < num_read_itr; i++) {
+		ret = ath10k_hif_diag_read(ar, paddr, vaddr,
+					   TGT_IRAM_READ_PER_ITR);
+		if (ret) {
+			ath10k_warn(ar, "failed to copy firmware IRAM contents: %d",
+				    ret);
+			return ret;
+		}
+
+		paddr += TGT_IRAM_READ_PER_ITR;
+		vaddr += TGT_IRAM_READ_PER_ITR;
+	}
+
+	if (remaining_len) {
+		ret = ath10k_hif_diag_read(ar, paddr, vaddr, remaining_len);
+		if (ret) {
+			ath10k_warn(ar, "failed to copy firmware IRAM contents: %d",
+				    ret);
+			return ret;
+		}
+	}
+
+	ath10k_dbg(ar, ATH10K_DBG_BOOT, "target IRAM back up completed\n");
+
+	return 0;
+}
+
 int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 		      const struct ath10k_fw_components *fw)
 {
@@ -2765,6 +2838,16 @@ int ath10k_core_start(struct ath10k *ar, enum ath10k_firmware_mode mode,
 	ath10k_dbg(ar, ATH10K_DBG_BOOT, "firmware %s booted\n",
 		   ar->hw->wiphy->fw_version);
 
+	if (test_bit(ATH10K_FW_FEATURE_IRAM_RECOVERY,
+		     ar->running_fw->fw_file.fw_features)) {
+		status = ath10k_core_copy_target_iram(ar);
+		if (status) {
+			ath10k_warn(ar, "failed to copy target iram contents: %d",
+				    status);
+			goto err_hif_stop;
+		}
+	}
+
 	if (test_bit(WMI_SERVICE_EXT_RES_CFG_SUPPORT, ar->wmi.svc_map) &&
 	    mode == ATH10K_FIRMWARE_MODE_NORMAL) {
 		val = 0;
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index b50ab9e..12b10bb 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -829,6 +829,9 @@ enum ath10k_fw_features {
 	/* Firmware allows setting peer fixed rate */
 	ATH10K_FW_FEATURE_PEER_FIXED_RATE = 21,
 
+	/* Firmware support IRAM recovery */
+	ATH10K_FW_FEATURE_IRAM_RECOVERY = 22,
+
 	/* keep last */
 	ATH10K_FW_FEATURE_COUNT,
 };
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 11300b1..c32aabe 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -3060,6 +3060,8 @@ struct host_memory_chunk {
 	__le32 size;
 } __packed;
 
+#define WMI_IRAM_RECOVERY_HOST_MEM_REQ_ID 8
+
 struct wmi_host_mem_chunks {
 	__le32 count;
 	/* some fw revisions require at least 1 chunk regardless of count */
-- 
2.7.4

