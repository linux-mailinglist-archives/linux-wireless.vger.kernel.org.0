Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87B831518F6
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2020 11:40:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbgBDKkr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 4 Feb 2020 05:40:47 -0500
Received: from nbd.name ([46.4.11.11]:52318 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726552AbgBDKkq (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 4 Feb 2020 05:40:46 -0500
Received: from [149.224.158.146] (helo=bertha.lan)
        by ds12 with esmtpa (Exim 4.89)
        (envelope-from <john@phrozen.org>)
        id 1iyvdL-0000eg-Dc; Tue, 04 Feb 2020 11:40:43 +0100
From:   John Crispin <john@phrozen.org>
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>,
        John Crispin <john@phrozen.org>
Subject: [PATCH] iw: add HE rate/gi/ltf support
Date:   Tue,  4 Feb 2020 11:40:36 +0100
Message-Id: <20200204104036.19576-1-john@phrozen.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds support for setting fied HE rates/gi/ltf

Signed-off-by: Miles Hu <milehu@codeaurora.org>
Tested-by: John Crispin <john@phrozen.org>
---
 bitrate.c | 178 +++++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 163 insertions(+), 15 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 4a026a4..256baf3 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -4,13 +4,22 @@
 #include "iw.h"
 
 
-static int parse_vht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
+static int parse_rate_chunk(const char *arg, __u8 *nss, __u16 *mcs, unsigned int mode)
 {
 	unsigned int count, i;
-	unsigned int inss, mcs_start, mcs_end, tab[10];
+	unsigned int inss, mcs_start, mcs_end, tab[12];
+	unsigned int max_mcs = 0, max_nss = 0;
 
 	*nss = 0; *mcs = 0;
 
+	if (mode == NL80211_TXRATE_HE) {
+		max_mcs = 11;
+		max_nss = NL80211_HE_NSS_MAX;
+	} else {
+		max_mcs = 9;
+		max_nss = NL80211_VHT_NSS_MAX;
+	}
+
 	if (strchr(arg, '-')) {
 		/* Format: NSS:MCS_START-MCS_END */
 		count = sscanf(arg, "%u:%u-%u", &inss, &mcs_start, &mcs_end);
@@ -18,13 +27,13 @@ static int parse_vht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
 		if (count != 3)
 			return 0;
 
-		if (inss < 1 || inss > NL80211_VHT_NSS_MAX)
+		if (inss < 1 || inss > max_nss)
 			return 0;
 
 		if (mcs_start > mcs_end)
 			return 0;
 
-		if (mcs_start > 9 || mcs_end > 9)
+		if (mcs_start > max_mcs || mcs_end > max_mcs)
 			return 0;
 
 		*nss = inss;
@@ -33,19 +42,26 @@ static int parse_vht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
 
 	} else {
 		/* Format: NSS:MCSx,MCSy,... */
-		count = sscanf(arg, "%u:%u,%u,%u,%u,%u,%u,%u,%u,%u,%u", &inss,
-			   &tab[0], &tab[1], &tab[2], &tab[3], &tab[4], &tab[5],
-			   &tab[6], &tab[7], &tab[8], &tab[9]);
+		if (mode == NL80211_TXRATE_HE) {
+			count = sscanf(arg, "%u:%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u",
+				       &inss, &tab[0], &tab[1], &tab[2], &tab[3],
+				       &tab[4], &tab[5], &tab[6], &tab[7], &tab[8],
+				       &tab[9], &tab[10], &tab[11]);
+		} else {
+			count = sscanf(arg, "%u:%u,%u,%u,%u,%u,%u,%u,%u,%u,%u", &inss,
+				       &tab[0], &tab[1], &tab[2], &tab[3], &tab[4],
+				       &tab[5], &tab[6], &tab[7], &tab[8], &tab[9]);
+		}
 
 		if (count < 2)
 			return 0;
 
-		if (inss < 1 || inss > NL80211_VHT_NSS_MAX)
+		if (inss < 1 || inss > max_nss)
 			return 0;
 
 		*nss = inss;
 		for (i = 0; i < count - 1; i++) {
-			if (tab[i] > 9)
+			if (tab[i] > max_mcs)
 				return 0;
 			*mcs |= 1 << tab[i];
 		}
@@ -54,6 +70,16 @@ static int parse_vht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
 	return 1;
 }
 
+static int parse_vht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
+{
+	return parse_rate_chunk(arg, nss, mcs, NL80211_TXRATE_VHT);
+}
+
+static int parse_he_chunk(const char *arg, __u8 *nss, __u16 *mcs)
+{
+	return parse_rate_chunk(arg, nss, mcs, NL80211_TXRATE_HE);
+}
+
 static int setup_vht(struct nl80211_txrate_vht *txrate_vht,
 		     int argc, char **argv)
 {
@@ -74,6 +100,45 @@ static int setup_vht(struct nl80211_txrate_vht *txrate_vht,
 	return 1;
 }
 
+static int setup_he(struct nl80211_txrate_he *txrate_he,
+		    int argc, char **argv)
+{
+	__u8 nss;
+	__u16 mcs;
+	int i;
+
+	memset(txrate_he, 0, sizeof(*txrate_he));
+
+	for (i = 0; i < argc; i++) {
+		if (!parse_he_chunk(argv[i], &nss, &mcs))
+			return 0;
+
+		nss--;
+		txrate_he->mcs[nss] |= mcs;
+	}
+
+	return 1;
+}
+
+#define HE_GI_STR_MAX	16
+#define HE_GI_08_STR "0.8"
+#define HE_GI_16_STR "1.6"
+#define HE_GI_32_STR "3.2"
+int parse_he_gi(char *he_gi)
+{
+	if (he_gi == NULL)
+		return 0;
+
+	if (!strncmp(he_gi, HE_GI_08_STR, sizeof(HE_GI_08_STR)))
+		return NL80211_RATE_INFO_HE_GI_0_8;
+	if (!strncmp(he_gi, HE_GI_16_STR, sizeof(HE_GI_16_STR)))
+		return NL80211_RATE_INFO_HE_GI_1_6;
+	if (!strncmp(he_gi, HE_GI_32_STR, sizeof(HE_GI_32_STR)))
+		return NL80211_RATE_INFO_HE_GI_3_2;
+
+	return -1;
+}
+
 #define VHT_ARGC_MAX	100
 
 static int handle_bitrates(struct nl80211_state *state,
@@ -90,24 +155,35 @@ static int handle_bitrates(struct nl80211_state *state,
 	int *n_legacy = NULL;
 	bool have_ht_mcs_24 = false, have_ht_mcs_5 = false;
 	bool have_vht_mcs_24 = false, have_vht_mcs_5 = false;
+	bool have_he_mcs_24 = false, have_he_mcs_5 = false;
 	uint8_t ht_mcs_24[77], ht_mcs_5[77];
 	int n_ht_mcs_24 = 0, n_ht_mcs_5 = 0;
 	struct nl80211_txrate_vht txrate_vht_24 = {};
 	struct nl80211_txrate_vht txrate_vht_5 = {};
+	struct nl80211_txrate_he txrate_he_24 = {};
+	struct nl80211_txrate_he txrate_he_5 = {};
 	uint8_t *mcs = NULL;
 	int *n_mcs = NULL;
 	char *vht_argv_5[VHT_ARGC_MAX] = {}; char *vht_argv_24[VHT_ARGC_MAX] = {};
-	char **vht_argv = NULL;
+	char *he_argv_5[VHT_ARGC_MAX] = {}; char *he_argv_24[VHT_ARGC_MAX] = {};
+	char **vht_argv = NULL, **he_argv = NULL;
 	int vht_argc_5 = 0; int vht_argc_24 = 0;
-	int *vht_argc = NULL;
+	int he_argc_5 = 0; int he_argc_24 = 0;
+	int *vht_argc = NULL, *he_argc = NULL;
 	int sgi_24 = 0, sgi_5 = 0, lgi_24 = 0, lgi_5 = 0;
+	int has_he_gi_24 = 0, has_he_gi_5 = 0, has_he_ltf_24 = 0, has_he_ltf_5 = 0;
+	int he_gi = 0, he_ltf = 0;
+	char *he_gi_argv = NULL;
 
 	enum {
 		S_NONE,
 		S_LEGACY,
 		S_HT,
 		S_VHT,
+		S_HE,
 		S_GI,
+		S_HE_GI,
+		S_HE_LTF,
 	} parser_state = S_NONE;
 
 	for (i = 0; i < argc; i++) {
@@ -158,6 +234,20 @@ static int handle_bitrates(struct nl80211_state *state,
 			vht_argv = vht_argv_5;
 			vht_argc = &vht_argc_5;
 			have_vht_mcs_5 = true;
+		} else if (strcmp(argv[i], "he-mcs-2.4") == 0) {
+			if (have_he_mcs_24)
+				return 1;
+			parser_state = S_HE;
+			he_argv = he_argv_24;
+			he_argc = &he_argc_24;
+			have_he_mcs_24 = true;
+		} else if (strcmp(argv[i], "he-mcs-5") == 0) {
+			if (have_he_mcs_5)
+				return 1;
+			parser_state = S_HE;
+			he_argv = he_argv_5;
+			he_argc = &he_argc_5;
+			have_he_mcs_5 = true;
 		} else if (strcmp(argv[i], "sgi-2.4") == 0) {
 			sgi_24 = 1;
 			parser_state = S_GI;
@@ -170,6 +260,18 @@ static int handle_bitrates(struct nl80211_state *state,
 		} else if (strcmp(argv[i], "lgi-5") == 0) {
 			lgi_5 = 1;
 			parser_state = S_GI;
+		} else if (strcmp(argv[i], "he-gi-2.4") == 0) {
+			has_he_gi_24 = 1;
+			parser_state = S_HE_GI;
+		} else if (strcmp(argv[i], "he-gi-5") == 0) {
+			has_he_gi_5 = 1;
+			parser_state = S_HE_GI;
+		} else if (strcmp(argv[i], "he-ltf-2.4") == 0) {
+			has_he_ltf_24 = 1;
+			parser_state = S_HE_LTF;
+		} else if (strcmp(argv[i], "he-ltf-5") == 0) {
+			has_he_ltf_5 = 1;
+			parser_state = S_HE_LTF;
 		} else switch (parser_state) {
 		case S_LEGACY:
 			tmpd = strtod(argv[i], &end);
@@ -192,8 +294,24 @@ static int handle_bitrates(struct nl80211_state *state,
 				return 1;
 			vht_argv[(*vht_argc)++] = argv[i];
 			break;
+		case S_HE:
+			if (*he_argc >= VHT_ARGC_MAX)
+				return 1;
+			he_argv[(*he_argc)++] = argv[i];
+			break;
 		case S_GI:
 			break;
+		case S_HE_GI:
+			he_gi_argv = argv[i];
+			break;
+		case S_HE_LTF:
+			he_ltf = strtol(argv[i], &end, 0);
+			if (*end != '\0')
+				return 1;
+			if (he_ltf < 0 || he_ltf > 4)
+				return 1;
+			he_ltf = he_ltf >> 1;
+			break;
 		default:
 			return 1;
 		}
@@ -207,17 +325,32 @@ static int handle_bitrates(struct nl80211_state *state,
 		if(!setup_vht(&txrate_vht_5, vht_argc_5, vht_argv_5))
 			return -EINVAL;
 
+	if (have_he_mcs_24)
+		if (!setup_he(&txrate_he_24, he_argc_24, he_argv_24))
+			return -EINVAL;
+
+	if (have_he_mcs_5)
+		if (!setup_he(&txrate_he_5, he_argc_5, he_argv_5))
+			return -EINVAL;
+
 	if (sgi_5 && lgi_5)
 		return 1;
 
 	if (sgi_24 && lgi_24)
 		return 1;
 
+	if (he_gi_argv) {
+		he_gi = parse_he_gi(he_gi_argv);
+		if (he_gi < 0)
+			return 1;
+	}
+
 	nl_rates = nla_nest_start(msg, NL80211_ATTR_TX_RATES);
 	if (!nl_rates)
 		goto nla_put_failure;
 
-	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || sgi_24 || lgi_24) {
+	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || have_he_mcs_24 ||
+	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_2GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -227,14 +360,22 @@ static int handle_bitrates(struct nl80211_state *state,
 			nla_put(msg, NL80211_TXRATE_HT, n_ht_mcs_24, ht_mcs_24);
 		if (have_vht_mcs_24)
 			nla_put(msg, NL80211_TXRATE_VHT, sizeof(txrate_vht_24), &txrate_vht_24);
+		if (have_he_mcs_24)
+			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_24),
+				&txrate_he_24);
 		if (sgi_24)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_SGI);
 		if (lgi_24)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_LGI);
+		if (has_he_gi_24)
+			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
+		if (has_he_ltf_24)
+			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
 		nla_nest_end(msg, nl_band);
 	}
 
-	if (have_legacy_5 || have_ht_mcs_5 || have_vht_mcs_5 || sgi_5 || lgi_5) {
+	if (have_legacy_5 || have_ht_mcs_5 || have_vht_mcs_5 || have_he_mcs_5 ||
+	    sgi_5 || lgi_5 || has_he_gi_5 || has_he_ltf_5) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_5GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -244,10 +385,17 @@ static int handle_bitrates(struct nl80211_state *state,
 			nla_put(msg, NL80211_TXRATE_HT, n_ht_mcs_5, ht_mcs_5);
 		if (have_vht_mcs_5)
 			nla_put(msg, NL80211_TXRATE_VHT, sizeof(txrate_vht_5), &txrate_vht_5);
+		if (have_he_mcs_5)
+			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_5),
+				&txrate_he_5);
 		if (sgi_5)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_SGI);
 		if (lgi_5)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_LGI);
+		if (has_he_gi_5)
+			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
+		if (has_he_ltf_5)
+			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
 		nla_nest_end(msg, nl_band);
 	}
 
@@ -259,9 +407,9 @@ static int handle_bitrates(struct nl80211_state *state,
 }
 
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
-#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
+#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
 
-COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]",
+COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-2.4:0.8/1.6/3.2] [he-gi-5:0.8/1.6/3.2] [he-ltf-2.4:1/2/4] [he-ltf-5:1/2/4]",
 	NL80211_CMD_SET_TX_BITRATE_MASK, 0, CIB_NETDEV, handle_bitrates,
 	"Sets up the specified rate masks.\n"
 	"Not passing any arguments would clear the existing mask (if any).");
-- 
2.20.1

