Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A76BB261A6A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731637AbgIHSft (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731847AbgIHScN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:13 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A86C061385
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:46 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id w5so209695wrp.8
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+JwIjVcGYRQT3Xw48y+fSj0xhb+qvXWha1H9977tamg=;
        b=KaBUFp+V9mOhJ/EYVpaG+lc/M6pQjAU16MJ/iUZq9z/z02t3mTmC8kZvff/5zqcMa7
         GQpSpdfUDVeYh/a1ZXjWrYV9UOapCWditLqCRwvyu/VVLzegJlFivg0GqX33f6rR+0qu
         UWL7xqmJVNwiw/KbYlQdoADvZfvv8JKXxB0DRWL7VQmMfKyzv74+eZ+EdkqsLW6tHTI3
         TkGHG4t7j/0RvciD3AEQ1WV0nzT/2evLOBwbpn3F3iD6hAzl3YJ9T/Y4T5bz2bRKX9/a
         2Y0o3a/FDPuJVMv72Uwm2aO4cdWCGLg7jzMtqY34AzLGQJ13NSXFyjMFBSwfGZd3R6fO
         3E4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+JwIjVcGYRQT3Xw48y+fSj0xhb+qvXWha1H9977tamg=;
        b=GOB9/QTofZEZf0IkESZoZBc7a8Rep3lFH0oTSs6/BI6jvbtSN0DG3cVZJw96E5Ye/L
         0yV6g1rQDRSoWVo79OmcQN3C6B2QKHFOygvnJc8KhBQeQe+eeTbSvoq7Pr2DShVqWyB5
         bxL1BJ6pXcXg2YmM8+aAmAWoHb3noiQE+IfQQvtgQ//6BaVb4zB0sbMJYFky6vXEpDTe
         Ig21ihhLsArigLQXth0mY8SHoHDs066jHVrE9GOAwcOrVSiCODqrdPae7o/TA7kNDHt5
         TC6W7+vjymQ8m/NfCv4E8GKG52Mo4y0BL8mcXNrvw3PQRi8LczzQG2/u9Ulfx+xH0/Ia
         ZL3g==
X-Gm-Message-State: AOAM533QfyyT0hgRfoVNOvpbZa3bGVJsUiFUsnoJ5W2RSIXb6OLISL9B
        8xbDKSHLvqLK6/qr8S9TRE3Y0g==
X-Google-Smtp-Source: ABdhPJxnYQhwd3gd3CrvD6EbFhJWpooT4M5mIF/AqCi+uYm5R24fKK4K5G4Vee+oBqljTxCMqNDg+Q==
X-Received: by 2002:a05:6000:1c7:: with SMTP id t7mr953443wrx.95.1599589485273;
        Tue, 08 Sep 2020 11:24:45 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b84sm381427wmd.0.2020.09.08.11.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 3/4] wcn36xx: Add ability to download wcn3680 specific firmware parameters
Date:   Tue,  8 Sep 2020 19:25:28 +0100
Message-Id: <20200908182529.2870478-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
References: <20200908182529.2870478-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit modifies wcn36xx_smd_start() so that it can download wcn3680
specific firmware parameters if we are talking to the wcn3680. If not the
original generic firmware parameter table should continue to be used for
wcn3620 and wcn3660.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4a53d4b515df..4672581a4354 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -610,6 +610,8 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	int ret;
 	int i;
 	size_t len;
+	int cfg_elements;
+	static struct wcn36xx_cfg_val *cfg_vals;
 
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_START_REQ);
@@ -622,9 +624,17 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	body = (struct wcn36xx_hal_mac_start_req_msg *)wcn->hal_buf;
 	len = body->header.len;
 
-	for (i = 0; i < ARRAY_SIZE(wcn36xx_cfg_vals); i++) {
-		ret = put_cfg_tlv_u32(wcn, &len, wcn36xx_cfg_vals[i].cfg_id,
-				      wcn36xx_cfg_vals[i].value);
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		cfg_vals = wcn3680_cfg_vals;
+		cfg_elements = ARRAY_SIZE(wcn3680_cfg_vals);
+	} else {
+		cfg_vals = wcn36xx_cfg_vals;
+		cfg_elements = ARRAY_SIZE(wcn36xx_cfg_vals);
+	}
+
+	for (i = 0; i < cfg_elements; i++) {
+		ret = put_cfg_tlv_u32(wcn, &len, cfg_vals[i].cfg_id,
+				      cfg_vals[i].value);
 		if (ret)
 			goto out;
 	}
-- 
2.27.0

