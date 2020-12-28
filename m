Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4702E67CD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Dec 2020 17:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441823AbgL1Q2z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Dec 2020 11:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2633580AbgL1Q2x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Dec 2020 11:28:53 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A69AC06179E
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:40 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id a12so11743482wrv.8
        for <linux-wireless@vger.kernel.org>; Mon, 28 Dec 2020 08:27:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3RYdIFmmEj5YWYc3o4ND5KeefyrBxeCm6bmJ8jzGapI=;
        b=sBv7gYlC5bwoIjuph34kxZMbuxPUbZIfw1OmJfrwhOXDfPje0X7xRUHPRJjIvxuiMB
         xVlg9Afvzp+bZiv/4dc/ZYP7vJGyvYlAaSTbcg7qtyf7eqPJDrzF6vI9nz0twKMbBM/g
         vO0t6SVPa3PhKn1AZQPHDbva4KJs4FpXKKmG9BeQ7kGEmY7GJ4YsaM03ikiKBmeLKiEz
         +9jL7eml+wdEQ22QDH2AFb9qhncK+oOJ025/6a9x7fknF0AWSsPyTusylh2gYRcXsqhM
         Y815//TB/Ns3uj15lFr/C86FzicCdc8ZveLsGCGhNyv7tR2xHX2Ak9e+JHmOzlODYVue
         wujA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3RYdIFmmEj5YWYc3o4ND5KeefyrBxeCm6bmJ8jzGapI=;
        b=OmmPMzam7JY6X4la5vUaxZehk8JRz5bDmnOkvCy6aYfPY1JJqEkrEEWCB9rXYE5ATi
         jyqGs3/0mvQmJpWhBHkPJHH5ltLJ3uhD1xmYiUlcxrtNE64lv+k7TLWPt7Q4yxY+frfV
         NV4dypk7kFibknZS7zNYvokaKADnt1Yc20tKGWOyaQGtECIY2Ky7uiPlq7gyT3s3TLnU
         WxVMMhUWJAeNk+Zk3VuV/dZrq5KVDiSlPdULevjAboxd2hU1BHinPpSrw3s8aenBQHxI
         L8z7Zc9MB7+VCmrKuyAhTdO2mnnG78ir6XXqCVVI0F5CfvzUQxRa+/uPA68Dbt9hkFse
         IBYw==
X-Gm-Message-State: AOAM532koj1oEHGOumxasdsPAzd64gczhu79zlMgX/yUtrAbWsEq5jst
        /kDBZ+6zi42CznNeCzRfDJoLYQ==
X-Google-Smtp-Source: ABdhPJzEKfSvAn0mJkWKt0i4wTmIsEAfiJTVP4UZ30DPS45UeJ8LGJt3QSq/zmR9dEv818phzWEMog==
X-Received: by 2002:adf:d238:: with SMTP id k24mr15458581wrh.414.1609172859208;
        Mon, 28 Dec 2020 08:27:39 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id w21sm19523379wmi.45.2020.12.28.08.27.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Dec 2020 08:27:38 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org
Subject: [PATCH 08/13] wcn36xx: Add set_rekey_data callback
Date:   Mon, 28 Dec 2020 16:28:34 +0000
Message-Id: <20201228162839.369156-9-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
References: <20201228162839.369156-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds a callback for Group Temporal Key tracking as provided by
the standard WiFi ops structure.

We track the key to integrate GTK offloading into the WoWLAN suspend path
later on. Code comes from the Intel iwlwifi driver with minimal name
changes.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 19 +++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index cfa2e2d20a20..b3388e4a76d2 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1155,6 +1155,24 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	return 0;
 }
 
+void wcn36xx_set_rekey_data(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct cfg80211_gtk_rekey_data *data)
+{
+	struct wcn36xx *wcn = hw->priv;
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+
+	mutex_lock(&wcn->conf_mutex);
+
+	memcpy(vif_priv->rekey_data.kek, data->kek, NL80211_KEK_LEN);
+	memcpy(vif_priv->rekey_data.kck, data->kck, NL80211_KCK_LEN);
+	vif_priv->rekey_data.replay_ctr =
+		cpu_to_le64(be64_to_cpup((__be64 *)data->replay_ctr));
+	vif_priv->rekey_data.valid = true;
+
+	mutex_unlock(&wcn->conf_mutex);
+}
+
 #endif
 
 static int wcn36xx_ampdu_action(struct ieee80211_hw *hw,
@@ -1256,6 +1274,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
 #ifdef CONFIG_PM
 	.suspend		= wcn36xx_suspend,
 	.resume			= wcn36xx_resume,
+	.set_rekey_data		= wcn36xx_set_rekey_data,
 #endif
 	.config			= wcn36xx_config,
 	.prepare_multicast	= wcn36xx_prepare_multicast,
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 5a5114660b18..6121d8a5641a 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -143,6 +143,12 @@ struct wcn36xx_vif {
 	unsigned long tentative_addrs[BITS_TO_LONGS(WCN36XX_HAL_IPV6_OFFLOAD_ADDR_MAX)];
 	int num_target_ipv6_addrs;
 #endif
+	/* WoWLAN GTK rekey data */
+	struct {
+		u8 kck[NL80211_KCK_LEN], kek[NL80211_KEK_LEN];
+		__le64 replay_ctr;
+		bool valid;
+	} rekey_data;
 
 	struct list_head sta_list;
 };
-- 
2.29.2

