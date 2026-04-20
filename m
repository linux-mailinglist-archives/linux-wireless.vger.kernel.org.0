Return-Path: <linux-wireless+bounces-35030-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2F5OIGnt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35030-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:01 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEEE428AEA
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:10:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7D508300D35C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E7B38C417;
	Mon, 20 Apr 2026 09:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="I7hjoENc";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="juQa+d8K"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A11D438C41B
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676193; cv=none; b=WQugWOLhZnwehst0UC3NUdHbGa2XqdRpZDdbV8IJmlKVmic1zTo0HBIdfPlYxu4gRBcj3aRyH2bBl6Iuf0Y6ZtgGNiXMu09+sT9jf8lbO3DIBsyaYAYsUHEGBXF8ceuogh+BgrAds45oLIwFm9xHJAruC60k+xL4ZaqII+u3+n0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676193; c=relaxed/simple;
	bh=kkfHnLvwJ6ktnU08AoaNBzqPwcLcJ7K2N4Il8T56oIs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=b6fZx3rCb0WJV+FZtw000a45IImMy4jbxwT5IEgr42zKNljpe1qcE2FlWdlQqvgYtNN5QUSjwM9xPGuygnoL1T/qNzUOvR5nc9vQKQ27fHQI0yjOM5w+/35T0LFhniN8ykBYxlYPg5eQpEgciDIViudpLdcn9srxgcbL+NJwBMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=I7hjoENc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=juQa+d8K; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K97M7a084442
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=iBfQUznOvX2
	09/AHZhPQYEyyUU8E2SdYYnrMXnOZ/OA=; b=I7hjoENc1Nwkh0cDBkE3CY9W/uD
	fuxtOtQnTNACnQHsfdWuhHbkvJNrkZvumOxvmWqiNzNovrlYdGteVlV4a/Dp+LoP
	1YB/K5nZ9KGY197oYzxb6B6//3wZ1H3v2W8oLrLpv3thMF0QKbNIQuv95qU+rOpk
	oU8HdYzp2AH48uS9DYrfW8syGSqF3R0nJsvYFB37QWqPsg+nxx6WM8kkWnfJ0UUh
	X8KMxl37C35XAMVVvAm7bdchnuUzb1BcMYRiG+BXRBX+tzyEp33BjyehKxeGY35r
	odTTlH3e7kA008qWNYCBs5cVBspulb/y0hBxs4oj1WEXWFdqdiYiQSFG4lg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dnh81g0ax-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:50 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b2497cc190so22447045ad.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676189; x=1777280989; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBfQUznOvX209/AHZhPQYEyyUU8E2SdYYnrMXnOZ/OA=;
        b=juQa+d8KXXBMYH2oJbGL58eyUmYqFXmyvS3nv76Rp75HXyWCVSDd8j/qH86EPWK4LZ
         B1J4i076aewp0geQwHBxfkaiV7sXItj/Ok6YTQKSV7MaYgt5FMr0RtG3JnerDaiKiLC0
         lBovbL4pXLLDVWqwK/vGfMORAa1Wb4lw2038ZD35z197+MhktinvpxaHiuSvdvhBhGRe
         6hNZVLzmw3k47TZaRrTDnNp1E+khhzHoPcoJYQ52Qr+Qxw1JgBm+lWVXJqACf6ZQDLwg
         WcYPRcl2MwcDclf/EO92pg1VMpc8KVm6h+otEO4DgJVXVN3C7Kvk1ma7u4t8o28kizzL
         GN0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676189; x=1777280989;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iBfQUznOvX209/AHZhPQYEyyUU8E2SdYYnrMXnOZ/OA=;
        b=mefyZh0WrHg8vHpvxpHrKRpmS+8b1OAyZalYknacnLuf7c5uMM3hM+sVFGZyxDQJVw
         /2Htz5mqHnQFn3dc4IX+n/H63K0sSj1TyaMLgiEYR8g77iViKxwDtM36KvBzw+3o2t7I
         sl2KnFQeSlUlGQ/jSG4oSaKRJEq/P8y2WBTttXbCD8K+25fiSAdbptmuZlOiAJ30JDZt
         dxfNcJu5bAZbiqyHgfB7uTj+58jP60YdAnfhtFzJOhX/1IGR7SfchotI0tvFZFna7wyJ
         XvYmKTMjEb6SYazzaS1ycbsEa3N4VHYWsqHyLx+gvm9FCb+1x6q+djM2XTMvHkbuMNqU
         23xA==
