Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAE57256468
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgH2Dif (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726869AbgH2DiO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:14 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC600C06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:13 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id b79so837603wmb.4
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=snHNh5lKS2G0FTSISsFMGrkG2Oau7dqOyX8GcYHpHKE=;
        b=VXGiSssovhD85ZzX6cPZxqcb3woNczAD5mY0J+oiwZoAuDoFrqkaE/gWoQrtHpfTbY
         uY5tM+HqU58dWR523VrERY6qBdNRYW1oumhl4CwU3zdYj5pEn7Zj9zHj6UMLQA4jywgb
         ivl5GAEt1VrzfNN/nXTiT3ycxgD9AvsurXuB13mVqnWVhnOtTWRYzrJTweX3cblx6Grb
         LsHBeemlhHXc4xIZm1R1BPIJq5irfnKJyNpAwbQKdVJ/aFeqMDyidh0JsARITMbCohdD
         X6mZ7nYsCfeFs+atK7YFPeOKrLn3/j3AmbdC4md9tRwa/XlL2RWxCt+zP/Ckza2fk6TF
         2fgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=snHNh5lKS2G0FTSISsFMGrkG2Oau7dqOyX8GcYHpHKE=;
        b=iy7vJRlpLQMA6CdaUssg7Yx8DXw6HeLleogly7/DLcshObi5mNc/YkL/0MxdFpG2tk
         H9ANO94fQUvJLcCU+b9fPQPa/GwnFwCsAQGgr7Ts6CspU5cTxM1qhCMtthPLfZqIeAZw
         RzPJ5PgcPVOGdW+1fdQJS/7nKrMyeAeGs7W4aJqo+FADeimtUv/O0FWjd195J/3WEfVf
         Qp6lgFLmx1YohqfEIIqrm+1hd650CIr4zybo6+MBYrSQa5Z4JfoMUReKT853kkqXsXAF
         6TOYVNZRClSgiNa0RkCcyVl9pQa9B4WVbWJVL3JYSseUyV+0gO8+mDb79/7BnKdDOPm3
         9VaA==
X-Gm-Message-State: AOAM533kZIDSHF+Iow0yHEkoiMxyqde2rfxkfxXsJh6DzSvEvRTE4hlF
        eLDkRKxeoK2fF8us/rFZrgkoBg==
X-Google-Smtp-Source: ABdhPJwuyhe3avaI6oPw97TycrXcvk+R8x7BWKwg8AA1iakz9S5JGdWUFp/M7stKAevsJch/jOVtHg==
X-Received: by 2002:a1c:9a47:: with SMTP id c68mr1493787wme.33.1598672292408;
        Fri, 28 Aug 2020 20:38:12 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:12 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 09/10] wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
Date:   Sat, 29 Aug 2020 04:38:45 +0100
Message-Id: <20200829033846.2167619-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Two pointers are already defined in this function "bss" and "sta" which
point to fields within msg_body->bss_params.

We can substantially reduce the amount of extraneous text in this function
by making use of those pointers. This change makes the code easier to read
and modify.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 110 +++++++++++--------------
 1 file changed, 47 insertions(+), 63 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 92ae77523115..9490b1bf4e05 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1299,87 +1299,71 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	sta = &bss->sta;
 
 	/* convert orig to v1 */
-	memcpy(&msg_body->bss_params.bssid,
-	       &orig->bss_params.bssid, ETH_ALEN);
-	memcpy(&msg_body->bss_params.self_mac_addr,
-	       &orig->bss_params.self_mac_addr, ETH_ALEN);
+	memcpy(bss->bssid, &orig->bss_params.bssid, ETH_ALEN);
+	memcpy(bss->self_mac_addr, &orig->bss_params.self_mac_addr, ETH_ALEN);
 
-	msg_body->bss_params.bss_type = orig->bss_params.bss_type;
-	msg_body->bss_params.oper_mode = orig->bss_params.oper_mode;
-	msg_body->bss_params.nw_type = orig->bss_params.nw_type;
+	bss->bss_type = orig->bss_params.bss_type;
+	bss->oper_mode = orig->bss_params.oper_mode;
+	bss->nw_type = orig->bss_params.nw_type;
 
-	msg_body->bss_params.short_slot_time_supported =
+	bss->short_slot_time_supported =
 		orig->bss_params.short_slot_time_supported;
-	msg_body->bss_params.lla_coexist = orig->bss_params.lla_coexist;
-	msg_body->bss_params.llb_coexist = orig->bss_params.llb_coexist;
-	msg_body->bss_params.llg_coexist = orig->bss_params.llg_coexist;
-	msg_body->bss_params.ht20_coexist = orig->bss_params.ht20_coexist;
-	msg_body->bss_params.lln_non_gf_coexist =
-		orig->bss_params.lln_non_gf_coexist;
-
-	msg_body->bss_params.lsig_tx_op_protection_full_support =
+	bss->lla_coexist = orig->bss_params.lla_coexist;
+	bss->llb_coexist = orig->bss_params.llb_coexist;
+	bss->llg_coexist = orig->bss_params.llg_coexist;
+	bss->ht20_coexist = orig->bss_params.ht20_coexist;
+	bss->lln_non_gf_coexist = orig->bss_params.lln_non_gf_coexist;
+
+	bss->lsig_tx_op_protection_full_support =
 		orig->bss_params.lsig_tx_op_protection_full_support;
