Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41D2F34218A
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Mar 2021 17:14:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhCSQO0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Mar 2021 12:14:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230378AbhCSQOA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Mar 2021 12:14:00 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 116A3C06174A
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:14:00 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id r15-20020a05600c35cfb029010e639ca09eso7613956wmq.1
        for <linux-wireless@vger.kernel.org>; Fri, 19 Mar 2021 09:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=myI1fQBtftwmddT3Z8jSGa9/PtOPEyQd6+p8HuZB9bg=;
        b=Y6B74L2e4fm8oZtZMB/O7rLhb25FVH9jdiY313JYjnYwG6OKa9+UFser9E8ozygAt+
         CNurb+oGseS2vH8A7AT/wsMdflPhWj5gDynkeUqVMj4DWaLq2E0MAi7GnE0UyBFIWvZ4
         jNOLdVrug6cSMRBFxOx/3iRUnVgbQq24JEbusI7FXNaPg9jyihK5U8V4QAILdLFofbSS
         TnqaYuDrQXoE2Xzo55ZnhR9KwYpX2S7Tn13ITiwXTu+Wshv0L7ndKyuXQg0maiB/SYQ/
         0WsBKL7lxz1qmEg54KttFYxaYB2n82CCz3JAVjHKxwgObPSlLOtEP6hRhxH7IJApE1mE
         JT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=myI1fQBtftwmddT3Z8jSGa9/PtOPEyQd6+p8HuZB9bg=;
        b=ChqpElGmGjc2BYeIZs414kN3HssInCFbnJcbdJOC8kaeMiik0bevcrFfTbe1OV9rPj
         whAoXm3klDW5qE0fRKD7V88DLI/1neDDQ8x9W3qjbZRrnoDMs7Q5NFAWYtJFRAjLRbrU
         /hEkg+ppQe8G2Vwz17HPyrEYRHkOgvEbsCIpK7lJ29El500jkMypffgriRbrbopDTNg8
         4Zh1zKHofh93AWZQjhSr8ZCSn2Acsw5cfu2kiFkfdzFE76KE8rKDRP35FD1fkSleEbEz
         NFE7NoBpPaeYMfcHlfGQtrahz5Zn99+0C50wPHMJp3RpZKTgSrILqSnWe9QzWKqbjiJr
         ta9A==
X-Gm-Message-State: AOAM532kunYPL+5HqPjYSCm6H8e6vpRJKnppf0ufXGv6oFnqrOhJZbt1
        StwQSyYCOzerqr4pUD91fpnrNg==
X-Google-Smtp-Source: ABdhPJyVDfz9KXZxQPdWMA7idBgueTSJtTGPA8eafs0teo+/onvUYmpSLC0Z3aizSS4d/33R6qjLFw==
X-Received: by 2002:a1c:9d0e:: with SMTP id g14mr4519547wme.30.1616170438837;
        Fri, 19 Mar 2021 09:13:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id h8sm8432495wrt.94.2021.03.19.09.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Mar 2021 09:13:58 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v3 07/12] wcn36xx: Add set_rekey_data callback
Date:   Fri, 19 Mar 2021 16:15:15 +0000
Message-Id: <20210319161520.3590510-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
References: <20210319161520.3590510-1-bryan.odonoghue@linaro.org>
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

