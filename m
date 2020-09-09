Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DABDA2633B0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730871AbgIIRIj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730387AbgIIPgw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:52 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78980C061347
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:52 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id m6so3493461wrn.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2HTnn0cKnVp0OVhPjKOxy9H7Cqlzp1+vwQDeRnijNCk=;
        b=AoomR6vFTgtmQMXBS5//PJ24M/3ZKmKyQPEjcQiFNBtDbR2FCjrTLmHELuiAzxBNvg
         wOjBFmMT0VYpRSNrY38zWzDCL6bCAtw10+11hmxCf6uihKbzbli7dGnT7J3jK45y4qp4
         A1Ph9QbYl3ylfpA9qcgWVBfig2lbJ4j3egKlWeDVlqdQrhjNqSOQKAD9AGrNMZlKnDTW
         +9YoDga5fId2bet7VwXVpezKEcMawr5z+5ZiqCcbyuXzX9iUJfmmB1WNWWftvzR7q/fY
         +yWX1BgSCAUg3bEfeVbuVF0g+0hD4TUIOAypIqLns/TTghkfKaWhYBh8rLS3Breo1n20
         gxyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2HTnn0cKnVp0OVhPjKOxy9H7Cqlzp1+vwQDeRnijNCk=;
        b=TyKuYKy+aAjzt7WoQyW/3oDUZGD179XZM2gIJGGaw7/tUm0zjBk+YwHh0d1nocD357
         GH0GPdQfNXI9GLBRTNaMWsvGwWj6+VnXOjht3HumnXy4nqfXzjQA+fl/JkN70bq0ydZK
         3XJ51ZRCCm5vqYJ0PDq4cULvLoVtuJGc7Ue0T5aqWIdo8F0vYauChZ2o38RhEF+ij7VI
         XGOukoXLbst3bzpZcgl+6WkvWDIeaDRQDiY69GADQYKQ/VE0/2rP4XSWEiqzMlCDcFa+
         MCJFrHyFAtAQWsPynPdLVgZjzW733sqAlhZSnSPZ/kXxIhcd1LDSi7sRqIammrjItO6W
         ijmg==
X-Gm-Message-State: AOAM53368rGRxbimM8U5H6yYCx1A+9E3hkIUW4cMP1ixBpAdIZ8cbHZO
        YY1fTBsRCq+18n5w3B2lD1WBdA==
X-Google-Smtp-Source: ABdhPJyuj139T0bm6NOz44BmAzXbrot05OwE9feJYqSyMuv98QB4/5qNI9GtHZRRvKepaXSkWo6tCw==
X-Received: by 2002:a05:6000:1083:: with SMTP id y3mr4366638wrw.405.1599665811176;
        Wed, 09 Sep 2020 08:36:51 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 128sm4470602wmz.43.2020.09.09.08.36.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:50 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 3/4] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Wed,  9 Sep 2020 16:37:35 +0100
Message-Id: <20200909153736.2905114-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
References: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
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

