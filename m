Return-Path: <linux-wireless+bounces-27571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFA32B8F392
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 09:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 851B43B11CA
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Sep 2025 07:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 926532F1FC3;
	Mon, 22 Sep 2025 07:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pcEFAvSo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8612F0C50
	for <linux-wireless@vger.kernel.org>; Mon, 22 Sep 2025 07:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758525055; cv=none; b=fdjA6GndYxnDLTbpRUwDcogC7VSss833LQGeHFgwSt5qjhScPZxZqDzlaqpsYfW1Z5flwMvgewU+YGf1d3PyAlkRWxODZlAzuUOGVBccXMMOzJt3ylqaX4SgzJSCMHgpXUamA+XdHuJrGc1iPAAiHXc5Siskpt6FJYMlOFhPz2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758525055; c=relaxed/simple;
	bh=QQvmFhxNnbF3gfPPMN9cTjWoOlKlY++UTIm83UBGZco=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=T9e96690dsbS/BkyKabiyvdoX+KLyELDpVzFAlou61+p268JgtZTJniKPXBlZRjC21H7Yr7JSFzPPVuLlBmHWtEjKbM4k6vDQu3cFycP8zzF6XuEVEKpGSaw5Hywi3MOcVbho3uIK5/n1aRDRpAGK06fwDOEZJ0LztDtuwOSQUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pcEFAvSo; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58M7AcimE4015238, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758525038; bh=Vcf0fh3CrtlezXm9nMh4hT2brMSnAdbk1pXNoLXdgXA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pcEFAvSo6q9o8Um8XWqFVSqufV/bWbH/LVtGtpk3FnR5NNqWryPtMCbTozMzp4siA
	 MhOqX4cAoJ5Y0aYucOUlbHL2MOBY+Jlx3hh7e30Z6j5eeMOagYE0aXjdMA99m9hp/p
	 DILTVtP1fdo+V6C8eR4WkoBUzLRO4pA/o83GyChh2p+gYdHpKLddzQfVvQMIWMqPQ6
	 KoS2qViFNYZi3DGL4LRx4I7b+CVc7OUFlqLzjW2TCucMhrHnxnxnKOfME5iHNppMbD
	 1yH6T9Gq0KrGTKw0Bz+LXwAbdS4DjONPDL3LGDAtcfh9qgSdAScXh7YbWqkKXKGYDf
	 kpYkUT+mnfRoQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58M7AcimE4015238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 15:10:38 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 22 Sep 2025 15:10:38 +0800
