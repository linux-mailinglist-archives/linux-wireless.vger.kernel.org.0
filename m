Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A708263396
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Sep 2020 19:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730367AbgIIPiR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 9 Sep 2020 11:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730361AbgIIPgV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 9 Sep 2020 11:36:21 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E22AC061364
        for <linux-wireless@vger.kernel.org>; Wed,  9 Sep 2020 08:36:17 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id y15so2846018wmi.0
        for <linux-wireless@vger.kernel.org>; Wed, 09 Sep 2020 08:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ALkvRKCUevbeFhjBwQhyolUataIAPGgfoMc2+wbgZyY=;
        b=b71P0uq3o1CkXwB1hBnlO+YSTdS7UzGiatB+Dy9bTJR90GXL+4ZqjeMkw9jeDU1rrq
         rJ4oqyIM2kI8PINP2FPnIyP9eyt8XPIBrfBj96GCGNmx5oWbxQNG38s8cziTUPSQyKwy
         cNmOCzFpk4R+iN3msgGsE3eT6Lxpm/+lycNdDnBstcQpYj70dpF9bg0y0uU9rE53HDr7
         zO/x+4wEYYKqaTkURKCSlA4AntuS1jDnXLqjZii3VOwYbNAI3bQnczwiGdadl96OqT2P
         xpZf81ZDApuK5285oqFokvShTZjOzMfiRQbCyQU/4q9Js/ULB+nAKjF4coRnkW2w2Vgn
         YxIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ALkvRKCUevbeFhjBwQhyolUataIAPGgfoMc2+wbgZyY=;
        b=bvV7yj+4R9Sv10o0rReaU/B5HIl1A7dovKnPWrx0xOcgQdh01CbhXAk2WewK5qRDMJ
         FXAZrBnQI//IQ9ufjP+XRH3Q1ZOYjNCh1mplJraY9dLQ5CDZKiSxbSMIWaqQvPAUfM/N
         3vTRM9KOkrlCngkwSDeVJb9dWxGWHw9z7uDrjyD9ZhQ+A3M0HEbCFrkRsgHjgCNHFdt4
         YkRIaT340u3Tvx33q6P2qXEzBncBnSpIRapO2weAUGkfFWKIXbDeTkW7KVQk/HbFYcIQ
         rX2SwHDVTZE6KEv7QCOaZJaJjNMDqDIRLJ8repBBgNXb7neCzExF9LATsh6rrMvXGBto
         Tzzw==
X-Gm-Message-State: AOAM533rYwanI1wRIedego7kD/PpZx0Cgrc6Yl86YhghJR55ekcyz2T6
        JRN/qoPfE0oA44902uz0PBRnxg==
X-Google-Smtp-Source: ABdhPJw7+UPY8SxPXMnieK/m8NJH6L+DNNkzzxgf7aWbfNZuAfY1oiqmW6mt1HZO8Wuup6ZNsLhRTA==
X-Received: by 2002:a1c:2ed0:: with SMTP id u199mr3998553wmu.125.1599665776313;
        Wed, 09 Sep 2020 08:36:16 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id v204sm4619807wmg.20.2020.09.09.08.36.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2020 08:36:15 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v4 5/5] wcn36xx: Set PHY into correct mode for 80MHz channel width
Date:   Wed,  9 Sep 2020 16:37:00 +0100
Message-Id: <20200909153700.2904977-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
References: <20200909153700.2904977-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

For the 80MHz channel we need to set the PHY mode to one of four PHY modes
that span the 80MHz range.

This patch latches the hw_value PHY field previously defined for 5GHz
channels directly to the parameter passed to the firmware.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/smd.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index a28bf52a60c5..55d2609bd9a1 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -1487,6 +1487,7 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	struct wcn36xx_hal_config_bss_params_v1 *bss;
 	struct wcn36xx_hal_config_bss_params bss_v0;
 	struct wcn36xx_hal_config_sta_params_v1 *sta;
+	struct cfg80211_chan_def *chandef;
 	int ret;
 
 	msg_body = kzalloc(sizeof(*msg_body), GFP_KERNEL);
@@ -1526,7 +1527,13 @@ static int wcn36xx_smd_config_bss_v1(struct wcn36xx *wcn,
 	bss->dtim_period = bss_v0.dtim_period;
 	bss->tx_channel_width_set = bss_v0.tx_channel_width_set;
 	bss->oper_channel = bss_v0.oper_channel;
-	bss->ext_channel = bss_v0.ext_channel;
+
+	if (wcn->hw->conf.chandef.width == NL80211_CHAN_WIDTH_80) {
+		chandef = &wcn->hw->conf.chandef;
+		bss->ext_channel = HW_VALUE_PHY(chandef->chan->hw_value);
+	} else {
+		bss->ext_channel = bss_v0.ext_channel;
+	}
 
 	bss->reserved = bss_v0.reserved;
 
-- 
2.27.0

