Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 824D939761C
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhFAPKI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhFAPKG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:06 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61688C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:25 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id o127so8408949wmo.4
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=bhSI5t2LXcO0cI7OzuFyOUtXr8NHcb9UAqoLbi7dW/hD4qG+aYzOG31ENCjvp6UIt8
         Np0Apn2vTHHE7H31zx8xSOyZi665SxJm15SsRLfnjcYkcJEM/bmlD4iNZ21EEqE8dOg6
         BKZPVAZHGbxc0gbeSaP7PtTwk+xWz414s5qrKEwuDCznGoPsZp4lnWy9OrcXstD3rg8X
         ARpfqUBnVbrMRhoyThCFlDOOPmEH3K7ONxRh/+dzgrLd5BKcOJoSnpTz2qgwdUWSpsIQ
         QHGf2UOTWZBxqlsRZ5qFZNRQjYp67qahODJrAPYqW6DDRM7jqiIo2Z7FcT8633hNVR9B
         JvlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=BSrqZebYlWLenBrtdapHr8V9qny16QdPqrZuz3DWSq5EqOYu4dA1x1rovpkKQZPhJE
         ijr3xq93tt00hM11Pzk4PDAbFZnKXHyTsrjadve/I5xoVEYNba8Wps5CFunCb6fRd2MF
         Uq4zb4nkUdTMP4hXT8J9qaPLIGHLFZPzbAHc6Oihc5d6OSIOjkEE5Js8i9HRCRq9VKCA
         KHIoHZ4jXYVFZXoE1YE1iCVf0fMQdTMLD0QmwkR9rfvHZ32VUGmIhBT+G/760HmeGqHT
         gDyQqNiunEwryPQ3QfUzXvBF2xYuAHqP4q4g4PCdYCtQhQcITCvUXLYwouDZ3B+2hHow
         DcIA==
X-Gm-Message-State: AOAM5326txT9ABwe+SI6a8Pk4PscXOhwV1L2PszK7IoSsQfJkdYC8Pvh
        knX/N4RJwlM7x1PIoV55iA0PGg==
X-Google-Smtp-Source: ABdhPJw2EiOpslyDmjJdkYvNmGgBNO03b9stQ+nWkHD6JClrDvYxxXcvxcI8wZvp/u7ckpOyUGwFdQ==
X-Received: by 2002:a1c:bdd6:: with SMTP id n205mr19395846wmf.74.1622560103997;
        Tue, 01 Jun 2021 08:08:23 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:23 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 04/12] wcn36xx: Do not flush indication queue on suspend/resume
Date:   Tue,  1 Jun 2021 16:09:53 +0100
Message-Id: <20210601151001.1450540-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

