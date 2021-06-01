Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE687397619
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234362AbhFAPKE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234074AbhFAPKD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:03 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D0FC061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:21 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id l18-20020a1ced120000b029014c1adff1edso1813269wmh.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=sNhF3dBWejpCgwbM1zny2PMGooFhdnzRTnX5ieerwXuJQzA973sykaegD+gt2TfpcX
         ke/hIsNt5Q2Nn/hYyMmqKuGbWoHNGbpkliuxUhcMhTMug4kBSd7QO7z1DTSthx0kSVjH
         eOtQUTcv5FavXfIcq7etU1H/N7CVh8cSL9aS2EBYEqVlh7fZbLeR91edOPC+PQzZqtCh
         WlV+xG0gF0JJ3/P2KPEmIbcu7wDZ+4JraYIrgKEDs+gEuuF6OwTtODGlnBFEv4vyfneN
         E1Dkk4IQbFou5UcJ14KjHs8qVl5Ctgcwmd6+L0rw+DJDLcxi9G+DDfyiO9w/23jHykOy
         84Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/kuNaO+3BN/9XKW0uTC+mnQ6gznoI5jFyk7Mscc9K1Y=;
        b=hvTk67sE1ZvnU1FklIWtV9kDBxL9Aex2Bdsyc+yzND00/VyB7rjysolbdEcsr3uPsE
         6f8AoXKzkpRgIeVdGfrucDdlujRZbKLvVu6tZr84FkGcvwwLTFchjiAdwqEcA79MC/MW
         yRtDlpFnGPBGJo69UucyvIT+lA0CE6A1xnxlB+UJxPnRLFADr8OX7ocJOAZ15Kup+g2T
         0IYS5e3UFkQfoX1JkcCv/gYxVuK4xwQijsFsllEXHCril0D++XgE5qCbKyGN6wxJpjpM
         eTlb/jOem7gr/mVPJ6+QSrD3I087Zt82BpqWRc7YeoT61TExhKg2q7g+HDkCw362O0to
         ElrA==
X-Gm-Message-State: AOAM532a7rfufkfEUq8S/LFkHnruQJniF4+4TIKyXkCu7fQEH+beIj8+
        i+syLbATWo2UXdffYI15gPKGuQ==
X-Google-Smtp-Source: ABdhPJzfu42UVMbJzaLO8QkRv8UToTU6kO/K00d6JuPHfri5E8III1xqGKOKTJDnHVShHlehKSN11w==
X-Received: by 2002:a05:600c:1994:: with SMTP id t20mr370722wmq.51.1622560100323;
        Tue, 01 Jun 2021 08:08:20 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:18 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 01/12] wcn36xx: Return result of set_power_params in suspend
Date:   Tue,  1 Jun 2021 16:09:50 +0100
Message-Id: <20210601151001.1450540-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

