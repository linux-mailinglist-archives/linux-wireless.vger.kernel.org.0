Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10F642633C8
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:10:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgIIRJt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730251AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9B6FC0612F4
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:41 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id w2so2726369wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAN3QMP99RMuUE2X4Hhmcyc8WgDbU6qUkAUGwiuBm+0=;
        b=e5dBR0BupdAskOjCR2OsjCy+jm0ple/SxA7HI6cVw3GyCuIddX7XOUMSNPxUx58zTb
         xrMoV58SdKtT4wjJYoFC6ITxEupXAccFJ5pdbbOb1/eb75eECWSeAXUAAvPSaREJ2lC8
         tzDAMVLNL3TXvffbUK/lrvJPQEyzXAfmO6Lc803q2woZRxw52icYgmhFuVp/kmw3Z9F/
         2NJ1LWsja4G6RxP12CAzqNNjGXDTsRtgJHkk1qoC4TtY5ZJLp+rRGQc131eja0/tTsZy
         I5Fm+ae/XAK/JXKb7k13pVXnvpboLvNcWdYCOMegiDP+/GRi1cEzv9osjqQLsDTbZ97u
         bZvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAN3QMP99RMuUE2X4Hhmcyc8WgDbU6qUkAUGwiuBm+0=;
        b=OUDORyKUdGfewYCPj5a71Z/fX0vNsZQftJFdOmJtkjYQQA3O1TIM4J2cWq2RGSeKSX
         kAbDDPuVtjYud48MshPkMPah9ND45rNPfqKh8BSv6BfsrwcCPdrAqDJIUCRC9XsfggQA
         Iv0IuLLvj4bP5LrzREnRdnUB32keUZk76EcGQy8ZYoZ+vb+LIByBtJ0EDlb+peDj9cIb
         BunJMtn55Sjba1Mwq3JY1zzswbivF9/d6Ezh+Rt4Vv3g3NtFKSIr2yIqtUbpk5m+wGga
         xd+02W8OR3rwiXuL19FD/6xY8w1+YMVQmaxC1V6UJRXOBHIaFpWVreTBnL1ZOvYIMr3o
         BtBw==
X-Gm-Message-State: AOAM531SoOHhGxcNvbjrbVCexAnj8UjkyfH33nhaRkfQ5LK9HGRyIQIe
        gJdXMYGpBrdUF/vqpl07l90GGg==
X-Google-Smtp-Source: ABdhPJwKKKA9Quw0YjNc2SBrAqKt9gocD3tkE4wbdyTwFm1RUkNfwlSr6+jQ1S6//F64ZlePB4mB9A==
X-Received: by 2002:a05:600c:24cc:: with SMTP id 12mr4285160wmu.126.1599665740601;
        Wed, 09 Sep 2020 08:35:40 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:40 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 1/7] wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
Date:   Wed,  9 Sep 2020 16:36:22 +0100
Message-Id: <20200909153628.2904888-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit functionally decomposes wcn36xx_smd_config_sta into a clearly
defined wcn36xx_smd_config_sta_v0 and wcn36xx_smd_config_sta_v1 path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index f434c355d32d..e26752396bdf 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1308,54 +1308,65 @@ static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 }
 
 static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
-		     const struct wcn36xx_hal_config_sta_req_msg *orig)
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
 {
 	struct wcn36xx_hal_config_sta_req_msg_v1 msg_body;
-	struct wcn36xx_hal_config_sta_params_v1 *sta = &msg_body.sta_params;
+	struct wcn36xx_hal_config_sta_params_v1 *sta_params;
 
 	INIT_HAL_MSG(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
 	msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
 
-	wcn36xx_smd_convert_sta_to_v1(wcn, &orig->sta_params,
-				      &msg_body.sta_params);
+	sta_params = &msg_body.sta_params;
+
+	wcn36xx_smd_set_sta_params_v1(wcn, vif, sta, sta_params);
 
 	PREPARE_HAL_BUF(wcn->hal_buf, msg_body);
 
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config sta v1 action %d sta_index %d bssid_index %d bssid %pM type %d mac %pM aid %d\n",
-		    sta->action, sta->sta_index, sta->bssid_index,
-		    sta->bssid, sta->type, sta->mac, sta->aid);
+		    sta_params->action, sta_params->sta_index, sta_params->bssid_index,
+		    sta_params->bssid, sta_params->type, sta_params->mac, sta_params->aid);
 
 	return wcn36xx_smd_send_and_wait(wcn, msg_body.header.len);
 }
 
-int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
-			   struct ieee80211_sta *sta)
+static int wcn36xx_smd_config_sta_v0(struct wcn36xx *wcn,
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
 {
 	struct wcn36xx_hal_config_sta_req_msg msg;
 	struct wcn36xx_hal_config_sta_params *sta_params;
-	int ret;
 
-	mutex_lock(&wcn->hal_mutex);
 	INIT_HAL_MSG(msg, WCN36XX_HAL_CONFIG_STA_REQ);
 
 	sta_params = &msg.sta_params;
 
 	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
-	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
-		ret = wcn36xx_smd_config_sta_v1(wcn, &msg);
-	} else {
-		PREPARE_HAL_BUF(wcn->hal_buf, msg);
+	PREPARE_HAL_BUF(wcn->hal_buf, msg);
 
-		wcn36xx_dbg(WCN36XX_DBG_HAL,
-			    "hal config sta action %d sta_index %d bssid_index %d bssid %pM type %d mac %pM aid %d\n",
-			    sta_params->action, sta_params->sta_index,
-			    sta_params->bssid_index, sta_params->bssid,
-			    sta_params->type, sta_params->mac, sta_params->aid);
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "hal config sta action %d sta_index %d bssid_index %d bssid %pM type %d mac %pM aid %d\n",
+		    sta_params->action, sta_params->sta_index,
+		    sta_params->bssid_index, sta_params->bssid,
+		    sta_params->type, sta_params->mac, sta_params->aid);
+
+	return wcn36xx_smd_send_and_wait(wcn, msg.header.len);
+}
+
+int wcn36xx_smd_config_sta(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
+{
+	int ret;
+
+	mutex_lock(&wcn->hal_mutex);
+
+	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24))
+		ret = wcn36xx_smd_config_sta_v1(wcn, vif, sta);
+	else
+		ret = wcn36xx_smd_config_sta_v0(wcn, vif, sta);
 
-		ret = wcn36xx_smd_send_and_wait(wcn, msg.header.len);
-	}
 	if (ret) {
 		wcn36xx_err("Sending hal_config_sta failed\n");
 		goto out;
-- 
2.27.0

