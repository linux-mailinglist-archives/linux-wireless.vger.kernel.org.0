Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 030B139761F
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Jun 2021 17:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234411AbhFAPKM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Jun 2021 11:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbhFAPKL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Jun 2021 11:10:11 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61C09C061574
        for <linux-wireless@vger.kernel.org>; Tue,  1 Jun 2021 08:08:30 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b145-20020a1c80970000b029019c8c824054so1804840wmd.5
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jun 2021 08:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=RxeqFnqU96Xv6bnRyg4MU79EeOjioPa9frXhIBOMgPZvK5jXfoPrXuiA4KlSSue9CA
         U9GepZK4PQKDR66VOIasUc+vGDdCgFW97/4WPXRwP/ZmvknAP+Qmn2qlMy1UWGgnCKyA
         +MnBY4vqz19qjXZxZmVVBmmdspOnOpq0p5o6Oh8ryVG5axWFTqBZsQNxmfMwvFWLpypq
         KrIvDvX4HTbWUiz+kdGHnKyVNRbn7vSW6DnB9OHVDLpFl4BcBghT15IcVhmcAyEfja/N
         u2FLaogqvYitSzteWdR74gmnbn/Mx+GS3bbX6PeS7r08/T7rQJZnYuZhiYU6k0ExhXUo
         1l+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EqMw+TK1CU976V2wAL6yPr0zVt+M7GcrRHHt2Qzbk6I=;
        b=IA6TWO5kopnBFN9XHtJvMILdUeTWWxxiKM3JqYz5ulP5B0B+DXqsqPDcyz1LHKz/dL
         VqZ2ROpYCPXUBJWvNkKWDcjMST3qdiPQx3VJlO6BkcbmH2rIsKbpZ6jxt/YyeT+CLQGz
         Ug1rFDnMEggdbaEJ5501QRXd9vvUuCI2ljrOtnTGNjKOJRxZp+9cbbUXJaIjOvyA7A2o
         AbhiHd8x67lEpagXnxVGZvFL5F0EofUK7meyVDgTwX+qoDO58W3WBNbolSTSJ2sUwKmi
         k3HQbM7ZxhEvSjreTe+E3621HAFjauAyceF58JULSNuQfSfTXPAxU74DgOIcxxnu+kcI
         zn2Q==
X-Gm-Message-State: AOAM533Z/foBKpGmeyFOnQfAoehjrbR84B+FOCjiRc6O8+bYgMtoZDvK
        2AWVmwnAcY0pe/NgrMyo1gKQVw==
X-Google-Smtp-Source: ABdhPJxCPM/rSOycW2/aKE5gtqZ5bmExpvbXDwUmVFKHi4f+BwDztCNrOyW1iTim77vKV+chyjFchg==
X-Received: by 2002:a1c:65c2:: with SMTP id z185mr414096wmb.2.1622560108162;
        Tue, 01 Jun 2021 08:08:28 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o129sm2822237wmo.22.2021.06.01.08.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jun 2021 08:08:27 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        benl@squareup.com, loic.poulain@linaro.org,
        bjorn.andersson@linaro.org
Subject: [PATCH v5 07/12] wcn36xx: Add set_rekey_data callback
Date:   Tue,  1 Jun 2021 16:09:56 +0100
Message-Id: <20210601151001.1450540-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
References: <20210601151001.1450540-1-bryan.odonoghue@linaro.org>
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

