Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA03425F354
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Sep 2020 08:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgIGGl5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Sep 2020 02:41:57 -0400
Received: from a27-10.smtp-out.us-west-2.amazonses.com ([54.240.27.10]:42246
        "EHLO a27-10.smtp-out.us-west-2.amazonses.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726278AbgIGGl5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Sep 2020 02:41:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=zsmsymrwgfyinv5wlfyidntwsjeeldzt; d=codeaurora.org; t=1599460915;
        h=From:To:Cc:Subject:Date:Message-Id;
        bh=wUeey4qWkTXxr162V3SAaoX8jZVmb6oFKzzHjYCaVO4=;
        b=NbI7VggbRUUDwa/h9BPyLzrvDJ+zo3CXX8tnqI6gViF9C1dfvMwYfiavqjNnFu6r
        xJEdq0pr2YS6AVh/bSAEUiP9X1LWbNAUAaikHSSVzbr5B9a80ICgPd4b31p58kB483Z
        gXUNoORNcsJdNqHeKN1G5zblP9zZ6kxW5W1pH8Bw=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
        s=hsbnp7p3ensaochzwyq5wwmceodymuwv; d=amazonses.com; t=1599460915;
        h=From:To:Cc:Subject:Date:Message-Id:Feedback-ID;
        bh=wUeey4qWkTXxr162V3SAaoX8jZVmb6oFKzzHjYCaVO4=;
        b=hS8DU8Yz3y4RQE+w1fR0pxPWmWP2nvvqNC8ixQuLxY1WtrcuA4YG7eNJN80MYuib
        wRD6L1B8WcGTd3rwj7Ezk2B4W36s9/63NIXdGpNZX6y8TsaR38IogzIfboIV8JEvhXQ
        lAM8Wcl4xGr5W3DZ0OQzHPa5nZxDUT4DBiDu2GpM=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL
        autolearn=no autolearn_force=no version=3.4.0
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 89E22C433F1
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=tamizhr@codeaurora.org
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Tamizh Chelvam <tamizhr@codeaurora.org>
Subject: [PATCHv2] iw: add TID specific Tx bitrate configuration
Date:   Mon, 7 Sep 2020 06:41:55 +0000
Message-ID: <01010174674cba3e-ae0b7501-76dd-4bbd-870f-a799e0558e1e-000000@us-west-2.amazonses.com>
X-Mailer: git-send-email 2.7.4
X-SES-Outgoing: 2020.09.07-54.240.27.10
Feedback-ID: 1.us-west-2.CZuq2qbDmUIuT3qdvXlRHZZCpfZqZ4GtG9v3VKgRyF0=:AmazonSES
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Tamizh Chelvam <tamizhr@codeaurora.org>

Add TID specific Tx bitrate configuration by using
handle_bitrates already APIs.

Examples:
	$ iw dev wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto
	$ iw dev wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9

Signed-off-by: Tamizh Chelvam <tamizhr@codeaurora.org>
---
v2:
  * Fixed help entries and implicit conversion of the enum value
  * Depend on [PATCH] iw: fix tid config help entries patch.

 bitrate.c   | 27 ++++++++++++++++++++-------
 interface.c | 36 +++++++++++++++++++++++++++++++++++-
 iw.h        |  3 +++
 3 files changed, 58 insertions(+), 8 deletions(-)

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
index c9da4b4..89c95a9 100644
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
@@ -766,6 +767,7 @@ static int handle_tid_config(struct nl80211_state *state,
 		PS_TIDS,
 		PS_CONF,
 	} parse_state = PS_ADDR;
+	unsigned int attr;
 
 	while (argc) {
 		switch (parse_state) {
@@ -920,6 +922,34 @@ static int handle_tid_config(struct nl80211_state *state,
 
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
+					attr = NL80211_TID_CONFIG_ATTR_TX_RATE;
+					ret = set_bitrates(msg, argc, argv,
+							   attr);
+					if (ret < 2)
+						return 1;
+
+					argc -= ret;
+					argv += ret;
+				}
 			} else {
 				fprintf(stderr, "Unknown parameter: %s\n", argv[0]);
 				return HANDLER_RET_USAGE;
@@ -945,7 +975,9 @@ nla_put_failure:
 }
 
 COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>] [lretry <num>] "
-	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]",
+	"[ampdu [on|off]] [amsdu [on|off]] [noack [on|off]] [rtscts [on|off]]"
+	"[bitrates <type [auto|fixed|limit]> [legacy-<2.4|5> <legacy rate in Mbps>*] [ht-mcs-<2.4|5> <MCS index>*]"
+	" [vht-mcs-<2.4|5> <NSS:MCSx,MCSy... | NSS:MCSx-MCSy>*] [sgi-2.4|lgi-2.4] [sgi-5|lgi-5]]",
 	NL80211_CMD_SET_TID_CONFIG, 0, CIB_NETDEV, handle_tid_config,
 	"Setup per-node TID specific configuration for TIDs selected by bitmask.\n"
 	"If MAC address is not specified, then supplied TID configuration\n"
@@ -955,4 +987,6 @@ COMMAND(set, tidconf, "[peer <MAC address>] tids <mask> [override] [sretry <num>
 	"  $ iw dev wlan0 set tidconf tids 0x5 ampdu off amsdu off rtscts on\n"
 	"  $ iw dev wlan0 set tidconf tids 0x3 override ampdu on noack on rtscts on\n"
 	"  $ iw dev wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x1 ampdu off tids 0x3 amsdu off rtscts on\n"
+	"  $ iw dev wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates auto\n"
+	"  $ iw dev wlan0 set tidconf peer xx:xx:xx:xx:xx:xx tids 0x2 bitrates limit vht-mcs-5 4:9\n"
 	);
diff --git a/iw.h b/iw.h
index 51f5ca8..1acf189 100644
--- a/iw.h
+++ b/iw.h
@@ -261,4 +261,7 @@ void nan_bf(uint8_t idx, uint8_t *bf, uint16_t bf_len, const uint8_t *buf,
 
 char *hex2bin(const char *hex, char *buf);
 
+int set_bitrates(struct nl_msg *msg, int argc, char **argv,
+		 enum nl80211_attrs attr);
+
 #endif /* __IW_H */
-- 
1.9.1