Received: from kevin-ThinkPad-T430s.realtek.com.tw (172.21.69.104) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Sep 2025 15:10:38 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <raja.mani@oss.qualcomm.com>
Subject: [PATCH v3 3/4] iw: bitrate: support EHT rate/gi/ltf
Date: Mon, 22 Sep 2025 15:10:16 +0800
Message-ID: <20250922071017.11954-4-kevin_yang@realtek.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20250922071017.11954-1-kevin_yang@realtek.com>
References: <20250922071017.11954-1-kevin_yang@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS03.realtek.com.tw (172.21.6.96)
X-KSE-ServerInfo: RTEXMBS03.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Support eht-mcs-*/eht-gi-*/eht-ltf-* fields when iw set bitrates.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
---
 bitrate.c | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 176 insertions(+), 8 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 8c575b086eba..16f118cce4ec 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -7,7 +7,7 @@
 static int parse_rate_chunk(const char *arg, __u8 *nss, __u16 *mcs, unsigned int mode)
 {
 	unsigned int count, i;
-	unsigned int inss, mcs_start, mcs_end, tab[12];
+	unsigned int inss, mcs_start, mcs_end, tab[16];
 	unsigned int max_mcs = 0, max_nss = 0;
 
 	*nss = 0; *mcs = 0;
@@ -15,6 +15,9 @@ static int parse_rate_chunk(const char *arg, __u8 *nss, __u16 *mcs, unsigned int
 	if (mode == NL80211_TXRATE_HE) {
 		max_mcs = 11;
 		max_nss = NL80211_HE_NSS_MAX;
+	} else if (mode == NL80211_TXRATE_EHT) {
+		max_mcs = 15;
+		max_nss = NL80211_EHT_NSS_MAX;
 	} else {
 		max_mcs = 9;
 		max_nss = NL80211_VHT_NSS_MAX;
@@ -47,6 +50,12 @@ static int parse_rate_chunk(const char *arg, __u8 *nss, __u16 *mcs, unsigned int
 				       &inss, &tab[0], &tab[1], &tab[2], &tab[3],
 				       &tab[4], &tab[5], &tab[6], &tab[7], &tab[8],
 				       &tab[9], &tab[10], &tab[11]);
+		} else if (mode == NL80211_TXRATE_EHT) {
+			count = sscanf(arg, "%u:%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u,%u",
+				       &inss, &tab[0], &tab[1], &tab[2], &tab[3],
+				       &tab[4], &tab[5], &tab[6], &tab[7], &tab[8],
+				       &tab[9], &tab[10], &tab[11], &tab[12], &tab[13],
+				       &tab[14], &tab[15]);
 		} else {
 			count = sscanf(arg, "%u:%u,%u,%u,%u,%u,%u,%u,%u,%u,%u", &inss,
 				       &tab[0], &tab[1], &tab[2], &tab[3], &tab[4],
@@ -80,6 +89,11 @@ static int parse_he_chunk(const char *arg, __u8 *nss, __u16 *mcs)
 	return parse_rate_chunk(arg, nss, mcs, NL80211_TXRATE_HE);
 }
 
+static int parse_eht_chunk(const char *arg, __u8 *nss, __u16 *mcs)
+{
+	return parse_rate_chunk(arg, nss, mcs, NL80211_TXRATE_EHT);
+}
+
 static int setup_vht(struct nl80211_txrate_vht *txrate_vht,
 		     int argc, char **argv)
 {
@@ -120,6 +134,26 @@ static int setup_he(struct nl80211_txrate_he *txrate_he,
 	return 1;
 }
 
+static int setup_eht(struct nl80211_txrate_eht *txrate_eht,
+		     int argc, char **argv)
+{
+	__u8 nss;
+	__u16 mcs;
+	int i;
+
+	memset(txrate_eht, 0, sizeof(*txrate_eht));
+
+	for (i = 0; i < argc; i++) {
+		if (!parse_eht_chunk(argv[i], &nss, &mcs))
+			return 0;
+
+		nss--;
+		txrate_eht->mcs[nss] |= mcs;
+	}
+
+	return 1;
+}
+
 #define HE_GI_STR_MAX	16
 #define HE_GI_08_STR "0.8"
 #define HE_GI_16_STR "1.6"
@@ -139,6 +173,24 @@ static int parse_he_gi(char *he_gi)
 	return -1;
 }
 
+#define EHT_GI_08_STR "0.8"
+#define EHT_GI_16_STR "1.6"
+#define EHT_GI_32_STR "3.2"
+static int parse_eht_gi(char *eht_gi)
+{
+	if (eht_gi == NULL)
+		return 0;
+
+	if (!strncmp(eht_gi, EHT_GI_08_STR, sizeof(EHT_GI_08_STR)))
+		return NL80211_RATE_INFO_EHT_GI_0_8;
+	if (!strncmp(eht_gi, EHT_GI_16_STR, sizeof(EHT_GI_16_STR)))
+		return NL80211_RATE_INFO_EHT_GI_1_6;
+	if (!strncmp(eht_gi, EHT_GI_32_STR, sizeof(EHT_GI_32_STR)))
+		return NL80211_RATE_INFO_EHT_GI_3_2;
+
+	return -1;
+}
+
 #define VHT_ARGC_MAX	100
 
 int set_bitrates(struct nl_msg *msg,
@@ -156,6 +208,7 @@ int set_bitrates(struct nl_msg *msg,
 	bool have_vht_mcs_24 = false, have_vht_mcs_5 = false;
 	bool have_he_mcs_24 = false, have_he_mcs_5 = false;
 	bool have_he_mcs_6 = false;
+	bool have_eht_mcs_24 = false, have_eht_mcs_5 = false, have_eht_mcs_6 = false;
 	uint8_t ht_mcs_24[77], ht_mcs_5[77];
 	int n_ht_mcs_24 = 0, n_ht_mcs_5 = 0;
 	struct nl80211_txrate_vht txrate_vht_24 = {};
@@ -163,21 +216,32 @@ int set_bitrates(struct nl_msg *msg,
 	struct nl80211_txrate_he txrate_he_24 = {};
 	struct nl80211_txrate_he txrate_he_5 = {};
 	struct nl80211_txrate_he txrate_he_6 = {};
+	struct nl80211_txrate_eht txrate_eht_24 = {};
+	struct nl80211_txrate_eht txrate_eht_5 = {};
+	struct nl80211_txrate_eht txrate_eht_6 = {};
 	uint8_t *mcs = NULL;
 	int *n_mcs = NULL;
 	char *vht_argv_5[VHT_ARGC_MAX] = {}; char *vht_argv_24[VHT_ARGC_MAX] = {};
 	char *he_argv_5[VHT_ARGC_MAX] = {}; char *he_argv_24[VHT_ARGC_MAX] = {};
 	char *he_argv_6[VHT_ARGC_MAX] = {};
-	char **vht_argv = NULL, **he_argv = NULL;
+	char *eht_argv_24[VHT_ARGC_MAX] = {};
+	char *eht_argv_5[VHT_ARGC_MAX] = {};
+	char *eht_argv_6[VHT_ARGC_MAX] = {};
+	char **vht_argv = NULL, **he_argv = NULL, **eht_argv = NULL;
 	int vht_argc_5 = 0; int vht_argc_24 = 0;
 	int he_argc_5 = 0; int he_argc_24 = 0;
 	int he_argc_6 = 0;
-	int *vht_argc = NULL, *he_argc = NULL;
+	int eht_argc_24 = 0, eht_argc_5 = 0, eht_argc_6 = 0;
+	int *vht_argc = NULL, *he_argc = NULL, *eht_argc = NULL;
 	int sgi_24 = 0, sgi_5 = 0, lgi_24 = 0, lgi_5 = 0;
 	int has_he_gi_24 = 0, has_he_gi_5 = 0, has_he_ltf_24 = 0, has_he_ltf_5 = 0;
 	int has_he_gi_6 = 0, has_he_ltf_6 = 0;
+	int has_eht_gi_24 = 0, has_eht_gi_5 = 0, has_eht_gi_6 = 0;
+	int has_eht_ltf_24 = 0, has_eht_ltf_5 = 0, has_eht_ltf_6 = 0;
 	int he_gi = 0, he_ltf = 0;
 	char *he_gi_argv = NULL;
+	int eht_gi = 0, eht_ltf = 0;
+	char *eht_gi_argv = NULL;
 
 	enum {
 		S_NONE,
@@ -185,9 +249,12 @@ int set_bitrates(struct nl_msg *msg,
 		S_HT,
 		S_VHT,
 		S_HE,
+		S_EHT,
 		S_GI,
 		S_HE_GI,
 		S_HE_LTF,
+		S_EHT_GI,
+		S_EHT_LTF,
 	} parser_state = S_NONE;
 
 	for (i = 0; i < argc; i++) {
@@ -259,6 +326,27 @@ int set_bitrates(struct nl_msg *msg,
 			he_argv = he_argv_6;
 			he_argc = &he_argc_6;
 			have_he_mcs_6 = true;
+		} else if (strcmp(argv[i], "eht-mcs-2.4") == 0) {
+			if (have_eht_mcs_24)
+				return 1;
+			parser_state = S_EHT;
+			eht_argv = eht_argv_24;
+			eht_argc = &eht_argc_24;
+			have_eht_mcs_24 = true;
+		} else if (strcmp(argv[i], "eht-mcs-5") == 0) {
+			if (have_eht_mcs_5)
+				return 1;
+			parser_state = S_EHT;
+			eht_argv = eht_argv_5;
+			eht_argc = &eht_argc_5;
+			have_eht_mcs_5 = true;
+		} else if (strcmp(argv[i], "eht-mcs-6") == 0) {
+			if (have_eht_mcs_6)
+				return 1;
+			parser_state = S_EHT;
+			eht_argv = eht_argv_6;
+			eht_argc = &eht_argc_6;
+			have_eht_mcs_6 = true;
 		} else if (strcmp(argv[i], "sgi-2.4") == 0) {
 			sgi_24 = 1;
 			parser_state = S_GI;
@@ -289,6 +377,24 @@ int set_bitrates(struct nl_msg *msg,
 		} else if (strcmp(argv[i], "he-ltf-6") == 0) {
 			has_he_ltf_6 = 1;
 			parser_state = S_HE_LTF;
+		} else if (strcmp(argv[i], "eht-gi-2.4") == 0) {
+			has_eht_gi_24 = 1;
+			parser_state = S_EHT_GI;
+		} else if (strcmp(argv[i], "eht-gi-5") == 0) {
+			has_eht_gi_5 = 1;
+			parser_state = S_EHT_GI;
+		} else if (strcmp(argv[i], "eht-gi-6") == 0) {
+			has_eht_gi_6 = 1;
+			parser_state = S_EHT_GI;
+		} else if (strcmp(argv[i], "eht-ltf-2.4") == 0) {
+			has_eht_ltf_24 = 1;
+			parser_state = S_EHT_LTF;
+		} else if (strcmp(argv[i], "eht-ltf-5") == 0) {
+			has_eht_ltf_5 = 1;
+			parser_state = S_EHT_LTF;
+		} else if (strcmp(argv[i], "eht-ltf-6") == 0) {
+			has_eht_ltf_6 = 1;
+			parser_state = S_EHT_LTF;
 		} else switch (parser_state) {
 		case S_LEGACY:
 			tmpd = strtod(argv[i], &end);
@@ -316,6 +422,11 @@ int set_bitrates(struct nl_msg *msg,
 				return 1;
 			he_argv[(*he_argc)++] = argv[i];
 			break;
+		case S_EHT:
+			if (*eht_argc >= VHT_ARGC_MAX)
+				return 1;
+			eht_argv[(*eht_argc)++] = argv[i];
+			break;
 		case S_GI:
 			break;
 		case S_HE_GI:
@@ -329,6 +440,19 @@ int set_bitrates(struct nl_msg *msg,
 				return 1;
 			he_ltf = he_ltf >> 1;
 			break;
+		case S_EHT_GI:
+			eht_gi_argv = argv[i];
+			break;
+		case S_EHT_LTF:
+			eht_ltf = strtol(argv[i], &end, 0);
+			if (*end != '\0')
+				return 1;
+			if (eht_ltf < 1 || eht_ltf > 8)
+				return 1;
+			if (eht_ltf != 1 && eht_ltf % 2)
+				return 1;
+			eht_ltf >>= 1;
+			break;
 		default:
 			if (attr != NL80211_ATTR_TX_RATES)
 				goto next;
@@ -360,6 +484,18 @@ next:
 		if (!setup_he(&txrate_he_6, he_argc_6, he_argv_6))
 			return -EINVAL;
 
+	if (have_eht_mcs_24)
+		if (!setup_eht(&txrate_eht_24, eht_argc_24, eht_argv_24))
+			return -EINVAL;
+
+	if (have_eht_mcs_5)
+		if (!setup_eht(&txrate_eht_5, eht_argc_5, eht_argv_5))
+			return -EINVAL;
+
+	if (have_eht_mcs_6)
+		if (!setup_eht(&txrate_eht_6, eht_argc_6, eht_argv_6))
+			return -EINVAL;
+
 	if (sgi_5 && lgi_5)
 		return 1;
 
@@ -372,12 +508,19 @@ next:
 			return 1;
 	}
 
+	if (eht_gi_argv) {
+		eht_gi = parse_eht_gi(eht_gi_argv);
+		if (eht_gi < 0)
+			return 1;
+	}
+
 	nl_rates = nla_nest_start(msg, attr);
 	if (!nl_rates)
 		goto nla_put_failure;
 
 	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || have_he_mcs_24 ||
-	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24) {
+	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24 ||
+	    have_eht_mcs_24 || has_eht_gi_24 || has_eht_ltf_24) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_2GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -390,6 +533,9 @@ next:
 		if (have_he_mcs_24)
 			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_24),
 				&txrate_he_24);
+		if (have_eht_mcs_24)
+			nla_put(msg, NL80211_TXRATE_EHT, sizeof(txrate_eht_24),
+				&txrate_eht_24);
 		if (sgi_24)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_SGI);
 		if (lgi_24)
@@ -398,11 +544,16 @@ next:
 			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
 		if (has_he_ltf_24)
 			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		if (has_eht_gi_24)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_GI, eht_gi);
+		if (has_eht_ltf_24)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_LTF, eht_ltf);
 		nla_nest_end(msg, nl_band);
 	}
 
 	if (have_legacy_5 || have_ht_mcs_5 || have_vht_mcs_5 || have_he_mcs_5 ||
-	    sgi_5 || lgi_5 || has_he_gi_5 || has_he_ltf_5) {
+	    sgi_5 || lgi_5 || has_he_gi_5 || has_he_ltf_5 ||
+	    have_eht_mcs_5 || has_eht_gi_5 || has_eht_ltf_5) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_5GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -415,6 +566,9 @@ next:
 		if (have_he_mcs_5)
 			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_5),
 				&txrate_he_5);
+		if (have_eht_mcs_5)
+			nla_put(msg, NL80211_TXRATE_EHT, sizeof(txrate_eht_5),
+				&txrate_eht_5);
 		if (sgi_5)
 			nla_put_u8(msg, NL80211_TXRATE_GI, NL80211_TXRATE_FORCE_SGI);
 		if (lgi_5)
@@ -423,20 +577,32 @@ next:
 			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
 		if (has_he_ltf_5)
 			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		if (has_eht_gi_5)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_GI, eht_gi);
+		if (has_eht_ltf_5)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_LTF, eht_ltf);
 		nla_nest_end(msg, nl_band);
 	}
 
