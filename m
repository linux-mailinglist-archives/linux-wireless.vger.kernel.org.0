Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EA23264906
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 17:49:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgIJPtj (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 11:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731317AbgIJPsN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:13 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C22C061344
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:39 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so372235wmb.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rwo9ulFXffmBiUSboQ3Oj3Dcuj3Fgxbrid758yS0THY=;
        b=j+lXJDHcwYuWzsQJt55oO7RJWUviQm/csrE/GGlCgz0iVjB2Pc9M5AegwHyVEtzbrS
         YOg8tnqBK5NvjYPhESZ44xSxniIan0taVSJEDNuzxs+f4G8pcxBD3KlcnXWMLdn7H2/i
         Emj26zznQrDrmvaVLRndoiWxTZzFGfSIqIhgIbYLkEsVxl2ETuIaDfyImRv/Mal2lkbG
         2kEsym85WL+MNI3TXCmw2jB4KmS6i1GZZomoDBmiaHUPe2dRmchWVdRY7/k0EW/gU4lh
         P8EwRwSDALqyPwDbz0qwdGzDpsLC9ggD66t2nsJI+9gcTm8t4pkb8WFHYWOt2zaJVUVi
         /g2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rwo9ulFXffmBiUSboQ3Oj3Dcuj3Fgxbrid758yS0THY=;
        b=SIYSDny85sIhx38yD2XdigbP+xR/VKBrqJwESGyfMCX3UjS+tIyOANxLoRmiClaXxX
         lgxQpUIsIpbhany4BTYJAwKjQOnOa5EkO0Ze+kPKz0Tk/uSrDlEycYxT3JCCOO+TPVlB
         GPrKysBxKYeOb9vIjRkEgGd/nqhgGQDW2jpCUNj/XTLAXq/QTTVfKEQrfS65hO3m1uo4
         ulTQbdngfMm6RlCBYAf12s0PLjD08QyXnc/HQHw9z3FuDTDMoIFiElalO8ptLYRuY7z9
         OLl8RHyt96dzcDzh2xgLqG08N6T1WASipMEgqqrWJKcj6n3DbznhKdFotAdT4Doyjuo1
         9fBA==
X-Gm-Message-State: AOAM533Rsu60006bVOxr0Mgoasa2T2VJ+5FRjwhCozWLTzYAa8TXOtNC
        Qkr0K2D1xoz0sHf6UqMSFpROyQ==
X-Google-Smtp-Source: ABdhPJyQ1Aw636dO1BThgeTra2S+9tnsljogGddMa93qvNWXUlfWRYNbViXWT9Y8rcg3cPl8bSFiRQ==
X-Received: by 2002:a1c:2ed0:: with SMTP id u199mr405417wmu.125.1599750458078;
        Thu, 10 Sep 2020 08:07:38 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id o128sm3895678wmo.39.2020.09.10.08.07.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:07:37 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 4/4] wcn36xx: Advertise ieee802.11 VHT flags
Date:   Thu, 10 Sep 2020 16:08:22 +0100
Message-Id: <20200910150822.2179261-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
References: <20200910150822.2179261-1-bryan.odonoghue@linaro.org>
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

After this patch is applied an AP should see the wcn3680 as an 802.11ac
capable device.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 32 +++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 720d3fa8ddcb..43596b919ed7 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -1200,6 +1200,35 @@ static const struct ieee80211_ops wcn36xx_ops = {
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
@@ -1226,6 +1255,9 @@ static int wcn36xx_init_ieee80211(struct wcn36xx *wcn)
 	if (wcn->rf_id != RF_IRIS_WCN3620)
 		wcn->hw->wiphy->bands[NL80211_BAND_5GHZ] = &wcn_band_5ghz;
 
+	if (wcn->rf_id == RF_IRIS_WCN3680)
+		wcn36xx_set_ieee80211_vht_caps(&wcn_band_5ghz.vht_cap);
+
 	wcn->hw->wiphy->max_scan_ssids = WCN36XX_MAX_SCAN_SSIDS;
 	wcn->hw->wiphy->max_scan_ie_len = WCN36XX_MAX_SCAN_IE_LEN;
 
-- 
2.27.0

