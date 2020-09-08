Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80560261A69
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgIHSfr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:35:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbgIHScN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 874EBC06179F
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:23:58 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id l9so303698wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:23:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oIyFTjtZqqz1/a9JDLpNoneKVIe4xiF8cj2LgmPKQKo=;
        b=P3hedTcYIXhIoygbLO9ap57mxbcZf4C1cLkaPFU4XqJCSwQr0eJ3Tvu2n+u0/5mvuB
         L/UIxs6DyWGSGlZTaPOyPiCqr2+241eJzHIzsGBfYDg2upz6V8M2jG103FNGiVL63eL9
         FpGreDD0mwbuyM8JaNRhUsV8ueKxJQbeDedC0Rkx9WOu9azu6S+RY3ZWlcbuc+48Xi9q
         m3kLnNfDfa+cZoVoNJIWM8OslHniy+keNzdY6VOBdMAgEpsOmpKDp50mvF05gLFF97F6
         T3J0/CkVrvO7zcLq0ltOTJN6/Ml1ifMa8VDPA42Fp+L1CwBVNU474tBrq9a3DrZ5OJIo
         kFvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oIyFTjtZqqz1/a9JDLpNoneKVIe4xiF8cj2LgmPKQKo=;
        b=UOlFO5Cdf2H6umCOp4gbzIIAfibY0IMBYt3wDf27TTeKgNqx7SDueoCb/nIEghW+mt
         AxPIYKVc0VfxEs+SEEjUDjhcnsNhzVETNaYsuTWCdEk/kEPDCBdlusqt/JgaCKz3bh4w
         dA0vOScVgMwN1HGNoaHwbUkb5aABYJySpQVZ7aKLnBJd/2HmgMh9YRdAR2XAlgHWC4DO
         +DXVOZedY0p7MlIDUWD3nYDP45ZoZyPAC23xdLrEa9JVMMi8kujDJy8PpSfNDe70QDfY
         SaQZacT01aurYKUgdWuP1ETdUHYBd8gBYMxjB1W36ksQ9XNS19kKawhej4ppfYc/ZIGl
         XwwA==
X-Gm-Message-State: AOAM532A7LdiSRoQWYrzIQvOG/rn53hvyc/HtIyzu6+TA5xPMZUjrDqr
        rZeWATFbBFhsI73Sj+bT7mWOeQ==
X-Google-Smtp-Source: ABdhPJxpjQSkSpJ1/KdybXnK71YSrVKp3QaZvbfj/dyzxnR0RvqlFQpcpc1rm4cWC/xKXuNWVVzwxA==
X-Received: by 2002:a7b:c1d3:: with SMTP id a19mr368649wmj.19.1599589437298;
        Tue, 08 Sep 2020 11:23:57 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id k8sm362516wrl.42.2020.09.08.11.23.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:23:56 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 7/7] wcn36xx: Add wrapper function wcn36xx_smd_set_sta_params_v1()
Date:   Tue,  8 Sep 2020 19:24:37 +0100
Message-Id: <20200908182437.2870281-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
References: <20200908182437.2870281-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds a wrapper function wcn36xx_smd_set_sta_params_v1() which
calls into wcn36xx_smd_set_sta_params() and then subsequently sets
version-1 specific parameters.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index fa6f5943a43d..f434c355d32d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1249,6 +1249,31 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
+void
+wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
+			      struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta,
+			      struct wcn36xx_hal_config_sta_params_v1 *sta_par)
+{
+	struct wcn36xx_sta *sta_priv = NULL;
+	struct wcn36xx_hal_config_sta_params sta_par_v0;
+
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, &sta_par_v0);
+	wcn36xx_smd_convert_sta_to_v1(wcn, &sta_par_v0, sta_par);
+
+	if (sta) {
+		sta_priv = wcn36xx_sta_to_priv(sta);
+		wcn36xx_smd_set_sta_vht_params(wcn, sta, sta_par);
+		wcn36xx_smd_set_sta_ht_ldpc_params(sta, sta_par);
+		memcpy(&sta_par->supported_rates, &sta_priv->supported_rates,
+		       sizeof(sta_par->supported_rates));
+	} else {
+		wcn36xx_set_default_rates_v1(&sta_par->supported_rates);
+		wcn36xx_smd_set_sta_default_vht_params(wcn, sta_par);
+		wcn36xx_smd_set_sta_default_ht_ldpc_params(wcn, sta_par);
+	}
+}
+
 static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_sta *sta,
 				      void *buf,
-- 
2.27.0

