Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C41E2264F73
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbgIJTm2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731329AbgIJPdi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:38 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C751C061342
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:37 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id a65so364009wme.5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=47YTP3hiYkA8vkH+lzBNX2aS1DpgYw/pF0C+zzRdrmk=;
        b=T8ULLRfhHaaMLBkLNhFX2NT9iPeqyReXcGhPzz4nEnpuRXHkqk02HObL09XPP9CDW/
         oP2tP3txY0B73E+E/JIvGXlvDH1UL9mYkAUahQEu3KNoz4adbg1F++gQiDKH6Scu4h0w
         PVmn2uUhroMKitN+0u1DPK9KgnVWGqdtd1jKp2LQVWHGk3wHJH54X8M3nA0Ld0bxmL2L
         m/JoKqGPikkdEAcvKJutj4jTLmMlRrM6uDBqbnyTBK5Jw8lT1A3aBxO4r4ityJDlAmEG
         O1x55g0FgqSd7UEWTlST8cFIHlY4naPchJ5uyGoOXHAITB3S1NgY5QXMBu7IbFwVTXUB
         Qv8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=47YTP3hiYkA8vkH+lzBNX2aS1DpgYw/pF0C+zzRdrmk=;
        b=szUHY+ZleZDshRFRGmXzDMWXKt7+7u+izW/px5oAiXWvQB4yo4d3Y1Mlv0vnGYhZB/
         TZ9BBNaNKj60RsuLuEcVBO/pVCNVTE9FRVA05dUu66yfrL5rV1ckBuqvJY2/oKPAISLS
         5K6zSJIaW/Z8HIP/nzd7FiTih0h7v0VA56R+FibxgPOpd5usQG43+yUe4X2v0F3s8RZI
         CiocYOLuQRuxHvNcZE+wK0By2wandVTYD7lrz63g3+AWWmZQKu9SrwqRNW6GRUArS94l
         u4kWS9Crmgjixdksv1j/FYYjYa2Nh0O8vCS2mT4iax4Q9F6LXFvCrWQ2mJ5pIGAZ2KiZ
         JjWA==
X-Gm-Message-State: AOAM531tultotu8Cno3y38nOAHfUfDZ4tSFiqWpUGAobwkbRl18br4qZ
        qVmd3eXEy8736SQdgm2YYsdAMC6LhkMFNg==
X-Google-Smtp-Source: ABdhPJyNCzuHk0s4eIaCzmj/gAHbNCUu5wEu73cFyUyCjSjPh/GJRicwFMXK7BkfNyRrWSsxf73VkA==
X-Received: by 2002:a1c:9883:: with SMTP id a125mr442728wme.133.1599750456072;
        Thu, 10 Sep 2020 08:07:36 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o128sm3895678wmo.39.2020.09.10.08.07.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:35 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/4] wcn36xx: Convert to VHT parameter structure on wcn3680
Date:   Thu, 10 Sep 2020 16:08:20 +0100
Message-Id: <20200910150822.2179261-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
References: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to send VHT parameters to wcn3680 we need to pass the extended V1
parameter structures to the firmware. These commands need to have the
version number set to 1.

This patch makes the conversion. The conversion consists of

1. Setting the version number for wcn3680 or leaving it at 0 otherwise
2. Setting the size of the packet header lower for wcn3620 and wcn3660

Once done all three chips can continue to use the same code to pass
parameters to their respective firmware. In the case of the wcn3680 the
passed structures will be slightly larger to accommodate communication of
VHT descriptors.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 0f5952003fff..e74abc153153 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1446,8 +1446,12 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_sta_req_msg_v1 msg_body;
 	struct wcn36xx_hal_config_sta_params_v1 *sta_params;
 
-	INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
-	msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		INIT_HAL_MSG_V1(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	} else {
+		INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+		msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
+	}
 
 	sta_params = &msg_body.sta_params;
 
@@ -1627,8 +1631,12 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	if (!msg_body)
 		return -ENOMEM;
 
-	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
-	msg_body->header.len -= WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT;
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		INIT_HAL_MSG_V1((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+	} else {
+		INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+		msg_body->header.len -= WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT;
+	}
 
 	bss = &msg_body->bss_params;
 	sta = &bss->sta;
-- 
2.27.0

