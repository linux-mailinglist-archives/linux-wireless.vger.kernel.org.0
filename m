Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 877AA261A5A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:35:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731453AbgIHSe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbgIHScb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:31 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22EC1C06138B
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:25:08 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id x23so286454wmi.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DAf97sptdgLCg/oA6L8vy5HwNzKTVCMj55H39bkxfx4=;
        b=CyNel8Fr0KQA8GWBzuf0PVqYs0SJ7zHsWSGVXSRDMAc4/i+rzHkGlDe+VdMywSFxRw
         JiBVorsUnAw33nkk6rf536t8cDBWD3oksA/Og6oEYudkAitMrJP0y0FcbGuaB6lbpL94
         L62nO8Jhb/KhxanIsc8OqyEtOPsza4BQ9U3X69Rv+ScOll72RP0lDmutDzRjtFQRvgpD
         c+RlljaF7oGLSCUzgawbNreV3/6GhlBRE/nI46Wm3SaW1/ICh9UZwG5DC4egTSDrAFRl
         gqgujj4gWqQkf8Th1o/8Ff1l+CalNoAf3mTitYjurzC6G1yEAFom4VgeSz6IcZ3/+tT2
         /wTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DAf97sptdgLCg/oA6L8vy5HwNzKTVCMj55H39bkxfx4=;
        b=COmUDIP8seBVg6ZXOcN3J3ULF0CyKPGo4SpC3r0BMwrJDyolB/QmiVW+crNOziijOg
         2gCWSK7LrqoiQceXa8Aj4XFVTp2YwsSglR2eGufJEHKnX2RZQz3zaWDqYZWsEJXm0Gop
         +VzfnUrDLsYdNZUBOpdsxvHmqNzmKaWdIfJXiPO87o8EDgRAAdKiCyBrfhh974itvK6U
         fw08vCWTnIKS4dvIj/Gy0oHweOhC8ZDELVSiqfo8mN8Xp2XQiPqXK80Dh1zGOfnrMVXU
         46bumRwe0285IaE1VG0UmGWwGK253WWrOl+hxiy/ASQK24yHZasR9nNXHNLt4GvN7MPL
         MouA==
X-Gm-Message-State: AOAM5310JgbxOc5t4BgCeSXgm7jZ8b/rH/sFeZ68tV56GF67B+BZj53c
        Dy9cMmTbS/wunelxR7HArnym5A==
X-Google-Smtp-Source: ABdhPJyukTXjXDtO21zToC6RG82Q5kXHR9bixgiXF2iaahJRpzXfdCWbjgWv7g8iTzO9SY5mMKbdtA==
X-Received: by 2002:a1c:dd45:: with SMTP id u66mr369833wmg.117.1599589506833;
        Tue, 08 Sep 2020 11:25:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c18sm376908wrx.63.2020.09.08.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:25:06 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/2] wcn36xx: Mark internal smd functions static
Date:   Tue,  8 Sep 2020 19:25:52 +0100
Message-Id: <20200908182553.2870585-2-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182553.2870585-1-pure.logic@nexus-software.ie>
References: <20200908182553.2870585-1-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

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
index ac10789332d8..a8d2af74ef62 100644
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
@@ -299,7 +299,7 @@ void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
-void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+static void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (sta->ht_cap.ht_supported) {
@@ -324,7 +324,7 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
-void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
@@ -340,7 +340,7 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
-void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680)
@@ -1361,7 +1361,7 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
-void
+static void
 wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta,
@@ -1500,12 +1500,12 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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
@@ -1713,9 +1713,11 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
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

