Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF68A4884D6
	for <lists+linux-wireless@lfdr.de>; Sat,  8 Jan 2022 18:08:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiAHRIz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 8 Jan 2022 12:08:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234545AbiAHRIy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 8 Jan 2022 12:08:54 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C419C06173F
        for <linux-wireless@vger.kernel.org>; Sat,  8 Jan 2022 09:08:54 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id w26so136134wmi.0
        for <linux-wireless@vger.kernel.org>; Sat, 08 Jan 2022 09:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsaR8KE4FUO+yauKKgOOa/fh5VYQZpsKbSDzqiBAFw4=;
        b=HrhxxzPzt72gGOJLuEPC+46L2QT5SwLLeWWoN9hn9JpmMcDabXW4hlFg5lae+bZ/qW
         n+tMFc/9gP+aq6jjxv9U71e+86MwgXbfOSQX0IHrgtl7ya4DPgzW4b4lQjHg+xFbosBi
         8dLHPab0ld/WvQJ9bEGnNCJhEBMhwgrWaD7Ai12REZ2qDfGC/YMSROYOyfEP1bQYJ/es
         Uj2OtxNuzrvFXEbk3FuM7/OUCIP7TzCRjYLiHZZxJAJquUe8xdwQAHi6DpXavpi6xNpN
         1X96ogPEsJ9j5yBYLC2NsLpLLjB5KKMVe7L3zOTLtA4L107yJ/9Wm3+XtU+sOHxos8n0
         o4RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsaR8KE4FUO+yauKKgOOa/fh5VYQZpsKbSDzqiBAFw4=;
        b=d+vfJOop2KZyUvmvOVHfYo5z0H2PRq97P95/Kx3XZkLhmDdP00Ci33gXOanLsEhlU/
         iauIEPeOrfJjEebJazcZJgwlfgOjGC0u/SxEKUxGSyX57EJuBPSEI4OvbR2gpPJVINgX
         STYwxrIh8b9RDnzpCmrMXkQoDvpoBa6jSGsDpl8Q7qUQKKIE3zbKtW955EvnRX/qHRyw
         1SHKFDd5B96+mnW6uU0lJqjpjLP50fzv01DuOwGYdTQWCcXjHpheZBmugHJ/hqn+R/06
         ZWmcHD+fv6yFGDR399Uy7vL7x41yUdJSl7N6qw8AifGP6GEH1vmyPCsaHHT+dymmWRsW
         RO0A==
X-Gm-Message-State: AOAM532ipr5nHZDfLEcsld2oArMbv9hRFR6asVKfz8KQfII0tDwVj6pp
        VRy4WRqclw1y+JO2vcvYK0JBmDRspAr7MQ==
X-Google-Smtp-Source: ABdhPJyiU9pKLv5vfKKT5veNA8phKGUFvclYMFx3jsPoE1Gqzk5DoBdjj0hHWcH+6pUzw00OfyiaaQ==
X-Received: by 2002:a1c:2544:: with SMTP id l65mr15616230wml.101.1641661732733;
        Sat, 08 Jan 2022 09:08:52 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id d22sm2154727wrb.83.2022.01.08.09.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 09:08:52 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH v2 2/4] wcn36xx: Track the band and channel we are tuned to
Date:   Sat,  8 Jan 2022 17:10:55 +0000
Message-Id: <20220108171057.1823315-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
References: <20220108171057.1823315-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Track the band and channel we are currently tuned to by way of pointers to
the standard structures that describe them both embedded within the driver.

Tracking of the pair makes it much easier when implementing
ieee80211_ops->get_survey to return quickly captured metrics for the
currently tuned channel.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c    | 27 ++++++++++++++++++++++
 drivers/net/wireless/ath/wcn36xx/wcn36xx.h |  3 +++
 2 files changed, 30 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ec355807f5817..d2b99f6112f6b 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -392,11 +392,38 @@ static void wcn36xx_change_opchannel(struct wcn36xx *wcn, int ch)
 {
 	struct ieee80211_vif *vif = NULL;
 	struct wcn36xx_vif *tmp;
+	struct ieee80211_supported_band *band;
+	struct ieee80211_channel *channel;
+	int i, j;
+
+	for (i = 0; i < ARRAY_SIZE(wcn->hw->wiphy->bands); i++) {
+		band = wcn->hw->wiphy->bands[i];
+		if (!band)
+			break;
+		for (j = 0; j < band->n_channels; j++) {
+			if (HW_VALUE_CHANNEL(band->channels[j].hw_value) == ch) {
+				channel = &band->channels[j];
+				break;
+			}
+		}
+		if (channel)
+			break;
+	}
+
+	if (!channel) {
+		wcn36xx_err("Cannot tune to channel %d\n", ch);
+		return;
+	}
+
+	wcn->band = band;
+	wcn->channel = channel;
 
 	list_for_each_entry(tmp, &wcn->vif_list, list) {
 		vif = wcn36xx_priv_to_vif(tmp);
 		wcn36xx_smd_switch_channel(wcn, vif, ch);
 	}
+
+	return;
 }
 
 static int wcn36xx_config(struct ieee80211_hw *hw, u32 changed)
diff --git a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
index fbd0558c2c196..dd2570e468084 100644
--- a/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
+++ b/drivers/net/wireless/ath/wcn36xx/wcn36xx.h
@@ -281,6 +281,9 @@ struct wcn36xx {
 	/* Debug file system entry */
 	struct wcn36xx_dfs_entry    dfs;
 #endif /* CONFIG_WCN36XX_DEBUGFS */
+
+	struct ieee80211_supported_band *band;
+	struct ieee80211_channel *channel;
 };
 
 static inline bool wcn36xx_is_fw_version(struct wcn36xx *wcn,
-- 
2.33.0

