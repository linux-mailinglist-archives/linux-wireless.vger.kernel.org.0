Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B23C256D25A
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Jul 2022 03:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229621AbiGKBJA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Jul 2022 21:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiGKBI6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Jul 2022 21:08:58 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FEB2B1FC
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:56 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id cp18-20020a17090afb9200b001ef79e8484aso4665363pjb.1
        for <linux-wireless@vger.kernel.org>; Sun, 10 Jul 2022 18:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uLwOARZB19JUF/kodrlpT2SqaqWPAUoPYWN2cKAx5dU=;
        b=HgmSAhfIBeD0V8EXaphiksXe0gYxbEDjpemNjjr+2AyFB3B+vY0pRPHSaa0HbzJY7a
         m5NjTUKPhh16mAdYXqgSdhHNX9Am0Q2wXHCXEIDKUIKr9T8O8p18lSAWjdCkxsM3d9Hg
         ASEidOyLs55ZTgIBSM3801nDeMrQv3bzKSl/V5e8t9eXS00XpSZDmGFTUucs9wvFhnU+
         rJjlVSwoEz/Q/xpgBeahUDIe3wjFWUyUtTBJhbatyRnSicZMTpEX4dbNzxEPwRlKYEJt
         GUSSnDv0x0oDgTJ2A5mnIbgYM3WpXWRDroMiQ1hAWb1GdybeQFB6kJ0ixGG27hZpJE+G
         Kedg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uLwOARZB19JUF/kodrlpT2SqaqWPAUoPYWN2cKAx5dU=;
        b=IH26Q/zV+phUiu8vO7l1vkXpglaAZ8yDJx8movUeO+ippgytViZ3xD7U7BTm/5JxP3
         jAaFhYlY67a4692CcUrb/8JyamtujBw7U5Wosq8AybK3H77pKODT92GZfna5wk+fgy3r
         Uhw+wjVixuwKzOsVHgcAWgAbmiyY+pmuE2JdUIW9V3dXa8LsQjN0p3lN41LX+OMvUffh
         YR46ZA5DKVYQ1OII5ipPXZH5djKfu+TmHoPFeLxrr54RGg0QbV7HBBZvaNmwXFEyKYV4
         kmVHeLnKC27+SRFhVvVZ+Pnz++xBsrOE7Ssqxt833OgUhxa5WM4Ve+Gzdd8vKoXk8UKW
         5m3g==
X-Gm-Message-State: AJIora81JgYB6HtObySyjUI4ZxxflBa+nDZgnAY7WVzK1mnoV7zh8e76
        Jj0xY8oaCnpnF/tTd4W1vgCyCOaKI1dVFKPm
X-Google-Smtp-Source: AGRyM1s4krA41x4IsRUZVSH9J9Fg6tM4qMv/vzXsqiRH57eCZrOu/7w4rR3dupleWRGb+YrvSCJOkw==
X-Received: by 2002:a17:903:22ca:b0:16c:4145:75a1 with SMTP id y10-20020a17090322ca00b0016c414575a1mr4612868plg.134.1657501735946;
        Sun, 10 Jul 2022 18:08:55 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij5-20020a170902ab4500b0015e8d4eb1dbsm3341330plb.37.2022.07.10.18.08.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 18:08:55 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        Bassem Dawood <bassem@morsemicro.com>
Subject: [PATCH 01/12] cfg80211: regulatory: extend regulatory support for S1G
Date:   Mon, 11 Jul 2022 01:08:05 +0000
Message-Id: <20220711010816.45927-2-kieran.frewen@morsemicro.com>
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

Extend the S1G regulatory information to support all regulatory
domains. An reg_s1g.h file is included containing structs with key
regulatory class information. These structs were required to ensure
the right combination of information was available to a series of
functions which support the mapping between frequencies, bandwidths,
and channels.

Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
Signed-off-by: Bassem Dawood <bassem@morsemicro.com>
---
 net/wireless/reg.c     |  50 ++++++--
 net/wireless/reg_s1g.h | 281 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/util.c    |  31 ++++-
 3 files changed, 349 insertions(+), 13 deletions(-)
 create mode 100644 net/wireless/reg_s1g.h

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c7383ede794f..d9ed6b619164 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -62,6 +62,7 @@
 #include "reg.h"
 #include "rdev-ops.h"
 #include "nl80211.h"
+#include "reg_s1g.h"
 
 /*
  * Grace period we give before making sure all current interfaces reside on
@@ -1737,26 +1738,44 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 		 * the largest bandwidth which cleanly divides the freq_range.
 		 */
 		int edge_offset;
