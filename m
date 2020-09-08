Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8862F261A8B
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731832AbgIHSgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730140AbgIHScb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:31 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0007BC06138D
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:25:08 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id q9so291519wmj.2
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6pAkxtOoFSvNi7RPnLSu55Y7kA0XCbGAAZQbWlXlijY=;
        b=Nw8zH73/LEfHreHLQOgQhBKMtwTyVQ37S/nC4WcGslQWk0hDJY0kZJVP0xFq3mixYj
         uqDAPJlvIFyksbk6CxyWRoOe1ideRXfdC/aP/TWiFZFwLCK+LvTj34waXeLcD9WvafDA
         RNl7dLAe4nMyRRobJMRIWFE70AkyNzH1eo+sYhWvWXYOp+wHBhJvY8f/Wiy4JoVGbz+C
         IV0yu3DHJoisek4A7NlnWxx0xdY55TJq6g3UfAXuRyarsowql0FwsPOO4Z2rzoEelSvA
         1cEE+0BfwSCQxEGvDxrXbGt23af3jHUfvPSvkcHpqlN9//+H1eT5zekE8IhbAD/qId2F
         RF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6pAkxtOoFSvNi7RPnLSu55Y7kA0XCbGAAZQbWlXlijY=;
        b=jgRHtHBHYIdA5dZMaq6WhG6Skwo7rEBIfltM7eGeqVAtBUhcVzDN4y5z1MCfcLiiDr
         wYKHt0sQNW6LpsLxXPmQRoTFBQQQ6moFDOK7BEtZ1bxKd6NF3bvDZdwnnk/kY7npbrGh
         2R8ypH6Lgyj8NtgonDmTSusj/i5XcyQ0jtlguzuAPtrBHCvbdTalhsM2xgkif13olNXy
         wEzsHv08jZIyk6z2vvBBiX5IQYTtQHMHGafdW0xzTqXEZM4BASaq+tUcHNDnJUVo6lsQ
         3AwGYWF/cISf+a1yJINHuJl2VopRQGgjyc/HzDxqzDhZR5hIClyAqiAEuy/EZnmF49H+
         d3xw==
X-Gm-Message-State: AOAM530n1hHrlO/J3yRF00qrNLQu7c0ixoaXGcPYgmAHonGL3TM7CaEx
        C0THpOMZDm2+QNuVJGpeV82JxA==
X-Google-Smtp-Source: ABdhPJwrVI2YM+liqGI7pBh4zc2LS34EfDld968GWCp8/cfG7QyRrTr/vRg5GhmZNa+RR1TaAH3u5w==
X-Received: by 2002:a7b:c749:: with SMTP id w9mr361320wmk.29.1599589507701;
        Tue, 08 Sep 2020 11:25:07 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id c18sm376908wrx.63.2020.09.08.11.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:25:07 -0700 (PDT)
From:   Bryan O'Donoghue <pure.logic@nexus-software.ie>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/2] wcn36xx: Ensure spaces between functions
Date:   Tue,  8 Sep 2020 19:25:53 +0100
Message-Id: <20200908182553.2870585-3-pure.logic@nexus-software.ie>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182553.2870585-1-pure.logic@nexus-software.ie>
References: <20200908182553.2870585-1-pure.logic@nexus-software.ie>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

This is a small update to fix an error I saw where a few functions do not
have a blank line in between them.

Affects smd.c and main.c - no logic is affected by this change.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 1 +
 drivers/net/wireless/ath/wcn36xx/smd.c  | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 9e97513feeb5..929425415d05 100644
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
index a8d2af74ef62..b6e49f8f029b 100644
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
@@ -2192,6 +2193,7 @@ int wcn36xx_smd_exit_bmps(struct wcn36xx *wcn, struct ieee80211_vif *vif)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 {
 	struct wcn36xx_hal_set_power_params_req_msg msg_body;
@@ -2221,6 +2223,7 @@ int wcn36xx_smd_set_power_params(struct wcn36xx *wcn, bool ignore_dtim)
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
+
 /* Notice: This function should be called after associated, or else it
  * will be invalid
  */
@@ -2900,6 +2903,7 @@ static void wcn36xx_ind_smd_work(struct work_struct *work)
 		kfree(hal_ind_msg);
 	}
 }
+
 int wcn36xx_smd_open(struct wcn36xx *wcn)
 {
 	wcn->hal_ind_wq = create_freezable_workqueue("wcn36xx_smd_ind");
-- 
2.27.0

