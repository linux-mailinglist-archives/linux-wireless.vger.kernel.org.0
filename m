Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F548256465
	for <lists+linux-wireless@lfdr.de>; Sat, 29 Aug 2020 05:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726954AbgH2Di1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 28 Aug 2020 23:38:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgH2DiK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 28 Aug 2020 23:38:10 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8B7C061234
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:09 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b18so872051wrs.7
        for <linux-wireless@vger.kernel.org>; Fri, 28 Aug 2020 20:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=rfxnSLFpws95ZzTiN2qtFlrCYz6/oakRsVyvq/HcoY4=;
        b=BTOXWD/U3EBW10PEULQgKuppUzxzpqwMLd1PFkYrGZxjdvFELVtGb6a095Ep6a3G0O
         6zY6dna0rwjkqN0qJs+yA1Qb3qTuhwztHV0FIR+Wg1R+JusLIbtZsdBESwvjt1aI6Ep5
         mdaEHRKUAbWNKihjqS/4omaemGaGzKHHDMuLDztE1+CN66qn0cJAkLujj+W7qv8zmtvF
         YLymhRAAIGnHoB6NC7hYym9FrUQlaYslPMrDoNfUojEqdJ7/PvrPKaiqBgWpMz8pmbMw
         cb7HgdSu2eygYcgKX/9B26oeSjODezaHp6OlAaHUVs8dN/kyVjUE6Ql0KmVs0GQ61wgO
         GKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rfxnSLFpws95ZzTiN2qtFlrCYz6/oakRsVyvq/HcoY4=;
        b=f4waw5m+QVUUZHP7I2oMLHZY2sHaewpFKbWxxkQiYDO7jXlBJ8wqTnDd6aHs2BEXjB
         GGxt/SLFu9x94TJm/Sif7BxZaa320F8bvjNp5bmfOzuxqqajCklFFHzF6yM3va4tr9Fk
         mzrLKiItT8E14mBP8A7ZJML+z2SPyE8PYXCNjUklxZIXdtchJvO5YRyaw7VNDY02Dz7x
         xWY/SXH+/4oFi+Ukgrd0A7QrsDVT2AHLaXXwRggu4fwRSU2HTxr+9JM/mQS1tZ7sbNiG
         mXDmZ4TFducSbpYmAPI895rzqKNShykhZ8BXxf2ApxJt0OcXhTV7GpoXqD78ULUiYGoQ
         XPQw==
X-Gm-Message-State: AOAM532bRHXYw4aggVOSSkKmrDRMbv3D0D7E+NN8Si96Z1axyDkJmNqs
        Oyvh4B+f7mAabG9T6yIAn6FjXQ==
X-Google-Smtp-Source: ABdhPJy0ApS1Um4sQFTjG9NUvWR4aGw+L+pPPYB0JF3fXvQCPSjrHZPLiR7nFNp7GCt+tUpB3aep4g==
X-Received: by 2002:adf:f507:: with SMTP id q7mr1708154wro.343.1598672288484;
        Fri, 28 Aug 2020 20:38:08 -0700 (PDT)
Received: from localhost.localdomain ([176.61.57.127])
        by smtp.gmail.com with ESMTPSA id v29sm1827545wrv.51.2020.08.28.20.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 20:38:08 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     kvalo@codeaurora.org, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org
Cc:     bryan.odonoghue@linaro.org, shawn.guo@linaro.org,
        loic.poulain@linaro.org
Subject: [PATCH v2 05/10] wcn36xx: Fix warning due to bad rate_idx
Date:   Sat, 29 Aug 2020 04:38:41 +0100
Message-Id: <20200829033846.2167619-6-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
References: <20200829033846.2167619-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Loic Poulain <loic.poulain@linaro.org>

The rate_idx is the index of the bitrate in the supported rate table.
However the 5Ghz band has a smaller legacy bitrate table than 2.4Ghz
since it does not have the DSSS bitrates (1, 2, 5.5, 11).

So in 5Ghz band the index should adjusted accrodingly (-4).

Signed-off-by: Loic Poulain <loic.poulain@linaro.org>
[bod: Made sure fix is only applied if the rate_idx > n_bitrates]
Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index 80e96c2296af..05a84f82584c 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -230,6 +230,7 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	const struct wcn36xx_rate *rate;
 	struct ieee80211_hdr *hdr;
 	struct wcn36xx_rx_bd *bd;
+	struct ieee80211_supported_band *sband;
 	u16 fc, sn;
 
 	/*
@@ -270,6 +271,14 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.enc_flags = rate->encoding_flags;
 		status.bw = rate->bw;
 		status.rate_idx = rate->mcs_or_legacy_index;
+		sband = wcn->hw->wiphy->bands[status.band];
+
+		if (status.band == NL80211_BAND_5GHZ &&
+		    status.encoding == RX_ENC_LEGACY &&
+		    status.rate_idx >= sband->n_bitrates) {
+			/* no dsss rates in 5Ghz rates table */
+			status.rate_idx -= 4;
+		}
 	} else {
 		status.encoding = 0;
 		status.bw = 0;
-- 
2.27.0

