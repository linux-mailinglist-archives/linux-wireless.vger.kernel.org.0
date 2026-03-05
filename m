Return-Path: <linux-wireless+bounces-32557-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCjIFRSsqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32557-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:16 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF54215416
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5EEAE301A6B2
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAFE3CD8A2;
	Thu,  5 Mar 2026 16:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mx3Gj0Z9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="M+ionvru"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 547263CE48F
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726889; cv=none; b=c0rFFvChRnlt9BBnlQ6ZxEj2D9hLUeM6X4XjkdM5B4cWjQ/ggAjIdWRoZWBKmAMuEi5OnqGcttZuKmxvJt7TOzv+mmmc+/xREnCDSfdK133bML0qxqkSZ928r2LIu3HYtKnZC6tibVIXXSY9XmgoLCz3Lzu4O4Mz6vLqX6qgw84=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726889; c=relaxed/simple;
	bh=pn+UsDyfh49qpBxMmsDbBqxFFCAcdOJwFvm1RyKqE+c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eTHHVXnAz++Ya611xXDbCEogiwoEkBh8Hpoq92hg0SeHFoAILH9vHfQoXdt/pKG7jmMPM/4voeJVBCM++RQZwupKQJb24XvZYRUllEWjBpaQdLDCh7EyiNhvJE8HTivktmL5+c/2CGtmn5cQAx4iP5KBtpXOwv5hZBCoB5nn3vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mx3Gj0Z9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=M+ionvru; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFuvA936376
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=B2fvffiiJ0B
	BqGaJ99NG+HwT5g1s9oIubQOBhair518=; b=mx3Gj0Z9Yk7RnMEgHj1aQIGcbkQ
	pBe5ehXsn5iSMzCBX0CtDBdmOKcwZXJErwsMg2EAg9uBie0n+z7So27rhvjUugZI
	tDZqJKix/gf4RtSn7ssSdu+Y8RCK6x62G6WMqPk53JfMXZvMM/RFPEYj0ZZ27Xud
	Sr2WQmgNveT02ZiE2Tt0WDkXWuGBvadH5In+EXjuozOljJCadkQZTzRkF435wXVx
	361i4nYEDVo6IanDNXBRMwLGgYdBCPvLNjxe4kRNTc9Djnl6GIdTYKla3W05vP8i
	MktNLya/Qe8q0NbEvdo0cMEKo7wZ2cczVi0+3XBY9M8lNVxYM+T1ngkdUaQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u2s37-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:06 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2adc527eaf5so45744165ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726886; x=1773331686; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B2fvffiiJ0BBqGaJ99NG+HwT5g1s9oIubQOBhair518=;
        b=M+ionvruGbMtir0seBTBF8ubRf2J0zCSM+v6p3Qr/YMI9DirArfn/xXZi9InSBJAad
         x2mm97Q0NQQRiGZFM9O0Iz63h8BFiLb6mf6j2z3aToTysllM2acJJ/JSTp+mNmmR7rSR
         jmx7QRLRdmuP4fpsk8vlHzqA8ctom021Piay8Mib4TLfkIs58n0+oj7pQVmd6olENcsA
         qpbJeedz++KJ5mlma9kYiH6qn3LonD0T9v+9CxF4F4qCL1Xdux8wOhnKG3uPdRJCo+5F
         hT9W8b1x3IWI7Mlem5wMz1VGo78VdAgAK4I6IayVZklfN/zO/bTYhPcK4PcbiFgfTHxp
         XQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726886; x=1773331686;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B2fvffiiJ0BBqGaJ99NG+HwT5g1s9oIubQOBhair518=;
        b=YRhXmNh2bR0xqsDtaFBKDPfpYf5wnlFDIjqORjB7+GdXKuHYlYa76cUEWSo+EZAgHz
         vM110AfXtaPPAe+m00Ss4Zu8VJB0V5XU7+J44meSznRZyZIcLtSb3Nn5KeTPrIT+DP1T
         HmTxhphrG8DlZi7U1aXi9G8eijj1WX39DMusj4mWXjgezvHsweouDNB08g5CYZC4x+TF
         jC9+7jXSNMpTH4vd+gpL8tHIir+CBu28ygMLjM0lk3RYy3VP+FRPUvrzZFpnQd0CC1oN
         eVQolKhEtLEVdrH9WgwxeoMUut0Y1KmBk07n51Xrt+yzqXKDig3dx6IGYmr+xoxOUcL3
         8xdw==
