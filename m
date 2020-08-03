Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4074A239DC0
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Aug 2020 05:11:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCDLZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 2 Aug 2020 23:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727889AbgHCDLW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 2 Aug 2020 23:11:22 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C405BC06174A
        for <linux-wireless@vger.kernel.org>; Sun,  2 Aug 2020 20:11:21 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id d190so13001753wmd.4
        for <linux-wireless@vger.kernel.org>; Sun, 02 Aug 2020 20:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3Gog2znRpiQy6wPYsGUf9FYxk4e4/BYWwYaxty3ALVY=;
        b=KBUtOVWlteyuIsDzEt/d/MDfs/AKw1OQQlOaJ603BNQ4XExsJ40qfKSDUalWCA8QGH
         ktKso7OCM/X/NMbglI9KbLOCvObqAF7BEyJ/QvaRcsM0S+EgpxJOq3CCsoXbxOrgjWd0
         l6dUtNbQVY44R23UmT53MF18EIWh8AinVH6+01DDSc2XrOl7nUHuK3xi6ie1xNzBpe6A
         /lc9hnmbDxPc7tpVn0/1BTDS3NaN3gL3+T2UJIxBcHjbtr8XIJIfL9kDOkPAXxJkfn4F
         d826u9coUlrTs/7IXbYI8Tv4LGc77DX41LaZE+NAMMFXyHkBTUdlzfE2NmkrTtsmANvv
         OKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3Gog2znRpiQy6wPYsGUf9FYxk4e4/BYWwYaxty3ALVY=;
        b=swv78GyEqg4j2/rnIgRaAfjIg/GW0CKTClttVqMZm/P2k+al1Swh94yMEW6qFfBu9f
         ywMQ/jj+T6wFaYa6HmV+9V1ONQJt284ef04YXAcF9RD8OeH9pV6W4hRJr2/fQwr62ewg
         tV2LxheiVptdtNEWIcXtTCfAcY0nNs1Lq6KsYI8j1FOACofl9BuvYegEA3ei19ontkga
         mH9aAWc+9cnBB2tthiT7jWdPlJZ08495Z7d9zIVk1K0JscPqIFt7V1A8FC3kbAqyZeo7
         hz3cO5tG2PAylJb2oGrl+8O4gAWG7s93aDGYjyGrERUVBnLkAKPspArdgYL9WN0l5KcH
         7+pw==
X-Gm-Message-State: AOAM532DeS3AbuIxwhRqSAYkcSDpqbKxS6rJpgwwODxE7YID2ur8qkMr
        mpLlhVAXWeQBx2SBu4PoyDMuNA==
X-Google-Smtp-Source: ABdhPJwMVDmPdI3OkTf3Iwl1pL44EDQgD+h0uG/0RD9C9Zexi954Fs7dDUkkFtB9ulNS6fG07qpDFg==
X-Received: by 2002:a05:600c:2904:: with SMTP id i4mr13255240wmd.126.1596424280597;
        Sun, 02 Aug 2020 20:11:20 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id q2sm21956857wro.8.2020.08.02.20.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2020 20:11:20 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org
Cc:     wcn36xx@lists.infradead.org, linux-wireless@vger.kernel.org,
        bryan.odonoghue@linaro.org, shawn.guo@linaro.org
Subject: [PATCH 32/36] wcn36xx: Encode PHY mode for 80MHz channel in hw_value
Date:   Mon,  3 Aug 2020 04:11:28 +0100
Message-Id: <20200803031132.1427063-33-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
References: <20200803031132.1427063-1-bryan.odonoghue@linaro.org>
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
index 6a85bb699d10..c96ae33a80d5 100644
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

