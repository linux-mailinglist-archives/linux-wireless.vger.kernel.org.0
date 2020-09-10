Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A47C72648B8
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731290AbgIJP0s (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731243AbgIJPFK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:05:10 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB0AEC061757
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id w2so385312wmi.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OT/7V+2xByy/9ST9yJhKKgW312HrOX/Xe+N2WUGIkkU=;
        b=Gr9fnaA8iYTG7yRNU7GaGAoTGRg9cvsIndyipmaOrtLFe31rtUOq/Q7bZhEvNvs02v
         BhULYhRWwO7RdZXHX4AQXq5Wi5TPiSZHUibwrhwGb8hd8Czgm49kss6B8GurM4K3utLX
         pSJNrVpzviXq7hfQodkVFP26uefiy/e1ihVZG4y+WUO1ECYP1nbnlxpPsLKxq7Rv00EH
         9hPelMGvMVa81CCdpGMtNSnu8CHQXSGI7GnV8gvV7+VEVLnLmPJ4FkT6gSvSudTC2f2q
         VDACqYjN4J95mFxKjCeN0NyWPhCOJEv/mzu59qXnxvA+7DE4Q+ip5YGkBTjYdPb8dNwL
         TYzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OT/7V+2xByy/9ST9yJhKKgW312HrOX/Xe+N2WUGIkkU=;
        b=Pu3SMLeiLDSqpmu0w1O7ynxJwmO+2dGSdLA87RzF1QfDDB2/wC5DbskKK+kdD2VDx8
         kN92Iq7Zt0vN1PAWZ6jj5TRju3qIz/DuMbHrW95AV6f2/andY2uNW1Dn9PgBOebhpGF+
         thuBERQCch/qSP6RZZHooCjIXNwRp3ZJU0dTirh+lBwjsoQVjB/Yc9jhQt659nBs3yGU
         JzOKxTVEQA4h6hYx/eihT3Anr47B1pBPGFQ71sf7UwPmrT0UhzncEBkVDedbXNP21sCz
         SpBzV8Qz5PhroYibJTd2rt78WaVwWnpPiRFDZDvf+cWewsWVncDox8c4PA8wBPYVj8rL
         z6eQ==
X-Gm-Message-State: AOAM530EMn/pp9iPdJNvzip3781876587mUkgRSjiIYLZl5HRXK4SB7v
        zmaeSccZuIce38bmIpxttBb9Rg==
X-Google-Smtp-Source: ABdhPJxnPgWVWGY6XpkHsUsZ4W085JPo5ACIy4DeOdDklp9774/WPhUeXH8gJH+qAmSV2jkf+7jrgA==
X-Received: by 2002:a1c:a107:: with SMTP id k7mr407052wme.67.1599750305565;
        Thu, 10 Sep 2020 08:05:05 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/7] wcn36xx: Add wcn36xx_set_default_rates_v1
Date:   Thu, 10 Sep 2020 16:05:46 +0100
Message-Id: <20200910150552.2178882-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add a routine to set some additional default parameters associated with the
V1 data structure.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 8 ++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index c5e94ba8f941..ab6685dc956b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -793,6 +793,14 @@ void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 		sizeof(*ofdm_rates) * WCN36XX_HAL_NUM_OFDM_RATES);
 	rates->supported_mcs_set[0] = 0xFF;
 }
+
+void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates)
+{
+	rates->op_rate_mode = STA_11ac;
+	rates->vht_rx_mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9;
+	rates->vht_tx_mcs_map = IEEE80211_VHT_MCS_SUPPORT_0_9;
+}
+
 static void wcn36xx_bss_info_changed(struct ieee80211_hw *hw,
 				     struct ieee80211_vif *vif,
 				     struct ieee80211_bss_conf *bss_conf,
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index d7d349de20e6..2da81d9926c4 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -271,6 +271,7 @@ static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
 		wcn->fw_revision == revision);
 }
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates);
+void wcn36xx_set_default_rates_v1(struct wcn36xx_hal_supported_rates_v1 *rates);
 
 static inline
 struct ieee80211_sta *wcn36xx_priv_to_sta(struct wcn36xx_sta *sta_priv)
-- 
2.27.0