X-Gm-Message-State: AOJu0YyqeJAg72EpsE7JKFLgkf1CwxC6orZxk5AcxO4zZbv9/c+z4I//
	iocfdhkf2XQoVBXe0KDe26xKr0mwiHz3pQ+YtAgUHYPoMoici+e0LVpUr+ja6zvdKnwlyfKtUPc
	0x8KVQA6eWvoeoPpUKda2vOR0DL5fsZkbNb5xLxbvd580Kudy7IxKp/lqy3UhFiDm7i6v
X-Gm-Gg: ATEYQzy6Wrn/y1F0kw1xYBb13ZT8/nVI6f7QP+9EYQHWl69M+36Zg9eMaH5Wf9IQMQE
	QxeCakFislDB6yVoH7cQcLf7wa6jbFY/db10k6Lp6Du7VRHUsK9RowJy/gjAZFPgOL3hlZQ+Mpn
	pUEfrt7tZmgQn0KAcprZslaLZuTkm80BbCpsnIPidoe7XmYSDCjxsG7Di/3gFhRQoB1cJe7GIQh
	Dy2ZjfyNjLqehHMNcLFdzPR7NC4F9+LxYEABotOSBTqNkImYd3ppzY1Si0gKxYY4oJD0euyaOhh
	C3K007nnxxXY9Hq081u7e2dehnoiulaXLOUBbwKav3avd2WcJ72CDbWqEAS9qa7N2PpMVFKnmhs
	GZd9aJtiLTag+8BEktpRny+sQVWLZ2Tw9SR8/qEwO14K+12CCHHHchLM=
X-Received: by 2002:a17:902:c952:b0:2ae:4409:5993 with SMTP id d9443c01a7336-2ae8029ddd4mr1442645ad.55.1772726885525;
        Thu, 05 Mar 2026 08:08:05 -0800 (PST)
X-Received: by 2002:a17:902:c952:b0:2ae:4409:5993 with SMTP id d9443c01a7336-2ae8029ddd4mr1442185ad.55.1772726884736;
        Thu, 05 Mar 2026 08:08:04 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:04 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 08/15] wifi: cfg80211: extend PMSR FTM response for proximity ranging
Date: Thu,  5 Mar 2026 21:37:05 +0530
Message-Id: <20260305160712.1263829-9-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
References: <20260305160712.1263829-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: q7t2trrlRhDYjVba5grc3nFKXHh_eRPL
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9aa66 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=TvsjVELUdtmmqoM0DT0A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: q7t2trrlRhDYjVba5grc3nFKXHh_eRPL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX5Ik3aAIIUsAX
 ksf6s81XF6fL0z4SH8xUnaxuNBEwWRHVGKCdetuSTtSDQgYh5Y+MX7lvYdDw+DWHNLeZ/aFcfC1
 y1lnHK6dkpkIGaIUSaz4yG5HVbQip/Jh+2c3IxgIE8RlQ8Mb06+J59slH6YgsN6CXxnMSajNXVO
 3pNt3aq2ELtS1rBbzhimlnS9Gzwiv1AUVNstHr8ZsoDB0PrWESgWNgJDo0pfr2nddRBXvzcqKZC
 QBsrqy8fa7j+yKmfwm2QstgQ6nRSKPzgNiPuFX1qf4PKH10gol0xvPNxS1qQNotuYLZeVFbO6/i
 pSw73sT2xtbAcdSWQx7U+dkF/LUEoPAtO6U23PxLLChS52T2x+BayfdQMksvWvs9DA1ybCIygWX
 ILLJNk4i2CJmlABOxy42HG6859GOkOsSI01+55+7FeMDfLRPNmF0s8YeuBBU9STrO+Vd+7i6So+
 yWx7UZWj5I58Q3Eh+Xw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 4DF54215416
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32557-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Applications need negotiated session parameters to interpret
proximity ranging results and perform post-processing. Currently,
the FTM response lacks LTF repetition counts, time constraints,
spatial stream configuration, and availability window parameters.

