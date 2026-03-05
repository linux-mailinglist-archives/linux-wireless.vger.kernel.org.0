Return-Path: <linux-wireless+bounces-32562-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CNZ+EYmqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32562-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A217215249
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 86DA7302BBFE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A86503CF66D;
	Thu,  5 Mar 2026 16:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ctfylmwd";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BO5+cZjW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE76B3CF666
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726900; cv=none; b=ZEQoqP2pF31AH73TiPKEjOwzxtQ/w3erP7TbDGd90Zts911C0Er1WSPmByOW0ZK4nubuAxJ/QBWFkMnDvRXOHiYJNPI0Nd0yq5XPrpIg8xu9Mx5UsHtiE3Zr4q5wCD5C6mnXi8DN/VgOBBDR2seRXp0CwrGjE5O0UGBdVbrLtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726900; c=relaxed/simple;
	bh=NDd82czOMgra/8NTHc/UhWFaFQjTX5OhctOBq2hQkEY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t7iI+zPLtgVBLpXt18tdmC2EHcK3w92qfSiYnBXbvkS06lX0VRVeWzxIsZXQy7jYAy/p5mKVu5c+5ri0Sc4kW9AuNJZvKdx93v/gZxm3JW5RpKtJ35SoGZ/DXHQWwnIHP7gr/jw3AjYB0vWJaWk0lgeFkVI7W/5TkxhHrh1zXsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ctfylmwd; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BO5+cZjW; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFjWl935986
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=irV1zip1NL+
	qjHQpTrOZTZx2s3LHS9orRFceLLkIFLg=; b=ctfylmwdUF3v5oPRG4Ah8B+5Gz0
	BnJwdBFIPJpg5xCsrayFhloj1helGCRkbCHvlpQhzVspIfJPeKCZVDuI9YqrrPqy
	RcIjHDdYuToxk0nq6/OGHdX1fOemKSyi+UDgl2Eo9KzFTe70bqTGq/EplkHRVfCP
	zv+1+7ZbBa/3+L361D+XY3vIxQWkb5QBVDFufqZeMp+gC1CS925epCYf6MRp0ynK
	cK0+hEhXnYU1BbFiopA3zoNXTnKxTpwosxmX7F5B4fRmgd1/7zmmJFDVsZiyRnBJ
	jyU+AQtkABEO3XGy4aBopBTTAK1ZE7Hxw7v5cWnYvWcvPbRfnWs2nf+0Y7Q==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq04u2s40-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:16 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae59e057f1so51595335ad.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726896; x=1773331696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=irV1zip1NL+qjHQpTrOZTZx2s3LHS9orRFceLLkIFLg=;
        b=BO5+cZjW7EBwr8TkmCQErGPwPXs9IJ5fTsGFnDxHiDAXvKY8L/9fyT2+IgdqIOIiAl
         r+kdlDf4s8WK6hZTEh1TLikYQ9X2CjxFGc0QPbqmJxLWIo41LbA5T9BdwZkHVpxq7jdG
         SkZZhnOCVRnmHfhvk3oN0wdS7Ea3pg+hwGLXR0fdXTgkQs0cvH4T0OcZvt74H1xdnmHw
         XxCnd2u5JeXBM8imjW5nlquAYsXDIEhSAqaEbwk2mR5OWan5VRW5YHHmbyUJOFDxISZ6
         WuwKSouGUo1y84Y/zMdrGidR0I7bfjRW9jyQ9XVfC56GCGp+pc8RwyodCIcjGAiqtFCr
         BSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726896; x=1773331696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=irV1zip1NL+qjHQpTrOZTZx2s3LHS9orRFceLLkIFLg=;
        b=QyC+R7ZO/eX/K9GZkQbsqhrzlSWMTh+D8ALwovx66imwq6pRaDjs2fToSJvqCNPzrx
         ewj6S1dP5Npu888pJr1H1LM5INdR24pKI/wamvFbMMPZ9wPDKr+0+XMulLp0aquVjZIp
         33VzX5ArVK+v6+eKfV74z3XN/oUD1Y3Vid/rYAjhDbhKxFGBkpN9W+tgj10JBc4ATNX3
         yPY95uB8N4mYqFrTG+M0zxx31sH+wlPrfWnBFK2ogW52O+qv6JEGI2QKgfBaMvxVVhvq
         C48Gu4ds/VEGsxSR3OnYNWf7qFZec90r0dxF5jTfyuUMtxqx7wslUTMUMVRCd41ZPwBi
         VVaA==
X-Gm-Message-State: AOJu0YzAc3/h0Qi5LdmN9CcuC7fj2mMzQ0sbj8OQyJfAIYjM/8dCxkXg
	yvxpJFjmi+7IWvAiMf46e9qg6OcP9kgetWXrwAbov88LnFkOHGU6kkULARj7Nr6HFqG8rOij6+P
	0KN0sBTQSvHDPyNKD4PpPmYNORPDEFZTQd0EGjEp25M8HbIObqKwbP0slmtguyKSHpbsa
X-Gm-Gg: ATEYQzx7R07vzM+34B32N0r6y/haPA+pgTcWo7gtPEtNfNR5RT/goYotGHj0DfxMuRf
	Np1IhXMa/JCI7IlmqJh53zHmV7cASIjFRQ5+WfCuxBPmGUtNCU0lii5LWmKn13Y3+JSL8sZzNeZ
	BcXASJMfi1NUJ5y/Ol5PuTAJFazrkZYubjj1w5JF/YB9oYkAJ9kW2SV+DDvTidCwQ3raeGkZq/D
	5MYtx+57O3T4qanYHDnWgkEQiyOG+Rxm2wgGKIVAbTAxs3rBwIpvrzedf4dYSAz+3TgLkskZ4X3
	SLZYtferITDQvQ62hrkAIkVshzzxzUejyOO4rAZQzM/Ma1DNfiBhDo40Z49RsZZzf3T+ahYUXmS
	WeXouVQ7BPdWblVao3E8BZDFnAGQ0Mc6C0tujxaiEowHEH6+gPxB1AVU=
