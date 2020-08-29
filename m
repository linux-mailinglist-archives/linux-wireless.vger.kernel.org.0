Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 480FF256476
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgH2DjD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727000AbgH2Dir (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25223C061233
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id e16so894942wrm.2
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=or2dbECxnpurnyDMf3aY/pIgT+JTIa/EycsL2GtCXSY=;
        b=HxsSo/PZu+qfet4lp+lRj+AN0WRVaaZGoaTTcBrC4XMvC3ENptwieaP1VAvMzbCdHB
         1y56MxnkH2i9BkW1k7STYaLxHOhCHCFt55FqItCENYDX7l85DSBO9uQYJr48HsTNGDPl
         q4l6/8pxqehmhZKlXWjHMowSGU486uKlh33rE0vA/p/NYes+4XcX1XSUpY+9Zn+CjFBr
         Pnxh4ry5j6V2MMKqtVZM+/IBD948IwNopgZbQwQS10JJcvfe0LPqAoHagEYnKa88nvTz
         wMLOQK8t/zeYDvMSeiKxasvkOUKwjCrs2alg2v1jlBGaRaxq5iIrRM7Ohx7l+qUSg+Wp
         +Oqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=or2dbECxnpurnyDMf3aY/pIgT+JTIa/EycsL2GtCXSY=;
        b=DtadjRKy/Qr7tp6uzzkCUXQCZ/tKwVsaWxhM8Bikr9ps9JSWsk9JKipKhpdRIBNeKZ
         HZoVsgDea0vGbxY7GtQC4pWdJWgb7P8qc4RBfNEKXM/7+6qJldNTG4QmpPZzcIMw+ArX
         Fn8niTOae9l4deX02ZY2tg2DhjvR8+A5lbqHS/dBqLkwhKZQHokkjvwqu+yMy1fEGV8m
         q6HUgcDZbQtHhjF77pgZsJJxWuhPtg2yCtfpa+Z0RModygOwM6I15CQxR8/vL7N92+lN
         ZmP97ZWZHxMlpTp6LRLih20mLls8sdK2wCNIkPxDB9MiFe3UucwyzaIHALwNY4/btqsk
         xayA==
X-Gm-Message-State: AOAM533dPOHu5/NZSeamf68qqlZvpfOFVVILd3aOnTbtysz0Hc2p5yrl
        2VL3tZlDM9aViijDhLfmPc8l0g==
X-Google-Smtp-Source: ABdhPJx/2C9Jo37q6Bid/XL+XWa9eVEVw3oyYoTyeOxejfCHncDcyu90+AfrysrErLamSyojbaaEOQ==
X-Received: by 2002:a5d:5273:: with SMTP id l19mr1832129wrc.64.1598672325876;
        Fri, 28 Aug 2020 20:38:45 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id s20sm1691700wmh.21.2020.08.28.20.38.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 2/7] wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
Date:   Sat, 29 Aug 2020 04:39:24 +0100
Message-Id: <20200829033929.2167761-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
References: <20200829033929.2167761-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

In order to facilitate functional decomposition of
wcn36xx_smd_config_bss() we need to move wcn36xx_smd_set_sta_params() later
in function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e8c2f4a152b4..654ef074b1eb 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1618,7 +1618,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 
 	bss->reserved = 0;
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	/* wcn->ssid is only valid in AP and IBSS mode */
 	bss->ssid.length = vif_priv->ssid.length;
@@ -1644,6 +1643,8 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	vif_priv->bss_type = bss->bss_type;
 
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
 		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-- 
2.27.0

