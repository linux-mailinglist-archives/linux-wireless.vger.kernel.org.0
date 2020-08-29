Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28F20256474
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727036AbgH2DjB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727043AbgH2Dir (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:47 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA430C06121B
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id x7so890889wro.3
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kmGkmjV/m2zZGU727AEDIK8F57fQ739jwqBKaTJaAC4=;
        b=gJDeuboGw9uYXGSPAmw2jBgLbsJEgvXTdsY+C0hlTCtU+g1knpbpQz2T8RVBWtSMCK
         e3uI6jWp9A78ZHUnzMShDR7QoObOAtEKYfFT4Y/+2ApCKS00czoAgcWIiGsum4RJu+Pj
         4/UmxZYCaJp6cYcN3/Acw0j0poAO7MzlOgynRdwkvRbiRce5jiPY/NdfIrEJDli09n8F
         cLW4aq9Hlvu4Roq8WZTnWPs43A48QZ2f7ZBml9O2xu9Elq0fgpHaU0tzLfM3Xx/Owpzn
         Te+eL7VdDbTh+HFo4+A8UHNOCsrqtWEYH4blrc/5xTybYLVMVQdTbkN0DZcjKMVMx5ry
         5vgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kmGkmjV/m2zZGU727AEDIK8F57fQ739jwqBKaTJaAC4=;
        b=F3BC52MNST42/c7F5VawOt4iWdemzUlTeezxyUnLqo+VRBURl+2LT9LTBC+Fcw7uZT
         ioW7GX0wkVUpoYskGx2ulC5aMxRhY0hDTe4dLFtD4CpitY8nKGZsqc9HRa622b1Gms26
         pRmymHXqCk3lmQvW6hBa7UAf12ffEdzWtbKefOEltSPK5xaw7IKpbGYXnQM826ze96kw
         Vb7uNjL8DyRkxVKSwocj2p+2bXLFEgFy2JklLPBKkkXO8uh8NhPNhzaAaFG/c/TbFKPm
         +1P4ryrF4nGl8PvQdb+SX1P4VVyyl0fVZmnUGZKIHqJ1p5DqXh8WnAKoOAWNVZFrL5fb
         Xftw==
X-Gm-Message-State: AOAM532R+cRFjhI83rdSUPBp1oa7UtqF3r08k48RrW3U3NXXiWK6gRfY
        gDLuGSliDW02Bm7a2E8a7kgz7w==
X-Google-Smtp-Source: ABdhPJyeev3UXfh7W9qjVNHUk8zVjVc0x4etgg8HBUH6EFIwO5TfalWkJ2+huJeFDNcBsjvYbMQrgQ==
X-Received: by 2002:a05:6000:1003:: with SMTP id a3mr1689067wrx.258.1598672324461;
        Fri, 28 Aug 2020 20:38:44 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 1/7] wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
Date:   Sat, 29 Aug 2020 04:39:23 +0100
Message-Id: <20200829033929.2167761-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
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
index 97fb47a8bc1a..e8c2f4a152b4 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1312,10 +1312,11 @@ static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
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
@@ -1324,46 +1325,56 @@ static int wcn36xx_smd_config_sta_v1(struct wcn36xx *wcn,
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

