Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4A13B1CD
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Jun 2019 11:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388802AbfFJJSH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 Jun 2019 05:18:07 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:34560 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388218AbfFJJSH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 Jun 2019 05:18:07 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 32FD16074C; Mon, 10 Jun 2019 09:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560158286;
        bh=KprkNffYsw2j7JclhNw1CuiK8pEBzkZ2nitrCsD/ths=;
        h=From:To:Cc:Subject:Date:From;
        b=TNJuV6CpupFWIYEVYv+IYbizxoQ+T4GFnF/PIzOfyjXUUzVGmj/PNZjAnM/oMakwJ
         /3GhfMijeZnVlDzvJfQbZwT6fttnTTHMvSV7wfTEqTkY+iWYSnQz3ToHY/P75fu7gY
         SIWJBD3YC60tKU18jA2kFkW3iaeNjF1ZNr3I1I4E=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 6C179602FE;
        Mon, 10 Jun 2019 09:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1560158285;
        bh=KprkNffYsw2j7JclhNw1CuiK8pEBzkZ2nitrCsD/ths=;
        h=From:To:Cc:Subject:Date:From;
        b=gzvFM/c3k/Am6qZcOZvAdFkaN2kTZDaWCrDwbAnppUyyA6VwjAT0yGCJ1inLN/bM4
         fRccvIGUuRghQmRfaVtV8Sr+Kh2dG1B0w3SUYLdMKEcecCaDCTHp/jwGzWeDSUiT9S
         WBBMEdaR6XSrJ028IB5gfkCzfqyXjK7ZUG8GsI1c=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 6C179602FE
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH v3] ath10k: Enable MSA region dump support for WCN3990
Date:   Mon, 10 Jun 2019 14:47:59 +0530
Message-Id: <20190610091759.29508-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

MSA memory region caries the hw descriptors information.
Dump MSA region in core dump as this is very helpful in debugging
hw issues.

Testing: Tested on WCN3990 HW
Tested FW: WLAN.HL.3.1-00959-QCAHLSWMTPLZ-1

Signed-off-by: Govind Singh <govinds@codeaurora.org>

---
Changes from v2:
- Rebased on top of 38faed150438 ath10k: perform crash dump collection in workqueue.
- Removed redundant msa permission call.
---
 drivers/net/wireless/ath/ath10k/coredump.c | 21 +++++++
 drivers/net/wireless/ath/ath10k/coredump.h |  1 +
 drivers/net/wireless/ath/ath10k/qmi.c      |  4 ++
 drivers/net/wireless/ath/ath10k/snoc.c     | 66 ++++++++++++++++++++++
 drivers/net/wireless/ath/ath10k/snoc.h     |  1 +
 5 files changed, 93 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/coredump.c b/drivers/net/wireless/ath/ath10k/coredump.c
index aa04fbf146e0..0ec690b49fb1 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.c
+++ b/drivers/net/wireless/ath/ath10k/coredump.c
@@ -962,6 +962,19 @@ static const struct ath10k_mem_region qca4019_hw10_mem_regions[] = {
 	},
 };
 
+static const struct ath10k_mem_region wcn399x_hw10_mem_regions[] = {
+	{
+		/* MSA region start is not fixed, hence it is assigned at runtime */
+		.type = ATH10K_MEM_REGION_TYPE_MSA,
+		.len = 0x100000,
+		.name = "DRAM",
+		.section_table = {
+			.sections = NULL,
+			.size = 0,
+		},
+	},
+};
+
 static const struct ath10k_hw_mem_layout hw_mem_layouts[] = {
 	{
 		.hw_id = QCA6174_HW_1_0_VERSION,
@@ -1059,6 +1072,14 @@ static const struct ath10k_hw_mem_layout hw_mem_layouts[] = {
 			.size = ARRAY_SIZE(qca4019_hw10_mem_regions),
 		},
 	},
+	{
+		.hw_id = WCN3990_HW_1_0_DEV_VERSION,
+		.hw_rev = ATH10K_HW_WCN3990,
+		.region_table = {
+			.regions = wcn399x_hw10_mem_regions,
+			.size = ARRAY_SIZE(wcn399x_hw10_mem_regions),
+		},
+	},
 };
 
 static u32 ath10k_coredump_get_ramdump_size(struct ath10k *ar)