Extend the FTM response structure to report these negotiated
parameters, enabling applications to track session configuration
and use them in post-processing to increase ranging precision.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 61 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/nl80211.h | 42 ++++++++++++++++++++++++-
 net/wireless/pmsr.c          | 16 ++++++++++
 3 files changed, 116 insertions(+), 3 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index b66300497312..febd7bf50d88 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4260,6 +4260,27 @@ struct cfg80211_ftm_responder_stats {
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
+ *	100 us) between two consecutive range measurements initiated by the
+ *	ISTA.
+ * @num_tx_spatial_streams: number of Tx space-time streams used in the NDP
+ *	frame during the measurement sounding phase.
+ * @num_rx_spatial_streams: number of Rx space-time streams used in the NDP
+ *	frame during the measurement sounding phase.
+ * @nominal_time: negotiated nominal duration between adjacent availability
+ *	windows in units of milliseconds (u32).
+ * @availability_window: negotiated availability window time used in this
+ *	session in units of milliseconds (u32).
+ * @measurements_per_aw: negotiated number of measurement attempts per
+ *	availability window.
+ * @chan_width: band width used for measurement.
+ * @preamble: preamble used for measurement.
  * @num_ftmr_attempts_valid: @num_ftmr_attempts is valid
  * @num_ftmr_successes_valid: @num_ftmr_successes is valid
  * @rssi_avg_valid: @rssi_avg is valid
