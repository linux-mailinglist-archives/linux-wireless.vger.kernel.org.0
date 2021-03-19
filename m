Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBD2342184
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbhCSQOV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbhCSQNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:55 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBD56C06175F
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id d191so5755129wmd.2
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYk+e0v1fIIJdNtGGm5pPGaN1woGIuYcsbVccpj5KvM=;
        b=AedZuECwrE33A9fA14xe/DNOpQSLgC2xQd0+gzgZtl/EXoSdLBYT0E5lfUPXcsElFs
         ilctEP2k15ssyFmiSYbGwAxIQz1eYRO0cWJoMR8MW5mPTyrqLbKDC6wTcKksMV9TXLbU
         AZ9yNYJ5yVIP54nNEEEhd62iKsAiB1La7JDOmFV+yQvDmPing/dYR1nt+SaQ7zCuRBiK
         XCp9aiCh3QxsYRkOkdQ8pl2oVSLU5aiY4qChREh6vhj0i9Zqz2Zhrk9W4ptwRMR4X4xP
         dr9LTlMq9PAA8tZdr/j8UmH5ce3fahaUaBU26nQHyPJIXvNwfVp+XWgmUHD7wWYf2H/c
         m3Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYk+e0v1fIIJdNtGGm5pPGaN1woGIuYcsbVccpj5KvM=;
        b=ZHwUFLdw2UpJ8/Lj+bgEhv6j1LPVU3Rgr9W2JM9Ng8ECnjE+x55346cXGFKtXVNXzQ
         w+ifWhzVsHU+5yJ+ZhIwOIdCDm6FVOuCBpdTjjvLnyiBF1KzHMFrV5iy1hdyAnUZnygT
         QKHF/iRynRalBwGYmkEvZBI0KINc04M8/qzAQReHuzTdtrj62YxCaRGv/BSCZNPlCeME
         RjwxCB0yPyvs9Ebgwyid6IbY4RmeoFO1saeaheyxdcaWAZb8G6Y5euTA/qLERVEryC/C
         z3S+civRBuhwYIFiRG1n9fKlxioEIEB8R0yrRpra6x7zfrT6yahJMamFJPR2L6m8hi3F
         /3bw==
X-Gm-Message-State: AOAM533bqax6RPUfwkgO8R3ODB/LYQ3i5Xw+BYp5bwC7rN/kYzy8nqFN
        WULiSqg8yTqvav4Z+1CmAxxePw==
X-Google-Smtp-Source: ABdhPJzcPjmnXtG5XrbHtN/usRqPkLU3CqD2Bd2HKEn3wlTp5qKPOkuLqbXJMHVCyCBfSrVBu3G29Q==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr4468920wmb.2.1616170432596;
        Fri, 19 Mar 2021 09:13:52 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:52 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 01/12] wcn36xx: Return result of set_power_params in suspend
Date:   Fri, 19 Mar 2021 16:15:09 +0000
Message-Id: <20210319161520.3590510-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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

