Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 296D1239DC3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgHCDL1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727909AbgHCDL0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF05C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:25 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z18so29222610wrm.12
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fZoFBHbiMDr3m9OWHf8AVF21Nakmli1eSwjE2dyRsIQ=;
        b=hWXQ530Suvyx18R5slJjFBMAu5Yu1/M6Hv9gVzKw+P3DYUCEKtmxPH04xYYuDPWyYv
         VexaJc0nbTMJCZ7nuslAd72+UZ+WTW6jTwqz5EUVNb8ngwtjBNU7r+HtqFdvgrsqIKOv
         3zHlD8wtDixB6oycL91C3ryNDjDnY9uZyV862m9vKP4RQ0lcDnFu+EgqNGVRPHlGMv13
         SOFTpISuD27v8DNyTZhIPQM4yhIv/Z7eYtGJXPAgtS1agAkbL83gGq+wOnOBB9lLiRt8
         YULzjuG2M3rrlwkkmkm8dVw4CPW7Fry/rjLwhOAOpPf1duiKp15T9QPw5yEJK3A64+mc
         UxDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fZoFBHbiMDr3m9OWHf8AVF21Nakmli1eSwjE2dyRsIQ=;
        b=NLXstQL8e+UN1f19xK7uApviRpSi8heqPPJVtt4kxnUXREkNa18jJjKfs+Gk4sX92I
         YR6ntxHn2v6lc/McpZ0GBnjThgk5Ksw+OUAuPfIBEyF4r5rRDYrjczNC3BHk7XpVQcg6
         zmKW5FcTiQxK1FxApffuZnovsv84L7tzox6q9Nd1pg2zF85UUAotzF2WQWEI8TFnOUt5
         QwU9gg/NDG7CdQU3wQDzPgEUFjI9R9AHsNEe1DxfmIqCBtwjvdHy2aYKa8YudF17WK40
         y/9nI1a3LFxbt7KETLXp1Yl4wIeL6TfBucSJqw0v72tAAYg9D41NDv+F6p4Gpwf15pN0
         kr1Q==
X-Gm-Message-State: AOAM532r7D/biNNdyPfSTELgitMUSYc0oPZomI4gaUqRb3DRPbys7T6b
        btpwY+DnsoLoFOrPf+yEslkAaA==
X-Google-Smtp-Source: ABdhPJz4nQVphLKxDdSZlSgkw4AMS27xzVPJHFMIL13hXvnKXlTdKMqI0S9ZyB711WnC5SGmdq9Isg==
X-Received: by 2002:a05:6000:150:: with SMTP id r16mr12875781wrx.63.1596424284449;
        Sun, 02 Aug 2020 20:11:24 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 36/36] wcn36xx: Add ability to download wcn3680 specific firmware parameters
Date:   Mon,  3 Aug 2020 04:11:32 +0100
Message-Id: <20200803031132.1427063-37-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 925d82dc0e88..542c5d160ebe 100644
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

