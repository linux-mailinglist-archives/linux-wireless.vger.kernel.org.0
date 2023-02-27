Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F07D56A3740
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Feb 2023 03:08:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbjB0CH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 26 Feb 2023 21:07:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjB0CHb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 26 Feb 2023 21:07:31 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70E31D500
        for <linux-wireless@vger.kernel.org>; Sun, 26 Feb 2023 18:06:45 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id i5so3518628pla.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Feb 2023 18:06:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=morsemicro-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qsndHsOSDYENkB0xJCEBcEtNNRw02wIOpYDOAKLyQVc=;
        b=tzMmIar8U7M2i7zIRyjACzb1diXRhtO4ZJnm1chaLejZzQx4cr6FMDZn4ceQxpmMLa
         bFRngPvnXfhOfbm1vp1m/UUNfccKaoGK1L45TcjPw0CFLTuVLNago/pE6aw/5kDPBIIJ
         47U+6mo2SmbN0evmpK9XawU3f5vZQ2VOi8c5+gtsJAMEqxA60IS8V0PrONQPPpXZwpOt
         xKMyFmh9kINv+UCDkyj3qEWELSRuvjgQga0W5AOU1vELYfyNeYPO1744b5Ife0RzMcTF
         mp6wxO/A53NqWXoOBfZhKWzFJK/12kYfk4FJ5WAFQ/OOQk66sRfNgB8ot3UuSrMwpDxl
         Cbgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qsndHsOSDYENkB0xJCEBcEtNNRw02wIOpYDOAKLyQVc=;
        b=3ots/U4ZUeUSGoJ8S+MLkhkQIfduHkNl9CXidOoNVpENODvf0cPfV/kKJY64xKaCG5
         gk1lXgNw9S8qhE7cEo4njLSa42RT20ZV8PuQIil/cU3Nonah1QaJ4AKC7hbtO4N/nqhy
         HcRwDYjwlNnCW2KE7q9hD050iBCSZdmxT8oGNufPZImJ8PKCvZELHFJdRUT1U4/0xn5G
         Y94oxGXnHv5GuAiogurGpY+n7oM5Jl1QVBfiQRKkSGJ5BlozzOrqVPp8z4hgDng8cHWF
         UnF1Kd0E/ig/XG+lP8uT/YVGdJev0z5qajxJzsX1ftxfoSBGSsW+lSR6vKx/F35gXb2P
         Kpsw==
X-Gm-Message-State: AO0yUKV6DwX+Q7T5MBaxs3CvHEf0sI2WrkPuU1C1CKN/lqFhXAyEC54M
        GIALNU3I509ECGSkj3jZPScIr51KpVhUnO60
X-Google-Smtp-Source: AK7set/kaTMyUEw2BKIvkkJhWbw94Cw9gF7+BNflOdcQwVvHGDFpTHw4yKyq8OwKvSkZJF+Yq3gu7Q==
X-Received: by 2002:a05:6a20:12d2:b0:c1:2027:f4a2 with SMTP id v18-20020a056a2012d200b000c12027f4a2mr17908693pzg.49.1677463535849;
        Sun, 26 Feb 2023 18:05:35 -0800 (PST)
Received: from virs-pc-014.morsemicro.com (124-248-138-161.static.lightwire.co.nz. [124.248.138.161])
        by smtp.gmail.com with ESMTPSA id k12-20020aa792cc000000b005a7c892b435sm3060304pfa.25.2023.02.26.18.05.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 18:05:35 -0800 (PST)
From:   Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
X-Google-Original-From: Gilad Itzkovitch <gilad.itzkovitch@virscient.com>
To:     johannes@sipsolutions.net
Cc:     linux-wireless@vger.kernel.org,
        Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
Subject: [PATCH] iw: S1G: add frequency set in kHz and offset options
Date:   Mon, 27 Feb 2023 15:05:29 +1300
Message-Id: <20230227020529.504934-1-gilad.itzkovitch@virscient.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>

This change adds support to specify the set frequency in kHz for
the set frequency command which include an offset whenever needed.
Also, it adds S1G bandwidth options to the selected chandef.

Signed-off-by: Gilad Itzkovitch <gilad.itzkovitch@morsemicro.com>
---
 ap.c        |  2 +-
 ibss.c      |  2 +-
 interface.c |  2 +-
 iw.h        |  5 +++-
 mesh.c      |  2 +-
 ocb.c       |  2 +-
 phy.c       | 37 ++++++++++++++++++++++-----
 util.c      | 73 ++++++++++++++++++++++++++++++++++++++++++++++++-----
 8 files changed, 107 insertions(+), 18 deletions(-)

