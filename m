Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7520C1A1F64
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Apr 2020 13:06:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgDHLGR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 8 Apr 2020 07:06:17 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:38507 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728000AbgDHLGR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 8 Apr 2020 07:06:17 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586343976; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gjFZj0re/3Zp8RkIWye5jT+SHR4n6jbucjudjP1wH/A=; b=lcI6ySQ+X3S2N699/lBT4vdALBb+nkKsomXjYRzmqtNCq9WkFKA3mKeb5TGxFppqIpqqSi4V
 8nMjn24kY5LIUJQL4t4QL1YT4kLdZDMk8y6lXJdas64TduE+qoI1PMMKJsJir6X+Z0mZ8SER
 8R6aKrFhJUhwjGEIpTUwB0lQySU=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8db020.7fb90b671ae8-smtp-out-n05;
 Wed, 08 Apr 2020 11:06:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2C5BCC433BA; Wed,  8 Apr 2020 11:06:07 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from CHECSTP284781-LIN.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: periyasa)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 61639C433D2;
        Wed,  8 Apr 2020 11:06:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 61639C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=periyasa@codeaurora.org
From:   Karthikeyan Periyasamy <periyasa@codeaurora.org>
To:     ath11k@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org,
        Karthikeyan Periyasamy <periyasa@codeaurora.org>
Subject: [PATCH] ath11k: Modify the interrupt timer threshold
Date:   Wed,  8 Apr 2020 16:35:57 +0530
Message-Id: <1586343957-21474-1-git-send-email-periyasa@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Modify the interrupt timer threshold param as 256 to avoid HW watchdog
in heavy multicast traffic scenario.

Signed-off-by: Karthikeyan Periyasamy <periyasa@codeaurora.org>
---
 drivers/net/wireless/ath/ath11k/hal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/ath11k/hal.h b/drivers/net/wireless/ath/ath11k/hal.h
index 7722822..780a3e1 100644
--- a/drivers/net/wireless/ath/ath11k/hal.h
+++ b/drivers/net/wireless/ath/ath11k/hal.h
@@ -599,7 +599,7 @@ struct hal_srng {
 /* Interrupt mitigation - timer threshold in us */
 #define HAL_SRNG_INT_TIMER_THRESHOLD_TX 1000
 #define HAL_SRNG_INT_TIMER_THRESHOLD_RX 500
-#define HAL_SRNG_INT_TIMER_THRESHOLD_OTHER 1000
+#define HAL_SRNG_INT_TIMER_THRESHOLD_OTHER 256
 
 /* HW SRNG configuration table */
 struct hal_srng_config {
-- 
1.9.1
