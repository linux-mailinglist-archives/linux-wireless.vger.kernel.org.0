Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C50BB25647F
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgH2DjS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726968AbgH2Di2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:28 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C4CC061264
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:27 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id z9so855446wmk.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rRqKSMYLkOaKma6hces3R6ozgO9nu1SFFWnxLHLzpL8=;
        b=csGKY3VOY9JXG15H2u4jrtOYlIQk776WhWvFofhzxxiSCkgWBkL28SQMcxyI6srSdS
         eZEOMmswzv6cOe4kp8l2fmRkk5HOUIMnrEpj5YeqYcYD0yQCmIfkJpXSdLO2t6eC7YrL
         Mh6LRpBYM4XvNiqRRAXP0TxGywBqhrqVcxB1re+dqHtjtF3PDRj5wtOqxHStVZW0rtj8
         YNCEI2buzQwdDjoBIi8XHbksbK47Mkd4ndALhJgu9LMsRd3i+YpI/H6YMTBoxGw+AMxT
         o530JDYGpcamEmZuti06r7ZFIf14ShN9LcOWeXl9koBG8j3thj8yGVRh9NAKQy99PW6G
         nXmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rRqKSMYLkOaKma6hces3R6ozgO9nu1SFFWnxLHLzpL8=;
        b=lr7v/dL0BPh78NRLPkHNTDFmIxIfMgIDdbhPJn74bollspHLIMWQHchrJ2mbwPVS8Y
         0BURCfqrZU99I+WJmsBC6zG+hwr04lcKPbIYn1VXkJxmnrN+2O+MeamXAawjTGe4moN6
         WaH44hHn3pYZ6Ov3RCE8IQNIqE7Q4jVx7TzIIErLs7qAf1yMxEF+HCQDqnEU9x6yt+rV
         lNkIpDXupaBQuoZqTDvIZmbigWCTkEAvydbK7tDDAcjEvQeoXtr9y72CPnE5ppg5z6hq
         DivrE5S+mNcy/1qUjpkX2cWrzkeYNdLpkYARVWUAPfdBLQx+tE5D2kLVFIIs/bDNUfnL
         qOfw==
X-Gm-Message-State: AOAM5311fPq57AJoWXxxowD5yC2rFJdr2/Rm1vqoZj2BR4o3cZmWb6cR
        V6WM9YLSD5zrG1+tS5o3LiDd8w==
X-Google-Smtp-Source: ABdhPJzXCMP7zOHEhe40suPZ0eQGMQprioaQBpdzl4Rd4/BlT6Jc6vfrgTnCCZ4cXmOgUEgHrFmwzQ==
X-Received: by 2002:a7b:c397:: with SMTP id s23mr1544014wmj.174.1598672306206;
        Fri, 28 Aug 2020 20:38:26 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 04/12] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Sat, 29 Aug 2020 04:39:00 +0100
Message-Id: <20200829033908.2167689-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit adds VHT rates to the wcn36xx_update_allowed_rates() routine.
Thus allowing the driver to latch the declared rates and transmit them to
the firmware in the same way as other 80211.n rates are.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index d589a00d901b..e92907a33443 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -766,6 +766,14 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
 		       sta->ht_cap.mcs.rx_mask,
 		       sizeof(sta->ht_cap.mcs.rx_mask));
 	}
+
+	if (sta->vht_cap.vht_supported) {
+		sta_priv->supported_rates.op_rate_mode = STA_11ac;
+		sta_priv->supported_rates.vht_rx_mcs_map =
+				sta->vht_cap.vht_mcs.rx_mcs_map;
+		sta_priv->supported_rates.vht_tx_mcs_map =
+				sta->vht_cap.vht_mcs.tx_mcs_map;
+	}
 }
 void wcn36xx_set_default_rates(struct wcn36xx_hal_supported_rates *rates)
 {
-- 
2.27.0

