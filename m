Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F56261A87
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgIHSgy (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731429AbgIHSck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA39DC061786
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:42 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so195669wrn.10
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=jYsnz1N+uO4dYYMsKSTzubbakPP6rYThv4JWdxQV2on9LKeIj+seQRMpI7FhmRDLtN
         fW8zAAE7y7qvxLXB6Mfg1igrhFKG9qcgF0+czwCAefI+3WjBfpQ+9ZUn0veA8i08kRE2
         p+4POPP/zphxM42LKqwlXtIxtI/QSMb4e2tTeUcQEHvOyG1R+FzP9Un3EZZ9bgC0l0+O
         gtsBKi8CHkT2Ow6TiYT/CCzzF3xLEfM3as5xRpcLnxuO+NpXYu9szApAVkpngCRHMJwe
         CDhcTq0sTXuuht1Joj1tuUXzGXf63arkBiJ1qKqCcqze01CV2+TVlNPq5foHIH1H/Cjd
         vURQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=Pggwxvbp1VrKkjxn0UCCGvw08sX3g0LiPgRiB7sLt/oXAk5e/uZ5qIVtqNccEzKryY
         gDgrw1rle/VAHDlOYQkKiUQjPEbIJXE4DK9bIv5SOBDcxGNPgUQf+wteUCpUY+AvUEWx
         lbbOVr+iadz8No1yDViURKciZvAAi5Z62ZpO+ZL+QZVtQZGKK0gP3Z+yPWNo1cgtC9qI
         xKQdRyZdSIAZpBYCmvtM/lKj4URRBgDL7sFTPj0fd3e5wwyZmUeHnMeo2ZG7dYWV4EY5
         y7AjtosUcBLYd7e0VtzW+2dqrb0XN6Omw2luXeYQvoZO1hLzTAkeZwqicOeDSLT5LZEf
         dSog==
X-Gm-Message-State: AOAM533ZAjxTDJ7/tAOAAbqOH6TBgykUhxNzjtW+ew3kfVpY+Q8xSx6+
        1Fz7gHPobl0VqY6T7aAw2oDeWg==
X-Google-Smtp-Source: ABdhPJwk/Kj7SAiXb5394UQei7BmcR8TVLjcZalPXqgDspo4y/OkWquQZC5OSsj5CDgobUEkUSbF1A==
X-Received: by 2002:adf:8342:: with SMTP id 60mr1017310wrd.158.1599589421598;
        Tue, 08 Sep 2020 11:23:41 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id g186sm286202wmg.25.2020.09.08.11.23.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/2] wcn36xx: Add VHT fields to parameter data structures
Date:   Tue,  8 Sep 2020 19:24:27 +0100
Message-Id: <20200908182428.2870226-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182428.2870226-1-bryan.odonoghue@linaro.org>
References: <20200908182428.2870226-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to pass VHT parameters to wcn3680 we need to use a super-set of
the V1 data-structures with additional VHT parameters tacked on.

This patch adds the additional fields to the STA and BSS parameter
structures.

Since neither wcn3620 nor wcn3660 support VHT the size of the passed
message is fixed to the previous message length. Subsequent changes will
differentiate between wcn3620/wcn3660 and wcn3680 which does use the larger
message size.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/hal.h | 14 +++++++++++++-
 drivers/net/wireless/ath/wcn36xx/smd.c |  2 ++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/hal.h b/drivers/net/wireless/ath/wcn36xx/hal.h
index 573799274a02..3cceeaf0136f 100644
--- a/drivers/net/wireless/ath/wcn36xx/hal.h
+++ b/drivers/net/wireless/ath/wcn36xx/hal.h
@@ -1592,9 +1592,15 @@ struct wcn36xx_hal_config_sta_params_v1 {
 	u8 reserved:4;
 
 	/* These rates are the intersection of peer and self capabilities. */
-	struct wcn36xx_hal_supported_rates supported_rates;
+	struct wcn36xx_hal_supported_rates_v1 supported_rates;
+
+	u8 vht_capable;
+	u8 vht_tx_channel_width_set;
+
 } __packed;
 
+#define WCN36XX_DIFF_STA_PARAMS_V1_NOVHT 10
+
 struct wcn36xx_hal_config_sta_req_msg_v1 {
 	struct wcn36xx_hal_msg_header header;
 	struct wcn36xx_hal_config_sta_params_v1 sta_params;
@@ -2015,8 +2021,14 @@ struct wcn36xx_hal_config_bss_params_v1 {
 	 *  "STA context"
 	 */
 	struct wcn36xx_hal_config_sta_params_v1 sta;
+
+	u8 vht_capable;
+	u8 vht_tx_channel_width_set;
+
 } __packed;
 
+#define WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT (WCN36XX_DIFF_STA_PARAMS_V1_NOVHT + 2)
+
 struct wcn36xx_hal_config_bss_req_msg_v1 {
 	struct wcn36xx_hal_msg_header header;
 	struct wcn36xx_hal_config_bss_params_v1 bss_params;
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4c30036e2e56..55aaaeb78b14 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1223,6 +1223,7 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_sta_params_v1 *sta = &msg_body.sta_params;
 
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
+	msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
 
 	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->sta_params,
 				      &msg_body.sta_params);
@@ -1294,6 +1295,7 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 		return -ENOMEM;
 
 	INIT_HAL_MSG((*msg_body), WCN36XX_HAL_CONFIG_BSS_REQ);
+	msg_body->header.len -= WCN36XX_DIFF_BSS_PARAMS_V1_NOVHT;
 
 	bss = &msg_body->bss_params;
 	sta = &bss->sta;
-- 
2.27.0

