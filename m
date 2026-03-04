Return-Path: <linux-wireless+bounces-32444-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLW/E4Pcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32444-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:23 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C05F81FB7A6
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 020673092B9C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A278C344DA8;
	Wed,  4 Mar 2026 07:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BSBD7vxd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="atnEvCU8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395E62C9D
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608591; cv=none; b=bOyNHggChgJzEBf5EJrT3On4xVOHo9YU3D9fCnOXa1RjJGSfd63eTMRZojzIWVYxQszL9GnS8FVjfZUQ9ipVn9dg1HgH9q2gEO7XbiEmWl4RInX0yQ5HHxutookHgxj1XTY6LJlX7Y6uQ2vFSyUNidWSdGRVeNuA5TQNCMif8x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608591; c=relaxed/simple;
	bh=6SRx3/tyXm4pIaLv4xcuEVxp1D4KbtwhTjlE08D7A3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qVWYkJqh+NY2qs83iF7+IxARBTtgC/nR979uZamvwq5e/PNhm9YIsJWygd5UCF438pOF/+dhcDRDbTFuKEfDXxlQ8KdtIjb+J/bsk79wLIUiZAbkpos4TpUFNETgtcRYY9WOY16o9VO1Os7UOvlM1/CAHEgG8l+/U/Tn4FFjbsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BSBD7vxd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=atnEvCU8; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245UAk53114139
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gqz+HtkXh0L
	Uja8OrJa3Aw/tRjNVr373QSejJW14PHY=; b=BSBD7vxdvNkXD6+5rTIVx/tHjR4
	2thh5hTqV/Ej9Sp05Vme+1YZfhvfcSwrmOKTpyaTaJrjH9q87VcR3WFbOo5XraNp
	X4q6TCz/PdeI1H+oyNKWXz7Ox32HwdirRLuSutFBkMM0lpNVH8196n2OKThi+uaB
	i/wNG+YwMijoLtGIcey5Pz/WDXeRG/3dL9oX3oALt9VelH5kD9pAOw1aLxMbcGXD
	KR+UCoViiQsJouS0q+tmEbi1wPzftEzOeNVW/yLm2CU2jJU+GVdM+ks7AboG/ZKe
	3nyGBWXQVC1KiFtix0SVQkJyGRWYPU3SByLBnZtj8MZnQPY+Gp8cb06RheA==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2a43u-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:29 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8230d6d54a5so5601622b3a.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608588; x=1773213388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gqz+HtkXh0LUja8OrJa3Aw/tRjNVr373QSejJW14PHY=;
        b=atnEvCU8hEZt2P4T99MdOxdIuVABCP64a5SglwQYc9txzqRnfbAA/CmXckoL9TDC2E
         ZvXNgjo27M0/bPltOb6KT1NeQCO1jQM46dMYNXwzKnBekti51Br2tKzYbXkVmuk1i5nx
         JMqNh4CMwPbKfoZIYV2rW9xll4N4JyFheeVfyMPSFDn5zZqtR7+00wFEyWOAyONqwsGP
         H9PKL9dN4EZp56f5gUry7eCtGevx5Mh1I9JTLP5x6GFk0NuFqCdyOBPRJnudcAvMgnTq
         BdAhU7eVOqmSunrQVOXJfcKD0QL0unDQACeEb/MpqkH+Floumr/aZ3689/y/khVEFECO
         67Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608588; x=1773213388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gqz+HtkXh0LUja8OrJa3Aw/tRjNVr373QSejJW14PHY=;
        b=JRBuPghxcQNwNAYRPOcZgenH/k7yuERk4MTJSin1TCkzzzu4DIKhKP755qpEH6g5WS
         GR2xHNq898o7A5JL+KpT/NVqqrz/KRztnv9InX+k+uX5+rB8OCa3MCEpSm/0bCFwCqtY
         P9rg82JkaTBJ3wa5KP/voaoUUDlChA4kppYBC8XYQKyjuMU3myuBMxCd8JyPuZoQugNH
         EwcI7aEDyBiOUSsduQ+HBfWPXHjUopw34ABKqVF5CADhYpRHcFU0hLURns37gdIrihCS
         nq4iDUanxEVKzTigNXAJkwXXwy0P/RlgZFzVVpP4U14Yh8GVfaTnTxv1ItuPnFew+eYx
         4ulg==
