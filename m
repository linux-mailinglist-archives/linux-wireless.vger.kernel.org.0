Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2308A2630B1
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 17:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730411AbgIIPij (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730359AbgIIPgU (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:20 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6C7CC06134E
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:16 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id s12so3438747wrw.11
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNr+Pfqwu/0aRFo1Po43D8D7g7/h15rV4ULpD0JgPO4=;
        b=Y2/PyBWdxg1P1jEbkeXKlpmoigQdCKRo87k2Le3pRYeEoxfnA4NvrUfQnpkcmkSMJ9
         SgRep61lw1lGaYH/GbF+9b41ELuBMcS8XeftkoU8zvRnWIKmIKA4Pb0j3RSQdUx1SZKn
         5uSzSIdhrKdwIU6aWO4extuXuHSkLpCBdYNmjVvP8OCqYYTOJL0d4Hsj6eu4fDYts4dU
         TeTLwLskJ6tz+iN72GL2kpUoZicGvsO1kZtP+ffojLjVCZqos1JHGAYgBMPijYbJle8C
         zi1BOM6+rJXuBPEU21VFEp3v+/q7OzomQwjBzUh0DxCUxnSgbWZmlWvj9v7FJdbpyAiw
         5h6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNr+Pfqwu/0aRFo1Po43D8D7g7/h15rV4ULpD0JgPO4=;
        b=k8UfFVrnr7kVVa06XZUXCLj6JA9C9V4btbpXeKN1/AnK4YgThSpxzybrkwyOv9uUS/
         IfXo9dAO/kLy+pN5xDbWEohYLdpIc21xpTT8fT5WVj+J3xoCg1ikWhLzdmVTjhai6pw8
         U3bkY1FQ0RzjmYsuOccOIX7q7w8gzBzWJRmf0cVPdoLrrc9tk4a70hS7P7RNXCm6SVFz
         mJOANoL4QXh2oJYmbz9G/ldqYb3eLY7haAhWIzeYcGZyP6+sgqCbq2uFrvGDuUJbYlpf
         MfjTxEKty8Q4hzFV4rSt++OesNeEuWP+BhgjMVRXbz0by3fhjjdHMnB49GNl9rtGVG4h
         EEqQ==
X-Gm-Message-State: AOAM530W+/bqM0v0/n+N5wzrkbTVRE9uCOipEuqzj7nbjiCUj998Z0Av
        8rbtawA+FmpFb2rx6bCrHNx8OQ==
X-Google-Smtp-Source: ABdhPJwJYAk5aw/RdYlLTmolBuMN2pPC4JFvfCb3/5Pf+V5Eb/UyIUUQau5yUUBgX9XrkHoJWphptg==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr4282315wrm.320.1599665775342;
        Wed, 09 Sep 2020 08:36:15 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:14 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 4/5] wcn36xx: Encode PHY mode for 80MHz channel in hw_value
Date:   Wed,  9 Sep 2020 16:36:59 +0100
Message-Id: <20200909153700.2904977-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
References: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
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
index ab6685dc956b..36cfa7043bc3 100644
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

