Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD84261A84
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731858AbgIHSgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731758AbgIHScq (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:46 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7106BC0617A4
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:15 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id l9so304421wme.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Nq2zvDwY36ADBkPvbURAQy+9pgEoAZ5b/bksokgvCk=;
        b=pdhz58Hj7RgWbQ1DDDx4cMT3OZl5JZTNkNca5UgGjJ2yVOKQHyUyTLgWAFip91Dj+R
         rMW2X4OgmwD5CkZ2ci00oaMiSTwr0ikjwccae8V9cUdnkqxnoGo3LG+diXqUeNQ5qXiW
         /v5Ph4oDDANK5DsGej7qLDbWAZfYI0k2u8a2kFJoCun4ugls063hSrv/lQplb+kqiggc
         OX7BLk5GQ7tBbjzYMLwFxnwukJxKiEfubZ0Z2wzoiGKWHR8PaPLW5VFG0pgF4O/UijqS
         l0KfGGDs8c7FkuSwhGbqi8scZJiNMsGaW9jfYCKeX6nRhJsnSAixDenjazasVQPMIQad
         RtXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Nq2zvDwY36ADBkPvbURAQy+9pgEoAZ5b/bksokgvCk=;
        b=GIvO4HtFaoKgfv+/H0dQGZ75scthswYcJHGwIETlubjSWyifAn7gk2LzAPjqoK1hwN
         noLEHteVhNRHtssW+Zr1IiIbel5JUxHoQTEEeYfKMbzbEA4NysU4/16VJWl3XdLsJSSD
         FI9G/9IoZ4xxnQf9v9eelZAZY20i2vwECDrlTVnsJtNW98UPyvgKKQeymk2S8o5ApHaX
         ekby8Sd80TyB5Je79iRss/Vdrtxn3gPOR1CCjDC8lL7tNLm3YDSKHElRkMUmSPPUXUeD
         JH15rF//ekDDWB+Vfv16woKMynz5SM5pMtp+bAgbEAOASYreXZlbR1kEvwfo7s8qgVOu
         vteQ==
X-Gm-Message-State: AOAM532Qh48nJ1hkkm52/C0+xEHD1XDZKqQIe28UlYK/UsptEgpjoqRt
        aztPvhywePshXbnmsEvVdXuTuCY4zqCqJA==
X-Google-Smtp-Source: ABdhPJw8wRgR8xPLATFIfg5zzW5seAvT5Poumar3kHVPVG5l6QSjRQAnAurXuauOxYiy3tVi/WxehQ==
X-Received: by 2002:a1c:2903:: with SMTP id p3mr404022wmp.170.1599589454147;
        Tue, 08 Sep 2020 11:24:14 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 4/7] wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
Date:   Tue,  8 Sep 2020 19:24:52 +0100
Message-Id: <20200908182455.2870345-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch updates wcn36xx_smd_config_bss_v1() to update on internally
derived parameters only, specifically making use of STA v1 wrapper routines
previously added.

Once done we no longer need to pass a struct wcn36xx_hal_config_bss_req_msg
which gives us options in later patches to eliminate the kzalloc() in
wcn36xx_smd_config_bss entirely.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 116 +++++++++++++------------
 1 file changed, 61 insertions(+), 55 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 3e8b929f45fc..7e3302ba97fa 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1476,10 +1476,14 @@ void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
 }
 
 static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