-	if (have_he_mcs_6 || has_he_gi_6 || has_he_ltf_6) {
+	if (have_he_mcs_6 || has_he_gi_6 || has_he_ltf_6 ||
+	    have_eht_mcs_6 || has_eht_gi_6 || has_eht_ltf_6) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_6GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
 		if (have_he_mcs_6)
 			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_6),
 				&txrate_he_6);
+		if (have_eht_mcs_6)
+			nla_put(msg, NL80211_TXRATE_EHT, sizeof(txrate_eht_6),
+				&txrate_eht_6);
 		if (has_he_gi_6)
 			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
 		if (has_he_ltf_6)
 			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		if (has_eht_gi_6)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_GI, eht_gi);
+		if (has_eht_ltf_6)
+			nla_put_u8(msg, NL80211_TXRATE_EHT_LTF, eht_ltf);
 		nla_nest_end(msg, nl_band);
 	}
 
@@ -459,14 +625,16 @@ static int handle_bitrates(struct nl80211_state *state,
 #define DESCR_HT " [ht-mcs-<2.4|5> <MCS index>*]"
 #define DESCR_VHT " [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
 #define DESCR_HE " [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
-#define DESCR_GI " [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>]"
-#define DESCR_LTF " [he-ltf-<2.4|5|6> <1|2|4>]"
+#define DESCR_EHT " [eht-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*]"
+#define DESCR_GI " [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [eht-gi-<2.4|5|6> <0.8|1.6|3.2>]"
+#define DESCR_LTF " [he-ltf-<2.4|5|6> <1|2|4>] [eht-ltf-<2.4|5|6> <1|2|4|6|8>]"
 
 #define DESCR \
 	DESCR_LEGACY \
 	DESCR_HT \
 	DESCR_VHT \
 	DESCR_HE \
+	DESCR_EHT \
 	DESCR_GI \
 	DESCR_LTF \
 	/* end of DESCR */
-- 
2.39.0


