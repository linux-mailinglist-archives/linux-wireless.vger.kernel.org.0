Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381DF1ED0E6
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 15:34:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725992AbgFCNea (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 09:34:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:28215 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725836AbgFCNe3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 09:34:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1591191269; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=7x/UvRiWgJpAX06BFIJz9rHjUfD/PoIrfzp1KJclTHM=; b=qbRaPwA6pf3rg8DXM1Wy8awXbZ4qHTYuZ9GM6tyXSKwsv/1o390V9tuHm+C6lpf/q3xU3rO4
 zVD4CIMt+eYfzatIj7x6FPeOA+I69L5pf2D0qhriw+0+ZsFCIlGX8XZC1oaF2pZSl9kB3Zdx
 Dp+0YzptdykQS7uIop65QfuOrS4=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-west-2.postgun.com with SMTP id
 5ed7a6dc9077f356cbeec216 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 03 Jun 2020 13:34:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D3D9C43391; Wed,  3 Jun 2020 13:34:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from dundi-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: govinds)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 596F0C43387;
        Wed,  3 Jun 2020 13:34:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 596F0C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=govinds@codeaurora.org
From:   Govind Singh <govinds@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Govind Singh <govinds@codeaurora.org>
Subject: [PATCH] ath10k: Move msa region map/unmap to init/deinit path
Date:   Wed,  3 Jun 2020 19:03:51 +0530
Message-Id: <1591191231-31917-1-git-send-email-govinds@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

With kernel qrtr switch from user space qrtr, fw crash is seen
during reboot. During reboot modem rproc shutdown causes wlan qmi
service exit and msa region gets unmapped. Since pdev is not suspended
hw still accessing the msa region and this results in  fw crash as
msa region is unmapped.

Decouple msa mapping from wlan qmi server arrive/exit to init/deinit
path.

Testing is pending with "0c2204a4ad71 net: qrtr: Migrate nameservice
to kernel from userspace", only regression sanity performed with user space
qrtr on QCS404/SC7180.

Fixes: 0c2204a4ad71 net: qrtr: Migrate nameservice to kernel from userspace
Signed-off-by: Govind Singh <govinds@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 5ae829b46c3d..8b1291e28ba2 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -796,22 +796,16 @@ static void ath10k_qmi_event_server_arrive(struct ath10k_qmi *qmi)
 	 */
 	msleep(20);
 
-	ret = ath10k_qmi_setup_msa_permissions(qmi);
-	if (ret)
-		return;
-
 	ret = ath10k_qmi_msa_ready_send_sync_msg(qmi);
 	if (ret)
-		goto err_setup_msa;
+		return;
 
 	ret = ath10k_qmi_cap_send_sync_msg(qmi);
 	if (ret)
-		goto err_setup_msa;
+		return;
 
 	return;
 
-err_setup_msa:
-	ath10k_qmi_remove_msa_permission(qmi);
 }
 
 static int ath10k_qmi_fetch_board_file(struct ath10k_qmi *qmi)
@@ -854,7 +848,6 @@ static void ath10k_qmi_event_server_exit(struct ath10k_qmi *qmi)
 	struct ath10k *ar = qmi->ar;
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 
-	ath10k_qmi_remove_msa_permission(qmi);
 	ath10k_core_free_board_files(ar);
 	if (!test_bit(ATH10K_SNOC_FLAG_UNREGISTERING, &ar_snoc->flags))
 		ath10k_snoc_fw_crashed_dump(ar);
@@ -1046,6 +1039,10 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	if (ret)
 		goto err_qmi_lookup;
 
+	ret = ath10k_qmi_setup_msa_permissions(qmi);
+	if (ret)
+		goto err_qmi_lookup;
+
 	return 0;
 
 err_qmi_lookup:
@@ -1064,6 +1061,7 @@ int ath10k_qmi_deinit(struct ath10k *ar)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct ath10k_qmi *qmi = ar_snoc->qmi;
 
+	ath10k_qmi_remove_msa_permission(qmi);
 	qmi_handle_release(&qmi->qmi_hdl);
 	cancel_work_sync(&qmi->event_work);
 	destroy_workqueue(qmi->event_wq);
-- 
2.22.0

