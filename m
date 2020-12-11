Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED732D7D0B
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Dec 2020 18:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395372AbgLKRhl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Dec 2020 12:37:41 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:15942 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2395377AbgLKRgv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Dec 2020 12:36:51 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607708192; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=8Nb64RVQOvYHeGACHp7hO/PtMyM1Lfitrt9he7u++0Q=; b=xJ3IxIQYarqshYIhZGD7hWAPL1JvB+D+hHLFJlbsbF5duSwuN+XOBdiaaLkoDnlWtpZOiai7
 w3PLch84/+Qtm+RkXCgdacOpl8XfHYL40rH1uWkZgjjLz3fVZKWlsY28ASziIx9m8yJ5vSPF
 F9hCV61Xg+qdptLHYWvuorFB3vk=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 5fd3ae03f81e894c55739b0b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 11 Dec 2020 17:36:03
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 53059C433C6; Fri, 11 Dec 2020 17:36:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 05513C433CA;
        Fri, 11 Dec 2020 17:36:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 05513C433CA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 05/10] ath11k: htc: implement suspend handling
Date:   Fri, 11 Dec 2020 19:35:45 +0200
Message-Id: <1607708150-21066-6-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
References: <1607708150-21066-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Carl Huang <cjhuang@codeaurora.org>

When ath11k sends suspend command to firmware, firmware will
return suspend_complete events and add handlers for those.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/core.c |  2 ++
 drivers/net/wireless/ath/ath11k/core.h |  4 ++++
 drivers/net/wireless/ath/ath11k/htc.c  | 23 ++++++++++++++++++++++-
 drivers/net/wireless/ath/ath11k/htc.h  |  4 +++-
 4 files changed, 31 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/core.c b/drivers/net/wireless/ath/ath11k/core.c
index 3c28e7ad7d51..1c2789ce6239 100644
--- a/drivers/net/wireless/ath/ath11k/core.c
+++ b/drivers/net/wireless/ath/ath11k/core.c
@@ -968,6 +968,8 @@ struct ath11k_base *ath11k_core_alloc(struct device *dev, size_t priv_size,
 	init_waitqueue_head(&ab->qmi.cold_boot_waitq);
 	INIT_WORK(&ab->restart_work, ath11k_core_restart);
 	timer_setup(&ab->rx_replenish_retry, ath11k_ce_rx_replenish_retry, 0);
+	init_completion(&ab->htc_suspend);
+
 	ab->dev = dev;
 	ab->bus_params = *bus_params;
 	ab->hif.bus = bus;
diff --git a/drivers/net/wireless/ath/ath11k/core.h b/drivers/net/wireless/ath/ath11k/core.h
index 3f539cf52690..689aa24fe28f 100644
--- a/drivers/net/wireless/ath/ath11k/core.h
+++ b/drivers/net/wireless/ath/ath11k/core.h
@@ -186,6 +186,7 @@ enum ath11k_dev_flags {
 	ATH11K_FLAG_UNREGISTERING,
 	ATH11K_FLAG_REGISTERED,
 	ATH11K_FLAG_QMI_FAIL,
+	ATH11K_FLAG_HTC_SUSPEND_COMPLETE,
 };
 
 enum ath11k_monitor_flags {
@@ -732,6 +733,9 @@ struct ath11k_base {
 	u32 num_db_cap;
 
 	struct timer_list mon_reap_timer;
+
+	struct completion htc_suspend;
+
 	/* must be last */
 	u8 drv_priv[0] __aligned(sizeof(void *));
 };
diff --git a/drivers/net/wireless/ath/ath11k/htc.c b/drivers/net/wireless/ath/ath11k/htc.c
index 6b57dc273e0b..059b48ded5cc 100644
--- a/drivers/net/wireless/ath/ath11k/htc.c
+++ b/drivers/net/wireless/ath/ath11k/htc.c
@@ -231,6 +231,18 @@ static int ath11k_htc_process_trailer(struct ath11k_htc *htc,
 	return status;
 }
 
+static void ath11k_htc_suspend_complete(struct ath11k_base *ab, bool ack)
+{
+	ath11k_dbg(ab, ATH11K_DBG_BOOT, "boot suspend complete %d\n", ack);
+
+	if (ack)
+		set_bit(ATH11K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
+	else
+		clear_bit(ATH11K_FLAG_HTC_SUSPEND_COMPLETE, &ab->dev_flags);
+
+	complete(&ab->htc_suspend);
+}
+
 void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 				      struct sk_buff *skb)
 {
@@ -328,8 +340,17 @@ void ath11k_htc_rx_completion_handler(struct ath11k_base *ab,
 
 			complete(&htc->ctl_resp);
 			break;
+		case ATH11K_HTC_MSG_SEND_SUSPEND_COMPLETE:
+			ath11k_htc_suspend_complete(ab, true);
+			break;
+		case ATH11K_HTC_MSG_NACK_SUSPEND:
+			ath11k_htc_suspend_complete(ab, false);
+			break;
+		case ATH11K_HTC_MSG_WAKEUP_FROM_SUSPEND_ID:
+			break;
 		default:
-			ath11k_warn(ab, "ignoring unsolicited htc ep0 event\n");
+			ath11k_warn(ab, "ignoring unsolicited htc ep0 event %ld\n",
+				    FIELD_GET(HTC_MSG_MESSAGEID, msg->msg_svc_id));
 			break;
 		}
 		goto out;
diff --git a/drivers/net/wireless/ath/ath11k/htc.h b/drivers/net/wireless/ath/ath11k/htc.h
index 848147cf81ee..6c8a469d7f9d 100644
--- a/drivers/net/wireless/ath/ath11k/htc.h
+++ b/drivers/net/wireless/ath/ath11k/htc.h
@@ -65,7 +65,9 @@ enum ath11k_htc_msg_id {
 	ATH11K_HTC_MSG_CONNECT_SERVICE_RESP_ID = 3,
 	ATH11K_HTC_MSG_SETUP_COMPLETE_ID       = 4,
 	ATH11K_HTC_MSG_SETUP_COMPLETE_EX_ID    = 5,
-	ATH11K_HTC_MSG_SEND_SUSPEND_COMPLETE   = 6
+	ATH11K_HTC_MSG_SEND_SUSPEND_COMPLETE   = 6,
+	ATH11K_HTC_MSG_NACK_SUSPEND	       = 7,
+	ATH11K_HTC_MSG_WAKEUP_FROM_SUSPEND_ID  = 8,
 };
 
 enum ath11k_htc_version {
-- 
2.7.4