-	msg_body->bss_params.rifs_mode = orig->bss_params.rifs_mode;
-	msg_body->bss_params.beacon_interval = orig->bss_params.beacon_interval;
-	msg_body->bss_params.dtim_period = orig->bss_params.dtim_period;
-	msg_body->bss_params.tx_channel_width_set =
-		orig->bss_params.tx_channel_width_set;
-	msg_body->bss_params.oper_channel = orig->bss_params.oper_channel;
-	msg_body->bss_params.ext_channel = orig->bss_params.ext_channel;
-
-	msg_body->bss_params.reserved = orig->bss_params.reserved;
-
-	memcpy(&msg_body->bss_params.ssid,
-	       &orig->bss_params.ssid,
+	bss->rifs_mode = orig->bss_params.rifs_mode;
+	bss->beacon_interval = orig->bss_params.beacon_interval;
+	bss->dtim_period = orig->bss_params.dtim_period;
+	bss->tx_channel_width_set = orig->bss_params.tx_channel_width_set;
+	bss->oper_channel = orig->bss_params.oper_channel;
+	bss->ext_channel = orig->bss_params.ext_channel;
+
+	bss->reserved = orig->bss_params.reserved;
+
+	memcpy(&bss->ssid, &orig->bss_params.ssid,
 	       sizeof(orig->bss_params.ssid));
 
-	msg_body->bss_params.action = orig->bss_params.action;
-	msg_body->bss_params.rateset = orig->bss_params.rateset;
-	msg_body->bss_params.ht = orig->bss_params.ht;
-	msg_body->bss_params.obss_prot_enabled =
-		orig->bss_params.obss_prot_enabled;
-	msg_body->bss_params.rmf = orig->bss_params.rmf;
-	msg_body->bss_params.ht_oper_mode = orig->bss_params.ht_oper_mode;
-	msg_body->bss_params.dual_cts_protection =
-		orig->bss_params.dual_cts_protection;
-
-	msg_body->bss_params.max_probe_resp_retry_limit =
+	bss->action = orig->bss_params.action;
+	bss->rateset = orig->bss_params.rateset;
+	bss->ht = orig->bss_params.ht;
+	bss->obss_prot_enabled = orig->bss_params.obss_prot_enabled;
+	bss->rmf = orig->bss_params.rmf;
+	bss->ht_oper_mode = orig->bss_params.ht_oper_mode;
+	bss->dual_cts_protection = orig->bss_params.dual_cts_protection;
+
+	bss->max_probe_resp_retry_limit =
 		orig->bss_params.max_probe_resp_retry_limit;
-	msg_body->bss_params.hidden_ssid = orig->bss_params.hidden_ssid;
-	msg_body->bss_params.proxy_probe_resp =
-		orig->bss_params.proxy_probe_resp;
-	msg_body->bss_params.edca_params_valid =
-		orig->bss_params.edca_params_valid;
-
-	memcpy(&msg_body->bss_params.acbe,
-	       &orig->bss_params.acbe,
+	bss->hidden_ssid = orig->bss_params.hidden_ssid;
+	bss->proxy_probe_resp =	orig->bss_params.proxy_probe_resp;
+	bss->edca_params_valid = orig->bss_params.edca_params_valid;
+
+	memcpy(&bss->acbe, &orig->bss_params.acbe,
 	       sizeof(orig->bss_params.acbe));
-	memcpy(&msg_body->bss_params.acbk,
-	       &orig->bss_params.acbk,
+	memcpy(&bss->acbk, &orig->bss_params.acbk,
 	       sizeof(orig->bss_params.acbk));
-	memcpy(&msg_body->bss_params.acvi,
-	       &orig->bss_params.acvi,
+	memcpy(&bss->acvi, &orig->bss_params.acvi,
 	       sizeof(orig->bss_params.acvi));
-	memcpy(&msg_body->bss_params.acvo,
-	       &orig->bss_params.acvo,
+	memcpy(&bss->acvo, &orig->bss_params.acvo,
 	       sizeof(orig->bss_params.acvo));
 
-	msg_body->bss_params.ext_set_sta_key_param_valid =
+	bss->ext_set_sta_key_param_valid =
 		orig->bss_params.ext_set_sta_key_param_valid;
 
-	memcpy(&msg_body->bss_params.ext_set_sta_key_param,
+	memcpy(&bss->ext_set_sta_key_param,
 	       &orig->bss_params.ext_set_sta_key_param,
 	       sizeof(orig->bss_params.acvo));
 
-	msg_body->bss_params.wcn36xx_hal_persona =
-		orig->bss_params.wcn36xx_hal_persona;
-	msg_body->bss_params.spectrum_mgt_enable =
-		orig->bss_params.spectrum_mgt_enable;
-	msg_body->bss_params.tx_mgmt_power = orig->bss_params.tx_mgmt_power;
-	msg_body->bss_params.max_tx_power = orig->bss_params.max_tx_power;
+	bss->wcn36xx_hal_persona = orig->bss_params.wcn36xx_hal_persona;
+	bss->spectrum_mgt_enable = orig->bss_params.spectrum_mgt_enable;
+	bss->tx_mgmt_power = orig->bss_params.tx_mgmt_power;
+	bss->max_tx_power = orig->bss_params.max_tx_power;
 
-	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->bss_params.sta,
-				      &msg_body->bss_params.sta);
+	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->bss_params.sta, sta);
 
 	PREPARE_HAL_BUF(wcn->hal_buf, (*msg_body));
 
-- 
2.27.0

