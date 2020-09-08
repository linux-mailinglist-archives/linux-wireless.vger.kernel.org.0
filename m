Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40DE261A43
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Sep 2020 20:34:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731605AbgIHSeX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Sep 2020 14:34:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731865AbgIHScz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Sep 2020 14:32:55 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD3AC0617BC
        for <linux-wireless@vger.kernel.org>; Tue,  8 Sep 2020 11:24:33 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id a65so274540wme.5
        for <linux-wireless@vger.kernel.org>; Tue, 08 Sep 2020 11:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrTOqER7Ro+hee8gyXLo9S/3xLKcWq5aNxrYU4kgAEA=;
        b=eM/nGswSaJQtep9usH63Ja+wpPAhQ+zIKb8VCATdPqi3jbLtCrM2NZ3edq6PtLr1c2
         UF7u+82n5N6B8CZjewP5FnNRH5gUVjrpuRRPrMyH7Fg2gfyJqMS8nVlUM/Y9zx1U2KxJ
         W15bk5wPavz5Vru0hyJyrqPYnj5Zchc2mVbtBSP3SCZtusYkNdxxaDK46Stl1gTwBolC
         OAskN1Jd8VayZnqzYdUAld5tHQSFu7258BkR7jPjonlfk/XxX3edXeboToXN1V5cn5n5
         MV2rTOBnJztCJg6MxQlyqSfcAIwKTxSH9zDdAVU1N1TuxEWnOilolxPMp/3TvYJritXL
         ye5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrTOqER7Ro+hee8gyXLo9S/3xLKcWq5aNxrYU4kgAEA=;
        b=OiDsnzVDV3TYcQIGv7c5nFMXY3WojFiACl5Z04PvY2pM3zRQ8qnBDqqptKPSonT3vb
         JJh3vMcrIyi3Lwbgkdt2+1ve+jNDKZHEsjCFP1L3Zr/GXusBZCt2coR7WPhd+yTpLOOz
         gsFq8iq3u9xE/ksY9Bvtm52Jk7bnGeMzgMr49e1MgC9nX7swVnIwMUWaNhfij37luxeM
         x66FpDYvkaadGmviNkmdFogEXmsskfFo3aHL9Z3KonwQqD21PNAFgRhOBR+CkYICaonW
         UGMJ9MS4vXcRtynDkKKf+C9sxr/Vli5ifNyw+qRF92wzuHk2omLRr2q+vxLNE4UNRBpj
         xuMw==
X-Gm-Message-State: AOAM531/BOzQd1Eg6/HI+Ijo4GdgDaF4w2EYgh8Lax8FmMvLuScpVjbi
        oZJ9AzjnbXjtWLAMJveXA/9CjA==
X-Google-Smtp-Source: ABdhPJw4nf81vE4P6Spmz3/7sMFU8eOdN18QH0KpcXL0KWblbpJnZW60e634YJ9iba1aVp+VuCYbYA==
X-Received: by 2002:a05:600c:2155:: with SMTP id v21mr422856wml.118.1599589472460;
        Tue, 08 Sep 2020 11:24:32 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id f14sm352447wrv.72.2020.09.08.11.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2020 11:24:31 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v3 4/5] wcn36xx: Encode PHY mode for 80MHz channel in hw_value
Date:   Tue,  8 Sep 2020 19:25:13 +0100
Message-Id: <20200908182514.2870410-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
References: <20200908182514.2870410-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This commit encodes the 802.11ac PHY mode for a given channel in the upper
bits of the hw_value field. This allows for a neat read-out and application
of the relevant PHY setting.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 50 ++++++++++++-------------
 1 file changed, 25 insertions(+), 25 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index ba37439352a7..2c2b6178c8cd 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -39,10 +39,10 @@ MODULE_PARM_DESC(debug_mask, "Debugging mask");
 	.max_power = 25, \
 }
 
-#define CHAN5G(_freq, _idx) { \
+#define CHAN5G(_freq, _idx, _phy_val) { \
 	.band = NL80211_BAND_5GHZ, \
 	.center_freq = (_freq), \
-	.hw_value = (_idx), \
+	.hw_value = (_phy_val) << HW_VALUE_PHY_SHIFT | HW_VALUE_CHANNEL(_idx), \
 	.max_power = 25, \
 }
 
@@ -67,29 +67,29 @@ static struct ieee80211_channel wcn_2ghz_channels[] = {
 };
 
 static struct ieee80211_channel wcn_5ghz_channels[] = {
-	CHAN5G(5180, 36),
-	CHAN5G(5200, 40),
-	CHAN5G(5220, 44),
-	CHAN5G(5240, 48),
-	CHAN5G(5260, 52),
-	CHAN5G(5280, 56),
-	CHAN5G(5300, 60),
-	CHAN5G(5320, 64),
-	CHAN5G(5500, 100),
-	CHAN5G(5520, 104),
-	CHAN5G(5540, 108),
-	CHAN5G(5560, 112),
-	CHAN5G(5580, 116),
-	CHAN5G(5600, 120),
-	CHAN5G(5620, 124),
-	CHAN5G(5640, 128),
-	CHAN5G(5660, 132),
-	CHAN5G(5700, 140),
-	CHAN5G(5745, 149),
-	CHAN5G(5765, 153),
-	CHAN5G(5785, 157),
-	CHAN5G(5805, 161),
-	CHAN5G(5825, 165)
+	CHAN5G(5180, 36, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5200, 40, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
+	CHAN5G(5220, 44, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5240, 48, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
+	CHAN5G(5260, 52, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5280, 56, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
+	CHAN5G(5300, 60, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5320, 64, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
+	CHAN5G(5500, 100, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5520, 104, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
+	CHAN5G(5540, 108, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5560, 112, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
+	CHAN5G(5580, 116, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5600, 120, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
+	CHAN5G(5620, 124, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5640, 128, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
+	CHAN5G(5660, 132, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5700, 140, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5745, 149, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5765, 153, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
+	CHAN5G(5785, 157, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5805, 161, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
+	CHAN5G(5825, 165, 0)
 };
 
 #define RATE(_bitrate, _hw_rate, _flags) { \
-- 
2.27.0

