Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1C2A261A3F
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731461AbgIHSeQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731641AbgIHSdT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:33:19 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AFA3C061796
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:32:47 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id a17so241584wrn.6
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z6qrCJ1afOzM2JHrlRChudxsJ7Nezg4eE7nOnjz7F2c=;
        b=IcCMC4zxXnFlX7zX/e8uh5iM/2ZdRiqw7NXIeM/EZveQnoQhIUZeTfFN8/5d/I2NQ7
         nxRPdTe0moDgnp7WlOQLtW5JDyUxH63dOAR5LWYBj0jRZFhx/x60e493rjhHaVGwpsja
         JLiZZTvdehBA9y4ymJmA4BGVwYM4riPNG1NkZb+vJmhO3jA7E2c2fxEIfyNalrPDfs7h
         rQLBpdNPx/Wa+ENKcd4SnDb7milsIuUrTW+XmVLE5ZMET6mrLwAzdcyQWmPFgR6khuMC
         85vUUwYFHptjl6xj6DjU0gRAPBmDtWfiRMkGEIXhGZJOJz13E74iPVlCPfUDOCoB0qB5
         WNMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z6qrCJ1afOzM2JHrlRChudxsJ7Nezg4eE7nOnjz7F2c=;
        b=WhhTJTvKX9iqcxRpu8DAZmGT4+OqhDdGxBSvGMRmWG3lesHE/Pv2A35Gy6+nbHPtgO
         hqeXiD59BmPjsJXdJyIC2h507dmPoUElU9UcrIpTBd7Z5AGmczkJt2pn+/G3jRjKXsCC
         JX3tTxUXAFltN9XzE+AVVAEJq2S3KSZg5L2AsonDSp5+6xy6+EkpDdsPbMgThpiGblgJ
         WXA/ezULBS2kdi5hFHu/uQbLBVqKtg6rp7eVNBkOBS3curKLcERJPjM1r0PBtnEs0RLd
         DUn8/qd+VWe9Qov/QWmv7zXqCxTtkudsZUD7eEOErwU34nvsXW8rryr8q5Kz8i972pV9
         y1jA==
X-Gm-Message-State: AOAM530awMSPX1It6eNmlIZ9cTXl4JRbiAmzT+6nBdq6giaFaAZyU8OL
        0BY+r/SPTlzjtmycSdaXTqS8Ng==
X-Google-Smtp-Source: ABdhPJwTi6/vc++wYhsYEXQsAFJjREjeNXDnGv+vln06kF6HR1j4wIgGOcJtH+pNrh1w6p1Y0TxLig==
X-Received: by 2002:a5d:51ce:: with SMTP id n14mr11160wrv.8.1599589966213;
        Tue, 08 Sep 2020 11:32:46 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm380267wrv.72.2020.09.08.11.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:32:45 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 1/2] wcn36xx: Add VHT rates to wcn36xx_update_allowed_rates()
Date:   Tue,  8 Sep 2020 19:33:30 +0100
Message-Id: <20200908183331.2871016-2-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908183331.2871016-1-bryan.odonoghue@linaro.org>
References: <20200908183331.2871016-1-bryan.odonoghue@linaro.org>
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
index 2c2b6178c8cd..9c283c110e07 100644
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

