Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E152D2DC1D4
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Dec 2020 15:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbgLPOHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Dec 2020 09:07:38 -0500
Received: from so254-31.mailgun.net ([198.61.254.31]:15632 "EHLO
        so254-31.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726096AbgLPOHi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Dec 2020 09:07:38 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1608127641; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=4UddAqCUG2pExa95WGYuZ8odvOjj9l+IeGMynL3BmO4=; b=X1uM5QfhO4Ibe7+wu6yTRpYjDE9t4YmQFCt3OJB5oSjrSDU7wzfzHtXnzTDY4SoX+W8exRcC
 itfVcPBPwwCWP/IApIVweLI4rX/l9KK9ZXYD3JrB7dZOdm1rMb6FfrzO4WBLGHD/MVAG24eb
 Noyh0RHJ4Keag//tCizrfR0VMWI=
X-Mailgun-Sending-Ip: 198.61.254.31
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fda146e0564dfefcdd5a6dc (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 16 Dec 2020 14:06:38
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9DF9DC43461; Wed, 16 Dec 2020 14:06:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 330EEC433CA;
        Wed, 16 Dec 2020 14:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 330EEC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: qmi: try to allocate a big block of DMA memory first
Date:   Wed, 16 Dec 2020 16:06:33 +0200
Message-Id: <1608127593-15192-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

Not all firmware versions support allocating DMA memory in smaller blocks so
first try to allocate big block of DMA memory for QMI. If the allocation fails,
let firmware request multiple blocks of DMA memory with smaller size.

This also fixes an unnecessary error message seen during ath11k probe on
QCA6390:

ath11k_pci 0000:06:00.0: Respond mem req failed, result: 1, err: 0
ath11k_pci 0000:06:00.0: qmi failed to respond fw mem req:-22

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 24 ++++++++++++++++++++++--
 drivers/net/wireless/ath/ath11k/qmi.h |  1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index f0b5c50974f3..0db623ff4bb9 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1660,6 +1660,7 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	struct qmi_wlanfw_respond_mem_resp_msg_v01 resp;
 	struct qmi_txn txn = {};
 	int ret = 0, i;
+	bool delayed;
 
 	req = kzalloc(sizeof(*req), GFP_KERNEL);
 	if (!req)
@@ -1672,11 +1673,13 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	 * failure to FW and FW will then request mulitple blocks of small
 	 * chunk size memory.
 	 */
-	if (!ab->bus_params.fixed_mem_region && ab->qmi.mem_seg_count <= 2) {
+	if (!ab->bus_params.fixed_mem_region && ab->qmi.target_mem_delayed) {
+		delayed = true;
 		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi delays mem_request %d\n",
 			   ab->qmi.mem_seg_count);
 		memset(req, 0, sizeof(*req));
 	} else {
+		delayed = false;
 		req->mem_seg_len = ab->qmi.mem_seg_count;
 
 		for (i = 0; i < req->mem_seg_len ; i++) {
@@ -1708,6 +1711,12 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 	}
 
 	if (resp.resp.result != QMI_RESULT_SUCCESS_V01) {
+		/* the error response is expected when
+		 * target_mem_delayed is true.
+		 */
+		if (delayed && resp.resp.error == 0)
+			goto out;
+
 		ath11k_warn(ab, "Respond mem req failed, result: %d, err: %d\n",
 			    resp.resp.result, resp.resp.error);
 		ret = -EINVAL;
@@ -1742,6 +1751,8 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 	int i;
 	struct target_mem_chunk *chunk;
 
+	ab->qmi.target_mem_delayed = false;
+
 	for (i = 0; i < ab->qmi.mem_seg_count; i++) {
 		chunk = &ab->qmi.target_mem[i];
 		chunk->vaddr = dma_alloc_coherent(ab->dev,
@@ -1749,6 +1760,15 @@ static int ath11k_qmi_alloc_target_mem_chunk(struct ath11k_base *ab)
 						  &chunk->paddr,
 						  GFP_KERNEL);
 		if (!chunk->vaddr) {
+			if (ab->qmi.mem_seg_count <= 2) {
+				ath11k_dbg(ab, ATH11K_DBG_QMI,
+					   "qmi dma allocation failed (%d B type %u), will try later with small size\n",
+					    chunk->size,
+					    chunk->type);
+				ath11k_qmi_free_target_mem_chunk(ab);
+				ab->qmi.target_mem_delayed = true;
+				return 0;
+			}
 			ath11k_err(ab, "failed to alloc memory, size: 0x%x, type: %u\n",
 				   chunk->size,
 				   chunk->type);
@@ -2517,7 +2537,7 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 				    ret);
 			return;
 		}
-	} else if (msg->mem_seg_len > 2) {
+	} else {
 		ret = ath11k_qmi_alloc_target_mem_chunk(ab);
 		if (ret) {
 			ath11k_warn(ab, "qmi failed to alloc target memory: %d\n",
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 92925c9eac67..7bad374cc23a 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -125,6 +125,7 @@ struct ath11k_qmi {
 	struct target_mem_chunk target_mem[ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01];
 	u32 mem_seg_count;
 	u32 target_mem_mode;
+	bool target_mem_delayed;
 	u8 cal_done;
 	struct target_info target;
 	struct m3_mem_region m3_mem;
-- 
2.7.4

