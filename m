Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F16C4244543
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726263AbgHNHKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:10:48 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:44859 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726091AbgHNHKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389046; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=GHrLCReIWSBO6YsruvU0EAJQGUeDytMyuknSGvEGCvM=; b=FUOUwDHBuclVKQiMK4pYyOnFNQ7HsjS8n44HbpnO+s1ATcXnYM2OK5jMdncwFw9RZWHDWRF5
 ne/JvPvKZOr/Ok92D8xtrDRK8wny3JnPGeAB9m4re1h7UX/AN0tBle83Mi4MrbiPD+SCpmDp
 dGjWLuuE6dZUAYInbAL40TL/biw=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5f3638ed668ab3fef6968448 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:37
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DBB10C433CA; Fri, 14 Aug 2020 07:10:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7FE6BC433CB;
        Fri, 14 Aug 2020 07:10:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7FE6BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 01/11] ath11k: add support for m3 firmware
Date:   Fri, 14 Aug 2020 10:10:20 +0300
Message-Id: <1597389030-13887-2-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Govind Singh <govinds@codeaurora.org>

PCI devices like QCA6390 have a separate firmware image for the m3
micro-controller. Add support to load the firmware using m3.bin file.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Govind Singh <govinds@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/ahb.c  |  1 +
 drivers/net/wireless/ath/ath11k/core.h |  1 +
 drivers/net/wireless/ath/ath11k/hw.h   |  1 +
 drivers/net/wireless/ath/ath11k/pci.c  |  1 +
 drivers/net/wireless/ath/ath11k/qmi.c  | 82 +++++++++++++++++++++++++++++++---
 drivers/net/wireless/ath/ath11k/qmi.h  |  7 +++
 6 files changed, 86 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/ahb.c b/drivers/net/wireless/ath/ath11k/ahb.c
