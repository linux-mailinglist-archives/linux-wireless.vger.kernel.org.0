Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7582A6BCD
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Nov 2020 18:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730145AbgKDRfy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Nov 2020 12:35:54 -0500
Received: from m42-4.mailgun.net ([69.72.42.4]:53522 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728305AbgKDRfy (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Nov 2020 12:35:54 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1604511353; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=2S1Ebta5UukZ4v1vDtKokuslV3WSYtgm9aD3Nxy9sdI=; b=lDNvZu8LeV1CJNRruA7StU80YPIaLls6vishwGJXrX3kboTzc3l2wgl6OdKsAOtz6hxslWJB
 o87dmTOUhSTKgeSCxjgDLm7QxIVH++YoRfbjRMKRjnh1lbEftWkRNKT6+serwD2AN+fhp3+v
 5F1NCXJIFLa20vyWdqW39rYj2I8=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5fa2e67846e8885ab857f353 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 04 Nov 2020 17:35:52
 GMT
Sender: periyasa=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 576B3C433CB; Wed,  4 Nov 2020 17:35:52 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from periyasa-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5CAD2C433C8;
        Wed,  4 Nov 2020 17:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5CAD2C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: Fix single phy hw mode
Date:   Wed,  4 Nov 2020 23:05:31 +0530
Message-Id: <1604511331-22477-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

driver not able to bootup in the single radio configured board.
single phy hw mode is converted to invalid hw mode and sent to FW
through wmi init cmd. In that case driver is not receiving wmi
ready event which leads to driver bootup fail. single phy hw mode
is a valid for single radio configured board. so removed the
conversion logic.

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01238-QCAHKSWPL_SILICONZ-2

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.c b/drivers/net/wireless/ath/ath11k/wmi.c
index 6e17373..1f0c517 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.c
+++ b/drivers/net/wireless/ath/ath11k/wmi.c
@@ -3351,9 +3351,6 @@ int ath11k_wmi_cmd_init(struct ath11k_base *ab)
 	init_param.hw_mode_id = wmi_sc->preferred_hw_mode;
 	init_param.mem_chunks = wmi_sc->mem_chunks;
 
-	if (wmi_sc->preferred_hw_mode == WMI_HOST_HW_MODE_SINGLE)
-		init_param.hw_mode_id = WMI_HOST_HW_MODE_MAX;
-
 	if (ab->hw_params.needs_band_to_mac) {
 		init_param.num_band_to_mac = ab->num_radios;
 		ath11k_fill_band_to_mac_param(ab, init_param.band_to_mac);
-- 
2.7.4

