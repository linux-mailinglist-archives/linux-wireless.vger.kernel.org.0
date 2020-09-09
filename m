Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C1AE2633A0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730480AbgIIRHi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:07:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730395AbgIIPhU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:37:20 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A10F0C061364
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:37:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id k15so3431911wrn.10
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:37:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qir4TYRC59wb4Iq2ZGJgB2PzB7fCjBhXW6Ruce9uYLI=;
        b=O6f2xHhI8TDqRXtwMuzZonh8355rfk4tgipDXSC6q4VEZ9xjXWirQuYN53wUxy/miO
         qVY84BNeZq6C5l1x7LRWC18imlWrA43Do0vVNOboCzc+2ZX0R0VydiNBNfrldD+Ntzat
         At8iFe3hHDk6+f/g6QUmZLAOxAbv7jw0rl9Vcz3VSVnlz5ZB24kERu5MB6FZbjq698B+
         yC8972OAiKd2h13W6h8qOa/dFzaE20LmLuaiPaduF+GtlTbMtIifeDgA1JEBsExtCaJG
         i4Ot0sMDLXRBW4YLkMGimisb5waDZXd2S6n55nfLW05brHeOLI9AXTtEACx8fpJ1Xp5A
         SzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qir4TYRC59wb4Iq2ZGJgB2PzB7fCjBhXW6Ruce9uYLI=;
        b=YBfMLJwKElD4hv3qb5LeX62hyuNeT94J6V+qp8LxZm43APejI0ylF9KpBS7Kbk6tLh
         US2BIEdhH6lbgzr433XxNusjmkk+0v8lWaDWJDpqLeyvJFHSz3DM6L/LqqABFmKd0dJe
         9cdMAB4ECkOkna8fcHKKFjXPYo3Bo9TxZhfGukhelwz2yS74anJfDn7KyzzEQKi9QkPh
         bnDc9wTSLa1DKx0vp6q6wa01t3ABzfRsnwhAUukA4G6yGft68/6szHoGu0EmgtVouKUA
         1t11l7ChUTskQEL6bHttS96gXpuRGgxe1UNbKm/Wk9MedSae5tOjDVsinCTP/LOtljQW
         4l9Q==
X-Gm-Message-State: AOAM532WNQsKpEGgtP6xJ/l9/dQxP/JNdRHHBxM8kgIRbhNYEB499hDj
        3LQfMCw5HGajkRPGpJxRhBk/ig==
X-Google-Smtp-Source: ABdhPJwbeJ595g88LofhB2giLDjCH6bKnkGdiKFNxzX96rRexMOPhB53+cnN4Is8qhOP5x5JPAnCfw==
X-Received: by 2002:a5d:460c:: with SMTP id t12mr4442764wrq.225.1599665828327;
        Wed, 09 Sep 2020 08:37:08 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id a83sm4424122wmh.48.2020.09.09.08.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:37:07 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/2] wcn36xx: Ensure spaces between functions
Date:   Wed,  9 Sep 2020 16:37:53 +0100
Message-Id: <20200909153753.2905176-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153753.2905176-1-bryan.odonoghue@linaro.org>
References: <20200909153753.2905176-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a small update to fix an error I saw where a few functions do not
have a blank line in between them.

Affects smd.c and main.c - no logic is affected by this change.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 43596b919ed7..706728fba72d 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -775,6 +775,7 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 				sta->vht_cap.vht_mcs.tx_mcs_map;
 	}
 }
+
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 {
 	u16 ofdm_rates[WCN36XX_HAL_NUM_OFDM_RATES] = {
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 61d9834b080d..0bf286659b44 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -218,6 +218,7 @@ static inline u8 is_cap_supported(unsigned long caps, unsigned long flag)
 {
 	return caps & flag ? 1 : 0;
 }
+
 static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_bss_params *bss_params)
@@ -2194,6 +2195,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 {
 	struct wcn36xx_hal_set_power_params_req_msg msg_body;
@@ -2223,6 +2225,7 @@ int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 /* Notice: This function should be called after associated, or else it
  * will be invalid
  */
@@ -2902,6 +2905,7 @@ static void wcn36xx_ind_smd_work(struct work_struct *work)
 		kfree(hal_ind_msg);
 	}
 }
+
 int wcn36xx_smd_open(struct wcn36xx *wcn)
 {
 	wcn->hal_ind_wq = create_freezable_workqueue("wcn36xx_smd_ind");
-- 
2.27.0

