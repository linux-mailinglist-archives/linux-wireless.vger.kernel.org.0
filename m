Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2AAD1C4EEC
	for <lists+linux-wireless@lfdr.de>; Tue,  5 May 2020 09:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728220AbgEEHSL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 May 2020 03:18:11 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:53627 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727849AbgEEHSI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 May 2020 03:18:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588663088; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=FHvKSwOq7HDlR/x83tultcrCPZZOptkuScQLeJFruww=; b=dy8gI5MmD7QIhHZJxCSC3F+8JL7jA+HJKZMJ7gPAByILctaJYFbiglWXXyiuuULdhLcVXGU9
 0xFJfqs6REo9BrGT5QgRyPRTgb/Hd6ENb4dMTHv2tGiRD0lUFBYLXqUt7rS2IpTMpxopWHAs
 h+7Qncml/NbJYnLU7dei36ovCxA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb11321.7fdbc0f4c6f8-smtp-out-n03;
 Tue, 05 May 2020 07:17:53 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 83413C433F2; Tue,  5 May 2020 07:17:53 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 19569C433D2;
        Tue,  5 May 2020 07:17:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 19569C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH] ath10k: Skip handling del_server during driver exit
Date:   Tue,  5 May 2020 12:47:41 +0530
Message-Id: <1588663061-12138-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The qmi infrastructure sends the client a del_server
event when the client releases its qmi handle. This
is not the msg indicating the actual qmi server exiting.
In such cases the del_server msg should not be processed,
since the wifi firmware does not reset its qmi state.

Hence skip the processing of del_server event when the
driver is unloading.

Tested HW: WCN3990
Tested FW: WLAN.HL.3.1-01040-QCAHLSWMTPLZ-1

Fixes: ba94c753ccb4 ("ath10k: add QMI message handshake for wcn3990 client")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/qmi.c | 13 ++++++++++++-
 drivers/net/wireless/ath/ath10k/qmi.h |  6 ++++++
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath10k/qmi.c b/drivers/net/wireless/ath/ath10k/qmi.c
index 85dce43..7abdef8 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.c
+++ b/drivers/net/wireless/ath/ath10k/qmi.c
@@ -961,7 +961,16 @@ static void ath10k_qmi_del_server(struct qmi_handle *qmi_hdl,
 		container_of(qmi_hdl, struct ath10k_qmi, qmi_hdl);
 
 	qmi->fw_ready = false;
-	ath10k_qmi_driver_event_post(qmi, ATH10K_QMI_EVENT_SERVER_EXIT, NULL);
+
+	/*
+	 * The del_server event is to be processed only if coming from
+	 * the qmi server. The qmi infrastructure sends del_server, when
+	 * any client releases the qmi handle. In this case do not process
+	 * this del_server event.
+	 */
+	if (qmi->state == ATH10K_QMI_STATE_INIT_DONE)
+		ath10k_qmi_driver_event_post(qmi, ATH10K_QMI_EVENT_SERVER_EXIT,
+					     NULL);
 }
 
 static struct qmi_ops ath10k_qmi_ops = {
@@ -1091,6 +1100,7 @@ int ath10k_qmi_init(struct ath10k *ar, u32 msa_size)
 	if (ret)
 		goto err_qmi_lookup;
 
+	qmi->state = ATH10K_QMI_STATE_INIT_DONE;
 	return 0;
 
 err_qmi_lookup:
@@ -1109,6 +1119,7 @@ int ath10k_qmi_deinit(struct ath10k *ar)
 	struct ath10k_snoc *ar_snoc = ath10k_snoc_priv(ar);
 	struct ath10k_qmi *qmi = ar_snoc->qmi;
 
+	qmi->state = ATH10K_QMI_STATE_DEINIT;
 	qmi_handle_release(&qmi->qmi_hdl);
 	cancel_work_sync(&qmi->event_work);
 	destroy_workqueue(qmi->event_wq);
diff --git a/drivers/net/wireless/ath/ath10k/qmi.h b/drivers/net/wireless/ath/ath10k/qmi.h
index dc25737..b597205 100644
--- a/drivers/net/wireless/ath/ath10k/qmi.h
+++ b/drivers/net/wireless/ath/ath10k/qmi.h
@@ -83,6 +83,11 @@ struct ath10k_qmi_driver_event {
 	void *data;
 };
 
+enum ath10k_qmi_state {
+	ATH10K_QMI_STATE_INIT_DONE,
+	ATH10K_QMI_STATE_DEINIT,
+};
+
 struct ath10k_qmi {
 	struct ath10k *ar;
 	struct qmi_handle qmi_hdl;
@@ -105,6 +110,7 @@ struct ath10k_qmi {
 	char fw_build_timestamp[MAX_TIMESTAMP_LEN + 1];
 	struct ath10k_qmi_cal_data cal_data[MAX_NUM_CAL_V01];
 	bool msa_fixed_perm;
+	enum ath10k_qmi_state state;
 };
 
 int ath10k_qmi_wlan_enable(struct ath10k *ar,
-- 
2.7.4
