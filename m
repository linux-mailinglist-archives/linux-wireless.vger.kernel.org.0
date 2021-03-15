Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B237933B22E
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230504AbhCOMIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbhCOMIK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:10 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73209C061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:10 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id 61so5561799wrm.12
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NYk+e0v1fIIJdNtGGm5pPGaN1woGIuYcsbVccpj5KvM=;
        b=oya9sOt/bAjZrmfhepm42rnPxi5a5a1YbgczIWnqr3NVQHKh4zkohqiPs+b1BpSnP/
         AD2Yv+U9vl+aasOW8+ZyH9dBEg5HFEENgt3kb1YmZPOsEGbDuEs/JcVNFXTUeDJ2jL+W
         LUderY90kDpe3ursrWzOiPDasNlDRFPEkKbsD1jdvB8DC43o2YduOB9v8wRNJp8fA2cq
         dZmh+0yzIrC/24k61gWoO0gx2EGX/CVBWHZBOjTJra8oE04UAg5u2t8P/6RbM/mkYTLO
         yANta9uVaw0BJbXpbTCAE3X3VXYMGqV9IMsn+2RppxaCm3nFHjR74M1WpYVssiyRJ0+B
         K6MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NYk+e0v1fIIJdNtGGm5pPGaN1woGIuYcsbVccpj5KvM=;
        b=l4YqEP/1k77jB0CJL1zEAnZVHMN9Zzr0aFUULnzUCz+RZ7Dy3bq5kIcK2V5bgTW9/U
         Xd2jgqxWzXI2ZSIcB1Cys0NArkaj12hVGj2mlKAcDRLNKaMkhmMJzk9NdJy41OTBYTe5
         okeyWmFX0cvmGu3PV8HGjITxydPmyjBn7ZUp0aJU4ZxfUVzyE8RWG4Dozo+D2Tu6IrnO
         10BROvOWq/PUfP+/JRdQLux4asxsqb2Uq+64fLYpfjfJHGARketaBDEm257wlQ02ckT6
         5EFOsoTovAHQmRdXSKV4f5xZcYEl5mfXCuz58G55bSXtC5sS50u8fTTvi2OgeDzR9m9j
         cJwA==
X-Gm-Message-State: AOAM531DurAm+h/8aS64EaKILpZztCbSo9bv0cTWKbgJtlWluIUli9M8
        2nV0kQ2zvM08LxCoLb5JFOQjiQ==
X-Google-Smtp-Source: ABdhPJwrtLd7gEsgE15N92lTVRKIVOWqwi38BIRlzEWLtnUOPztqiKCUjUnj+uERIqAkgIOicD595g==
X-Received: by 2002:a5d:4587:: with SMTP id p7mr27250214wrq.205.1615810089036;
        Mon, 15 Mar 2021 05:08:09 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 01/12] wcn36xx: Return result of set_power_params in suspend
Date:   Mon, 15 Mar 2021 12:09:26 +0000
Message-Id: <20210315120937.2512341-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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

