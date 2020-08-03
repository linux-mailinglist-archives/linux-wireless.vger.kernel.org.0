Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A54D239DB8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgHCDLO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgHCDLN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:13 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12E5EC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:13 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id t14so8893143wmi.3
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MEUWUJFP24hT9x0knHQlZkJe347puz4cw8J1YAVzn7s=;
        b=tKG17mtpsX0klVMiQxGI+DP8DvKFoPtEXyU3w+gbF7kgs/CcT9tn4rfnfDfmx/t6vP
         w42UmnPwT2YHvcR35nSq+yH091rRmmax8QzcJocshpBtTnoznSEAsYr6wooHcl+6wfzT
         ciqxOfZigb68eWDjW16OLoFlXWpp/vnBrV95zo5z+whMuKhAIcPxcVe8cWzvaYseJXpR
         B6O4OtOnvI/WaCs4Epxanrv+QjH0Hj0Wpx497osNE+uosqgLJwTK+dOnIqXS1aXQg6SW
         DOZ45Y//xObl70MVlqN2iu0JOdb1XzuCLW0dqdwnu5UhOo0rmTsYysNN+EwUNgb63cm8
         eCjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MEUWUJFP24hT9x0knHQlZkJe347puz4cw8J1YAVzn7s=;
        b=HlbJIYs+SFwikPYufF9ATAusnDuMELSHwv+AfqC5V60HclwZWsoYe68fl3QrlCRkfU
         Wzg7p4Bdmq6xOiK3ZX6kHdCIOCSK7BStOqPS3U1pvIExMUrhvQPH3DGYCKITQwEQXrZy
         xcATBQlXaI+wzyODkbhcwItx9UZYP7GQLCvNvd/VTHddNCAcFaB1q4HqkgsiMr+Q3BKI
         6XeRQlUpI9VrSg8b64BqRuPMkMucU/rtHURg7aVFp1nnNIfNR08rvmAH+JpnYwhBPB50
         mau63VlOk9D9ZkruckjsA2/x7ZjE4YntLbY7y45OX0ynpDM7tfPvvQnOZZxu/QKrjONy
         VTDQ==
X-Gm-Message-State: AOAM530Ki3qYNRWKifl4caMReSu7m/8gmhOhmr0jm7iO1X1q2AcJ/Ey1
        aFo1RjCVXuCLGNX0yA/XR6RfQA==
X-Google-Smtp-Source: ABdhPJxLYCwePtcOWFEDNHrWIt1Ml/bVrbBUuyqayiVs73koqXKtREHF9HYW7k3GlHolH7uUcPdQaQ==
X-Received: by 2002:a05:600c:2907:: with SMTP id i7mr13002404wmd.182.1596424271747;
        Sun, 02 Aug 2020 20:11:11 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 23/36] wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
Date:   Mon,  3 Aug 2020 04:11:19 +0100
Message-Id: <20200803031132.1427063-24-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 6232e64fb298..5fda63f79ca7 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1386,6 +1386,97 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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
@@ -1493,7 +1584,6 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -1545,7 +1635,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_req_msg *msg;
 	struct wcn36xx_hal_config_bss_params *bss;
 	struct wcn36xx_hal_config_sta_params *sta_params;
-	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
@@ -1559,84 +1648,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

