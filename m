Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6A094378A1
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Oct 2021 16:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbhJVOFM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 10:05:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232357AbhJVOFJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 10:05:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3ADDC061764
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id o20so760349wro.3
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 07:02:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=B/qiK0v1pop72OWfh2hJtPvJXhk79SaLDKolKRgysc8=;
        b=bHqRH1IA5Ys8EvtC3eMmKRwRSl3JC3R2DLrcpJxdn/B9lE6/+Ix/Xs8/KNAycE/JwX
         SwTE100gRo0KDStpiQPOSvTPYjpU00s6E6b3HPH/qqF10KIyzv5Wo4dCMCKdJSErUGUM
         wSfXh2zEwFamPlzU5csVynNItHy32i2MBFF9R+V/5V1RD9MHgNAQQ02YisQxeHR2BGNW
         wtBS4t0bglLv0rZfOFp1JhGf4eWjoy5nCP8sZi9SdQ+9M9hG+BX4Q1j6OCqfyFDD/Kp5
         iG2IW64+qjUvJ/b6+9g4KDfNz5tCDopgjPOnAyBxIcwLjUptRbKtyiuFpFuw/xve9cyy
         JkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=B/qiK0v1pop72OWfh2hJtPvJXhk79SaLDKolKRgysc8=;
        b=nPlNp4UqWT+D3gFG03ErHgZN4lRjJcRyokWzS72bVKqPszjouKBxHppbWvbQUyejcV
         mK1VL+HZ9UggvOsJgBD4Z2i7WnhoOYR35UPGxcKIGg3e1WVQlRmSLcdVPtDGames5RHl
         NUD17uClo1zIW0aNhRdivPRStntvfDtBw4eU3PnGgYLKdspkf2HLhgzbo9nsFPwfM+7G
         F/NAO0hQBwoZkUvaU3sR6cN9PkzbKGQEFRLRTdYW9j1GbimE596uPdCXRCitOe5+EfnT
         ejj/J9ozMaCqIpvuvPubcf8H6iHdEBgOw6m3lTW7sZXasxAbv22jf8lhY4TTA03f0Mtz
         qtFQ==
X-Gm-Message-State: AOAM533yNjTSgho5ifI3AY9zAIAojIDKFOcv3E3mSN9PUOR+eugC98p6
        Cu2H/kGm7IoAkcTnI/LtatPYeCfie6QGYg==
X-Google-Smtp-Source: ABdhPJypS4A5SnLvpgwSr4epb6PU49KyQhloXQd/xkaKQ7+ok1tPp3+/ieHK8AZOiNEpwCQxugYzjA==
X-Received: by 2002:adf:dc0d:: with SMTP id t13mr98023wri.158.1634911370204;
        Fri, 22 Oct 2021 07:02:50 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u10sm4789913wrm.34.2021.10.22.07.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Oct 2021 07:02:49 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        daniel.thompson@linaro.org, bryan.odonoghue@linaro.org
Subject: [PATCH 1/2] wcn36xx: Treat repeated BMPS entry fail as connection loss
Date:   Fri, 22 Oct 2021 15:04:46 +0100
Message-Id: <20211022140447.2846248-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
References: <20211022140447.2846248-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On an open AP when you pull the plug on the AP, if we are not already in
BMPS mode then the firmware will not generate a disconnection event.

Instead we need to monitor for failure to enter BMPS and treat a string of
failures as connection loss.

Secure AP connections don't appear to demonstrate this behavior so the
work-around is limited to open APs only.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/pmc.c     | 9 +++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 2 ++
 2 files changed, 11 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/pmc.c b/drivers/net/wireless/ath/wcn36xx/pmc.c
index 2d0780fefd477..592a9416e51f9 100644
--- a/drivers/net/wireless/ath/wcn36xx/pmc.c
+++ b/drivers/net/wireless/ath/wcn36xx/pmc.c
@@ -18,6 +18,8 @@
 
 #include "wcn36xx.h"
 
+#define WCN36XX_BMPS_FAIL_THREHOLD 3
+
 int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 				 struct ieee80211_vif *vif)
 {
@@ -31,6 +33,7 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 	if (!ret) {
 		wcn36xx_dbg(WCN36XX_DBG_PMC, "Entered BMPS\n");
 		vif_priv->pw_state = WCN36XX_BMPS;
+		vif_priv->bmps_fail_ct = 0;
 		vif->driver_flags |= IEEE80211_VIF_BEACON_FILTER;
 	} else {
 		/*
@@ -39,6 +42,12 @@ int wcn36xx_pmc_enter_bmps_state(struct wcn36xx *wcn,
 		 * received just after auth complete
 		 */
 		wcn36xx_err("Can not enter BMPS!\n");
+
+		if (vif_priv->bmps_fail_ct++ == WCN36XX_BMPS_FAIL_THREHOLD) {
+			wcn36xx_err("BMPS fail exceeded connection loss\n");
+			ieee80211_connection_loss(vif);
+			vif_priv->bmps_fail_ct = 0;
+		}
 	}
 	return ret;
 }
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index 9469feed1475f..871aab7fd4e60 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -151,6 +151,8 @@ struct wcn36xx_vif {
 	} rekey_data;
 
 	struct list_head sta_list;
+
+	int bmps_fail_ct;
 };
 
 /**
-- 
2.33.0

