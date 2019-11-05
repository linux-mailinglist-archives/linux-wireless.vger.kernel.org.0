Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BC628EFA9A
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Nov 2019 11:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387773AbfKEKO3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Nov 2019 05:14:29 -0500
Received: from smtp.codeaurora.org ([198.145.29.96]:46508 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730699AbfKEKO3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Nov 2019 05:14:29 -0500
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 57758611F4; Tue,  5 Nov 2019 10:14:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572948868;
        bh=N0QTVZ+dZLkODl3pWyGNVL/EZFLw93DGEbdfWinZjJM=;
        h=From:To:Cc:Subject:Date:From;
        b=VgDsC4s2Z3y7b0yvA7pV8SCIZ5Rx+83/MCUT5Mlf/LJGxF5+lWDSC7tRgKxSnvxad
         ePleOf+Bn3rmQgXRsUCi5k/dOvf/qWfwXCSnW4hDv6Md40MEo5x5+PDoBGgQKlFqyA
         ht73Ed7LIT1Su466oynEWVWIFPBLzcyHUoy5IYn0=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.0
Received: from murugana-linux.qualcomm.com (blr-c-bdr-fw-01_globalnat_allzones-outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: murugana@smtp.codeaurora.org)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2A6CE607EF;
        Tue,  5 Nov 2019 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1572948867;
        bh=N0QTVZ+dZLkODl3pWyGNVL/EZFLw93DGEbdfWinZjJM=;
        h=From:To:Cc:Subject:Date:From;
        b=J7GN/PZQ/J49QJUrExVb2CoaJgcpkrPbHhWkCFyxvrrTU+6iqDzprvWOukRgFHSEt
         0z5fsw6szmWy1KHj1/ZIOL7xyN499eAAqUFUG29dD+9IM/ViUgc2vhIdmQWD4i1+dw
         GG08obHNRS70E60Vu6Co0xgQTZz4htBKchs5NnAI=
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2A6CE607EF
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=murugana@codeaurora.org
From:   Sathishkumar Muruganandam <murugana@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org
Subject: [PATCH] iw: Add phymode parameters to scan command for Wide Band Scan support
Date:   Tue,  5 Nov 2019 15:44:17 +0530
Message-Id: <1572948857-20702-1-git-send-email-murugana@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

chandef is parsed and updated based on user phymode [HT40+|HT40-|80MHz]
config. Scan flag NL80211_SCAN_FLAG_WIDE_BAND_SCAN is set to indicate
the presence of chandef in nl_msg.

Added print in extended features dump.

Supported extended features:
                * [ WIDE_BAND_SCAN ]: wide band scan (40Mhz, 80Mhz)

Wide Band Scan Commands:
-----------------------

dev <devname> scan freq <freq> [HT40+|HT40-|80MHz] [ap-force]

dev <devname> scan trigger freq <freq> [HT40+|HT40-|80MHz] [ap-force]

Examples:
---------

iw wlan0 scan freq 5180 HT40+

iw wlan0 scan trigger freq 5260 80Mhz ap-force

Signed-off-by: Sathishkumar Muruganandam <murugana@codeaurora.org>
---
 info.c |  2 ++
 scan.c | 53 +++++++++++++++++++++++++++++++++++++++++------------
 util.c |  5 +++--
 3 files changed, 46 insertions(+), 14 deletions(-)

diff --git a/info.c b/info.c
index 38362d8744b7..14b397d34f79 100644
--- a/info.c
+++ b/info.c
@@ -686,6 +686,8 @@ broken_combination:
 		ext_feat_print(tb, EXT_KEY_ID, "extended key ID support");
 		ext_feat_print(tb, STA_TX_PWR, "TX power control per station");
 		ext_feat_print(tb, SAE_OFFLOAD, "SAE offload support");
+		ext_feat_print(tb, NL80211_EXT_FEATURE_WIDE_BAND_SCAN,
+			       "WIDE_BAND_SCAN", "wide band scan (40Mhz, 80Mhz)");
 	}
 
 	if (tb_msg[NL80211_ATTR_COALESCE_RULE]) {
diff --git a/scan.c b/scan.c
index 1418da73a624..b8a00f26b85a 100644
--- a/scan.c
+++ b/scan.c
@@ -378,19 +378,23 @@ static int handle_scan(struct nl80211_state *state,
 	enum {
 		NONE,
 		FREQ,
+		MODE,
+		CHECK_SCAN_FLAG_AP,
 		IES,
 		SSID,
 		MESHID,
 		DURATION,
 		DONE,
 	} parse = NONE;
-	int freq;
+	int freq = 0;
 	unsigned int duration = 0;
 	bool passive = false, have_ssids = false, have_freqs = false;
+	bool have_chandef = false;
 	bool duration_mandatory = false;
 	size_t ies_len = 0, meshid_len = 0;
 	unsigned char *ies = NULL, *meshid = NULL, *tmpies = NULL;
 	unsigned int flags = 0;
+	struct chandef chandef;
 
 	ssids = nlmsg_alloc();
 	if (!ssids)
@@ -407,7 +411,6 @@ static int handle_scan(struct nl80211_state *state,
 		case NONE:
 			if (strcmp(argv[i], "freq") == 0) {
 				parse = FREQ;
-				have_freqs = true;
 				break;
 			} else if (strcmp(argv[i], "ies") == 0) {
 				parse = IES;
@@ -453,14 +456,33 @@ static int handle_scan(struct nl80211_state *state,
 			err = 1;
 			goto nla_put_failure;
 		case FREQ:
-			freq = strtoul(argv[i], &eptr, 10);
-			if (eptr != argv[i] + strlen(argv[i])) {
-				/* failed to parse as number -- maybe a tag? */
-				i--;
-				parse = NONE;
-				continue;
+			parse_freqchan(&chandef, false, argc - i, argv + i, NULL);
+			if (!chandef.control_freq || have_freqs) {
+				freq = strtoul(argv[i], &eptr, 10);
+				if (eptr != argv[i] + strlen(argv[i])) {
+					/* failed to parse as number -- maybe a tag? */
+					i--;
+					parse = NONE;
+					continue;
+				}
+				NLA_PUT_U32(freqs, i, freq);
+			} else {
+				if (chandef.width == NL80211_CHAN_WIDTH_20_NOHT) {
+					have_freqs = true;
+					NLA_PUT_U32(freqs, i, chandef.control_freq);
+				} else {
+					parse = MODE;
+				}
 			}
-			NLA_PUT_U32(freqs, i, freq);
+			break;
+		case MODE:
+			have_chandef = true;
+			flags |= NL80211_SCAN_FLAG_WIDE_BAND_SCAN;
+			parse = CHECK_SCAN_FLAG_AP;
+			break;
+		case CHECK_SCAN_FLAG_AP:
+			if (strcmp(argv[i], "ap-force") == 0)
+				flags |= NL80211_SCAN_FLAG_AP;
 			break;
 		case IES:
 			if (ies)
@@ -508,8 +530,11 @@ static int handle_scan(struct nl80211_state *state,
 	if (!passive)
 		nla_put_nested(msg, NL80211_ATTR_SCAN_SSIDS, ssids);
 
-	if (have_freqs)
+	if (have_chandef)
+		put_chandef(msg, &chandef);
+	else if (have_freqs)
 		nla_put_nested(msg, NL80211_ATTR_SCAN_FREQUENCIES, freqs);
+
 	if (flags)
 		NLA_PUT_U32(msg, NL80211_ATTR_SCAN_FLAGS, flags);
 	if (duration)
@@ -2337,20 +2362,24 @@ static int handle_scan_combined(struct nl80211_state *state,
 	dump_argv[0] = argv[0];
 	return handle_cmd(state, id, dump_argc, dump_argv);
 }
-TOPLEVEL(scan, "[-u] [freq <freq>*] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]", 0, 0,
+TOPLEVEL(scan, "[-u] [freq <freq>*] [HT40+|HT40-|80MHz] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]", 0, 0,
 	 CIB_NETDEV, handle_scan_combined,
 	 "Scan on the given frequencies and probe for the given SSIDs\n"
 	 "(or wildcard if not given) unless passive scanning is requested.\n"
+	 "If channel mode/width is provided along with frequency, wide band\n"
+	 "scan results on primary frequency of channel mode/width is printed.\n"
 	 "If -u is specified print unknown data in the scan results.\n"
 	 "Specified (vendor) IEs must be well-formed.");
 COMMAND(scan, dump, "[-u]",
 	NL80211_CMD_GET_SCAN, NLM_F_DUMP, CIB_NETDEV, handle_scan_dump,
 	"Dump the current scan results. If -u is specified, print unknown\n"
 	"data in scan results.");
-COMMAND(scan, trigger, "[freq <freq>*] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]",
+COMMAND(scan, trigger, "[freq <freq>*] [HT40+|HT40-|80MHz] [duration <dur>] [ies <hex as 00:11:..>] [meshid <meshid>] [lowpri,flush,ap-force,duration-mandatory] [randomise[=<addr>/<mask>]] [ssid <ssid>*|passive]",
 	NL80211_CMD_TRIGGER_SCAN, 0, CIB_NETDEV, handle_scan,
 	 "Trigger a scan on the given frequencies with probing for the given\n"
 	 "SSIDs (or wildcard if not given) unless passive scanning is requested.\n"
+	 "If channel mode/width is provided along with frequency, wide band\n"
+	 "scan on primary frequency of channel mode/width is requested.\n"
 	 "Duration(in TUs), if specified, will be used to set dwell times.\n");
 
 
diff --git a/util.c b/util.c
index cbac5ad46b7d..82a55d116719 100644
--- a/util.c
+++ b/util.c
@@ -749,6 +749,9 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 
 	if (!argv[0])
 		goto out;
+
+	memset(chandef, 0, sizeof(struct chandef));
+
 	freq = strtoul(argv[0], &end, 10);
 	if (*end) {
 		res = 1;
@@ -757,8 +760,6 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 
 	_parsed += 1;
 
-	memset(chandef, 0, sizeof(struct chandef));
-
 	if (chan) {
 		enum nl80211_band band;
 
-- 
2.7.4

