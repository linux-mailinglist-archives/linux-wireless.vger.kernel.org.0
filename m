Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70E76264F23
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727900AbgIJTfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731390AbgIJPn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:43:27 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D49BC061796
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id a9so381410wmm.2
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TSmlKxa8tfftdzKPtW1OR0b3dc7k+Gxn+7syuplFMNk=;
        b=VO7fpuHqsdhMHthwTUSalazntVQBN4BaxAdhtZ3mhGhxzgk6z9lyBeCGM0jG1aWkAS
         IqBgziRfD7RUCgTPh/ZzKJCDmskLEGmJaT+5ayggvKm8SYYyrcUCLdPBLB90qEND90io
         Snz27uNhXQn/fMWJ1ibTnK4VZXxY4TDaIxS8y+CeeDawO1LP1VUvI4OT+imCQFtsZzq+
         PaFaJVPOW2fcf9N/qzzpl7KeMpvVlhcx3Er+uHMDU93BjlSKJnfFVMFVPx+TbGPY2JSO
         3eaZ1Z3Q/aqrR8bvyyu7VFWsIGQ2oo9q0adDade4MJzDpuQpE+oose9SZkmgqhOuIAxm
         v0Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TSmlKxa8tfftdzKPtW1OR0b3dc7k+Gxn+7syuplFMNk=;
        b=Cm70qt77bxfDgXVEp+buTmjNXGysJR2SBA+hVgs6dngRssELRat+ZBsVdy4lV9uxPz
         zsUMi7cIq921FqsUy9PQV98COd4OthJk4ZQPlBTFMdHTDp+WndWpBVu0N8Q5vj1FUhn2
         D+j8+gPPt4ROZ7Km368Tf+Roe53lKJ9NR2vC4hn6wb26t2CM3fRwjkcCiDRPfgKNqlWN
         0Kokot/i584Pe/GGFopBwhUEMst73iEVRVL1/eh90B3UzpbRYLA4WWPwkrLHV1mokvH4
         2yvU9ULf37Hl3bmQLSSNdurndEQSfmN5/wgx1WZZhA+oUAm7xlTMBCuQPMd5JsRlOw2t
         2CfA==
X-Gm-Message-State: AOAM532Swl/zpddJJxTwglevHnXSk/Hjfld8Lo2aWMIg9FfxODIMpwFF
        J9bVqgEPwTXUHwUx6yNLBpjB9Q==
X-Google-Smtp-Source: ABdhPJx0WC1q/RTRjPht3KQ7gJ75fYdvk9kb4/qf7SjD+K2hrScX9W21U5af7ztcfjY2Z1Qm56rUlg==
X-Received: by 2002:a7b:cb47:: with SMTP id v7mr470670wmj.36.1599750345707;
        Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k24sm3857005wmj.19.2020.09.10.08.05.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 2/7] wcn36xx: Move wcn36xx_smd_set_sta_params() inside wcn36xx_smd_config_bss()
Date:   Thu, 10 Sep 2020 16:06:26 +0100
Message-Id: <20200910150631.2178970-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
References: <20200910150631.2178970-1-bryan.odonoghue@linaro.org>
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
index 475d4f60185c..fa4357b36a8e 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1624,7 +1624,6 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 		bss->ext_channel = IEEE80211_HT_PARAM_CHA_SEC_NONE;
 
 	bss->reserved = 0;
-	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
 
 	/* wcn->ssid is only valid in AP and IBSS mode */
 	bss->ssid.length = vif_priv->ssid.length;
@@ -1650,6 +1649,8 @@ int wcn36xx_smd_config_bss(struct wcn36xx *wcn, struct ieee80211_vif *vif,
 
 	vif_priv->bss_type = bss->bss_type;
 
+	wcn36xx_smd_set_sta_params(wcn, vif, sta, sta_params);
+
 	wcn36xx_dbg(WCN36XX_DBG_HAL,
 		    "hal config bss bssid %pM self_mac_addr %pM bss_type %d oper_mode %d nw_type %d\n",
 		    bss->bssid, bss->self_mac_addr, bss->bss_type,
-- 
2.27.0

