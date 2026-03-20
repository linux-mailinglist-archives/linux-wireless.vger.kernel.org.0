Return-Path: <linux-wireless+bounces-33602-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIUYAL+MvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33602-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:06:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 57EC92DF297
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:06:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B8EA3208AC5
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B95BF3D4125;
	Fri, 20 Mar 2026 18:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eNIC1XEw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="WfvfRZAW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41995337B99
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029650; cv=none; b=MpmDSNIWEOb9Nryt9aGLtpVr+O/fo4pSwkqpTTQlP0VO/rZtYS9JTtapa43auBftl1UYxu2ikm0Yu9VJNWhDlWjdXdLcHzRScv99MK1V/9pLd3F44aBb0o9PuZ6rozEKa0GurUQ/aL6V94+aPepU6UZpot79ZPVJUE9LixC7Gew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029650; c=relaxed/simple;
	bh=2ml3i8mU3mcuPc5CcfiWnODiF+09924l/PdOTw9oZ3M=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHzYnfU9EBd/U+sjciaYPVP8MRkXNj2iVayraKkYWX6RSX/FYV+J8PAtwdRtTt20zqlKqgLBoAVOuwqDC8XQItv2JroJhcaibjgTlit4YkpBirQ8zZupN0V5ynZ9BN9SA35rH5zn2tN/OidvvDK+up+aUg/52veLKCjDv1nIkM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eNIC1XEw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=WfvfRZAW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KBsX3u3876041
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=JJCB4VzSkVQ
	ge4kaxJE4KrRWIXDRC7ktynIHqwZgmPQ=; b=eNIC1XEwMAZuDK2he6C0UVZ6cW9
	ruAVQcS5tBQ9JGfRg2A+J8A1nf8tXsoXL13TPbgJ1cIlkAn5ND7c0FNQStPGhx6R
	nLgMb+jhFsYwlirTwmNZ1iKMV/U//KKgcS3AUQd14kE9+v4mJkwlEpyOl2Ce4GQb
	Ro2yzaytGu0OyBxaUmFkW2ZvroSH6TOtUx8Cs7Pd7uWct3HxPZz5pSe+mdDdo+Wn
	aRd1kD03sho/1xaB/pN5KocotbuZ4BlvFejdD4J6I+3MxxgOrvzGQdwa/2L0X8UC
	SL2wf8BaDbmQnC2m/Z+Ua1mUsOQV7ITqEDX4V7R4Y3RUiKunGiDLyhnNZbg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d15s08wrk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:46 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b064884a7cso136935245ad.3
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029646; x=1774634446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JJCB4VzSkVQge4kaxJE4KrRWIXDRC7ktynIHqwZgmPQ=;
        b=WfvfRZAWEzyPiKEfncYBC4tFPQ+WC5VdFDRUZSwRWQTxWsQZ63kOqS8gWx+PhugxHg
         AEbKLJWD9vPRE2k58OXOP4DSfgQLrahUepvz6qdZWGFo9RDltS9dsRWeI1h0688dQZH6
         Ipb7EIh1tBb7vXtkaaGd1JzsLMkRv0nQTAoc5NSp+FFtTCWk8NKY2cLHxkRyKNVckXpW
         p1Rl0i/F4BsBG74Gp7FsgL8of6P10V0/Dsy/NPGH50wbeqA75u5TlMZvMvCh5lCMVT6r
         3T/8PYbQ/rvbDdp4uFe1/9RjAIoEi2L9+7QLjzKHKXJCpzQDbM8MJqPaqtgdadYTND06
         zBWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029646; x=1774634446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JJCB4VzSkVQge4kaxJE4KrRWIXDRC7ktynIHqwZgmPQ=;
        b=oo+kbeUYgyvP+Ohrfk7raQ3GFSI8LcRjdl166/W8zQSDS2bpr4VZ3q9m60ija5ElnW
         FCr0DpSVGSepEzauAf7bBSsUpmZnvF1yF45CmCnw8ncjiGBkoeDML1fnOduf6qcnh412
         F3fu4aMS0ImEJkdU+PUNrQ6Vvtkw0bJoN3GKwZ1+NkK4+1K0vWDOcyoFif8qCvJlKXf9
         xlxJQOO7wR+pDI2QPHoIMsI0L9JD3ztdtAlRsiMHJRYC5MxlGuWASz2MXIp9hRiDwcLk
         dBp2ztkizFY8pwjec054CMj1IoxGmruHX3pl7PgpcIzAwUMCTOxOU0zX3M/qgleZ7gHG
         9WBA==
