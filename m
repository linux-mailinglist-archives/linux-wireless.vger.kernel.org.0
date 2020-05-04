Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBC6B1C388F
	for <lists+linux-wireless@lfdr.de>; Mon,  4 May 2020 13:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgEDLqn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 May 2020 07:46:43 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:37573 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726756AbgEDLqn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 May 2020 07:46:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588592802; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=itZcaWNzM3nzullpeoEtG5NsmBpw6axwfV5igTCJRn0=; b=pxP0prpErncXqTz5ZvyZ9krb2AmFmqlu3K35dCBvlJqcrO9g5lpTBhDhSc1rBMPumBklh1Jt
 BI/JLgalv0akR8ClGTzk/rk/8yX+pUdwcEQ8lMSdy0ygfc5XwnYUDPS6Rg4avTEFddvT3e26
 Zi5p+YdDXWdkHXoyyszQkVqJhgM=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb00091.7feb8c7735a8-smtp-out-n02;
 Mon, 04 May 2020 11:46:25 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 14E24C432C2; Mon,  4 May 2020 11:46:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: ssreeela)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 47D87C433BA;
        Mon,  4 May 2020 11:46:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 47D87C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=ssreeela@codeaurora.org
From:   Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
Subject: [PATCH] ath11k: fix resource unavailability for htt stats after peer stats display
Date:   Mon,  4 May 2020 17:15:55 +0530
Message-Id: <1588592755-10427-1-git-send-email-ssreeela@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

htt stats are not working after htt peer stats display
and also after htt peer stats reset. Trying to dump htt 
stats shows "Resource temporarily unavailable".
This is because of "ar->debug.htt_stats.stats_req" member is being
consecutively used for all htt stats without being reset 
during the previous usage. Hence assigning NULL to this member 
after freeing the allocated memory fixes the issue.

console logs below:
# echo 9 >/sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats_type
# cat /sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats_type
9
# cat /sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats
cat: can't open '/sys/kernel/debug/ath11k/ipq8074/mac1/htt_stats'
: Resource temporarily unavailable

Signed-off-by: Sowmiya Sree Elavalagan <ssreeela@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/debugfs_sta.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/debugfs_sta.c b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
index 389dac2..696ff14 100644
--- a/drivers/net/wireless/ath/ath11k/debugfs_sta.c
+++ b/drivers/net/wireless/ath/ath11k/debugfs_sta.c
@@ -435,13 +435,22 @@ ath11k_dbg_sta_open_htt_peer_stats(struct inode *inode, struct file *file)
 	return 0;
 out:
 	vfree(stats_req);
+	ar->debug.htt_stats.stats_req = NULL;
 	return ret;
 }
 
 static int
 ath11k_dbg_sta_release_htt_peer_stats(struct inode *inode, struct file *file)
 {
+	struct ieee80211_sta *sta = inode->i_private;
+	struct ath11k_sta *arsta = (struct ath11k_sta *)sta->drv_priv;
+	struct ath11k *ar = arsta->arvif->ar;
+
+	mutex_lock(&ar->conf_mutex);
 	vfree(file->private_data);
+	ar->debug.htt_stats.stats_req = NULL;
+	mutex_unlock(&ar->conf_mutex);
+
 	return 0;
 }
 
-- 
2.7.4
