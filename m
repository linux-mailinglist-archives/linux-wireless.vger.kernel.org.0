Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 066D924454A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726302AbgHNHLB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:11:01 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:16270 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgHNHKy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:54 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389053; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=mY5wgJEqcKurXzP8QMEbYyxCC3/jCR7LIa81vf5VQY0=; b=rcum7g6C7nRklZS3/tRsBa/LgwoTIEjTOaOkmOHDPLu+lcxJFenr27gwoxVcQ30dsBwznuT+
 CNXPW2xKX5T4yGPEVdASvHsjGQIAg7z88ztxfohn2fXuUO4LtDOsvYoLhAzMAdKBa4nuT3+6
 Uts20r6ty1bCh1k+BBCUwWlL57E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 5f3638ee2889723bf891a18e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:38
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9EB2AC433C9; Fri, 14 Aug 2020 07:10:38 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32F0DC433C6;
        Fri, 14 Aug 2020 07:10:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 32F0DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 02/11] ath11k: add board file support for PCI devices
Date:   Fri, 14 Aug 2020 10:10:21 +0300
Message-Id: <1597389030-13887-3-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

PCI devices like QCA6390 load the board file differently, add support for that
and the method is chosen using bus_params variables.

Add support to create board name for different targets.  This board name is
used to parse the board data from board-2.bin for ahb/pci based targets.

As struct target_mem_chunk::vaddr was changed from 'u32' to 'u32 *' in
ath11k_qmi_assign_target_mem_chunk() vaddr assignments were changed to NULL to
avoid a compilation warning. IPQ8074 does not use the vaddr field for anything
so that change does not affect functionality.

At the moment this only supports board files with BIN type. Support for ELF
type, which seems to be more popular on QCA6390 devices, needs to be added later.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |   2 +
 drivers/net/wireless/ath/ath11k/core.c |   7 +-
 drivers/net/wireless/ath/ath11k/core.h |  15 ++++
 drivers/net/wireless/ath/ath11k/pci.c  |   2 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 144 +++++++++++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.h  |   7 +-
 6 files changed, 167 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index 746e84c4526c..06e599cbfbf9 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -28,6 +28,8 @@ MODULE_DEVICE_TABLE(of, ath11k_ahb_of_match);
 static const struct ath11k_bus_params ath11k_ahb_bus_params = {
 	.mhi_support = false,
 	.m3_fw_support = false,
+	.fixed_bdf_addr = true,
+	.fixed_mem_region = true,
 };
 
 /* Target firmware's Copy Engine configuration. */
diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 22657dac7749..a3a53debc24f 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -50,11 +50,9 @@ static const struct ath11k_hw_params ath11k_hw_params[] = {
 static int ath11k_core_create_board_name(struct ath11k_base *ab, char *name,
 					 size_t name_len)
 {
-	/* Note: bus is fixed to ahb. When other bus type supported,
-	 * make it to dynamic.
-	 */
 	scnprintf(name, name_len,
-		  "bus=ahb,qmi-chip-id=%d,qmi-board-id=%d",
+		  "bus=%s,qmi-chip-id=%d,qmi-board-id=%d",
+		  ath11k_bus_str(ab->hif.bus),
 		  ab->qmi.target.chip_id,
 		  ab->qmi.target.board_id);
 
@@ -853,6 +851,7 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
 	ab->dev = dev;
 	ab->bus_params = *bus_params;
+	ab->hif.bus = bus;
 
 	return ab;
 
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index b30abd611f0d..6e351e7bded8 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -583,6 +583,8 @@ struct ath11k_board_data {
 struct ath11k_bus_params {
 	bool mhi_support;
 	bool m3_fw_support;
+	bool fixed_bdf_addr;
+	bool fixed_mem_region;
 };
 
 /* IPQ8074 HW channel counters frequency value in hertz */
@@ -647,6 +649,7 @@ struct ath11k_base {
 	unsigned long mem_len;
 
 	struct {
+		enum ath11k_bus bus;
 		const struct ath11k_hif_ops *ops;
 	} hif;
 
@@ -905,4 +908,16 @@ static inline void ath11k_core_create_firmware_path(struct ath11k_base *ab,
 		 ab->hw_params.fw.dir, filename);
 }
 
+static inline const char *ath11k_bus_str(enum ath11k_bus bus)
+{
+	switch (bus) {
+	case ATH11K_BUS_PCI:
+		return "pci";
+	case ATH11K_BUS_AHB:
+		return "ahb";
+	}
+
+	return "unknown";
+}
+
 #endif /* _CORE_H_ */
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index 802461d1261a..dd3122b47d35 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -30,6 +30,8 @@ MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 static const struct ath11k_bus_params ath11k_pci_bus_params = {
 	.mhi_support = true,
 	.m3_fw_support = true,
+	.fixed_bdf_addr = false,
+	.fixed_mem_region = false,
 };
 
 static const struct ath11k_msi_config msi_config = {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0d7441e6ff17..b182d6181057 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1680,15 +1680,56 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	return ret;
 }
 
+static void ath11k_qmi_free_target_mem_chunk(struct ath11k_base *ab)
+{
+	int i;
+
+	if (ab->bus_params.fixed_mem_region)
+		return;
+
+	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		if (!ab->qmi.target_mem[i].vaddr)
+			continue;
+
+		dma_free_coherent(ab->dev,
+				  ab->qmi.target_mem[i].size,
+				  ab->qmi.target_mem[i].vaddr,
+				  ab->qmi.target_mem[i].paddr);
+		ab->qmi.target_mem[i].vaddr = NULL;
+	}
+}
+
 static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 {
+	int i;
+	struct target_mem_chunk *chunk;
+
+	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
+		chunk = &ab->qmi.target_mem[i];
+		chunk->vaddr = dma_alloc_coherent(ab->dev,
+						  chunk->size,
+						  &chunk->paddr,
+						  GFP_KERNEL);
+		if (!chunk->vaddr) {
+			ath11k_err(ab, "failed to alloc memory, size: 0x%x, type: %u\n",
+				   chunk->size,
+				   chunk->type);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static int ath11k_qmi_assign_target_mem_chunk(struct ath11k_base *ab)
+{
 	int i, idx;
 
 	for (i = 0, idx = 0; i < ab->qmi.mem_seg_count; i++) {
 		switch (ab->qmi.target_mem[i].type) {
 		case BDF_MEM_REGION_TYPE:
 			ab->qmi.target_mem[idx].paddr = ab->hw_params.bdf_addr;
-			ab->qmi.target_mem[idx].vaddr = ab->hw_params.bdf_addr;
+			ab->qmi.target_mem[idx].vaddr = NULL;
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -1700,7 +1741,7 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 			}
 			/* TODO ath11k does not support cold boot calibration */
 			ab->qmi.target_mem[idx].paddr = 0;
-			ab->qmi.target_mem[idx].vaddr = 0;
+			ab->qmi.target_mem[idx].vaddr = NULL;
 			ab->qmi.target_mem[idx].size = ab->qmi.target_mem[i].size;
 			ab->qmi.target_mem[idx].type = ab->qmi.target_mem[i].type;
 			idx++;
@@ -1842,7 +1883,7 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 	return ret;
 }
 
-static int ath11k_qmi_load_bdf(struct ath11k_base *ab)
+static int ath11k_qmi_load_bdf_fixed_addr(struct ath11k_base *ab)
 {
 	struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
 	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
@@ -1914,6 +1955,92 @@ static int ath11k_qmi_load_bdf(struct ath11k_base *ab)
 	return ret;
 }
 
+static int ath11k_qmi_load_bdf_qmi(struct ath11k_base *ab)
+{
+	struct qmi_wlanfw_bdf_download_req_msg_v01 *req;
+	struct qmi_wlanfw_bdf_download_resp_msg_v01 resp;
+	struct ath11k_board_data bd;
+	unsigned int remaining;
+	struct qmi_txn txn = {};
+	int ret;
+	const u8 *temp;
+
+	req = kzalloc(sizeof(*req), GFP_KERNEL);
+	if (!req)
+		return -ENOMEM;
+	memset(&resp, 0, sizeof(resp));
+
+	memset(&bd, 0, sizeof(bd));
+	ret = ath11k_core_fetch_bdf(ab, &bd);
+	if (ret) {
+		ath11k_warn(ab, "qmi failed to load bdf:\n");
+		goto out;
+	}
+
+	temp = bd.data;
+	remaining = bd.len;
+
+	while (remaining) {
+		req->valid = 1;
+		req->file_id_valid = 1;
+		req->file_id = ab->qmi.target.board_id;
+		req->total_size_valid = 1;
+		req->total_size = bd.len;
+		req->seg_id_valid = 1;
+		req->data_valid = 1;
+		req->data_len = ATH11K_QMI_MAX_BDF_FILE_NAME_SIZE;
+		req->bdf_type = ATH11K_QMI_BDF_TYPE_BIN;
+		req->bdf_type_valid = 1;
+		req->end_valid = 1;
+		req->end = 0;
+
+		if (remaining > QMI_WLANFW_MAX_DATA_SIZE_V01) {
+			req->data_len = QMI_WLANFW_MAX_DATA_SIZE_V01;
+		} else {
+			req->data_len = remaining;
+			req->end = 1;
+		}
+
+		memcpy(req->data, temp, req->data_len);
+
+		ret = qmi_txn_init(&ab->qmi.handle, &txn,
+				   qmi_wlanfw_bdf_download_resp_msg_v01_ei,
+				   &resp);
+		if (ret < 0)
+			goto out_qmi_bdf;
+
+		ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
+				       QMI_WLANFW_BDF_DOWNLOAD_REQ_V01,
+				       QMI_WLANFW_BDF_DOWNLOAD_REQ_MSG_V01_MAX_LEN,
+				       qmi_wlanfw_bdf_download_req_msg_v01_ei, req);
+		if (ret < 0) {
+			qmi_txn_cancel(&txn);
+			goto out_qmi_bdf;
+		}
+
+		ret = qmi_txn_wait(&txn, msecs_to_jiffies(ATH11K_QMI_WLANFW_TIMEOUT_MS));
+		if (ret < 0)
+			goto out_qmi_bdf;
+
+		if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+			ath11k_warn(ab, "qmi BDF download failed, result: %d, err: %d\n",
+				    resp.resp.result, resp.resp.error);
+			ret = resp.resp.result;
+			goto out_qmi_bdf;
+		}
+		remaining -= req->data_len;
+		temp += req->data_len;
+		req->seg_id++;
+	}
+
+out_qmi_bdf:
+	ath11k_core_free_bdf(ab, &bd);
+
+out:
+	kfree(req);
+	return ret;
+}
+
 static int ath11k_qmi_m3_load(struct ath11k_base *ab)
 {
 	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
@@ -2242,7 +2369,10 @@ static void ath11k_qmi_event_load_bdf(struct ath11k_qmi *qmi)
 		return;
 	}
 
-	ret = ath11k_qmi_load_bdf(ab);
+	if (ab->bus_params.fixed_bdf_addr)
+		ret = ath11k_qmi_load_bdf_fixed_addr(ab);
+	else
+		ret = ath11k_qmi_load_bdf_qmi(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to load board data file:%d\n", ret);
 		return;
@@ -2281,7 +2411,10 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
-	ret = ath11k_qmi_alloc_target_mem_chunk(ab);
+	if (ab->bus_params.fixed_mem_region)
+		ret = ath11k_qmi_assign_target_mem_chunk(ab);
+	else
+		ret = ath11k_qmi_alloc_target_mem_chunk(ab);
 	if (ret < 0) {
 		ath11k_warn(ab, "qmi failed to alloc target memory:%d\n", ret);
 		return;
@@ -2492,5 +2625,6 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
 	ath11k_qmi_m3_free(ab);
+	ath11k_qmi_free_target_mem_chunk(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index dd9e498a2056..cd484a4d0216 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -40,6 +40,11 @@ enum ath11k_qmi_file_type {
 	ATH11K_QMI_MAX_FILE_TYPE,
 };
 
+enum ath11k_qmi_bdf_type {
+	ATH11K_QMI_BDF_TYPE_BIN			= 0,
+	ATH11K_QMI_BDF_TYPE_ELF			= 1,
+};
+
 enum ath11k_qmi_event_type {
 	ATH11K_QMI_EVENT_SERVER_ARRIVE,
 	ATH11K_QMI_EVENT_SERVER_EXIT,
@@ -83,7 +88,7 @@ struct target_mem_chunk {
 	u32 size;
 	u32 type;
 	dma_addr_t paddr;
-	u32 vaddr;
+	u32 *vaddr;
 };
 
 struct target_info {
-- 
2.7.4

