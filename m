Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AADF239DBA
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727840AbgHCDLQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727812AbgHCDLP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:15 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2CF0C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:14 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a14so32807058wra.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pKx2vUsb2J83Nd1ElnjujJcXzTbgjOG6BmjNC2hrd9o=;
        b=glKF7drXVHhwTibsv3qDncmKpdlk6w4TMknv04P3xr8NhHbkqHl43KLlVhaPSMR9i6
         YfgtMXZGTbyeWXHpu5iQV2rbl2Qx0aUP6S/U8IM0DcRBhAE1NVTWf696tb8nv/U3rJBA
         atU19kieY6k1GGhGAi6gb6iNL/HtYwZCZ4cweHqJuAp2FFMdP1Nls2RKfWGLieepsbwV
         GX/TaziX1wrxMH3icMRsyP1vxfIMBbBIvsyxb+kUbksGkkqFuQMJsAf+Q8AE1xD40RM5
         z+zA7HL1CzwKwgYPSTNrpCu08cTkpYzGrB7gf4TpHWWF1DinAzqP2c6jerVW+0KwYK1J
         EqNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pKx2vUsb2J83Nd1ElnjujJcXzTbgjOG6BmjNC2hrd9o=;
        b=UtVUiCGU2OATFFiyt8hvFeCFzgEWpAwlEA0AY7uTgcFtC//ygQ9kyT7kJ+Uzer7kcn
         yCXBuLWB66zV8hsYEuTv9AGXwJ8iNkP8si73UqObAMchi72hssSl4cyW+8Z6NJ7//Sgz
         ZCVSpG4Mfi494kdN0DcB51IUv8WBxXmP1rJTK+GAStlgIE4HPB6fmsPaikFKnf1enEbE
         hv7yLMDENvX063z1M2xPQlebf7BODufw+An3NFTCllQKf7S7OnMYHgEgZNvl9Z9goDEg
         Dd2Lsvld5aa4NDOahdQ7wJA3+8eFrYYDo/kIzin49LXeuhp/2H0/eJaMlR+eK5LUmYLL
         5rGg==
X-Gm-Message-State: AOAM533VA5V/PJptT+V/hdaByx4tVRL3JNIByTqdshJvsLgrs1XT+tAJ
        iN4NFfjifjUP9npMM3SBBV7oVw==
X-Google-Smtp-Source: ABdhPJwcRFXEvP2M40fIApkCMzlxVrz1o6WiK+LAiko+4IDJS8HSu/2KVBe9I9DicgkpPgqheuXF1w==
X-Received: by 2002:a5d:55d2:: with SMTP id i18mr12585610wrw.378.1596424273692;
        Sun, 02 Aug 2020 20:11:13 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:13 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 25/36] wcn36xx: Update wcn36xx_smd_config_bss_v1() to operate internally
Date:   Mon,  3 Aug 2020 04:11:21 +0100
Message-Id: <20200803031132.1427063-26-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 115 +++++++++++++------------
 1 file changed, 59 insertions(+), 56 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 43021b13b5b0..50559871d109 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1477,11 +1477,13 @@ static void wcn36xx_smd_set_bss_params(struct wcn36xx *wcn,
 	vif_priv->bss_type = bss->bss_type;
 }
 
-static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
-			const struct wcn36xx_hal_config_bss_req_msg *orig)
+int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta_80211, const u8 *bssid,
+			      bool update)
 {
 	struct wcn36xx_hal_config_bss_req_msg_v1 *msg_body;
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
+	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
 	int ret;
 
@@ -1499,72 +1501,73 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss = &msg_body->bss_params;
 	sta = &bss->sta;
 
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
 
@@ -1705,7 +1708,7 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		    sta_params->mac);
 
 	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
-		ret = wcn36xx_smd_config_bss_v1(wcn, msg);
+		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
 	} else {
 		PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
 
-- 
2.27.0

