Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36BBA244544
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Aug 2020 09:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726278AbgHNHKu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Aug 2020 03:10:50 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:29707 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726006AbgHNHKu (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Aug 2020 03:10:50 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597389049; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=VUfWrl6bEWh9+CnFbDm0LA8PMKMOmwAyMBTQq64DLdA=; b=uT31d/Xg12/SAMHOASY6XNpeGE3lSVL+qBjHJMKOEdcadV0iKPKHwcN2SDgvg5aOb+UNSN//
 dNEWDcBqv3VCNYoR7f/IQVhyilEtk1jIUdigML2WLe1K9S8Qugpzhc8DmiQvcDopSMKJIZ4+
 mOETNWmzLd/FdXLtsRiaEzk/XuY=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f3638f51e4d3989d4b99f4a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 14 Aug 2020 07:10:45
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B47D9C433C9; Fri, 14 Aug 2020 07:10:44 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7B5CDC433CA;
        Fri, 14 Aug 2020 07:10:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7B5CDC433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 07/11] ath11k: allocate smaller chunks of memory for firmware
Date:   Fri, 14 Aug 2020 10:10:26 +0300
Message-Id: <1597389030-13887-8-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
References: <1597389030-13887-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

On x86 it's sometimes difficult to allocate a large contigous DMA
memory, so instead allocate blocks of small chunk memory.

In ath11k_qmi_msg_mem_request_cb() the error handling was cleaned up to avoid
an unused variable warning. Also changed the test from (ret < 0) to just (ret)
as the functions don't return any positive values.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 42 +++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index acf7a3f2fe77..b386ab4bd806 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1640,19 +1640,30 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 
 	memset(&resp, 0, sizeof(resp));
 
-	req->mem_seg_len = ab->qmi.mem_seg_count;
+	/* For QCA6390 by default FW requests a block of ~4M contiguous
+	 * DMA memory, it's hard to allocate from OS. So host returns
+	 * failure to FW and FW will then request mulitple blocks of small
+	 * chunk size memory.
+	 */
+	if (!ab->bus_params.fixed_mem_region && ab->qmi.mem_seg_count <= 2) {
+		ath11k_dbg(ab, ATH11K_DBG_QMI, "qmi delays mem_request %d\n",
+			   ab->qmi.mem_seg_count);
+		memset(req, 0, sizeof(*req));
+	} else {
+		req->mem_seg_len = ab->qmi.mem_seg_count;
+
+		for (i = 0; i < req->mem_seg_len ; i++) {
+			req->mem_seg[i].addr = ab->qmi.target_mem[i].paddr;
+			req->mem_seg[i].size = ab->qmi.target_mem[i].size;
+			req->mem_seg[i].type = ab->qmi.target_mem[i].type;
+		}
+	}
 
 	ret = qmi_txn_init(&ab->qmi.handle, &txn,
 			   qmi_wlanfw_respond_mem_resp_msg_v01_ei, &resp);
 	if (ret < 0)
 		goto out;
 
-	for (i = 0; i < req->mem_seg_len ; i++) {
-		req->mem_seg[i].addr = ab->qmi.target_mem[i].paddr;
-		req->mem_seg[i].size = ab->qmi.target_mem[i].size;
-		req->mem_seg[i].type = ab->qmi.target_mem[i].type;
-	}
-
 	ret = qmi_send_request(&ab->qmi.handle, NULL, &txn,
 			       QMI_WLANFW_RESPOND_MEM_REQ_V01,
 			       QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN,
@@ -2411,13 +2422,20 @@ static void ath11k_qmi_msg_mem_request_cb(struct qmi_handle *qmi_hdl,
 			   msg->mem_seg[i].type, msg->mem_seg[i].size);
 	}
 
-	if (ab->bus_params.fixed_mem_region)
+	if (ab->bus_params.fixed_mem_region) {
 		ret = ath11k_qmi_assign_target_mem_chunk(ab);
-	else
+		if (ret) {
+			ath11k_warn(ab, "qmi failed to assign target memory: %d\n",
+				    ret);
+			return;
+		}
+	} else if (msg->mem_seg_len > 2) {
 		ret = ath11k_qmi_alloc_target_mem_chunk(ab);
-	if (ret < 0) {
-		ath11k_warn(ab, "qmi failed to alloc target memory:%d\n", ret);
-		return;
+		if (ret) {
+			ath11k_warn(ab, "qmi failed to alloc target memory: %d\n",
+				    ret);
+			return;
+		}
 	}
 
 	ath11k_qmi_driver_event_post(qmi, ATH11K_QMI_EVENT_REQUEST_MEM, NULL);
-- 
2.7.4

