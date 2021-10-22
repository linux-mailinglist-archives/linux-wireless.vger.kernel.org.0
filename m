Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A9B14380D2
	for <lists+linux-wireless@lfdr.de>; Sat, 23 Oct 2021 01:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232631AbhJWAAx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Oct 2021 20:00:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhJWAAt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Oct 2021 20:00:49 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 340E3C061766
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 16:58:31 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id h2so5946362ili.11
        for <linux-wireless@vger.kernel.org>; Fri, 22 Oct 2021 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Si5lbp2a5j1U0HCfBdV44/FetwO/pG2+HucWazNTbKw=;
        b=DGLA132M8/FcLhmK+vR/nRo3FP1yMAFtCW/wpXyxgIuPQ4cAfUllbs2aMQTKChayMT
         ouvOy/ViIQ6lgP6RqHy9eK1V3UiZS9nC2NDrqj+fcF7iPabCMtmPhFpN9oifDJYDnv0E
         Q4n+llSZ3HBSJCUYzMarAU1D84l0/OZ9Rp1Yg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Si5lbp2a5j1U0HCfBdV44/FetwO/pG2+HucWazNTbKw=;
        b=uDUT0S1Qn3m1D6XBfr0PW2UrxqMKXs2Aj5EzU+07JAnQy914UyIvIhp++gZpN56tsN
         xGDmbYqAB437VZwBFcKglRk3SD6DmzmNSLWFN2o1DpqPwyV7ezZlBmH9+n+y2y2dj59S
         4PGz9GHNZhR7EbqEAv5d/HG2XrSHJCkvL04oMe3OuTAHtZiHik88hsm/niiFhYi2Z3aj
         EfYVG+BIrnlEGHbe6lCAwsQj+/JagkftEBmJ/fzKt3GuUJnz8Q/CpLznvfA7zia8++8V
         PdWyyM34O3POq2w4EVrNeNE5XkzT0k+/BRWbxRAD9/az79YpdjT70bCURUlYYpG10UiM
         IIwA==
X-Gm-Message-State: AOAM5328ZTjMZTNz3NI1JuN3D+B8X5A0ZCs6xCZglSAsvfWAd7Fjoz2n
        jWDL6dcR8iEWXJZ9cIFPTXhHJl/L8xMk0w==
X-Google-Smtp-Source: ABdhPJzRtntF5c8V3sfCqUww06qkit5at7Z11doVNrjArRmWDnnYm4qe/iI+e9PNGrKVL0wN2RzvKQ==
X-Received: by 2002:a05:6e02:1d13:: with SMTP id i19mr1815550ila.182.1634947110542;
        Fri, 22 Oct 2021 16:58:30 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:cd01::382])
        by smtp.gmail.com with ESMTPSA id z11sm4761784ilb.11.2021.10.22.16.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Oct 2021 16:58:29 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] wcn36xx: add missing 5GHz channels 136 and 144
Date:   Fri, 22 Oct 2021 16:57:38 -0700
Message-Id: <20211022235738.2970167-3-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211022235738.2970167-1-benl@squareup.com>
References: <20211022235738.2970167-1-benl@squareup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These channels missing from scan results are a regression from downstream
prima.

Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/main.c | 2 ++
 drivers/net/wireless/ath/wcn36xx/smd.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/main.c b/drivers/net/wireless/ath/wcn36xx/main.c
index 263af65a889a..13d09c66ae92 100644
--- a/drivers/net/wireless/ath/wcn36xx/main.c
+++ b/drivers/net/wireless/ath/wcn36xx/main.c
@@ -85,7 +85,9 @@ static struct ieee80211_channel wcn_5ghz_channels[] = {
 	CHAN5G(5620, 124, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
 	CHAN5G(5640, 128, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
 	CHAN5G(5660, 132, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
+	CHAN5G(5680, 136, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
 	CHAN5G(5700, 140, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
+	CHAN5G(5720, 144, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_HIGH),
 	CHAN5G(5745, 149, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_LOW),
 	CHAN5G(5765, 153, PHY_QUADRUPLE_CHANNEL_20MHZ_HIGH_40MHZ_LOW),
 	CHAN5G(5785, 157, PHY_QUADRUPLE_CHANNEL_20MHZ_LOW_40MHZ_HIGH),
diff --git a/drivers/net/wireless/ath/wcn36xx/smd.c b/drivers/net/wireless/ath/wcn36xx/smd.c
index be6442b3c80b..9785327593d2 100644
--- a/drivers/net/wireless/ath/wcn36xx/smd.c
+++ b/drivers/net/wireless/ath/wcn36xx/smd.c
@@ -2396,6 +2396,7 @@ int wcn36xx_smd_feature_caps_exchange(struct wcn36xx *wcn)
 	set_feat_caps(msg_body.feat_caps, STA_POWERSAVE);
 	if (wcn->rf_id == RF_IRIS_WCN3680) {
 		set_feat_caps(msg_body.feat_caps, DOT11AC);
+		set_feat_caps(msg_body.feat_caps, WLAN_CH144);
 		set_feat_caps(msg_body.feat_caps, ANTENNA_DIVERSITY_SELECTION);
 	}
 
-- 
2.25.1

