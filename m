Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95F3D396B93
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 04:47:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhFACt1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 May 2021 22:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232635AbhFACt0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 May 2021 22:49:26 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CADAFC06174A
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:45 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f17so5759193wmf.2
        for <linux-wireless@vger.kernel.org>; Mon, 31 May 2021 19:47:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=E+9DcNRaXyopiRpXg0r8Us3pzCipide1qA0z4FYbcPo1NUlmx/nn+XnUPevsXGKbgc
         ZzYWfPj1J9vLm1CMAaW1obVZz0mZHwe6Ns6xhxHNqwPa51Q8t5AG4cGpk/0rb/yckf4w
         sDtqd3EhsDuhzEe+5QBVXpI8GY+chMpe+DiM0BycUkNpJ0zb6RxlZlwcOBu4FUFEvd14
         5XeszdJQhOh/IW/Se2fQkmZKlh7yCMRY+KLJp9uzxy2H+sTlyHHzHQm2CplRkMTHrN9y
         w+WBh3s5FXb4corndBbAJ+u/B6aUazfR+Z6HNjn+jk0bnH6Embx0wTR6tnJcl/IlNj9c
         IFEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=d87AIu8iUEaxuC3wnBnMpqB5rzkdR5ZSAHrZc9CpqdQjMJxnm5ZQi0pWHlKSNYwuV9
         JSx7a+b7SB9LXj97g2CmQJ4OSDBRvD2ntOUKPOTV2XcP080eqDmIF3Z5e49Plq7lYApo
         w4Bx86AwTN0yD8AxATmqkp+ZsaTw/IyceRSXPlhosUZu9dCR7iPNWI5bwXONV7akbQET
         qGOyTAz7vI9uq2cyyS7HGqO+VoAAzW1eY0n7kzXstkZy9zadkieUhCuv1eds8EVO7va4
         ftbw0KEyX+rxRsbGuKgFhEPaA7J1px29D7LaK6+tLDsGByRGXewRXiHTv1EmBuDOt0ay
         qILA==
X-Gm-Message-State: AOAM532av71oywYaiLTFnrsmwMVTCXp8NtOcjBrqK4+864/AQrANdx1H
        oYRdiKYp1lgba5SAIo0ifTX68PAScwOgig==
X-Google-Smtp-Source: ABdhPJzOWbOG0MMSAsBYEtmque+ORp3fWExYBbpmNoqyYP81L8N7fK7qoSNcFn/9uFF9rXbe0nCFuA==
X-Received: by 2002:a7b:cb1a:: with SMTP id u26mr1774142wmj.125.1622515664518;
        Mon, 31 May 2021 19:47:44 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id e22sm16774014wme.48.2021.05.31.19.47.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 19:47:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v4 07/12] wcn36xx: Add set_rekey_data callback
Date:   Tue,  1 Jun 2021 03:49:15 +0100
Message-Id: <20210601024920.1424144-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
References: <20210601024920.1424144-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a callback for Group Temporal Key tracking as provided by the standard
WiFi ops structure.

We track the key to integrate GTK offloading into the WoWLAN suspend path
later on. Code comes from the Intel iwlwifi driver with minimal name
changes.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Tested-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 19 +++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 09e22f829682..ec32b8b0067d 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1147,6 +1147,24 @@ static int wcn36xx_resume(struct ieee80211_hw *hw)
 	return 0;
 }
 
+static void wcn36xx_set_rekey_data(struct ieee80211_hw *hw,
+				   struct ieee80211_vif *vif,
+				   struct cfg80211_gtk_rekey_data *data)
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
@@ -1249,6 +1267,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
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
2.30.1

