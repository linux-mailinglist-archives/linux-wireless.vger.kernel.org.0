Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1797C256483
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:39:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727848AbgH2DjX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:39:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727772AbgH2DjG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:39:06 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44399C061233
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:06 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z9so855988wmk.1
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:39:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yQy8OHTZ0idummaIvQ2bIiI3uqJoP/LErWU5Dq1ghsQ=;
        b=kIVZi9oRTiO/jlsjnSJGa1Ewk4JNmh/k5+zIOdrkGi3h63VS8T96KLGBVem9EiZLkq
         qSB64lE+d3sZYzeoq2i2wtvjyvcte3Q9eivrrjq6tleyUEAXz2lABbFP5sUtnr7NYDQK
         m0bwUPaJjMsrRKEb55+V4NF5lR6SAHFmoW5pnHwCUvjDxsOztZjxzVJ5qwfbK+IGNObi
         oKTXwRDG71Chq5hB6l8cAFJcDwqsRfzRxygRBgm5CcDfP4fXKs+ivin8Yjq0sYJiQdcb
         jo4hmhy4Onw7MRkDZ3hMUsLaXkujQczF6LgW7foTK+q7zlUMvM9lQt+VGAKUoBCUozaV
         vT6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yQy8OHTZ0idummaIvQ2bIiI3uqJoP/LErWU5Dq1ghsQ=;
        b=uEIDqKQmiN4pd1RaHc8XeAYyw9mFqV6PbwZOcASP2fezN7x9TWb13XLg12DanMtBSe
         KesXob1TODBr9itNsr0nlaCemCONgXbUEQWSLZ14GQbCJfzO981++YlpOEWmZxNnaK6A
         PGAgDXf8VUk2F8cQwIfCq5FBygMGpX7W8IEdrhdwDl57YvQyygCeC9BedbrEx9FO3Aq6
         3Yxn7P8V9YCzIBKqbKrhqPaPXuON0zPi373AEsa+rpg4G38aBcAroXcBDT6CX60d3xC4
         TrPWvT3Wg/D2lIIO3JyXHRRcjbmzHYjOwXn4D3Jfc518txqx8JVg/NKQVP01vJ6iRgMp
         CxRA==
X-Gm-Message-State: AOAM530sZp1Fkd9JRkzcfMGZkW6EB5yYJdqvnZz9jOS7U9ObRiDIp/SR
        KzF6/kLu1mF7zAvbZNxfpQVKlA==
X-Google-Smtp-Source: ABdhPJzSC3IZktFW/wx1T7A7lihijJoVSM2wXkoYlhF4O4XO2LgWlZDOWQiKqQAEssPTQBCl3Had8w==
X-Received: by 2002:a7b:c399:: with SMTP id s25mr1548265wmj.13.1598672344983;
        Fri, 28 Aug 2020 20:39:04 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id l9sm1732151wmh.1.2020.08.28.20.39.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:39:04 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 4/5] wcn36xx: Encode PHY mode for 80MHz channel in hw_value
Date:   Sat, 29 Aug 2020 04:39:46 +0100
Message-Id: <20200829033947.2167817-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
References: <20200829033947.2167817-1-bryan.odonoghue@linaro.org>
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
index e92907a33443..9e97513feeb5 100644
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

