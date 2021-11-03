Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7417E44450C
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Nov 2021 16:56:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232566AbhKCP6t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Nov 2021 11:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232509AbhKCP6o (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Nov 2021 11:58:44 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AE6C061208
        for <linux-wireless@vger.kernel.org>; Wed,  3 Nov 2021 08:56:07 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x64so2785335pfd.6
        for <linux-wireless@vger.kernel.org>; Wed, 03 Nov 2021 08:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=squareup.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fRKGePYlOmiVuBckenaZg2lvZOcrPTPvFy6IKWhuraA=;
        b=YLEp/Xoz4W2xV+OI2S15NnYwPElTYeS0SpIQ8yv97vYxKejLqOInKtY/oAP/4+D8If
         YqCq0B7Gm73oeuYX2C0270HXK+PLZp3RO2ZzViWeul/g1R166dSvbJlwbpuzaU+4oEVj
         K/W6oadXhKmmyRx6f+L4tXrDa22NUqfA9mBAo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fRKGePYlOmiVuBckenaZg2lvZOcrPTPvFy6IKWhuraA=;
        b=zdKvT8vBmyooOBkzxvgy41N9URKYkn+2mamjifV3I7wTH+IMsletEMucpK5/swtPZU
         VR+irjRdvLqDJg+sYLrv8Sptp0gxjqQ1ZpDnM4s+ywzslgdUrX6mq9rwT9k/F/KSTjzJ
         Q3ZGmSXT1/d9vVbPtajnDQtAq2HGgeGDgnYsZ4k2xbbKx9aUEtsiOdoEbhb+kfnjSJHU
         a2JC4dAPcGGmmXwnoIMKjkNGLFr5yOUcJMr5aua5YdXE/rKeSm66XTRC5hX6f3VyxrA5
         yDQiQQDNRedGGIs3LCZ9/grfdgmL9+ulN46QLD9BjwddAdDxtQUQOW2o3767FEC6Uva3
         x0jg==
X-Gm-Message-State: AOAM533Fhunv9c8CbTLPJFAGfdMAVvSrdE6qsXGyjbrcNZUTF4m4R5V9
        4ywyvkn19yWl4SmkntBchjX2Hw==
X-Google-Smtp-Source: ABdhPJzZXUKnwm5tW5gImvnc6h54z0C6R5vHG6hKRJ120aAOl/5rSmHIVJZ0BQ68n5YA2oGHIXJoSg==
X-Received: by 2002:a63:4d20:: with SMTP id a32mr33303288pgb.247.1635954967135;
        Wed, 03 Nov 2021 08:56:07 -0700 (PDT)
Received: from localhost ([2600:6c50:4d00:d401:aa7a:1484:c7d0:ae82])
        by smtp.gmail.com with ESMTPSA id h11sm3174517pfc.131.2021.11.03.08.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Nov 2021 08:56:06 -0700 (PDT)
From:   Benjamin Li <benl@squareup.com>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        linux-arm-msm@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, wcn36xx@lists.infradead.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] wcn36xx: fix RX BD rate mapping for 5GHz legacy rates
Date:   Wed,  3 Nov 2021 08:55:42 -0700
Message-Id: <20211103155543.1037604-3-benl@squareup.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211103155543.1037604-1-benl@squareup.com>
References: <20211103155543.1037604-1-benl@squareup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The linear mapping between the BD rate field and the driver's 5GHz
legacy rates table (wcn_5ghz_rates) does not only apply for the latter
four rates -- it applies to all eight rates.

Fixes: 6ea131acea98 ("wcn36xx: Fix warning due to bad rate_idx")
Signed-off-by: Benjamin Li <benl@squareup.com>
---
 drivers/net/wireless/ath/wcn36xx/txrx.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/wcn36xx/txrx.c b/drivers/net/wireless/ath/wcn36xx/txrx.c
index f0a9f069a92a9..fce3a6a98f596 100644
--- a/drivers/net/wireless/ath/wcn36xx/txrx.c
+++ b/drivers/net/wireless/ath/wcn36xx/txrx.c
@@ -272,7 +272,6 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 	const struct wcn36xx_rate *rate;
 	struct ieee80211_hdr *hdr;
 	struct wcn36xx_rx_bd *bd;
-	struct ieee80211_supported_band *sband;
 	u16 fc, sn;
 
 	/*
@@ -350,12 +349,10 @@ int wcn36xx_rx_skb(struct wcn36xx *wcn, struct sk_buff *skb)
 		status.enc_flags = rate->encoding_flags;
 		status.bw = rate->bw;
 		status.rate_idx = rate->mcs_or_legacy_index;
-		sband = wcn->hw->wiphy->bands[status.band];
 		status.nss = 1;
 
 		if (status.band == NL80211_BAND_5GHZ &&
-		    status.encoding == RX_ENC_LEGACY &&
-		    status.rate_idx >= sband->n_bitrates) {
+		    status.encoding == RX_ENC_LEGACY) {
 			/* no dsss rates in 5Ghz rates table */
 			status.rate_idx -= 4;
 		}
-- 
2.25.1