index f00c4cc76d74..746e84c4526c 100644
--- a/drivers/net/wireless/ath/ath11k/ahb.c
+++ b/drivers/net/wireless/ath/ath11k/ahb.c
@@ -27,6 +27,7 @@ MODULE_DEVICE_TABLE(of, ath11k_ahb_of_match);
 
 static const struct ath11k_bus_params ath11k_ahb_bus_params = {
 	.mhi_support = false,
+	.m3_fw_support = false,
 };
 
 /* Target firmware's Copy Engine configuration. */
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 0309b13e38c9..b30abd611f0d 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -582,6 +582,7 @@ struct ath11k_board_data {
 
 struct ath11k_bus_params {
 	bool mhi_support;
+	bool m3_fw_support;
 };
 
 /* IPQ8074 HW channel counters frequency value in hertz */
diff --git a/drivers/net/wireless/ath/ath11k/hw.h b/drivers/net/wireless/ath/ath11k/hw.h
index c02fd02839d4..5b443a212c85 100644
--- a/drivers/net/wireless/ath/ath11k/hw.h
+++ b/drivers/net/wireless/ath/ath11k/hw.h
@@ -73,6 +73,7 @@
 #define ATH11K_DEFAULT_BOARD_FILE	"board.bin"
 #define ATH11K_DEFAULT_CAL_FILE		"caldata.bin"
 #define ATH11K_AMSS_FILE		"amss.bin"
+#define ATH11K_M3_FILE			"m3.bin"
 
 enum ath11k_hw_rate_cck {
 	ATH11K_HW_RATE_CCK_LP_11M = 0,
diff --git a/drivers/net/wireless/ath/ath11k/pci.c b/drivers/net/wireless/ath/ath11k/pci.c
index d09faaf747ba..802461d1261a 100644
--- a/drivers/net/wireless/ath/ath11k/pci.c
+++ b/drivers/net/wireless/ath/ath11k/pci.c
@@ -29,6 +29,7 @@ MODULE_DEVICE_TABLE(pci, ath11k_pci_id_table);
 
 static const struct ath11k_bus_params ath11k_pci_bus_params = {
 	.mhi_support = true,
+	.m3_fw_support = true,
 };
 
 static const struct ath11k_msi_config msi_config = {
diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 50812df6527d..0d7441e6ff17 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1516,11 +1516,17 @@ static int ath11k_qmi_host_cap_send(struct ath11k_base *ab)
 	req.bdf_support_valid = 1;
 	req.bdf_support = 1;
 
-	req.m3_support_valid = 0;
-	req.m3_support = 0;
-
-	req.m3_cache_support_valid = 0;
-	req.m3_cache_support = 0;
+	if (ab->bus_params.m3_fw_support) {
+		req.m3_support_valid = 1;
+		req.m3_support = 1;
+		req.m3_cache_support_valid = 1;
+		req.m3_cache_support = 1;
+	} else {
+		req.m3_support_valid = 0;
+		req.m3_support = 0;
+		req.m3_cache_support_valid = 0;
+		req.m3_cache_support = 0;
+	}
 
 	req.cal_done_valid = 1;
 	req.cal_done = ab->qmi.cal_done;
@@ -1908,8 +1914,57 @@ static int ath11k_qmi_load_bdf(struct ath11k_base *ab)
 	return ret;
 }
 
+static int ath11k_qmi_m3_load(struct ath11k_base *ab)
+{
+	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
+	const struct firmware *fw;
+	char path[100];
+	int ret;
+
+	if (m3_mem->vaddr || m3_mem->size)
+		return 0;
+
+	fw = ath11k_core_firmware_request(ab, ATH11K_M3_FILE);
+	if (IS_ERR(fw)) {
+		ret = PTR_ERR(fw);
+		ath11k_core_create_firmware_path(ab, ATH11K_M3_FILE,
+						 path, sizeof(path));
+		ath11k_err(ab, "failed to load %s: %d\n", path, ret);
+		return ret;
+	}
+
+	m3_mem->vaddr = dma_alloc_coherent(ab->dev,
+					   fw->size, &m3_mem->paddr,
+					   GFP_KERNEL);
+	if (!m3_mem->vaddr) {
+		ath11k_err(ab, "failed to allocate memory for M3 with size %zu\n",
+			   fw->size);
+		release_firmware(fw);
+		return -ENOMEM;
+	}
+
+	memcpy(m3_mem->vaddr, fw->data, fw->size);
+	m3_mem->size = fw->size;
+	release_firmware(fw);
+
+	return 0;
+}
+
+static void ath11k_qmi_m3_free(struct ath11k_base *ab)
+{
+	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
+
+	if (!ab->bus_params.m3_fw_support || !m3_mem->vaddr)
+		return;
+
+	dma_free_coherent(ab->dev, m3_mem->size,
+			  m3_mem->vaddr, m3_mem->paddr);
+	m3_mem->vaddr = NULL;
+}
+
 static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 {
+	struct m3_mem_region *m3_mem = &ab->qmi.m3_mem;
 	struct qmi_wlanfw_m3_info_req_msg_v01 req;
 	struct qmi_wlanfw_m3_info_resp_msg_v01 resp;
 	struct qmi_txn txn = {};
@@ -1917,8 +1972,20 @@ static int ath11k_qmi_wlanfw_m3_info_send(struct ath11k_base *ab)
 
 	memset(&req, 0, sizeof(req));
 	memset(&resp, 0, sizeof(resp));
-	req.addr = 0;
-	req.size = 0;
+
+	if (ab->bus_params.m3_fw_support) {
+		ret = ath11k_qmi_m3_load(ab);
+		if (ret) {
+			ath11k_err(ab, "failed to load m3 firmware: %d", ret);
+			return ret;
+		}
+
+		req.addr = m3_mem->paddr;
+		req.size = m3_mem->size;
+	} else {
+		req.addr = 0;
+		req.size = 0;
+	}
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_m3_info_resp_msg_v01_ei, &resp);
@@ -2424,5 +2491,6 @@ void ath11k_qmi_deinit_service(struct ath11k_base *ab)
 	qmi_handle_release(&ab->qmi.handle);
 	cancel_work_sync(&ab->qmi.event_work);
 	destroy_workqueue(ab->qmi.event_wq);
+	ath11k_qmi_m3_free(ab);
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 3307be5be687..dd9e498a2056 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -96,6 +96,12 @@ struct target_info {
 	char fw_build_id[ATH11K_QMI_WLANFW_MAX_BUILD_ID_LEN_V01 + 1];
 };
 
+struct m3_mem_region {
+	u32 size;
+	dma_addr_t paddr;
+	void *vaddr;
+};
+
 struct ath11k_qmi {
 	struct ath11k_base *ab;
 	struct qmi_handle handle;
@@ -110,6 +116,7 @@ struct ath11k_qmi {
 	u32 target_mem_mode;
 	u8 cal_done;
 	struct target_info target;
+	struct m3_mem_region m3_mem;
 };
 
 #define QMI_WLANFW_HOST_CAP_REQ_MSG_V01_MAX_LEN		189
-- 
2.7.4

