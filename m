Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7522A261A58
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731688AbgIHSez (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731730AbgIHScm (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:42 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664EEC0617AA
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:18 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so303478wme.0
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yTFsQ/Thh+oiXlokRzBRhy7fryTyWLYZWgMktev/5uE=;
        b=R/5PR7kx5bfQao/dqFxTgY6vVvKrEtNMCgcmIzT8IuiRX6AkKDoLQuIu2T/OUZrFRa
         5NdfNo3Nj8cfkFq0zvoUSU3r8iPIy3IO0bua3rHtdY029+N1mAKp0GeXFDKdtmPCTDSE
         kfLaUVJ8StB+NaAWiB843vsIR50j55pTpA/zAsY6EgrOFTn0jG45GDj/sYl7QpJtO4Rk
         0Y3UhlAg6Ui1aMqYVWVGJSd5YlzbUh3sNbpvEQQPO3+a/OiB3rElDdMEALn2qs6LZY/Y
         d9OMMlkS6K1g1hWqzPKwCF0C8+l1zcB+RhvHCJmKKAs0CWz7eGBFZ4CY2PMjO8Q5DxcA
         ZWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yTFsQ/Thh+oiXlokRzBRhy7fryTyWLYZWgMktev/5uE=;
        b=MtwoqsiqAEsFmnI6pxK6I0u9X/eFuF1OWO0uO8s6qBJ4whUwW+C2qYWb0TCv1ggL2h
         axBvB7yuoXG2hxoCzfHrx+nS3COUK51sMiGWvobYTVixK1f9fXVQkFHmxabYWeAWK2Tg
         K437IM0YIjtrUGGL31Xt8wQCp0P/soOlW5SUlL2ZdWndxup/035O0/NXnHRA1PibuDf+
         8KdvY0qjHiwwZVUiE9MCCk6Kcw2zpzCGpHS7sEzX4L4pD7ZnQyOApCKrro70kYM/gPbX
         TLJ+QD6SUoNV0Ijr4r51IwIV6fjIaQyi2VlpLdIDu8LnYUTbBa43oIO/NaJrrX4RWeVq
         xoCQ==
X-Gm-Message-State: AOAM531fg8iIxfYMAWBl3VU31fumyMe8OT1CkuA9joMoJqJlspYn+919
        ETk0/4xsb4yW3gUlCvWm0zi1yw==
X-Google-Smtp-Source: ABdhPJxSctMZIslzg5qvvruim3fRsoq+FUlU67ow/yttLzUjjiFy4VTlVejKzNMUxxkoBvKcP2NzPQ==
X-Received: by 2002:a1c:a385:: with SMTP id m127mr373050wme.189.1599589457082;
        Tue, 08 Sep 2020 11:24:17 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id 189sm330439wmb.3.2020.09.08.11.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:16 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 7/7] wcn36xx: Remove dead code in wcn36xx_smd_config_bss()
Date:   Tue,  8 Sep 2020 19:24:55 +0100
Message-Id: <20200908182455.2870345-8-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
References: <20200908182455.2870345-1-bryan.odonoghue@linaro.org>
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

