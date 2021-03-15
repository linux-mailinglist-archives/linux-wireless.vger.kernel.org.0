Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5561333B230
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhCOMIi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbhCOMIO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:14 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D33DAC061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:13 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id g8so7978021wmd.4
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PK1ysPzp6vM3CYkwLCzyPDUUfmW5NdD9G7dghbyOwwQ=;
        b=Dn2aLoSlYFaM1HqnkLdAGbnG612XxzqF/xX71Q5KWCoYaQx4klRO6lfxideNihhAgO
         ltim+K8CNj1Qa1daR7Vt2rvE9vx7OwOxiRruuRO5Oqrg6ARbdnzYQcsT90hJPaI93MR4
         7MUGfI8A4ni3dEOlQbszOkGKD3EY+f68/18Ggr5XGn4tlSIdyM1IhK+hQnWqz7Uqmo6A
         oITYXD3/BztB8ge/QFeqcJ0VOZCQ4INi9ApBx+sFRQpWs0TXs0gYrX5gMx0Imb33ENCW
         buFIkYEEmcK+Q9ACDHFB/k7mRMdo8if11bNGcL6zDFn3BndMeSUH0RbjrK+SG6539Ghu
         mbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PK1ysPzp6vM3CYkwLCzyPDUUfmW5NdD9G7dghbyOwwQ=;
        b=Xfpm68dIDSmXhH1nReKasabeXJaCaO8wCMrrmIyxn01nIXuJ/JIzw1hzoBfh9gmWK3
         Mfd7tv1pDM5byLdspCu4M6qKGxAZYKG3sr+VDKLflIdCh8GTnBvrVVF7QNdyJOW+aQvS
         Vh+7h1mb9t2bKmc49QiFby0tRgfCKSw9D0oOvEDTkymB1LlnJsa2ONdx4MXyHL6Pvvps
         zU4k+zj7yQuKpWn8f8m7M1lApqEVkJapLEXYP3538P0/bLqEgAMsGVe4aJ0a1kL0aSm8
         REQVqXEZDigXk1paTPjVD+ZXVFik6SAiPr2v/uJqPXZwND2YSyWq0/OTLoFRwxzuWa5k
         fXUw==
X-Gm-Message-State: AOAM5321ljHP4yvfyJ75OOjEgyx0GV08E7h47cSrVznD9z0XDVgGVAtk
        uVDLcFWbQUvGuebK2GCSXzmhVg==
X-Google-Smtp-Source: ABdhPJxChNoDTq4NhFUY7zvGOKAdTsQtvHpnRZk4xrIr/uLqeC+7Ax7FKElM8PRO7/sbZIzPe+a1mQ==
X-Received: by 2002:a1c:195:: with SMTP id 143mr26052009wmb.147.1615810092491;
        Mon, 15 Mar 2021 05:08:12 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 04/12] wcn36xx: Do not flush indication queue on suspend/resume
Date:   Mon, 15 Mar 2021 12:09:29 +0000
Message-Id: <20210315120937.2512341-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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

