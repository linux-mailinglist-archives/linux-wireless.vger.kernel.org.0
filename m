Return-Path: <linux-wireless+bounces-32556-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDoQNbqqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32556-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 34592215275
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C4D863101E16
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBCB3C6A48;
	Thu,  5 Mar 2026 16:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="imXU7G91";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="fWogkiPO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 644203CE4B3
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726889; cv=none; b=XQlJGTjRoxPggGlzO4BgkMZD63cXP8ixfFSd3uhM0UnzVVodn+JZepB7CudoPuOwLx1BccOaRjbGSlDGrzQOlgoVHnxCKmQ2EE2eiZrnwxboG80pQ3xS3ZpmTx2twkz3YSzq+2kWsSph6lmn6UVlkLBKFhSU2u55ReGO+LWmlDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726889; c=relaxed/simple;
	bh=PeFPjRKrIwZ+oMB0dKlc1GjyYhsf8TTmSffVndwCaaE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E8wYChxO+HNlBQYnHzswJ8CYV+eH9xNjgI7EjInCoWum8oTLLCW4AwoOwyHrlu4qOiFdb659jc0M3OqrxBpygxWlPl2fewQpmppD/HlDTEGB2ouANsPPQpkds2TEzRi0kvrQDHjGx0zz2S+fSbjRjMFLINBHYFB+BWBhOV84Qtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=imXU7G91; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=fWogkiPO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AUKir169345
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LcoqgJ9IMyk
	JKbhRDamvTOPX8l6mjfxDGyxf1QCV4I8=; b=imXU7G91b2dgJzYn54pQQcodpFM
	PVGx3KlcYFfKIMgR+phD2e2J5eMmgohh9X3sthbWlHBJIO+taX284zTayWPvLAK5
	uCF9ID23WcEskfvtydKdKV/hrSi1P0DGq3orktYC7/YtBcComWGvlSqzsX0fyRDu
	gWMrP3yBzZdZsLuYovdLJ7eR371z007+e5NI87hW/757qHNnTxzABpY2E9a9C7l5
	f3tEX0DhdpaVyNJSRdnj921edhi7YfwELGOKTK/d9KEbh/ozB0xDjyDYC90h+Arx
	y8jWRF/tZgTx05GiVCGG99HFA9Ofopdbq4+0Js4v5yF0Tv1sqVG1FijNNfg==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com [209.85.214.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq84w9194-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:04 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2ae53ec06b0so198846415ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726884; x=1773331684; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LcoqgJ9IMykJKbhRDamvTOPX8l6mjfxDGyxf1QCV4I8=;
        b=fWogkiPOeANiRu2Rvsa0O9k/7srM+t3XJKA/F3blVOKq6IqgxDuoP44jfzY9j/B7rO
         oCLnomCCPVPwWXUb5fd8UR0UfZIWaeApEfhaVwp6vdCskFJD7P49kp/UCa/worALaWh1
         INcV5LKVkc3h2gkFuN07EjRBJhrp5H6wYAMpACje9pEPNagUaYsOktVyMUwzM1IvrREe
         4jZh0NYe59dvo5/+Kx5jSC8beaWcP2laK9tkczULzXE3YpLA5UunDboxg8yYaUpxM0yr
         jpqYYUk+NQ9dT1N+WzdQ3FRwgDuDbt6BAKuuYZ6Dz3+7gng3Pm1GfdFW0H1hNq6rFxeo
         /1Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726884; x=1773331684;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LcoqgJ9IMykJKbhRDamvTOPX8l6mjfxDGyxf1QCV4I8=;
        b=n3xj0AppO6qXc85dXoeulrjxC4ny/ljQEWiJXM2AZmoB/UO/73bwRQH7Kr5N+qFPeX
         Qp+EBSy7meaFRSBtZZ14FYB8jBy2RQAFEwXNhyeHgu6ScF5qAtOXXEylxSCugtFpBmq4
         NpM4sUr0Vy39mu6RXA70tTWp9WM2wMkFwZ+NtjqcQ6rO4HK5MhhBT9S0/e+VgCxi2Euy
         3mKRtEyqgh2BFNHVLujDd4eVFlRE/dY/sGTHTOfrK+PUU4WtMv5FM/r1U7Ux39Pb112m
         bbY9kuSFZMuHe4hS69gka42WW9KjRSHOq+owMYvlgP9E77I4MaXiX7ryy1i+CisNcrb6
         2+6w==
X-Gm-Message-State: AOJu0Yx6AsTo8jvqicLXVkB+Xpiynd+RbOp126o+KgfgzZ0ePG76JDCu
	Buv9hlgxmoEcQ6tTzeT8/EbX+Qy3IeuwRvTfqY0gB481saHpyJUEfrqnN7g7SKTYUtm5/eJc5Y7
	vdt8VaC7GmSCIs29OHwWqucHHcy/oVp/vtQLG064lJY6pvGaadkfbU9P3sLOBipFSAMh2
X-Gm-Gg: ATEYQzwX8bIcxdMnwn29dRtC6BgO3Iwm9+nxEUQAZPvvj0D7FmHZzWHgbhT5frr5gh/
	fw031/0ggSl4k0zGbYFEKYY9JoRFEOrIaEq9okpPd9Lk42UgPj/Is3ercOgUhie8iieiv45vbiW
	CRcqkl35r/o1f7R3oXAnE+OG2+oY+0zDrayopgZiEOIetk1r9ZvcRkmGQAK8LbnBr/BjbpM3REk
	AYuBddM3jop2s+DXe9FiSROzfIBroJbGJUKLr5HQ8h/jAnp7u2NkeL4Kcc3Wyno8DxRBAxiyN8z
	xZ/lGgwJlI0e5BMfVh1fDlxaYqW4e/g/kEb5/46Y0v3hLWGV14oa3XL90mkZeNMVr7zJVW+FPOe
	wRzk8DhpWqOkJa0MpFyD24b9/ATMgJGvV0wqhqm0cBH4nyChPReefWko=
X-Received: by 2002:a17:903:2c07:b0:2ad:cf11:5048 with SMTP id d9443c01a7336-2ae6aa1ac93mr60561895ad.22.1772726883531;
        Thu, 05 Mar 2026 08:08:03 -0800 (PST)
X-Received: by 2002:a17:903:2c07:b0:2ad:cf11:5048 with SMTP id d9443c01a7336-2ae6aa1ac93mr60561545ad.22.1772726882669;
        Thu, 05 Mar 2026 08:08:02 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:02 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 07/15] wifi: cfg80211: add continuous ranging and PD request support
