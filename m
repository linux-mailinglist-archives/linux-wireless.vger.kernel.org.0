Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB0B4342186
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhCSQOY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbhCSQNz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:13:55 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6931C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id x16so9663181wrn.4
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jZ3WKCazIuoUxdRWj4Ban4JPE+r27UOCDH/EMw86Dwc=;
        b=k3FG7wJBZz1iduVEW3wZy1SPnWvZELKBBbQbcDV//CRTtVHBesiBTWh9RaTdZ0rymx
         9Tk8VAswPI8ggFJLzgvbDSV+7+sRTpAhjTcNOQylgw6PVOt/ehUHty+4OBEp0SPWuCp9
         FM/9KDPz6SgqR3IA+NlsAR0cgwiy+fgM2s9VNdafH0Rp1/urcy+afUY+hilSkIybj8nH
         liRyMCRS4SPW6HGl1733KuaXJ3k3hFyV04+oxwzXWJCSe+ZxP2+7ICOwrUCX9tfpaY2T
         ZFa07xcMgKOB9ysCz0m06qDDq0y7+HPhThMgIp5QqhTUju/S1XzlNgGp9BZ3hktEhWCT
         Jh/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jZ3WKCazIuoUxdRWj4Ban4JPE+r27UOCDH/EMw86Dwc=;
        b=GZWxJA7A0rOvw8T6ciTxB5qxfafiV1JFz/tj+a35/qRUdUQGIPWNqz5aR2PDGeRYwY
         IzTK2vCG+motwRqM4jGHSgBf6hRWHRCdcsmsml049au/t+VglFE8/70l1d2HRNPGx7HZ
         ++8gJhKSotMgXnz6YYd/UzYHxEBJw3QlN8TJAx0gqQ8v9jaSvKPHfTo7K76tlkXwxn/e
         Becj645ZVP7cd7OrjiYfjC6iKeOWQWXew8Sk7Acg1SzCDQ7E16Ld9VcrfAeheuJXZ/Vv
         xo88uGKsVX7IMMTRDFnlPG2yK/jUFKBYK1TnEcrpdbS3c2c5GDoiNdU3VtEi6L1Z4feV
         k2Eg==
X-Gm-Message-State: AOAM532wEpNj6Tc6djlGO+6piyy/Cd92z28daukU2NtfIqrDkdDhMaQE
        FDjeKBFCftqaYi78ZsEVW80xEw==
X-Google-Smtp-Source: ABdhPJy2rHp5i7CyNhcSFYXQNTJE41UyR+kTHvznegAfRVEljc9AJbuIOhi9RMfIUw/9wS8HjIWalA==
X-Received: by 2002:adf:f648:: with SMTP id x8mr5331023wrp.157.1616170433548;
        Fri, 19 Mar 2021 09:13:53 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 02/12] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Fri, 19 Mar 2021 16:15:10 +0000
Message-Id: <20210319161520.3590510-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/main.c | 43 +++++++++++++++++++++++--
 1 file changed, 40 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b361e40697a6..c0c1ea18864f 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1088,15 +1088,39 @@ static int wcn36xx_sta_remove(struct ieee80211_hw *hw,
 
 #ifdef CONFIG_PM
 
+struct ieee80211_vif *wcn36xx_get_first_vif(struct wcn36xx *wcn)
+{
+	struct wcn36xx_vif *tmp;
+	struct ieee80211_vif *vif = NULL;
+
+	list_for_each_entry(tmp, &wcn->vif_list, list) {
+		vif = wcn36xx_priv_to_vif(tmp);
+		if (vif)
+			break;
+	}
+	return vif;
+}
+
 static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 {
 	struct wcn36xx *wcn = hw->priv;
-	int ret;
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *vif_priv = NULL;
+	int ret = 0;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac suspend\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	ret = wcn36xx_smd_set_power_params(wcn, true);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_vif(wcn);
+	if (vif) {
+		vif_priv = wcn36xx_vif_to_priv(vif);
+		if (!vif_priv->sta_assoc)
+			goto out;
+		ret = wcn36xx_smd_set_power_params(wcn, true);
+	}
+out:
+	mutex_unlock(&wcn->conf_mutex);
 
 	return ret;
 }
@@ -1104,11 +1128,24 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
 static int wcn36xx_resume(struct ieee80211_hw *hw)
 {
 	struct wcn36xx *wcn = hw->priv;
+	struct ieee80211_vif *vif = NULL;
+	struct wcn36xx_vif *vif_priv = NULL;
 
 	wcn36xx_dbg(WCN36XX_DBG_MAC, "mac resume\n");
 
 	flush_workqueue(wcn->hal_ind_wq);
-	wcn36xx_smd_set_power_params(wcn, false);
+	mutex_lock(&wcn->conf_mutex);
+	vif = wcn36xx_get_first_vif(wcn);
+	if (vif) {
+		vif_priv = wcn36xx_vif_to_priv(vif);
+		if (!vif_priv->sta_assoc)
+			goto out;
+
+		wcn36xx_smd_set_power_params(wcn, false);
+	}
+out:
+	mutex_unlock(&wcn->conf_mutex);
+
 	return 0;
 }
 
-- 
2.30.1

