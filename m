Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55A9E13398F
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Jan 2020 04:20:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgAHDUN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Jan 2020 22:20:13 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:25850 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726142AbgAHDUN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Jan 2020 22:20:13 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1578453612; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=skGoFpTrGWTxWcKwtO7nTwdJjS9VLcXB/IdxoEcY6yI=; b=TBlezwlHgeFzH9eduivWIDs/noyiFJ8TLpvbNXCCzl2Ce6+F/PWDsLjaYKrRRhKYNxkCUNX6
 lXRGgj3nuMK+NqKFa09cmZmlXzHhezUjxM5CPkVH6NpyRc26bjMRi9UNJIBF79WZbSd9CzHt
 rXMv7z0pZ8E0C1jlVUfCcRXZnmw=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e154a69.7f1a7c7ce1b8-smtp-out-n03;
 Wed, 08 Jan 2020 03:20:09 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4AC02C4479F; Wed,  8 Jan 2020 03:20:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0EADDC43383;
        Wed,  8 Jan 2020 03:20:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0EADDC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v4 1/2] ath10k: add refcount for ath10k_core_restart
Date:   Wed,  8 Jan 2020 11:19:56 +0800
Message-Id: <20200108031957.22308-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20200108031957.22308-1-wgong@codeaurora.org>
References: <20200108031957.22308-1-wgong@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When it has more than one restart_work queued meanwhile, the 2nd
restart_work is very esay to break the 1st restart work and lead
recovery fail.

Add a ref count to allow only one restart work running untill
device successfully recovered.

Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.

Signed-off-by: Wen Gong <wgong@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/core.c | 13 +++++++++++++
 drivers/net/wireless/ath/ath10k/core.h |  2 ++
 drivers/net/wireless/ath/ath10k/mac.c  |  1 +
 3 files changed, 16 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 91f131b87efc..0e31846e6c89 100644
--- a/drivers/net/wireless/ath/ath10k/core.c
+++ b/drivers/net/wireless/ath/ath10k/core.c
@@ -2199,6 +2199,14 @@ static void ath10k_core_restart(struct work_struct *work)
 {
 	struct ath10k *ar = container_of(work, struct ath10k, restart_work);
 	int ret;
+	int restart_count;
+
+	restart_count = atomic_add_return(1, &ar->restart_count);
+	if (restart_count > 1) {
+		ath10k_warn(ar, "can not restart, count: %d\n", restart_count);
+		atomic_dec(&ar->restart_count);
+		return;
+	}
 
 	set_bit(ATH10K_FLAG_CRASH_FLUSH, &ar->dev_flags);
 
@@ -2231,6 +2239,11 @@ static void ath10k_core_restart(struct work_struct *work)
 
 	mutex_lock(&ar->conf_mutex);
 
+	if (ar->state != ATH10K_STATE_ON) {
+		ath10k_warn(ar, "state is not on: %d\n", ar->state);
+		atomic_dec(&ar->restart_count);
+	}
+
 	switch (ar->state) {
 	case ATH10K_STATE_ON:
 		ar->state = ATH10K_STATE_RESTARTING;
diff --git a/drivers/net/wireless/ath/ath10k/core.h b/drivers/net/wireless/ath/ath10k/core.h
index e57b2e7235e3..810c99f2dc0e 100644
--- a/drivers/net/wireless/ath/ath10k/core.h
+++ b/drivers/net/wireless/ath/ath10k/core.h
@@ -982,6 +982,8 @@ struct ath10k {
 	/* protected by conf_mutex */
 	u8 ps_state_enable;
 
+	atomic_t restart_count;
+
 	bool nlo_enabled;
 	bool p2p;
 
diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless/ath/ath10k/mac.c
index 3856edba7915..bc1574145e66 100644
--- a/drivers/net/wireless/ath/ath10k/mac.c
+++ b/drivers/net/wireless/ath/ath10k/mac.c
@@ -7208,6 +7208,7 @@ static void ath10k_reconfig_complete(struct ieee80211_hw *hw,
 		ath10k_info(ar, "device successfully recovered\n");
 		ar->state = ATH10K_STATE_ON;
 		ieee80211_wake_queues(ar->hw);
+		atomic_dec(&ar->restart_count);
 	}
 
 	mutex_unlock(&ar->conf_mutex);
-- 
2.23.0
