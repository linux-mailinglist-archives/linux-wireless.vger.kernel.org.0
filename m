Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F307C2649BB
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIJQ3s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726474AbgIJQ16 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:58 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B4EC061387
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:04 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id x23so377152wmi.3
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bt7q4WuJS1fLYjS1vUbuAcQqhXMPVcrVhmoeIcbszdE=;
        b=uxa8g2ASp9ohHLOccxMhBkdBhNNBA1F6uHZa74fFwBnkZBfhlAxduUXqitKC8pSiNk
         HrCLYU2LWpN4D2Xf7vNjpg6dySri49048PKbtdwlp0m89Zfr/L8lORklj++AiL0yKr8i
         H+6201nHBopNlkjJ4Ca5mtBOQM+Zz+2qc4PubB5wTqfRt1PyemYw9J07eqekucZUQuau
         PLngadCdrI/8knfV2bIJK8c0xh8D3nOuus7HPrNgHsv7RHjEIvfd4wT7ojxAx2GuX8Df
         kPZPCKYuKgT5tD07qW2L3mVzPx0dilx6VSozy1qWKWqn5YH/EQFMUh20G/rSVYL+KzHA
         hLzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bt7q4WuJS1fLYjS1vUbuAcQqhXMPVcrVhmoeIcbszdE=;
        b=Uw8FYCuCIptoehAMPugdqqLy7hs8ou5uwhGVKr+gkeVGzwzb146JyUZV8lLw7EoNi7
         +mHsBMtUwPoEpSlRyioBbaLluTtyi88N5QDIS7Bq4bZbXRtBu/HdAPUlNETBVc4tJI4e
         knM6Ce4IHaLyow/os5fXJM9vws1NRE21nt86/oKbP16JP2faIE7iray5ngpBDqPk//cz
         CWrHNDoDSESR77OLsQCu6dxQXj9/ChxuMWH5zb0ufcoLiruHoUwPsqFjKyGQ3OZmlZY5
         LbzZXhJR87lG+9k7VYhanqGGJ4172IkHs0fpzpL1lLdMDf4tNWyUJ1kQ5/1EL0h/BCRS
         CO9g==
X-Gm-Message-State: AOAM533/1fCONc2eNR6PBmfMVrSHEpzfhrNzRsmBqvx8ObAQQO5Yff1q
        H86gQ2f04922GPsdCQn/Op/gUA==
X-Google-Smtp-Source: ABdhPJyG6t/pcDSZMksVJG00RaVNblKl/0vQ05RyvcBH4+xQ0bU3ptMT58FRInmE7OjZrQKfidHfXA==
X-Received: by 2002:a1c:f008:: with SMTP id a8mr427580wmb.155.1599750423104;
        Thu, 10 Sep 2020 08:07:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m3sm7597315wrs.83.2020.09.10.08.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:02 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 3/4] wcn36xx: Add ability to download wcn3680 specific firmware parameters
Date:   Thu, 10 Sep 2020 16:07:46 +0100
Message-Id: <20200910150747.2179122-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150747.2179122-1-bryan.odonoghue@linaro.org>
References: <20200910150747.2179122-1-bryan.odonoghue@linaro.org>
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
index 242112ce102a..57523a66a8ee 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -625,6 +625,8 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	int ret;
 	int i;
 	size_t len;
+	int cfg_elements;
+	static struct wcn36xx_cfg_val *cfg_vals;
 
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_START_REQ);
@@ -637,9 +639,17 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
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

