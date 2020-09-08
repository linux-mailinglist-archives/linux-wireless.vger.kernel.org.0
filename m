Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86EAF261A3A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbgIHSeI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731461AbgIHSdk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:40 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C83AC061756
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:33:40 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so263904wrt.3
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:33:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fYS/m1bPyZkdQcLi31wUabR/VQlSuGHp2lU5CceXrgc=;
        b=CyfllJeeN46yeFryr1S/z5scYIs5a4+SXqm2bhA0jRgEMhF8hn2ozQQkxo68RRsiV0
         g1Sn+jrSydQwrDsI21h839+RepLjtCQAkOGkT8/pTNeO4jsqfDjnCS66zSTxRL3oYywS
         VYapWSsfW3HjnpWF14tULNsxcx1U4TbJzrhbgdncavuy2MkwT2Pegv+Bjp7yuUCXtIBB
         mMydRSsBHZPh4skzyl1qTioW1HMkvReH+qksu0F5EgEzHeNoFo1WtJsNrkG8Af4EsvIl
         oGEeZ2U1T96Jo3zmJ9HzoEbXon0OjXf+iQDQ09W3ra2rjDKaErFUnkAUfQhrb8gU+w6y
         xDaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fYS/m1bPyZkdQcLi31wUabR/VQlSuGHp2lU5CceXrgc=;
        b=INbSZJ7P33Jeo4DoEe6uXJEM21mV52lT9IDMjgMszchSqLF3glrWjP2EzY+0pZFbbB
         PBesJ3GJPmxKljwBWnHi6+2VV+Bali4MvAYN8DWpy/ieUptKm7rnGG0XuCD0C3Wn15YE
         iGmKUpIcOacec7rZ56bJk2ZG0LLHS2/HWOwQOq/l8iMlYmQqfj+AoougEy0v/5JyjHGz
         ncG7b/zKvOuJguUJqIwPYHUWDxxfwu89aH/WksmQOsKhc1uu2AhrZyB4UoPQevNMr2RB
         t8GSmsIw3hOfzdxdmzd+OG16T2XC6DuXMLAgLkdPOP2ChVb/2xnzDppeCtfbneEpVN5F
         2tvA==
X-Gm-Message-State: AOAM531xv5E8LyYPcpB7hfJJ3cIBXuaG1pLvRb6BZTe9HMP8PSqd87cK
        tv4LnOZFSzQoBt2ydmOak0eu7w==
X-Google-Smtp-Source: ABdhPJyziyqMXadeVj5u6zT/yaXIdYXwkRqxxRLkZ7waYIATDzhK5Z/eFJ2N8m/4HG8kn+XstXsl+Q==
X-Received: by 2002:a5d:6283:: with SMTP id k3mr969670wru.191.1599590018513;
        Tue, 08 Sep 2020 11:33:38 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id b194sm294992wmd.42.2020.09.08.11.33.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:33:38 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 2/2] wcn36xx: Ensure spaces between functions
Date:   Tue,  8 Sep 2020 19:34:24 +0100
Message-Id: <20200908183424.2871101-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908183424.2871101-1-bryan.odonoghue@linaro.org>
References: <20200908183424.2871101-1-bryan.odonoghue@linaro.org>
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

