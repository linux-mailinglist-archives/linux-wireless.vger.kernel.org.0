Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18F401FB348
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729136AbgFPOCC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:02:02 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:44251 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729248AbgFPOCB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:02:01 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316121; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=yh4iyx929/Ij0GsACWXzhnS2zyNE8Hbr9B209Z8JTk4=; b=O7tdYLucqlEm+4sfmUlCeYVpi1bTlnfOFY3Tj4AOPYpGHRSStlNoQEteXCyCdu77PmVhAFBV
 HzfzX5fBZh+lxQcGQZ+Dza7wg6m/+r/3EFw3NaBA06q4vDB35d5G/ChiasqU5I82XtbJmqiH
 CCST6Z3YHTKMc9gvK1dtD5rQImc=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5ee8d0b4fe1db4db8915b3a3 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:24
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ECBB6C43387; Tue, 16 Jun 2020 14:01:23 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 8625BC433C9;
        Tue, 16 Jun 2020 14:01:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 8625BC433C9
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 12/12] ath11k: remove define ATH11K_QMI_DEFAULT_CAL_FILE_NAME
Date:   Tue, 16 Jun 2020 17:00:55 +0300
Message-Id: <1592316055-24958-13-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

It's just a duplicate of ATH11K_DEFAULT_CAL_FILE.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 5 ++---
 drivers/net/wireless/ath/ath11k/qmi.h | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index c890f85ffd5c..f5c4d69fbb98 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1810,11 +1810,10 @@ ath11k_qmi_prepare_bdf_download(struct ath11k_base *ab, int type,
 		ath11k_core_free_bdf(ab, &bd);
 		break;
 	case ATH11K_QMI_FILE_TYPE_CALDATA:
-		fw_entry = ath11k_core_firmware_request(ab,
-							ATH11K_QMI_DEFAULT_CAL_FILE_NAME);
+		fw_entry = ath11k_core_firmware_request(ab, ATH11K_DEFAULT_CAL_FILE);
 		if (ret) {
 			ath11k_warn(ab, "failed to load %s: %d\n",
-				    ATH11K_QMI_DEFAULT_CAL_FILE_NAME, ret);
+				    ATH11K_DEFAULT_CAL_FILE, ret);
 			goto out;
 		}
 
diff --git a/drivers/net/wireless/ath/ath11k/qmi.h b/drivers/net/wireless/ath/ath11k/qmi.h
index a7a0a189cbe4..3307be5be687 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.h
+++ b/drivers/net/wireless/ath/ath11k/qmi.h
@@ -22,7 +22,6 @@
 #define ATH11K_QMI_RESP_LEN_MAX			8192
 #define ATH11K_QMI_WLANFW_MAX_NUM_MEM_SEG_V01	32
 #define ATH11K_QMI_CALDB_SIZE			0x480000
-#define ATH11K_QMI_DEFAULT_CAL_FILE_NAME	"caldata.bin"
 
 #define QMI_WLFW_REQUEST_MEM_IND_V01		0x0035
 #define QMI_WLFW_FW_MEM_READY_IND_V01		0x0037
-- 
2.7.4

