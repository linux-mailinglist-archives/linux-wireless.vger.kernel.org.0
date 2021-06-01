Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8FE7F39761A
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234370AbhFAPKF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234363AbhFAPKE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:04 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2C05C06174A
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id z137-20020a1c7e8f0000b02901774f2a7dc4so1462725wmc.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BDB2CUDPDaolV/e1QpwHthEeMSH5hthfQ21cne8mw4A=;
        b=UyL9p2CYH5J04r0W6uZRR0+QlJBrjCWzwvFPDfrgNDv3ObhX+Sz7rNAMXaQ3UW04nF
         wCFNG0bWHvkAwndw+FThWuciBSkxOIclA9goIBF5PyGRDDPi4MviKyvicUMQaFUkWQY8
         ZRbKg7h72bzwOud3DEj4qqIlNy/ZfjYrZ+11ebKOJnhsRnI4W1Io4FcSXsqrnGNH90wD
         Gd5MpdWxhMm6LVOgXDaRAqhRyAy2EKDBdTl4k5lw/iaFqoJa7FILMjng07Te6pPbfkha
         v0VZinMV+9d3C4tTEohF7Neyfn9UqIbgPleO3E3sSWAKyz5Ga+SUEQVua6irZ3nJeevf
         LTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BDB2CUDPDaolV/e1QpwHthEeMSH5hthfQ21cne8mw4A=;
        b=nl+W17Y1GzMypM3AgCHPbwJEothhlt76ne2d200CdLBUoLyoLg4KCeehKVZZ6YZvMz
         T070Z9ypSmaZY0fsk8ub9ESn985l938OwmhYRQIwT/yfwfyKs/eTep5PQ7TAM1UMQOIf
         QXWT8BKQu2LEnDyzPOVbfbID/E4IHCZ3u+hcnU9rhaN7Vv2wuGMYwN6FLpKnSCcHK51L
         KS/GKc/k6t00TD7kA17UQEa5EyiL3tNAsyEN8IF0u4Jjn1mb3Xvn49bb9GEoXCsEyKCd
         k6FSg7suR1llIr1d29at8mA0RnAEo5tLboV7KBC2vS4Qh27yMh6scdOsT7OJ304rSG3J
         OTaA==
X-Gm-Message-State: AOAM533RpbY+LfSu0NbLf1kcAUYqAbiCeBmLZ71ADJgcxPlCr79BDJUn
        3pIwG34GWXeXg6ESr54/GxCkAA==
X-Google-Smtp-Source: ABdhPJxrBApfz5VF33kI064pDN52H0P0+6qNvo2xIlEG+QQWflGO0c8hHuN8VkvvNyoOfRHaJLfV7Q==
X-Received: by 2002:a05:600c:4b87:: with SMTP id e7mr11047183wmp.101.1622560101406;
        Tue, 01 Jun 2021 08:08:21 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 02/12] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Tue,  1 Jun 2021 16:09:51 +0100
Message-Id: <20210601151001.1450540-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A subsequent set of patches will extend out suspend/resume support in this
driver, we cannot set the firmware up for multiple ipv4/ipv6 addresses and
as such we can't iterate through a list of ieee80211_vif.

Constrain the interaction with the firmware to the first ieee80211_vif on
the suspend/resume/wowlan path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 31 ++++++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b361e40697a6..9a97a288a96f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1088,15 +1088,34 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_PM
 
+static struct ieee80211_vif *wcn36xx_get_first_assoc_vif(struct wcn36xx *wcn)
+{
+	struct wcn36xx_vif *vif_priv = NULL;
+	struct ieee80211_vif *vif = NULL;
+
+	list_for_each_entry(vif_priv, &wcn->vif_list, list) {
+		if (vif_priv->sta_assoc) {
+			vif = wcn36xx_priv_to_vif(vif_priv);
+			break;
+		}
+	}
+	return vif;
+}
+
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
-	int ret;
+	struct ieee80211_vif *vif = NULL;
+	int ret = 0;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_assoc_vif(wcn);
+	if (vif)
+		ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_unlock(&wcn->conf_mutex);
 
 	return ret;
 }
@@ -1104,11 +1123,17 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 static int wcn36xx_resume(struct ieee80211_hw *hw)
 {
 	struct wcn36xx *wcn = hw->priv;
+	struct ieee80211_vif *vif = NULL;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, false);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_assoc_vif(wcn);
+	if (vif)
+		wcn36xx_smd_set_power_params(wcn, false);
+	mutex_unlock(&wcn->conf_mutex);
+
 	return 0;
 }
 
-- 
2.30.1

