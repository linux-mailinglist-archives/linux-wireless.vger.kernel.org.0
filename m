Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B51382630AD
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:38:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730326AbgIIPh7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:37:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730260AbgIIPfJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:09 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B9DC061756
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id s13so2716719wmh.4
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=I8waGxojlzkRIl6Ew8JGRtxReXZpz0VU+jHluWkVETFxLkMTVb4sJRk3I9ZNkrD2L2
         Cfc/3HFNgR6X6LKixBdbgHauFjurngCXFVUYGqp/QFdA4ZD4Xiez5XMdOf434hlPjWlW
         /MlQ6wU9gOVsWdvXpsr7U69zlcWYwX5ajbnF78hzgNdZP41yODTP8dCZMSSG5VzNgQM5
         h7QtSDa/G3vFK2lItUMIDEppvbo7xul1v0315zkZFk1Aknh79juP6XsV7pYHAKEiuswO
         11EkkU/l0iPosmmDerUQ0c9AOTYfREvGHyOyaLCnasVCWsagRjIIqFfNmTKF/j/o0DGL
         Jorg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RqOhclRRIqI97WuGHZsdvXxzhC2mxsIcVlTbaDy3Bdg=;
        b=LV/3zl+KNpzasd5M2Fs1Tz3u/GvNBaG4/T4ZTB1GD8GV3zL0L5Y9/UKE7mIfSRc9Ju
         8ISQdSFav1Oehi/iX3MgI9Fo2yb2R73o+HW38hU79C7YC+XQlBJ80EooZ9slHpO3C/RA
         M1Mo/7FF4rh/VJWZ0NyaiktsupVfCGMLjDScJEaH6nGdxOV72MX0QcRlc5hAf+vM89Pv
         4yM85ovfjHkUhmFJnBiCQ1CRRPVZ98siL52S3ueOOy0z5Xk4LEd9Nl0za4bRsIYL3bEz
         dUn8A+H85s7UKMh7fQdu28a8GLtx8SAT22uTtKiEJMBbuXb/kUQPr3AGw97b9bkt3bPy
         mXbg==
X-Gm-Message-State: AOAM531oJFy31k6kgVoqrhkDlUWeTBFUu/3TVYw7joTu21UKRgGNeAS2
        qs2ywubIPAxhnXm577PT/kEfFw==
X-Google-Smtp-Source: ABdhPJyWtYesrxWyrBxGMnos9C0CFI/MffEvq7V7967a7stgco9FeJCxXcHc2Y0tgP/twJTtTqvj+Q==
X-Received: by 2002:a1c:5a87:: with SMTP id o129mr4237839wmb.145.1599665707121;
        Wed, 09 Sep 2020 08:35:07 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c4sm4922120wrp.85.2020.09.09.08.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:06 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 1/2] wcn36xx: Add VHT fields to parameter data structures
Date:   Wed,  9 Sep 2020 16:35:53 +0100
Message-Id: <20200909153554.2904762-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153554.2904762-1-bryan.odonoghue@linaro.org>
References: <20200909153554.2904762-1-bryan.odonoghue@linaro.org>
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

