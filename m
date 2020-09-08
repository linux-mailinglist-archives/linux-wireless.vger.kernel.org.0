Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52CEA261A38
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731582AbgIHSds (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731451AbgIHSdj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:39 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF81C061573
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:33:38 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id z4so256923wrr.4
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:33:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qjd8fV7YLxTioYXpGkugtmpc2/qrixUOQBDAVrehnVM=;
        b=qgBhPVuVYy6Q8M49AdQ4WF2mbirJRIUSI4J3wlYPz640eBCc6tmic0Iz8gxn3XhkQP
         7zEGRjAcAPhDHZaCOM5xbJwTtkSzYSoopbdu5Oyh9FiURTVrchtpAW6xCdRo6mBqVp6w
         Ob3LUy3bw0r5dyGXxrBd4LIIiEueDOIFTMMMe4QfzKIOOSKZnepEenm6IeFPv15fVqCr
         JH4cYa4DUc8dVsUUlapx8f0t6oCZLdluoixyjs0ftCfoXbtH67WjrI55ZM18zsDXyLUu
         dWo9hor3bL7D6o3QGYKqjzQCsWdt9Y6lJRubeb+6JTS9cptFtgFJu/1qOkwVngDeCE+u
         7KEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qjd8fV7YLxTioYXpGkugtmpc2/qrixUOQBDAVrehnVM=;
        b=OXrB5pSJZVmXzSNQj/KqYq09pMK3jn0/yMvfYpAPI3z9pMJoJeWntQ2fo10k0H5MY4
         FvMGfGt/tUSc72+ShmdYA2lS5HwXXjK+Y5oGLTve07G1ARMGPj5rpE9djDjgTLjIMZRj
         JOx3hntuYlNWrAW21KePK0au8aE1emjJrvdMjbfbDI9VRGpTHgLb2BEjnWTxoEhct1uN
         dIqJy4Gopxq7lZHyntU3wtaBa/KbYWrCBKsYYq6jivXrUw2Yo8Ecs6qmAOKEib9hNoEe
         +s8LQOmjXDYq1FKfZPfJ0QuvbaGGbGFIJw2vSjyTBoKBXkIjymtCi2NSaGWMIM3LCzEk
         kGnw==
X-Gm-Message-State: AOAM532rUYDy/0DvZXK8sbdI3ZLS0vaCqH1LXFBmlgUj0Cu2X7K+8Wga
        oer4nL6gtvx1EYgo4pupsH/wBA==
X-Google-Smtp-Source: ABdhPJy9yk0CEBxQY1XHjqCi42d4Yfn+j1pgsy2tx2kEgJ+QZsQmVd7NTdAGfuZljgSUqD4qXr2NVA==
X-Received: by 2002:a5d:4603:: with SMTP id t3mr912133wrq.424.1599590017534;
        Tue, 08 Sep 2020 11:33:37 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b194sm294992wmd.42.2020.09.08.11.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:33:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/2] wcn36xx: Mark internal smd functions static
Date:   Tue,  8 Sep 2020 19:34:23 +0100
Message-Id: <20200908183424.2871101-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908183424.2871101-1-bryan.odonoghue@linaro.org>
References: <20200908183424.2871101-1-bryan.odonoghue@linaro.org>
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

