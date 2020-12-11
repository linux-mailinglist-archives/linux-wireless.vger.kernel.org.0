Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BE202D7D07
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:38:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405326AbgLKRh0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:37:26 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:16826 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395372AbgLKRgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:49 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708189; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=fOKlcm0yeo/eaCgxXTF4CSaKLB/YYqfHC+bQtxw+pdA=; b=RF/S1TVdG4Q9iYYnIfiywl5Vhq4RQOtB+OQ4nE3NBe16cU1N55RsE7J1sA1XG7KIzziFgRDE
 FW9Ffixm4ezw5X8rYQf1Z5jE5T1CT8ClDrj7eECYap0UcH5Lw6yMkX3+1rcvzOLO0vJ1Qfh1
 dvJ1eKJjxVSq9Y29YfemaSM5Mig=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5fd3ae01f81e894c55739368 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:01
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C4553C433C6; Fri, 11 Dec 2020 17:36:00 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97CC2C433ED;
        Fri, 11 Dec 2020 17:35:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97CC2C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 04/10] ath11k: htc: remove unused struct ath11k_htc_ops
Date:   Fri, 11 Dec 2020 19:35:44 +0200
Message-Id: <1607708150-21066-5-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

No need for it so remove. Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/htc.h | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index f0a3387567ca..848147cf81ee 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -221,10 +221,6 @@ enum ath11k_htc_ep_id {
 	ATH11K_HTC_EP_COUNT,
 };
 
-struct ath11k_htc_ops {
-	void (*target_send_suspend_complete)(struct ath11k_base *ar);
-};
-
 struct ath11k_htc_ep_ops {
 	void (*ep_tx_complete)(struct ath11k_base *, struct sk_buff *);
 	void (*ep_rx_complete)(struct ath11k_base *, struct sk_buff *);
@@ -284,8 +280,6 @@ struct ath11k_htc {
 	/* protects endpoints */
 	spinlock_t tx_lock;
 
-	struct ath11k_htc_ops htc_ops;
-
 	u8 control_resp_buffer[ATH11K_HTC_MAX_CTRL_MSG_LEN];
 	int control_resp_len;
 
-- 
2.7.4

