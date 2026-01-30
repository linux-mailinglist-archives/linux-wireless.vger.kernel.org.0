Return-Path: <linux-wireless+bounces-31388-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPf0CeHVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31388-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:37 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690CBC56A
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79FFF303815F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BEFD342C98;
	Fri, 30 Jan 2026 16:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="VEEoQdu6";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MVNHjiwQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9630032B992
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788867; cv=none; b=gWfUZxQoNPAJCgHXxYeH3bR6eh3E3bTMGjzc6UQu6agvY9VW6W6Wude5zKmLh1BxcQwsjq7PnOfPf51WN131GRFYn5M0BNu1ffXbM1OMzXKzWjydHQHQ9Qz7Y18dtzEGV41lu3KoEquQpTXarC0/jSsh58U/L1iy2ARi6mjbLrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788867; c=relaxed/simple;
	bh=HGHJ+Cdh//ull2OixrUV3RkYnBAXnSqwmd9zxO8cjlk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BCotsJoNxClce/MP0RaVIN48bn7pA+OPkqwRmtGHK9EYJdpnMNxWFrWnWT2ctfac8qn5NMIGqrdIYoeAFy1+45F6gp6KfvulVEgs4Z1ghCDTxY7NFwjaAhDPUyZe0Ec6oA6zyk/Hd/xxlBhPSyunGTy6FzZ0jTjr/BFJH9nQCLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=VEEoQdu6; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MVNHjiwQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UCOBwe555437
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	mqi5AoedalQQerPh/+1z7H4r4YlVied7WlAY6tqwKt4=; b=VEEoQdu6u3Rc8d6a
	A7gJ5WOPR8dPrrB9E8h860l7MtQgS7zODZT4lIsSmdIQuZOkkfxTVh4e4POBziRp
	CRtytv7cHl1pnUacnw/7VqHTjMD57LxTwEuZiX0NE+BU95Rue6JElRUicwIXiSju
	QWsVzp9EOJD5oQs4k4KzHMaRUnuhww3b7YS+VMePFVeyHr2c4bwtrmFDpN7JQFCc
	3UHSGng8xfnIKmmTiWE6Wv6ZWY596TcWGeW/DAeymQZWl3330HSS8LE7HJLmkZel
	BJPDz3XJl74QiFiFyTFICGiwoplwdxtgP6dF6//ue507Uy93kb3rB8J2Xdk/2Gx/
	To2YbA==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0p59hwv4-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:04 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c634b862fcfso1427616a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788863; x=1770393663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqi5AoedalQQerPh/+1z7H4r4YlVied7WlAY6tqwKt4=;
        b=MVNHjiwQs+uZqZdnOutqd5UGCq6gNbV3DKkiWSKer5RRJW8Q5NqJ4Pkp8AxyTrkQri
         7o2TpQ7Ou6ksqTaamwy8t1i1Q7EpOo1PlvGnlC0i49VYcJnJkKbeOAb4q3tDcq0FYwSc
         bDk4zlfW7E9/OfH2x1kU7Fnbk6+OcbrSiAisUrhm30gvh6jJWG9epxS9hvjyOlgcyMDa
         P3J6AkfRYy0md+PjGdcty5CLBuiZHF3Y1OYkCTCAJTkzsVd36iM1mNE9cWJD0RnCy2PZ
         LCrncJrf0PFZuHn/VN1yGZSIF1spyr7cYvu+OqUebiDSr4yzF1R38PzuKmdli6Dj/yf8
         p2lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788863; x=1770393663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mqi5AoedalQQerPh/+1z7H4r4YlVied7WlAY6tqwKt4=;
        b=Ue6D7WRmIQO6pUMF/Ygd/xh624tsjPeHocgFXIZ2I9s0kDTKhH7iGvefDUVYzdw+x3
         URz/RTRFt+vmrO3LVdeJ0oY6sbhhJ9mBJ9X0Pl4d4X2MG6981WEhNciEce6rf5+51feF
         ZwPWnQccMreYKv8OuQ1Zz3MUnLnKzdAq3R3iPdl93qEhvf/9WuvxLyHl6KpQ3v2TAUhv
         CH/SZEnv4XYEYR9nSLXuG+R/9weY1TraG+QNnsMYk8EFe5fl4ffDNoOoJNOjzTuGJYmU
         S5Tzq4I2zlHcLCdUTbMsUtD/6wG6SKdN2fLchIlGD8NOM6i5lDvGqvwRQChfezS3MjTE
         vBjQ==
