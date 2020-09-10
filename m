Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D3CB2648D0
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731343AbgIJPe3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:34:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731105AbgIJPdD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:33:03 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C32AC061343
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:38 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so394087wmi.0
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HTnn0cKnVp0OVhPjKOxy9H7Cqlzp1+vwQDeRnijNCk=;
        b=Udk9i/A3q4l8EyDrosQNtzW5i1Tl7gMR62Dmd1N6E/F+bH6NAhG/bTLZo6/7hbjBu7
         tZrRbOI8Om1pjmZvRVsIf7QW0Hkrafu7QKJIrjAM4nniBClNnmgb0LNm2WnvQtSlyNuh
         lwEjeJncEjtFuo12YjDw63l2n53N402POxvBVE+m79SdOZpWh2vzlSq3GA8H9nX3o63K
         O/ejxXkp1ES/NFRK9QqS2Df7M/h2RBGI4jdcSvvPnTo4LBy2EeyI8AvEkw+zau5AiOIK
         qaDvJ+QmskmzZ5Lv523afDWfvrg1AtYnI/2ZuAXxWUk1mIM0ZylOnHEBaWzOAkAytjQb
         V+xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HTnn0cKnVp0OVhPjKOxy9H7Cqlzp1+vwQDeRnijNCk=;
        b=lzVvuQAVFMEfnqQjFz6PExkcKKKcBJ4JOEoBu/aQ+iMMqMYpUHBNuYWT/cdoNQw2EQ
         mdAqyypyaLACkbiyd/I2uPY1A+HzxgvA0Yct6xxxqyWlNbeEOAtyqwjkDIHvZbcCwIra
         5TzeOWCtxNhlleZvzT7MBKWfceSLyJLaAa2J2PZn+7N1HENuau9r6dsXTh80eXaDwE52
         KQsvXaF8LJCgpxTGVvhRns9yTgSF0xAlY0xhB8FfYLCZXKUbTn2Lq68BhD9JPlXiDAP4
         Mz1hAZb4PevJ/9FOqyX4JwVUlmRYN7bKx+hCazuFUmBHSOhYWiLdRAwlp044UeSEnfUQ
         OP6A==
X-Gm-Message-State: AOAM531kf5wqDnPQ6cjopsTdXbbvrPRMLiD7mQbNGJEZZKYsiRJqFRdn
        s7xgSNaNWzRgjwHCZx0Sj/HBKg==
X-Google-Smtp-Source: ABdhPJy/qhDvn7lyh6z56OikbGJesllg8a2IMHkPyjaeePHbpEOfBEeA7DblgCZEB9mgkXvNTEhV1Q==
X-Received: by 2002:a1c:dec2:: with SMTP id v185mr440365wmg.1.1599750457145;
        Thu, 10 Sep 2020 08:07:37 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o128sm3895678wmo.39.2020.09.10.08.07.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:36 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 3/4] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Thu, 10 Sep 2020 16:08:21 +0100
Message-Id: <20200910150822.2179261-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
References: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
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
index 36cfa7043bc3..720d3fa8ddcb 100644
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

