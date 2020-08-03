Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13ACD239DB6
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727806AbgHCDLM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727792AbgHCDLL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:11 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7B0FC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:10 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id f1so32234483wro.2
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ax8SuSrL7632ouEAOv3sobptqn91JzKWsmm/Phaehw8=;
        b=EjsU4MRG2d7kjpTDDuIlyGLFVnyAVEUpcVS6Bf3qSVhleBvh7etYy/HmQfNwCPqV+V
         GSHkLwEwx3jnylTW8m3hdQUhQvMffYM70zvTXwtODWKcyXTC8pwvDVuvsGet0qDGo2CS
         6hANX6h5LROc8VDsqoBX6Qm8bfetQhy+N3zSKdB37kxmUxToMqGlRV+D44x15u/gRZBT
         zHCsBDG5QJk1C3dcFZ7LYP5iNxC3DDL71mcOcrbqvBL+PRTLbGTeISHjv5liMy/HYVgT
         5ikcn5cmcGvSdQJXvgWBo36QxYxaH8ny4OJsoKBALKrQU1Zu18Q+2lGLT+R3PW5zjLhD
         NCUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ax8SuSrL7632ouEAOv3sobptqn91JzKWsmm/Phaehw8=;
        b=CZPdtqsHeDgwQ7YKqKMkF48CY/EeQRQYzHbSzViiMBTwh468sLlxIJ+7OirqMHmbis
         u+XwNH244d8rH7KaxaXhhhgca81shmePfdDxbXx/nc6s7eQkAcA1RRjSyzHZHqSr0MMF
         Wtgxy0p6nWMm4Gk7u/VW05akvrAqKPo5Jp04V9WY5h//nRuAqKdmX60rsw/EL7SqCewH
         bglSFwtf7+YrtfMSvtCofXKLXJFO3XnPukWSWia6vrikYlpW1UJ47AaAhuDAlfbrAUDf
         xYRe1ny714vAuzud2vT09wIUC0besQ9Q4Q5z8Toge1iMRHMSgRWPGAWvW+uBsx3nQ+Ua
         icxQ==
X-Gm-Message-State: AOAM532eqIMvA1iR3DyUkFRBTWW5pZSO+scuZXw03C4pgN22hX4Hx7tJ
        bNI/e62vWZUKhBtB5aaRFVHwMxqFW04=
X-Google-Smtp-Source: ABdhPJwIs78GukpvbeHgIvlrg9X1CKWtIZnAEQX8yH2Sqmn7AX6xImVbY51I+qPsAP0hMLfdFgz36A==
X-Received: by 2002:adf:a3d0:: with SMTP id m16mr12424041wrb.232.1596424269609;
        Sun, 02 Aug 2020 20:11:09 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:09 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 21/36] wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
Date:   Mon,  3 Aug 2020 04:11:17 +0100
Message-Id: <20200803031132.1427063-22-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit functionally decomposes wcn36xx_smd_config_sta into a clearly
defined wcn36xx_smd_config_sta_v0 and wcn36xx_smd_config_sta_v1 path.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 53 ++++++++++++++++----------
 1 file changed, 32 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 2d6779cfa59c..7ad75faf8c4b 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1306,10 +1306,11 @@ static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
 }
 
 static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
-		     const struct wcn36xx_hal_config_sta_req_msg *orig)
+				     struct ieee80211_vif *vif,
+				     struct ieee80211_sta *sta)
 {
 	struct wcn36xx_hal_config_sta_req_msg_v1 msg_body;
-	struct wcn36xx_hal_config_sta_params_v1 *sta = &msg_body.sta_params;
+	struct wcn36xx_hal_config_sta_params_v1 *sta_params;
 
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
 		INIT_HAL_MSG_V1(msg_body, WCN36XX_HAL_CONFIG_STA_REQ);
@@ -1318,46 +1319,56 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
 		msg_body.header.len -= WCN36XX_DIFF_STA_PARAMS_V1_NOVHT;
 	}
 
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

