Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB9B288049
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Oct 2020 04:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731040AbgJICSW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 8 Oct 2020 22:18:22 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:54085 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729724AbgJICSV (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 8 Oct 2020 22:18:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602209901; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=LzAohiDpFz2hyyRVpsrPkaURCp3kjctWOwIoGGIXbqU=; b=kq8S6IrrY8ywbPVLrbAP26FcCjEy8oJ61lTjN0pjncU+XI/RVqU4l0tgloc7rRmzRVxRZtDD
 eQrrhjeG6Ubl8AYabOdDpFBCvWkz3IUS0iRm4HG78uyZQ0Ju6VtbnVaxknZmh0Ztm3SD8o5N
 +YyxTciPshi9snVMhwRaABFnZAE=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 5f7fc86c06d81bc48d41a4fd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 02:18:20
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ADAEEC43387; Fri,  9 Oct 2020 02:18:20 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc2-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DAA4BC433CB;
        Fri,  9 Oct 2020 02:18:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DAA4BC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     Johannes Berg <johannes@sipsolutions.net>,
        ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH 2/4] ath11k: fix incorrect wmi param for configuring HE operation
Date:   Thu,  8 Oct 2020 19:18:09 -0700
Message-Id: <20201009021811.18584-3-pradeepc@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201009021811.18584-1-pradeepc@codeaurora.org>
References: <20201009021811.18584-1-pradeepc@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

WMI_VDEV_PARAM_TX_OFDMA_CPLEN has been added with incorrect enum
value. Fix the enum to represent WMI param for configuring HE
operation field.

This is applicable to firmwares under
https://github.com/kvalo/ath11k-firmware/tree/master/IPQ8074/hw2.0
https://github.com/kvalo/ath11k-firmware/tree/master/IPQ6018/hw1.0
https://github.com/kvalo/ath11k-firmware/tree/master/QCN9074/hw1.0

Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.1.0.1-01228-QCAHKSWPL_SILICONZ-1

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/wmi.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/wmi.h b/drivers/net/wireless/ath/ath11k/wmi.h
index 5a32ba0eb4f5..55b1a5db206a 100644
--- a/drivers/net/wireless/ath/ath11k/wmi.h
+++ b/drivers/net/wireless/ath/ath11k/wmi.h
@@ -1032,7 +1032,7 @@ enum wmi_tlv_vdev_param {
 	WMI_VDEV_PARAM_PROTOTYPE = 0x8000,
 	WMI_VDEV_PARAM_BSS_COLOR,
 	WMI_VDEV_PARAM_SET_HEMU_MODE,
-	WMI_VDEV_PARAM_TX_OFDMA_CPLEN,
+	WMI_VDEV_PARAM_HEOPS_0_31 = 0x8003,
 };
 
 enum wmi_tlv_peer_flags {
-- 
2.17.1

