Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 901D5256471
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgH2Diz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727013AbgH2Die (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:34 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E550C06123A
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:33 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so859702wrn.10
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LAUjl4qBWaw4FcREKzPLcJ67Zc3Yyp+jTDTvGFFFspg=;
        b=c5csRQitPGDzMhYdd0ShpPj6QcsJdqwWprevOTnXxEApgBLAqjvR4YO5xjoUeQbgNO
         gl4cENIUNCuxH5z0awvX0dno2adhCrE2KIPB8VwcttmYu6VkfXpr+ic6xdo+lQZELrv/
         agbwA6GNL11ftA1z7cx9bPmXj3Ka/Q0Wlr3Uvty7Wv5RIR3easZEIsdRafGWoestijim
         0Q00WclE4CiPNCAx7Zo9g9BatU5YeaHHXz/mCiAPwuyo21SsHk9Fp0O28IMQ383Cvafy
         0Cit4J2BPivECRtXHLGX+tqLucaBVDSrBPsUWN6HD0ucXTDQB4/3bE7VWhDgW7uTDt8b
         DVhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LAUjl4qBWaw4FcREKzPLcJ67Zc3Yyp+jTDTvGFFFspg=;
        b=TnPkUQ345NzKMnVAdLkbsWFuvwy6N1cO9nloCtkqRHe/sR48T9I+ZpBBoL/6FwDpxd
         GJxCm4I1eImQAWu4s23pViUUCGC7No59+eGpm3wVQsV/cD6YRuqU1Yek3Cv6+V5k4It4
         MrpYFr2sQsJWHBfPT4CJfNQd+x/VGAsecYxu3W6nP4LHIjp0BvpdyCwnKhXf2u2+uRxp
         bfI59AeyyIAcrjbcO5K34QYwzbl5PqiukzzQXgqcJ62U9hKSggnts7OMcFF4lOiJdbgu
         7xzesPX7cH0mPzc6vX0hCBlUVUuM0YKLgLHL6IOwGcaoOBqMLpDm/fxXk3voqnywP8T6
         Y3pw==
X-Gm-Message-State: AOAM530sIVQrHK+jY40ajaznouu6nJ0qR+50b1qjU+a70kHO+uNji+3m
        qhMsvNUEc5ciFPUZPX9NrPCxuQ==
X-Google-Smtp-Source: ABdhPJzYPyiS6qk/HTNcX/UxRKEFj5SXZDBlYTbSNnBGV/iOAExVeBu6QbTHHI1ETOgbsbF+MKQCFg==
X-Received: by 2002:a5d:50c7:: with SMTP id f7mr586054wrt.367.1598672311921;
        Fri, 28 Aug 2020 20:38:31 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id t9sm1649179wmj.47.2020.08.28.20.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 09/12] wcn36xx: Add wcn36xx_smd_set_bss_vht_params()
Date:   Sat, 29 Aug 2020 04:39:05 +0100
Message-Id: <20200829033908.2167689-10-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
References: <20200829033908.2167689-1-bryan.odonoghue@linaro.org>
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
index a6106ba9cc89..b311b170fd36 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -146,6 +146,15 @@ static void wcn36xx_smd_set_bss_ht_params(struct ieee80211_vif *vif,
 	}
 }
 
+static void
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

