Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC61727DE3A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 04:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729729AbgI3CGO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 22:06:14 -0400
Received: from z5.mailgun.us ([104.130.96.5]:58512 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CGO (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 22:06:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601431573; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=ZCgHN6FQXNqI0hpKKoSS01FJe53IK3vDY8kPpBf71kE=; b=UKZRktoAC4oPwVqPIYu6KjpZ64XSj9+iRzvjY3MOeeA5KX2kJhjlpy6SlGXEzcsQAEsXMNEy
 HTDoAKsJLmFg4HFOTuzYYQHxaOy+iKkbLLr/rcZkLs2fDh5Nz7nz9Vl1d9HqQZlmp9f60GI3
 PsgQzpmVQt6Xvk+Oc6IcjlH0O8U=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 5f73e803cc21f6157a8db995 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 02:05:55
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6F881C433FE; Wed, 30 Sep 2020 02:05:54 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 5C23DC433C8;
        Wed, 30 Sep 2020 02:05:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 5C23DC433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org, Miles Hu <milehu@codeaurora.org>
Subject: [PATCH v2 1/2] iw: add HE rate/gi/ltf support
Date:   Tue, 29 Sep 2020 19:05:37 -0700
Message-Id: <1601431538-6621-1-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Miles Hu <milehu@codeaurora.org>

This patch adds support for setting fied HE rates/gi/ltf

Tested-by: John Crispin <john@phrozen.org>
Signed-off-by: Miles Hu <milehu@codeaurora.org>
---
v2: Rebased and fixed conflicts

 bitrate.c | 178 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 163 insertions(+), 15 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 32a23a938914..2cd55d15bfab 100644
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
 
 int set_bitrates(struct nl_msg *msg,
@@ -89,24 +154,35 @@ int set_bitrates(struct nl_msg *msg,
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
@@ -157,6 +233,20 @@ int set_bitrates(struct nl_msg *msg,
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
@@ -169,6 +259,18 @@ int set_bitrates(struct nl_msg *msg,
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
@@ -191,8 +293,24 @@ int set_bitrates(struct nl_msg *msg,
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
 			if (attr != NL80211_ATTR_TX_RATES)
 				goto next;
@@ -212,17 +330,32 @@ next:
 		if (!setup_vht(&txrate_vht_5, vht_argc_5, vht_argv_5))
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
 	nl_rates = nla_nest_start(msg, attr);
 	if (!nl_rates)
 		goto nla_put_failure;
 
-	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || sgi_24 || lgi_24) {
+	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || have_he_mcs_24 ||
+	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_2GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -232,14 +365,22 @@ next:
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
@@ -249,10 +390,17 @@ next:
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
 
@@ -272,9 +420,9 @@ static int handle_bitrates(struct nl80211_state *state,
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
2.7.4

