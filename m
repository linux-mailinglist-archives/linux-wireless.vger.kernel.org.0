Return-Path: <linux-wireless+bounces-24279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA01AE1501
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 09:33:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B2A919E4D22
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 07:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD3C71F8756;
	Fri, 20 Jun 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fwf67jOW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30FD17583
	for <linux-wireless@vger.kernel.org>; Fri, 20 Jun 2025 07:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750404803; cv=none; b=ZeX41ioQcQvreXPu0G7Aw9ymAYyi+7sTcYR9sfzV2IJmyBhRlrum7oqcLCzYBbEUHY46s7LjtGwNKm/iSZ00RjwYGJyUudeiodtX320V7YcxCo/w82iipWf7uu4sirw8AYr34HwcHeGLn6crlmzvDY17uNSj4LoNCqjJ7UyLlLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750404803; c=relaxed/simple;
	bh=VTkDIP5BBZP/E3K5zPz/wimbEm4CUiHHmfqDxQo3Vh4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ljr5P/FJiuIfdLv38RcBMsMOevgnJr56vRpSokJ+uGpveB5XLpIqbbZuOtp/5/FlhTRt0fi1ID0O3Ga2lOVIkcBdUprM50BG93GVcJ/sDF+xtLeT6qouvtbKU0KiP14xk3ierA6W/vHVSrqfEQ9ICNWTyyQhzFPir8bFfNo0MfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fwf67jOW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55K4Ve7q018578;
	Fri, 20 Jun 2025 07:33:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=KTTWLtuLGcAkKBXYjKvX5T
	vIDsH5pPMVis7kh8CUUMw=; b=Fwf67jOWTExO8IaexRja4xQkPSBIiNHY+tUua1
	jSoqRn7oYqacON3vXV6fuyfEKKLEnP3WGuu5SrKkv4IPh0C9D36xI3s+NUC9+Fbz
	KD39KitFhYYEqKBJZyJT3joEJHctamCDikrsxne77VyHF4wpByOhLv2E+XtJekm8
	3POwiVfsKIwIisVSpZSIv6g3wxO+HzB3Ftc7Lky4khwDyXfPOvONXPwq/l+cC9Pp
	/KpAD8QrW3EG3VHa3VP8uCQtDRdosRowTg8bwqSOZ9L57vXSCAGuE2WuOEyzD7W4
	D7wV6laXE0qkKKUM/uUY4m3hDp2MNq4RXNaz0twz48dSGSnQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 47d0pcgesv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 07:33:14 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 55K7XDDu028751
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Jun 2025 07:33:13 GMT
Received: from hu-surapk-blr.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 20 Jun 2025 00:33:11 -0700
From: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
To: <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>,
        Pradeep Kumar Chitrapu
	<quic_pradeepc@quicinc.com>,
        Suraj P Kizhakkethil <quic_surapk@quicinc.com>
Subject: [PATCH] iw: add support to parse 6 GHz channel
Date: Fri, 20 Jun 2025 13:02:40 +0530
Message-ID: <20250620073240.2770468-1-quic_surapk@quicinc.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: _HGgONMOAABVAw0w-o7p77Jgg8MU9Jux
X-Authority-Analysis: v=2.4 cv=YKyfyQGx c=1 sm=1 tr=0 ts=68550eba cx=c_pps
 a=ouPCqIW2jiPt+lZRy3xVPw==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=GEpy-HfZoHoA:10 a=6IFa9wvqVegA:10 a=COk6AnOGAAAA:8 a=dU3wDXb4suEuto-h_AsA:9
 a=+jEqtf1s3R9VXZ0wqowq2kgwd+I=:19 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-GUID: _HGgONMOAABVAw0w-o7p77Jgg8MU9Jux
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIwMDA1NSBTYWx0ZWRfX+7ibxU8KOUpd
 /jiipykuRTDh6D4x7d2GfpJqiBb8IeKmab/Fq8hrZQeXdxjLZHBjuhTeLfgbVwkQm5vYzhEu0Bo
 6LQyYxPKpRKYp7V1fHIPVIbEWfmCqGKUvcv9xGYTlgcrLqzwAXarCUsy2pz1K2R+h84aAQFtoYa
 YsquZPTvcAneu5gt8M9UEv0uCUyRWJbNSHEpjL6qlwWRP0GkV+gnHOlFM6Ivwx4/laWSxZ//iEh
 ZqoAksi317/z7yY5r3GRrJxkHwl1kMVlkEek0w+Sx0G7amBwuBOUnbxXjoEnNpqYSlJ/zm8Gfum
 uqMzNMOmJ58Occk/HZzNxZVv3u3gKy1pxCJ4Wmxv/Vr+xkLSpwYgU5WoQrZeg9grqJ8/LAlliEm
 iS9tc75tA3ugwLxffT9Ig17QUGM2jVA7Y7nHVtsBr4rG2VgjgwxUI23+q0/k6aA5kQaeDX5V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-20_02,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 malwarescore=0 mlxlogscore=999 phishscore=0 suspectscore=0 clxscore=1011
 lowpriorityscore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506200055

