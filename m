Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ADA5C7C048
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 13:42:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727221AbfGaLmb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 07:42:31 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:53270 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbfGaLmb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 07:42:31 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id F3FAF60907; Wed, 31 Jul 2019 11:42:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564573350;
        bh=ogVQDO12SawzTxJX9ZUztmWfkhG5Pw/7rGll6TPcbxU=;
        h=From:To:Cc:Subject:Date:From;
        b=jbcghzzFOM409qoWLV/fN0AFNeuQ1HjH4QDGfspYo4QGSnuHNd92OwCU2I6BbRr4G
         /iL7NSvKMiLn2X7/uL2NH26mXCFRKHejA0b8Csuzh0I+kFJjcLF/iGxMQRNQv/P1Mn
         pDhx6MzviXM5B9XskgEtX6V/Zw1nvoNkeqttqcCk=
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
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4E3B0605A5;
        Wed, 31 Jul 2019 11:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564573349;
        bh=ogVQDO12SawzTxJX9ZUztmWfkhG5Pw/7rGll6TPcbxU=;
        h=From:To:Cc:Subject:Date:From;
        b=KhAA48/01mr4c+gQqQdVn+YrJpPss95Xoun8kftMlWkQJNkVudRYI2qyN8WD5tWR7
         6inIKxsJ33+Z/zR0crzbxb9apA5FtYavURvXaIjatL7MaJ2murZ3n/vxOO8myKY4Cx
         8BTxRVOKMjyKIwXG8Q6676d+y7ixrQs3JTpclzpk=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4E3B0605A5
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] ath10k: revalidate the msa region coming from firmware
Date:   Wed, 31 Jul 2019 17:12:20 +0530
Message-Id: <20190731114220.22830-1-govinds@codeaurora.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

driver sends QMI_WLFW_MSA_INFO_REQ_V01 QMI request to firmware
and in response expects range of addresses and size to be mapped.
Add condition to check whether addresses in response falls
under valid range otherwise return failure.

Testing: Tested on WCN3990 HW
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 2e678780df5d..3457509a003f 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -111,6 +111,7 @@ static int ath10k_qmi_msa_mem_info_send_sync_msg(struct ath10k_qmi *qmi)
 	struct wlfw_msa_info_resp_msg_v01 resp = {};
 	struct wlfw_msa_info_req_msg_v01 req = {};
 	struct ath10k *ar = qmi->ar;
+	phys_addr_t max_mapped_addr;
 	struct qmi_txn txn;
 	int ret;
 	int i;
@@ -150,8 +151,20 @@ static int ath10k_qmi_msa_mem_info_send_sync_msg(struct ath10k_qmi *qmi)
 		goto out;
 	}
 
+	max_mapped_addr = qmi->msa_pa + qmi->msa_mem_size;
 	qmi->nr_mem_region = resp.mem_region_info_len;
 	for (i = 0; i < resp.mem_region_info_len; i++) {
+		if (resp.mem_region_info[i].size > qmi->msa_mem_size ||
+		    resp.mem_region_info[i].region_addr > max_mapped_addr ||
+		    resp.mem_region_info[i].region_addr < qmi->msa_pa ||
+		    resp.mem_region_info[i].size +
+		    resp.mem_region_info[i].region_addr > max_mapped_addr) {
+			ath10k_err(ar, "received out of range memory region address 0x%llx with size 0x%x, aborting\n",
+				   resp.mem_region_info[i].region_addr,
+				   resp.mem_region_info[i].size);
+			ret = -EINVAL;
+			goto fail_unwind;
+		}
 		qmi->mem_region[i].addr = resp.mem_region_info[i].region_addr;
 		qmi->mem_region[i].size = resp.mem_region_info[i].size;
 		qmi->mem_region[i].secure = resp.mem_region_info[i].secure_flag;
@@ -165,6 +178,8 @@ static int ath10k_qmi_msa_mem_info_send_sync_msg(struct ath10k_qmi *qmi)
 	ath10k_dbg(ar, ATH10K_DBG_QMI, "qmi msa mem info request completed\n");
 	return 0;
 
+fail_unwind:
+	memset(&qmi->mem_region[0], 0, sizeof(qmi->mem_region[0]) * i);
 out:
 	return ret;
 }
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

