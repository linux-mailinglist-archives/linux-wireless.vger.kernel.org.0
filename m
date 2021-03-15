Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED29933B236
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Mar 2021 13:09:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231164AbhCOMIn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Mar 2021 08:08:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbhCOMIR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Mar 2021 08:08:17 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A1BBC061574
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:17 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v4so5563719wrp.13
        for <linux-wireless@vger.kernel.org>; Mon, 15 Mar 2021 05:08:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myI1fQBtftwmddT3Z8jSGa9/PtOPEyQd6+p8HuZB9bg=;
        b=FaGEdBtCOwGt2P+UfQLoPfJ2euzcbontoAyFJSSt3H5hzLEpRyZVygMuC0Zhp+fhsA
         6lanCSlEmUgjNaK3Vts/UTVixXpQNLUk1zAs5QK0TZPh0kra+KSjPHs8Qz0JKoi23b0U
         cdLRSmSxNggMqEI8EoD3AD7pxS11VsXM3fu7uGIA3pheXJTOAyxW8O1niZr4Eo8GGRWA
         ZNBKwLgvqtY+U10ru+hhgbm3maAB6V1/R1yYfP3mbiQQSwa3eqAuz4L7Wz+pWX2g5mqI
         r7Q2bk1FJiq/M8swSgXFqxe05kVtDbT2VwF/ytq5FDQfXkeTydEOXmxxPUlGXD9JOe53
         ZFTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myI1fQBtftwmddT3Z8jSGa9/PtOPEyQd6+p8HuZB9bg=;
        b=N/mdMp6GEIAZ5/s4002CQt546/0rguSHDwJ6UlYqw1J+rbkTy6NgOghAhXCEkdYTLd
         1RQ6ZAetCY8K1s38sJrI1JJhWYY/+yygD0i5dqMjm1AtkdDE38rb3Gzt/V1KZPJ/S1uY
         hnDDHRoGxEIl1MjNY/4cr9a/eLn65WoU2YOWd0SDBfCbD77aDWHcQAS9ixpRhqnpIuwn
         Jl1NgUi2lz3QxetOreOsJ42fINR3yGZE5D1QTLJt5XHuJDYPhPWh9HfiBRKg0HOZ4YXW
         S0sOKltNDOGzmxJUxyTC+gJF1h8Xmuc4Liz0M2hPFTsSbS8QgEbNzZP7G3oN1rw2g+7k
         aXPg==
X-Gm-Message-State: AOAM532TSyqyZHsyCdp2iWdXGvZX26ItQQI1ojXaAdx21BPgcARt2iGw
        R32+dhMmxu/kZJSZHpzba6UkvQ==
X-Google-Smtp-Source: ABdhPJxM+jMIm3p8yKS5pFbG6yoie/9hx81TCpChLQ1rqQMX5pmsrQ08UGwuxCWxO4zh7gF0vrPN1A==
X-Received: by 2002:adf:e60e:: with SMTP id p14mr27058883wrm.221.1615810096189;
        Mon, 15 Mar 2021 05:08:16 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm29239891wmk.0.2021.03.15.05.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 05:08:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v2 07/12] wcn36xx: Add set_rekey_data callback
Date:   Mon, 15 Mar 2021 12:09:32 +0000
Message-Id: <20210315120937.2512341-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
References: <20210315120937.2512341-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 19 +++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  6 ++++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 36cf771d8a20..6b0deed23c5a 100644
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
@@ -1257,6 +1275,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
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