Date: Thu,  5 Mar 2026 21:37:04 +0530
Message-Id: <20260305160712.1263829-8-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: 9msjz5s-n87MK8MhwP54TpOyAXzpfThf
X-Proofpoint-GUID: 9msjz5s-n87MK8MhwP54TpOyAXzpfThf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX9dlUga0DNfIL
 05HKHV/pFy37ZlDBsyXICeNXpq4iC/Z8CJlsBrZzYwOAkIovWZS/P9VqbRAMZ573tfrQA0VLJ7n
 WCOutLbM/eq6dsN52jY7Ky4LaCOWlfJKRJKlBapNB2WQzujkYIQS3XNH5oRsVFOskvcXqZLpd5p
 sbz/THJxmNYhjqiyA7vwBHC1o+aBccikhLP1gEX9/9N9Gc7iXsDdwL11g/Xn4srOk0H2Lhz9xNB
 d8aq7LSoTdBCrjL34nTimqzDvTsdSlnd7SNmACOaX0Ya4YC7AnAGU67nzRRRTr+KUL9fdseOUGE
 LQCT/taDoW8yePg7z3YokUu83BXUQg4GUl46smJt/P0uyWmF5bBshBMNRW2tpZ5Dzh7C9lcSTgz
 LmZJ0Ms8jB2xpCuytBfC4sCaljSmlivPJIWPKKKDd6Iw/cN0kzoE1CiBbnRNH97ARuKlwOKAVvv
 /WaJ8+nPvK7NG5AtOgw==
