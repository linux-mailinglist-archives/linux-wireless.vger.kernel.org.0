Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D33C1FB345
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Jun 2020 16:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728944AbgFPOBv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 Jun 2020 10:01:51 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16424 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729239AbgFPOBq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 Jun 2020 10:01:46 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592316106; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=0pm8uDAQ0Ra1hWSh3MKfvIr8jZYaqpc9tXjkXWp0evc=; b=oWFg6HUQeKyShGjpQXVMMT+TsZXdNeKoW3JixQUDO9/n/cyLneXVaLH5gZltSTUnDb2v4/Cf
 MpHRTtRMAtYuB57JCbfLysoMVGgop0eEoSyyiXDRXxwyX5GvfbFt8dovtrFkEGCWLk7u8omk
 YuZAn8eFZfJ5ilBaAw+UtWNaD5A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-west-2.postgun.com with SMTP id
 5ee8d0b0117610c7ff04912e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 16 Jun 2020 14:01:20
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E7AA7C433CA; Tue, 16 Jun 2020 14:01:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 97747C43387;
        Tue, 16 Jun 2020 14:01:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 97747C43387
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH 10/12] ath11k: qmi: cleanup info messages
Date:   Tue, 16 Jun 2020 17:00:53 +0300
Message-Id: <1592316055-24958-11-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
References: <1592316055-24958-1-git-send-email-kvalo@codeaurora.org>
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use simplified format, just like ath10k uses, which is easier to read.

Compile tested only.

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index bbdbf1ed19dc..c890f85ffd5c 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1772,11 +1772,11 @@ static int ath11k_qmi_request_target_cap(struct ath11k_base *ab)
 		strlcpy(ab->qmi.target.fw_build_id, resp.fw_build_id,
 			sizeof(ab->qmi.target.fw_build_id));
 
-	ath11k_info(ab, "qmi target: chip_id: 0x%x, chip_family: 0x%x, board_id: 0x%x, soc_id: 0x%x\n",
+	ath11k_info(ab, "qmi chip_id 0x%x chip_family 0x%x board_id 0x%x soc_id 0x%x\n",
 		    ab->qmi.target.chip_id, ab->qmi.target.chip_family,
 		    ab->qmi.target.board_id, ab->qmi.target.soc_id);
 
-	ath11k_info(ab, "qmi fw_version: 0x%x fw_build_timestamp: %s fw_build_id: %s",
+	ath11k_info(ab, "qmi fw_version 0x%x fw_build_timestamp %s fw_build_id %s",
 		    ab->qmi.target.fw_version,
 		    ab->qmi.target.fw_build_timestamp,
 		    ab->qmi.target.fw_build_id);
-- 
2.7.4

