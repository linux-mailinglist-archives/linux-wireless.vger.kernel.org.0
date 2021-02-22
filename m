Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10D183213E0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Feb 2021 11:14:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbhBVKMo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 22 Feb 2021 05:12:44 -0500
Received: from z11.mailgun.us ([104.130.96.11]:22730 "EHLO z11.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231160AbhBVKKw (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 22 Feb 2021 05:10:52 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613988633; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=QeThCgQqPa6HbWJQokbkefJAUSQg1jKYIIaZj1q3QnE=; b=fwZCogzomSCCM/K/qqjOhqKP0NYwl7fF1vlegETd2xHb82O9FUvsz0SHvphwxYLT7T98dPuC
 NvZcwzO6hIiQjsM0xH2OdWibEQa1InOgaJtru5NfbYhRh2MsDaNpxye66T1REaoLdvKaR72m
 W1w6otgKDf7Y7Bw5tZsfi+R/58w=
X-Mailgun-Sending-Ip: 104.130.96.11
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 603382eb4511108a81eaf8aa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Feb 2021 10:09:47
 GMT
Sender: mkenna=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id EF332C433C6; Mon, 22 Feb 2021 10:09:46 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from ssreeela-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkenna)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3E25EC43461;
        Mon, 22 Feb 2021 10:09:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3E25EC43461
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=mkenna@codeaurora.org
From:   Maharaja Kennadyrajan <mkenna@codeaurora.org>
To:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Maharaja Kennadyrajan <mkenna@codeaurora.org>
Subject: [PATCH 3/3] ath11k: Add support for beacon tx mode
Date:   Mon, 22 Feb 2021 15:39:33 +0530
Message-Id: <1613988573-10839-4-git-send-email-mkenna@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org>
References: <1613988573-10839-1-git-send-email-mkenna@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support to configure the beacon tx mode in
the driver.

Use the below configuration in the hostapd/wpa_supplicant
for AP/MESH mode to configure the beacon tx mode.

"beacon_tx_mode=N", where N = 1 for STAGGERED beacon mode
and N = 2 for BURST beacon mode.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.5.0.1-00480-QCAHKSWPL_SILICONZ-1

Signed-off-by: Maharaja Kennadyrajan <mkenna@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/mac.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/mac.c b/drivers/net/wireless/ath/ath11k/mac.c
index b391169..94239cf 100644
--- a/drivers/net/wireless/ath/ath11k/mac.c
+++ b/drivers/net/wireless/ath/ath11k/mac.c
@@ -2062,7 +2062,10 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 
 	if (changed & BSS_CHANGED_BEACON) {
 		param_id = WMI_PDEV_PARAM_BEACON_TX_MODE;
-		param_value = WMI_BEACON_STAGGERED_MODE;
+		if (info->beacon_tx_mode == NL80211_BEACON_BURST_MODE)
+			param_value = WMI_BEACON_BURST_MODE;
+		else
+			param_value = WMI_BEACON_STAGGERED_MODE;
 		ret = ath11k_wmi_pdev_set_param(ar, param_id,
 						param_value, ar->pdev->pdev_id);
 		if (ret)
@@ -2070,8 +2073,9 @@ static void ath11k_mac_op_bss_info_changed(struct ieee80211_hw *hw,
 				    arvif->vdev_id);
 		else
 			ath11k_dbg(ar->ab, ATH11K_DBG_MAC,
-				   "Set staggered beacon mode for VDEV: %d\n",
-				   arvif->vdev_id);
+				   "Set %s beacon mode for VDEV: %d mode: %d\n",
+				   param_value ? "burst" : "staggered",
+				   arvif->vdev_id, param_value);
 
 		ret = ath11k_mac_setup_bcn_tmpl(arvif);
 		if (ret)
-- 
2.7.4

