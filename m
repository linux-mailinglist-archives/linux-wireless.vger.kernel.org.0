Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F44856D269
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229729AbiGKBJf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGKBJ3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:29 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE4B215FDB
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:26 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id j12so3187347plj.8
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aUn3EPCckrE531sAIYD4jpJJiQgREvuGMuNMzPatpEA=;
        b=GX4Fs/hE2viFSZq8F8iB0SQurYtOEPrPb2wCBUeHtULW5zDQB3QIsYr5CcCd3QFsmG
         tFz5HRveoObxle36esdkSjKMwEJZmGAceozZ0pzVbQqjxoElFKdR1DjlHPABOB8sBCSH
         POyQDLA73zyWtXws6V1hMLXX3HgUREyHVHGWzrnMIukA6V1NTMNBldftgVz4wf8gWpPw
         cKhAj1TCfFzFceMmisDSBsIcG3p8k/+vmQaeUGucMhLQZwGDIVxWUlvCZcYRpl0LMgH8
         SUYyYNZparjOFijoyGhmcsKywHlvZhp/LkFovIY7AYhr6ae65ZRHBfzG6okWpVbVn36L
         fUIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aUn3EPCckrE531sAIYD4jpJJiQgREvuGMuNMzPatpEA=;
        b=SfFdkz/CSVWYWRZAFE+ILSq08/LgUPKY/Vsax9EOvc9mUMORblMX621bNuEjyYmh7Z
         5AhI8f8T+VKNe/2Stm+Z+o0S06do/GzlPuN8qyI/vQI4OhBRDtVV0h3cbb6gHmzF2qtl
         qSmtUM77YjThCUcJVBTaJJ7gXC8X0WNifC0UR1UFS6YU0QttxVLWX0pEN7VRi3xqBjgW
         3RT4sMCLIB7j0Up7W3IhvUHjakU32S9mW+qw7MbfpaE/P8UjkqrVOPYOkrbJu5H52jAN
         3/tuCwDbkf+OYF+wAUt/wn4l4+BYt5Zptv0M1CpT0GuhL+ZRqCZx0pIuPOBNjMb2cLuI
         qDvA==
X-Gm-Message-State: AJIora972awswT+OoLYJyLGmIvJ6IglR3jB+O5Hc7v4ziMSQZHIPRgRl
        yC7Ty+u2tb9IUCGPkQUs68m7KA==
X-Google-Smtp-Source: AGRyM1skKLs/owtGg3sZfe7FNtbJaGt4s/GRRxOHDe76frkKvIyweolniowiEKyenrlDoBskGo5LxQ==
X-Received: by 2002:a17:902:ee42:b0:16b:e518:d894 with SMTP id 2-20020a170902ee4200b0016be518d894mr15983296plo.5.1657501766236;
        Sun, 10 Jul 2022 18:09:26 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:25 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 12/12] mac80211_hwsim: support for S1G rate information
Date:   Mon, 11 Jul 2022 01:08:16 +0000
Message-Id: <20220711010816.45927-13-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
References: <20220711010816.45927-1-kieran.frewen@morsemicro.com>
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
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 drivers/net/wireless/mac80211_hwsim.c | 38 ++++++++++++++++++++-------
 1 file changed, 29 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mac80211_hwsim.c b/drivers/net/wireless/mac80211_hwsim.c
index 304249038ac6..c4c0796a610d 100644
--- a/drivers/net/wireless/mac80211_hwsim.c
+++ b/drivers/net/wireless/mac80211_hwsim.c
@@ -1549,7 +1549,14 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
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
@@ -1560,14 +1567,27 @@ static bool mac80211_hwsim_tx_frame_no_nl(struct ieee80211_hw *hw,
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

