Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1559256463
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgH2DiU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726594AbgH2DiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:08 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C328CC061232
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:07 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y8so802547wma.0
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eyueDL1HpZcFmjns3DJaD8rZWh8gy/SLzoJpbodUmaQ=;
        b=MEatZ4qkA3Q5ErPunm5qnR+0+uYbnen5AD2b3OXNCtfvC7vCDCWns5XLYdaoQauP0s
         jEpTEwuv8b6M0HTTgulbRXzg9B+++8FgB2u1sAXzawA0Uwl2ikDVW8azUFyTYm82kBy8
         0O87/yKp73EnZKcTPv350uJSJOwi4ciMPcSiFNtb5ivqbQM9WiRNoDYlk6/6LgIhM4nO
         hbRJZlk48wrX1wzn32kTHCDfxDDnSKIfpY6n99HpE8vQbb5Q6Bn2mT8mjAnBM6ahVPXF
         ZBT0WGJ1R/DZZGyhOVr2KwS4akt516nmokgOSf5ODC4V6sCWUdyRbn4pMVYsJd+OUDzs
         JHaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eyueDL1HpZcFmjns3DJaD8rZWh8gy/SLzoJpbodUmaQ=;
        b=kJ5+Z1Lo8kwVroytSYcSHzpLXDcq+8gPvuhn/oCrXTmcOt2Hyvm1o0YLdkiEmjdXrj
         HbTGQz+fozlVw8ZWQdffpetgVocppIdbEpA5+sDmZAUA9mbbLRX9bPJMODmmWK20pHn6
         Q/NQWE6Vu3fBOVbIoIiVZ/CndWuvfM5rWjmgUm/KvnsrG+Tf/iaffuT3OF1cowDZ276T
         JDRzuRDukPy31+gurnaFQtBOahe9/hx4eqgttyR9m7NNWEnwZLgnEQS3u8xaVWPMaAj9
         7AEcFnVWWDBpDU3DX9f5Vig79G2LMAbimYhwTL4kA782bUOz+UKZeuESfIYwS9bpg2vn
         Rusw==
X-Gm-Message-State: AOAM5336+GL8ri2vHlMlbybPfpDyei+Gzafm/oScXnyFMgeN5WfETuUi
        WRWDmLSx99t+qBX0b93ddmW73g==
X-Google-Smtp-Source: ABdhPJw1M5xH8mcu0/vIdlGkg8dkTqw/putpUvCkXz/FipR8FUR1OYmWG59UlYUXqhj8YGYvY3w12Q==
X-Received: by 2002:a1c:1904:: with SMTP id 4mr1431433wmz.119.1598672286424;
        Fri, 28 Aug 2020 20:38:06 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:05 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 03/10] wcn36xx: Add ieee802.11 VHT flags
Date:   Sat, 29 Aug 2020 04:38:39 +0100
Message-Id: <20200829033846.2167619-4-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds ieee802.11 VHT flags for the wcn3680b.

- RX_STBC1
- SU Beamformee
- MU Beamformee
- VHT80 SGI
- Single spatial stream

RX LDPC is declared as supported in the datasheet but not enabled at this
time.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index eb518bd88870..08e23dbb60fb 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1184,6 +1184,35 @@ static const struct ieee80211_ops wcn36xx_ops = {
 	CFG80211_TESTMODE_CMD(wcn36xx_tm_cmd)
 };
 
+static void
+wcn36xx_set_ieee80211_vht_caps(struct ieee80211_sta_vht_cap *vht_cap)
+{
+	vht_cap->vht_supported = true;
+
+	vht_cap->cap = (IEEE80211_VHT_CAP_MAX_MPDU_LENGTH_3895 |
+			IEEE80211_VHT_CAP_SHORT_GI_80 |
+			IEEE80211_VHT_CAP_RXSTBC_1 |
+			IEEE80211_VHT_CAP_SU_BEAMFORMEE_CAPABLE |
+			IEEE80211_VHT_CAP_MU_BEAMFORMEE_CAPABLE |
+			3 << IEEE80211_VHT_CAP_BEAMFORMEE_STS_SHIFT |
+			7 << IEEE80211_VHT_CAP_MAX_A_MPDU_LENGTH_EXPONENT_SHIFT);
+
+	vht_cap->vht_mcs.rx_mcs_map =
+		cpu_to_le16(IEEE80211_VHT_MCS_SUPPORT_0_9 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 2 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 4 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 6 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 8 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 10 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 12 |
+			    IEEE80211_VHT_MCS_NOT_SUPPORTED << 14);
+
+	vht_cap->vht_mcs.rx_highest = cpu_to_le16(433);
+	vht_cap->vht_mcs.tx_highest = vht_cap->vht_mcs.rx_highest;
+
+	vht_cap->vht_mcs.tx_mcs_map = vht_cap->vht_mcs.rx_mcs_map;
+}
+
 static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 {
 	static const u32 cipher_suites[] = {
@@ -1212,6 +1241,9 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 		wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] = &wcn_band_5ghz;
 	}
 
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		wcn36xx_set_ieee80211_vht_caps(&wcn_band_5ghz.vht_cap);
+
 	wcn->hw->wiphy->max_scan_ssids = WCN36XX_MAX_SCAN_SSIDS;
 	wcn->hw->wiphy->max_scan_ie_len = WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

