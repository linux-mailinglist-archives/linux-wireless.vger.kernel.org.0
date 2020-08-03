Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 264A8239DAD
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727098AbgHCDLC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgHCDLB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:01 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 806B5C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:01 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id 9so12987120wmj.5
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtHey7iAsoGrNcBMQl/5w9ghs+hy8e9VJSTGAKv138U=;
        b=sHbU4lidjcxZEGX9NBT70jWaIgwINlY8OFLsSCYKwoflkizeLRilTZFlI74xFu2mNh
         84goftO4U82tK1bmEAQQigC7qJrKut7NH0yRPpnykug/zvTYk62onVcMFYYkfo/ZE+05
         Qsy8LxX3r3JrcBSVcm4ELAwrZR7+XVLnZjn7bYB21Ai+oGigY9/DLE3UFxkKusl8vBvz
         9ebf1bvnZuMqNwdZitvh1sxXeg+uk1GD7xUBbl9SAYeSVlTQF3/ufVGRrGSAgjhoBQBF
         E2jB6LHpedJwNMuMgh2+/9x8HAniqWkuMIiB7eUfTbjyI7bmBBcA3U7vxNz4GPjHkWVM
         rrWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtHey7iAsoGrNcBMQl/5w9ghs+hy8e9VJSTGAKv138U=;
        b=DINmKMYnZkQL1xcqebNDxLcYQ8HJfQQGMYv7m6phNdUIw6UA0LPMkSfTC9kqzJHiad
         OPV8I7X0QwNtU7+cZalxfiYirb1Kvn12NJJrkWslQj5Vr35rde+MQMLpwAM/5+4afX7K
         Hoy/YKOgJCwGpAUWTmBn6EtlwYvL1FVIyHm1KS8PSdigWjmq23xkHinRs2WwngiJeHQJ
         L/GndAvHJ68XFitp6xNluWkv+eXzXJlX92KI3wcePyaPqMHOR3pGN5OGDHIld00zCsCr
         YVST+PmDomtIshiEWuT04Ut6TD3Ajxk9ZaW0NGSjjZiP/HJduYDX8uV5VSJRlg4yYz/g
         zN+w==
X-Gm-Message-State: AOAM531J7GWQLxvg+ZHDehhcCym+oyPZ0U2SnxS5ALSC1y0Y3gA/9zFv
        fvBIe7H7YiuSbKS1zzsXop/rFA==
X-Google-Smtp-Source: ABdhPJxwYw1EGkkF31iJjUFOTDFpKUZtYGSgTSthnLoIzCSsxwh6IzsjMlFdT4/KkZNZJZM/DA0d0g==
X-Received: by 2002:a1c:9942:: with SMTP id b63mr4632698wme.12.1596424260000;
        Sun, 02 Aug 2020 20:11:00 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:59 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 12/36] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Mon,  3 Aug 2020 04:11:08 +0100
Message-Id: <20200803031132.1427063-13-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 9f56f1af6dc4..6a85bb699d10 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -758,6 +758,14 @@ static void wcn36xx_update_allowed_rates(struct ieee80211_sta *sta,
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

