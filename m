Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 726EA1526CE
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2020 08:27:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726386AbgBEH1W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Feb 2020 02:27:22 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:49676 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725468AbgBEH1W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Feb 2020 02:27:22 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580887641; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=a6928noU/VpV2+yVNNNmairirn+k6UvpBHK3xJkoj4g=; b=qiW6ILA3+qfAErMByd6uh/iD/pd4BDvov2d1BZFVosL0LqvdgvAI3jjFddCe/mnGCwpikK25
 JxTDrkl8UcdPagQeDB2owJJcdX+AHt5hLl5qgZR56nr/zQsH+QzwTaN+uZkfDyXl/WLOfLCf
 ap3zvIRkeS6Y631SzACgszywZqU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a6e57.7fcd16a29420-smtp-out-n02;
 Wed, 05 Feb 2020 07:27:19 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8667DC43383; Wed,  5 Feb 2020 07:27:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from yintang-HP-Z230-SFF-Workstation.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: yintang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BC12C433CB;
        Wed,  5 Feb 2020 07:27:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BC12C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=yintang@codeaurora.org
From:   Yingying Tang <yintang@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath10k: fix unsupported chip reset debugs file write
Date:   Wed,  5 Feb 2020 15:27:24 +0800
Message-Id: <1580887644-21061-1-git-send-email-yintang@codeaurora.org>
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
 drivers/net/wireless/ath/ath10k/wmi.h   | 8 ++++++++
 2 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/debug.c b/drivers/net/wireless/ath/ath10k/debug.c
index 32d967a..4cec1a85 100644
--- a/drivers/net/wireless/ath/ath10k/debug.c
+++ b/drivers/net/wireless/ath/ath10k/debug.c
@@ -2365,9 +2365,6 @@ static ssize_t ath10k_write_warm_hw_reset(struct file *file,
 		goto exit;
 	}
 
-	if (!(test_bit(WMI_SERVICE_RESET_CHIP, ar->wmi.svc_map)))
-		ath10k_warn(ar, "wmi service for reset chip is not available\n");
-
 	ret = ath10k_wmi_pdev_set_param(ar, ar->wmi.pdev_param->pdev_reset,
 					WMI_RST_MODE_WARM_RESET);
 
@@ -2603,8 +2600,10 @@ int ath10k_debug_register(struct ath10k *ar)
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
index e1c40bb..d753924 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -367,6 +367,12 @@ enum wmi_10_4_service {
 	WMI_10_4_SERVICE_RTT_RESPONDER_ROLE,
 	WMI_10_4_SERVICE_EXT_PEER_TID_CONFIGS_SUPPORT,
 	WMI_10_4_SERVICE_REPORT_AIRTIME,
+	WMI_10_4_SERVICE_TX_PWR_PER_PEER,
+	WMI_10_4_SERVICE_FETCH_PEER_TX_PN,
+	WMI_10_4_SERVICE_MULTIPLE_VDEV_RESTART,
+	WMI_10_4_SERVICE_ENHANCED_RADIO_COUNTERS,
+	WMI_10_4_SERVICE_QINQ_SUPPORT,
+	WMI_10_4_SERVICE_RESET_CHIP,
 };
 
 static inline char *wmi_service_name(enum wmi_service service_id)
@@ -818,6 +824,8 @@ static inline void wmi_10_4_svc_map(const __le32 *in, unsigned long *out,
 	       WMI_SERVICE_PER_PACKET_SW_ENCRYPT, len);
 	SVCMAP(WMI_10_4_SERVICE_REPORT_AIRTIME,
 	       WMI_SERVICE_REPORT_AIRTIME, len);
+	SVCMAP(WMI_10_4_SERVICE_RESET_CHIP,
+	       WMI_SERVICE_RESET_CHIP, len);
 }
 
 #undef SVCMAP
-- 
1.9.1
