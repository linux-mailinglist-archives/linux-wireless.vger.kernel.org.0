Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC3A9239DA3
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:10:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHCDKv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726757AbgHCDKu (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:10:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CD5C06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:10:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so13026542wmg.1
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cnyL/56H0ZY1bZCWnMx8pvkwuKGz4kOf8WM2bIlPthw=;
        b=FCpFudldTNINYGShwafjOQr1RJCRYvZdS1qEPhVcfW2PGS/ZdS/ucEkj4A3vaGOaZv
         AyGM5of5vVH2ydv4s6du+CJqot5dIt3q8Dzcrf8IomfrdNrkYbX33DLW77ucYgS7s/PC
         C56BnAKWfCQLxISSZt32xKs0pWhdPqs5dAl5Y1TCSLNSkicLRfB9tENlKf1bcsxDOaBJ
         QjQK5SzdQLWAYG6ZmwgCqqiwRuDZ7BmIkkY5Gyh4Mwou9GtahvXa8A7LJWC+CjCfzYkA
         reM/jWpDvOrMog4YeMUgxmoX987K5BqTf+IkIyCViGIt3hC5d+/lpo+MlocMYCtzmJab
         B2yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cnyL/56H0ZY1bZCWnMx8pvkwuKGz4kOf8WM2bIlPthw=;
        b=kCE1rK3P9GLs7JY6em7YircqTlulj8yNT+DOXI3YD7vjMzE6t/NTHeiP6eLxeQLfuC
         +pWjsqsDAdQwFv/FP35zpUdAUFyLYVfnaCy5rjcb1CPXgEC8kp80Fswgs/J6W8PoSERX
         lJ5R63b2aB/NjoEoW2gG5nL7505e9T+EFAnIESF+cY6Kv1TnXd60MavEy7/RwpomIyQF
         v/+hyfJcPyXCL7Lao8hkfDUBFASd4cyLvHZmTLbV7jKvr6yTj+h5++PFxVIsVbQYBReX
         WDE+CCeRyOGpCNYXTrg/VBtFbdeF+4YSnbn4kpVP895RUuT4rXwCPN4H6smdInu1r9kI
         54Ow==
X-Gm-Message-State: AOAM532Kd8nvObkV//z2isIsqiRvlXCNV3voosjvj3ZEF4nZFrdXLgVp
        oBbF8hlxIXt/6SM8GhR41rjJB8CbSCw=
X-Google-Smtp-Source: ABdhPJzr4nUsWJfjTKAragy/dqX5g2UFyE+hAOnEmfXVV89xRAqoaWaumt9c4UZOtHSxTJV3xiBqJg==
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr13253780wmd.126.1596424249054;
        Sun, 02 Aug 2020 20:10:49 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:10:48 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 02/36] wcn36xx: Add ieee802.11 VHT flags
Date:   Mon,  3 Aug 2020 04:10:58 +0100
Message-Id: <20200803031132.1427063-3-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This patch adds ieee802.11 VHT flags for the wcn3680b.

- RX_STBC1
- SU Beamformee
- VHT80 SGI
- Single spatial stream

RX LDPC is declared as supported in the datasheet but not enabled at this
time.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 31 +++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 73ba30a4d727..3b27ff6f6dac 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1175,6 +1175,34 @@ static const struct ieee80211_ops wcn36xx_ops = {
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
@@ -1201,6 +1229,9 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	if (wcn->rf_id != RF_IRIS_WCN3620)
 		wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] = &wcn_band_5ghz;
 
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		wcn36xx_set_ieee80211_vht_caps(&wcn_band_5ghz.vht_cap);
+
 	wcn->hw->wiphy->max_scan_ssids = WCN36XX_MAX_SCAN_SSIDS;
 	wcn->hw->wiphy->max_scan_ie_len = WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

