Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44797264F4A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:39:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727776AbgIJTjO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731256AbgIJPmg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:42:36 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8ECBC061757
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id e16so7110514wrm.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jPZywSlUGy1DbYCXOG17ZaN4fGsj4lfwxAd0j52fwtc=;
        b=bXdk5WDh+FTYAUqvJ+3Rkt9BfbjPH88W65o4uL/hwqVRtPxELZodv7ZLsql2nAxYPK
         hs/GH8U/9O9CQ3uFAQeT8ZRsM6bFOxVYqXMv87jBkUyM8VCwjNWq2azM2hi+nlb5jg4T
         a5OrNL873vPbxgQztjzjpZpCzmPYdT4+Xi4Zn40VyQwQj2RksH148JrQ212hS9l5nEGR
         xdtJ8iiq9N0F4+Uuapy/YbkIMriqudeoozncz4mLlWuATC6NO0S8mIZjq5fHWNlI8oRc
         C6EE2WRIVx/yKwRqiDmJBU7/hSfORQDehB+/Fhu933LvKB45Kqt0ZnjfojmkyKozU8Jj
         vH9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jPZywSlUGy1DbYCXOG17ZaN4fGsj4lfwxAd0j52fwtc=;
        b=Z0XKzm0NaJTN6ypE7sCeU9c1aTbvOPZTLT1M3IRPSC7z7vaNKL8VcRn4wIDObysBEB
         ClslyOLBNI7upoNdJI5ifi7VinOl7UcBaMi5IPt1afcU0Q7jQhmV0/cCd3KwysUB/1YM
         kfkYUDwmlXKLAjcAqNhbPfwVZSiVPZhJAcn6GmKqdX8nTFV47b6HkmDHssJDDn7nM0Uq
         7ztVexA2PtdLS9spl/o+uklSSg2mKno4ORwCGkVLzNXjcXkNxAg9cH229YkMlMQ1x4Rj
         steg6LzbkolkoFQmlPlomgvAEiQ9OrsHxZtdjhyg4aD/712C7N89KWpqisvMK92dBpfQ
         2utA==
X-Gm-Message-State: AOAM5316ws+YNIMMQQxUpaCR2ntT7c1znHlMkEzM+2EEZmC5unkolONs
        JvGDnAPOk273icLfvaxUFSaoWA==
X-Google-Smtp-Source: ABdhPJxdkuVMxqA0Mf7/yk85MFls20O2MKUcPt4GBl1oKxe84zIZzY11kZRMRivmYWaNd1HEkFq1iw==
X-Received: by 2002:adf:aad1:: with SMTP id i17mr10102202wrc.360.1599750344653;
        Thu, 10 Sep 2020 08:05:44 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:44 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 1/7] wcn36xx: Functionally decompose wcn36xx_smd_config_sta()
Date:   Thu, 10 Sep 2020 16:06:25 +0100
Message-Id: <20200910150631.2178970-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
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
index 71ecf3ef5ab2..475d4f60185c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1326,54 +1326,65 @@ static int wcn36xx_smd_config_sta_rsp(struct wcn36xx *wcn,
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

