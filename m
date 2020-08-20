Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2652A24AF14
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Aug 2020 08:12:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726376AbgHTGMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Aug 2020 02:12:14 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:15787 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725768AbgHTGMJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Aug 2020 02:12:09 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597903927; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=0wj54JAAX0vZ+kmAu84kJyobj7Q5th6TKVp+WOwDQ/k=; b=dIGyzspTKYVDv3uPAFSIQpbknaAzlZC3U2ByLoaSnbPb8zPyi4HjE26XtGsxmqoF4aO17M2T
 Xlsvwu8VCVX3qY9UnVxzhuKCUb785uOzra/N6qE8PSBRaZyS6OinTtSZQwGvOyppNJQy84ct
 hBr7M/j24mZ+dhQWOrvBy/a3skQ=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n05.prod.us-east-1.postgun.com with SMTP id
 5f3e1437f729de1078ab8af2 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 06:12:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D452BC433CB; Thu, 20 Aug 2020 06:12:06 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from seevalam-linux.qualcomm.com (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tamizhr)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id D95E2C433C6;
        Thu, 20 Aug 2020 06:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org D95E2C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh Chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCH] iw: add TID specific Tx bitrate configuration
Date:   Thu, 20 Aug 2020 11:41:55 +0530
Message-Id: <1597903916-8674-1-git-send-email-tamizhr@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add TID specific Tx bitrate configuration by using
handle_bitrates already APIs.

Examples:
	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto
	$ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
 bitrate.c   | 27 ++++++++++++++++++++-------
 interface.c | 34 +++++++++++++++++++++++++++++++++-
 iw.h        |  3 +++
 3 files changed, 56 insertions(+), 8 deletions(-)

diff --git a/bitrate.c b/bitrate.c
index 780017f..32a23a9 100644
--- a/bitrate.c
+++ b/bitrate.c
@@ -76,13 +76,12 @@ static int setup_vht(struct nl80211_txrate_vht *txrate_vht,
 
 #define VHT_ARGC_MAX	100
 
-static int handle_bitrates(struct nl80211_state *state,
-			   struct nl_msg *msg,
-			   int argc, char **argv,
-			   enum id_input id)
+int set_bitrates(struct nl_msg *msg,
+		 int argc, char **argv,
+		 enum nl80211_attrs attr)
 {
 	struct nlattr *nl_rates, *nl_band;
-	int i;
+	int i, ret = 0;
 	bool have_legacy_24 = false, have_legacy_5 = false;
 	uint8_t legacy_24[32], legacy_5[32];
 	int n_legacy_24 = 0, n_legacy_5 = 0;
@@ -195,10 +194,16 @@ static int handle_bitrates(struct nl80211_state *state,
 		case S_GI:
 			break;
 		default:
+			if (attr != NL80211_ATTR_TX_RATES)
+				goto next;
 			return 1;
 		}
 	}
 
+next:
+	if (attr != NL80211_ATTR_TX_RATES)
+		ret = i;
+
 	if (have_vht_mcs_24)
 		if (!setup_vht(&txrate_vht_24, vht_argc_24, vht_argv_24))
 			return -EINVAL;
@@ -213,7 +218,7 @@ static int handle_bitrates(struct nl80211_state *state,
 	if (sgi_24 && lgi_24)
 		return 1;
 
-	nl_rates = nla_nest_start(msg, NL80211_ATTR_TX_RATES);
+	nl_rates = nla_nest_start(msg, attr);
 	if (!nl_rates)
 		goto nla_put_failure;
 
@@ -253,11 +258,19 @@ static int handle_bitrates(struct nl80211_state *state,
 
 	nla_nest_end(msg, nl_rates);
 
-	return 0;
+	return ret;
  nla_put_failure:
 	return -ENOBUFS;
 }
 
+static int handle_bitrates(struct nl80211_state *state,
+			   struct nl_msg *msg,
+			   int argc, char **argv,
+			   enum id_input id)
+{
+	return set_bitrates(msg, argc, argv, NL80211_ATTR_TX_RATES);
+}
+
 #define DESCR_LEGACY "[legacy-<2.4|5> <legacy rate in Mbps>*]"
 #define DESCR DESCR_LEGACY " [ht-mcs-<2.4|5> <MCS index>*] [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]"
 
diff --git a/interface.c b/interface.c
index df96bed..b55261f 100644
--- a/interface.c
+++ b/interface.c
@@ -757,6 +757,7 @@ static int handle_tid_config(struct nl80211_state *state,
 {
 	struct nlattr *tids_array = NULL;
 	struct nlattr *tids_entry = NULL;
+	enum nl80211_tx_rate_setting txrate_type;
 	unsigned char peer[ETH_ALEN];
 	int tids_num = 0;
 	char *end;
@@ -920,6 +921,33 @@ static int handle_tid_config(struct nl80211_state *state,
 
 				argc -= 2;
 				argv += 2;
+			} else if (strcmp(argv[0], "bitrates") == 0) {
+				if (argc < 2) {
+					fprintf(stderr, "not enough args for %s\n", argv[0]);
+					return HANDLER_RET_USAGE;
+				}
+				if (!strcmp(argv[1], "auto"))
+					txrate_type = NL80211_TX_RATE_AUTOMATIC;
+				else if (!strcmp(argv[1], "fixed"))
+					txrate_type = NL80211_TX_RATE_FIXED;
+				else if (!strcmp(argv[1], "limit"))
+					txrate_type = NL80211_TX_RATE_LIMITED;
+				else {
+					printf("Invalid parameter: %s\n", argv[0]);
+					return 2;
+				}
+				NLA_PUT_U8(msg, NL80211_TID_CONFIG_ATTR_TX_RATE_TYPE, txrate_type);
+				argc -= 2;
+				argv += 2;
+				if (txrate_type != NL80211_TX_RATE_AUTOMATIC) {
+					ret = set_bitrates(msg, argc, argv,
+							   NL80211_TID_CONFIG_ATTR_TX_RATE);
+					if (ret < 2)
+						return 1;
+
+					argc -= ret;
+					argv += ret;
+				}
 			} else {
 				fprintf(stderr, "Unknown parameter: %s\n", argv[0]);
 				return HANDLER_RET_USAGE;
@@ -945,7 +973,9 @@ nla_put_failure:
 }
 
 COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
-	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]",
+	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]"
+	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
+	" [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]]",
 	NL80211_CMD_SET_TID_CONFIG, 0, CIB_NETDEV, handle_tid_config,
 	"Setup per-node TID specific configuration for TIDs selected by bitmask.\n"
 	"If MAC address is not specified, then supplied TID configuration\n"
@@ -955,4 +985,6 @@ COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>
 	"  $ iw dev wlan0 tids 0x5 ampdu off amsdu off rtscts on\n"
 	"  $ iw dev wlan0 tids 0x3 override ampdu on noack on rtscts on\n"
 	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x1 ampdu off tids 0x3 amsdu off rtscts on\n"
+	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto\n"
+	"  $ iw dev wlan0 peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9\n"
 	);
diff --git a/iw.h b/iw.h
index bc0b3ac..46bc9b5 100644
--- a/iw.h
+++ b/iw.h
@@ -245,4 +245,7 @@ void nan_bf(uint8_t idx, uint8_t *bf, uint16_t bf_len, const uint8_t *buf,
 
 char *hex2bin(const char *hex, char *buf);
 
+int set_bitrates(struct nl_msg *msg, int argc, char **argv,
+		 enum nl80211_attrs attr);
+
 #endif /* __IW_H */
-- 
1.9.1

