Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364522B3C26
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Nov 2020 05:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726722AbgKPEfD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 15 Nov 2020 23:35:03 -0500
Received: from z5.mailgun.us ([104.130.96.5]:61191 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726016AbgKPEfD (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 15 Nov 2020 23:35:03 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1605501302; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=/c30ssjQII9bBs8zlg7nWad/yX/b7rus1ec2hiAIveA=; b=K3WqVAeJurg0E5GA4gZ6f9ox3vsHZ1cqJauUWlFTCUKKnHC4KbN5dV5x+sIekmCGv/g6wXhu
 9PdwyyXTWqMcitFPY2MybiFI6tOK8Y63PlDtRWfV1JQkbIb/wowg1iuW4ytJbpIZ5XkThgG+
 NZV3Ca3vmL6f3QQ/uuNMM2AGbyw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fb201766c42d983b9a62ff6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 16 Nov 2020 04:35:02
 GMT
Sender: pillair=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6FE03C43462; Mon, 16 Nov 2020 04:35:01 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pillair-linux.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pillair)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3B776C433ED;
        Mon, 16 Nov 2020 04:34:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3B776C433ED
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pillair@codeaurora.org
From:   Rakesh Pillai <pillair@codeaurora.org>
To:     ath10k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
        kuabhs@chromium.org, dianders@chromium.org,
        briannorris@chromium.org, Rakesh Pillai <pillair@codeaurora.org>
Subject: [PATCH v3] ath10k: Fix the parsing error in service available event
Date:   Mon, 16 Nov 2020 10:04:51 +0530
Message-Id: <1605501291-23040-1-git-send-email-pillair@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The wmi service available event has been
extended to contain extra 128 bit for new services
to be indicated by firmware.

Currently the presence of any optional TLVs in
the wmi service available event leads to a parsing
error with the below error message:
ath10k_snoc 18800000.wifi: failed to parse svc_avail tlv: -71

The wmi service available event parsing should
not return error for the newly added optional TLV.
Fix this parsing for service available event message.

Tested-on: WCN3990 hw1.0 SNOC WLAN.HL.3.2.2-00720-QCAHLSWMTPL-1

Fixes: cea19a6ce8bf ("ath10k: add WMI_SERVICE_AVAILABLE_EVENT support")
Signed-off-by: Rakesh Pillai <pillair@codeaurora.org>
---
Changes from v2:
- Add code documentation explaining the necessity of variable
  initialization for the logic to work.
---
 drivers/net/wireless/ath/ath10k/wmi-tlv.c | 4 +++-
 drivers/net/wireless/ath/ath10k/wmi.c     | 9 +++++++--
 drivers/net/wireless/ath/ath10k/wmi.h     | 1 +
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/wmi-tlv.c b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
index 932266d..7b58341 100644
--- a/drivers/net/wireless/ath/ath10k/wmi-tlv.c
+++ b/drivers/net/wireless/ath/ath10k/wmi-tlv.c
@@ -1401,13 +1401,15 @@ static int ath10k_wmi_tlv_svc_avail_parse(struct ath10k *ar, u16 tag, u16 len,
 
 	switch (tag) {
 	case WMI_TLV_TAG_STRUCT_SERVICE_AVAILABLE_EVENT:
+		arg->service_map_ext_valid = true;
 		arg->service_map_ext_len = *(__le32 *)ptr;
 		arg->service_map_ext = ptr + sizeof(__le32);
 		return 0;
 	default:
 		break;
 	}
-	return -EPROTO;
+
+	return 0;
 }
 
 static int ath10k_wmi_tlv_op_pull_svc_avail(struct ath10k *ar,
diff --git a/drivers/net/wireless/ath/ath10k/wmi.c b/drivers/net/wireless/ath/ath10k/wmi.c
index 1fa7107..37b53af 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.c
+++ b/drivers/net/wireless/ath/ath10k/wmi.c
@@ -5751,8 +5751,13 @@ void ath10k_wmi_event_service_available(struct ath10k *ar, struct sk_buff *skb)
 			    ret);
 	}
 
-	ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
-			       __le32_to_cpu(arg.service_map_ext_len));
+	/*
+	 * Initialization of "arg.service_map_ext_valid" to ZERO is necessary
+	 * for the below logic to work.
+	 */
+	if (arg.service_map_ext_valid)
+		ath10k_wmi_map_svc_ext(ar, arg.service_map_ext, ar->wmi.svc_map,
+				       __le32_to_cpu(arg.service_map_ext_len));
 }
 
 static int ath10k_wmi_event_temperature(struct ath10k *ar, struct sk_buff *skb)
diff --git a/drivers/net/wireless/ath/ath10k/wmi.h b/drivers/net/wireless/ath/ath10k/wmi.h
index 4898e19..66ecf09 100644
--- a/drivers/net/wireless/ath/ath10k/wmi.h
+++ b/drivers/net/wireless/ath/ath10k/wmi.h
@@ -6917,6 +6917,7 @@ struct wmi_svc_rdy_ev_arg {
 };
 
 struct wmi_svc_avail_ev_arg {
+	bool service_map_ext_valid;
 	__le32 service_map_ext_len;
 	const __le32 *service_map_ext;
 };
-- 
2.7.4

