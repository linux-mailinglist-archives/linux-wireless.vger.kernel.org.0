Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6677076B8
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 02:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229687AbjERAHe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 20:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229642AbjERAHd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 20:07:33 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BC3A124
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 17:07:32 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-64359d9c531so1028050b3a.3
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 17:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1684368452; x=1686960452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X6l7nyOXh1JlrfSweCJOVvlJVVJo4PWzevLMFlFgi7c=;
        b=cZeU2A+XH+342KxmUrd0Gp3AUcxGJexr6U5yipfpWmNUGQ0SLbzcBdNKGfschLwplD
         94EdZK+ih9I2JrPBCYZ30RHA00JIa8FgTC9R/cSYPU1QlrdoS1tXHM+yWswgINQoCvbz
         QYMgjf5W8TjkWEVvjQK7mjWz+QnqTY+BofWcpxxfDZ/b/WuJDA7FvraRbHhFw1E6u1XB
         ssVbEhJZ86Tjsq01bXKqZ+gFi+OJPg6trSUXloNjlrLPk6JOacrHF6mHf7LsqOfSbcG2
         uayzaggvjv0x9AaERV9pwLg4XjcyrOLWe+H4lzPa62675MngT0lyb8XKHLWT4yMUyLsS
         qKIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684368452; x=1686960452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X6l7nyOXh1JlrfSweCJOVvlJVVJo4PWzevLMFlFgi7c=;
        b=CSxq3F94rDDyv5k+kBWfxBXMShEn2axWVnyS4jFDasLgiYeA/7PitI8fAFfmlDan03
         oGWksXQWP19i9Vw6E5tmu74MvsTyztdmj7Ncmm0HMTTLmyqfnXht6lhNjaz5TguyZ6EI
         XWNHNt/JMG3J1iXl8PlDcnJPDANREWV8Xn2Lmwcxak+j2qLHXQNIJv/XIECO74UG59Lk
         KU2tdi7i+hkl1PGugdUcvKnYPizArO3O9u8jXuVzHZ05F0nDiFtabi7xFRdIjfVw6NfT
         Z/RvHGbt4VgUq8+tiTpJHp6vmtVsbndbpcUR4spJc2oHk/4i+vxJ5nMVb2Ph0xNM/U2n
         Ykbg==
X-Gm-Message-State: AC+VfDyWgSG8ycRXzhfnDSNEIb96E6/8QMBoQUJQpcVhhVv8UvICVizg
        sIIDkOJ78VaAAlEFaaEPoIHeFw==
X-Google-Smtp-Source: ACHHUZ7QOLex5OolALvLBqLHwDsKoYU90LZTv2Jbz+uXxw7awFI0SD0dcuOQrDV7pjmafxEnV1LOUQ==
X-Received: by 2002:a05:6a00:1a11:b0:64c:c841:4e8a with SMTP id g17-20020a056a001a1100b0064cc8414e8amr1849814pfv.22.1684368451676;
        Wed, 17 May 2023 17:07:31 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id e17-20020aa78c51000000b00640defda6d2sm71222pfd.207.2023.05.17.17.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 May 2023 17:07:31 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>,
        kernel test robot <lkp@intel.com>,
        Dan Carpenter <error27@gmail.com>
Subject: [PATCH v3] cfg80211: S1G rate information and calculations
Date:   Thu, 18 May 2023 12:07:23 +1200
Message-Id: <20230518000723.991912-1-gilad.itzkovitch@morsemicro.com>
X-Mailer: git-send-email 2.25.1
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

Increase the size of S1G rate_info flags to support S1G and add
flags for new S1G MCS and the supported bandwidths. Also, include
S1G rate information to netlink STA rate message. Lastly, add
rate calculation function for S1G MCS.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Link: https://lore.kernel.org/r/202305110435.EhEiLYWA-lkp@intel.com/
Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
v3:
 - Add changelog to commit message
v2:
 - Add link to Dan Carpenter's reported issue
 - Fix for the issue above
 - Add missing S1G kernel-doc for MCS and the requested EHT
