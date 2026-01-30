Return-Path: <linux-wireless+bounces-31387-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mC3JDNnVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31387-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:29 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C17BEBC562
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:01:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A96243031830
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424FD341660;
	Fri, 30 Jan 2026 16:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BmWF8dOC";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MV2OesQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88ADF342C98
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788866; cv=none; b=UNmM5PsR6EPNChBj8zkvvPSXTfhR0p7dEDEm5lfwIi2jlfVIm3bvu1GshWaY5GnUGvFKzq/QnkpngE5vKwP9obINLtHlzUQHX8luoQvkFgz5oHWdpWL+E5k6/LHkV8tolE3T5fnLnaPLCEEQpKgmKvZZ/n40bZow/dx+TXHWxlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788866; c=relaxed/simple;
	bh=8FQtM1mjn8ocUTEFRCMH5YKPSmNcAll7xsJnzRjgDYU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dCoSho/WSMAVdPcE3rRftIkBu2S2KItlbUW0sGyYBWZo8SL/ZXvNEadn0MzBOTw1XFhlgmbMtckBYVU5xsnvdUojZs79tl8M9rxpMdEMNts89EEqk3xj+4nQL/DbkogtJsxqIxo4PmAhKxhH4nzmo9H1edJ7eKEMTHen92JARjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BmWF8dOC; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MV2OesQu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAE3co1022075
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2BiT012I9Og
	r12ix3fFz9dx9X8SNwKrdV5CFmgKlVw4=; b=BmWF8dOCRJVwpMATq+BQFVOLVNY
	YhnM1ATXygfYnOzlWWlIFhVnXrPulAKCAYRg+cat2uanxRHzUfNVDBO5glJNIugM
	7ZjfClxngqiujMnot1G0HSJOD01t6BRiaa8aIFRLu5q+K2NZNeFqU3BCCPcjIZNm
	pq6YkpVA92AE47++kA5pOulN5/ikqGXu3YuLs7qRNOJa5IxWfeH+4K72CAh66fXu
	AthYnIWJmsWxFLA3kh7/OyugK1O64KUQcpBFAA8Y3J4mS96AMfIuFtaqcpnF5wML
	WEmn4ta2PA6w0zRhNPy4NU2bkyzT6/xsb/XLFjqIcb5AdtaSeAyTWiC6MiQ==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3kb6ma-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:03 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c5eed9a994dso1435074a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788861; x=1770393661; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2BiT012I9Ogr12ix3fFz9dx9X8SNwKrdV5CFmgKlVw4=;
        b=MV2OesQucaMFSir+ijQBq8Ktbm8Jx4FL5ZsBpDRqis48Va+9Hex9Z5SH3+EjZnRFb/
         i/pAgZf2SNO2G/qgmnOEUjseFQZHYnGAwqvm5RGVmnecX9rYqw1Pxpa0s6J8ZQZ3Dpzg
         yucECMogvaMzyFR7dlx5HqdzPYofqAo5xvnt76+rbLKE9Lc6alQpioF8BTxcVatB2FF9
         hzj5kpigzw1DBbJU0RRX/cnvpZ4b5OvNS8hWIE7clkEImMZ+GyVF6Ygj0fZvoEtyw5Ix
         2wgE/qEba9FbsbZxHSGK1zSgZUT88G7tdSRipOqEN+fA1LNpz3awq1ucPliKNlyWqUYh
         CBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788861; x=1770393661;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2BiT012I9Ogr12ix3fFz9dx9X8SNwKrdV5CFmgKlVw4=;
        b=JhPGKfT0Pxlf/yx/NExMSSjUT/4kXNFBI3h73SfRp6QltccOndWR+tBBHI/j6+VqlN
         5KM/Gb8WH/Pw6pjWnmvd08FNKBXk9TJqlZJBmi/kXcBlV5tiUBufPS2T2c7X63zC0oKw
         dNptAWSqt2UIWDixfPVuee6VczQxGE2buetTDkyHjjBJ6zMDu+lD4xIaV6gMf0VMp0j7
         rdFW6PYUw/wWejnQPeEzxhGIn3B5bj5IO8eneaxP8Qui059E65+QX7s31vuKZskzYlxY
         /kLoWcPyjWWZoGuaSF5UNa1oR2fIyHegE16V8qz56CKlER8b6cxe8vhlgTnSN/31pS98
         uzgg==