@@ -4272,6 +4293,19 @@ struct cfg80211_ftm_responder_stats {
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
+ * @chan_width_valid: @chan_width is valid.
+ * @preamble_valid: @preamble is valid.
+ * @is_delayed_lmr: indicates if the reported LMR is of the current burst or the
+ *	previous burst, flag.
  */
 struct cfg80211_pmsr_ftm_result {
 	const u8 *lci;
@@ -4295,8 +4329,19 @@ struct cfg80211_pmsr_ftm_result {
 	s64 dist_avg;
 	s64 dist_variance;
 	s64 dist_spread;
+	u32 tx_ltf_repetition_count;
+	u32 rx_ltf_repetition_count;
+	u32 max_time_between_measurements;
+	u32 min_time_between_measurements;
+	u32 num_tx_spatial_streams;
+	u32 num_rx_spatial_streams;
+	u32 nominal_time;
+	u32 availability_window;
+	u32 measurements_per_aw;
+	enum nl80211_chan_width chan_width;
+	enum nl80211_preamble preamble;
 
-	u16 num_ftmr_attempts_valid:1,
+	u32 num_ftmr_attempts_valid:1,
 	    num_ftmr_successes_valid:1,
 	    rssi_avg_valid:1,
 	    rssi_spread_valid:1,
@@ -4307,7 +4352,19 @@ struct cfg80211_pmsr_ftm_result {
 	    rtt_spread_valid:1,
 	    dist_avg_valid:1,
 	    dist_variance_valid:1,
-	    dist_spread_valid:1;
+	    dist_spread_valid:1,
+	    tx_ltf_repetition_count_valid:1,
+	    rx_ltf_repetition_count_valid:1,
+	    max_time_between_measurements_valid:1,
+	    min_time_between_measurements_valid:1,
+	    num_tx_spatial_streams_valid:1,
+	    num_rx_spatial_streams_valid:1,
+	    nominal_time_valid:1,
+	    availability_window_valid:1,
+	    measurements_per_aw_valid:1,
+	    chan_width_valid:1,
+	    preamble_valid:1,
+	    is_delayed_lmr:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4dafaf25b0f6..67cc1ce6d2a1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8145,7 +8145,35 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
  * @NL80211_PMSR_FTM_RESP_ATTR_PAD: ignore, for u64/s64 padding only
  * @NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD: actual burst period used by
  *	the responder (similar to request, u16)
- *
+ * @NL80211_PMSR_FTM_RESP_ATTR_TX_LTF_REPETITION_COUNT: negotiated value of
+ *	number of tx ltf repetitions in NDP frames (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_RX_LTF_REPETITION_COUNT: negotiated value of
+ *	number of rx ltf repetitions in NDP frames (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: negotiated value
+ *	where latest time by which the ISTA needs to complete the next round of
+ *	measurements, in units of 10 ms (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: negotiated
+ *	minimum time between two consecutive range measurements initiated by an
+ *	ISTA, in units of 100 us (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_NUM_TX_SPATIAL_STREAMS: number of Tx space-time
+ *	streams used in NDP frames during the measurement sounding phase
+ *	(u32, optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_NUM_RX_SPATIAL_STREAMS: number of Rx space-time
+ *	streams used in the NDP frames during the measurement sounding phase
+ *	(u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_NOMINAL_TIME: negotiated nominal time used in
+ *	this session in milliseconds. (u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_AVAILABILITY_WINDOW: negotiated availability
+ *	window time used in this session, in units of milli seconds.
+ *	(u32, optional)
+ * @NL80211_PMSR_FTM_RESP_ATTR_MEASUREMENTS_PER_AW: negotiated measurements
+ *	per availability window (u32, optional, max value 4)
+ * @NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH: u32 attribute indicating channel
+ *	width used for measurement, see &enum nl80211_chan_width (optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE: u32 attribute indicating the preamble
+ *	type used for the measurement, see &enum nl80211_preamble (optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR: flag, indicates if the
+ *	current result is delayed LMR data.
  * @NUM_NL80211_PMSR_FTM_RESP_ATTR: internal
  * @NL80211_PMSR_FTM_RESP_ATTR_MAX: highest attribute number
  */
@@ -8174,6 +8202,18 @@ enum nl80211_peer_measurement_ftm_resp {
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
+	NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH,
+	NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE,
+	NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_RESP_ATTR,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 7e90dc29b0e5..a0c07fd841d8 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -527,6 +527,22 @@ static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
 	PUTOPT_U64(DIST_AVG, dist_avg);
 	PUTOPT_U64(DIST_VARIANCE, dist_variance);
 	PUTOPT_U64(DIST_SPREAD, dist_spread);
+	PUTOPT(u32, TX_LTF_REPETITION_COUNT, tx_ltf_repetition_count);
+	PUTOPT(u32, RX_LTF_REPETITION_COUNT, rx_ltf_repetition_count);
+	PUTOPT(u32, MAX_TIME_BETWEEN_MEASUREMENTS,
+	       max_time_between_measurements);
+	PUTOPT(u32, MIN_TIME_BETWEEN_MEASUREMENTS,
+	       min_time_between_measurements);
+	PUTOPT(u32, NUM_TX_SPATIAL_STREAMS, num_tx_spatial_streams);
+	PUTOPT(u32, NUM_RX_SPATIAL_STREAMS, num_rx_spatial_streams);
+	PUTOPT(u32, NOMINAL_TIME, nominal_time);
+	PUTOPT(u32, AVAILABILITY_WINDOW, availability_window);
+	PUTOPT(u32, MEASUREMENTS_PER_AW, measurements_per_aw);
+	PUTOPT(u32, CHANNEL_WIDTH, chan_width);
+	PUTOPT(u32, PREAMBLE, preamble);
+	if (res->ftm.is_delayed_lmr &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR))
+		goto error;
 	if (res->ftm.lci && res->ftm.lci_len &&
 	    nla_put(msg, NL80211_PMSR_FTM_RESP_ATTR_LCI,
 		    res->ftm.lci_len, res->ftm.lci))
-- 
2.34.1