---
 include/net/cfg80211.h       |  18 +++++-
 include/uapi/linux/nl80211.h |  14 +++++
 net/wireless/nl80211.c       |  23 ++++++++
 net/wireless/util.c          | 110 +++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..14c4f92ed28e 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -1702,6 +1702,7 @@ int cfg80211_check_station_change(struct wiphy *wiphy,
  * @RATE_INFO_FLAGS_EDMG: 60GHz MCS in EDMG mode
  * @RATE_INFO_FLAGS_EXTENDED_SC_DMG: 60GHz extended SC MCS
  * @RATE_INFO_FLAGS_EHT_MCS: EHT MCS information
+ * @RATE_INFO_FLAGS_S1G_MCS: MCS field filled with S1G MCS
  */
 enum rate_info_flags {
 	RATE_INFO_FLAGS_MCS			= BIT(0),
@@ -1712,6 +1713,7 @@ enum rate_info_flags {
 	RATE_INFO_FLAGS_EDMG			= BIT(5),
 	RATE_INFO_FLAGS_EXTENDED_SC_DMG		= BIT(6),
 	RATE_INFO_FLAGS_EHT_MCS			= BIT(7),
+	RATE_INFO_FLAGS_S1G_MCS			= BIT(8),
 };
 
 /**
@@ -1728,6 +1730,11 @@ enum rate_info_flags {
  * @RATE_INFO_BW_HE_RU: bandwidth determined by HE RU allocation
  * @RATE_INFO_BW_320: 320 MHz bandwidth
  * @RATE_INFO_BW_EHT_RU: bandwidth determined by EHT RU allocation
+ * @RATE_INFO_BW_1: 1 MHz bandwidth
+ * @RATE_INFO_BW_2: 2 MHz bandwidth
+ * @RATE_INFO_BW_4: 4 MHz bandwidth
+ * @RATE_INFO_BW_8: 8 MHz bandwidth
+ * @RATE_INFO_BW_16: 16 MHz bandwidth
  */
 enum rate_info_bw {
 	RATE_INFO_BW_20 = 0,
@@ -1739,6 +1746,11 @@ enum rate_info_bw {
 	RATE_INFO_BW_HE_RU,
 	RATE_INFO_BW_320,
 	RATE_INFO_BW_EHT_RU,
+	RATE_INFO_BW_1,
+	RATE_INFO_BW_2,
+	RATE_INFO_BW_4,
+	RATE_INFO_BW_8,
+	RATE_INFO_BW_16,
 };
 
 /**
@@ -1747,8 +1759,8 @@ enum rate_info_bw {
  * Information about a receiving or transmitting bitrate
  *
  * @flags: bitflag of flags from &enum rate_info_flags
- * @mcs: mcs index if struct describes an HT/VHT/HE rate
  * @legacy: bitrate in 100kbit/s for 802.11abg
+ * @mcs: mcs index if struct describes an HT/VHT/HE/EHT/S1G rate
  * @nss: number of streams (VHT & HE only)
  * @bw: bandwidth (from &enum rate_info_bw)
  * @he_gi: HE guard interval (from &enum nl80211_he_gi)
@@ -1761,9 +1773,9 @@ enum rate_info_bw {
  *	only valid if bw is %RATE_INFO_BW_EHT_RU)
  */
 struct rate_info {
-	u8 flags;
-	u8 mcs;
+	u16 flags;
 	u16 legacy;
+	u8 mcs;
 	u8 nss;
 	u8 bw;
 	u8 he_gi;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c59fec406da5..435c4ac5d9bf 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -3667,6 +3667,13 @@ enum nl80211_eht_ru_alloc {
  *	(u8, see &enum nl80211_eht_gi)
  * @NL80211_RATE_INFO_EHT_RU_ALLOC: EHT RU allocation, if not present then
  *	non-OFDMA was used (u8, see &enum nl80211_eht_ru_alloc)
+ * @NL80211_RATE_INFO_S1G_MCS: S1G MCS index (u8, 0-10)
+ * @NL80211_RATE_INFO_S1G_NSS: S1G NSS value (u8, 1-4)
+ * @NL80211_RATE_INFO_1_MHZ_WIDTH: 1 MHz S1G rate
+ * @NL80211_RATE_INFO_2_MHZ_WIDTH: 2 MHz S1G rate
+ * @NL80211_RATE_INFO_4_MHZ_WIDTH: 4 MHz S1G rate
+ * @NL80211_RATE_INFO_8_MHZ_WIDTH: 8 MHz S1G rate
+ * @NL80211_RATE_INFO_16_MHZ_WIDTH: 16 MHz S1G rate
  * @__NL80211_RATE_INFO_AFTER_LAST: internal use
  */
 enum nl80211_rate_info {
@@ -3693,6 +3700,13 @@ enum nl80211_rate_info {
 	NL80211_RATE_INFO_EHT_NSS,
 	NL80211_RATE_INFO_EHT_GI,
 	NL80211_RATE_INFO_EHT_RU_ALLOC,
+	NL80211_RATE_INFO_S1G_MCS,
+	NL80211_RATE_INFO_S1G_NSS,
+	NL80211_RATE_INFO_1_MHZ_WIDTH,
+	NL80211_RATE_INFO_2_MHZ_WIDTH,
+	NL80211_RATE_INFO_4_MHZ_WIDTH,
+	NL80211_RATE_INFO_8_MHZ_WIDTH,
+	NL80211_RATE_INFO_16_MHZ_WIDTH,
 
 	/* keep last */
 	__NL80211_RATE_INFO_AFTER_LAST,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index d95f8053020d..8fb8c8905b48 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -6365,12 +6365,27 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		return false;
 
 	switch (info->bw) {
+	case RATE_INFO_BW_1:
+		rate_flg = NL80211_RATE_INFO_1_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_2:
+		rate_flg = NL80211_RATE_INFO_2_MHZ_WIDTH;
+		break;
+	case RATE_INFO_BW_4:
+		rate_flg = NL80211_RATE_INFO_4_MHZ_WIDTH;
+		break;
 	case RATE_INFO_BW_5:
 		rate_flg = NL80211_RATE_INFO_5_MHZ_WIDTH;
 		break;
+	case RATE_INFO_BW_8:
+		rate_flg = NL80211_RATE_INFO_8_MHZ_WIDTH;
+		break;
 	case RATE_INFO_BW_10:
 		rate_flg = NL80211_RATE_INFO_10_MHZ_WIDTH;
 		break;
+	case RATE_INFO_BW_16:
+		rate_flg = NL80211_RATE_INFO_16_MHZ_WIDTH;
+		break;
 	default:
 		WARN_ON(1);
 		fallthrough;
@@ -6429,6 +6444,14 @@ bool nl80211_put_sta_rate(struct sk_buff *msg, struct rate_info *info, int attr)
 		    nla_put_u8(msg, NL80211_RATE_INFO_HE_RU_ALLOC,
 			       info->he_ru_alloc))
 			return false;
+	} else if (info->flags & RATE_INFO_FLAGS_S1G_MCS) {
+		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_MCS, info->mcs))
+			return false;
+		if (nla_put_u8(msg, NL80211_RATE_INFO_S1G_NSS, info->nss))
+			return false;
+		if (info->flags & RATE_INFO_FLAGS_SHORT_GI &&
+		    nla_put_flag(msg, NL80211_RATE_INFO_SHORT_GI))
+			return false;
 	} else if (info->flags & RATE_INFO_FLAGS_EHT_MCS) {
 		if (nla_put_u8(msg, NL80211_RATE_INFO_EHT_MCS, info->mcs))
 			return false;
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 3bc0c3072e78..610a867c14f7 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -1646,6 +1646,114 @@ static u32 cfg80211_calculate_bitrate_eht(struct rate_info *rate)
 	return result / 10000;
 }
 
+static u32 cfg80211_calculate_bitrate_s1g(struct rate_info *rate)
+{
+	/* For 1, 2, 4, 8 and 16 MHz channels */
+	static const u32 base[5][11] = {
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
+	if (rate->mcs >= 11)
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
+	WARN_ONCE(1, "invalid rate bw=%d, mcs=%d, nss=%d\n",
+		  rate->bw, rate->mcs, rate->nss);
+	return 0;
+}
+
 u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 {
 	if (rate->flags & RATE_INFO_FLAGS_MCS)
@@ -1662,6 +1770,8 @@ u32 cfg80211_calculate_bitrate(struct rate_info *rate)
 		return cfg80211_calculate_bitrate_he(rate);
 	if (rate->flags & RATE_INFO_FLAGS_EHT_MCS)
 		return cfg80211_calculate_bitrate_eht(rate);
+	if (rate->flags & RATE_INFO_FLAGS_S1G_MCS)
+		return cfg80211_calculate_bitrate_s1g(rate);
 
 	return rate->legacy;
 }

base-commit: f3dc7bb037d813ab7da84f488dd485f0fce66347
-- 
2.34.1