X-Gm-Message-State: AOJu0YyOFzXUG8ZSD3JhtuYrJh44XBJfRWgK3NaATR0OsBVDU+QdT06y
	A2Dm7q75xYNKf2f0lBkCN/qk4/K/7zY/QWGYBZcnY+nldPqUzUAUmtyggFYcvjQnvnrfV2fmKfL
	0FkHSLubnS9SIXPlKW6bZMNmGP4I4KtLvI3PvB3NDnLZUy9g/D6AEAnrbf8RoRhyNcryN
X-Gm-Gg: AeBDiesxwhiDioHE29clRVJNoBVeZcAqBcf4+wbymvS+Y4V0vM8JzBArPyclO1jHz2G
	TXyiXzvBe9bwKb7VucY2uIPE5fnMZ48KTUnvVqGSyZzj+caAeLUnKSyG8dw4FitBuiXDniqm0sj
	jQJRWs642DyVIhulpyEQP27mDaFfPegRMIIWmJuFTR/LtH5FBw1g8CjQoZ6yA0qvaRYy2MNxx3n
	rivqe/rm5z3iT9sCFL6/fUb2QV/cyKfl4EvXjgEI4uwc1y7VV/8Umv30bzA+KUV8Q3YD92MwRMG
	qyXTWRR9PgSwdZExHWyaqBU1XU8rUCiHgMpR6A50if1PuOAMHQpsA31q/mafSjowvAAqD9T3KA7
	NuROTKFd3dKncMT8TZxmNNw06wjJKSQLYePc7nNppqhCnG0tN2YxNhgymlUlDBJFCNA==
X-Received: by 2002:a17:90b:1e10:b0:35f:c156:a82e with SMTP id 98e67ed59e1d1-36140290696mr10795284a91.9.1776676189149;
        Mon, 20 Apr 2026 02:09:49 -0700 (PDT)
X-Received: by 2002:a17:90b:1e10:b0:35f:c156:a82e with SMTP id 98e67ed59e1d1-36140290696mr10795256a91.9.1776676188594;
        Mon, 20 Apr 2026 02:09:48 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:48 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 07/13] wifi: cfg80211: extend PMSR FTM response for proximity ranging
Date: Mon, 20 Apr 2026 14:38:50 +0530
Message-Id: <20260420090856.2152905-8-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
References: <20260420090856.2152905-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfX0EW5UTkpYprB
 7QAEAHLQxzaZvDHFzT848siKPaFF91YGaqFn1QMHKegypbrEbSpaMM54xLYbOACzaGte+XYzitL
 YeIEyfJznXbP55TbeKIzmVuHs605TWK0c2AR6bwUXivvuTr4nkpheug+dGLeid01lVg79fBklae
 jufD6J62A5jkGke0gMVZbzv/SxvYit/VAc5Doe1KLdq/vh7/t4LL58ddItQIpDkXOxRZy0crXv1
 eGoKppdgtsHXFoJlLbcNgtEYPlctLKQBr5k0So9lup5ZSe55EhkB2Ti3xznIGrx/6TY7birm5LW
 m3eUOOZJNG1lyCjm6+IXADZtohP1JBpDBd1Fhcx76dTnexElJhp4COsEthUXzLWFpzK3mu3VZow
 K4eetl/vPWGb7I69KJtBkiYY+LqaT6eHAy0NIa4izF2WvJDXbtK5RNaYe5vROkHeK8fayQZACK0
 V7UC18LF/SfSyuEcO2Q==
X-Proofpoint-GUID: 9y6eXQmS06I4xemBjrPceeZmiAjim9eL
X-Proofpoint-ORIG-GUID: 9y6eXQmS06I4xemBjrPceeZmiAjim9eL
X-Authority-Analysis: v=2.4 cv=PsKjqQM3 c=1 sm=1 tr=0 ts=69e5ed5e cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=b4lw_rM-2rEBNTTdhYAA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 suspectscore=0 phishscore=0 adultscore=0
 bulkscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35030-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CEEE428AEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Applications need negotiated session parameters to interpret
proximity ranging results and perform post-processing. Currently,
the FTM response lacks LTF repetition counts, time constraints,
spatial stream configuration, and availability window parameters.

