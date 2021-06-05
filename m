Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D466139C4C2
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhFEBMz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:55 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:33677 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbhFEBMz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:55 -0400
Received: by mail-wr1-f54.google.com with SMTP id a20so10994698wrc.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=xVXoCTJKppd+snLF02kWT+xu9IsA8qBQXdLxL8E3FnP4qeDoY+psq2KBy33A5FHbBF
         NGEqCXTSI2uiqznDJi0A6Qi5FCQ+xbpVyPiyVkuyLkAhCgRuGm5w8OkYTz8WB+LWv2ug
         qsXOgAxnHf/yvC5kG6CP0BEPdQCUqtj+VKc091936hCRaQY24swbPc3g9x+ZXXGAtlUF
         LmvqK+T4e6upLtJHwJM7x+4T4hh8Lb110VHEYeua2DWtgsXJ3w40BDgJSgfKGyfVCq8C
         ggzEYWVtXLhFTNeJ7xcVzWDEzAglhkpbB36wTY3qAqWhJoHWQ4lfS3xLFL6UWPJBaKiX
         iRoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=tBYN9AeYhzwDVEgvsfWLLQ5Q7kyKd1WzywIUPL0S29LchJWcCMabp8+K/TZDbDfOm6
         Xfre62kapcmWAn+SsP4g70qRZk0FuMszlvNXz49skT+5PEUt+ZuWJpi6Xyb2XAF12yQ+
         nDHDE2GXBYrvmKdjMsC3IysMFGPqalwXLx8QqdspSZLA9QuHCbGxZzEeJ8ER2YOEUk+l
         3Dj8fQPZ69v8Veo0NjTZTqtDKxponJ/6jxF+WPX0UVG/RJq/pn0hebPtpyIdaqRqVfzj
         8rtde4StfV1s7amMx7U0TLq2nbJEnyKvr94caxXoshlFwGXcfw2zwR/DksjUcnnQ9SjJ
         EkWQ==
X-Gm-Message-State: AOAM531MwVSqMidcPx46+9UJPdhTEELT4hiXFmkBkG4eAyTeVxMpDm5d
        /rVCL7x8LPcdmkRNpNLpF5UijQ==
X-Google-Smtp-Source: ABdhPJzEvaYpgR4tU8I1HHISwa6pmXIqma/9vaG2wTeDeHq00sQ5q07YRltBO3GXwxRe4e0rFpsNFw==
X-Received: by 2002:a5d:4c4b:: with SMTP id n11mr6476211wrt.269.1622855397717;
        Fri, 04 Jun 2021 18:09:57 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.09.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:09:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 01/12] wcn36xx: Return result of set_power_params in suspend
Date:   Sat,  5 Jun 2021 02:11:29 +0100
Message-Id: <20210605011140.2004643-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wcn36xx_smd_set_power_params() can return an error. For the purposes of
entering into suspend we need the suspend() function to trap and report
errors up the stack.

First step in this process is reporting the existing result code for
wcn36xx_smd_set_power_params().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index afb4877eaad8..b361e40697a6 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1091,12 +1091,14 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
+	int ret;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, true);
-	return 0;
+	ret = wcn36xx_smd_set_power_params(wcn, true);
+
+	return ret;
 }
 
 static int wcn36xx_resume(struct ieee80211_hw *hw)
-- 
2.30.1

