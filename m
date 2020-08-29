Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F02C8256479
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727783AbgH2DjI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH2Dis (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:48 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58743C061234
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:48 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id b79so838055wmb.4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Inet6OCfp+FQ7rBZ5m79Dx9CVjCkFP88QA/07j0o8NA=;
        b=iNNWC/2fCLSalsnwsckxWXqWvaK53tdB1wHKwQwJT9ji3W3NBg7ejB0p/22b6efFPH
         fQMAJO8A+fl0vSV1f1CQFkVSqg7TeCUhIX++n89CC1r3p2wdEMr6dHeNeQEMF2Fpb5nT
         MazZ+SvCTq1kaero31+cWaimSGzfseUAjtLKIIumHBfN8DTYjZT48zZfR3d+plOjkhLm
         6WHhllH/dqg00lOtlfp/7OixGHgj6WjBnPMz4xg4b/l+KQUAk+i0BtQFlfLuz3huDbog
         qoOTNH2lMGElqpsvNBE8OmPOvwb1sBk5j6VvP3rFV95YTfVr93+IRz0DFNqOrqEvo4bk
         TUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Inet6OCfp+FQ7rBZ5m79Dx9CVjCkFP88QA/07j0o8NA=;
        b=sUe8dykBCPdAMS1GjQVU3MNuxDJoyx2plaRrdbYBk4KpVK1zJSMwLusbNvgPBZ39gm
         mD/CHuWgq+0hlssr3CHP0icFbacwPIbQvkdwlrfmDbUn7J/03GzzCm8vJCkOuLZyCsMt
         PuMCEwQB8pen4ZdF4SyGep57Kr4zCD/OQ0KpvwLjsV4rIOmlVsJivas5tkuSbouAE+77
         a09YQ43CAElrCk3E0s6vh1BDLCGeZaqMN00aN+UpZTKcO7GgAGy1okYGs69vn41HfUQb
         Tb79NHLeBofQHreuFKO8rg8X7z758ckuunyoPEc2iIgOhG7MuuaZgHeDzQWKVparSuOX
         Csbg==
X-Gm-Message-State: AOAM533sxsh1qzaCWXcmKpedfg+v/kpJnp13vx7Q0u2LZ5dP+TM6N78C
        MKKGpsJZ2BGp2PvH/+PbAdp9sA==
X-Google-Smtp-Source: ABdhPJzSrig5k6c7XJ503+qiMIYQkgxl2UvrKeHKOpIFoy6GGnBAtSL/41HWSnoKt2MB73BADaKmEg==
X-Received: by 2002:a1c:988d:: with SMTP id a135mr1498416wme.8.1598672327030;
        Fri, 28 Aug 2020 20:38:47 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 3/7] wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
Date:   Sat, 29 Aug 2020 04:39:25 +0100
Message-Id: <20200829033929.2167761-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit moves BSS parameter setup to a separate function
wcn36xx_smd_set_bss_params(). This will allow for further functional
decomposition and fewer kzalloc() operations in subsequent patches.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 172 +++++++++++++------------
 1 file changed, 92 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 654ef074b1eb..4d15abed5493 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1392,6 +1392,97 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