X-Received: by 2002:a17:903:2409:b0:2a9:62ce:1c15 with SMTP id d9443c01a7336-2ae80009331mr2059545ad.0.1772726895499;
        Thu, 05 Mar 2026 08:08:15 -0800 (PST)
X-Received: by 2002:a17:903:2409:b0:2a9:62ce:1c15 with SMTP id d9443c01a7336-2ae80009331mr2059235ad.0.1772726894874;
        Thu, 05 Mar 2026 08:08:14 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:14 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 13/15] wifi: cfg80211: add result reporting control for PD requests
Date: Thu,  5 Mar 2026 21:37:10 +0530
Message-Id: <20260305160712.1263829-14-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: -sIDUA14sirePU3mrDJhN--LjmBoFh8V
X-Authority-Analysis: v=2.4 cv=eqTSD4pX c=1 sm=1 tr=0 ts=69a9aa70 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=RfmHTrBQH4soxj86TAEA:9 a=GvdueXVYPmCkWapjIL-Q:22
X-Proofpoint-ORIG-GUID: -sIDUA14sirePU3mrDJhN--LjmBoFh8V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX5magivMwj9dN
 d3H8KW6cNn7lTYchaiUtqTLFjb9U3fh2ZLGuWLUw+X+5ow6nUd2yNIZoOGT6LHpQsVwGR4+bwnf
 tYOBH4aZJ3vYPNP2LlNbsu3vAynJ+QOE2DAvvWZUPcXp+TRBJK6iKU6fAwhCmBCyw/dD16pE8ZK
 Z/e49yPtii+l31ixxOIclmEB2Vla8wjJE7We/Bf6WY1N2lXjzyAL2rcgVoIsRXy1eQo9aYWvoIM
 k+tIhZMQKUD3A6Qby5fkAMaPUqi0PgtC8v150r2tS6eTZTRYCG1KDxnDdWnUrBXGXUZCUIWM8PZ
 KQ9OIkc8+evY+uu8YF6+dbkz5zt24bOLL/L6XKrbd77VxiAFOVPvVELXn8xaJjnnHo53MnX5Ksm
 xNtp7SyJNeYv458kREdWYroAruRUiqDAOABToO5O7Wd7h/LkyL9RkSLTKd7Dw0TSpWWvlmJ1p5b
 /kBsgNHuHPjh62qMdOA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 5A217215249
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	TAGGED_FROM(0.00)[bounces-32562-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email]
X-Rspamd-Action: no action

Proximity detection applications may not need detailed ranging
measurements for every request, yet currently receive all results
causing unnecessary data transfer, host wakeups, and processing
overhead. Currently, there is no mechanism for applications to
suppress result reporting when only proximity detection is needed.

Introduce optional result suppression control that drivers can use
to implement selective result reporting. Add a flag allowing
applications to disable ranging reports when only proximity detection
is needed, enabling drivers to reduce unnecessary data transfer and
host wakeups. This flag cannot be combined with range report or LMR
feedback requests in RSTA mode as these require result reporting.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  7 +++++++
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 18 ++++++++++++++++++
 4 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index e398a594082a..8dc2ccafb88b 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4448,6 +4448,11 @@ struct cfg80211_pmsr_result {
  *	basis in this case.
  * @range_report: negotiate for FTM range report. Only valid for
  *	EDCA based ranging.
+ * @pd_suppress_range_results: flag to suppress ranging results for PD
+ *	requests. When set, ranging measurements are performed but results
+ *	are not reported to userspace, regardless of ranging role or type.
+ *	Only valid when @pd_request is set. Cannot be used with @range_report
+ *	or @lmr_feedback as these require result reporting.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4474,7 +4479,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 measurements_per_aw;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
-	u8 range_report:1;
+	u8 range_report:1,
+	   pd_suppress_range_results:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a70dcb2aa111..cafa73280758 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8082,6 +8082,12 @@ enum nl80211_peer_measurement_ftm_capa {
  *	(units mm, u64)
  * @NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT: Negotiate Range report in case of
  *	EDCA based ranging (flag).
+ * @NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS: Flag to suppress ranging
+ *	results for PD requests. When set, ranging measurements are performed
+ *	but results are not reported to userspace, regardless of ranging role
+ *	or type. Only valid when %NL80211_PMSR_PEER_ATTR_PD_REQUEST is set.
+ *	Cannot be used with %NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT or
+ *	%NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK as these require result reporting.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8112,6 +8118,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT,
+	NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 69f972af7e64..313bad0d4a77 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -384,6 +384,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 9a2e84805a31..eb372c2a6744 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -277,6 +277,24 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	out->ftm.pd_suppress_range_results =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS]);
+
+	if (!out->pd_request && out->ftm.pd_suppress_range_results) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS],
+				    "FTM: suppress range result flag only valid for PD requests");
+		return -EINVAL;
+	}
+
+	if (out->ftm.pd_suppress_range_results && out->ftm.rsta &&
+	    (out->ftm.range_report || out->ftm.lmr_feedback)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS],
+				    "FTM: cannot report with suppressed results");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


