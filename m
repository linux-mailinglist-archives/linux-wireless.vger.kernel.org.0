Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13F594879B9
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jan 2022 16:31:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348094AbiAGPbU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 Jan 2022 10:31:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348095AbiAGPbS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 Jan 2022 10:31:18 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98D2EC06173F
        for <linux-wireless@vger.kernel.org>; Fri,  7 Jan 2022 07:31:17 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id k18so11684051wrg.11
        for <linux-wireless@vger.kernel.org>; Fri, 07 Jan 2022 07:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AsaR8KE4FUO+yauKKgOOa/fh5VYQZpsKbSDzqiBAFw4=;
        b=PDAuIXS4HJV16D/pIi6G6wE0bHzK9lD06+QDNBDZA0LsLOYvuY9BbFaJ+25zo9bgAx
         FfSRDN0D45bgazuCT0lTE4Xa3o4Gy50TEAlR3mHON78h3q+RE+iY2Hvm6g/FlnVlUfDJ
         V2qJEJT21YAzhSRsGbDhE1JUxJRANI1eX0+fzn2ZVDzOFbdEWk5mPk+CuVHr/O9HcXg/
         +LWireHtzpdpFbgDrcJ4+6KnY70LS8SDBgWO/5FSzjBjQBQLotV2dt3thsH96eav8nqk
         E8sI/6FxNeACr6ppYVB6KgpIqKEuUZr55BXtuu0QMtrMK0fHCRk0geRD7lxCPwugYxmA
         tKEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AsaR8KE4FUO+yauKKgOOa/fh5VYQZpsKbSDzqiBAFw4=;
        b=7DA+4FvfzwlCAX5thdpn7gJeyKKix0AtrpWgi02ENpz2i//dfy251ru2Abb9AF0GW5
         do2PmKZ7u3guPZLD6V9TqIa5eSEGhEFvGLX2zopL8dnGkyG9ZJPa/VdqAYwDtCS7ahYk
         4EKiSltF6bM3wS0qqNbLMSvEwY4rHT8WeI6RbzO9KpzRnkzSHrLBZI1cfKK03hYPACyr
         NA3yRlPd5/oRql8Bn3V1PY29K0pmMsjueEf49I+enCa2RDhsj6Ss3LFVUAixRtfhSHpY
         38ye2bZ9oGFZcTXoqAATz4VUMxqDLX7e5QC6CnwvFtJoDSJ/nPf/QZjHydxRmiKAvYAo
         b+uQ==
X-Gm-Message-State: AOAM532VzpzqfDRhw2nEnZBOTphU3w62PXf0Ac+YLdhs7An6YZ147JuN
        5r+lIMO+MrF+Tw1rNXn9Y9oe1Q77cI5yUw==
X-Google-Smtp-Source: ABdhPJxHrZDbR6Qe65+5Gbhc6xfb5DKjYNuSc6d2+RiNov1TEQV+n32Sq9JO/LHyQGh/uWpVdBFlHw==
X-Received: by 2002:adf:a45b:: with SMTP id e27mr1904950wra.661.1641569476231;
        Fri, 07 Jan 2022 07:31:16 -0800 (PST)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id m6sm997242wrx.36.2022.01.07.07.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 07:31:15 -0800 (PST)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org,
        wcn36xx@lists.infradead.org, linux-arm-msm@vger.kernel.org
Cc:     loic.poulain@linaro.org, benl@squareup.com,
        bryan.odonoghue@linaro.org
Subject: [PATCH 2/4] wcn36xx: Track the band and channel we are tuned to
Date:   Fri,  7 Jan 2022 15:33:21 +0000
Message-Id: <20220107153323.1807905-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220107153323.1807905-1-bryan.odonoghue@linaro.org>
References: <20220107153323.1807905-1-bryan.odonoghue@linaro.org>
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

