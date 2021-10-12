Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAF6542A301
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Oct 2021 13:18:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236178AbhJLLU3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Oct 2021 07:20:29 -0400
Received: from so254-9.mailgun.net ([198.61.254.9]:19671 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbhJLLU2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Oct 2021 07:20:28 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1634037507; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0q2YRKv3uyGBISXmLzoboNGiNvzauNXZoaVbEX1+pLQ=; b=ndBSrOwuhh2A07kK9gJn13cZxpFpPj8+tWdgAHS5yn/+QkylSPMSu24144q4G4IBh0sR7cy+
 wRqlT2Pi0BtT5wtGjYiYR+bdr5vEEG9iGfy1VMSZsNrUF8+m8VUoptDb/ITsv0i7Vzw2ydQR
 m59Icluv4ChrjkcbtQ/pNs12uT4=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-east-1.postgun.com with SMTP id
 61656eec22fe3a98e537a9ac (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 12 Oct 2021 11:18:04
 GMT
Sender: cjhuang=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 61B48C4338F; Tue, 12 Oct 2021 11:18:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_06_12,SPF_FAIL autolearn=no autolearn_force=no version=3.4.0
Received: from cjhuang-Inspiron-7590.qca.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: cjhuang)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 32626C4338F;
        Tue, 12 Oct 2021 11:18:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 32626C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Carl Huang <cjhuang@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: set DTIM policy to stick mode for station interface
Date:   Tue, 12 Oct 2021 15:18:33 -0400
Message-Id: <20211012191833.8836-1-cjhuang@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Set DTIM policy to DTIM stick mode, so station follows AP DTIM
interval rather than listen interval which is set in peer assoc cmd.
DTIM stick mode is more preferred per firmware team request.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Carl Huang <cjhuang@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 7 +++++++
 drivers/net/wireless/ath/ath11k/wmi.h | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index bb5d12f40..9a86856 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2219,6 +2219,13 @@ static void ath11k_bss_assoc(struct ieee80211_hw *hw,
 			    arvif->vdev_id, ret);
 
 	ath11k_mac_11d_scan_stop_all(ar->ab);
+
+	ret = ath11k_wmi_vdev_set_param_cmd(ar, arvif->vdev_id,
+					    WMI_VDEV_PARAM_DTIM_POLICY,
+					    WMI_DTIM_POLICY_STICK);
+	if (ret)
+		ath11k_warn(ar->ab, "failed to set vdev %d dtim policy: %d\n",
+			    arvif->vdev_id, ret);
 }
 
 static void ath11k_bss_disassoc(struct ieee80211_hw *hw,
diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 6848089..28e2e57 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -2191,6 +2191,13 @@ enum wmi_nss_ratio {
 	WMI_NSS_RATIO_2_NSS = 0x3,
 };
 
+enum wmi_dtim_policy {
+	WMI_DTIM_POLICY_IGNORE = 1,
+	WMI_DTIM_POLICY_NORMAL = 2,
+	WMI_DTIM_POLICY_STICK  = 3,
+	WMI_DTIM_POLICY_AUTO   = 4,
+};
+
 struct wmi_host_pdev_band_to_mac {
 	u32 pdev_id;
 	u32 start_freq;
-- 
2.7.4

