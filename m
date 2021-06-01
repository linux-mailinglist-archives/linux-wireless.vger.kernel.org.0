Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D69A9396B90
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbhFACtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhFACtX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:23 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE808C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:42 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f20-20020a05600c4e94b0290181f6edda88so553061wmq.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=ZpgO2MP1KriQSIbxmw/bWEOAHcTegnidOVBirFpHKEIP++ugodrKda0zumw8j6B/fG
         5x4Rg4oXGbrV6FSE7i8k5NLNelUVoEEiL2Y6IKnz5KZrJ1zFWpXNTeiXY/bOpsrYueNw
         738HVPkdnaAStWJUwAl5wX6sjXHuciIZgzwqV/E1JMOmlDby2t3EODjDCrUhFsDUAl1r
         jNfd6tWrs3hZtpLpWIqvN10DYxwtG1QsrPv+k6rynslpa0q9eMR2vFoRnLl5ddh6jh9D
         gOUU9gGDZzE/RyuELg4vA+7Mjx9MWBYNdsJihQtV6rBTjZzq52T6FgdP6wlaR+d9qMne
         kwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=I20Dg6wr1nh39aczGW9QOgRM1CFfw72wioeV0cnfSQ9XYgwI9S4SnZRDImGiSocNuP
         pIJHkUDxY/7+Ni0zPmaox64tS8o8jfIjfllsDm29HgCWByRv/ggelohwT8Jrj0hUIbhF
         ReXkpOu1eNZsEJ3d86H1Exq3ZeCOlXjSuyeAHSQ1hfHeND3LIMPpp7OxI+W4wVeTJCZm
         180EPY1kEUSc2dtplsmrERbjot7YYtn2kQlvx4h0fDvRRPEyC9d32u/Lkp7OLOqRR5v6
         4IAxjDPQycX87iszyPeIT/yCjmzlUazN5P0/rfg07/fqQ5zFudPeQfdZKblPUhVhkqhC
         3ahA==
X-Gm-Message-State: AOAM530kbeIVENfKRlITaMT07dbVq5J6ZwwiArv2r5SzsCwfi1wqgt9K
        k6YcfhIkoVIfdCSqREbOgq5L3A==
X-Google-Smtp-Source: ABdhPJxB3R075BWChky6fbTlEDAPH2ZQr7A0N8IYAVJLCmdEnu5IffQTYRDVK9vIfb77Zl8tBau2OQ==
X-Received: by 2002:a05:600c:3592:: with SMTP id p18mr23608352wmq.44.1622515661410;
        Mon, 31 May 2021 19:47:41 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 04/12] wcn36xx: Do not flush indication queue on suspend/resume
Date:   Tue,  1 Jun 2021 03:49:12 +0100
Message-Id: <20210601024920.1424144-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Testing on Android reveals that the flush on both suspend and resume of the
firmware indication work-queue can stall indefinitely.

Given this code path doesn't appear to have been exercised up until now,
removing this flush to unblock this situation.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 0da123660fa1..9731fcbe2e7f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1110,7 +1110,6 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
-	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
 
 	vif = wcn36xx_get_first_assoc_vif(wcn);
@@ -1132,7 +1131,6 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
-	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_assoc_vif(wcn);
 	if (vif) {
-- 
2.30.1

