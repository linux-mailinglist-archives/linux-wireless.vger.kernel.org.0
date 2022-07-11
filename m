Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5F2556D268
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbiGKBJd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiGKBJ1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:09:27 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10A165A4
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:24 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id g4so3520656pgc.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zu1KPhIskeJjpHwFJ5sq4T1Dv+v0bG6sgY/TYDuPtPs=;
        b=clHWvjexYNQIHmw6UUilkLNRXAxRxYU5vFs7uX3CPjo2xaJh6KyPgcDP+820SB4ZaO
         CY20XoSH9qnGusPUdsxTe7OMM8oDWQsH+4dUnAYT0XzDMJ1ZjTgUu+UU9S1f0UTlmC44
         deT28rv2vKtK8FTC7vqDan7WP+Symgm4Y9SRT4bVfdNcNLhxx3nU1/jKqcbwmFcVvjjA
         LaXyPYzfJAXJVhBcIzGx7LRY9WEzSnD9UjmxpCHRPMiVdLcH9iW5Ok1kYkYtF4A/1OL4
         dm4Yp5Y4w7fUNqFRm2MbCBmGSWqdmRLAYCHMWnD77ggN+QPPQwNwDvXLI+2BbPgukcCA
         Dcug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zu1KPhIskeJjpHwFJ5sq4T1Dv+v0bG6sgY/TYDuPtPs=;
        b=zbtw+vyjSIi9PE2oNe0ETeEwSQZMWJ/ZRTp80hiYacvEuN2wfHP9D/nScdtBhHU1Md
         bzmxIRHQDKjCWxwFheYqovL747ARAw0Ldqifk31itmL3QVjvSPsfBvc9JXfix/qN0sx0
         SlGVWwtRyFX46SGLVQdKmBA3FsMiNhz8ckI3Sfz7uBOjt9ioNa8czU0Js6ZDY4t0n+Ll
         Q4v6AuDDhUQ8oe4vwvQYbTYrIskag3DYwef/xy4M5cekB5ZCuoHc61wPw6ylxkHhXCOJ
         hj/z7oE57hQDAAUO4LKC3dJKXl9DWgOeDc6oLqdaJvhwviSswSshR5lLLuYS7ZcNCOoq
         kKzw==
X-Gm-Message-State: AJIora/u9xrViYQEItd8zuJ4NfqXpJ/vbuNVTC+Lia8NKWKFgO21OuD+
        U00Qb5S57CyAODMdg0vbSip+xg==
X-Google-Smtp-Source: AGRyM1uXnBM/5Xsub0QK2kCFkykhpuGTeZ8bibNn+Mr/GXTqbaFt6zOiKcsvS1eOGGMVZ+wctr9rCA==
X-Received: by 2002:a63:5663:0:b0:412:7e4f:e208 with SMTP id g35-20020a635663000000b004127e4fe208mr13982934pgm.619.1657501763544;
        Sun, 10 Jul 2022 18:09:23 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:09:23 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 11/12] cfg80211: support for calculating S1G bitrates
Date:   Mon, 11 Jul 2022 01:08:15 +0000
Message-Id: <20220711010816.45927-12-kieran.frewen@morsemicro.com>
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

Support for reporting and calculating S1G MCS bitrates.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/wireless/util.c | 113 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/net/wireless/util.c b/net/wireless/util.c
index 412403d29c22..1bc604ec66dc 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1380,6 +1380,117 @@ static u32 cfg80211_calculate_bitrate_vht(struct rate_info *rate)
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
@@ -1608,6 +1719,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_he(rate);
 	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
 		return cfg80211_calculate_bitrate_eht(rate);
+	if (rate->flags & RATE_INFO_FLAGS_S1G_MCS)
+		return cfg80211_calculate_bitrate_s1g(rate);
 
 	return rate->legacy;
 }
-- 
2.25.1