X-Gm-Message-State: AOJu0Yw7JjXnvWM9HdPBfArnwW9/DGTt8FFSCf5MLHOEjDzcT8TN1y/+
	SrnFFHuSVARYRzdBKD/3++aWE3YjRn/2QYk6LOn3Usl+WoMc/3vxol50IURpIyw50WiSck5w1dF
	2+Txzi+Lh9RTTsOdVJPxJ7em5HUcfzZSTUj7QmGlpN6uSAsVQ4TV6ylHlH7eXZXJUPnEBJfxGYh
	k1
X-Gm-Gg: ATEYQzylsdgHMrjb39ZLlvhWspBfDtONw8HMzo+vT5V3i2j+BH0972O3V5wulPDIf3w
	x0rPB/TYJ6WNw6LghGzAwGaMkzFzCfZDHJXzyVrz/ljIB/I5lX78ZaP/kDRpmTT5uDki4GWF4M1
	RmSOIq2HrawNMtq9ghgmSkzj+i3AdyWwh5h9pKWILGr3z5CZ+HnE91Vy/6asGtFkWeyDUwKJiiW
	vH5/VVtJg4rXQcGwrPWFcvLW1Oe6r8P8Wp3adjP+YxkjoMDqDxxr3X8ywOJuATBw3O6IFJZm6UA
	TWnVoIPe5s28fNJuH94uplVehJNPo95Xsta00ds9sCS3iXopqdeCKGGEl4O4x9sPsmzQRaeLiSq
	E+KefUZPfgx+2BbjM/ck6uK40SUaeLDzzf0QJjhcJ+qRqJqu8GaSCzCo=
X-Received: by 2002:a05:6a20:734a:b0:35f:14ae:4a7a with SMTP id adf61e73a8af0-39814396072mr4792668637.13.1772608588513;
        Tue, 03 Mar 2026 23:16:28 -0800 (PST)
X-Received: by 2002:a05:6a20:734a:b0:35f:14ae:4a7a with SMTP id adf61e73a8af0-39814396072mr4792650637.13.1772608588046;
        Tue, 03 Mar 2026 23:16:28 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:27 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 08/16] wifi: cfg80211: extend PMSR FTM response for proximity ranging
Date: Wed,  4 Mar 2026 12:45:30 +0530
Message-Id: <20260304071538.3833062-9-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
References: <20260304071538.3833062-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7dc4d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=TvsjVELUdtmmqoM0DT0A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: AdpCXGH1VYXqkoPgFjPOtqEtlCKHLtGJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX0CNhXj5jWIdo
 pyhzvAr6UYmrq2GJJcoG+iuDyS0GKqU37LEUuDsX5d0wY2RXyId+LPvPJ3eH7wO/anqHlJCIsAG
 ay88kVbVc0h/b2iatyF3FXb0zoA8QLiAGnGpK75bocfDu+Npwy7QEFPzN3u65bgfGv6ZfPshmSP
 z9bUJnnHKm9JBxQgf30wgZqlNRkmc8WqGZ9svrml3OKmniLFxWA6cPSa3XZhc7ZHAp/pIYfpWIN
 UliZvFLY0N9vSp+NJBLf4NM8XtkXsDirVuICwSAnfwFu5I8mC72gUt3z7jqGFdxsfGWQnLZ2ZQl
 jNdHulxym3PSZySTQxW483hkpMQbxz+3/t9aVprq8oFDisrmC1zaU+hq4NN0FgkPkQ6pFhMfsTI
 vkogv7Iw2z1IrgDVkeZjxGWGWk3pmS51qxbkiLYv9d0AYcGtM2WM8eIizkGqbz2oBzG6XFWMMdj
 WZ72M/cKUlRiaq6auhw==
X-Proofpoint-GUID: AdpCXGH1VYXqkoPgFjPOtqEtlCKHLtGJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: C05F81FB7A6
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32444-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
index 4ae25b946111..a230bb95f5e3 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -518,6 +518,22 @@ static int nl80211_pmsr_send_ftm_res(struct sk_buff *msg,
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


