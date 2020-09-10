Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B14262649C5
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgIJQaq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:30:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726815AbgIJQ1g (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:36 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5BC4C0617A1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:49 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id a17so7082474wrn.6
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DQTt4ZJIu8GTxj+4B1cvxGG4nybh/ZrPxormf6iSTCU=;
        b=ucpAjTCaNTUlZJQEWLRjLbssJXBm1SZt/yxRqtoouzmk77RdUBsbFmOShJDl8PD6TG
         d4hbRJLnGhz354i7xar3axwWUh7cBcuwfxj3pCoA90tiBAUdv7fp17i9EZ1sFz0gFH/u
         R2nNEyrSwuWHVq30F8dDq3BkvOQGUfF3/rCvazqpC5vOEyTWYZxpCZPULItp+YzZA4wv
         IoarB7c3QNy1ue7JgiQ9/nnGLEpjBUVVT1Te4Quc+FFRXR8g9ZfktV5/M6G+E6IINyL3
         siYscq+JNeFURo//EjmCllqq/ysPNQzvCOrDeeY9lpp6BLPMd5g36ABIJx5VN/5kh8k8
         D1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DQTt4ZJIu8GTxj+4B1cvxGG4nybh/ZrPxormf6iSTCU=;
        b=Q+0uolXp0QJROF0xpLnqfY3ln9y0LI4mNYJYDyj1wGQa65FSjo2DIPbRTSbdpMFXQA
         TLShMASw42SrFN++eZhaeTULZCtIs3IwTaHUIQMwTKko/tB6q5ZJUD+zFjyz0470E1IU
         Cki/BJ4ylbA8ttH3wpvBnPyDLj0CYJ+ZqkX0f3mXNJ4+F78gmvm0YHCWWgZiXbMp/jpN
         nWndUsD2sARIOY/SEtaPuImf85IouoJskwY9goRFBU8pa3QcNXAi9QtZs7lShVPbsjms
         mFBrimX1nuy4jtrAVM3ZwvB5Zr9jNznUgaonFGEWlgbQvlCUav7d3CkSgaRkBk4Pj35X
         Yu0A==
X-Gm-Message-State: AOAM533PnfG/dPsUUzIKUSOxl1Zc2Xh5IvjRPMzDypHodT982BYvPzG4
        yK5DTVPIwOwv8SdX72U5CUAAkw==
X-Google-Smtp-Source: ABdhPJz/fUEoROVUDl7E48VmQ537BDAItWSpzRBNr29zyul28DvOpDeBheLu46NjAFCh0vSm8gN0Ow==
X-Received: by 2002:a5d:4d8a:: with SMTP id b10mr9498645wru.82.1599750348555;
        Thu, 10 Sep 2020 08:05:48 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 5/7] wcn36xx: Add wcn36xx_smd_config_bss_v0
Date:   Thu, 10 Sep 2020 16:06:29 +0100
Message-Id: <20200910150631.2178970-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_config_bss_v0() as a step along the road of
functionally decomposing wcn36xx_smd_config_bss().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 809a4c0899ff..57833eec16eb 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1605,6 +1605,50 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
+int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, const u8 *bssid,
+			      bool update);
+int wcn36xx_smd_config_bss_v0(struct wcn36xx *wcn, struct ieee80211_vif *vif,
+			      struct ieee80211_sta *sta, const u8 *bssid,
+			      bool update)
+{
+	struct wcn36xx_hal_config_bss_req_msg *msg;
+	struct wcn36xx_hal_config_bss_params *bss;
+	struct wcn36xx_hal_config_sta_params *sta_params;
+	int ret;
+
+	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
+	if (!msg)
+		return -ENOMEM;
+
+	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
+
+	bss = &msg->bss_params;
+	sta_params = &bss->sta;
+
+	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
+	PREPARE_HAL_BUF(wcn->hal_buf, (*msg));
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
+		    bss->bssid, bss->self_mac_addr, bss->bss_type,
+		    bss->oper_mode, bss->nw_type);
+
+	wcn36xx_dbg(WCN36XX_DBG_HAL,
+		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
+		    sta_params->bssid, sta_params->action,
+		    sta_params->sta_index, sta_params->bssid_index,
+		    sta_params->aid, sta_params->type,
+		    sta_params->mac);
+
+	ret = wcn36xx_smd_send_and_wait(wcn, msg->header.len);
+	kfree(msg);
+
+	return ret;
+}
+
 static int wcn36xx_smd_config_bss_rsp(struct wcn36xx *wcn,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta,
-- 
2.27.0

