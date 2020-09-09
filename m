Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECBBB2633C2
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730978AbgIIRJ7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1801BC0612F6
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:44 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id q9so2732107wmj.2
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bb83HCAluDLRPf/WFmZ9LIqNCsJ2xe/qCw3buaSSDk=;
        b=JQmdq/DmpRMuXqPjhMZTbESGSk0q4YnMaQhFqxvag3yXFNWjosuAlQjmpkSyL8GplP
         6424d70nxq8QD4uDwnnv/ihpOvF8iK7EpwbNOTGNd54Y/Rth91iwgjuaOeuHS+OsodYZ
         gieHSNWHvKTzKNLxBkElMXQ5O1jWzIYvazMkDqNMcM56Mfqn/QnsZQdyGIWM7XOKZFRp
         CLfIuOxLzzRvvecEaJosbaL6zeHmyn8CjGoVfWbhj3Gdoyc0DYuxA/ktLbySSpngE3yW
         gVEDeI97yJomHdMWHno3amIX2dAEyHspNZGw3Oe3vq35LjSz5oQoJv2I1Yolft03k4K3
         fSbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bb83HCAluDLRPf/WFmZ9LIqNCsJ2xe/qCw3buaSSDk=;
        b=Mn9UTMOZjyOIQZ4qiJYVtjaBHNze5YnAMpM4LfhL5JmqtTwDeMVN/NzsWqm9oL/I0m
         i9SEExfIa127aAO/5juWDUW6zqwRxibbmcWq61Yrt8YXkgdhUYG1TEYS3smGVeF0GXld
         47YLm1NbX/GjoHNx7mnLirCbArzG3+QGLshUSXNPwgo+SvERBwN+wPS8F2cVBQpAZA8+
         +W1qGzdvLRvG2MI4RS303z/RkeCcmefMNwsZeq051SbSrANtt1UfXsfn1V8zKV5ssoB1
         YC39ic4Ak6RYDdClF75HkddhetbeOwmn3Xt+5MbIoHPPld+shTvRVJS2iqz2gppljSfR
         BoVQ==
X-Gm-Message-State: AOAM530QMRL9AFpOGfqAEZg0bsGEI4/I+sNgGrQk8uKkrnllpFkcA7R0
        5MfMU4OrY9yhxEYKUuemP65U7w==
X-Google-Smtp-Source: ABdhPJyS2BgRP6d03iPIT16SDfw7Ckc07Dbx+GIGRrqVz1Qg0Xxq3a4EsbZ81iyzYqdxdVs1r/ggQA==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr3848922wmk.29.1599665742763;
        Wed, 09 Sep 2020 08:35:42 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:42 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 3/7] wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
Date:   Wed,  9 Sep 2020 16:36:24 +0100
Message-Id: <20200909153628.2904888-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
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
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 172 +++++++++++++------------
 1 file changed, 92 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 28a571918b19..3e8b929f45fc 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1384,6 +1384,97 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
+void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				const u8 *bssid,
+				bool update,
+				struct wcn36xx_hal_config_bss_params *bss)
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
@@ -1487,7 +1578,6 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -1539,7 +1629,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_req_msg *msg;
 	struct wcn36xx_hal_config_bss_params *bss;
 	struct wcn36xx_hal_config_sta_params *sta_params;
-	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
@@ -1553,84 +1642,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

