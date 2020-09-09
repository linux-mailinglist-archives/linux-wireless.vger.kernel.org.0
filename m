Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1B62630A9
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:37:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730403AbgIIPhU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726399AbgIIPfv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:35:51 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17B37C06137E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:35:27 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id e17so2728155wme.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7Rx0C6d6/7/5yg3uB9kdCw4d9C0cgfMEPvtmg+zlZY=;
        b=sNE+b88z3vCssUNGhpsNU9MhqJzm1UaC03/QDnRE3Y22nZjT/1Amo6qflrLXB15Otz
         q41O3aV10K2m9xekepIcIa6kiViE5QwUJtKCjk7RWf9bsUamNWyAvLdnuV6PEKjFCXaq
         DAZlUlqQ2WKtOhnFAY1J/lTgUGzcI5Omw1opccMqyh4W4rvXlEIRiB0Q8+mD/kfKiO/7
         Kaq7lqwsmtLUGXviTuVdU2S+SluDGjK7k5XbjSGn+HuepKXAeSopPZ+6gj+aV2mLOIBX
         cdubXu9zNtDMrANpXSICedKOdOZl02PS46qlS0zvl/uH+kMmztYsIhHrcK5xddxNHrRA
         cSTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7Rx0C6d6/7/5yg3uB9kdCw4d9C0cgfMEPvtmg+zlZY=;
        b=YJtdXcS4//gO85Ff1WBaanXTk2jdOxzGqofm3KRxPMMHnn4hyu9GVbUhIov/I+Jmzz
         kOjKXXN1vcwwxPyGiHn+fZWdC7W2q+7QP3K3gsp998tYlFvBmdxHFhy57w73yPcB3ugJ
         yNzkK5V9RHAynd64cij1wfa8b7Ft2ClS1Cxh94zRrmug8D5ICKaskYTO43sMijPsY+Sx
         IUNEtR3e6VkKOdk7x0WFEqDJP9z/g9cqF51TKxQKWdbkkAuQjNBnxwBn0YuQX/FxZ4Vq
         QIL1OjZ4/tbfei/rDMed788BPOFOtSS7AnlaTnlV22TCu0eGjX0mKucRJ6EN2y0nzN5s
         Ym+Q==
X-Gm-Message-State: AOAM533fzPHRVW7UTVi/janPFH+diZmVMgYj79ZJ8mPeWuONPi4AVSWA
        FHHhJ0qnxbauUjKCXGQWJSfZkA==
X-Google-Smtp-Source: ABdhPJwbX0yoJltI+N9d03XcUiNnxzGsI3oHHtRZg+AZZ0n6yamRRR0uHbwkbl6wytYE/XVWAAZoAQ==
X-Received: by 2002:a1c:7c1a:: with SMTP id x26mr4322697wmc.112.1599665725760;
        Wed, 09 Sep 2020 08:35:25 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id s2sm4473335wrw.96.2020.09.09.08.35.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:35:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 6/7] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
Date:   Wed,  9 Sep 2020 16:36:06 +0100
Message-Id: <20200909153607.2904822-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
References: <20200909153607.2904822-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds wcn36xx_smd_set_bss_vht_params(). The job of this function
is to decide if the BSS is VHT capable and if so set the appropriate bit
in the BSS parameter structure for passing to the firmware.

VHT Channel width set is not set since we don't support 160MHz.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index 14af98af42f3..fa6f5943a43d 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -146,6 +146,15 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
+void
+wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct wcn36xx_hal_config_bss_params_v1 *bss)
+{
+	if (sta && sta->vht_cap.vht_supported)
+		bss->vht_capable = 1;
+}
+
 static void wcn36xx_smd_set_sta_ht_params(struct ieee80211_sta *sta,
 		struct wcn36xx_hal_config_sta_params *sta_params)
 {
-- 
2.27.0

