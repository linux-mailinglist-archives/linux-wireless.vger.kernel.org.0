Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 163204884DA
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 18:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234801AbiAHRI5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 12:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234778AbiAHRI4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 12:08:56 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32F6DC061746
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 09:08:56 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id o203-20020a1ca5d4000000b003477d032384so3093690wme.2
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 09:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IZ9wQElu7gxaZRjK3LghSKU0X1qkME6nh55EQ6D9bBM=;
        b=aTho56GKtJR2hrR9HbKbKmd0cOwCdSYOJAKGV2Zbru2QRyd61qr/VsOK2uvtRxDOug
         HQBIFzKFtP2YIKufQHpi3N/s8M2j5t51/w7y7rD1rL54M1B718ErVMQBlL7ZXgikUueF
         VnqxLtJKrmt+Ab/lTbYEUm9974un6zJ/Pnzx8Q3lX0LjqjhiY6vyhCHccWOo7L/Sda+Q
         T2UUVSR94A3w1HyXbQVZCBHJfNMaRq6kN8to8VN6ko4aHBWKGrj8m7nFG0uvqONnp5Tq
         rKaEU+OwqeuFOqwBYaXOlj9qC+5I9PTJLR3KMKgi1sP/mB/cMFDsIWwdWbQv3o4HlCZ3
         Sw1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IZ9wQElu7gxaZRjK3LghSKU0X1qkME6nh55EQ6D9bBM=;
        b=hvm0e7iTG2uOw0kT6NF+uBMXrSE7miqn9zJrCEr6huDVdoZI1aurOSg64MjcNcTS7+
         2VrJhxQRg/9wOhh8AT8AA8BaMKQqt4MoHdpvn8hwALAw0YxZbmG3KJIC+16J27KXMW2c
         Bi7v1GYs8GsxX3Z4TiyhLdLEFk8n9FoKaJFosVBdUBWjyEWGEpfgwL3cM57lq+vxJlrV
         +nocDdWLcn4lfDqSoX9pYRjj3sudKe/OP0Q74wfNuiueQzddylM4J9oXt8Iw8XB0GXNY
         /vcKzeiBdEZZmjfQ/nqSlMTowzdns87Rd7qc+aXxFo4+lHFz1kPQu7GFhftCNGN8pBD3
         2Vlw==
X-Gm-Message-State: AOAM531Japprp4te+BgmyyqJNjxfPJWz0Q6Y9YW/PQgYeh9OIrUsAXHA
        5bNQP1jQuvhW7RC2792TED4C5A==
X-Google-Smtp-Source: ABdhPJxiIjlaYgp7K94rOhV97AOMYsiqk+QMow0BKlCzUDyUSBwOprHdD6obhJTH7WkH2C5c1kkz7w==
X-Received: by 2002:a1c:4e04:: with SMTP id g4mr15263008wmh.156.1641661734871;
        Sat, 08 Jan 2022 09:08:54 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d22sm2154727wrb.83.2022.01.08.09.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:08:54 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org, kernel test robot <lkp@intel.com>
Subject: [PATCH v2 4/4] wcn36xx: Add SNR reporting via get_survey()
Date:   Sat,  8 Jan 2022 17:10:57 +0000
Message-Id: <20220108171057.1823315-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
References: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add support for get_survey() reporting. Current channel and noise-floor are
reported, other parameters such as scan, busy, TX and RX time are not
immediately available.

Noise is a useful metric to report, so bring it out now.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 42 +++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 0e1f3dc4f69d4..9ccfe752767b7 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1357,6 +1357,47 @@ static void wcn36xx_flush(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	}
 }
 
+static int wcn36xx_get_survey(struct ieee80211_hw *hw, int idx,
+			      struct survey_info *survey)
+{
+	struct wcn36xx *wcn = hw->priv;
+	struct ieee80211_supported_band *sband;
+	struct wcn36xx_chan_survey *chan_survey;
+	unsigned long flags;
+
+	sband = wcn->hw->wiphy->bands[NL80211_BAND_2GHZ];
+	if (idx >= sband->n_channels) {
+		idx -= sband->n_channels;
+		sband = wcn->hw->wiphy->bands[NL80211_BAND_5GHZ];
+	}
+
+	if (!sband || idx >= sband->n_channels)
+		return -ENOENT;
+
+	spin_lock_irqsave(&wcn->survey_lock, flags);
+
+	chan_survey = &wcn->chan_survey[idx];
+	survey->channel = &sband->channels[idx];
+	survey->noise = chan_survey->rssi - chan_survey->snr;
+	survey->filled = 0;
+
+	if (chan_survey->rssi > -100 && chan_survey->rssi < 0)
+		survey->filled |= SURVEY_INFO_NOISE_DBM;
+
+	if (survey->channel == wcn->channel)
+		survey->filled |= SURVEY_INFO_IN_USE;
+
+	spin_unlock_irqrestore(&wcn->survey_lock, flags);
+
+	 wcn36xx_dbg(WCN36XX_DBG_MAC,
+		     "ch %d rssi %d snr %d noise %d filled %x freq %d\n",
+		     HW_VALUE_CHANNEL(survey->channel->hw_value),
+		     chan_survey->rssi, chan_survey->snr, survey->noise,
+		     survey->filled, survey->channel->center_freq);
+
+	return 0;
+}
+
 static const struct ieee80211_ops wcn36xx_ops = {
 	.start			= wcn36xx_start,
 	.stop			= wcn36xx_stop,
@@ -1385,6 +1426,7 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	.ipv6_addr_change	= wcn36xx_ipv6_addr_change,
 #endif
 	.flush			= wcn36xx_flush,
+	.get_survey		= wcn36xx_get_survey,
 
 	CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
 };
-- 
2.33.0

