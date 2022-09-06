Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F4E5ADE99
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231891AbiIFEt3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbiIFEt1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:27 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A53D6AA12
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:17 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id o4so10060204pjp.4
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=GNqXMxZS8O9iLZAjkr5TFaBGJEQ6fxE12NJY7BMykUk=;
        b=J4wGPnfEw5Muofoys49J6lrerVpDrMuJco6/lVYszSkROAOWrd4FBacyM1wN8IDOdp
         RVw/kh/So5nTRMFv73SvNPg7XN1jMnREI9/U2AtlkbviHYmJitz3lyek0WWYu3u2bJtq
         A5ifYixqaXjB3DBtUCBuWpYLjWsdEepwXIvrOsDgWA6GeNs/MZPp3z/7+3+lAAKfwSk+
         qzssBybSOB8aJqCWdzEGGnggO7Nb9DpDxlgQbVfJ6J2I4auzwS1b6QSAXLbr+WxIFh3j
         gTn4FEBzeOCrjaeHESuuDXXBXMybnHOMDK1QQOfHNhzpuvqFkGOm/NURxA8qqjfACx70
         PNOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=GNqXMxZS8O9iLZAjkr5TFaBGJEQ6fxE12NJY7BMykUk=;
        b=kkv4lU1rP581PYvBIjOMVPlJ23t4pWI+WziZrdo5WcB4iVgVdy8aO4JF+gh+Czo840
         QSynppRzBtPOtdu89oUoiv8AoDwzvSN+cPa6krsjrjofwqC9soQNiH/KxBqIcVg2MNXm
         /9tP+yW1NL5N2hudoiHATtMUjprj3oUIDQkJDpxRYeEpHqRlfRJXz36o3VBqAqQBsX6N
         xSyTnEAt3RMhTNyiuYKoz9NSF764ke8SgAuGykpaEcL8IaKy36WX91QPv6X51rRR4Pbr
         f7U4/4dZgMg5Q9+5Z/Ytbv/1FP4yLx04D94LTWprv8ItTT1aZxSOaeDpvyPUSJe120Ss
         zKBA==
X-Gm-Message-State: ACgBeo3zFnkAbEcTT2hNDs5T+dUqUDDs+JgoIGxX1+b6gS8T1YnDGggk
        IutEcKhLjMyaiDPqBO9xi9oE+A==
X-Google-Smtp-Source: AA6agR4QguUUyE1XV+qqRgxexgmqqMtkR21hzOuw8C5GNWLSFAbggLvDRhM3zcS41JGzbafYotgrVg==
X-Received: by 2002:a17:902:da8d:b0:175:4a53:9d0f with SMTP id j13-20020a170902da8d00b001754a539d0fmr28573163plx.13.1662439756744;
        Mon, 05 Sep 2022 21:49:16 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:49:16 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 12/12] mac80211_hwsim: support for S1G rate information
Date:   Tue,  6 Sep 2022 16:48:12 +1200
Message-Id: <20220906044812.7609-13-kieran.frewen@morsemicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
References: <20220906044812.7609-1-kieran.frewen@morsemicro.com>
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
2.34.1