X-Authority-Analysis: v=2.4 cv=N64k1m9B c=1 sm=1 tr=0 ts=69a9aa64 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4ElBkG7Mby1RxegV-8cA:9 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015 adultscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 34592215275
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32556-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Proximity detection (PD) applications require sustained measurement
sessions without repeated FTM negotiation overhead. Currently, each
ranging session requires separate negotiation.

Enable NTB continuous ranging with configurable timing and
measurement parameters as per the specification "Proximity Ranging
(PR) Implementation Consideration Draft 1.9 Rev 1, section 5.3".
Add PD capability validation to support proximity detection sessions.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 22 ++++++++++++-
 include/uapi/linux/nl80211.h | 26 +++++++++++++++
 net/wireless/nl80211.c       | 10 ++++++
 net/wireless/pmsr.c          | 64 +++++++++++++++++++++++++++++++-----
 4 files changed, 112 insertions(+), 10 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 62a2139b2f37..b66300497312 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4369,6 +4369,19 @@ struct cfg80211_pmsr_result {
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
+ * @min_time_between_measurements: minimum time between two consecutive range
+ *	measurements in units of 100 micro seconds, applicable for
+ *	non trigger based ranging. Only valid if @non_trigger_based is set.
+ * @max_time_between_measurements: maximum time between two consecutive range
+ *	measurements in units of 10 milli seconds, to avoid FTM negotiation
+ *	applicable for non trigger based ranging. Only valid
+ *	if @non_trigger_based is set.
+ * @availability_window: duration of the availability window (AW) in units of
+ *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
+ * @nominal_time: Nominal duration between adjacent availability windows
+ *	in units of milli seconds. Only valid if @non_trigger_based is set.
+ * @measurements_per_aw: number of measurement attempts per availability window
+ *	with a maximum value of 4. Only valid if @non_trigger_based is set.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4388,6 +4401,11 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
 	u8 bss_color;
+	u32 min_time_between_measurements;
+	u32 max_time_between_measurements;
+	u32 availability_window;
+	u32 nominal_time;
+	u32 measurements_per_aw;
 };
 
 /**
@@ -4395,12 +4413,14 @@ struct cfg80211_pmsr_ftm_request_peer {
  * @addr: MAC address
  * @chandef: channel to use
  * @report_ap_tsf: report the associated AP's TSF
+ * @pd_request: indicates a peer-to-peer PD request
  * @ftm: FTM data, see &struct cfg80211_pmsr_ftm_request_peer
  */
 struct cfg80211_pmsr_request_peer {
 	u8 addr[ETH_ALEN];
 	struct cfg80211_chan_def chandef;
-	u8 report_ap_tsf:1;
+	u8 report_ap_tsf:1,
+	   pd_request:1;
 	struct cfg80211_pmsr_ftm_request_peer ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 59e8ba9c37c4..4dafaf25b0f6 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7792,6 +7792,8 @@ enum nl80211_peer_measurement_resp {
  * @NL80211_PMSR_PEER_ATTR_RESP: This is a nested attribute indexed by
  *	measurement type, with attributes from the
  *	&enum nl80211_peer_measurement_resp inside.
+ * @NL80211_PMSR_PEER_ATTR_PD_REQUEST: flag attribute indicating this is a
+ *	peer-to-peer PD request
  *
  * @NUM_NL80211_PMSR_PEER_ATTRS: internal
  * @NL80211_PMSR_PEER_ATTR_MAX: highest attribute number
@@ -7803,6 +7805,7 @@ enum nl80211_peer_measurement_peer_attrs {
 	NL80211_PMSR_PEER_ATTR_CHAN,
 	NL80211_PMSR_PEER_ATTR_REQ,
 	NL80211_PMSR_PEER_ATTR_RESP,
+	NL80211_PMSR_PEER_ATTR_PD_REQUEST,
 
 	/* keep last */
 	NUM_NL80211_PMSR_PEER_ATTRS,
@@ -8012,6 +8015,24 @@ enum nl80211_peer_measurement_ftm_capa {
  *	%NL80211_ATTR_TIMEOUT has expired.
  *	Set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK to ensure RSTA will have
  *	the measurement results to report back in the FTM response.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: minimum time
+ *	between two consecutive range measurements in units of 100 microseconds,
+ *	applicable for non-trigger based ranging (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: maximum time
+ *	between two consecutive range measurements in units of 10 milliseconds,
+ *	to avoid FTM negotiation, applicable for non-trigger based ranging (u32)
+ *	. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME: the nominal time field shall be set
+ *	to the nominal duration between adjacent Availability Windows in units
+ *	of milli seconds (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION: The AW duration field shall be set
+ *	to the duration of the AW in units of 1ms (0-255 ms) (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the
+ *	number of measurements attempts per AW with a maximum value of 4 (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8033,6 +8054,11 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 	NL80211_PMSR_FTM_REQ_ATTR_RSTA,
+	NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4fbc2c8ff395..01a70f1898bc 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -372,6 +372,15 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK] = { .type = NLA_FLAG },
 	[NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_RSTA] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS] = {
+		.type = NLA_U32
+	},
+	[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS] = {
+		.type = NLA_U32
+	},
+	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
+	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
 };
 
 static const struct nla_policy
@@ -394,6 +403,7 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_PD_REQUEST] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 17f0b1c97d58..7e90dc29b0e5 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -90,15 +90,6 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		out->ftm.ftms_per_burst =
 			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
 
-	if (capa->ftm.max_ftms_per_burst &&
-	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
-	     out->ftm.ftms_per_burst == 0)) {
-		NL_SET_ERR_MSG_ATTR(info->extack,
-				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
-				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
-		return -EINVAL;
-	}
-
 	out->ftm.ftmr_retries = 3;
 	if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES])
 		out->ftm.ftmr_retries =
@@ -128,6 +119,13 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (out->pd_request && out->ftm.trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    ftmreq,
+				    "FTM: TB ranging is not supported by Proximity Detection");
+		return -EINVAL;
+	}
+
 	out->ftm.non_trigger_based =
 		!!tb[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED];
 	if (out->ftm.non_trigger_based && !capa->ftm.non_trigger_based) {
@@ -143,6 +141,16 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
+	    capa->ftm.max_ftms_per_burst &&
+	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
+	     out->ftm.ftms_per_burst == 0)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
+		return -EINVAL;
+	}
+
 	if (out->ftm.ftms_per_burst > 31 && !out->ftm.non_trigger_based &&
 	    !out->ftm.trigger_based) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -196,6 +204,36 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EOPNOTSUPP;
 	}
 
+	if (out->ftm.non_trigger_based) {
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS])
+			out->ftm.min_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS])
+			out->ftm.max_time_between_measurements =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION])
+			out->ftm.availability_window =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME])
+			out->ftm.nominal_time =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW])
+			out->ftm.measurements_per_aw =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW]);
+	}
+
+	if (out->pd_request && out->ftm.non_trigger_based && !out->ftm.rsta &&
+	    out->ftm.measurements_per_aw == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    ftmreq,
+				    "FTM: Invalid parameters:measurements per avail window is zero for NTB PD request");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -223,6 +261,14 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
 
+	out->pd_request = !!tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST];
+
+	if (out->pd_request && !rdev->wiphy.pmsr_capa->pd_support) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST],
+				    "PD request not supported by device");
+		return -EINVAL;
+	}
 	/* reuse info->attrs */
 	memset(info->attrs, 0, sizeof(*info->attrs) * (NL80211_ATTR_MAX + 1));
 	err = nla_parse_nested_deprecated(info->attrs, NL80211_ATTR_MAX,
-- 
2.34.1