diff --git a/drivers/net/wireless/ath/ath10k/coredump.h b/drivers/net/wireless/ath/ath10k/coredump.h
index 5dac653e1649..9802e90483f4 100644
--- a/drivers/net/wireless/ath/ath10k/coredump.h
+++ b/drivers/net/wireless/ath/ath10k/coredump.h
@@ -126,6 +126,7 @@ enum ath10k_mem_region_type {
 	ATH10K_MEM_REGION_TYPE_IRAM2	= 5,
 	ATH10K_MEM_REGION_TYPE_IOSRAM	= 6,
 	ATH10K_MEM_REGION_TYPE_IOREG	= 7,
+	ATH10K_MEM_REGION_TYPE_MSA	= 8,
 };
 
 /* Define a section of the region which should be copied. As not all parts
diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index ba8f5a8f83d1..8eb0f0f0d3a7 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -817,9 +817,13 @@ ath10k_qmi_driver_event_post(struct ath10k_qmi *qmi,
 static void ath10k_qmi_event_server_exit(struct ath10k_qmi *qmi)
 {
 	struct ath10k *ar = qmi->ar;
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
 	ath10k_qmi_remove_msa_permission(qmi);
 	ath10k_core_free_board_files(ar);
+	if (!test_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags))
+		ath10k_snoc_fw_crashed_dump(ar);
+
 	ath10k_snoc_fw_indication(ar, ATH10K_QMI_EVENT_FW_DOWN_IND);
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "wifi fw qmi service disconnected\n");
 }
diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 0be12996beba..ecc0f884b123 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -24,6 +24,7 @@
 #include <linux/regulator/consumer.h>
 
 #include "ce.h"
+#include "coredump.h"
 #include "debug.h"
 #include "hif.h"
 #include "htc.h"
@@ -1586,6 +1587,71 @@ static int ath10k_hw_power_off(struct ath10k *ar)
 	return ret;
 }
 
+static void ath10k_msa_dump_memory(struct ath10k *ar,
+				   struct ath10k_fw_crash_data *crash_data)
+{
+	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
+	const struct ath10k_hw_mem_layout *mem_layout;
+	const struct ath10k_mem_region *current_region;
+	struct ath10k_dump_ram_data_hdr *hdr;
+	size_t buf_len;
+	u8 *buf;
+
+	if (!crash_data && !crash_data->ramdump_buf)
+		return;
+
+	mem_layout = ath10k_coredump_get_mem_layout(ar);
+	if (!mem_layout)
+		return;
+
+	current_region = &mem_layout->region_table.regions[0];
+
+	buf = crash_data->ramdump_buf;
+	buf_len = crash_data->ramdump_buf_len;
+	memset(buf, 0, buf_len);
+
+	/* Reserve space for the header. */
+	hdr = (void *)buf;
+	buf += sizeof(*hdr);
+	buf_len -= sizeof(*hdr);
+
+	hdr->region_type = cpu_to_le32(current_region->type);
+	hdr->start = cpu_to_le32(ar_snoc->qmi->msa_va);
+	hdr->length = cpu_to_le32(ar_snoc->qmi->msa_mem_size);
+
+	if (current_region->len < ar_snoc->qmi->msa_mem_size) {
+		memcpy(buf, ar_snoc->qmi->msa_va, current_region->len);
+		ath10k_warn(ar, "msa dump length is less than msa size %x, %x\n",
+			    current_region->len, ar_snoc->qmi->msa_mem_size);
+	} else {
+		memcpy(buf, ar_snoc->qmi->msa_va, ar_snoc->qmi->msa_mem_size);
+	}
+}
+
+void ath10k_snoc_fw_crashed_dump(struct ath10k *ar)
+{
+	struct ath10k_fw_crash_data *crash_data;
+	char guid[UUID_STRING_LEN + 1];
+
+	mutex_lock(&ar->dump_mutex);
+
+	spin_lock_bh(&ar->data_lock);
+	ar->stats.fw_crash_counter++;
+	spin_unlock_bh(&ar->data_lock);
+
+	crash_data = ath10k_coredump_new(ar);
+
+	if (crash_data)
+		scnprintf(guid, sizeof(guid), "%pUl", &crash_data->guid);
+	else
+		scnprintf(guid, sizeof(guid), "n/a");
+
+	ath10k_err(ar, "firmware crashed! (guid %s)\n", guid);
+	ath10k_print_driver_info(ar);
+	ath10k_msa_dump_memory(ar, crash_data);
+	mutex_unlock(&ar->dump_mutex);
+}
+
 static const struct of_device_id ath10k_snoc_dt_match[] = {
 	{ .compatible = "qcom,wcn3990-wifi",
 	 .data = &drv_priv,
diff --git a/drivers/net/wireless/ath/ath10k/snoc.h b/drivers/net/wireless/ath/ath10k/snoc.h
index 25383de8f17d..6d28a6290a94 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.h
+++ b/drivers/net/wireless/ath/ath10k/snoc.h
@@ -101,5 +101,6 @@ static inline struct ath10k_snoc *ath10k_snoc_priv(struct ath10k *ar)
 }
 
 int ath10k_snoc_fw_indication(struct ath10k *ar, u64 type);
+void ath10k_snoc_fw_crashed_dump(struct ath10k *ar);
 
 #endif /* _SNOC_H_ */
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