Extend the FTM response structure to report these negotiated
parameters, enabling applications to track session configuration
and use them in post-processing to increase ranging precision.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 56 ++++++++++++++++++++++++++++++++++--
 include/uapi/linux/nl80211.h | 38 ++++++++++++++++++++++++
 net/wireless/pmsr.c          | 15 ++++++++++
 3 files changed, 107 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ec82ca19470b..4f1f66a137ae 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4433,6 +4433,25 @@ struct cfg80211_ftm_responder_stats {
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
+ *	session in units of milliseconds (u8).
+ * @chan_width: band width used for measurement.
+ * @preamble: preamble used for measurement.
  * @num_ftmr_attempts_valid: @num_ftmr_attempts is valid
  * @num_ftmr_successes_valid: @num_ftmr_successes is valid
  * @rssi_avg_valid: @rssi_avg is valid
@@ -4445,6 +4464,18 @@ struct cfg80211_ftm_responder_stats {
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
+ * @chan_width_valid: @chan_width is valid.
+ * @preamble_valid: @preamble is valid.
+ * @is_delayed_lmr: indicates if the reported LMR is of the current burst or the
+ *	previous burst, flag.
  */
 struct cfg80211_pmsr_ftm_result {
 	const u8 *lci;
@@ -4468,8 +4499,18 @@ struct cfg80211_pmsr_ftm_result {
 	s64 dist_avg;
 	s64 dist_variance;
 	s64 dist_spread;
+	u32 tx_ltf_repetition_count;
+	u32 rx_ltf_repetition_count;
+	u32 max_time_between_measurements;
+	u32 min_time_between_measurements;
+	u8 num_tx_spatial_streams;
+	u8 num_rx_spatial_streams;
+	u32 nominal_time;
+	u8 availability_window;
+	enum nl80211_chan_width chan_width;
+	enum nl80211_preamble preamble;
 
-	u16 num_ftmr_attempts_valid:1,
+	u32 num_ftmr_attempts_valid:1,
 	    num_ftmr_successes_valid:1,
 	    rssi_avg_valid:1,
 	    rssi_spread_valid:1,
@@ -4480,7 +4521,18 @@ struct cfg80211_pmsr_ftm_result {
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
+	    chan_width_valid:1,
+	    preamble_valid:1,
+	    is_delayed_lmr:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4be04dea7938..cb55e8b69097 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8428,6 +8428,33 @@ enum nl80211_peer_measurement_ftm_failure_reasons {
  * @NL80211_PMSR_FTM_RESP_ATTR_PAD: ignore, for u64/s64 padding only
  * @NL80211_PMSR_FTM_RESP_ATTR_BURST_PERIOD: actual burst period used by
  *	the responder (similar to request, u16)
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
+ * @NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH: u32 attribute indicating channel
+ *	width used for measurement, see &enum nl80211_chan_width (optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE: u32 attribute indicating the preamble
+ *	type used for the measurement, see &enum nl80211_preamble (optional).
+ * @NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR: flag, indicates if the
+ *	current result is delayed LMR data.
  *
  * @NUM_NL80211_PMSR_FTM_RESP_ATTR: internal
  * @NL80211_PMSR_FTM_RESP_ATTR_MAX: highest attribute number
@@ -8457,6 +8484,17 @@ enum nl80211_peer_measurement_ftm_resp {
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
+	NL80211_PMSR_FTM_RESP_ATTR_CHANNEL_WIDTH,
+	NL80211_PMSR_FTM_RESP_ATTR_PREAMBLE,
+	NL80211_PMSR_FTM_RESP_ATTR_IS_DELAYED_LMR,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_RESP_ATTR,
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 951ba0b96da2..caffa2421c20 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -562,6 +562,21 @@ static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
 	PUTOPT_U64(DIST_AVG, dist_avg);
 	PUTOPT_U64(DIST_VARIANCE, dist_variance);
 	PUTOPT_U64(DIST_SPREAD, dist_spread);
+	PUTOPT(u32, TX_LTF_REPETITION_COUNT, tx_ltf_repetition_count);
+	PUTOPT(u32, RX_LTF_REPETITION_COUNT, rx_ltf_repetition_count);
+	PUTOPT(u32, MAX_TIME_BETWEEN_MEASUREMENTS,
+	       max_time_between_measurements);
+	PUTOPT(u32, MIN_TIME_BETWEEN_MEASUREMENTS,
+	       min_time_between_measurements);
+	PUTOPT(u8, NUM_TX_SPATIAL_STREAMS, num_tx_spatial_streams);
+	PUTOPT(u8, NUM_RX_SPATIAL_STREAMS, num_rx_spatial_streams);
+	PUTOPT(u32, NOMINAL_TIME, nominal_time);
+	PUTOPT(u8, AVAILABILITY_WINDOW, availability_window);
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


