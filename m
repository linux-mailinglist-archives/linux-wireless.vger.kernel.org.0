Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B37972633A5
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:08:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730498AbgIIRIJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 13:08:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730388AbgIIPgy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:54 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D685C061348
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:53 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id s12so3441094wrw.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rwo9ulFXffmBiUSboQ3Oj3Dcuj3Fgxbrid758yS0THY=;
        b=hIBDIvRY+yy78TmSS6OMPk57iLQDR/lyZQKzboua/CkqLlWySC7531fPNftguLjeso
         qNwfZdYXymY1BYADXVYkAs+7MUCIlVyirrr0RjO9mgIzlP1/gdafUJAB9f4bE++Ntd/F
         +WfTkLfSvV3CfqJGs4YNw9cld/ys6wTSSpHOK125k4Ekcxu5e51uh/NXmEhxsQHG1tsg
         KxCvkZ5ASpPdFcGi9yollNSqbMGmDNGwZXLocIZgV74rZIRWehE8DBAFfvF8qobYEDv3
         jnHbYau9bGO0P1RzXuCp/fX0axid+Ddp3V2wleboTPHgv0qEhBFpvCIGqUAASGdxmALK
         DxQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rwo9ulFXffmBiUSboQ3Oj3Dcuj3Fgxbrid758yS0THY=;
        b=DsSXmfxq1jEotDadOO4pU1Awc9Vs9PtwnblGRw1UOt9dZCvpPI19FRYyk5gwvqopBG
         53AInmd2n1cGj8lUDMEnbU5xrFqikz+wHfxlfz5lJOIpSi8LAICaIH86YjGG+5es1v7+
         +WYReyKidPQckJ03MPyUqfTRqzgl0XRALuD8xsO4/6FnpFkBhCn/El8hO270ibLiinYt
         660wa3wcbyUyP8NhKfn8S89vzCEEA5FdgK9FaZGUwPhpXDgyEdvKtaBOb5DQV0LF4wuM
         G/f0zc9yW7GomgkIFj2tnZtgNXcHzsfBOHZqboJQQXFq/uXG8lELtmVvGIJ1Q2l9FbHY
         pytw==
X-Gm-Message-State: AOAM532JW7IXwd4yfcUAX9EoyooQ3uPrORail9xmheRXx69QFb0CYr/X
        OW9idDcccDhzzfxF3z4SSZUMiojBCqa9ig==
X-Google-Smtp-Source: ABdhPJxz+RCmLxWoSihTc+AVdFHoYSKgh712ACdVAA/r3VQLvPrPtDIWP4q+yWwVYdPdkEF+N1Ftrw==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr4410725wrq.278.1599665812216;
        Wed, 09 Sep 2020 08:36:52 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id 128sm4470602wmz.43.2020.09.09.08.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:51 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 4/4] wcn36xx: Advertise ieee802.11 VHT flags
Date:   Wed,  9 Sep 2020 16:37:36 +0100
Message-Id: <20200909153736.2905114-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
References: <20200909153736.2905114-1-bryan.odonoghue@linaro.org>
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

