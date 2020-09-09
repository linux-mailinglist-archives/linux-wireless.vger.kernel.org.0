Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6746C2633BB
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731122AbgIIRJ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730346AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC78C061757
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:48 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id w2so2726676wmi.1
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTFsQ/Thh+oiXlokRzBRhy7fryTyWLYZWgMktev/5uE=;
        b=bDaDaBH3RlmXba1m2936yTlW0VjhPgcg7KEU3pm5sHzQ8eq4cbIryvBB5LKuF7T9TH
         HBtoJH/72ZuoWP2/Rp8My9ruBESz+sbp9jfgWMhH3IYHWn0/QqC3H7KuwJZV6SlkIMcA
         ZUvuYOrqFzV2/vs82kyDwCSGSRJuxTfbWPAxyALgWAHSzBTNJlFYoB63/wyA5mfn8SGQ
         ubq4vUPcGIY28MTs284xY2vYf8PD5jCyiGsp6S6xNb1dUpDTJSH2arWrwZUfKn0pJDZk
         OUg0wcCAIydOXK5kM/hXLn1wmDngzKTcmebAvY6xgrX0knTbzKH3mJHiqdfZmP3ZIlW5
         9Njg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTFsQ/Thh+oiXlokRzBRhy7fryTyWLYZWgMktev/5uE=;
        b=kxJErNjqDFxn1gb1XEjRYw+2LF1sc+E6o74ltLARFh/k7p0e+9k17dw/aQHH0KWH3e
         pNNhkNKriM2E9LsQIZ8K1WNxsctb4nuTvjSIByVRnm/JHLUga7FoLklUiAVX6hYxcc9k
         09XJqb6rWenukqexI9BH/J0ZG86yIBqwAJrrfAUneTi0P3eBXOR8wSS0pe2sERazcEQO
         ILcr2zAwxp3y1GfltAxEYR93HV2kkHP41obdNWZ3pzOcz9wO3wttShyGA1wyBMLuwCyD
         yBlcd9uxb//yaOtyc9CGI5iggcXIyuklATpilJvnAO3VXRQa+DNpVr9wrgP8DBDZS2J1
         LnNQ==
X-Gm-Message-State: AOAM532+YBibS5fXKQf/XajvKitiYk11+7gydqgUh7g+LGeCbnksP0Wg
        vXYr1FnCl5VXe5HVAGhMKGXmSw==
X-Google-Smtp-Source: ABdhPJwJBBoWskU3EpRSkqKDHRBKJiRQD+etEYEz5En6jDjNqKfrmUzx+46FSaXziOja6PePxMSN/A==
X-Received: by 2002:a7b:c24b:: with SMTP id b11mr4339736wmj.134.1599665747147;
        Wed, 09 Sep 2020 08:35:47 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:46 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 7/7] wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
Date:   Wed,  9 Sep 2020 16:36:28 +0100
Message-Id: <20200909153628.2904888-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

wcn36xx_smd_config_bss_v0() and wcn36xx_smd_config_bss_v1() have been
designed to operate in standalone fashion. As a result we can drop the
dead code now present in wcn36xx_smd_config_bss() and happily remove one
kzalloc from the BSS config path as we do so.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 39 ++++----------------------
 1 file changed, 5 insertions(+), 34 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index fc922dd9ccde..ce6536a3185c 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1673,42 +1673,15 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta, const u8 *bssid,
 			   bool update)
 {
-	struct wcn36xx_hal_config_bss_req_msg *msg;
-	struct wcn36xx_hal_config_bss_params *bss;
-	struct wcn36xx_hal_config_sta_params *sta_params;
 	int ret;
 
 	mutex_lock(&wcn->hal_mutex);
-	msg = kzalloc(sizeof(*msg), GFP_KERNEL);
-	if (!msg) {
-		ret = -ENOMEM;
-		goto out;
-	}
-	INIT_HAL_MSG((*msg), WCN36XX_HAL_CONFIG_BSS_REQ);
-
-	bss = &msg->bss_params;
-	sta_params = &bss->sta;
-
-	wcn36xx_smd_set_bss_params(wcn, vif, sta, bssid, update, bss);
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
-
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
-		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-		    bss->oper_mode, bss->nw_type);
 
-	wcn36xx_dbg(WCN36XX_DBG_HAL,
-		    "- sta bssid %pM action %d sta_index %d bssid_index %d aid %d type %d mac %pM\n",
-		    sta_params->bssid, sta_params->action,
-		    sta_params->sta_index, sta_params->bssid_index,
-		    sta_params->aid, sta_params->type,
-		    sta_params->mac);
-
-	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24)) {
+	if (!wcn36xx_is_fw_version(wcn, 1, 2, 2, 24))
 		ret = wcn36xx_smd_config_bss_v1(wcn, vif, sta, bssid, update);
-	} else {
+	else
 		ret = wcn36xx_smd_config_bss_v0(wcn, vif, sta, bssid, update);
-	}
+
 	if (ret) {
 		wcn36xx_err("Sending hal_config_bss failed\n");
 		goto out;
@@ -1718,12 +1691,10 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 					 sta,
 					 wcn->hal_buf,
 					 wcn->hal_rsp_len);
-	if (ret) {
+	if (ret)
 		wcn36xx_err("hal_config_bss response failed err=%d\n", ret);
-		goto out;
-	}
+
 out:
-	kfree(msg);
 	mutex_unlock(&wcn->hal_mutex);
 	return ret;
 }
-- 
2.27.0

