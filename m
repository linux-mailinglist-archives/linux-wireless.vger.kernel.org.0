Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19C693DA871
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Jul 2021 18:07:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232011AbhG2QH1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 29 Jul 2021 12:07:27 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:38611 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234034AbhG2QGW (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 29 Jul 2021 12:06:22 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1627574779; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=3d92ICPN2NzgVRGb8y/2l0auYOAgyPpkj9BJA5JlyAQ=; b=RmGUmiLpQrqavmyZ9Xjt6qnKIvuc6msTvAgWaZeRJLPU7C8vWdgMoN19QcL+aFyaIvCDsqBS
 Xm1VscIwxDNbT+0IPRS6paGJoGeAITY0DNGkVjRWhebsBfrDNFufr8g3/u39+1f+HiJu9RDC
 uy4Ye1kIleyWyjfDytzVY5IQz6E=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-west-2.postgun.com with SMTP id
 6102d1dc96a66e66b2f824cd (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Jul 2021 16:05:48
 GMT
Sender: msinada=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 9B49AC43460; Thu, 29 Jul 2021 16:05:48 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from msinada-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: msinada)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 4F251C43217;
        Thu, 29 Jul 2021 16:05:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 4F251C43217
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=msinada@codeaurora.org
From:   Muna Sinada <msinada@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Muna Sinada <msinada@codeaurora.org>
Subject: [PATCH v2] iw: Add HE UL MU fixed rate setting
Date:   Thu, 29 Jul 2021 09:05:39 -0700
Message-Id: <1627574739-15279-1-git-send-email-msinada@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Adding mcs fixed rate settings for HE UL MU traffic, which encompasses
both UL-OFDMA and UL-MUMIO.

---
v2: rebased patch
---
Signed-off-by: Muna Sinada <msinada@codeaurora.org>
---
 bitrate.c | 52 ++++++++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 46 insertions(+), 6 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 8bde850b1d7f..bd5c14cef8bd 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -156,6 +156,7 @@ int set_bitrates(struct nl_msg *msg,
 	bool have_vht_mcs_24 = false, have_vht_mcs_5 = false;
 	bool have_he_mcs_24 = false, have_he_mcs_5 = false;
 	bool have_he_mcs_6 = false;
+	bool have_he_ul_mcs_24 = false, have_he_ul_mcs_5 = false;
 	uint8_t ht_mcs_24[77], ht_mcs_5[77];
 	int n_ht_mcs_24 = 0, n_ht_mcs_5 = 0;
 	struct nl80211_txrate_vht txrate_vht_24 = {};
@@ -163,16 +164,21 @@ int set_bitrates(struct nl_msg *msg,
 	struct nl80211_txrate_he txrate_he_24 = {};
 	struct nl80211_txrate_he txrate_he_5 = {};
 	struct nl80211_txrate_he txrate_he_6 = {};
+	struct nl80211_txrate_he txrate_he_ul_24 = {};
+	struct nl80211_txrate_he txrate_he_ul_5 = {};
 	uint8_t *mcs = NULL;
 	int *n_mcs = NULL;
 	char *vht_argv_5[VHT_ARGC_MAX] = {}; char *vht_argv_24[VHT_ARGC_MAX] = {};
 	char *he_argv_5[VHT_ARGC_MAX] = {}; char *he_argv_24[VHT_ARGC_MAX] = {};
 	char *he_argv_6[VHT_ARGC_MAX] = {};
-	char **vht_argv = NULL, **he_argv = NULL;
+	char *he_ul_argv_5[VHT_ARGC_MAX] = {};
+	char *he_ul_argv_24[VHT_ARGC_MAX] = {};
+	char **vht_argv = NULL, **he_argv = NULL, **he_ul_argv = NULL;
 	int vht_argc_5 = 0; int vht_argc_24 = 0;
 	int he_argc_5 = 0; int he_argc_24 = 0;
 	int he_argc_6 = 0;
-	int *vht_argc = NULL, *he_argc = NULL;
+	int he_ul_argc_5 = 0; int he_ul_argc_24 = 0;
+	int *vht_argc = NULL, *he_argc = NULL, *he_ul_argc = NULL;
 	int sgi_24 = 0, sgi_5 = 0, lgi_24 = 0, lgi_5 = 0;
 	int has_he_gi_24 = 0, has_he_gi_5 = 0, has_he_ltf_24 = 0, has_he_ltf_5 = 0;
 	int has_he_gi_6 = 0, has_he_ltf_6 = 0;
@@ -188,6 +194,7 @@ int set_bitrates(struct nl_msg *msg,
 		S_GI,
 		S_HE_GI,
 		S_HE_LTF,
+		S_HE_UL,
 	} parser_state = S_NONE;
 
 	for (i = 0; i < argc; i++) {
@@ -289,6 +296,20 @@ int set_bitrates(struct nl_msg *msg,
 		} else if (strcmp(argv[i], "he-ltf-6") == 0) {
 			has_he_ltf_6 = 1;
 			parser_state = S_HE_LTF;
+		} else if (strcmp(argv[i], "he-ul-mcs-2.4") == 0) {
+			if (have_he_ul_mcs_24)
+				return 1;
+			parser_state = S_HE_UL;
+			he_ul_argv = he_ul_argv_24;
+			he_ul_argc = &he_ul_argc_24;
+			have_he_ul_mcs_24 = true;
+		} else if (strcmp(argv[i], "he-ul-mcs-5") == 0) {
+			if (have_he_ul_mcs_5)
+				return 1;
+			parser_state = S_HE_UL;
+			he_ul_argv = he_ul_argv_5;
+			he_ul_argc = &he_ul_argc_5;
+			have_he_ul_mcs_5 = true;
 		} else switch (parser_state) {
 		case S_LEGACY:
 			tmpd = strtod(argv[i], &end);
@@ -329,6 +350,11 @@ int set_bitrates(struct nl_msg *msg,
 				return 1;
 			he_ltf = he_ltf >> 1;
 			break;
+		case S_HE_UL:
+			if (*he_ul_argc >= VHT_ARGC_MAX)
+				return 1;
+			he_ul_argv[(*he_ul_argc)++] = argv[i];
+			break;
 		default:
 			if (attr != NL80211_ATTR_TX_RATES)
 				goto next;
@@ -372,12 +398,20 @@ next:
 			return 1;
 	}
 
+	if (have_he_ul_mcs_24)
+		if (!setup_he(&txrate_he_ul_24, he_ul_argc_24, he_ul_argv_24))
+			return -EINVAL;
+
+	if (have_he_ul_mcs_5)
+		if (!setup_he(&txrate_he_ul_5, he_ul_argc_5, he_ul_argv_5))
+			return -EINVAL;
+
 	nl_rates = nla_nest_start(msg, attr);
 	if (!nl_rates)
 		goto nla_put_failure;
 
 	if (have_legacy_24 || have_ht_mcs_24 || have_vht_mcs_24 || have_he_mcs_24 ||
-	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24) {
+	    sgi_24 || lgi_24 || has_he_gi_24 || has_he_ltf_24 || have_he_ul_mcs_24) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_2GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -398,11 +432,14 @@ next:
 			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
 		if (has_he_ltf_24)
 			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		if (have_he_ul_mcs_24)
+			nla_put(msg, NL80211_TXRATE_HE_UL, sizeof(txrate_he_ul_24),
+				&txrate_he_ul_24);
 		nla_nest_end(msg, nl_band);
 	}
 
 	if (have_legacy_5 || have_ht_mcs_5 || have_vht_mcs_5 || have_he_mcs_5 ||
-	    sgi_5 || lgi_5 || has_he_gi_5 || has_he_ltf_5) {
+	    sgi_5 || lgi_5 || has_he_gi_5 || has_he_ltf_5 || have_he_ul_mcs_5) {
 		nl_band = nla_nest_start(msg, NL80211_BAND_5GHZ);
 		if (!nl_band)
 			goto nla_put_failure;
@@ -423,6 +460,9 @@ next:
 			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
 		if (has_he_ltf_5)
 			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		if (have_he_ul_mcs_5)
+			nla_put(msg, NL80211_TXRATE_HE_UL, sizeof(txrate_he_ul_5),
+				&txrate_he_ul_5);
 		nla_nest_end(msg, nl_band);
 	}
 
@@ -456,9 +496,9 @@ static int handle_bitrates(struct nl80211_state *state,
 }
 
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
-#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
+#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-ul-mcs-<2.4|5> <NSS:MCS>]"
 
-COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [he-ltf-<2.4|5|6> <1|2|4>]",
+COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [he-ltf-<2.4|5|6> <1|2|4>] [he-ul-mcs-<2.4|5> <NSS:MCS>]",
 	NL80211_CMD_SET_TX_BITRATE_MASK, 0, CIB_NETDEV, handle_bitrates,
 	"Sets up the specified rate masks.\n"
 	"Not passing any arguments would clear the existing mask (if any).");
-- 
2.7.4

