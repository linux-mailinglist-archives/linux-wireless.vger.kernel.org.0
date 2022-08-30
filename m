Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 664D15A594A
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Aug 2022 04:21:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiH3CVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 22:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbiH3CVK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 22:21:10 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 208A27E013
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:10 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id y141so9979858pfb.7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 19:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=btEicRQEW6kIhtWiOkgGVo9tjK3NPwQVFn5P37CngZI=;
        b=TE2kabvyEJn1DLuJRXY8kimA1PBnfBtd9+wKPDPhHqWpYvaKPdRRCI6mw8QwHsuphA
         Pf3WVnV2L/b6E0cBIGCwsU7n45B9n4pyKQaJrqWCGoziW/QMxNBVmq6aTmdO1bvxxgF5
         DZUiG2BIdXdhlONjq4sc+5l2PUulxk8ysrp3cvE2T89PkHrez1YUx2f3vEaIDzs4Fow9
         +RKp0diyfWxOZNCoSkeb8d8KJ2MhKQKLKCteJ93GaE9Rq9h7nad0gwAbvo6UNGJJGZPe
         P26aPv70O546Gjl9XlM37OMZ/K5E7JFT0xpOYekh2vLVNW09dBdxy0IJ7OpCmnBDeaDi
         xkdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=btEicRQEW6kIhtWiOkgGVo9tjK3NPwQVFn5P37CngZI=;
        b=TURF2ovZOZ3UBJfCDQfwb8f3gUvdJIoiIrSDMe43F3Cuq9IOYsPniVJkZlcPKzlx8j
         ARs2d4NWkrW3h34I1lv1q+1xN6zD5bEfsy6tixJnp/eqjJTKXVn7Q+W7UGGbn916+WRE
         5nrHZnx93HjiUUREO+jgoklEd1jSlY6BdRAlzIvs/qCq5n9YWSI9d0Wajm2ZJJLn5wU3
         5/mAUXtbyG8PNZdsbhbbp+LaYCgcck7fVkeg7lCkhvsxb8OJVs87tx6FdGEMps3m8klA
         6b0jTXkvsFS+HU6osE0bmW0Rg5WHvh/iw7iIOVPFT7BCWii1/f60nuXAI6yng8oCGNhb
         ZPvQ==
X-Gm-Message-State: ACgBeo2T3vkxcsKJm13SnIaVmvPgubBm9he+YgQo41v6klLMtpi+d2RC
        PBKorrwsGmU99qfrSiUBIzijug==
X-Google-Smtp-Source: AA6agR4+WWI9n4hW90cWtvstBoFmFSC24ynscpt9QPRj0m+Sy0gldo1tbrQjheveHicYQPAHvYucyA==
X-Received: by 2002:a63:225c:0:b0:42c:3811:93fb with SMTP id t28-20020a63225c000000b0042c381193fbmr5103498pgm.543.1661826069706;
        Mon, 29 Aug 2022 19:21:09 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id q12-20020a170902a3cc00b0016d8d277c02sm8220050plb.25.2022.08.29.19.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 19:21:09 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>
Subject: [PATCH v2 11/12] cfg80211: support for calculating S1G bitrates
Date:   Tue, 30 Aug 2022 02:20:16 +0000
Message-Id: <20220830022017.51017-12-kieran.frewen@morsemicro.com>
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
2.25.1

