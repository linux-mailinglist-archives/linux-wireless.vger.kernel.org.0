Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73E43261A8D
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731794AbgIHSgu (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731403AbgIHScb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:31 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D4FC0617A3
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:15 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l9so304398wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2bb83HCAluDLRPf/WFmZ9LIqNCsJ2xe/qCw3buaSSDk=;
        b=bNNS+mdfG3LMvb1uwhdXes1htGVAIaVqty70MIaW7ALRAvqZsHlO+++KBtrKxKlp3r
         3tzBTUHN79U6mT7bWgue8NTM5Iu7fbJufz8IFDvCYiur3gPtPU5YgAS90JVtauXldS5g
         J5U0y4zk11NGT9b51wjPbfX9h+ckBL5EGcMTNtF0yesEtQFj5TSiSoQN3qRRsw1O/6MO
         Cf1TQZU4nm5plUDmXcnkvLUstwXPvK9eaIHmQ9/Xil97Pe2s+BaaSw9m75fDgCWHKSAS
         zCxCMLxHqjEEBnVw/yP53PN9dmWcN8AWIjpQdjuvPM6/+czyTjpIvrnfCw85eAQJav1x
         cy4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2bb83HCAluDLRPf/WFmZ9LIqNCsJ2xe/qCw3buaSSDk=;
        b=rRuaMyCBxL3bgJM1jhM6wrsUhN93A9657be+YhODcvB42VVRXA2wrNXfZeFWx/4zev
         LXYoDEyIne0kPjZN143I9GUBaB8pMa59Z6lZRU+g3S21JuGVbR91I7V3q9sThqcrqsnI
         4dMkK3C0zyBmjtxiP36wogbVEsfYMG5Wf9j0f3lnponnhuhRZf+O3tIJzilU+Ig4nFx0
         PQLb8Y/rU1Rq/ANN6p/hsKJuDEmkpxgokGLeD60L0xCwcusAnrGKtueXCvCwvktMmCVY
         zlzlYwHdiIF6uOLBTK0icq2j0rhhjGpl2N14HN28ha6bwI9BcmOqzK2jdodbYQYCm+lQ
         Om/w==
X-Gm-Message-State: AOAM533aF8tWDTxnH/OUAqVaFW++/iHYjLBHCHP9B2V7xsj0aDSeyDtS
        HVqctgJzR4CybOv6f2FR0+xF7Q==
X-Google-Smtp-Source: ABdhPJxQzS1xCYcPuUT+6ayrNAO15puWgGtRoe5Ky/URzcFXkcAC0XsR2/+GmVgKOs7akzBn6Vu5kQ==
X-Received: by 2002:a1c:92:: with SMTP id 140mr397804wma.39.1599589451702;
        Tue, 08 Sep 2020 11:24:11 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:11 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 3/7] wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
Date:   Tue,  8 Sep 2020 19:24:51 +0100
Message-Id: <20200908182455.2870345-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
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

