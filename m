Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E01F9261A90
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:37:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731783AbgIHSgx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731361AbgIHSck (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:40 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AB6C0617A1
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:10 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so179624wrn.13
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TAN3QMP99RMuUE2X4Hhmcyc8WgDbU6qUkAUGwiuBm+0=;
        b=X1nC4SeejQjeJyQI7dQSYL+Z5IwxvGY68esopG5mFiYSIhNtKZcHeTzSAFJivUmYr8
         bbZERcQTQp/IXonUh9Jl26zU4PbcZ+AFMGSwUQr+ceDmAESUAG8paUWvX+uR45R9dOWU
         dikp4JnU9SALDdiTYFhLBwu4o0s7Zaa34RL9jvwxe1pzhUmDdIOpppxbB2Q61y3IMDRU
         dwrs/APby+NsKxiBij/MS5X8Wn/I9eNfxvamn/QfkkMhExxWl5ojoQg1Tk7oVpmqb79n
         mhfiVBmeYnZrFXhfIYL2U1rwITzlpPZYhDTOwUdO2E15EJ6ktPOGzwFgJAXTN+oq5h0i
         B5HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TAN3QMP99RMuUE2X4Hhmcyc8WgDbU6qUkAUGwiuBm+0=;
        b=aLzObuy7HAZ7B0gYNCkFUsK2jXZXow/MiMJim3iwF2G9yRvKyQ07g/bfHCNdNHlt79
         fp+a053tAi1cXTuyUOTHUBeW01bUWVpubofCd25Z4S5G3nVWp09pDAOhhomoVDu5j2zb
         Bi/row2K+m5eFa3i+jRw8N91+yN7ge4WhI42X7qaJdsVI3X0M6iG2J8QThxeYw/tmYZs
         z/1ObbV6MXNMotHl3o6oVpGsbgEudh14l6wVYPf9m3S0RoZceTZpVKEyCnVju8uNUDhS
         ITOWDHbRPpsTc3lW5ZhfMlJSwk9E6SgSF6rglGm5JlK60FTq9S6NS1gFcSGJbcYDyzpr
         F9Ww==
X-Gm-Message-State: AOAM533ssyO8wrNRMxhZYIkNosaQbuy+eaLt0U/ERrTrcbdr80JHSBWV
        UMe4LVpEx8sV2gXOBIeh1KIcNg==
X-Google-Smtp-Source: ABdhPJwBrETBgdmn6JvFKSnjlvaBV78TiMTnmboGccj+S9vSuXN+swOxuVJaRaFm8lVDmQZre3RxnA==
X-Received: by 2002:a5d:4bc6:: with SMTP id l6mr1005090wrt.132.1599589449430;
        Tue, 08 Sep 2020 11:24:09 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/7] wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
Date:   Tue,  8 Sep 2020 19:24:49 +0100
Message-Id: <20200908182455.2870345-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
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

