Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E1582649B9
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Sep 2020 18:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725833AbgIJQaC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Sep 2020 12:30:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIJQ1u (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Sep 2020 12:27:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB9AFC0617BB
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:25 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id b79so367784wmb.4
        for <linux-wireless@vger.kernel.org>; Thu, 10 Sep 2020 08:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mNr+Pfqwu/0aRFo1Po43D8D7g7/h15rV4ULpD0JgPO4=;
        b=mLUG+m2RMLYxd7+leQI+qGNm+14EZ05Cj539MxNHPEzvfR0Y/j63C+135xIHgv8k2v
         Bxna23J5ESOfrp/FVfyICxm9P3jBJiIrvuhJ9Ux/Tfjtc8Ivoi+hmL7ZoA7sk8XT6JLf
         xtv4U7hZsBjxSsrVanmUqcSwZpLJhph1N7uvYy6aePa3CG1CIF2MFM46bpxGvUHUhmGN
         lRN38DQwOw3MB0Aahg1whV902XAPZNvViZCvdDqKDYIdflfTXvlHILv3Lx1UBzA4QDTS
         RW6axvCy7GUgyta00Y4vSzyO9f8dRt6AjG1SkcvlwspdAwOjswil9bOQxBzfqvgvNMng
         WeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mNr+Pfqwu/0aRFo1Po43D8D7g7/h15rV4ULpD0JgPO4=;
        b=Wx9atAp+v9a/CVrhKJl5gs9BIXSI3/+ebcHGxeugB65cP7+6wKn9Yf+xa4OWAWHQTf
         th9/LsHnEf0K5P+9kb+BIEyA0zdYPgF5YCO1KjHeTRG3+UsxLv5Rde0hrw792VHC4znu
         6Xeuh/XlxGxK4nOOGkhVHI3HBLi9Mv6DR5obA689SoPNSmHsVBKVlc1zbI9AmGqyxXsF
         k9thbfKSJPtB6zPJm7XEWPJBFCe7HQPBr5J1FYIas8Hw4+ZYnsiM5d7f+tKtK0YpDCR0
         SAikPqvYtTl6ho1s6FBJZCj9XoByFkynpCHCxu7faAgKglI88F8q37/DX8Nb/7uGQD29
         qyaA==
X-Gm-Message-State: AOAM530lAQgiK1j2Vyw44NIQg2V/OJH8k5DZWBqgpsval/GQu2Oy1XNN
        vip0AJPUvhM30ragzIdf80DMCw==
X-Google-Smtp-Source: ABdhPJzqIbA5VVfajo0eQCsOfEGM4QlsUQcd1AtV47G5v1LQzPqkRcgzOdkE3jnNKliOr/8MgEyckg==
X-Received: by 2002:a1c:cc0c:: with SMTP id h12mr411822wmb.57.1599750384590;
        Thu, 10 Sep 2020 08:06:24 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id i11sm8778906wre.32.2020.09.10.08.06.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2020 08:06:24 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v5 4/5] wcn36xx: Encode PHY mode for 80MHz channel in hw_value
Date:   Thu, 10 Sep 2020 16:07:07 +0100
Message-Id: <20200910150708.2179043-5-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
References: <20200910150708.2179043-1-bryan.odonoghue@linaro.org>
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

