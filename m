Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8354A239DA8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726993AbgHCDK4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726862AbgHCDKz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AEBC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:55 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q76so12875486wme.4
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sikUkIrUUUYDQIfnByPU/LmcIZ12zwkI3UVYfyuDjzw=;
        b=gBWc2vipv4uQatf9GMbAMQLNdYm/SL7Ww1x5Lk66em5Dg2oV6JKFhYKm4fU5SEHXi/
         5HVlmy5e32zZzLFnzPs5OjOZuIFc7TXRzRl2C63y5oV6Aouq6cheTPSvR0W0jgMzYXwA
         lzLu7oTrhqkW6h0jJhVVTTcirabTnKmFvPfSTkMn2eFt1NRD3Ht4kqjkLNj1Vrwl92XM
         F5Gr12zzg+TY5GrsOBBIgjS4A02HaGwCG4ZSukUHSKGo9/IH0Bo/6nLxEcofuf8IaDbm
         gUwPnPhEQlqoLYDmHTOGoGAgeuFBYTEryjURp8viFo3D6RO2Gx295Sx1eAajXDoTuA8w
         daXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sikUkIrUUUYDQIfnByPU/LmcIZ12zwkI3UVYfyuDjzw=;
        b=UN/jxggtxc4b/kFmYuzFvxaKNhLaatky+ln9wCYQnGVJTBT9Jkzc3gbArwSZBkQ/zO
         pYzjwtxkZ0eqa86Y+Ka+WjurwfnMryK+VkvLdRP4+jYybuUMuzO9eXsn9gbinA4lClPG
         Ehu9IZgqpA6WiduU+b4tkupMOW0QdGBLtiy/e11ua4BAaRxbefsMNRXyoiE9SmVzCzu9
         Tb9dhJebQ07KpQ36iG20JQMxLfLUI2uwnMvIOWsaEHrLY61UKkIBYPklQezVJs1LpulW
         Yum6lWqL+J45vfww8EMC2mXRFQ0zEFPrBQC1KURjIm/N2N8J7F4Mh1siaSMBxnSvhr3O
         Gevw==
X-Gm-Message-State: AOAM530VX6AbsZWDFy9ppeYbqVKA/fHGjRNfQBraE8MItGpAKEUcVmor
        Dj7sYF+4s+t5y31OMhTZopdx8h8xP7Q=
X-Google-Smtp-Source: ABdhPJy8NAMLlKsWOCeJ0I04rPKXFJtiKJiEnW2clNO8F+TQStp2EayD2xoUKXWcFR62PMcUh+xa5w==
X-Received: by 2002:a1c:2485:: with SMTP id k127mr13333234wmk.138.1596424254074;
        Sun, 02 Aug 2020 20:10:54 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:53 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 07/36] wcn36xx: Use existing pointers in wcn36xx_smd_config_bss_v1
Date:   Mon,  3 Aug 2020 04:11:03 +0100
Message-Id: <20200803031132.1427063-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 218f70283809..05835cf6e409 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1298,87 +1298,71 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
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

