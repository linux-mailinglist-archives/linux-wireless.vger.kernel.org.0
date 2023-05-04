Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EF66F6303
	for <lists+linux-wireless@lfdr.de>; Thu,  4 May 2023 04:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjEDCto (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 May 2023 22:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjEDCtn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 May 2023 22:49:43 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47CD6E73
        for <linux-wireless@vger.kernel.org>; Wed,  3 May 2023 19:49:41 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-63b62d2f729so24028b3a.1
        for <linux-wireless@vger.kernel.org>; Wed, 03 May 2023 19:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20221208.gappssmtp.com; s=20221208; t=1683168581; x=1685760581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gdBsapl1cekSBby7Qju/NnK/ibSlcRZlDinsSUvqyBA=;
        b=FPgO7DHZULCaZTeslIL9cbiWjt0LHb7cx48X5DXJGDgv9bDOw7j7rscP6dX+yYP2/f
         z7vp1MYLXsyzoB9NBvj4pmGiAmyVvWNBqN1/ss77wBdkiyo534ffZXD/GcW0e/9wVEx5
         GSgcVVidBgYuuJnf//dewqXMXStL0oqVGjooDWk52zh84iNhwjkc2uStTkjTtq02YysR
         E3yhxBE1iBLv/K2uNLx1XAw/MjJKwmRLWl5zGU1WY/TZxJdU+R4ll9EMcx6dS14d5WNH
         Nfw2psIERVlDTmC8U8qMwwoRiN1uV/mmRUik8fpzhutpjstPz4r2WMrLi6vAKNkMfXW7
         xKtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683168581; x=1685760581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gdBsapl1cekSBby7Qju/NnK/ibSlcRZlDinsSUvqyBA=;
        b=fn2wiN4WtGicAol4kuojwb6F28gEUh2mhhsTcK13AdiUrH8Ej+YTbXOV1IAf8mxk8I
         8xvBhquD4WGeKyazkLqycNn0l2+KDvaczjZ3p7PZX3UKpxUufpPKvR63ZEK+adJGlXPe
         hooGvCX4M/Myko7YDylDrqJtIrtDXPn6DT8LxVFDYeIGoZHQGB7rmZ2SnBSyi6s4/C4G
         nGdNfUp2qT0hHB09MKWmvWGE3ru+O9YLTu8Yn1KEU1EhVTx3rLUCWCfNOZ7Vj1XKyjYu
         gSh9MMvBsIE7sy3wLX0ZMMTIBhzhmFadyK4KcTSXPnCDUYVGSMN2UCadjCIakqtLV9Hw
         vHdA==
X-Gm-Message-State: AC+VfDyXQyQ7YBEc+Q3X8zmF6ricIQb/SPOcd3nCsQ+T37bteIsDooz+
        04HywA1ap7Um20yPkmJ828ctOQ==
X-Google-Smtp-Source: ACHHUZ4zlSdqUUZGKRZAymIuB9qdzvDj3rycRjiib7NIlhj1/FEY9zkCa+BRy8YSRTNTSNvDWS+/TQ==
X-Received: by 2002:a05:6a00:178d:b0:637:3234:4e22 with SMTP id s13-20020a056a00178d00b0063732344e22mr896487pfg.23.1683168580690;
        Wed, 03 May 2023 19:49:40 -0700 (PDT)
Received: from virs-pc-014.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id p10-20020a056a000a0a00b0062d8e79ea22sm24049496pfh.40.2023.05.03.19.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 19:49:40 -0700 (PDT)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] cfg80211: S1G rate information and calculations
Date:   Thu,  4 May 2023 14:49:23 +1200
Message-Id: <20230504024923.1925530-1-gilad.itzkovitch@morsemicro.com>
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

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 include/net/cfg80211.h       |  18 +++++-
 include/uapi/linux/nl80211.h |  14 +++++
 net/wireless/nl80211.c       |  23 ++++++++
 net/wireless/util.c          | 110 +++++++++++++++++++++++++++++++++++
 4 files changed, 162 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9e04f69712b1..b7c26ccdb690 100644
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
+ * @mcs: mcs index if struct describes an HT/VHT/HE rate
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
index 3bc0c3072e78..9874a8469ef1 100644
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

base-commit: 28b17f6270f182e22cdad5a0fdc4979031e4486a
-- 
2.34.1