X-Gm-Message-State: AOJu0Ywb/g/A20FSXijcKgH1gh/m9gPb4JHMkimL6bd9ZYw5S47ug3Gd
	dxw73ncMfB5Qwl9pv6dZU67siUcIUBlk8oRDibFxUDDwjbcEbmaDWgFXoyfX9qK2ioqLQzx7CM4
	FVJ8qHzNYUHwoDUuFXg1/0J5eZM9ulxoeWoxJYxNDMgEoCia3xg90RByJUh+XAJnM7YcWNcqcAO
	Fq
X-Gm-Gg: ATEYQzxeiDWCC7TdH66E618mXqepngXKZ9LXBULN041AzkTlU0SVCK4tB4D9LbRRXnE
	VSOpIP77wycWgV00myH3HG5m/czpu2sYGND52H9LksmrqAAfnWLYUzzFlTV6SEOH3Mo0fKbBm5q
	aeWcA7JmueXFMErPME5pBtPjO6RsGpswPARkfp/AyqS23PpO1AN67QY4gbUixYGiuoL49L4r3ii
	oE4NwrxRzKk+wvb3qRm5MBYRd/+orYbs17VhRnaf53cLM/hai/Gkidx4hk9numSXdj7ftyErZKP
	ykpjyXDXdG2qmIexNtI6K7dNPQVUzaFMpX/vCw5MRm/XFaQ+RnzGT/twwjvX+cqywExiN2we1z+
	z+TdOS/exo33H4SpLQg3wWfFvWpNcoB97fCWjHXgudRI6eLWnZS6JT4w=
X-Received: by 2002:a17:903:1a4e:b0:2aa:d65f:47a2 with SMTP id d9443c01a7336-2b0827c0d2emr37655515ad.41.1774029645658;
        Fri, 20 Mar 2026 11:00:45 -0700 (PDT)
X-Received: by 2002:a17:903:1a4e:b0:2aa:d65f:47a2 with SMTP id d9443c01a7336-2b0827c0d2emr37655135ad.41.1774029644941;
        Fri, 20 Mar 2026 11:00:44 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:44 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 07/14] wifi: cfg80211: add NTB continuous ranging and FTM PD request support
Date: Fri, 20 Mar 2026 23:29:31 +0530
Message-Id: <20260320175938.2547288-8-peddolla.reddy@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
References: <20260320175938.2547288-1-peddolla.reddy@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: lnRYDxDw8OaMmdaQyX9uLRajSWuvK6fO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX1qleihZUVI1o
 mCTK7mkAZ31Zgk0bsIg1f5FPu8dMKOUCb4/fs4f1SVrpKnnNYOOv5TrsrIQd8EuGJ3FAsTldtfZ
 GpAakXcHaYs+epTES9HqeYjZN9s07eUnflRLj0pKbpDEHL/Pha2RgbLvzq3t87zG9X0CSqmEckc
 9kfrbmM/P2h6G18UOeyDVGh42IrLifznKui3zIG+++qnk0ECNz2dKpVYPG6Qsj5BOY8InZFVqbX
 tbe1SA+CM4tCKmiI2IYFanKWBmAdwL4/UJw4NTr9UYDQ0qeGp9JZx1Cn5iRgQpWBjhCjb+smgO7
 h7jGEZmOh51q5W2eZYwHplIxHUB4QUlBzXEupkeQ9vd+abpNT0j7GQtKzNc4vURDjfOW93SyS9p
 aWY0Lv4wnrmjWqapE7Zt5BCve7PzzbuVCUgYee+oJViYEtsTJ5PkLTdnvpZPNjd5GUrcoa2Net9
 ssxIzlXv0KsU5h/2A+A==
X-Proofpoint-GUID: lnRYDxDw8OaMmdaQyX9uLRajSWuvK6fO
X-Authority-Analysis: v=2.4 cv=KORXzVFo c=1 sm=1 tr=0 ts=69bd8b4f cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=fpgZQOwNbBMtDrBjYVcA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 phishscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33602-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.996];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 57EC92DF297
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Proximity detection (PD) applications require sustained measurement
sessions without repeated FTM negotiation overhead. Currently, each
ranging session requires separate negotiation.

Enable NTB continuous ranging with configurable timing and measurement
parameters as per the specification "Proximity Ranging (PR)
Implementation Consideration Draft 1.9 Rev 1, section 5.3".

Introduce "pd_request" field in the FTM request structure to support
peer-to-peer proximity detection requests. Validate that PD request
is not compatible with trigger-based (TB) ranging.

