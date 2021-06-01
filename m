Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E2396B8D
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232559AbhFACtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232268AbhFACtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:21 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 956F0C061574
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:39 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso590016wmc.1
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=Lo4bik+TZIU7M/QWJWM5fLz+7AXZQdnBL5yFb4HyrbKXHXnK1j8SQPO6Ww6AFOyK5M
         SQz9EzE2DK0StDXBpy8EjrT+KR/WHy4LxvTkD+HTUP4NcltISAbw6mn/jRBjDyVkrf5U
         D5AqLZRtV+sPhTEi5FhYQTij1fnwsVagHf6d0yQd9dXzjrpWjuyG+POHeFAiiFerR4oG
         7+KMYjjpmLOnMCztYQYN0m4VOnRN53WdQ03I1KnrEKKIl04ck+uBIm6uxVepm81dlP5K
         5XleGfmZUBNMPPjoEGHI0SmUefj4k4h/tfLqI0cK0FGi2WqSNFtFsFreRgnIrGqyHH4u
         VjdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=RhfcumzAC32U6LX2PKXmowMW+cLXT0lzwANHQCQka2UpdEMTVInmTe1SVbp5dOffj/
         RtOLzQ/FtrZJ1g0t4m1i0zjnJ42GjP/Ng5tUXz4w63Xlst+w8RlRJkQQk7KbXB/LK1K7
         prIITmS8kNR2F6dOZk05LVi8It1eabTm0afYRjvTPtAxCII3q80G6GH+FpUmrvxhavtb
         5vmJUo7eo/jlys5avowkIzsN80y8Ts9FRWHIg1jaMi6RfsCoyVGydfdHJifhYCRxtWFP
         Cd0Fb0csG6nvZ6b+Vvy1kXu8MOgoLz1oafTUVQdkscYR33/taOL7Oi/w02xtQZ3Ila39
         bIuA==
X-Gm-Message-State: AOAM530sEyYb8e2N6Qfp+KnYxz0pZO3iA8taXtJHObILt6zAko5kZIEu
        P2+Rz1jbI81IbGoQmRNJumWOq+Jlj1P49A==
X-Google-Smtp-Source: ABdhPJxqW3kadPvq4gucoaiPkMBEvBJynqhRHoEiREItrCoz8TgwMWB3cuXSWg9iNJ4TVVWjVKh63A==
X-Received: by 2002:a05:600c:2301:: with SMTP id 1mr1823494wmo.180.1622515658225;
        Mon, 31 May 2021 19:47:38 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 01/12] wcn36xx: Return result of set_power_params in suspend
Date:   Tue,  1 Jun 2021 03:49:09 +0100
Message-Id: <20210601024920.1424144-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
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

