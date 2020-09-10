Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1315E264FA3
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:47:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727081AbgIJTrn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731238AbgIJPEb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:04:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91114C0617A5
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:09 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id s13so360846wmh.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:04:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=inDBJR68WYJdwpPmY616QNwaCxGJEHgdaL3t93f7/bywUN6ytLC2hWLHssLIhl6GPb
         uCm9JZi9LYz4y2rzkRo/E14Al60Du8sJcgYo/FqT9BW4qPvD6TdHm2Hzinb/0gsKfry5
         EiKo6pQhmwX1Zyy4pSbSt9A3SZShluCBIU/bOqOb4Ns3tbE+yzjQCgNaBFgtfpv6OsQ6
         VIX21FYZENu/5ZEI6IfIFrfjhB3xnWmTqmo5x090VvnTnNnsL0HhR/IImt3L0OUt8lzK
         76pVADwhhyG8s9j2f1s9cpjVkZLB6BEMHbPkFyEVpW6VSQHVlJ3SOOYUGs4s5sY3n//L
         32Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=uPh5VMrUSbhpW+eQMdHKHOdum8qMe6rLgUKpdPIViN1Imsn2YC8+xViSUAKBpXK9oM
         X3LnZWtn8x7INAEHhrpm2Xqmhl8dH8iHIWdjdyH9px3kyfm3afIQGEF4OZwihQts8y1F
         37+39JhhQeAf3vx6klD9L4MEhMwcPGU0Qv9N0ycuCswo4AByYnaaX9qti7tVO/EVHlWy
         4/rTCI/sDOl4qzRkKZBxkQD0Cb8Z7IEfeWqYnlgkRRtLZ923lv1iovyT+SSXB0h1XUse
         e8S1jF1UVQ9Mt6X3Ul8PPFucXutJoNamwR0jzS1sXekTBI46YoCLHfPRjzZQ4sRbBMVo
         aTjw==
X-Gm-Message-State: AOAM530CVhOU+9zngF6LMOGm9/HUBW7w6sIm/EtaGwKOLcnL/Q6buEBp
        AEXkQigqsn7uzK6VkhdX1Hqpig==
X-Google-Smtp-Source: ABdhPJxrfhnvzMBaSkWIVB/WHZwXEHknQ1rkHe0mm9DLoxoR1otzptZ5aopkd/DfBKJIWgV4C4oA/Q==
X-Received: by 2002:a1c:f612:: with SMTP id w18mr405111wmc.47.1599750248298;
        Thu, 10 Sep 2020 08:04:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id q186sm4075754wma.45.2020.09.10.08.04.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:04:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/2] wcn36xx: Add VHT fields to parameter data structures
Date:   Thu, 10 Sep 2020 16:04:49 +0100
Message-Id: <20200910150450.2178784-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150450.2178784-1-bryan.odonoghue@linaro.org>
References: <20200910150450.2178784-1-bryan.odonoghue@linaro.org>
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

