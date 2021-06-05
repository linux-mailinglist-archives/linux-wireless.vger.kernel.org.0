Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF38439C4BE
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbhFEBMD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:12:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231208AbhFEBMC (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:12:02 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDCCC061767
        for <linux-wireless@vger.kernel.org>; Fri,  4 Jun 2021 18:10:01 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id u7so5499142wrs.10
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=mba+tniFLtfhiwBsWBMsKt77/WW2VOYAGlXLXJOM8SgywJ/Y2xbqYwVxuxPg2typnA
         p+us60xXcK6NDg5YK39MelHe/B8dXJe2IUIFIZnYgOXnJ8LWl9fMmazkdT4jdx/E7P7D
         D8dDl9RSR8jCQiWhEQqzN6yEqZ7F05l/9uI1Ttj4n9WXg/g0lpmzF9q3YEtU+AoNyV2B
         6K/PO2tIINTEcYmBK4+ckVqSlW9kml7PM2l+vnHb+BC0eme1DCR88Z5SgxtDy2+nF9Dl
         HYkS7i2WAtuB0e9TZVh7kxVPtrH1rIgL7aKg0rXr079oLxIz3xnHvUzT2IgokVAt4WLt
         S+yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SquAaKfKT+XFRM7MHN5IY0d9iler2O6E6du+Hc36euc=;
        b=AlzX6XsgsVzXDdwW4JdZHFXFru5WnMkzyuTwSL4+pNwg91sTMug59DXWh6v7WddXKc
         L+Ktji2cJoa3JsX8Iv2sJzGotflKb0ZKU7c3Z2Gab8DKI2Bo7t35Z238q8I31STmI4em
         VzoiQ0gmFc4FehFosmOOK21kl1w42tyWzhCmkvno930X+At9DRppwMdsY2xDxGhqdKIv
         HwkdTI79yFXt++c4SJF6yrvSdcLaq9Arh9JGDcKElTQMkxGAEhlNfudiWW348LzZaofY
         YWQ2YSFYGCPuQ33dFl4n+1oGBCjCJ+WFxU+KD8tgB3yyPro8tf/t4yJrMD3aFbw3gZgV
         pjmA==
X-Gm-Message-State: AOAM532pZJjL78pbWjEu68kt5Ohb2AjC+derXwEH3NkkrvjbRkJAsSId
        yJKZdUMOksYBoZriLlnz3M9FaA==
X-Google-Smtp-Source: ABdhPJyQQ5htNCHNPRU7ew2DhngNPJKJFlN+hPtF79iczWjg0VCps2WtzWMJufXoo7utLWyCvCky9w==
X-Received: by 2002:a5d:4a4e:: with SMTP id v14mr6294245wrs.74.1622855400566;
        Fri, 04 Jun 2021 18:10:00 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:00 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 04/12] wcn36xx: Do not flush indication queue on suspend/resume
Date:   Sat,  5 Jun 2021 02:11:32 +0100
Message-Id: <20210605011140.2004643-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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