From: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>

Currently, 6 GHz band channel parsing is not supported for
set/switch channel commands. Channel numbers of 6 GHz band
overlaps with those of 2 GHz or 5 GHz bands and therefore needs
additional argument to indicate 6 GHz band. Add support to
parse 6 GHz channels for set/switch channel commands by an
optional argument "6GHz" in the set/switch channel commands.

Examples:

For 6 GHz band,
iw dev wlan0 set channel 49 6GHz 80MHz

For 5 GHz band,
iw dev wlan0 set channel 36 80MHz

Signed-off-by: Pradeep Kumar Chitrapu <quic_pradeepc@quicinc.com>
Signed-off-by: Suraj P Kizhakkethil <quic_surapk@quicinc.com>
---
 interface.c |  6 ++++--
 iw.h        |  2 +-
 util.c      | 14 ++++++++++----
 3 files changed, 15 insertions(+), 7 deletions(-)

diff --git a/interface.c b/interface.c
index 0d4ff04..0bddda2 100644
--- a/interface.c
+++ b/interface.c
@@ -771,8 +771,10 @@ COMMAND(switch, freq,
 	"<control freq> [5|10|20|40|80|80+80|160] [<center1_freq> [<center2_freq>]] [beacons <count>] [block-tx]",
 	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_freq,
 	"Switch the operating channel by sending a channel switch announcement (CSA).");
-COMMAND(switch, channel, "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [beacons <count>] [block-tx]",
-	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_chan, NULL);
+COMMAND(switch, channel, "<channel> [6GHz] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz] [beacons <count>] [block-tx]",
+	NL80211_CMD_CHANNEL_SWITCH, 0, CIB_NETDEV, handle_chan,
+	"Switch the operating channel by sending a channel switch announcement (CSA)."
+	"6 GHz channels expects '6GHz' in argument. Defaults to 5 GHz or 2 GHz channels");
 
 
 static int toggle_tid_param(const char *argv0, const char *argv1,
diff --git a/iw.h b/iw.h
index a423431..e0f548d 100644
--- a/iw.h
+++ b/iw.h
@@ -229,7 +229,7 @@ int parse_keys(struct nl_msg *msg, char **argv[], int *argc);
 	pfx _PARSE_FREQ_KHZ_ARGS_OPT1 sfx "\n" \
 	pfx _PARSE_FREQ_KHZ_ARGS_OPT2 sfx
 #define PARSE_CHAN_ARGS(pfx) \
-	pfx "<channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz|320MHz] [punct <bitmap>]"
+	pfx "<channel> [6GHz] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz|320MHz] [punct <bitmap>]"
 int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 		    int *parsed, bool freq_in_khz);
 enum nl80211_chan_width str_to_bw(const char *str);
diff --git a/util.c b/util.c
index 3345d95..8bf1c7f 100644
--- a/util.c
+++ b/util.c
@@ -593,7 +593,8 @@ static int parse_freqs(struct chandef *chandef, int argc, char **argv,
  * user by giving "NOHT" instead.
  *
  * The working specifier if chan is set are:
- *   <channel> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz|320MHz]
+ *   <channel> [6GHz] [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz|320MHz]
+ * channel number defaults to 5 GHz or 2 GHz band unless 6GHz is specified.
  *
  * And if frequency is set:
  *   <freq> [NOHT|HT20|HT40+|HT40-|5MHz|10MHz|80MHz|160MHz|320MHz]
@@ -697,7 +698,12 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 	if (chan) {
 		enum nl80211_band band;
 
-		band = freq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		if (argc > 1 && strcasecmp(argv[1], "6GHz") == 0) {
+			band = NL80211_BAND_6GHZ;
+			_parsed += 1;
+		} else {
+			band = freq <= 14 ? NL80211_BAND_2GHZ : NL80211_BAND_5GHZ;
+		}
 		freq = ieee80211_channel_to_frequency(freq, band);
 	}
 	chandef->control_freq = freq;
@@ -707,9 +713,9 @@ int parse_freqchan(struct chandef *chandef, bool chan, int argc, char **argv,
 	chandef->center_freq1_offset = freq_offset;
 
 	/* Try to parse HT mode definitions */
-	if (argc > 1) {
+	if ((argc - _parsed) > 0) {
 		for (i = 0; i < ARRAY_SIZE(chanmode); i++) {
-			if (strcasecmp(chanmode[i].name, argv[1]) == 0) {
+			if (strcasecmp(chanmode[i].name, argv[_parsed]) == 0) {
 				chanmode_selected = &chanmode[i];
 				_parsed += 1;
 				break;

base-commit: 1558e6021ec5ae0f6fcb1c31e20d0d4dacebd82b
-- 
2.34.1


