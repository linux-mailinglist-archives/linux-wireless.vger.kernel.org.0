Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D380396B8E
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232590AbhFACtW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbhFACtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:21 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AF99C06174A
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:40 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id h5-20020a05600c3505b029019f0654f6f1so25271wmq.0
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ONbc2ptFm/dZBx8XWwy/A/AaOhsPLbrPaqAnpZ4ZWqg=;
        b=KPXxiBTA8FxhMKM8KZz+vK8VjkqSPmQiNujL5TY+RPM5AHVzbRSuWPP90/09WzX4I7
         ArL14S5OhYZgTICy1tZ5GtDi7CtDmshzwk7yi97HG7w3ZMMSaposNJk70digd9mF8i+f
         5KU06iHAWwrKJgQ2SfvqF2YvA8uDs0UzqeE+3CHeEadj6X/t+QhZjhor6hAjoBXwKN9x
         hBj9kZwg83yfYjMkyYZzjjHVvGomG2mu2Sa3vMAHdwlaqULnEfTZYQs7aVqz+sknz5f/
         cuAYC2vUjlxeuk+Ait4jfMO+3nohBq2bYx+aUj5l+rWoxdpUx4/sg26KXcGm3nmHN1rV
         E/Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ONbc2ptFm/dZBx8XWwy/A/AaOhsPLbrPaqAnpZ4ZWqg=;
        b=jZ5uHG6CLwgVBs4SRXcGUbsdk+g6L5RwTEMluUKzQxjeHXB/IB5+8wfGhkHs4aR+F5
         gBrx6AIm4ZkSkKshwRFKuXyq542lpz9cqXUv6E9Z13ZdJwDpyHjfB14NdbvWF1X0O32u
         9GPnOfjhUCo7e4JP0RZ3tCpBYBPbcsGpuRIIzbMSl4/c3nDsMcrhO9to0PRGEkND+eN2
         IA+0xSxStGMMD0WqJzONs9BZ+DsZq08F84O3+QH6bi+UuTjy0KJtljjavRlJvyEm2X92
         43Clw1FW4oJBKzQ6SwQ/K/nDxF601ya73Zkh4LwJ0jMEDPPJ1vwfNrJtJx5aNyvcZxHU
         xwxw==
X-Gm-Message-State: AOAM531EWlZXFhA9xRcuULUp8JWBkfzFzx6f/anTvS08XV25exUfhNKv
        4woId3X7emlMoJtWMlPK85S8Iw==
X-Google-Smtp-Source: ABdhPJz1iwdZ29q33Rk6VoyX93vJDFbE+I5LkQAYoqvt9Pvbuta/7+dDZD+a+/LRf1yK/iJ/kVtZgQ==
X-Received: by 2002:a1c:e343:: with SMTP id a64mr3209594wmh.114.1622515659249;
        Mon, 31 May 2021 19:47:39 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:38 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 02/12] wcn36xx: Run suspend for the first ieee80211_vif
Date:   Tue,  1 Jun 2021 03:49:10 +0100
Message-Id: <20210601024920.1424144-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/main.c | 30 ++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index b361e40697a6..6802dce2a02b 100644
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
@@ -1104,11 +1123,16 @@ static int wcn36xx_suspend(struct ieee80211_hw *hw, struct cfg80211_wowlan *wow)
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
+
 	return 0;
 }
 
-- 
2.30.1