X-Gm-Message-State: AOJu0YzfgllXeSG908alasgF+0g1wDmOLaj1T+BCQgUYoK7f/wOZ+s5m
	2i2vXF0zIKPLz1UNgPq7FwrgZ4VB4HTp9ALiKqclYm8Dmc5A6LoZfOBk3FmLW2bXr8Tulo5uOCm
	SrBEd+69bFg3AmKU7N28lykFdcm795g2ZYKi+Z60e6+XQUC0tlM4oJNTNS4gersDvWDO4edngwn
	LU
X-Gm-Gg: AZuq6aLcw3aOOYNAaZLMqEOFg6l6+YInqbclt2u1e3FV4q4OcirENsdBaHHuHT3lD4k
	lQspykwMOriC8Xo+hiZZXBlFSip1cPaSycgWhzeUW5JDMcbMpFrD+PMWfgAiwGTq6PdV1UIcVyf
	bNgk0IRGqoZUCRTQIzeBBI7Ylu2/MuUmQRVRRc+UYYJG0aduFQaBcLZsYnNjoC1LQQck/V665yA
	sJ7IFfNNTtqLoKl2Dikhk77ghb3FdNJdcz3PVxGv7qPEGkwNQZJk0ApO+bNe9gjguL87y//wFhG
	VrGHKvFj2Ia/H7/QaxUoAZpNIQ4lmQQ9vcacK4lSb6DlalaCs0Q7FOLZMOaGG4MG2YJYYnJkqTt
	XuiMf3oBtC+tRc5qPfJ5e8l5ttjcuHlB751x2xg53cLs=
X-Received: by 2002:a05:6a21:138c:b0:364:af5:d599 with SMTP id adf61e73a8af0-392e0000812mr3709266637.14.1769788862902;
        Fri, 30 Jan 2026 08:01:02 -0800 (PST)
X-Received: by 2002:a05:6a21:138c:b0:364:af5:d599 with SMTP id adf61e73a8af0-392e0000812mr3709185637.14.1769788861842;
        Fri, 30 Jan 2026 08:01:01 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:01 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 04/13] wifi: nl80211/cfg80211: extend PMSR FTM response for proximity ranging
Date: Fri, 30 Jan 2026 21:30:30 +0530
Message-Id: <20260130160039.2823409-5-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: D_YejThZc9-AmkKDLtRUKD4i9vIbCgWl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX86KwbaWsJcAI
 xXBpVGIeSpgFX5WMg+6tJo74tvf0cTU28/R0Q5t2rwVCtI8fHOYBcLu2wWpGjYMi1e0ufnrx97q
 rroqQ8vj8mIP/Uep+/nHL5lrqqDeIaP7DBPLlG/Z7emG7qO2PJhTVWL7UnzjeoGLB8NXATLYCTH
 3oXpubbJ4ftJjGMLF8ows9e1JOaXFjLmT2g7A4I0HmER2czUMTzn0EqEiDp126R450zYuGgaQ0N
 i15qqwfYCZjLD+KJBa9s2HW4nhkdpZxLigyMd9pcbLqvn2LLKYU9sXf/OIJ/r45QhtfDbO0RPUo
 VH08h/QCU25U73SmFzZjPqPNocGd3nvWqGTkP2cLn7aZi0KA/bNLaRqyywI9uqipp4Pg/8H87rA
 BrsLyV6BWJ0OMav4BhCmgpcrSTUJEvJTqTHZPVMzavN0+fpHR6NLLENVnmv6fBv+0yooe3kKHO2
 VsHzXRcCgiaQwTOSkkQ==
X-Proofpoint-GUID: D_YejThZc9-AmkKDLtRUKD4i9vIbCgWl
X-Authority-Analysis: v=2.4 cv=Re+dyltv c=1 sm=1 tr=0 ts=697cd5c0 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=IkcTkHD0fZMA:10 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=EUspDBNiAAAA:8 a=TvsjVELUdtmmqoM0DT0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 clxscore=1011 bulkscore=0
 adultscore=0 impostorscore=0 priorityscore=1501 lowpriorityscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31388-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8690CBC56A
X-Rspamd-Action: no action

Extend the peer measurement FTM response structure to include
negotiated parameters for proximity ranging sessions. This adds
support for reporting LTF repetition counts, time constraints
between measurements, spatial stream configuration, and
availability window parameters.

