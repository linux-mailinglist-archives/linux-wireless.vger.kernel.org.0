Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E26B2D5CF8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Dec 2020 15:08:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389968AbgLJOGM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Dec 2020 09:06:12 -0500
Received: from m43-15.mailgun.net ([69.72.43.15]:14843 "EHLO
        m43-15.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389958AbgLJOGB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Dec 2020 09:06:01 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1607609138; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=ejh2xOp0M8fe2LIvSg5q/SP3nwRAztNNNoSXVcpQ90k=; b=vTfURpnO1/N7g3q1aE/0hPz5K8y0kwv5eUWZoDvEuQgbI/cGnnZhIMW8A4+U1AnFSfXlCW/Y
 dAJem1o4I4NiO23fU4ZC/xP2ke3WjgsIiI+M7jZK5CYQrufje+X5T2RrKIVHkkiaOk1bKblN
 PEycS5pIlJ6YkcuE+X9aM4MOAx0=
X-Mailgun-Sending-Ip: 69.72.43.15
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-east-1.postgun.com with SMTP id
 5fd22b3135a25d1b166d04d1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 10 Dec 2020 14:05:37
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1DD33C433CA; Thu, 10 Dec 2020 14:05:37 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id F3B0DC43461;
        Thu, 10 Dec 2020 14:05:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org F3B0DC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 6/6] ath11k: Fix incorrect tlvs in scan start command
Date:   Thu, 10 Dec 2020 16:05:24 +0200
Message-Id: <1607609124-17250-7-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
References: <1607609124-17250-1-git-send-email-kvalo@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>

Currently 6G specific tlvs have duplicate entries which is causing
scan failures. Fix this by removing the duplicate entries of the same
tlv. This also fixes out-of-bound memory writes caused due to
adding tlvs when num_hint_bssid and num_hint_s_ssid are ZEROs.

Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.4.0.1-01386-QCAHKSWPL_SILICONZ-1

Fixes: 74601ecfef6e ("ath11k: Add support for 6g scan hint")
Reported-by: Carl Huang <cjhuang@codeaurora.org>
Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 31 -------------------------------
 1 file changed, 31 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 79b7f991c612..95ebb105dfd7 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -2213,37 +2213,6 @@ int ath11k_wmi_send_scan_start_cmd(struct ath11k *ar,
 		}
 	}
 
-	len = params->num_hint_s_ssid * sizeof(struct hint_short_ssid);
-	tlv = ptr;
-	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
-		      FIELD_PREP(WMI_TLV_LEN, len);
-	ptr += TLV_HDR_SIZE;
-	if (params->num_hint_s_ssid) {
-		s_ssid = ptr;
-		for (i = 0; i < params->num_hint_s_ssid; ++i) {
-			s_ssid->freq_flags = params->hint_s_ssid[i].freq_flags;
-			s_ssid->short_ssid = params->hint_s_ssid[i].short_ssid;
-			s_ssid++;
-		}
-	}
-	ptr += len;
-
-	len = params->num_hint_bssid * sizeof(struct hint_bssid);
-	tlv = ptr;
-	tlv->header = FIELD_PREP(WMI_TLV_TAG, WMI_TAG_ARRAY_FIXED_STRUCT) |
-		      FIELD_PREP(WMI_TLV_LEN, len);
-	ptr += TLV_HDR_SIZE;
-	if (params->num_hint_bssid) {
-		hint_bssid = ptr;
-		for (i = 0; i < params->num_hint_bssid; ++i) {
-			hint_bssid->freq_flags =
-				params->hint_bssid[i].freq_flags;
-			ether_addr_copy(&params->hint_bssid[i].bssid.addr[0],
-					&hint_bssid->bssid.addr[0]);
-			hint_bssid++;
-		}
-	}
-
 	ret = ath11k_wmi_cmd_send(wmi, skb,
 				  WMI_START_SCAN_CMDID);
 	if (ret) {
-- 
2.7.4

