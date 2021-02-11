Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB616318923
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Feb 2021 12:15:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231406AbhBKLKR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Feb 2021 06:10:17 -0500
Received: from mail29.static.mailgun.info ([104.130.122.29]:46566 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229849AbhBKLHG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Feb 2021 06:07:06 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1613041601; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZHyTXzCP1diOgxg//VtXpZpz0SVVM0kV8s3ghwkJp3A=; b=HWLg6Qx+YVacN1O9ZQdiVhWJhqD3PWSg1ZiyZ7wi8Xj12h8PCzfuo8Lm9OMZy1hzBt/sSD8w
 C70uA0/fUZ1QN1CHQZMSfSGC1ctfSjdiHsGegrthco8GXzY8lkzA1wnHw2OgRMh0HLCab6yj
 LNUhXp9lSMDB4+XWfzSpvdDP2Ws=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-east-1.postgun.com with SMTP id
 60250f93e4842e9128e52e83 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 11 Feb 2021 11:05:55
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2F3D6C433ED; Thu, 11 Feb 2021 11:05:55 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 982B6C433C6;
        Thu, 11 Feb 2021 11:05:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 982B6C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] ath11k: qmi: add debug message for allocated memory segment addresses and sizes
Date:   Thu, 11 Feb 2021 13:05:49 +0200
Message-Id: <1613041549-7265-1-git-send-email-kvalo@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This helps debugging firmware memory allocation problems.

Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1

Signed-off-by: Kalle Valo <kvalo@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/qmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/ath11k/qmi.c b/drivers/net/wireless/ath/ath11k/qmi.c
index 0db623ff4bb9..1aca841cd147 100644
--- a/drivers/net/wireless/ath/ath11k/qmi.c
+++ b/drivers/net/wireless/ath/ath11k/qmi.c
@@ -1686,6 +1686,11 @@ static int ath11k_qmi_respond_fw_mem_request(struct ath11k_base *ab)
 			req->mem_seg[i].addr = ab->qmi.target_mem[i].paddr;
 			req->mem_seg[i].size = ab->qmi.target_mem[i].size;
 			req->mem_seg[i].type = ab->qmi.target_mem[i].type;
+			ath11k_dbg(ab, ATH11K_DBG_QMI,
+				   "qmi req mem_seg[%d] 0x%llx %u %u\n", i,
+				    ab->qmi.target_mem[i].paddr,
+				    ab->qmi.target_mem[i].size,
+				    ab->qmi.target_mem[i].type);
 		}
 	}
 
-- 
2.7.4

