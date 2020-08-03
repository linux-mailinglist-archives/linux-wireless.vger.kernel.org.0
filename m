Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02331239DB5
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgHCDLL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727788AbgHCDLK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:10 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAB12C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:09 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id y3so32789172wrl.4
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KS5+23voL9WeTjkQBGek/Gfs7r3fmKSdew4Fk01OQj4=;
        b=r8Kq4HnYWyrKPARy+4a/zfw2tt0NKlmEV3VpnxQWmTDyVRN72NJdFs/1NhDwDUqIMi
         T7ZviP+AEwWZc9Em52VEIhAJ7t+Q4kQAn+mFffHpBB4YQnqTnnxF66cW0UD2S/0iCcC6
         tWLmkRXkPHGVX9P+iSXH1nnIbnqidRgxl+/pMbUvfDCfpCy46zMCMzz83NSXViKlEULZ
         1eOax+tr65lBBl/Q+MjD6SXUFdPv9Y4NeRZ6sQ0DgOocd4KWneSYiaRpB0+Ot/vcms3m
         MKrZ/FIlBxjuyZp2+3P5p7xVeBl9tnbE6fQKi+SUB3E1o1SPry55Mh9Kb+wtPvv6K5mc
         bMBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KS5+23voL9WeTjkQBGek/Gfs7r3fmKSdew4Fk01OQj4=;
        b=nrYuabqrYSrk6m7YK7A6diohPXxBs6+wlOFgGYseBH4rBuamEZOqlqVbKj3Ax6UIPu
         OJMwcBRhqENjoHVxc9EacVdSYpfWNkkpxppMY/LRY6zY/sfDGl88SyBTmSnSE6JAakRA
         pocy16GUH5yCpAzZFJJJNItdsv1oXoxdd1+bZHt4GltZTRsdz9cX9mdQ650Nq/a3PMDw
         66Cytjq7/Kh/v2tm07UnNvxpNjBooOdW0Y0f/m0fewBcmj9fhaFnETRxHAixCjB1DCh5
         xpEk6x8RTMAcMDOvxiEWrAlbEH+lND9iQ0dEicaVVXdc8m5az/UPUGGlRGpkrNbF8D2D
         wZnA==
X-Gm-Message-State: AOAM531Go9+CKaYhFoJQB+5YY5CjFqwxDNPy1NiV4IQsKlhYSY+tzKXS
        qtf21JRLVHrbBEjEU8Y2piFAyQ==
X-Google-Smtp-Source: ABdhPJwT5ifTtehVIu9EyL3eSM72q72nxV50Y5xhF1/p2uyHcH9WR+xvITvT6nJtkjjKYDTDgXNG5A==
X-Received: by 2002:adf:ab05:: with SMTP id q5mr12495357wrc.46.1596424268620;
        Sun, 02 Aug 2020 20:11:08 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 20/36] wcn36xx: Convert to VHT parameter structure on wcn3680
Date:   Mon,  3 Aug 2020 04:11:16 +0100
Message-Id: <20200803031132.1427063-21-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
2. Setting the sizeo of the packet header lower for wcn3620 and wcn3660

Once done all three chips can continue to use the same code to pass
parameters to their respective firmware. In the case of the wcn3680 the
passed structures will be slightly larger to accommodate communication of
VHT descriptors.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 6a03d5956fc2..2d6779cfa59c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1311,7 +1311,12 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_sta_req_msg_v1 msg_body;
 	struct wcn36xx_hal_config_sta_params_v1 *sta = &msg_body.sta_params;
 
-	INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	if (wcn->rf_id == RF_IRIS_WCN3680) {
+		INIT_HAL_MSG_V1(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	} else {
+		INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+		msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
+	}
 
 	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->sta_params,
 				      &msg_body.sta_params);
@@ -1382,7 +1387,12 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	if (!msg_body)
 		return -ENOMEM;
 
-	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
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

