Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C485027DE3B
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Sep 2020 04:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729742AbgI3CGk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 29 Sep 2020 22:06:40 -0400
Received: from z5.mailgun.us ([104.130.96.5]:58512 "EHLO z5.mailgun.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729322AbgI3CGj (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 29 Sep 2020 22:06:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1601431599; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=IU7FaWBjvNQh5q5ONMDEuD++7KDd4lDCHIdDUxqZi2I=; b=SuuARtc9YRWri16L1r1YSmfkAdHL/zgFz5pD6zO+ExhNkfvhO1Pxhl6jwMvg5wsgbkiiaETj
 afUhTdQVeIclKMlP+ANxcgGTGPDLFvu3QRLlpuA2mnMmIhDysqnEckLB45dCDOP9gsC4SfOC
 16FArkDxymdDChAZePVS4mkXufY=
X-Mailgun-Sending-Ip: 104.130.96.5
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-west-2.postgun.com with SMTP id
 5f73e805bebf546dbbd8a0f9 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 30 Sep 2020 02:05:57
 GMT
Sender: rmanohar=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CA63EC433CB; Wed, 30 Sep 2020 02:05:57 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from rmanohar-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: rmanohar)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A9746C433C8;
        Wed, 30 Sep 2020 02:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A9746C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=rmanohar@codeaurora.org
From:   Rajkumar Manoharan <rmanohar@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Rajkumar Manoharan <rmanohar@codeaurora.org>
Subject: [PATCH v2 2/2] iw: support HE rate configuration in 6 GHz band
Date:   Tue, 29 Sep 2020 19:05:38 -0700
Message-Id: <1601431538-6621-2-git-send-email-rmanohar@codeaurora.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1601431538-6621-1-git-send-email-rmanohar@codeaurora.org>
References: <1601431538-6621-1-git-send-email-rmanohar@codeaurora.org>
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Allow HE-MCS, HE-GI, HE-LTF in 6 GHz band as well and allow only
MCS rates in 6 GHz.