Mark %NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST as optional. If absent,
treat it as no preference and let the driver or firmware choose a
suitable value.

Burst parameters (ftms_per_burst) are not applicable for trigger-based
or non-trigger-based ranging. Add validation to reject burst parameters
when NTB or TB ranging is requested.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 34 +++++++++++++++++-
 include/uapi/linux/nl80211.h | 45 ++++++++++++++++++++++--
 net/wireless/nl80211.c       | 11 ++++++
 net/wireless/pmsr.c          | 67 +++++++++++++++++++++++++++++++-----
 4 files changed, 145 insertions(+), 12 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 986775cd4502..fb9191449886 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4351,7 +4351,8 @@ struct cfg80211_pmsr_result {
  * @burst_duration: burst duration. If @trigger_based or @non_trigger_based is
  *	set, this is the burst duration in milliseconds, and zero means the
  *	device should pick an appropriate value based on @ftms_per_burst.
- * @ftms_per_burst: number of FTMs per burst
+ * @ftms_per_burst: number of FTMs per burst. If set to 0, the firmware or
+ *	driver can automatically select an appropriate value.
  * @ftmr_retries: number of retries for FTM request
  * @request_lci: request LCI information
  * @request_civicloc: request civic location information
@@ -4368,6 +4369,29 @@ struct cfg80211_pmsr_result {
  * @bss_color: the bss color of the responder. Optional. Set to zero to
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
+ * @pd_request: indicates a peer-to-peer PD request.
+ * @min_time_between_measurements: minimum time between two consecutive range
+ *	measurements in units of 100 micro seconds, applicable for
+ *	non trigger based ranging. Only valid if @non_trigger_based is set.
+ * @max_time_between_measurements: maximum time between two consecutive range
+ *	measurements in units of 10 milli seconds, to avoid FTM negotiation
+ *	applicable for non trigger based ranging. Only valid
+ *	if @non_trigger_based is set.
+ * @availability_window: duration of the availability window (AW) in units of
+ *	1 millisecond (0-255 ms). Only valid if @non_trigger_based is set.
+ *	If set to 0, the firmware or driver can automatically select an
+ *	appropriate value.
+ * @nominal_time: Nominal duration between adjacent availability windows
+ *	in units of milli seconds. Only valid if @non_trigger_based is set.
+ *	If set to 0, the firmware or driver can automatically select an
+ *	appropriate value.
+ * @measurements_per_aw: number of measurement attempts per availability window
+ *	with a maximum value of 4. Only valid if @non_trigger_based is set.
+ *	If set to 0, the firmware or driver can automatically select an
+ *	appropriate value.
+ * @num_measurements: number of measurements to be performed in total.
+ *	Only valid if @non_trigger_based is set. If set to 0, the firmware or
+ *	driver can automatically select an appropriate value.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4387,6 +4411,14 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftms_per_burst;
 	u8 ftmr_retries;
 	u8 bss_color;
+
+	u8 pd_request:1;
+	u32 min_time_between_measurements;
+	u32 max_time_between_measurements;
+	u32 availability_window;
+	u32 nominal_time;
+	u32 measurements_per_aw;
+	u32 num_measurements;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a1a5bc21ab6f..b271a9629b0f 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7798,6 +7798,8 @@ enum nl80211_peer_measurement_resp {
  * @NL80211_PMSR_PEER_ATTR_RESP: This is a nested attribute indexed by
  *	measurement type, with attributes from the
  *	&enum nl80211_peer_measurement_resp inside.
+ * @NL80211_PMSR_PEER_ATTR_PD_REQUEST: flag attribute indicating this is a
+ *	peer-to-peer PD request
  *
  * @NUM_NL80211_PMSR_PEER_ATTRS: internal
  * @NL80211_PMSR_PEER_ATTR_MAX: highest attribute number
@@ -7809,6 +7811,7 @@ enum nl80211_peer_measurement_peer_attrs {
 	NL80211_PMSR_PEER_ATTR_CHAN,
 	NL80211_PMSR_PEER_ATTR_REQ,
 	NL80211_PMSR_PEER_ATTR_RESP,
+	NL80211_PMSR_PEER_ATTR_PD_REQUEST,
 
 	/* keep last */
 	NUM_NL80211_PMSR_PEER_ATTRS,
@@ -8002,9 +8005,11 @@ enum nl80211_peer_measurement_ftm_capa {
  *	default 15 i.e. "no preference"). For non-EDCA ranging, this is the
  *	burst duration in milliseconds (optional with default 0, i.e. let the
  *	device decide).
- * @NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST: number of successful FTM frames
- *	requested per burst
+ * @NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST: (Optional) number of successful
+ *	FTM frames requested per burst
  *	(u8, 0-31, optional with default 0 i.e. "no preference")
+ *	If the attribute is absent ("no preference"), the driver or firmware can
+ *	choose a suitable value.
  * @NL80211_PMSR_FTM_REQ_ATTR_NUM_FTMR_RETRIES: number of FTMR frame retries
  *	(u8, default 3)
  * @NL80211_PMSR_FTM_REQ_ATTR_REQUEST_LCI: request LCI data (flag)
@@ -8038,6 +8043,36 @@ enum nl80211_peer_measurement_ftm_capa {
  *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK is set (so the
  *	RSTA will have the measurement results to report back in the FTM
  *	response).
+ * @NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS: minimum time
+ *	between two consecutive range measurements in units of 100 microseconds,
+ *	applicable for non-trigger based ranging (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS: maximum time
+ *	between two consecutive range measurements in units of 10 milliseconds,
+ *	to avoid FTM negotiation, applicable for non-trigger based ranging (u32)
+ *	. Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME: (Optional) The nominal time field
+ *	shall be set to the nominal duration between adjacent Availability
+ *	Windows in units of milli seconds (u32). Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION: (Optional) The AW duration field
+ *	shall be set to the duration of the AW in units of 1ms (0-255 ms) (u32).
+ *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: (Optional) This field shall
+ *	indicate the number of measurements attempts per AW with a maximum value
+ *	of 4 (u32). Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED
+ *	is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS: (Optional) number of
+ *	measurements to be performed in total. Only valid if
+ *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ *	If the attribute is absent ("no preference"), the driver or firmware
+ *	can choose a suitable value.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8059,6 +8094,12 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK,
 	NL80211_PMSR_FTM_REQ_ATTR_BSS_COLOR,
 	NL80211_PMSR_FTM_REQ_ATTR_RSTA,
+	NL80211_PMSR_FTM_REQ_ATTR_MIN_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_MAX_TIME_BETWEEN_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
+	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
+	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+	NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 8e06ff02c5cc..8bcc4aa6514e 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -385,6 +385,16 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
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
+	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
 };
 
 static const struct nla_policy
@@ -407,6 +417,7 @@ nl80211_pmsr_peer_attr_policy[NL80211_PMSR_PEER_ATTR_MAX + 1] = {
 	[NL80211_PMSR_PEER_ATTR_REQ] =
 		NLA_POLICY_NESTED(nl80211_pmsr_req_attr_policy),
 	[NL80211_PMSR_PEER_ATTR_RESP] = { .type = NLA_REJECT },
+	[NL80211_PMSR_PEER_ATTR_PD_REQUEST] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c21f693fac29..9432cd645f2f 100644
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
 
+	if (out->ftm.pd_request && out->ftm.trigger_based) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    ftmreq,
+				    "FTM: TB ranging is not supported by Proximity Detection");
+		return -EINVAL;
+	}
+
 	out->ftm.non_trigger_based =
 		!!tb[NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED];
 	if (out->ftm.non_trigger_based && !capa->ftm.non_trigger_based) {
@@ -143,6 +141,23 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if ((out->ftm.trigger_based || out->ftm.non_trigger_based) &&
+	    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST]) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: FTMs per burst cannot be set for trigger based or non trigger based ranging");
+		return -EINVAL;
+	}
+
+	if (!out->ftm.trigger_based && !out->ftm.non_trigger_based &&
+	    capa->ftm.max_ftms_per_burst &&
+	    out->ftm.ftms_per_burst > capa->ftm.max_ftms_per_burst) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_FTMS_PER_BURST],
+				    "FTM: FTMs per burst must be set lower than the device limit");
+		return -EINVAL;
+	}
+
 	if (out->ftm.ftms_per_burst > 31 && !out->ftm.non_trigger_based &&
 	    !out->ftm.trigger_based) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
@@ -222,6 +237,32 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
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
+
+		if (tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS])
+			out->ftm.num_measurements =
+				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS]);
+	}
+
 	return 0;
 }
 
@@ -249,6 +290,14 @@ static int pmsr_parse_peer(struct cfg80211_registered_device *rdev,
 
 	memcpy(out->addr, nla_data(tb[NL80211_PMSR_PEER_ATTR_ADDR]), ETH_ALEN);
 
+	out->ftm.pd_request = !!tb[NL80211_PMSR_PEER_ATTR_PD_REQUEST];
+
+	if (out->ftm.pd_request && !rdev->wiphy.pmsr_capa->ftm.pd_support) {
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


