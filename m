Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0DFF2A6C26
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 18:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732123AbgKDRrx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 12:47:53 -0500
Received: from z5.mailgun.us ([104.130.96.5]:26472 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgKDRrx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 12:47:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604512072; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=vbsPoGewpn6vLmgZfRomE55ZGgLa/LsM0vTs9lI+thg=; b=EOtTHfoaSOOseHh8A0NbilMpjvAFN7HMho4pBb9HvkR1bPP/CNwZz1JbkG2vTSb46mzcRXuH
 6pbvyqvB/KfhsKMAHHtYs8UCGADL/dpRkzgcOCm0DP7ioqHi6W+1S33wnb9xN99wvntVPd+5
 A4oUbEouHn+t8jWEmSOyAxN7RSw=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-west-2.postgun.com with SMTP id
 5fa2e94173dcdcdfed3e8f65 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 17:47:45
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2807EC433A1; Wed,  4 Nov 2020 17:47:45 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5BCA1C43385;
        Wed,  4 Nov 2020 17:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5BCA1C43385
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: fix wmi init configuration
Date:   Wed,  4 Nov 2020 23:17:00 +0530
Message-Id: <1604512020-25197-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Assign the correct hw_op ath11k_init_wmi_config_ipq8074 to
the hw IPQ8074. Also update the correct TWT radio count.
Incorrect TWT radio count cause TWT feature fails on radio2
because physical device count is hardcoded to 2. so set
the value dynamically.

Found this during code review.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Fixes: 2d4bcbed5b7d53e1 ("ath11k: initialize wmi config based on hw_params")
Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hw.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/hw.c b/drivers/net/wireless/ath/ath11k/hw.c
index 11a411b..66331da 100644
--- a/drivers/net/wireless/ath/ath11k/hw.c
+++ b/drivers/net/wireless/ath/ath11k/hw.c
@@ -127,7 +127,7 @@ static void ath11k_init_wmi_config_ipq8074(struct ath11k_base *ab,
 	config->beacon_tx_offload_max_vdev = ab->num_radios * TARGET_MAX_BCN_OFFLD;
 	config->rx_batchmode = TARGET_RX_BATCHMODE;
 	config->peer_map_unmap_v2_support = 1;
-	config->twt_ap_pdev_count = 2;
+	config->twt_ap_pdev_count = ab->num_radios;
 	config->twt_ap_sta_count = 1000;
 }
 
@@ -157,7 +157,7 @@ static int ath11k_hw_mac_id_to_srng_id_qca6390(struct ath11k_hw_params *hw,
 
 const struct ath11k_hw_ops ipq8074_ops = {
 	.get_hw_mac_from_pdev_id = ath11k_hw_ipq8074_mac_from_pdev_id,
-	.wmi_init_config = ath11k_init_wmi_config_qca6390,
+	.wmi_init_config = ath11k_init_wmi_config_ipq8074,
 	.mac_id_to_pdev_id = ath11k_hw_mac_id_to_pdev_id_ipq8074,
 	.mac_id_to_srng_id = ath11k_hw_mac_id_to_srng_id_ipq8074,
 };
-- 
2.7.4

