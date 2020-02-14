Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 94B3715D417
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 09:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728691AbgBNIvI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 03:51:08 -0500
Received: from mail27.static.mailgun.info ([104.130.122.27]:38052 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728513AbgBNIvI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 03:51:08 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581670267; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/rM8vyh91dkEc2sLEeFt7hkeEpN6F/5GKCLGaEuBU+w=; b=BOQ0SXlzbmbsziE/k97cZYuqtjG2HNKx8qr77s4e/4/+Mnbn947LQ+DuFQs9u5CWh2+Wu2u1
 TFZS+s8UvsP0FmIHeWH6Iwoxk/0zhEeJU4AJv8z8v6WrQm5jrOnh9kutMFvEQNe36dY5Jlk3
 lzA7sSnM2PexVd+hHRzPMnfumKo=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e465f76.7f1ee3edd298-smtp-out-n03;
 Fri, 14 Feb 2020 08:51:02 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A67A2C433A2; Fri, 14 Feb 2020 08:51:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from yintang-HP-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yintang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 354CEC447A0;
        Fri, 14 Feb 2020 08:51:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 354CEC447A0
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yintang@codeaurora.org
From:   Yingying Tang <yintang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH v2] ath10k: fix unsupported chip reset debugs file write
Date:   Fri, 14 Feb 2020 16:51:18 +0800
Message-Id: <1581670278-5682-1-git-send-email-yintang@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Before this change, after writing "warm_hw_reset" debugfs file, host
will send chip reset command to FW even though FW do not support this
service getting a warning print.

Though there is no FW impact before this change, this patch restricts
chip reset command sent to FW only if FW advertises the support via WMI
service bit.

Removed the redundant check and ath10k_warn() print as well.

New version FW will report chip reset service bit to host. Host allow user
to trigger WLAN chip reset only when fw report this service bit.

For older NON-TLV FW, since it do not report chip reset service bit, host
will not send chip reset command. For older TLV FW, since it report chip
reset service bit, host will send chip reset command.

Tested HW:  QCA9984, WCN3990

QCA9984 FW version: WLAN.BL.3.9.0.2-00042-S-1

Signed-off-by: Yingying Tang <yintang@codeaurora.org>
---
 drivers/net/wireless/ath/ath10k/debug.c | 9 ++++-----
 drivers/net/wireless/ath/ath10k/wmi.h   | 7 +++++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 3894b77..f811e69 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -2373,9 +2373,6 @@ static ssize_t ath10k_write_warm_hw_reset(struct file *file,
 		goto exit;
 	}
 
-	if (!(test_bit(WMI_SERVICE_RESET_CHIP, ar->wmi.svc_map)))
-		ath10k_warn(ar, "wmi service for reset chip is not available\n");
-
 	ret = ath10k_wmi_pdev_set_param(ar, ar->wmi.pdev_param->pdev_reset,
 					WMI_RST_MODE_WARM_RESET);
 
@@ -2650,8 +2647,10 @@ int ath10k_debug_register(struct ath10k *ar)
 				    ar->debug.debugfs_phy, ar,
 				    &fops_tpc_stats_final);
 
-	debugfs_create_file("warm_hw_reset", 0600, ar->debug.debugfs_phy, ar,
-			    &fops_warm_hw_reset);
+	if (test_bit(WMI_SERVICE_RESET_CHIP, ar->wmi.svc_map))
+		debugfs_create_file("warm_hw_reset", 0600,
+				    ar->debug.debugfs_phy, ar,
+				    &fops_warm_hw_reset);
 
 	debugfs_create_file("ps_state_enable", 0600, ar->debug.debugfs_phy, ar,
 			    &fops_ps_state_enable);
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 972d53d..6df4157 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -371,6 +371,11 @@ enum wmi_10_4_service {
 	WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
 	WMI_10_4_SERVICE_REPORT_AIRTIME,
 	WMI_10_4_SERVICE_TX_PWR_PER_PEER,
+	WMI_10_4_SERVICE_FETCH_PEER_TX_PN,
+	WMI_10_4_SERVICE_MULTIPLE_VDEV_RESTART,
+	WMI_10_4_SERVICE_ENHANCED_RADIO_COUNTERS,
+	WMI_10_4_SERVICE_QINQ_SUPPORT,
+	WMI_10_4_SERVICE_RESET_CHIP,
 };
 
 static inline char *wmi_service_name(enum wmi_service service_id)
@@ -827,6 +832,8 @@ static inline void wmi_10_4_svc_map(const __le32 *in, unsigned long *out,
 	       WMI_SERVICE_REPORT_AIRTIME, len);
 	SVCMAP(WMI_10_4_SERVICE_TX_PWR_PER_PEER,
 	       WMI_SERVICE_TX_PWR_PER_PEER, len);
+	SVCMAP(WMI_10_4_SERVICE_RESET_CHIP,
+	       WMI_SERVICE_RESET_CHIP, len);
 }
 
 #undef SVCMAP
-- 
1.9.1
