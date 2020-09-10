Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2400264F2D
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 21:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727070AbgIJTfb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 15:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731386AbgIJPn1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:43:27 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20760C06179B
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:12 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w5so7058063wrp.8
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HqHLp1msqI2btcU80XmiahuTU9fQPQhG4xjHOmh9N3E=;
        b=IZI9RjLPsZtDmR1K6FXBEjSuD+Nn8XBfF2l44tXm0qvaW8Cf+ijXJauAxJgho2bJzI
         qklqQzKv/SLavr7ry8CIIZ8NUzpOIgzoah8yBgFHfIkFFBAl5FqSESxmZZOvAKvotj9q
         DiAfgr4fi3MNWc5Socz04euqF0bVEx9+ycSDimrQHbtPr5QUygJZPob2CGmdK42jb/ij
         kFMw/3RdSNVe/Ou0WMrjwKDDelzkltWR1anyntKVyVbRgksFTzovPWkVM1K5u+HhkMqB
         ynFJWe0AddxwePCeBeGHeG33/cwbxGWXl+7dG9naBmkfRNB5PgR2XUJ4QxSAvH4tI4dk
         9d5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HqHLp1msqI2btcU80XmiahuTU9fQPQhG4xjHOmh9N3E=;
        b=C+QiLihPlK+r58pQJ7tOPAPwsG5OVhjLgNWWdAsaqgKbuAt3ohx1KIkVYeCt143gHp
         ds0QEmXM2W+g0NawjmVvgbaFy+twqYEMLd1ag8JGDcOC+uQDftkq9MTUpP7iVUOe9hyw
         TYcv0BSpwbvxCXP8F153u8rSL5RMn4wSr2Ba+dBBgYdFB+kVAmK4K8cLvC+y2/LzNlUK
         bFu0xR8JpIi3PVNyUNWD9c+S89s0VkPFKsZPDupvMxTdtXgT6ZkprY/U74BGU3PWjWaG
         pk7+AKyj/Oc+5H5x8Z99Rjzd8BMglVgl3Tcu56M7nXzkqlbuuee+8agLowDUxWg2JbKs
         K+jg==
X-Gm-Message-State: AOAM531RIA7Y0K7FczOeuqs66XW6lVTp+x7n76T+CXpDG8zJZ4nzpBaT
        bqoUZ3DAxsVtQYJGf3EzNemjrA==
X-Google-Smtp-Source: ABdhPJyZFhVb9R3SjF9SkGY6h0CvLw8SSbRilNUwd8SBUI/pc1eG7//X129ygYMjaZQA22XT53vWPA==
X-Received: by 2002:a05:6000:1184:: with SMTP id g4mr9551476wrx.20.1599750310677;
        Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id g8sm3852620wmd.12.2020.09.10.08.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:05:10 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 6/7] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
Date:   Thu, 10 Sep 2020 16:05:51 +0100
Message-Id: <20200910150552.2178882-7-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
References: <20200910150552.2178882-1-bryan.odonoghue@linaro.org>
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
 drivers/net/wireless/ath/wcn36xx/smd.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index ab9b6116cc75..d5089aa382bd 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -146,6 +146,19 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
+void
+wcn36xx_smd_set_bss_vht_params(struct ieee80211_vif *vif,
+			       struct ieee80211_sta *sta,
+			       struct wcn36xx_hal_config_bss_params_v1 *bss);
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

