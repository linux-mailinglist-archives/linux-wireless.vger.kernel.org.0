Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4D826339E
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730599AbgIIRHk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:07:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729479AbgIIPhI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:37:08 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E8C061360
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:37:07 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id c19so2083393wmd.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YTwsOssKLuWm0RN1XuxIWtatvqfRvgRgu4IUBKS+A1E=;
        b=lxcfZku/uhGuk8yokqH2WaZ+jloQ85lqillMPiqaXSgPvhWT5/qCvOt/LB29RZcYHg
         mIllMij6oOC4gS/aTj1qiiXjdL6xxeAEE3MUZEpbx8v1iaA9JBC6Dg9RUtHPUWXgueFH
         xzqsnItJ6S25o8nyjQDZNzAFI5B+qjU4kTckRFaZ7kKf+9F0Bnvz2Aie0Bi6+vVKctLM
         JjDtMFe0a9Vh+HASj4sW3YcwGueVpy1UN6KAf9YpbHZLI/u8zkOQzQejW8XcmVwttZfE
         knPSyLxE+CBsvyi5OCbyRRV55R+SUHGqaRNhDzgwIpsbpxSfe9yzxSKHN+xdQSuRRoC3
         Jx5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YTwsOssKLuWm0RN1XuxIWtatvqfRvgRgu4IUBKS+A1E=;
        b=OnDOpebYng+wRbUpxGyOVb4MjxRe0wHqdi+fbje8oyEg3Vr4U2la3i5aDtmu1tHhLj
         EaYbjtL0DNBjn8pvhch0DsTtQqnVULYmhwwVWAVJbJ3CDfJAI9ntit0cR/OCqyFc0vWu
         s8/PeEXWYmhUa0HyneACRdQ/mhIUZ78HsPUg69Ylhl7XPTYxR6UzGdHMtOfjQ9+0o22k
         tugX48zfla5SeMWBHUKMxuv0X9elPOAOWdgm8B+4BuhzqD+s3BJbfUtO9TT8fTrLxTya
         MjLvxO+ZBpZYFRjtrTSJR01qZUPoNFuFEzzWtly9gedvSyVgyFazK4VbNzfT1zKoUJRa
         JlJQ==
X-Gm-Message-State: AOAM532j+0SbyNxcrEJt8z5+NJIUN89JfJvPKEIvQ/v8w4WoWS9ruOEs
        v0gFwZp926AAtNFgbyxyceOYH/z1vvLYeA==
X-Google-Smtp-Source: ABdhPJwv35pZlNQSjk6iJJG7gqftnATym/+wO2pXthdUXIpL2xmh6lYfYbnkOr+z9jFOEmCmiZ6itw==
X-Received: by 2002:a7b:c753:: with SMTP id w19mr4009720wmk.157.1599665826371;
        Wed, 09 Sep 2020 08:37:06 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a83sm4424122wmh.48.2020.09.09.08.37.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:37:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 1/2] wcn36xx: Mark internal smd functions static
Date:   Wed,  9 Sep 2020 16:37:52 +0100
Message-Id: <20200909153753.2905176-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153753.2905176-1-bryan.odonoghue@linaro.org>
References: <20200909153753.2905176-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit marks all smd.c functions that are only used inside of smd.c as
static. Previous commits added some VHT specific setup functions non-static
which is the right thing to do in terms of having granular git commits that
compile warning free. What we really want is for local not global scope on
those functions.

This patch makes the conversion from global to local scope.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 34 ++++++++++++++------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 18507b4d3681..61d9834b080d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -80,7 +80,7 @@ static struct wcn36xx_cfg_val wcn36xx_cfg_vals[] = {
 	WCN36XX_CFG_VAL(ENABLE_DYNAMIC_RA_START_RATE, 133), /* MCS 5 */
 };
 
-struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
+static struct wcn36xx_cfg_val wcn3680_cfg_vals[] = {
 	WCN36XX_CFG_VAL(CURRENT_TX_ANTENNA, 1),
 	WCN36XX_CFG_VAL(CURRENT_RX_ANTENNA, 1),
 	WCN36XX_CFG_VAL(LOW_GAIN_OVERRIDE, 0),
@@ -242,7 +242,7 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
-void
+static void
 wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta,
 			       struct wcn36xx_hal_config_bss_params_v1 *bss)
@@ -279,7 +279,7 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
-void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 		struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
@@ -301,7 +301,7 @@ void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
-void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+static void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (sta->ht_cap.ht_supported) {
@@ -326,7 +326,7 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
-void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
@@ -342,7 +342,7 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
-void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680)
@@ -1363,7 +1363,7 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
-void
+static void
 wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta,
@@ -1502,12 +1502,12 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				const u8 *bssid,
-				bool update,
-				struct wcn36xx_hal_config_bss_params *bss)
+static void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta,
+				       const u8 *bssid,
+				       bool update,
+				       struct wcn36xx_hal_config_bss_params *bss)
 {
 	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	struct wcn36xx_hal_config_sta_params *sta_params;
@@ -1715,9 +1715,11 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta, const u8 *bssid,
-			      bool update)
+static int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta,
+				     const u8 *bssid,
+				     bool update)
 {
 	struct wcn36xx_hal_config_bss_req_msg *msg;
 	struct wcn36xx_hal_config_bss_params *bss;
-- 
2.27.0