X-Gm-Message-State: AOJu0YwerHdxBKQSFBM6bhf8MZDCEkDuFn7O5JBnrbXlaALucPzQQJDa
	TSRU1denNKB/CoRID6VxqDUrh2m400TfTD0f3whHQ7aonIv6o1DHeAJdayPkhpu0isACPsE9065
	HLp+pPYeyLQWfbOUNtuAFt0FG2SMAnps9XwzMJKDbx/iDy25YtMbkNaDsNHsEDpV/d3PS
X-Gm-Gg: AZuq6aLpAcKK/pG1gqNLDtKfL/EeRys0YlbHTgHO1TtdHKuot4f7vERaN+DHhJ0TQnT
	h/en34MEHCx4fHDuv1qugGUZLqcyq2FSmJDbywLWqZdq6ncCoryj4dWWr+mfn02ktB9zBwf+XYG
	SVtN2Ad3PSOf1bX0w86avylp6gtTWm8etwBPp/sDx9kvlEjVNIFEjkRpHm8LPN15kv0/WEKnW4D
	pClpefkYZp6qEEInPqLvgQzyzlZZJSYixxmjFOKp3jsCwiXUAAwtUv0+XyycCNrO4c71ZbioCra
	z4pv2rhLSjU0/d5jXklc9sT+5VWoBx6Ug7/FKR37teMY3Pz+/7PChhIkQ81Tp2eee+fzxAOamLV
	8S4v5KUPbTbQ9ofw3ucEz/5IXfEngqPWNqIvTzWRHV1Q=
X-Received: by 2002:a05:6a20:43a9:b0:366:14ac:8c6e with SMTP id adf61e73a8af0-392e0163c2fmr2991631637.68.1769788860654;
        Fri, 30 Jan 2026 08:01:00 -0800 (PST)
X-Received: by 2002:a05:6a20:43a9:b0:366:14ac:8c6e with SMTP id adf61e73a8af0-392e0163c2fmr2991569637.68.1769788859819;
        Fri, 30 Jan 2026 08:00:59 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:00:59 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 03/13] wifi: nl80211/cfg80211: add continuous ranging and PD request support
Date: Fri, 30 Jan 2026 21:30:29 +0530
Message-Id: <20260130160039.2823409-4-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
References: <20260130160039.2823409-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697cd5bf cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=dlBkoYi7_Dx1vrx-vz8A:9 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-GUID: I7RMhAVCaBvcNVfq_j8acdTiI1S47JMm
X-Proofpoint-ORIG-GUID: I7RMhAVCaBvcNVfq_j8acdTiI1S47JMm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfXwql2Dca6YqRW
 z+UzqjC4ZlgbjEr2huU8gvJzgoYNBOT9X1kvt8jCty6ZqYVyb5uijlysmBOAYT/ymYnyjqfRmOC
 yvAcMSumirzCahthFu03dZnLxD7rDSoSBE2MWK9njJ8l5F/LDhK4tXx3zhbKUlnroJ8OSQPuTYs
 xlsbnB0CW5R2lOhaVm57wHMXaeh+HrgIZ5zMFsXNdD4N0T9larEvjuRL8nhys0/2SPcoeeUQwZV
 5/iEmUfCX5/XPPivAe24MgYqmG3VCf9U1T2GXYed4LJ8Dy4JfSiAhfKymWOcBwdZs1zO10+w2nl
 sIM1nW3qaQM4gXUjRyFJpDsAl6vvY6Q1inRqfQYNM9g9/zTczvz7VrWMXmv1I+qdu0DnO9g2n4+
 HJBwHwx2HnNxct8SMCMUm9murFqDSJpjEPFZN4uGZ1NIGxZ4Avd3pyjT9rNbaqwmF1mUwwmm9wQ
 sncMYtZRMjgEKNvonXw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
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
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31387-lists,linux-wireless=lfdr.de];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C17BEBC562
X-Rspamd-Action: no action

