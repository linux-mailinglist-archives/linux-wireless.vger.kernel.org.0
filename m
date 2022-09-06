Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 721FF5ADEA2
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Sep 2022 06:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232318AbiIFEsz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 6 Sep 2022 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231836AbiIFEsx (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 6 Sep 2022 00:48:53 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18A3B5FAD2
        for <linux-wireless@vger.kernel.org>; Mon,  5 Sep 2022 21:48:47 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id b144so5428097pfb.7
        for <linux-wireless@vger.kernel.org>; Mon, 05 Sep 2022 21:48:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=R4zEEzriyM2dk3bgEA5bMN8hoDe1qItJp2RwfiL+VrQ=;
        b=nMWPuI7nddWxuGQDuaKgrNNVgG2AKRT4nfspclQMmClH5Cg8AjQoDSEcaE0VHVcEEz
         kk+719msswQ0tCH7QQYTvZs28w69/KswoO45p+bsJm+a5d0IScoa6nRVtO9Yl1KNZkGI
         w0MOLTnAeaxE8+LpGypoZoZHi0G1NKc5Dsq4YYLlFkCnPtcyrhtno0saYEV+sYC3iIco
         aXz4J5S1pbvSS2JAoWgIIGQFPMS6iTB4hzQ48g1HyW2cnackSVDXFbez6W4aUGEWeT4/
         uxmbvaQZMHBZS6q/IXEsjmbI89S4Ve5/ZsUAJGtNCD6Ue2u23cFYrLXpLSGoTGpnGvZR
         fN/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=R4zEEzriyM2dk3bgEA5bMN8hoDe1qItJp2RwfiL+VrQ=;
        b=YnSsQAOmG10XaMfBawNnRxJnYOgWMvdkOq7FNZ+WoZoXjttkztUhVRtpIKiyV4afGl
         2/s9J3Ggxbfq+pOIN9zRj7oSQpje0aE/JyrYbyuLShe5vrgP5bCzWv5YCR2wlefhm4LK
         7QFoyVWLfke7X/nHBHnATDtOeFUGJIBFwU4Z9eFB4+T2pyAoSQ4ddmwjdIxJB6/n8QEk
         vEMdeW3HrIWDdWR4hO3mUVlGM8jqV/ETcQWiEhCjEd5M46+lreRsFB6EjYviWMo8yz+N
         py9KAxGD6NJAxrUIxWmAVC9qj1jJ0FvuVszhIO3vw0Dru0zRIEXIrJlHiRF4ovg5xpZD
         HXbA==
X-Gm-Message-State: ACgBeo35/SKFNPw5vaGMgiszEIHvfMY4EVcwc42XKdo77/IDzYoNvKMg
        Wfa2TVTMRbWR1xfz7Q8AC7yWng==
X-Google-Smtp-Source: AA6agR46cHUf56KkFJc2aSYbDU+9x7C9H01VMNXOkIpE+s9kAjEd8L+wcDFjntpngtCBWFhXoSPNZg==
X-Received: by 2002:a63:1257:0:b0:42f:fbe8:3ac0 with SMTP id 23-20020a631257000000b0042ffbe83ac0mr27721532pgs.412.1662439726525;
        Mon, 05 Sep 2022 21:48:46 -0700 (PDT)
Received: from virs-pc-021.intranet.virscient.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id ij28-20020a170902ab5c00b00176b66954a6sm2726822plb.121.2022.09.05.21.48.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Sep 2022 21:48:46 -0700 (PDT)
From:   Kieran Frewen <kieran.frewen@morsemicro.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, quic_jjohnson@quicinc.com,
        Kieran Frewen <kieran.frewen@morsemicro.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 01/12] cfg80211: regulatory: extend regulatory support for S1G
Date:   Tue,  6 Sep 2022 16:48:01 +1200
Message-Id: <20220906044812.7609-2-kieran.frewen@morsemicro.com>
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

Extend the S1G regulatory information to support all regulatory
domains. An reg_s1g.h file is included containing structs with key
regulatory class information. These structs were required to ensure
the right combination of information was available to a series of
functions which support the mapping between frequencies, bandwidths,
and channels.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Kieran Frewen <kieran.frewen@morsemicro.com>
---
 include/net/cfg80211.h |   8 ++
 net/wireless/Makefile  |   2 +-
 net/wireless/reg.c     |  60 +++++++++--
 net/wireless/reg_s1g.c | 231 +++++++++++++++++++++++++++++++++++++++++
 net/wireless/reg_s1g.h |  53 ++++++++++
 net/wireless/util.c    |  35 ++++++-
 6 files changed, 376 insertions(+), 13 deletions(-)
 create mode 100644 net/wireless/reg_s1g.c
 create mode 100644 net/wireless/reg_s1g.h

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 908d58393484..945e7700de66 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5909,6 +5909,14 @@ ieee80211_channel_to_khz(const struct ieee80211_channel *chan)
 	return MHZ_TO_KHZ(chan->center_freq) + chan->freq_offset;
 }
 
