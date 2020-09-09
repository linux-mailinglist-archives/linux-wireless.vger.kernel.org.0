Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4091B2633C3
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:10:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731129AbgIIRKM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730166AbgIIPgD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD7AC0612F5
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:42 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id e17so2728960wme.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=naU0RpV8J9Z6Qcq0aj4T/awPa3wV7pjar3MjYtbLY9w=;
        b=C2o7CmUpJtKLs9TEWpSRunSOxPh+9pLoyKfJLJMjnmv3A2fRSeKqUnjBwGd/5ErmIT
         f7IWJ+Hbl9+5RjVHYczBuBABIZt5dtffPjB5VkM1uu62D5JaP4gpvW9fuc8xLh9ZrfWm
         yjD1zxEfn+5F4JDjg6lAadJjQsyqiXNo0/Lgn+fJgWfVvbe764x061ER94+Ozi0AjtDw
         1Mj3PeXXqF9xnyIJD+2d1XtoUNN+Z7DI+tp4NgQTKYER/XGrScZcHSyiHxiWfY4GG0xx
         4rp5DMfJo2agzwegtVbuRLmLptFpxnm3C6SLSKWc+yR+IxNJkrQ5wDedhP6fNiqtTOhl
         x+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=naU0RpV8J9Z6Qcq0aj4T/awPa3wV7pjar3MjYtbLY9w=;
        b=E4eeBUi9lFMoQbQ4QciTDXBcXfGpZOMhWN4P+vcQVnda9DNbSmoIToCCvZVQVzSTFr
         xDnSs64EFt52LHBxHbYddTNThhoD610ZDXlw/Gp0mkhHLvQltneqixE9vkn31DdjUasd
         PW/cHcnShK7yamUyQRKP/ar1NumjmDvp1TLfXa0i1E2IapfOvqyhVdDUBHaYQJka8emr
         qt9vfYlkumVAJWQQXGbK54f5Up6L15RAoTNeDGPTBcj/IYcvM+7Xoo8/YbqFYtBZBo8H
         imxtuzhMvNDHheRCBzO4MsAdz+qjcJhGCqLWyWECFnwWjdA7Bu+r/ZfMABBI1D05jgis
         NaZw==
X-Gm-Message-State: AOAM531VjXQ7xGoWGht5GVTvQIhbo6x+6eJkGQyD+2TZzSFrsBcQgIs3
        Nq/BrcJ1ssTu8oohMLgy4MNQFg==
X-Google-Smtp-Source: ABdhPJw0u6NOPIJK1AIJY6tvpAgkPUTW4zN+uG8AWNnTxeNPjz6FMZkM2eqyjfn4f8ot05I3ffm5Lw==
X-Received: by 2002:a7b:c182:: with SMTP id y2mr3754745wmi.21.1599665741678;
        Wed, 09 Sep 2020 08:35:41 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c18sm4924871wrx.63.2020.09.09.08.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:41 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 2/7] wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
Date:   Wed,  9 Sep 2020 16:36:23 +0100
Message-Id: <20200909153628.2904888-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
References: <20200909153628.2904888-1-bryan.odonoghue@linaro.org>
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
Reviewed-by: Loic Poulain <loic.poulain@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index e26752396bdf..28a571918b19 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1606,7 +1606,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 
 	bss->reserved = 0;
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	/* wcn->ssid is only valid in AP and IBSS mode */
 	bss->ssid.length = vif_priv->ssid.length;
@@ -1632,6 +1631,8 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	vif_priv->bss_type = bss->bss_type;
 
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
 		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-- 
2.27.0

