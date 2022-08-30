Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8D05A594B
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbiH3CVQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229911AbiH3CVP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:15 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E74B77E013
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:13 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id w13so9382872pgq.7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=uyJmH5QODACX39loBetvnkaSvQzRkAD1ZxCe7Jwbavs=;
        b=jW0/pHHuEvWNUqTZFXj/6dp78kQJUVSdoW7b4MKyMttf1kLFVp3g7egiRdRPGYr8WX
         Gjyr9xZQg+z29KxDzwKRzw3/mnNik/o6jM71JWeGb7sjeuwOUf53KnEbhRqxIzPJPGM+
         TNV9TLgNL2Qax2lSwrBsRV1APhSqB/qQGpU5yNRIMLYJ7i/wYZ6v53+Cw4ecHt95BHvs
         fjVVVGFXIp29M9lh8UH41dzwxd0CNxNpNdkTYwqATF2Z3o7UjmlFgHxL9NUZyGV2r9w7
         AXXR0ccTnuxlo4aTS5Tz7gZQ2T2TVmA1VrJqujIrG70G7lkDs5fjLeYS2RZa1oC5D0vN
         zoJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=uyJmH5QODACX39loBetvnkaSvQzRkAD1ZxCe7Jwbavs=;
        b=dnmYtB/rmvbTb5+li0gNLJmxe8i/3ATEijC+68OQIbYXjqYgkKKpe8BNVA/Rf76ECh
         ouKAnrju3apOoKX6Z2Geu69E16OvqP/uRawxkqg6MEA8seIjNmyZlcf3xV9DMewxh6NP
         b/f89WUiD5rcbzs9B/urOkLcqo7+lzuE0vhCTCXhdZAptB8Vcym+pkolQgVlwqUurmaL
         vgpBpiNe3uRVfxUoCchK1c/+SmkGfDRyEihclSfSE/zuW2wPj3FP8Xv8W38qN1Iugprg
         F/by4Gixs5l7AUyhFjpP/bo1O7GoVSBvwwH1nyy+rwufqiT6mUAPV8292lg1Kj2X/9Bh
         P9eQ==
X-Gm-Message-State: ACgBeo0kE8KBa/ZHshIqcnWZnIYzzgzMHV0Vi/dj/VmfN/KKc1TvYRGE
        72B+oARnoZV9+s4yYrcfNNJKWw==
X-Google-Smtp-Source: AA6agR5boHVFZHfDxj0vD8doXQxq/+b4JwpL5uxK5PAkB6jBffvrQoElZBUh0F8loWcSawxGllnKeQ==
X-Received: by 2002:a05:6a00:1ac7:b0:537:4186:c106 with SMTP id f7-20020a056a001ac700b005374186c106mr19185403pfv.76.1661826072710;
        Mon, 29 Aug 2022 19:21:12 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:21:12 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 12/12] mac80211_hwsim: support for S1G rate information
Date:   Tue, 30 Aug 2022 02:20:17 +0000
Message-Id: <20220830022017.51017-13-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
References: <20220830022017.51017-1-kieran.frewen@morsemicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Include S1G rate information in S1G frames.

Signed-off-by: Kieran Frewen<kieran.frewen@morsemicro.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 38 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 5ecbc80be338..6742f308ef7a 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1577,7 +1577,14 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 	rx_status.freq = chan->center_freq;
 	rx_status.freq_offset = chan->freq_offset;
 	rx_status.band = chan->band;
-	if (info->control.rates[0].flags & IEEE80211_TX_RC_VHT_MCS) {
+	if (info->control.rates[0].flags & IEEE80211_TX_RC_S1G_MCS &&
+	    rx_status.band == NL80211_BAND_S1GHZ) {
+		rx_status.rate_idx =
+			ieee80211_rate_get_s1g_mcs(&info->control.rates[0]);
+		rx_status.nss =
+			ieee80211_rate_get_s1g_nss(&info->control.rates[0]);
+		rx_status.encoding = RX_ENC_S1G;
+	} else if (info->control.rates[0].flags & IEEE80211_TX_RC_VHT_MCS) {
 		rx_status.rate_idx =
 			ieee80211_rate_get_vht_mcs(&info->control.rates[0]);
 		rx_status.nss =
@@ -1588,14 +1595,27 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
 		if (info->control.rates[0].flags & IEEE80211_TX_RC_MCS)
 			rx_status.encoding = RX_ENC_HT;
 	}
-	if (info->control.rates[0].flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
-		rx_status.bw = RATE_INFO_BW_40;
-	else if (info->control.rates[0].flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
-		rx_status.bw = RATE_INFO_BW_80;
-	else if (info->control.rates[0].flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
-		rx_status.bw = RATE_INFO_BW_160;
-	else
-		rx_status.bw = RATE_INFO_BW_20;
+	if (rx_status.band == NL80211_BAND_S1GHZ) {
+		if (info->control.rates[0].flags & IEEE80211_TX_RC_2_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_2;
+		else if (info->control.rates[0].flags & IEEE80211_TX_RC_4_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_4;
+		else if (info->control.rates[0].flags & IEEE80211_TX_RC_8_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_8;
+		else if (info->control.rates[0].flags & IEEE80211_TX_RC_16_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_16;
+		else
+			rx_status.bw = RATE_INFO_BW_1;
+	} else {
+		if (info->control.rates[0].flags & IEEE80211_TX_RC_40_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_40;
+		else if (info->control.rates[0].flags & IEEE80211_TX_RC_80_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_80;
+		else if (info->control.rates[0].flags & IEEE80211_TX_RC_160_MHZ_WIDTH)
+			rx_status.bw = RATE_INFO_BW_160;
+		else
+			rx_status.bw = RATE_INFO_BW_20;
+	}
 	if (info->control.rates[0].flags & IEEE80211_TX_RC_SHORT_GI)
 		rx_status.enc_flags |= RX_ENC_FLAG_SHORT_GI;
 	/* TODO: simulate optional packet loss */
-- 
2.25.1