Add support for NTB continuous ranging with new FTM attributes. These
enable continuos non-trigger based ranging with configurable timing and
measurement parameters. Also add PD request flag to peer attrs for
proximity detection support with device capability checks.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 23 +++++++++++++++++--
 include/uapi/linux/nl80211.h | 26 +++++++++++++++++++++
 net/wireless/nl80211.c       | 10 ++++++++
 net/wireless/pmsr.c          | 44 +++++++++++++++++++++++++++++++++---
 4 files changed, 98 insertions(+), 5 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index fedff0a8b982..af357d21f67c 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4315,7 +4315,19 @@ struct cfg80211_pmsr_result {
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
- *
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
  * See also nl80211 for the respective attribute documentation.
  */
 struct cfg80211_pmsr_ftm_request_peer {
@@ -4334,6 +4346,11 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
 	u8 bss_color;
+	u32 min_time_between_measurements;
+	u32 max_time_between_measurements;
+	u8 availability_window;
+	u32 nominal_time;
+	u8 measurements_per_aw;
 };
 
 /**
@@ -4341,12 +4358,14 @@ struct cfg80211_pmsr_ftm_request_peer {
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
index 6a858e46bf3e..e594ccc59021 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7708,6 +7708,8 @@ enum nl80211_peer_measurement_resp {
  * @NL80211_PMSR_PEER_ATTR_RESP: This is a nested attribute indexed by
  *	measurement type, with attributes from the
  *	&enum nl80211_peer_measurement_resp inside.
+ * @NL80211_PMSR_PEER_ATTR_PD_REQUEST: flag attribute indicating this is a
+ *	peer-to-peer PD request
  *
  * @NUM_NL80211_PMSR_PEER_ATTRS: internal
  * @NL80211_PMSR_PEER_ATTR_MAX: highest attribute number
@@ -7719,6 +7721,7 @@ enum nl80211_peer_measurement_peer_attrs {
 	NL80211_PMSR_PEER_ATTR_CHAN,
 	NL80211_PMSR_PEER_ATTR_REQ,
 	NL80211_PMSR_PEER_ATTR_RESP,
+	NL80211_PMSR_PEER_ATTR_PD_REQUEST,
 
 	/* keep last */
 	NUM_NL80211_PMSR_PEER_ATTRS,
@@ -7929,6 +7932,24 @@ enum nl80211_peer_measurement_ftm_capa {
  *	set %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK so the
  *	RSTA will have the measurement results to report back in the FTM
  *	response.
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
+ *	to the duration of the AW in units of 1ms (0-255 ms) (u8).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the.
+ *	number of measurements attempts per AW with a maximum value of 4 (u8).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -7950,6 +7971,11 @@ enum nl80211_peer_measurement_ftm_req {
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
index accbc80b4a90..e0c910d22bd4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -362,6 +362,15 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
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
+	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = { .type = NLA_U8 },
 };
 
 static const struct nla_policy
@@ -384,6 +393,7 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_PD_REQUEST] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 8cc8d6be0e98..bee9c6fd2859 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -91,11 +91,10 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]);
 
 	if (capa->ftm.max_ftms_per_burst &&
-	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst ||
-	     out->ftm.ftms_per_burst == 0)) {
+	    (out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst)) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
-				    "FTM: FTMs per burst must be set lower than the device limit but non-zero");
+				    "FTM: FTMs per burst must be set lower than the device limit");
 		return -EINVAL;
 	}
 
@@ -196,6 +195,36 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
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
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME])
+			out->ftm.nominal_time =
+			nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME]);
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW])
+			out->ftm.measurements_per_aw =
+			nla_get_u8(tb[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW]);
+	}
+
+	if (!out->ftm.rsta && out->ftm.ftms_per_burst == 0 &&
+	    out->ftm.measurements_per_aw == 0) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: Both Ftm's per burst and measurements per avail window cannot be zero");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
@@ -223,6 +252,15 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
 
+	if (tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST])
+		out->pd_request = true;
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