+/**
+ * ieee80211_s1g_channel_to_freq_khz - convert S1G channel index to
+ * frequency in khz
+ * @chan: int channel index to convert
+ * Return: The corresponding frequency (in KHz)
+ */
+u32 ieee80211_s1g_channel_to_freq_khz(int chan);
+
 /**
  * ieee80211_s1g_channel_width - get allowed channel width from @chan
  *
diff --git a/net/wireless/Makefile b/net/wireless/Makefile
index 527ae669f6f7..10cc0db5a935 100644
--- a/net/wireless/Makefile
+++ b/net/wireless/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_WEXT_PROC) += wext-proc.o
 obj-$(CONFIG_WEXT_SPY) += wext-spy.o
 obj-$(CONFIG_WEXT_PRIV) += wext-priv.o
 
-cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o scan.o nl80211.o
+cfg80211-y += core.o sysfs.o radiotap.o util.o reg.o reg_s1g.o scan.o nl80211.o
 cfg80211-y += mlme.o ibss.o sme.o chan.o ethtool.o mesh.o ap.o trace.o ocb.o
 cfg80211-y += pmsr.o
 cfg80211-$(CONFIG_OF) += of.o
diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index c7383ede794f..3377cea16c2b 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -62,6 +62,7 @@
 #include "reg.h"
 #include "rdev-ops.h"
 #include "nl80211.h"
+#include "reg_s1g.h"
 
 /*
  * Grace period we give before making sure all current interfaces reside on
@@ -1737,26 +1738,54 @@ static uint32_t reg_rule_to_chan_bw_flags(const struct ieee80211_regdomain *regd
 		 * the largest bandwidth which cleanly divides the freq_range.
 		 */
 		int edge_offset;
