Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 955A812D76A
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2019 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726407AbfLaJ2T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Dec 2019 04:28:19 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:13947 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725770AbfLaJ2T (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Dec 2019 04:28:19 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1577784498; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=6OnxIaY/89F6bOipfAHJuWOXROI71sCyvwXMZk88A9M=; b=AlHgZzp5t0PojAPi5Q9teKxfUVjfJMNyV13pldCrohdIpQ5VZYzcGT2ExIOpH9fqk6KVPDlH
 +Dbv8+6HuHXTlo8e4ZDsxnP43su+EUVqQ92LQgCGZe7/WTajdrvQH/I2nCyiYPsGQNTcZisz
 Mdsn1jrgkS77gy+myOvAT7vdEhk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e0b14b1.7f3279dfffb8-smtp-out-n03;
 Tue, 31 Dec 2019 09:28:17 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 62453C4479C; Tue, 31 Dec 2019 09:28:16 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from wgong-HP-Z240-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: wgong)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 68BCBC43383;
        Tue, 31 Dec 2019 09:28:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 68BCBC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=wgong@codeaurora.org
From:   Wen Gong <wgong@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v3 1/2] ath10k: add refcount for ath10k_core_restart
Date:   Tue, 31 Dec 2019 17:28:05 +0800
Message-Id: <20191231092806.6247-2-wgong@codeaurora.org>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20191231092806.6247-1-wgong@codeaurora.org>
References: <20191231092806.6247-1-wgong@codeaurora.org>
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
 drivers/net/wireless/ath/ath10k/core.c | 8 ++++++++
 drivers/net/wireless/ath/ath10k/core.h | 2 ++
 drivers/net/wireless/ath/ath10k/mac.c  | 1 +
 3 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/ath10k/core.c b/drivers/net/wireless/ath/ath10k/core.c
index 91f131b87efc..9439e575ec63 100644
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
