Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 185F1289BEE
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Oct 2020 00:50:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391164AbgJIWuo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Oct 2020 18:50:44 -0400
Received: from m42-4.mailgun.net ([69.72.42.4]:62204 "EHLO m42-4.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388159AbgJIWtx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Oct 2020 18:49:53 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1602283792; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=RekaQuzvEuTMKFGRUjGOcQkPbJ8kOe/tSuFlI+cV3EU=; b=uruvwUx89t418JciJGVdYzWX6hRhrwPWdC+gN5IWvPQmpG7KxqfyhnToUVh9IXOR9cSFM+BM
 fTcH0zwVpF9o1SYNkExTcAYKlRMt9rfscubmkBuc7knIluwtBfVXZpZrHUmp357wr/WPJCmH
 WuImHSiagibUBB3kINqNceOXKss=
X-Mailgun-Sending-Ip: 69.72.42.4
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 5f80e90f42f9861fb1489a04 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Fri, 09 Oct 2020 22:49:51
 GMT
Sender: pradeepc=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id E1B6AC43382; Fri,  9 Oct 2020 22:49:51 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from pradeepc-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pradeepc)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C5A6FC433CB;
        Fri,  9 Oct 2020 22:49:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C5A6FC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=pradeepc@codeaurora.org
From:   Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
Subject: [PATCH] iw: add optional argument to parse 6G band channel
Date:   Fri,  9 Oct 2020 15:49:29 -0700
Message-Id: <1602283770-8026-1-git-send-email-pradeepc@codeaurora.org>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Channel numbers of 6G band overlaps with those of 2G or 5G bands.
Therefore, an optional argument "6G" is added and expected next
to channel number to map it to correct 6GHz frequency. If not
specified, defaults to matching 2G or 5G frequency.

example:
iw wlanX set channel 149 6G 80MHz  --> maps to 6695 MHz
iw wlanX set channel 149 80MHz     --> maps to 5745 MHz

Signed-off-by: Pradeep Kumar Chitrapu <pradeepc@codeaurora.org>
---
 interface.c |  5 +++--
 phy.c       |  8 ++++----
 util.c      | 13 +++++++++----
 3 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/interface.c b/interface.c
index 89c95a9ac4ab..8e85f831f9f9 100644
--- a/interface.c
+++ b/interface.c
@@ -725,8 +725,9 @@ COMMAND(switch, freq,
 	"<control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]] [beacons <count>] [block-tx]",
 	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_freq,
 	"Switch the operating channel by sending a channel switch announcement (CSA).");
-COMMAND(switch, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [beacons <count>] [block-tx]",
-	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_chan, NULL);
+COMMAND(switch, channel, "<channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [beacons <count>] [block-tx]",
+	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_chan,
+	"6GHz channels expects '6G' in argument. If not specified, defaults to 5GHz or 2GHz channels");
 
 
 static int toggle_tid_param(const char *argv0, const char *argv1,
diff --git a/phy.c b/phy.c
index 2d489efd7690..31d96cec7886 100644
--- a/phy.c
+++ b/phy.c
@@ -222,9 +222,9 @@ static int handle_chan(struct nl80211_state *state, struct nl_msg *msg,
 
 	return put_chandef(msg, &chandef);
 }
-COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]",
+COMMAND(set, channel, "<channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]",
 	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_chan, NULL);
-COMMAND(set, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]",
+COMMAND(set, channel, "<channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]",
 	NL80211_CMD_SET_WIPHY, 0, CIB_NETDEV, handle_chan, NULL);
 
 
@@ -369,12 +369,12 @@ err_out:
 		free(cac_trigger_argv);
 	return err;
 }
-TOPLEVEL(cac, "channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+TOPLEVEL(cac, "channel <channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
 	      "freq <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
 	      "freq <control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]",
 	 0, 0, CIB_NETDEV, handle_cac, NULL);
 COMMAND(cac, trigger,
-	"channel <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
+	"channel <channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
 	"freq <frequency> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz]\n"
 	"freq <frequency> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]",
 	NL80211_CMD_RADAR_DETECT, 0, CIB_NETDEV, handle_cac_trigger,
diff --git a/util.c b/util.c
index 0a9083c613a4..9ca32c5295ae 100644
--- a/util.c
+++ b/util.c
@@ -576,7 +576,7 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
  * user by giving "NOHT" instead.
  *
  * The working specifier if chan is set are:
- *   <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
+ *   <channel> [6G] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
  *
  * And if frequency is set:
  *   <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz]
@@ -648,7 +648,12 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 	if (chan) {
 		enum nl80211_band band;
 
-		band = freq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		if (argc > 1 && strcmp(argv[1], "6G") == 0) {
+			band = NL80211_BAND_6GHZ;
+			_parsed += 1;
+		} else {
+			band = freq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		}
 		freq = ieee80211_channel_to_frequency(freq, band);
 	}
 	chandef->control_freq = freq;
@@ -656,9 +661,9 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 	chandef->center_freq1 = freq;
 
 	/* Try to parse HT mode definitions */
-	if (argc > 1) {
+	if ((argc - _parsed) > 0) {
 		for (i = 0; i < ARRAY_SIZE(chanmode); i++) {
-			if (strcasecmp(chanmode[i].name, argv[1]) == 0) {
+			if (strcasecmp(chanmode[i].name, argv[_parsed]) == 0) {
 				chanmode_selected = &chanmode[i];
 				_parsed += 1;
 				break;
-- 
1.9.1