-		int ch_bw = max_bandwidth_khz;
+		int ch_bw, freq_end, freq_start, class_idx = -1;
+		unsigned int i;
+		const struct s1g_oper_class *oper = reg_s1g_get_oper_class(regd->alpha2);
+
+		if (!oper) {
+			bw_flags |= IEEE80211_CHAN_DISABLED;
+			return bw_flags;
+		}
+
+		for (i = 0; i < oper->class_count; i++) {
+			if (center_freq_khz >= oper->class[i].start_freq &&
+			    center_freq_khz <= oper->class[i].end_freq) {
+				class_idx = i;
+				break;
+			}
+		}
+
+		if (class_idx == -1) {
+			bw_flags |= IEEE80211_CHAN_DISABLED;
+			return bw_flags;
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
@@ -2555,9 +2584,18 @@ static void handle_channel_custom(struct wiphy *wiphy,
 	const struct ieee80211_reg_rule *reg_rule = NULL;
 	const struct ieee80211_power_rule *power_rule = NULL;
 	u32 bw, center_freq_khz;
+	bool is_s1g = chan->band == NL80211_BAND_S1GHZ;
 
 	center_freq_khz = ieee80211_channel_to_khz(chan);
-	for (bw = MHZ_TO_KHZ(20); bw >= min_bw; bw = bw / 2) {
+
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
diff --git a/net/wireless/reg_s1g.c b/net/wireless/reg_s1g.c
new file mode 100644
index 000000000000..6727d9986419
--- /dev/null
+++ b/net/wireless/reg_s1g.c
@@ -0,0 +1,231 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "reg_s1g.h"
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
+		.align_to_end = false,
+		.supported_chan = au_nz_supported_channels,
+		.n_supported_chan = sizeof(au_nz_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(8),
+		.align_to_end = true,
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
+		.align_to_end = false,
+		.supported_chan = au_nz_supported_channels,
+		.n_supported_chan = sizeof(au_nz_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 924000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(8),
+		.align_to_end = false,
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
+		.align_to_end = false,
+		.supported_chan = us_supported_channels,
+		.n_supported_chan = sizeof(us_supported_channels),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 928000,
+		.max_bw_khz = MHZ_TO_KHZ(16),
+		.align_to_end = false,
+		.supported_chan = NULL,
+		.n_supported_chan = 0,
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 904000,
+		.end_freq = 920000,
+		.max_bw_khz = MHZ_TO_KHZ(16),
+		.align_to_end = false,
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
+		.align_to_end = true,
+		.supported_chan = sg_supported_channels_863,
+		.n_supported_chan = sizeof(sg_supported_channels_863),
+	},
+	{
+		.band_start = 902000,
+		.start_freq = 920000,
+		.end_freq = 925000,
+		.max_bw_khz = MHZ_TO_KHZ(4),
+		.align_to_end = false,
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
+		.align_to_end = true,
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
+		.align_to_end = false,
+		.supported_chan = eu_supported_channels_863,
+		.n_supported_chan = sizeof(eu_supported_channels_863),
+	},
+	{
+		.band_start = 901400,
+		.start_freq = 917400,
+		.end_freq = 919400,
+		.max_bw_khz = MHZ_TO_KHZ(1),
+		.align_to_end = false,
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
+		.align_to_end = false,
+		.supported_chan = jp_supported_channels,
+		.n_supported_chan = sizeof(jp_supported_channels),
+	}
+	},
+};
+
+const struct s1g_oper_class *reg_s1g_get_oper_class(const char *cc)
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
+	return NULL;
+}
diff --git a/net/wireless/reg_s1g.h b/net/wireless/reg_s1g.h
new file mode 100644
index 000000000000..3165166054d2
--- /dev/null
+++ b/net/wireless/reg_s1g.h
@@ -0,0 +1,53 @@
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
+ * @band_start: The channel starting frequency (kHz) for that CCA classification
+ * @start_freq: The start of the valid frequency (kHz) range for the CCA
+ *	classification
+ * @end_freq: The end of the valid frequency (kHz) range for the CCA
+ *	classification
+ * @max_bw_khz: The maximum valid bandwidth for the CCA classification
+ * @align_to_end: True if the maximum valid bandwidth for the range is aligned
+ *	to the end_freq
+ * @supported_chan: A list of supported channel indexes
+ * @n_supported_chan: A count of the supported channels for this CCA
+ *	classification
+ */
+struct s1g_cca_classification {
+	u32 band_start;
+	u32 start_freq;
+	u32 end_freq;
+	u32 max_bw_khz;
+	bool align_to_end;
+	const u8 *supported_chan;
+	u8 n_supported_chan;
+};
+
+/**
+ * Struct s1g_oper_class
+ *
+ * An aggregated view of the operating classes for a single regulatory
+ * domain
+ * @cc: country code (2-character code)
+ * @class_count: The number of CCA level classifications that exist
+ *	within that country
+ * @class: The specifics of a CCA level classification within a regulatory
+ *	domain.
+ */
+struct s1g_oper_class {
+	char cc[3];
+	int class_count;
+	struct s1g_cca_classification class[];
+};
+
+const struct s1g_oper_class *reg_s1g_get_oper_class(const char *cc);
+
+#endif /*__NET_WIRELESS_REG_S1G_H */
diff --git a/net/wireless/util.c b/net/wireless/util.c
index 2c127951764a..aeccb6ce595c 100644
--- a/net/wireless/util.c
+++ b/net/wireless/util.c
@@ -22,6 +22,7 @@
 #include <linux/nospec.h>
 #include "core.h"
 #include "rdev-ops.h"
+#include "reg_s1g.h"
 
 
 const struct ieee80211_rate *
@@ -72,6 +73,27 @@ u32 ieee80211_mandatory_rates(struct ieee80211_supported_band *sband,
 }
 EXPORT_SYMBOL(ieee80211_mandatory_rates);
 
+static u32 ieee80211_s1g_base_freq(int chan)
+{
+	const struct ieee80211_regdomain *regd  = rtnl_dereference(cfg80211_regdomain);
+	const struct s1g_oper_class *oper = reg_s1g_get_oper_class(regd->alpha2);
+	u8 i, j, index = 0;
+
+	if (!oper)
+		return 0;
+
+	if (oper->class_count > 1)
+		for (i = 0; i < oper->class_count; i++)
+			for (j = 0; j < oper->class[i].n_supported_chan; j++)
+				if (oper->class[i].supported_chan[j] == chan) {
+					index = i;
+					goto out;
+				}
+	return 0; /* not supported */
+out:
+	return oper->class[index].band_start;
+}
+
 u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 {
 	/* see 802.11 17.3.8.3.2 and Annex J
@@ -104,7 +126,7 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
 			return MHZ_TO_KHZ(56160 + chan * 2160);
 		break;
 	case NL80211_BAND_S1GHZ:
-		return 902000 + chan * 500;
+		return ieee80211_s1g_base_freq(chan) + chan * 500;
 	default:
 		;
 	}
@@ -112,6 +134,17 @@ u32 ieee80211_channel_to_freq_khz(int chan, enum nl80211_band band)
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
2.34.1

