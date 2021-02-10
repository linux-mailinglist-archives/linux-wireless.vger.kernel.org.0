Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFE631615F
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Feb 2021 09:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230483AbhBJIrT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 10 Feb 2021 03:47:19 -0500
Received: from so15.mailgun.net ([198.61.254.15]:38100 "EHLO so15.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230197AbhBJIng (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 10 Feb 2021 03:43:36 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1612946585; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=/y1H7m8tiDjR3yJ22JTzktykL76/exVvECpFNFsT0PE=; b=g8GqJC4AS/G+Iln86HSFxTbPbMbi4KPrrDFQgJL6F+xMTnRdx0zJUSxJvoEVgfECBc1zU+nu
 bjJdVsJaBJs1U95eTD9xFWYTexopfu1bBQ0ZFNyPK2s8/8poXCBvdAQQ9dHVJXb2A81V+Ex1
 j/YNakHclTghk/RJzyzvghy7EpI=
X-Mailgun-Sending-Ip: 198.61.254.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 60239c75f112b7872c63f419 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 10 Feb 2021 08:42:29
 GMT
Sender: akolli=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 463F0C433ED; Wed, 10 Feb 2021 08:42:29 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from vnaralas-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akolli)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8F3EFC433C6;
        Wed, 10 Feb 2021 08:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8F3EFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=akolli@codeaurora.org
From:   Anilkumar Kolli <akolli@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Anilkumar Kolli <akolli@codeaurora.org>
Subject: [PATCH 03/11] ath11k: qmi: increase the number of fw segments
Date:   Wed, 10 Feb 2021 14:12:02 +0530
Message-Id: <1612946530-28504-4-git-send-email-akolli@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
References: <1612946530-28504-1-git-send-email-akolli@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

QCN9074 firmware uses 20MB of HOST DDR memory, fw requests
the memory in segmnets of size 1MB/512KB/256KB.
Increase the number of fw memory segments to 52.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1.r2-00012-QCAHKSWPL_SILICONZ-1

Signed-off-by: Anilkumar Kolli <akolli@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index 7bad374cc23a..1797c3b59f48 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -23,7 +23,7 @@
 #define ATH11K_QMI_WLFW_SERVICE_INS_ID_V01_IPQ8074	0x02
 #define ATH11K_QMI_WLANFW_MAX_TIMESTAMP_LEN_V01	32
 #define ATH11K_QMI_RESP_LEN_MAX			8192
-#define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	32
+#define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	52
 #define ATH11K_QMI_CALDB_SIZE			0x480000
 #define ATH11K_QMI_BDF_EXT_STR_LENGTH		0x20
 
@@ -216,8 +216,8 @@ struct qmi_wlanfw_ind_register_resp_msg_v01 {
 	u64 fw_status;
 };
 
-#define QMI_WLANFW_REQUEST_MEM_IND_MSG_V01_MAX_LEN	1124
-#define QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN	548
+#define QMI_WLANFW_REQUEST_MEM_IND_MSG_V01_MAX_LEN	1824
+#define QMI_WLANFW_RESPOND_MEM_REQ_MSG_V01_MAX_LEN	888
 #define QMI_WLANFW_RESPOND_MEM_RESP_MSG_V01_MAX_LEN	7
 #define QMI_WLANFW_REQUEST_MEM_IND_V01			0x0035
 #define QMI_WLANFW_RESPOND_MEM_REQ_V01			0x0036
-- 
2.7.4

