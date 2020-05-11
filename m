Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77E391CE26F
	for <lists+linux-wireless@lfdr.de>; Mon, 11 May 2020 20:18:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgEKSSS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 May 2020 14:18:18 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:51535 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729643AbgEKSSS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 May 2020 14:18:18 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589221097; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=JY3ILg7vIXB79YPJ6cGMNDLdWDP72SfZJEWhtz2m34o=; b=EvctMXK3CM3nza6CqMd7CZUn/cGXiu7Cup4Z5O+O/0d4HNvkNuhCpQaKDuBmqyvzR/XoMBgf
 zZSk6HOtEx1T0mZ/qcDG3miNUrZ7Y9Jge3Kc7R5jd63AQUXoXmtA88QASCsAHG/e3wL+IVHf
 zqofeqZRvKSr+ZISw6G7UKfFqIw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb996dd.7f93a7e575a8-smtp-out-n04;
 Mon, 11 May 2020 18:18:05 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9C631C433BA; Mon, 11 May 2020 18:18:05 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.0
Received: from pradeepc-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E7AA9C433F2;
        Mon, 11 May 2020 18:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E7AA9C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>,
        Miles Hu <milehu@codeaurora.org>
Subject: [PATCH v2] ath11k: fix htt stats module not handle multiple skbs
Date:   Mon, 11 May 2020 11:17:54 -0700
Message-Id: <1589221074-28778-1-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

HTT EXT stats comes in stream of TLVs spanning over multiple
messages. Currently completion is being sent for each message
which is creating a race where stats_req is being accessed
for filling in second message after the memory is already
freed in release operation. Fix this by issuing completion
once all the messages are received and processed. Driver
knows this info from DONE bit set in htt msg.

Also fix locking required for htt stats.

Co-developed-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
v2:
 - fix kbot reported issue of missing unlock

 drivers/net/wireless/ath/ath11k/debug_htt_stats.c | 48 ++++++++++++++++++-----
 drivers/net/wireless/ath/ath11k/dp.h              |  1 +
 2 files changed, 39 insertions(+), 10 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
index 5db0c27de475..6b532dc99c98 100644
--- a/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
+++ b/drivers/net/wireless/ath/ath11k/debug_htt_stats.c
@@ -4306,6 +4306,7 @@ void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
 	u32 len;
 	u64 cookie;
 	int ret;
+	bool send_completion = false;
 	u8 pdev_id;
 
 	msg = (struct ath11k_htt_extd_stats_msg *)skb->data;
@@ -4330,11 +4331,11 @@ void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
 		return;
 
 	spin_lock_bh(&ar->debug.htt_stats.lock);
-	if (stats_req->done) {
-		spin_unlock_bh(&ar->debug.htt_stats.lock);
-		return;
-	}
-	stats_req->done = true;
+
+	stats_req->done = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_DONE, msg->info1);
+	if (stats_req->done)
+		send_completion = true;
+
 	spin_unlock_bh(&ar->debug.htt_stats.lock);
 
 	len = FIELD_GET(HTT_T2H_EXT_STATS_INFO1_LENGTH, msg->info1);
@@ -4344,7 +4345,8 @@ void ath11k_dbg_htt_ext_stats_handler(struct ath11k_base *ab,
 	if (ret)
 		ath11k_warn(ab, "Failed to parse tlv %d\n", ret);
 
-	complete(&stats_req->cmpln);
+	if (send_completion)
+		complete(&stats_req->cmpln);
 }
 
 static ssize_t ath11k_read_htt_stats_type(struct file *file,
@@ -4497,28 +4499,54 @@ static int ath11k_open_htt_stats(struct inode *inode, struct file *file)
 	if (type == ATH11K_DBG_HTT_EXT_STATS_RESET)
 		return -EPERM;
 
+	mutex_lock(&ar->conf_mutex);
+
+	if (ar->state != ATH11K_STATE_ON) {
+		ret = -ENETDOWN;
+		goto err_unlock;
+	}
+
+	if (ar->debug.htt_stats.stats_req) {
+		ret = -EAGAIN;
+		goto err_unlock;
+	}
+
 	stats_req = vzalloc(sizeof(*stats_req) + ATH11K_HTT_STATS_BUF_SIZE);
-	if (!stats_req)
-		return -ENOMEM;
+	if (!stats_req) {
+		ret = -ENOMEM;
+		goto err_unlock;
+	}
 
-	mutex_lock(&ar->conf_mutex);
 	ar->debug.htt_stats.stats_req = stats_req;
 	stats_req->type = type;
+
 	ret = ath11k_dbg_htt_stats_req(ar);
-	mutex_unlock(&ar->conf_mutex);
 	if (ret < 0)
 		goto out;
 
 	file->private_data = stats_req;
+
+	mutex_unlock(&ar->conf_mutex);
+
 	return 0;
 out:
 	vfree(stats_req);
+	ar->debug.htt_stats.stats_req = NULL;
+err_unlock:
+	mutex_unlock(&ar->conf_mutex);
+
 	return ret;
 }
 
 static int ath11k_release_htt_stats(struct inode *inode, struct file *file)
 {
+	struct ath11k *ar = inode->i_private;
+
+	mutex_lock(&ar->conf_mutex);
 	vfree(file->private_data);
+	ar->debug.htt_stats.stats_req = NULL;
+	mutex_unlock(&ar->conf_mutex);
+
 	return 0;
 }
 
diff --git a/drivers/net/wireless/ath/ath11k/dp.h b/drivers/net/wireless/ath/ath11k/dp.h
index 222de10e4b93..058a5c1d86ff 100644
--- a/drivers/net/wireless/ath/ath11k/dp.h
+++ b/drivers/net/wireless/ath/ath11k/dp.h
@@ -1517,6 +1517,7 @@ struct htt_ext_stats_cfg_params {
  *       4 bytes.
  */
 
+#define HTT_T2H_EXT_STATS_INFO1_DONE	BIT(11)
 #define HTT_T2H_EXT_STATS_INFO1_LENGTH   GENMASK(31, 16)
 
 struct ath11k_htt_extd_stats_msg {
-- 
1.9.1