+				       struct ieee80211_vif *vif,
+				       struct ieee80211_sta *sta,
+				       const u8 *bssid,
+				       bool update,
+				       struct wcn36xx_hal_config_bss_params *bss)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
+	struct wcn36xx_hal_config_sta_params *sta_params;
+
+	sta_params = &bss->sta;
+
+	WARN_ON(is_zero_ether_addr(bssid));
+
+	memcpy(&bss->bssid, bssid, ETH_ALEN);
+
+	memcpy(bss->self_mac_addr, vif->addr, ETH_ALEN);
+
+	if (vif->type == NL80211_IFTYPE_STATION) {
+		bss->bss_type = WCN36XX_HAL_INFRASTRUCTURE_MODE;
+
+		/* STA */
+		bss->oper_mode = 1;
+		bss->wcn36xx_hal_persona = WCN36XX_HAL_STA_MODE;
+	} else if (vif->type == NL80211_IFTYPE_AP ||
+		   vif->type == NL80211_IFTYPE_MESH_POINT) {
+		bss->bss_type = WCN36XX_HAL_INFRA_AP_MODE;
+
+		/* AP */
+		bss->oper_mode = 0;
+		bss->wcn36xx_hal_persona = WCN36XX_HAL_STA_SAP_MODE;
+	} else if (vif->type == NL80211_IFTYPE_ADHOC) {
+		bss->bss_type = WCN36XX_HAL_IBSS_MODE;
+
+		/* STA */
+		bss->oper_mode = 1;
+	} else {
+		wcn36xx_warn("Unknown type for bss config: %d\n", vif->type);
+	}
+
+	if (vif->type == NL80211_IFTYPE_STATION)
+		wcn36xx_smd_set_bss_nw_type(wcn, sta, bss);
+	else
+		bss->nw_type = WCN36XX_HAL_11N_NW_TYPE;
+
+	bss->short_slot_time_supported = vif->bss_conf.use_short_slot;
+	bss->lla_coexist = 0;
+	bss->llb_coexist = 0;
+	bss->llg_coexist = 0;
+	bss->rifs_mode = 0;
+	bss->beacon_interval = vif->bss_conf.beacon_int;
+	bss->dtim_period = vif_priv->dtim_period;
+
+	wcn36xx_smd_set_bss_ht_params(vif, sta, bss);
+
+	bss->oper_channel = WCN36XX_HW_CHANNEL(wcn);
+
+	if (conf_is_ht40_minus(&wcn->hw->conf))
+		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
+	else if (conf_is_ht40_plus(&wcn->hw->conf))
+		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
+	else
+		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
+
+	bss->reserved = 0;
+
+	/* wcn->ssid is only valid in AP and IBSS mode */
+	bss->ssid.length = vif_priv->ssid.length;
+	memcpy(bss->ssid.ssid, vif_priv->ssid.ssid, vif_priv->ssid.length);
+
+	bss->obss_prot_enabled = 0;
+	bss->rmf = 0;
+	bss->max_probe_resp_retry_limit = 0;
+	bss->hidden_ssid = vif->bss_conf.hidden_ssid;
+	bss->proxy_probe_resp = 0;
+	bss->edca_params_valid = 0;
+
+	/* FIXME: set acbe, acbk, acvi and acvo */
+
+	bss->ext_set_sta_key_param_valid = 0;
+
+	/* FIXME: set ext_set_sta_key_param */
+
+	bss->spectrum_mgt_enable = 0;
+	bss->tx_mgmt_power = 0;
+	bss->max_tx_power = WCN36XX_MAX_POWER(wcn);
+	bss->action = update;
+
+	vif_priv->bss_type = bss->bss_type;
+}
+
 static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 			const struct wcn36xx_hal_config_bss_req_msg *orig)
 {
@@ -1499,7 +1590,6 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -1551,7 +1641,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_req_msg *msg;
 	struct wcn36xx_hal_config_bss_params *bss;
 	struct wcn36xx_hal_config_sta_params *sta_params;
-	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
@@ -1565,84 +1654,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	bss = &msg->bss_params;
 	sta_params = &bss->sta;
 
-	WARN_ON(is_zero_ether_addr(bssid));
-
-	memcpy(&bss->bssid, bssid, ETH_ALEN);
-
-	memcpy(bss->self_mac_addr, vif->addr, ETH_ALEN);
-
-	if (vif->type == NL80211_IFTYPE_STATION) {
-		bss->bss_type = WCN36XX_HAL_INFRASTRUCTURE_MODE;
-
-		/* STA */
-		bss->oper_mode = 1;
-		bss->wcn36xx_hal_persona = WCN36XX_HAL_STA_MODE;
-	} else if (vif->type == NL80211_IFTYPE_AP ||
-		   vif->type == NL80211_IFTYPE_MESH_POINT) {
-		bss->bss_type = WCN36XX_HAL_INFRA_AP_MODE;
-
-		/* AP */
-		bss->oper_mode = 0;
-		bss->wcn36xx_hal_persona = WCN36XX_HAL_STA_SAP_MODE;
-	} else if (vif->type == NL80211_IFTYPE_ADHOC) {
-		bss->bss_type = WCN36XX_HAL_IBSS_MODE;
-
-		/* STA */
-		bss->oper_mode = 1;
-	} else {
-		wcn36xx_warn("Unknown type for bss config: %d\n", vif->type);
-	}
-
-	if (vif->type == NL80211_IFTYPE_STATION)
-		wcn36xx_smd_set_bss_nw_type(wcn, sta, bss);
-	else
-		bss->nw_type = WCN36XX_HAL_11N_NW_TYPE;
-
-	bss->short_slot_time_supported = vif->bss_conf.use_short_slot;
-	bss->lla_coexist = 0;
-	bss->llb_coexist = 0;
-	bss->llg_coexist = 0;
-	bss->rifs_mode = 0;
-	bss->beacon_interval = vif->bss_conf.beacon_int;
-	bss->dtim_period = vif_priv->dtim_period;
-
-	wcn36xx_smd_set_bss_ht_params(vif, sta, bss);
-
-	bss->oper_channel = WCN36XX_HW_CHANNEL(wcn);
-
-	if (conf_is_ht40_minus(&wcn->hw->conf))
-		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_BELOW;
-	else if (conf_is_ht40_plus(&wcn->hw->conf))
-		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_ABOVE;
-	else
-		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
-
-	bss->reserved = 0;
-
-	/* wcn->ssid is only valid in AP and IBSS mode */
-	bss->ssid.length = vif_priv->ssid.length;
-	memcpy(bss->ssid.ssid, vif_priv->ssid.ssid, vif_priv->ssid.length);
-
-	bss->obss_prot_enabled = 0;
-	bss->rmf = 0;
-	bss->max_probe_resp_retry_limit = 0;
-	bss->hidden_ssid = vif->bss_conf.hidden_ssid;
-	bss->proxy_probe_resp = 0;
-	bss->edca_params_valid = 0;
-
-	/* FIXME: set acbe, acbk, acvi and acvo */
-
-	bss->ext_set_sta_key_param_valid = 0;
-
-	/* FIXME: set ext_set_sta_key_param */
-
-	bss->spectrum_mgt_enable = 0;
-	bss->tx_mgmt_power = 0;
-	bss->max_tx_power = WCN36XX_MAX_POWER(wcn);
-	bss->action = update;
-
-	vif_priv->bss_type = bss->bss_type;
-
+	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
 	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
-- 
2.27.0