These parameters allow userspace to understand the negotiated
session configuration for proximity detection and continuous
ranging operations.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 59 +++++++++++++++++++++++++++++++++++-
 include/uapi/linux/nl80211.h | 41 ++++++++++++++++++++++++-
 net/wireless/pmsr.c          | 16 ++++++++++
 3 files changed, 114 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index af357d21f67c..a82d1606345a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4206,6 +4206,27 @@ struct cfg80211_ftm_responder_stats {
  *	(must have either this or @rtt_avg)
  * @dist_variance: variance of distances measured (see also @rtt_variance)
  * @dist_spread: spread of distances measured (see also @rtt_spread)
+ * @tx_ltf_repetition_count: negotiated value of number of tx ltf repetitions
+ *	in NDP frames
+ * @rx_ltf_repetition_count: negotiated value of number of rx ltf repetitions
+ *	in NDP frames
+ * @max_time_between_measurements: the negotiated maximum interval (in units of
+ *	10 ms) by which the ISTA must complete the next measurement cycle.
+ * @min_time_between_measurements: the negotiated minimum interval (in units of
+ *	100 µs) between two consecutive range measurements initiated by the
+ *	ISTA.
+ * @num_tx_spatial_streams: number of Tx space-time streams used in the NDP
+ *	frame during the measurement sounding phase.
+ * @num_rx_spatial_streams: number of Rx space-time streams used in the NDP
+ *	frame during the measurement sounding phase.
+ * @nominal_time: negotiated nominal duration between adjacent availability
+ *	windows in units of milli seconds (u32).
+ * @availability_window: negotiated availability window time used in this
+ *	session (8 bits size, units of 1ms)
+ * @measurements_per_aw: negotiated number of measurement attempts per
+ *	availability window.
+ * @band_width: band width used for measurement.
+ * @preamble: preamble used for measurement.
  * @num_ftmr_attempts_valid: @num_ftmr_attempts is valid
  * @num_ftmr_successes_valid: @num_ftmr_successes is valid
  * @rssi_avg_valid: @rssi_avg is valid
@@ -4218,6 +4239,19 @@ struct cfg80211_ftm_responder_stats {
  * @dist_avg_valid: @dist_avg is valid
  * @dist_variance_valid: @dist_variance is valid
  * @dist_spread_valid: @dist_spread is valid
+ * @tx_ltf_repetition_count_valid: @tx_ltf_repetition_count is valid
+ * @rx_ltf_repetition_count_valid: @rx_ltf_repetition_count is valid
+ * @max_time_between_measurements_valid: @max_time_between_measurements is valid
+ * @min_time_between_measurements_valid: @min_time_between_measurements is valid
+ * @num_tx_spatial_streams_valid: @num_tx_spatial_streams is valid
+ * @num_rx_spatial_streams_valid: @num_rx_spatial_streams is valid
+ * @nominal_time_valid: @nominal_time is valid
+ * @availability_window_valid: @availability_window is valid
+ * @measurements_per_aw_valid: @measurements_per_aw is valid
+ * @band_width_valid: @band_width is valid.
+ * @preamble_valid: @preamble is valid.
+ * @is_delayed_lmr: indicates if the reported LMR is of the current burst or the
+ *	previous burst, flag.
  */
 struct cfg80211_pmsr_ftm_result {
 	const u8 *lci;
@@ -4241,6 +4275,17 @@ struct cfg80211_pmsr_ftm_result {
 	s64 dist_avg;
 	s64 dist_variance;
 	s64 dist_spread;
+	u8 tx_ltf_repetition_count;
+	u8 rx_ltf_repetition_count;
+	u32 max_time_between_measurements;
+	u32 min_time_between_measurements;
+	u8 num_tx_spatial_streams;
+	u8 num_rx_spatial_streams;
+	u32 nominal_time;
+	u8 availability_window;
+	u8 measurements_per_aw;
+	enum nl80211_chan_width band_width;
+	enum nl80211_preamble preamble;
 
 	u16 num_ftmr_attempts_valid:1,
 	    num_ftmr_successes_valid:1,
@@ -4253,7 +4298,19 @@ struct cfg80211_pmsr_ftm_result {
 	    rtt_spread_valid:1,
 	    dist_avg_valid:1,
 	    dist_variance_valid:1,
-	    dist_spread_valid:1;
+	    dist_spread_valid:1,
+	    tx_ltf_repetition_count_valid:1,
+	    rx_ltf_repetition_count_valid:1,
+	    max_time_between_measurements_valid:1,
+	    min_time_between_measurements_valid:1;
+	u16 num_tx_spatial_streams_valid:1,
+	    num_rx_spatial_streams_valid:1,
+	    nominal_time_valid:1,
+	    availability_window_valid:1,
+	    measurements_per_aw_valid:1,
+	    band_width_valid:1,
+	    preamble_valid:1,
+	    is_delayed_lmr:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index e594ccc59021..a3c82b231d82 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8062,7 +8062,34 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
  * @NL80211_PMSR_FTM_RESP_ATTR_PAD: ignore, for u64/s64 padding only
  * @NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD: actual burst period used by
  *	the responder (similar to request, u16)
- *
+ * @NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT: negotiated value of
+ *	number of tx ltf repetitions in NDP frames (u8, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT: negotiated value of
+ *	number of rx ltf repetitions in NDP frames (u8, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: negotiated value
+ *	where latest time by which the ISTA needs to complete the next round of
+ *	measurements, in units of 10 ms (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: negotiated
+ *	minimum time between two consecutive range measurements initiated by an
+ *	ISTA, in units of 100 µs (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS: number of Tx space-time
+ *	streams used in NDP frames during the measurement sounding phase
+ *	(u8, optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS: number of Rx space-time
+ *	streams used in the NDP frames during the measurement sounding phase
+ *	(u8, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME: negotiated nominal time used in
+ *	this session in milli seconds. (u32)
+ * @NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW: negotiated availability
+ *	window time used in this session, in units of 1ms (u8, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW: negotiated measurements
+ *	per availability window (u8, optional, max value 4)
+ * @NL80211_PMSR_FTM_RESP_ATTR_BANDWIDTH: u32 attribute indicating channel
+ *	width used for measurement, see &enum nl80211_chan_width.
+ * @NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE: u32 attribute indicating the preamble
+ *	type used for the measurement, see &enum nl80211_preamble
+ * @NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR: flag, indicates if the
+ *	current result is delayed LMR data.
  * @NUM_NL80211_PMSR_FTM_RESP_ATTR: internal
  * @NL80211_PMSR_FTM_RESP_ATTR_MAX: highest attribute number
  */
@@ -8091,6 +8118,18 @@ enum nl80211_peer_measurement_ftm_resp {
 	NL80211_PMSR_FTM_RESP_ATTR_CIVICLOC,
 	NL80211_PMSR_FTM_RESP_ATTR_PAD,
 	NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD,
+	NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT,
+	NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT,
+	NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS,
+	NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS,
+	NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME,
+	NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW,
+	NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW,
+	NL80211_PMSR_FTM_RESP_ATTR_BANDWIDTH,
+	NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE,
+	NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_RESP_ATTR,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index bee9c6fd2859..141ac19f86c8 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -518,6 +518,22 @@ static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
 	PUTOPT_U64(DIST_AVG, dist_avg);
 	PUTOPT_U64(DIST_VARIANCE, dist_variance);
 	PUTOPT_U64(DIST_SPREAD, dist_spread);
+	PUTOPT(u8, TX_LTF_REPETITION_COUNT, tx_ltf_repetition_count);
+	PUTOPT(u8, RX_LTF_REPETITION_COUNT, rx_ltf_repetition_count);
+	PUTOPT(u32, MAX_TIME_BETWEEN_MEASUREMENTS,
+	       max_time_between_measurements);
+	PUTOPT(u32, MIN_TIME_BETWEEN_MEASUREMENTS,
+	       min_time_between_measurements);
+	PUTOPT(u8, NUM_TX_SPATIAL_STREAMS, num_tx_spatial_streams);
+	PUTOPT(u8, NUM_RX_SPATIAL_STREAMS, num_rx_spatial_streams);
+	PUTOPT(u32, NOMINAL_TIME, nominal_time);
+	PUTOPT(u8, AVAILABILITY_WINDOW, availability_window);
+	PUTOPT(u8, MEASUREMENTS_PER_AW, measurements_per_aw);
+	PUTOPT(u32, BANDWIDTH, band_width);
+	PUTOPT(u32, PREAMBLE, preamble);
+	if (res->ftm.is_delayed_lmr &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR))
+		goto error;
 	if (res->ftm.lci && res->ftm.lci_len &&
 	    nla_put(msg, NL80211_PMSR_FTM_RESP_ATTR_LCI,
 		    res->ftm.lci_len, res->ftm.lci))
-- 
2.34.1


