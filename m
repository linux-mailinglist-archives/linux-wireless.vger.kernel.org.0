Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA9A11E99F7
	for <lists+linux-wireless@lfdr.de>; Sun, 31 May 2020 20:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728337AbgEaS4h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 31 May 2020 14:56:37 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:44375 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728357AbgEaS4b (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 31 May 2020 14:56:31 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590951390; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=hoB6VZlIL+yL2PWYvofUbOkDxJuj7N04JW1TznMD6h0=; b=tr+MeCWc5mGWY+X6DD4NBzYtEJcRRyqlahoU76ExV2565OnhNKTmS1BLORBye+HbUjsTnzNr
 1Hb7DFa9DRRz1Lgurw2RQygW9oqeDNibH7kHkx31OHR7b7FMey/C6rBIRF/of/Ao3Sdrojmp
 3lbvbGVaZafCDIgnZUeBU66+NgA=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ed3fdc976fccbb4c8176791 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 31 May 2020 18:56:09
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DCCFEC433A0; Sun, 31 May 2020 18:56:08 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 372F7C4339C;
        Sun, 31 May 2020 18:56:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 372F7C4339C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH v4 6/8] ath11k: Add 6G scan dwell time parameter in scan request command
Date:   Sun, 31 May 2020 11:55:58 -0700
Message-Id: <20200531185600.20789-7-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200531185600.20789-1-pradeepc@codeaurora.org>
References: <20200531185600.20789-1-pradeepc@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add 6G scan active and passive dwell time parameter to scan request.

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 4 ++++
 drivers/net/wireless/ath/ath11k/wmi.h | 5 +++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index a6bbb3badd1f..239a336f55f4 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -1899,6 +1899,8 @@ void ath11k_wmi_start_scan_init(struct ath11k *ar,
 	arg->dwell_time_active = 50;
 	arg->dwell_time_active_2g = 0;
 	arg->dwell_time_passive = 150;
+	arg->dwell_time_active_6g = 40;
+	arg->dwell_time_passive_6g = 30;
 	arg->min_rest_time = 50;
 	arg->max_rest_time = 500;
 	arg->repeat_probe_time = 0;
@@ -2045,6 +2047,8 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 	cmd->dwell_time_active = params->dwell_time_active;
 	cmd->dwell_time_active_2g = params->dwell_time_active_2g;
 	cmd->dwell_time_passive = params->dwell_time_passive;
+	cmd->dwell_time_active_6g = params->dwell_time_active_6g;
+	cmd->dwell_time_passive_6g = params->dwell_time_passive_6g;
 	cmd->min_rest_time = params->min_rest_time;
 	cmd->max_rest_time = params->max_rest_time;
 	cmd->repeat_probe_time = params->repeat_probe_time;
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 76c2da2c5db7..4937d02839fc 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -3061,6 +3061,9 @@ struct  wmi_start_scan_cmd {
 	u32 num_vendor_oui;
 	u32 scan_ctrl_flags_ext;
 	u32 dwell_time_active_2g;
+	u32 dwell_time_active_6g;
+	u32 dwell_time_passive_6g;
+	u32 scan_start_offset;
 } __packed;
 
 #define WMI_SCAN_FLAG_PASSIVE        0x1
@@ -3127,6 +3130,8 @@ struct scan_req_params {
 	u32 dwell_time_active;
 	u32 dwell_time_active_2g;
 	u32 dwell_time_passive;
+	u32 dwell_time_active_6g;
+	u32 dwell_time_passive_6g;
 	u32 min_rest_time;
 	u32 max_rest_time;
 	u32 repeat_probe_time;
-- 
2.17.1