diff --git a/ap.c b/ap.c
index db9efb7..748576d 100644
--- a/ap.c
+++ b/ap.c
@@ -28,7 +28,7 @@ static int handle_start_ap(struct nl80211_state *state,
 	argc--;
 
 	/* chandef */
-	res = parse_freqchan(&chandef, false, argc, argv, &parsed);
+	res = parse_freqchan(&chandef, false, argc, argv, &parsed, false);
 	if (res)
 		return res;
 	argc -= parsed;
diff --git a/ibss.c b/ibss.c
index f6cbc4c..6e6a835 100644
--- a/ibss.c
+++ b/ibss.c
@@ -30,7 +30,7 @@ static int join_ibss(struct nl80211_state *state,
 	argv++;
 	argc--;
 
-	err = parse_freqchan(&chandef, false, argc, argv, &parsed);
+	err = parse_freqchan(&chandef, false, argc, argv, &parsed, false);
 	if (err)
 		return err;
 
diff --git a/interface.c b/interface.c
index 84990c9..f676b85 100644
--- a/interface.c
+++ b/interface.c
@@ -669,7 +669,7 @@ static int handle_chanfreq(struct nl80211_state *state, struct nl_msg *msg,
 	int parsed;
 	char *end;
 
-	res = parse_freqchan(&chandef, chan, argc, argv, &parsed);
+	res = parse_freqchan(&chandef, chan, argc, argv, &parsed, false);
 	if (res)
 		return res;
 
diff --git a/iw.h b/iw.h
index e712c59..d658350 100644
--- a/iw.h
+++ b/iw.h
@@ -102,7 +102,9 @@ struct chandef {
 	enum nl80211_chan_width width;
 
 	unsigned int control_freq;
+	unsigned int control_freq_offset;
 	unsigned int center_freq1;
+	unsigned int center_freq1_offset;
 	unsigned int center_freq2;
 };
 
@@ -207,7 +209,8 @@ int parse_hex_mask(char *hexmask, unsigned char **result, size_t *result_len,
 unsigned char *parse_hex(char *hex, size_t *outlen);
 
 int parse_keys(struct nl_msg *msg, char **argv[], int *argc);
-int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv, int *parsed);
+int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
+		    int *parsed, bool freq_in_khz);
 enum nl80211_chan_width str_to_bw(const char *str);
 int parse_txq_stats(char *buf, int buflen, struct nlattr *tid_stats_attr, int header,
 		    int tid, const char *indent);
diff --git a/mesh.c b/mesh.c
index 0fb98a3..40e5e5e 100644
--- a/mesh.c
+++ b/mesh.c
@@ -485,7 +485,7 @@ static int join_mesh(struct nl80211_state *state,
 		int err, parsed;
 
 		err = parse_freqchan(&chandef, false, argc - 1, argv + 1,
-				     &parsed);
+				     &parsed, false);
 		if (err)
 			return err;
 
diff --git a/ocb.c b/ocb.c
index fc9579b..ee0eedf 100644
--- a/ocb.c
+++ b/ocb.c
@@ -16,7 +16,7 @@ static int join_ocb(struct nl80211_state *state,
 	if (argc < 2)
 		return 1;
 
-	err = parse_freqchan(&chandef, false, argc, argv, &parsed);
+	err = parse_freqchan(&chandef, false, argc, argv, &parsed, false);
 
 	if (err)
 		return err;
diff --git a/phy.c b/phy.c
index 0a57ecb..f3ca5f8 100644
--- a/phy.c
+++ b/phy.c
@@ -191,7 +191,7 @@ static int handle_freq(struct nl80211_state *state, struct nl_msg *msg,
 	struct chandef chandef;
 	int res;
 
-	res = parse_freqchan(&chandef, false, argc, argv, NULL);
+	res = parse_freqchan(&chandef, false, argc, argv, NULL, false);
 	if (res)
 		return res;
 
@@ -209,6 +209,31 @@ COMMAND(set, freq,
 	"<control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]]",
 	NL80211_CMD_SET_WIPHY, 0, CIB_NETDEV, handle_freq, NULL);
 
+static int handle_freq_khz(struct nl80211_state *state, struct nl_msg *msg,
+		       int argc, char **argv,
+		       enum id_input id)
+{
+	struct chandef chandef;
+	int res;
+
+	res = parse_freqchan(&chandef, false, argc, argv, NULL, true);
+	if (res)
+		return res;
+
+	return put_chandef(msg, &chandef);
+}
+
+COMMAND(set, freq_khz,
+	"<freq> [1MHz|2MHz|4MHz|8MHz|16MHz]\n"
+	"<control freq> [1|2|4|8|16] [<center1_freq> [<center2_freq>]]",
+	NL80211_CMD_SET_WIPHY, 0, CIB_PHY, handle_freq_khz,
+	"Set frequency in kHz the hardware is using\n"
+	"configuration.");
+COMMAND(set, freq_khz,
+	"<freq> [1MHz|2MHz|4MHz|8MHz|16MHz]\n"
+	"<control freq> [1|2|4|8|16] [<center1_freq> [<center2_freq>]]",
+	NL80211_CMD_SET_WIPHY, 0, CIB_NETDEV, handle_freq_khz, NULL);
+
 static int handle_chan(struct nl80211_state *state, struct nl_msg *msg,
 		       int argc, char **argv,
 		       enum id_input id)
@@ -216,7 +241,7 @@ static int handle_chan(struct nl80211_state *state, struct nl_msg *msg,
 	struct chandef chandef;
 	int res;
 
-	res = parse_freqchan(&chandef, true, argc, argv, NULL);
+	res = parse_freqchan(&chandef, true, argc, argv, NULL, false);
 	if (res)
 		return res;
 
@@ -288,9 +313,9 @@ static int handle_cac_trigger(struct nl80211_state *state,
 		return 1;
 
 	if (strcmp(argv[0], "channel") == 0) {
-		res = parse_freqchan(&chandef, true, argc - 1, argv + 1, NULL);
+		res = parse_freqchan(&chandef, true, argc - 1, argv + 1, NULL, false);
 	} else if (strcmp(argv[0], "freq") == 0) {
-		res = parse_freqchan(&chandef, false, argc - 1, argv + 1, NULL);
+		res = parse_freqchan(&chandef, false, argc - 1, argv + 1, NULL, false);
 	} else {
 		return 1;
 	}
@@ -334,9 +359,9 @@ static int handle_cac(struct nl80211_state *state,
 		return 1;
 
 	if (strcmp(argv[2], "channel") == 0) {
-		err = parse_freqchan(&chandef, true, argc - 3, argv + 3, NULL);
+		err = parse_freqchan(&chandef, true, argc - 3, argv + 3, NULL, false);
 	} else if (strcmp(argv[2], "freq") == 0) {
-		err = parse_freqchan(&chandef, false, argc - 3, argv + 3, NULL);
+		err = parse_freqchan(&chandef, false, argc - 3, argv + 3, NULL, false);
 	} else {
 		err = 1;
 	}
diff --git a/util.c b/util.c
index 8a2ba10..9c389c9 100644
--- a/util.c
+++ b/util.c
@@ -483,7 +483,7 @@ enum nl80211_chan_width str_to_bw(const char *str)
 }
 
 static int parse_freqs(struct chandef *chandef, int argc, char **argv,
-		       int *parsed)
+		       int *parsed, bool freq_in_khz)
 {
 	uint32_t freq;
 	char *end;
@@ -536,7 +536,14 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
 		return 1;
 	*parsed += 1;
 
-	chandef->center_freq1 = freq;
+	if (freq_in_khz) {
+		chandef->center_freq1 = freq / 1000;
+		chandef->center_freq1_offset = freq % 1000;
+	}
+	else {
+		chandef->center_freq1 = freq;
+		chandef->center_freq1_offset = 0;
+	}
 
 	if (!need_cf2)
 		return 0;
@@ -550,7 +557,11 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
 	freq = strtoul(argv[2], &end, 10);
 	if (*end)
 		return 1;
-	chandef->center_freq2 = freq;
+
+	if (freq_in_khz)
+		chandef->center_freq2 = freq / 1000;
+	else
+		chandef->center_freq2 = freq;
 
 	*parsed += 1;
 
@@ -567,6 +578,7 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
  * @argv: Array of string arguments
  * @parsed: Pointer to return the number of used arguments, or NULL to error
  *          out if any argument is left unused.
+ * @freq_in_khz: Boolean whether to parse the frequency in kHz or default as MHz
  *
  * The given chandef structure will be filled in from the command line
  * arguments. argc/argv will be updated so that further arguments from the
@@ -590,7 +602,7 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
  * Return: Number of used arguments, zero or negative error number otherwise
  */
 int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
-		   int *parsed)
+		   int *parsed, bool freq_in_khz)
 {
 	char *end;
 	static const struct chanmode chanmode[] = {
@@ -630,9 +642,30 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 		  .width = NL80211_CHAN_WIDTH_320,
 		  .freq1_diff = 0,
 		  .chantype = -1 },
+		{ .name = "1MHz",
+		  .width = NL80211_CHAN_WIDTH_1,
+		  .freq1_diff = 0,
+		  .chantype = -1 },
+		{ .name = "2MHz",
+		  .width = NL80211_CHAN_WIDTH_2,
+		  .freq1_diff = 0,
+		  .chantype = -1 },
+		{ .name = "4MHz",
+		  .width = NL80211_CHAN_WIDTH_4,
+		  .freq1_diff = 0,
+		  .chantype = -1 },
+		{ .name = "8MHz",
+		  .width = NL80211_CHAN_WIDTH_8,
+		  .freq1_diff = 0,
+		  .chantype = -1 },
+		{ .name = "16MHz",
+		  .width = NL80211_CHAN_WIDTH_16,
+		  .freq1_diff = 0,
+		  .chantype = -1 },
+
 	};
 	const struct chanmode *chanmode_selected = NULL;
-	unsigned int freq;
+	unsigned int freq, freq_offset = 0;
 	unsigned int i;
 	int _parsed = 0;
 	int res = 0;
@@ -642,7 +675,14 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 
 	if (!argv[0])
 		goto out;
+
 	freq = strtoul(argv[0], &end, 10);
+
+	if (freq_in_khz) {
+		freq_offset = freq % 1000;
+		freq = freq / 1000;
+	}
+
 	if (*end) {
 		res = 1;
 		goto out;
@@ -659,8 +699,10 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 		freq = ieee80211_channel_to_frequency(freq, band);
 	}
 	chandef->control_freq = freq;
+	chandef->control_freq_offset = freq_offset;
 	/* Assume 20MHz NOHT channel for now. */
 	chandef->center_freq1 = freq;
+	chandef->center_freq1_offset = freq_offset;
 
 	/* Try to parse HT mode definitions */
 	if (argc > 1) {
@@ -673,9 +715,20 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 		}
 	}
 
+	/* Set channel width's default value */
+	if (chandef->control_freq < 1000)
+		chandef->width = NL80211_CHAN_WIDTH_16;
+	else
+		chandef->width = NL80211_CHAN_WIDTH_20_NOHT;
+
 	/* channel mode given, use it and return. */
 	if (chanmode_selected) {
 		chandef->center_freq1 = get_cf1(chanmode_selected, freq);
+
+		/* For non-S1G frequency */
+		if (chandef->center_freq1 > 1000)
+			chandef->center_freq1_offset = 0;
+
 		chandef->width = chanmode_selected->width;
 		goto out;
 	}
@@ -684,7 +737,7 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 	if (chan)
 		goto out;
 
-	res = parse_freqs(chandef, argc - 1, argv + 1, &_parsed);
+	res = parse_freqs(chandef, argc - 1, argv + 1, &_parsed, freq_in_khz);
 
  out:
 	/* Error out if parsed is NULL. */
@@ -700,6 +753,9 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 int put_chandef(struct nl_msg *msg, struct chandef *chandef)
 {
 	NLA_PUT_U32(msg, NL80211_ATTR_WIPHY_FREQ, chandef->control_freq);
+	NLA_PUT_U32(msg,
+		    NL80211_ATTR_WIPHY_FREQ_OFFSET,
+		    chandef->control_freq_offset);
 	NLA_PUT_U32(msg, NL80211_ATTR_CHANNEL_WIDTH, chandef->width);
 
 	switch (chandef->width) {
@@ -732,6 +788,11 @@ int put_chandef(struct nl_msg *msg, struct chandef *chandef)
 			    NL80211_ATTR_CENTER_FREQ1,
 			    chandef->center_freq1);
 
+	if (chandef->center_freq1_offset)
+		NLA_PUT_U32(msg,
+			    NL80211_ATTR_CENTER_FREQ1_OFFSET,
+			    chandef->center_freq1_offset);
+
 	if (chandef->center_freq2)
 		NLA_PUT_U32(msg,
 			    NL80211_ATTR_CENTER_FREQ2,

base-commit: d6fd2757f7aab638022ffa635e32e21594ec382d
-- 
2.25.1

