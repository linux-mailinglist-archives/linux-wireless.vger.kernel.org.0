Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BFB2633AE
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731027AbgIIRIm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:08:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730376AbgIIPgn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20638C0612FA
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:34 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so3485967wrm.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AiC0FgF4uDyeVnKed9OyzjxTSydZd0n83LrPDKGnIx0=;
        b=qoVAGYgvJAXzaNyItH/D1xYCzbVYiKWjlxjPjxREKvVdKi5C23Bb3/5oVuR9XU7Rx+
         TpaqpjGvbTgnicv/WxgfBBqAwuyKga+YIaQEYd0moB91WRg1PCyAqB01ClCOrhtZllYs
         qMqPgFJS84qyVW1GJcJSa9uDOC8Zquj6t/dSMRHXxNKtpWNLs8FPszlvUJD+iSaR2XhN
         yOh/UOyFvu5Jb4rEQkV8Pb+3EFbsJ1H5YWNXA4T/DhnTZgz859slr4U4CCt5JPOW2eHN
         c42iOWexbkDYKsUIgicDFELTCbCE/mHg9BhoUV7cBlhjJNAlBVOo1aCdRdZ1AeIZKtQQ
         1h6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AiC0FgF4uDyeVnKed9OyzjxTSydZd0n83LrPDKGnIx0=;
        b=FWd50CRzk5ubFf2qLzMMK3U7G5/KnA98h1v4fevpf1xSnxwd0bM3H8ygZCPKjWdz4I
         RyOsZ2RNzsGz8GfgbahMyzT6vlqa6ujPV5miYCVjiHU7nsnOBXR/CcgGxDV/4w+vuWBn
         uEFmvcmvSjw+rBqVkglP2X/d1v5+BT2MRy2nr96NzLjr9ZLCoWFUN98QgLP5x3N8gWzS
         CwcecvuHqM5QFfhfgVWJDzl0hQWYaCwWZVTO/1zX1V7Gje1kJdPlEt1sElDKDM+MpRsd
         a9C4suaxAiJSljQHffb19IIWULZYgzJfsP0UOyF6qSI+cbJ5e1vnjrHZeL6J7BU9Zj2B
         SF9g==
X-Gm-Message-State: AOAM530ooGpjsIoyOdFzYb6rUrMlfoyz4DM6OEuqbXFVuUrza8PxyLTM
        oVuVmLbmeBe30GW4jmPYyo8BqQ==
X-Google-Smtp-Source: ABdhPJzeqg2EPsTLD9XIBJ3xkyW9ZsnhD65hD20+mQNcJNoYg0ocBGmK2A4a4IA5gis6QSFXa9ZXXA==
X-Received: by 2002:adf:e449:: with SMTP id t9mr4668564wrm.154.1599665792826;
        Wed, 09 Sep 2020 08:36:32 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m185sm4605220wmf.5.2020.09.09.08.36.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:32 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 3/4] wcn36xx: Add ability to download wcn3680 specific firmware parameters
Date:   Wed,  9 Sep 2020 16:37:16 +0100
Message-Id: <20200909153717.2905037-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
References: <20200909153717.2905037-1-bryan.odonoghue@linaro.org>
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
index fda2fa0339d9..6805de3f58e7 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -612,6 +612,8 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
 	int ret;
 	int i;
 	size_t len;
+	int cfg_elements;
+	static struct wcn36xx_cfg_val *cfg_vals;
 
 	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_START_REQ);
@@ -624,9 +626,17 @@ int wcn36xx_smd_start(struct wcn36xx *wcn)
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

