Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE7AB25647E
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727051AbgH2DjR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbgH2Dit (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:49 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BDD4C061235
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:49 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so894981wrm.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OfKzT0AQLv9vCASnT+Ck1FNtBdRG7UzTmfEa75WAP6U=;
        b=HIPVdGgIqrJu0YOXqxK6wFKDD1gqQ2p4RKCSM0fbzMnLmROBz/ap9rkZK1E1vyTdvb
         tbzo5NvFrEKNeZcIKVZ+lO/k/po46EoRfavRCp3LzV8kOy6wbWzrsfb3vSVMsGBsQCO7
         aBZmBeJrlTMIYnBWnQhRcSdwMrWNdW56KZcC8XVS1FrXv00h7qETgyvzsNe08m8bEEXr
         KA+YIR5UdIeDGqgObtHLW5HUDvHKZXSPyJblp6AWIfQEKN92MaKhHNdoTsGmCrYU/X2u
         3SmgnDYtsBA8nR1vCXJGfDQOqNLNV1tVphckCBJHX0m0YrE2zUnWZeqiCmGT2zg8DTxz
         uaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OfKzT0AQLv9vCASnT+Ck1FNtBdRG7UzTmfEa75WAP6U=;
        b=d+ep3hdHSt8rqXFofp6e0CgtAIXhKQjUjvsp2z0u+RqOH7vG8dFIqQGmdJWKTNS09/
         e9k5nd8xE/ZN7W0Bs8jmBEn49vo3RUb9CK8nxlQyd/sP5k5lzS34StUZqOEvKQZaRjFt
         vxyF2mP4pLF49fQegNHl7yXb2u29ZPkWFqJeLI35vPs+Bho42HpjJs1dhgELXwEGoTNj
         klSHWwyRZkh5I8zuVv/WwLEAO5KQSz95sh676cdJGV4Kks+4oegti4odxILzrXdVCAdl
         PkJZKHAGdAjOW38EmWqw8d2VsXaSttD/BgUI0BrzTkQVWgQKdHxGIQvw9m1n52acvu+S
         IKPg==
X-Gm-Message-State: AOAM531kgh2Ay2RvbZVzMDtEO1+Vcut5e3UIjUfBN+Yy2FEgvLwivJd/
        hmjsMZWAQNoEntnraBxRAWFwjQ==
X-Google-Smtp-Source: ABdhPJxs64sNrquZXRasHMaJs47r8++fy+h1aUQLTK2YUI1PDZxj1HZe5R51d56kDIgP0pe5/8a1zw==
X-Received: by 2002:adf:f7c3:: with SMTP id a3mr1691030wrq.162.1598672328149;
        Fri, 28 Aug 2020 20:38:48 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:47 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 4/7] wcn36xx: Add wcn36xx_smd_config_bss_v0
Date:   Sat, 29 Aug 2020 04:39:26 +0100
Message-Id: <20200829033929.2167761-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_config_bss_v0() as a step along the road of
functionally decomposing wcn36xx_smd_config_bss().

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 4d15abed5493..87fee9c1b981 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1590,6 +1590,47 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	return ret;
 }
 
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