-		int ch_bw = max_bandwidth_khz;
+		int ch_bw, freq_end, freq_start, class_idx;
+		unsigned int i;
+		const struct s1g_oper_class *oper = reg_s1g_get_oper_class(regd->alpha2);
+
+		for (i = 0; i < oper->class_count; i++) {
+			if (center_freq_khz >= oper->class[i].start_freq &&
+			    center_freq_khz <= oper->class[i].end_freq) {
+				class_idx = i;
+				break;
+			}
+		}
+
+		ch_bw = oper->class[class_idx].max_bw_khz;
+		freq_start = oper->class[class_idx].start_freq;
+		freq_end = oper->class[class_idx].end_freq;
 
 		while (ch_bw) {
-			edge_offset = (center_freq_khz - ch_bw / 2) -
-				      freq_range->start_freq_khz;
-			if (edge_offset % ch_bw == 0) {
-				switch (KHZ_TO_MHZ(ch_bw)) {
-				case 1:
+			if (oper->class[class_idx].align_to_end)
+				edge_offset = freq_end -
+					(center_freq_khz - (ch_bw) / 2);
+			else
+				edge_offset = (center_freq_khz - (ch_bw) / 2) -
+					freq_start;
+			if (edge_offset % (ch_bw) == 0) {
+				switch (ch_bw) {
+				case MHZ_TO_KHZ(1):
 					bw_flags |= IEEE80211_CHAN_1MHZ;
 					break;
-				case 2:
+				case MHZ_TO_KHZ(2):
 					bw_flags |= IEEE80211_CHAN_2MHZ;
 					break;
-				case 4:
+				case MHZ_TO_KHZ(4):
 					bw_flags |= IEEE80211_CHAN_4MHZ;
 					break;
-				case 8:
+				case MHZ_TO_KHZ(8):
 					bw_flags |= IEEE80211_CHAN_8MHZ;
 					break;
-				case 16:
+				case MHZ_TO_KHZ(16):
 					bw_flags |= IEEE80211_CHAN_16MHZ;
 					break;
 				default:
@@ -2555,9 +2574,16 @@ static void handle_channel_custom(struct wiphy *wiphy,
 	const struct ieee80211_reg_rule *reg_rule = NULL;
 	const struct ieee80211_power_rule *power_rule = NULL;
 	u32 bw, center_freq_khz;
+	bool is_s1g = chan->band == NL80211_BAND_S1GHZ;
 
-	center_freq_khz = ieee80211_channel_to_khz(chan);
-	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
+	if (is_s1g) {
+		bw = MHZ_TO_KHZ(16);
+		min_bw = MHZ_TO_KHZ(1);
+	} else {
+		bw = MHZ_TO_KHZ(20);
+	}
+
+	for (; bw >= min_bw; bw = bw / 2) {
 		reg_rule = freq_reg_info_regd(center_freq_khz, regd, bw);
 		if (!IS_ERR(reg_rule))
 			break;
diff --git a/net/wireless/reg_s1g.h b/net/wireless/reg_s1g.h
new file mode 100644
index 000000000000..69dd4e2cd4d3
--- /dev/null
+++ b/net/wireless/reg_s1g.h
@@ -0,0 +1,281 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __NET_WIRELESS_REG_S1G_H
+#define __NET_WIRELESS_REG_S1G_H
+
+#include "reg.h"
+
+/**
+ * Struct cca_class
+ *
+ * The specifics of a cca level classification used to validate bw/frequency
+ *	combinations in a regulatory domain
+ * @band_start: The channel starting frequency for that CCA classification
+ * @start_freq: The start of the valid frequency range for the CCA
+ *	classification
+ * @end_freq: The end of the valid frequency range for the CCA classification
+ * @max_bw_khz: The maximum valid bw for the CCA classification
+ * @align_to_end: True if the maximum valid BW for the range is aligned to the
+ *	end_freq
+ * @supported_chan: A list of supported channel indexes
+ * @n_supported_chan: A count of the supported channels for this CCA
+ *	classification
+ */
+struct s1g_cca_classification {
+	u32 band_start;
+	u32 start_freq;
+	u32 end_freq;
+	u32 max_bw_khz;
+	u8 align_to_end;
+	const u8 *supported_chan;
+	u8 n_supported_chan;
+};
+
+
+/**
+
+ * Struct s1g_oper_class
+ *
+ * An aggregated view of the operating classes for a single regulatory
+ * domain
+ * @cc: country code
+ * @class_count: The number of CCA level classifications that exist
+ *	within that country
+ * @class: The specifics of a CCA level classification within a regulatory
+ *	domain.
+ */
+struct s1g_oper_class {
+	char *cc;
+	int class_count;
+	struct s1g_cca_classification class[];
+};
+
+/* The following channel lists have been retrieved from
+ * IEEE Std 802.11-2020 Table E-5
+ */
+static const u8 us_supported_channels[] = {
+	1, 2, 3, 5, 6, 7, 8, 9, 10, 11, 12, 13,
+	14, 15, 16, 17, 18, 19, 20, 21, 22, 23,
+	24, 25, 26, 27, 28, 29, 30, 31, 32, 33,
+	34, 35, 37, 38, 39, 40, 41, 42, 43, 44,
+	45, 46, 47, 48, 49, 50, 51
+};
+
+static const u8 eu_supported_channels_863[] = {
+	1, 3, 5, 7, 9
+};
+
+static const u8 eu_supported_channels_901_4[] = {
+	33, 35
+};
+
+static const u8 jp_supported_channels[] = {
+	1, 3, 5, 7, 9, 11, 13, 15, 17, 19, 21
+};
+
+static const u8 kr_supported_channels[] = {
+	1, 2, 3, 5, 6, 7, 8, 9, 10, 11
+};
+
+static const u8 sg_supported_channels_863[] = {
+	7, 9, 10, 11
+};
+
+static const u8 sg_supported_channels_902[] = {
+	37, 38, 39, 40, 41, 42, 43, 45
+};
+
+static const u8 au_nz_supported_channels[] = {
+	27, 29, 30, 31, 32, 33, 34, 35, 37, 38, 39,
+	40, 41, 42, 43, 44, 45, 46, 47, 48, 49, 50,
+	51
+};
+
+
+/* The following s1g_oper_class structs are taken from
+ * IEEE Std 802.11-2020 Table E-5
+ */
+static const struct s1g_oper_class country_class_au = {
+	.cc = "AU",
+	.class_count = 2,
+	.class = {
+	{
+		.band_start = 902000,
+		.start_freq = 915000,
+		.end_freq = 920000,
+		.max_bw_khz = MHZ_TO_KHZ(4),
+		.align_to_end = 0,
+		.supported_chan = au_nz_supported_channels,
+		.n_supported_chan = sizeof(au_nz_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(8),
+		.align_to_end = 1,
+		.supported_chan = NULL,
+		.n_supported_chan = 0,
+	}
+	},
+};
+
+static const struct s1g_oper_class country_class_nz = {
+	.cc = "NZ",
+	.class_count = 2,
+	.class = {
+	{
+		.band_start = 902000,
+		.start_freq = 915000,
+		.end_freq = 924000,
+		.max_bw_khz = MHZ_TO_KHZ(8),
+		.align_to_end = 0,
+		.supported_chan = au_nz_supported_channels,
+		.n_supported_chan = sizeof(au_nz_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 924000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(8),
+		.align_to_end = 0,
+		.supported_chan = NULL,
+		.n_supported_chan = 0,
+	}
+	},
+};
+
+static const struct s1g_oper_class country_class_us = {
+	.cc = "US",
+	.class_count = 3,
+	.class = {
+	{
+		.band_start = 902000,
+		.start_freq = 902000,
+		.end_freq = 904000,
+		.max_bw_khz = MHZ_TO_KHZ(16),
+		.align_to_end = 0,
+		.supported_chan = us_supported_channels,
+		.n_supported_chan = sizeof(us_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(16),
+		.align_to_end = 0,
+		.supported_chan = NULL,
+		.n_supported_chan = 0,
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 904000,
+		.end_freq = 920000,
+		.max_bw_khz = MHZ_TO_KHZ(16),
+		.align_to_end = 0,
+		.supported_chan = NULL,
+		.n_supported_chan = 0,
+	}
+	},
+};
+
+static const struct s1g_oper_class country_class_sg = {
+	.cc = "SG",
+	.class_count = 2,
+	.class = {
+	{
+		.band_start = 863000,
+		.start_freq = 866000,
+		.end_freq = 869000,
+		.max_bw_khz = MHZ_TO_KHZ(2),
+		.align_to_end = 1,
+		.supported_chan = sg_supported_channels_863,
+		.n_supported_chan = sizeof(sg_supported_channels_863),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 925000,
+		.max_bw_khz = MHZ_TO_KHZ(4),
+		.align_to_end = 0,
+		.supported_chan = sg_supported_channels_902,
+		.n_supported_chan = sizeof(sg_supported_channels_902),
+	},
+	},
+};
+
+static const struct s1g_oper_class country_class_kr = {
+	.cc = "KR",
+	.class_count = 1,
+	.class = {
+	{
+		.band_start = 917500,
+		.start_freq = 917500,
+		.end_freq = 923500,
+		.max_bw_khz = MHZ_TO_KHZ(4),
+		.align_to_end = 1,
+		.supported_chan = kr_supported_channels,
+		.n_supported_chan = sizeof(kr_supported_channels),
+	}
+	},
+};
+
+static const struct s1g_oper_class country_class_eu = {
+	.cc = "EU",
+	.class_count = 1,
+	.class = {
+	{
+		.band_start = 863000,
+		.start_freq = 863000,
+		.end_freq = 868000,
+		.max_bw_khz = MHZ_TO_KHZ(1),
+		.align_to_end = 0,
+		.supported_chan = eu_supported_channels_863,
+		.n_supported_chan = sizeof(eu_supported_channels_863),
+	},
+	{
+		.band_start = 901400,
+		.start_freq = 917400,
+		.end_freq = 919400,
+		.max_bw_khz = MHZ_TO_KHZ(1),
+		.align_to_end = 0,
+		.supported_chan = eu_supported_channels_901_4,
+		.n_supported_chan = sizeof(eu_supported_channels_901_4),
+	}
+	},
+};
+
+static const struct s1g_oper_class country_class_jp = {
+	.cc = "JP",
+	.class_count = 1,
+	.class = {
+	{
+		.band_start = 916500,
+		.start_freq = 916500,
+		.end_freq = 927500,
+		.max_bw_khz = MHZ_TO_KHZ(1),
+		.supported_chan = jp_supported_channels,
+		.n_supported_chan = sizeof(jp_supported_channels),
+	}
+	},
+};
+
+static const struct s1g_oper_class *reg_s1g_get_oper_class(const char *cc)
+{
+	if (!strcmp(cc, "EU"))
+		return &country_class_eu;
+	if (!strcmp(cc, "SG"))
+		return &country_class_sg;
+	if (!strcmp(cc, "US"))
+		return &country_class_us;
+	if (!strcmp(cc, "AU"))
+		return &country_class_au;
+	if (!strcmp(cc, "KR"))
+		return &country_class_kr;
+	if (!strcmp(cc, "JP"))
+		return &country_class_jp;
+	if (!strcmp(cc, "NZ"))
+		return &country_class_nz;
+	return &country_class_us;
+}
+
+#endif /*__NET_WIRELESS_REG_S1G_H */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index b7257862e0fe..412403d29c22 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -22,6 +22,7 @@
 #include <linux/nospec.h>
 #include "core.h"
 #include "rdev-ops.h"
+#include "reg_s1g.h"
 
 
 const struct ieee80211_rate *
@@ -72,6 +73,23 @@ u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
 }
 EXPORT_SYMBOL(ieee80211_mandatory_rates);
 
+static u32 ieee80211_s1g_base_freq(int chan)
+{
+	const struct ieee80211_regdomain *regd  = rtnl_dereference(cfg80211_regdomain);
+	const struct s1g_oper_class *oper = reg_s1g_get_oper_class(regd->alpha2);
+	u8 i, j, index = 0;
+
+	if (oper->class_count > 1)
+		for (i = 0; i < oper->class_count; i++)
+			for (j = 0; j < oper->class[i].n_supported_chan; j++)
+				if (oper->class[i].supported_chan[j] == chan) {
+					index = i;
+					goto out;
+				}
+out:
+	return oper->class[index].band_start;
+}
+
 u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 {
 	/* see 802.11 17.3.8.3.2 and Annex J
@@ -104,7 +122,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 			return MHZ_TO_KHZ(56160 + chan * 2160);
 		break;
 	case NL80211_BAND_S1GHZ:
-		return 902000 + chan * 500;
+		return ieee80211_s1g_base_freq(chan) + chan * 500;
 	default:
 		;
 	}
@@ -112,6 +130,17 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 }
 EXPORT_SYMBOL(ieee80211_channel_to_freq_khz);
 
+u32 ieee80211_s1g_channel_to_freq_khz(int chan)
+{
+	u32 base = ieee80211_s1g_base_freq(chan);
+
+	if (!base)
+		return 0;
+
+	return (base + chan * 500);
+}
+EXPORT_SYMBOL(ieee80211_s1g_channel_to_freq_khz);
+
 enum nl80211_chan_width
 ieee80211_s1g_channel_width(const struct ieee80211_channel *chan)
 {
-- 
2.25.1