-			const struct wcn36xx_hal_config_bss_req_msg *orig)
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta_80211,
+				     const u8 *bssid,
+				     bool update)
 {
 	struct wcn36xx_hal_config_bss_req_msg_v1 *msg_body;
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
+	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
 	int ret;
 
@@ -1493,72 +1497,74 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss = &msg_body->bss_params;
 	sta = &bss->sta;
 
+	memset(&bss_v0, 0x00, sizeof(bss_v0));
+	wcn36xx_smd_set_bss_params(wcn, vif, sta_80211, bssid, update, &bss_v0);
+	wcn36xx_smd_set_sta_params_v1(wcn, vif, sta_80211, sta);
+
 	/* convert orig to v1 */
-	memcpy(bss->bssid, &orig->bss_params.bssid, ETH_ALEN);
-	memcpy(bss->self_mac_addr, &orig->bss_params.self_mac_addr, ETH_ALEN);
+	memcpy(bss->bssid, &bss_v0.bssid, ETH_ALEN);
+	memcpy(bss->self_mac_addr, &bss_v0.self_mac_addr, ETH_ALEN);
 
-	bss->bss_type = orig->bss_params.bss_type;
-	bss->oper_mode = orig->bss_params.oper_mode;
-	bss->nw_type = orig->bss_params.nw_type;
+	bss->bss_type = bss_v0.bss_type;
+	bss->oper_mode = bss_v0.oper_mode;
+	bss->nw_type = bss_v0.nw_type;
 
 	bss->short_slot_time_supported =
-		orig->bss_params.short_slot_time_supported;
-	bss->lla_coexist = orig->bss_params.lla_coexist;
-	bss->llb_coexist = orig->bss_params.llb_coexist;
-	bss->llg_coexist = orig->bss_params.llg_coexist;
-	bss->ht20_coexist = orig->bss_params.ht20_coexist;
-	bss->lln_non_gf_coexist = orig->bss_params.lln_non_gf_coexist;
+		bss_v0.short_slot_time_supported;
+	bss->lla_coexist = bss_v0.lla_coexist;
+	bss->llb_coexist = bss_v0.llb_coexist;
+	bss->llg_coexist = bss_v0.llg_coexist;
+	bss->ht20_coexist = bss_v0.ht20_coexist;
+	bss->lln_non_gf_coexist = bss_v0.lln_non_gf_coexist;
 
 	bss->lsig_tx_op_protection_full_support =
-		orig->bss_params.lsig_tx_op_protection_full_support;
-	bss->rifs_mode = orig->bss_params.rifs_mode;
-	bss->beacon_interval = orig->bss_params.beacon_interval;
-	bss->dtim_period = orig->bss_params.dtim_period;
-	bss->tx_channel_width_set = orig->bss_params.tx_channel_width_set;
-	bss->oper_channel = orig->bss_params.oper_channel;
-	bss->ext_channel = orig->bss_params.ext_channel;
-
-	bss->reserved = orig->bss_params.reserved;
-
-	memcpy(&bss->ssid, &orig->bss_params.ssid,
-	       sizeof(orig->bss_params.ssid));
-
-	bss->action = orig->bss_params.action;
-	bss->rateset = orig->bss_params.rateset;
-	bss->ht = orig->bss_params.ht;
-	bss->obss_prot_enabled = orig->bss_params.obss_prot_enabled;
-	bss->rmf = orig->bss_params.rmf;
-	bss->ht_oper_mode = orig->bss_params.ht_oper_mode;
-	bss->dual_cts_protection = orig->bss_params.dual_cts_protection;
+		bss_v0.lsig_tx_op_protection_full_support;
+	bss->rifs_mode = bss_v0.rifs_mode;
+	bss->beacon_interval = bss_v0.beacon_interval;
+	bss->dtim_period = bss_v0.dtim_period;
+	bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
+	bss->oper_channel = bss_v0.oper_channel;
+	bss->ext_channel = bss_v0.ext_channel;
+
+	bss->reserved = bss_v0.reserved;
+
+	memcpy(&bss->ssid, &bss_v0.ssid,
+	       sizeof(bss_v0.ssid));
+
+	bss->action = bss_v0.action;
+	bss->rateset = bss_v0.rateset;
+	bss->ht = bss_v0.ht;
+	bss->obss_prot_enabled = bss_v0.obss_prot_enabled;
+	bss->rmf = bss_v0.rmf;
+	bss->ht_oper_mode = bss_v0.ht_oper_mode;
+	bss->dual_cts_protection = bss_v0.dual_cts_protection;
 
 	bss->max_probe_resp_retry_limit =
-		orig->bss_params.max_probe_resp_retry_limit;
-	bss->hidden_ssid = orig->bss_params.hidden_ssid;
-	bss->proxy_probe_resp =	orig->bss_params.proxy_probe_resp;
-	bss->edca_params_valid = orig->bss_params.edca_params_valid;
-
-	memcpy(&bss->acbe, &orig->bss_params.acbe,
-	       sizeof(orig->bss_params.acbe));
-	memcpy(&bss->acbk, &orig->bss_params.acbk,
-	       sizeof(orig->bss_params.acbk));
-	memcpy(&bss->acvi, &orig->bss_params.acvi,
-	       sizeof(orig->bss_params.acvi));
-	memcpy(&bss->acvo, &orig->bss_params.acvo,
-	       sizeof(orig->bss_params.acvo));
+		bss_v0.max_probe_resp_retry_limit;
+	bss->hidden_ssid = bss_v0.hidden_ssid;
+	bss->proxy_probe_resp =	bss_v0.proxy_probe_resp;
+	bss->edca_params_valid = bss_v0.edca_params_valid;
+
+	memcpy(&bss->acbe, &bss_v0.acbe,
+	       sizeof(bss_v0.acbe));
+	memcpy(&bss->acbk, &bss_v0.acbk,
+	       sizeof(bss_v0.acbk));
+	memcpy(&bss->acvi, &bss_v0.acvi,
+	       sizeof(bss_v0.acvi));
+	memcpy(&bss->acvo, &bss_v0.acvo,
+	       sizeof(bss_v0.acvo));
 
 	bss->ext_set_sta_key_param_valid =
-		orig->bss_params.ext_set_sta_key_param_valid;
+		bss_v0.ext_set_sta_key_param_valid;
 
 	memcpy(&bss->ext_set_sta_key_param,
-	       &orig->bss_params.ext_set_sta_key_param,
-	       sizeof(orig->bss_params.acvo));
-
-	bss->wcn36xx_hal_persona = orig->bss_params.wcn36xx_hal_persona;
-	bss->spectrum_mgt_enable = orig->bss_params.spectrum_mgt_enable;
-	bss->tx_mgmt_power = orig->bss_params.tx_mgmt_power;
-	bss->max_tx_power = orig->bss_params.max_tx_power;
+	       &bss_v0.ext_set_sta_key_param,
+	       sizeof(bss_v0.acvo));
 
-	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->bss_params.sta, sta);
+	bss->wcn36xx_hal_persona = bss_v0.wcn36xx_hal_persona;
+	bss->spectrum_mgt_enable = bss_v0.spectrum_mgt_enable;
+	bss->tx_mgmt_power = bss_v0.tx_mgmt_power;
+	bss->max_tx_power = bss_v0.max_tx_power;
 
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
@@ -1658,7 +1664,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		    sta_params->mac);
 
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
-		ret = wcn36xx_smd_config_bss_v1(wcn, msg);
+		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
 		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
 
-- 
2.27.0

