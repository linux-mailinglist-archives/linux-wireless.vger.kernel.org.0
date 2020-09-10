Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBE0264B78
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 19:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgIJRjN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 13:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727853AbgIJRhg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 13:37:36 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1007AC061799
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id a9so381463wmm.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=C1kM/nc6ngULE2TMZqCWmpEyLxElDiaI0yH/xvzMhMM=;
        b=M2Wg92rS/qXH/CKBPOKrB8DyumKnguAlhB9mxAWkLq6IZ7txZ1uptKFQqVwPl/Aldu
         0HY3u9jPgVS335mW+yaAKF8P4pV7Dmss/dc516MWRktquag0EZcvrD48lLEQvXu/d2wV
         QSuf9uBMicyCpg5h1ce7geqEBYE1CDvp6hLctVYA+MeYRfkcV5gQH6Of+ItsfqeNDsEr
         DXb0tLRloFvMLfDyu3lO2KoQmugmxztfH8t5CIEex/cg3Arxa69oKoOOia9hvP7VvGoq
         I8STni2IgHRP7Yo2qSsO044hW7sdWpv1moMNaQS7z6lVfcXw39HvBYAqWosCUXoCTG5j
         Nxhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=C1kM/nc6ngULE2TMZqCWmpEyLxElDiaI0yH/xvzMhMM=;
        b=c9wOmO494mkdtI7OIU0XmKQhIdZLAup2Ydus18vv9uV5bcqkBOPIaPkeLRVFz29gSN
         uBNOcJDy7B3G6/cfNPaDzJdYYAWweVUuSgGtN+mQxRniGu20LMi7RiRFoCEIDeRTyYYS
         xZykvK2uqroMikr+/kkHvK2TS8sx3ScFVh1ltz+KNjElIONMBoYzQHsugQH18TTlmya6
         as5F8SRTVQNVQ94p5wLvW2ozJ/ZHM98WV25/ojj6mcmryKQmRTQNIOhbUMKJbgaWM3/a
         xmXLFzGbRlvrVobtxh2X5JEE+szJyroEOXiphKETL1WuedCjEx9oNdBT5ySl716HbGOL
         BQUQ==
X-Gm-Message-State: AOAM533bgjkLiXEf0zzrzzRN65jp1z1OEtOg49s/aEkX+pIGKnXf0RqZ
        Yc37v1VCFgGALN4YZhhmFOpxzg==
X-Google-Smtp-Source: ABdhPJyMhq5Oev5MwsqfgmOkHLnBUvi67jZCh7iGWgKNqyWwwmcA5J4VEpIClMWJFJF/3vM0H6QX/w==
X-Received: by 2002:a1c:2501:: with SMTP id l1mr525100wml.16.1599750346719;
        Thu, 10 Sep 2020 08:05:46 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 3/7] wcn36xx: Move BSS parameter setup to wcn36xx_smd_set_bss_params()
Date:   Thu, 10 Sep 2020 16:06:27 +0100
Message-Id: <20200910150631.2178970-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 175 ++++++++++++++-----------
 1 file changed, 95 insertions(+), 80 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index fa4357b36a8e..4be9def9509c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1402,6 +1402,100 @@ int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	return ret;
 }
 
+void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				const u8 *bssid,
+				bool update,
+				struct wcn36xx_hal_config_bss_params *bss);
+void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
+				struct ieee80211_vif *vif,
+				struct ieee80211_sta *sta,
+				const u8 *bssid,
+				bool update,
+				struct wcn36xx_hal_config_bss_params *bss)
+{
+	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
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
@@ -1505,7 +1599,6 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
-
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
@@ -1557,7 +1650,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 	struct wcn36xx_hal_config_bss_req_msg *msg;
 	struct wcn36xx_hal_config_bss_params *bss;
 	struct wcn36xx_hal_config_sta_params *sta_params;
-	struct wcn36xx_vif *vif_priv = wcn36xx_vif_to_priv(vif);
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
@@ -1571,84 +1663,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
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

