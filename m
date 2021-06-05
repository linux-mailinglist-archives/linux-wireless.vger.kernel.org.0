Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E76F639C4BC
	for <lists+linux-wireless@lfdr.de>; Sat,  5 Jun 2021 03:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230527AbhFEBLw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Jun 2021 21:11:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbhFEBLw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Jun 2021 21:11:52 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D531AC061768
        for <linux-wireless@vger.kernel.org>; Fri,  4 Jun 2021 18:10:04 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so10916329wrz.8
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jun 2021 18:10:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=jJQ6imj825D6p03IkWy1xIMM3GXOxVh+LjUX8KR9CO9GGi2ozPBa/Wo4wDaG2VeSeB
         8qZCDStNYdeWpaInRoPPG9fljd5k86AZdizYg0MLslUdzTfytlPrWSPKwyT5PxJDAkls
         dulGbJleJKi5IzImHBzSHBdw73nNNPo+y0e0PbAG9EbHeQUW9oT36cwIc6t8DMLwcFih
         7UBNfhvIoTtrAA/9urfT5uATHztICVVXCiR9sSr6VO/f9Mqjs2XYUGtK+5NkdboWUySd
         yCyncoIcRHeCrKr6g6+KOMsh/GPr/rCl1Sqhomp/uCInaxbK3W7tojV7JFEwkbuQlbn0
         s2Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=Ws9v+w+QKt6D52AAThYIgxvK3v5I/f/6pQmGhBjmknk9Ed7eVUMuN04mQQuO6WlKUO
         zO7+rStlKdEMosCReEEikb+BNwoOqxphmY/gO+ZLzL/u3i3+JYSEheamfocJZFboocYo
         8LeW76EkctsbRv1r/vUsrjufvSRHgSDyckORDABKjfZiauSa27V6uOOw9V8dIAvgIPAU
         olxiHXELAzpUyi4ho/ZzSIEPW6VXTOhWVwMqGci44O37JiN8x0569uA052W/R6Rl8XdF
         OA5CrHNEjOy5JAL4g2f7exUaMAkctJMxk/SISLN81nLoiZiUUSkKJB+PKUb1Ict8FNvz
         BuFg==
X-Gm-Message-State: AOAM531y/8AtavB9UIUPujFdwvqFV52a/eLH9tu+mj8/tL6fJQ8pe/ES
        wkO5Rl0SsELNtZy/pK8Tt6e7MtlD0vbQoYYO
X-Google-Smtp-Source: ABdhPJzdr6RnLT6fCRomQvYzmgxAIywVmhWPqbvYS0EEvMMQecGupaLHnK7sdOs26kUdE8NetHK9+Q==
X-Received: by 2002:a5d:540b:: with SMTP id g11mr6550369wrv.390.1622855403483;
        Fri, 04 Jun 2021 18:10:03 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u8sm9594941wmq.29.2021.06.04.18.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 18:10:03 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v6 07/12] wcn36xx: Add set_rekey_data callback
Date:   Sat,  5 Jun 2021 02:11:35 +0100
Message-Id: <20210605011140.2004643-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
References: <20210605011140.2004643-1-bryan.odonoghue@linaro.org>
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

