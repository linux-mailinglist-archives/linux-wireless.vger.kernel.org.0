Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0FB8264F18
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:34:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726899AbgIJTeS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:34:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731405AbgIJPsO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:14 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 988E1C061347
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:59 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id x14so7053429wrl.12
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bux7fAG0+zOODRO5fQccC45bmW3bWHTSwsrxqwBCgeg=;
        b=EAtrRbzxlI8L7D+Mx1FEFBHBOY14RfStjnJdk7p0Gt4QMaL/0kDxz52hvNrTiFPO1I
         B7bd4UNzRxFRoF1cQGLBVMLkisIm6yqsSXH+4WAYWQrJMpF37g/sVqe6TakU9cvlp9LK
         9dRlP/IZPy1mZucFDmuAg9O9LOJO+U2sdsAgjmY+NwnC0UdHeM7pU8+gLmH8J+gF9KoZ
         SrIrHTOVDM7C0rAgLdk8MSEBugeYEF1qAoVAT4Pkp69vWx0kt6SoSoo8aXgJS5mlJtmG
         m1tkznaKYVKtRgqHLzM+1qIpdw6j1tliiiwcOFTpx0B0sU+Mv3qTed0Vf9vJVwXEk6Ru
         PQhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bux7fAG0+zOODRO5fQccC45bmW3bWHTSwsrxqwBCgeg=;
        b=eUSVVCM9sxFyC1C0BTUXdoWA3yHltarzkjtp3+n7PRu7s0l/S/7OIZa35c+6q57ulG
         Mn9QSjinUO/ILOs8Xm5eMbsmo5sXgKoFdeBrd6zSPaY7AeMZDVHJSh1uMK2TK+YQkAqC
         eU5ycMCELEY1VXjjBo2bZsOny+/zEUUcc6eM3UMoyT3r1VCx5RQ3YAS174l24ZRzkeBZ
         gXRj2CkXEGu+ZHHK/F5c6kasrkc4MFwKgRcRIGI3k2PoERDD7/JTIjOZnWJK1rXOicyK
         VO1GIDvm+Ddap6pxsePKP2gScQ0JgEXEQ1FCE21fiSbe2IAbA+wxLl5X+wdHkL6OgSlx
         /oHg==
X-Gm-Message-State: AOAM531cow9K6GWLtxYopys4dtZPItFmSv8dHUFrCS/uvMynOUZ4+a1i
        GNw8djwhI7/7niwyVrjSDRr/xg==
X-Google-Smtp-Source: ABdhPJxY3awhQi65w0bK3UUvTHgep0wUBRBirhrhvW+wuRnVmMrPNrPo0xeU2ACrAxqCZHT7e6w82w==
X-Received: by 2002:adf:a1d6:: with SMTP id v22mr9788348wrv.185.1599750478327;
        Thu, 10 Sep 2020 08:07:58 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a17sm9732901wra.24.2020.09.10.08.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:57 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/2] wcn36xx: Mark internal smd functions static
Date:   Thu, 10 Sep 2020 16:08:44 +0100
Message-Id: <20200910150845.2179320-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
References: <20200910150845.2179320-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 61 ++++++++------------------
 1 file changed, 18 insertions(+), 43 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e74abc153153..bccdae62ffbc 100644
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
@@ -242,11 +242,7 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
-void
-wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
-			       struct ieee80211_sta *sta,
-			       struct wcn36xx_hal_config_bss_params_v1 *bss);
-void
+static void
 wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
 			       struct ieee80211_sta *sta,
 			       struct wcn36xx_hal_config_bss_params_v1 *bss)
@@ -283,10 +279,7 @@ static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 	}
 }
 
-void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
-		struct ieee80211_sta *sta,
-		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
-void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 		struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
@@ -308,9 +301,7 @@ void wcn36xx_smd_set_sta_vht_params(struct wcn36xx *wcn,
 	}
 }
 
-void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
-		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
-void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
+static void wcn36xx_smd_set_sta_ht_ldpc_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (sta->ht_cap.ht_supported) {
@@ -335,9 +326,7 @@ static void wcn36xx_smd_set_sta_default_ht_params(
 	sta_params->dsss_cck_mode_40mhz = 1;
 }
 
-void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
-		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
-void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
@@ -353,9 +342,7 @@ void wcn36xx_smd_set_sta_default_vht_params(struct wcn36xx *wcn,
 	sta_params->vht_tx_bf_enabled = 0;
 }
 
-void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
-		struct wcn36xx_hal_config_sta_params_v1 *sta_params);
-void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
+static void wcn36xx_smd_set_sta_default_ht_ldpc_params(struct wcn36xx *wcn,
 		struct wcn36xx_hal_config_sta_params_v1 *sta_params)
 {
 	if (wcn->rf_id == RF_IRIS_WCN3680)
@@ -1376,12 +1363,7 @@ static void wcn36xx_smd_convert_sta_to_v1(struct wcn36xx *wcn,
 	v1->p2p = orig->p2p;
 }
 
-void
-wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
-			      struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta,
-			      struct wcn36xx_hal_config_sta_params_v1 *sta_par);
-void
+static void
 wcn36xx_smd_set_sta_params_v1(struct wcn36xx *wcn,
 			      struct ieee80211_vif *vif,
 			      struct ieee80211_sta *sta,
@@ -1520,18 +1502,12 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
-				struct ieee80211_vif *vif,
-				struct ieee80211_sta *sta,
-				const u8 *bssid,
-				bool update,
-				struct wcn36xx_hal_config_bss_params *bss);
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
 
@@ -1736,12 +1712,11 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
-			      struct ieee80211_sta *sta, const u8 *bssid,
-			      bool update);
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

