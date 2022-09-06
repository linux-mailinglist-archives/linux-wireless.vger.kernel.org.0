Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A385ADE9B
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbiIFEtY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:49:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229818AbiIFEtV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:49:21 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8365C66A43
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:49:14 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id a5-20020a17090aa50500b002008eeb040eso1442993pjq.1
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=U4+WSp5Hf5M3UD/mtG12IEyiqRiUL1EUylH+ou79N/4=;
        b=FiN+ViXQE4l3iprSeA0fOa3Ns1mqzczlYcI0LPffda/PEuPyw4eGR87p7EawCl+LpE
         +XKSogS4p7+Tn6vxr/tL6edsrjPMyz/0KYiWzynh2F/NYWqoXEoE4Fg+HL2dcubpXNyl
         7qxQSv5zRIrLxdMi6V3shkv4n5dfN9HMuqIu/FH14ZFuiQujoxRdVI0LfTNZlvxOlxat
         UeJ1ATNDWloSAfjLXJ2vTmOrYSO/htOe6gPVKeT98RMGpO+5uSTGYKYNtx+PeU9/sPfJ
         KGWxOlyTuv5mT3y95CM6UP8fR4QUtISvIxDDs2Y1wb4dF80qrurF156k7ipaN1PzBb+8
         WACw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=U4+WSp5Hf5M3UD/mtG12IEyiqRiUL1EUylH+ou79N/4=;
        b=Ll1H75qPUNEBdYce81MhxFhF44CnyNh8aAdUZM/rjkSe1hqwvTuB5Y9CfLhNZW75t7
         ls0VzXWVXqko9jl4KUymmQn2krABqgBAGdT6e5mpXI0aTUFDC5ja6F8FdfosSvJiaPdY
         KSOyEybhPsQM1um8CD+UxPEZQDXaA7yk1DoydKIMqtP4WA4iDqjknsOzM2qaTknCV4Es
         rgJreDbRlszimwMoIzirGFQWCp4VeklcTF5cs4l9Em9vKTJGfqusfwi4vH9tfPj+JqTP
         QAAOhhq4U4sBxbR33D4MaTNHCdJuml9HT/HJUuGiGD59NRDNi41FcvLBlsYwZhElWioz
         KNFg==
X-Gm-Message-State: ACgBeo1gheADiW4PkLojsyUS3WmbHk5emb22mplEN9hU0LUrsP5Ku//I
        EM0GkPzntazRTxAeEDe0Q8seJA==
X-Google-Smtp-Source: AA6agR6QiGWkscjTVjjMw6X5+Lk0w7e9/M+ggh2n1xNthVqb+0RiOa+82c5Ch0w/5RABr5lWuZup4w==
X-Received: by 2002:a17:903:120a:b0:172:5a63:7442 with SMTP id l10-20020a170903120a00b001725a637442mr52735593plh.55.1662439754052;
        Mon, 05 Sep 2022 21:49:14 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.49.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:49:13 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v3 11/12] cfg80211: support for calculating S1G bitrates
Date:   Tue,  6 Sep 2022 16:48:11 +1200
Message-Id: <20220906044812.7609-12-kieran.frewen@morsemicro.com>
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

Support for reporting and calculating S1G MCS bitrates.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 net/wireless/util.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index aeccb6ce595c..d9d7dde3d4f2 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1384,6 +1384,117 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
 	return 0;
 }
 
+static u32 cfg80211_calculate_bitrate_s1g(struct rate_info *rate)
+{
+	/* For 1, 2, 4, 8 and 16 MHz channels */
+	static const u32 base[5][12] = {
+		{  300000,
+		   600000,
+		   900000,
+		  1200000,
+		  1800000,
+		  2400000,
+		  2700000,
+		  3000000,
+		  3600000,
+		  4000000,
+		  /* MCS 10 supported in 1 MHz only */
+		  150000,
+		},
+		{  650000,
+		  1300000,
+		  1950000,
+		  2600000,
+		  3900000,
+		  5200000,
+		  5850000,
+		  6500000,
+		  7800000,
+		  /* MCS 9 not valid */
+		},
+		{  1350000,
+		   2700000,
+		   4050000,
+		   5400000,
+		   8100000,
+		  10800000,
+		  12150000,
+		  13500000,
+		  16200000,
+		  18000000,
+		},
+		{  2925000,
+		   5850000,
+		   8775000,
+		  11700000,
+		  17550000,
+		  23400000,
+		  26325000,
+		  29250000,
+		  35100000,
+		  39000000,
+		},
+		{  8580000,
+		  11700000,
+		  17550000,
+		  23400000,
+		  35100000,
+		  46800000,
+		  52650000,
+		  58500000,
+		  70200000,
+		  78000000,
+		},
+	};
+	u32 bitrate;
+	/* default is 1 MHz index */
+	int idx = 0;
+
+	if (rate->mcs > 11)
+		goto warn;
+
+	switch (rate->bw) {
+	case RATE_INFO_BW_16:
+		idx = 4;
+		break;
+	case RATE_INFO_BW_8:
+		idx = 3;
+		break;
+	case RATE_INFO_BW_4:
+		idx = 2;
+		break;
+	case RATE_INFO_BW_2:
+		idx = 1;
+		break;
+	case RATE_INFO_BW_1:
+		idx = 0;
+		break;
+	case RATE_INFO_BW_5:
+	case RATE_INFO_BW_10:
+	case RATE_INFO_BW_20:
+	case RATE_INFO_BW_40:
+	case RATE_INFO_BW_80:
+	case RATE_INFO_BW_160:
+	default:
+		goto warn;
+	}
+
+	bitrate = base[idx][rate->mcs];
+	bitrate *= rate->nss;
+
+	if (rate->flags & RATE_INFO_FLAGS_SHORT_GI)
+		bitrate = (bitrate / 9) * 10;
+	/* do NOT round down here */
+	return (bitrate + 50000) / 100000;
+warn:
+	if (!rate->bw && !rate->mcs && !rate->nss)
+		pr_debug("%s: rx status was not received yet!", __func__);
+	else
+		WARN_ONCE(1, "invalid rate bw=%d, mcs=%d, nss=%d\n",
+			  rate->bw, rate->mcs, rate->nss);
+	return 0;
+}
+
 static u32 cfg80211_calculate_bitrate_he(struct rate_info *rate)
 {
 #define SCALE 6144
@@ -1612,6 +1723,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_he(rate);
 	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
 		return cfg80211_calculate_bitrate_eht(rate);
+	if (rate->flags & RATE_INFO_FLAGS_S1G_MCS)
+		return cfg80211_calculate_bitrate_s1g(rate);
 
 	return rate->legacy;
 }
-- 
2.34.1