Signed-off-by: Rajkumar Manoharan <rmanohar@codeaurora.org>
---
 bitrate.c | 40 ++++++++++++++++++++++++++++++++++++++--
 1 file changed, 38 insertions(+), 2 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 2cd55d15bfab..8bde850b1d7f 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -155,22 +155,27 @@ int set_bitrates(struct nl_msg *msg,
 	bool have_ht_mcs_24 = false, have_ht_mcs_5 = false;
 	bool have_vht_mcs_24 = false, have_vht_mcs_5 = false;
 	bool have_he_mcs_24 = false, have_he_mcs_5 = false;
+	bool have_he_mcs_6 = false;
 	uint8_t ht_mcs_24[77], ht_mcs_5[77];
 	int n_ht_mcs_24 = 0, n_ht_mcs_5 = 0;
 	struct nl80211_txrate_vht txrate_vht_24 = {};
 	struct nl80211_txrate_vht txrate_vht_5 = {};
 	struct nl80211_txrate_he txrate_he_24 = {};
 	struct nl80211_txrate_he txrate_he_5 = {};
+	struct nl80211_txrate_he txrate_he_6 = {};
 	uint8_t *mcs = NULL;
 	int *n_mcs = NULL;
 	char *vht_argv_5[VHT_ARGC_MAX] = {}; char *vht_argv_24[VHT_ARGC_MAX] = {};
 	char *he_argv_5[VHT_ARGC_MAX] = {}; char *he_argv_24[VHT_ARGC_MAX] = {};
+	char *he_argv_6[VHT_ARGC_MAX] = {};
 	char **vht_argv = NULL, **he_argv = NULL;
 	int vht_argc_5 = 0; int vht_argc_24 = 0;
 	int he_argc_5 = 0; int he_argc_24 = 0;
+	int he_argc_6 = 0;
 	int *vht_argc = NULL, *he_argc = NULL;
 	int sgi_24 = 0, sgi_5 = 0, lgi_24 = 0, lgi_5 = 0;
 	int has_he_gi_24 = 0, has_he_gi_5 = 0, has_he_ltf_24 = 0, has_he_ltf_5 = 0;
+	int has_he_gi_6 = 0, has_he_ltf_6 = 0;
 	int he_gi = 0, he_ltf = 0;
 	char *he_gi_argv = NULL;
 
@@ -247,6 +252,13 @@ int set_bitrates(struct nl_msg *msg,
 			he_argv = he_argv_5;
 			he_argc = &he_argc_5;
 			have_he_mcs_5 = true;
+		} else if (strcmp(argv[i], "he-mcs-6") == 0) {
+			if (have_he_mcs_6)
+				return 1;
+			parser_state = S_HE;
+			he_argv = he_argv_6;
+			he_argc = &he_argc_6;
+			have_he_mcs_6 = true;
 		} else if (strcmp(argv[i], "sgi-2.4") == 0) {
 			sgi_24 = 1;
 			parser_state = S_GI;
@@ -265,12 +277,18 @@ int set_bitrates(struct nl_msg *msg,
 		} else if (strcmp(argv[i], "he-gi-5") == 0) {
 			has_he_gi_5 = 1;
 			parser_state = S_HE_GI;
+		} else if (strcmp(argv[i], "he-gi-6") == 0) {
+			has_he_gi_6 = 1;
+			parser_state = S_HE_GI;
 		} else if (strcmp(argv[i], "he-ltf-2.4") == 0) {
 			has_he_ltf_24 = 1;
 			parser_state = S_HE_LTF;
 		} else if (strcmp(argv[i], "he-ltf-5") == 0) {
 			has_he_ltf_5 = 1;
 			parser_state = S_HE_LTF;
+		} else if (strcmp(argv[i], "he-ltf-6") == 0) {
+			has_he_ltf_6 = 1;
+			parser_state = S_HE_LTF;
 		} else switch (parser_state) {
 		case S_LEGACY:
 			tmpd = strtod(argv[i], &end);
@@ -338,6 +356,10 @@ next:
 		if (!setup_he(&txrate_he_5, he_argc_5, he_argv_5))
 			return -EINVAL;
 
+	if (have_he_mcs_6)
+		if (!setup_he(&txrate_he_6, he_argc_6, he_argv_6))
+			return -EINVAL;
+
 	if (sgi_5 && lgi_5)
 		return 1;
 
@@ -404,6 +426,20 @@ next:
 		nla_nest_end(msg, nl_band);
 	}
 
+	if (have_he_mcs_6 || has_he_gi_6 || has_he_ltf_6) {
+		nl_band = nla_nest_start(msg, NL80211_BAND_6GHZ);
+		if (!nl_band)
+			goto nla_put_failure;
+		if (have_he_mcs_6)
+			nla_put(msg, NL80211_TXRATE_HE, sizeof(txrate_he_6),
+				&txrate_he_6);
+		if (has_he_gi_6)
+			nla_put_u8(msg, NL80211_TXRATE_HE_GI, he_gi);
+		if (has_he_ltf_6)
+			nla_put_u8(msg, NL80211_TXRATE_HE_LTF, he_ltf);
+		nla_nest_end(msg, nl_band);
+	}
+
 	nla_nest_end(msg, nl_rates);
 
 	return ret;
@@ -420,9 +456,9 @@ static int handle_bitrates(struct nl80211_state *state,
 }
 
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
-#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
+#define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5>  [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
 
-COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-2.4:0.8/1.6/3.2] [he-gi-5:0.8/1.6/3.2] [he-ltf-2.4:1/2/4] [he-ltf-5:1/2/4]",
+COMMAND(set, bitrates, "[legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> [he-mcs-<2.4|5|6> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5] [he-gi-<2.4|5|6> <0.8|1.6|3.2>] [he-ltf-<2.4|5|6> <1|2|4>]",
 	NL80211_CMD_SET_TX_BITRATE_MASK, 0, CIB_NETDEV, handle_bitrates,
 	"Sets up the specified rate masks.\n"
 	"Not passing any arguments would clear the existing mask (if any).");
-- 
2.7.4

