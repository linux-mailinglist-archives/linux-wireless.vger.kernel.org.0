Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94AEF342188
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbhCSQOZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbhCSQN5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:57 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2A9EC06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:56 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id j18so9681882wra.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PK1ysPzp6vM3CYkwLCzyPDUUfmW5NdD9G7dghbyOwwQ=;
        b=LSnkFoSVtANfomNnx6mRhQic961DuP46T62YwfvYO0LHO6hp+6mOmR6MwM+7ZIxaO3
         xRqB63p2KLjViOS2v4dl4ixH6pNsxKHk4QNvzpYuu7a5UNBwdYmWEe7YngT2v2GyG/56
         9CG17xbss42HWIbzm8/DCUqT05sVSB98L4vrBzXR5Myl7JLECgfdeUhxNk0A35JVcb5c
         VPr8pMcpvoF9QKECpd0JtDmp+A0xKNI0cKp/HTeRWT1KyFqxZKLki6JA6khNBF0erC3R
         pqQT3yarx3eTiPARa8m70DL9Q1QEcLrm+jVstH7PEt6SoQL8yhDwaqrzpVtmc3/rWqIG
         plRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PK1ysPzp6vM3CYkwLCzyPDUUfmW5NdD9G7dghbyOwwQ=;
        b=atPttROriNih58tWK20uO5MVXKS9iC6SnFG4z+zjJ9H7dxXLGMBnc8JVeoDwcxlUx4
         PCK1V9LZBo/xvQgsGPNd/YGGNVo9c4gef84ZxYRT7Ty36ShJnbxHLXU6pAzn0Cx6QtQi
         iDuqrXFkqpYjwKhG98dS4mMOLToQYPCaNL0k+kI8xaWGlV2pcYD1CknpMuYItUUtoi5O
         lBD9aCKT05SFfB3o95gBXN/9OhX/Jci5NJMckwg4TttfLc1K9U1XDHw5nkjDvDRwBGJ6
         GCTZYzRHCY9FyotSFm5lIy3yINFKDxP9CujCPwJ6VJffN2tc4bk0LtYEWeeZ/OM57QoR
         Xs8w==
X-Gm-Message-State: AOAM531s0DlUi2P+rolUIkXjYTa/LLKt4PdwikRXPmkkCgOBH9gZYhy4
        8a5lmezFEXNPoEGSlDpATIISTA==
X-Google-Smtp-Source: ABdhPJwWFgvNoOG7EfdfdSAnpQGiSMqazujScbEy1pU1GaomXTwYY0fxYAp8lThTCAf48g0mlvj8OA==
X-Received: by 2002:a5d:4203:: with SMTP id n3mr5266334wrq.116.1616170435727;
        Fri, 19 Mar 2021 09:13:55 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:55 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 04/12] wcn36xx: Do not flush indication queue on suspend/resume
Date:   Fri, 19 Mar 2021 16:15:12 +0000
Message-Id: <20210319161520.3590510-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index f95103706100..029c9952b4fb 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1110,7 +1110,6 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
-	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_vif(wcn);
 	if (vif) {
@@ -1135,7 +1134,6 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
-	flush_workqueue(wcn->hal_ind_wq);
 	mutex_lock(&wcn->conf_mutex);
 	vif = wcn36xx_get_first_vif(wcn);
 	if (vif) {
-- 
2.30.1

