Return-Path: <linux-wireless+bounces-35034-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE6SH6vt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35034-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A5297428B1C
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 52EF73016154
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60ADF30E0E5;
	Mon, 20 Apr 2026 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="e62wv3Qe";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ehNu1SHd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA6B38E5DE
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676202; cv=none; b=PgDspryIlO2MPVoL78ZTERaE0I/lQ4AjIdMXb0oYn0xsj+H4q7igIiH/OtdwVaWWrj8SORjOPOJUoiZE/wZDjGwpEVegutPF65SzknRRflqirE57sIIu8lh2HhUn2KNLZQQjJoojp1MVPJW2qbMmH/UL9vzLTSMbZLy86LL6ttk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676202; c=relaxed/simple;
	bh=Pch45pSlTe20QQR98Z7hwkMRqBTu5dHEga/EJz9gDU4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YFVnphDO0bvJrarWa8frRRJ3XhBk4ldrANBFic3Nzn7eC4E5+z+m3XinvBpl+eKCGlCbj0mpsUMWQDJ+xDXiK5Tz9oenkFL8ilEhmAcBWtouvbu4of6yvHRWX5XXU0Mk7s0svtSBdeKTDMqXZWEnmI7kr5CW64PrhDWMwekIZm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=e62wv3Qe; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ehNu1SHd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K8Ln583407957
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=UFMSfagjScB
	ZlZvTVukT/fwLH27Cc4fj0RdpFfv7aDg=; b=e62wv3Qe3gFaY0mLdGMVwvAHvvj
	McSvnwx17EBIZx5HJ8m1HI2RxXYEpJZrq3N5zkJge8tvHcCZUGkFQMGOYrC7dzKf
	iGNHHEJrYLBREAM2UBg29lYPJxienGmNlwzLB4DLrpaclZorr3SG+brW4DeSgPxj
	W0wOyN3t46lQgWHjPJjioDr1iqrFtZTl16K3gRac0jjnlKXrq6YylLH95zQhpTj+
	+5Enkto4c5Z5Gl16SdYF9XD4PCiT8QDJFmQKOJ5zh58FpO9lQcyWeXWsaR+2/Neo
	8WZ0vZ64OIMqtJzb/Ujn/8OBwnyCXZ0X8mFhsbm9Ybju7OXYdI//ykAunfg==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com [209.85.216.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2b75aaf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:59 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d99c2908cso2848685a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676198; x=1777280998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UFMSfagjScBZlZvTVukT/fwLH27Cc4fj0RdpFfv7aDg=;
        b=ehNu1SHd3J2BTckcM13hOM/NcSOexInjvt+KXA9rhEne3ulWrz9hTgsGGiHMiJXMCo
         de+0E0L5ZBXACviJXZoxLWBL0MzsNJ7ej26nkmmd1+axVd5+80lMe3qI38C/TSJpYVlm
         GUzooxIPx/usHZglTAuWM4DwobEilN7dgoZamonunD9ZRemFP9zbmbUbo/sKy6EmhLy8
         4WHcl38LpPTz5gIvunPRmxjjiaJzsnEkHBt2WafA9gsA9/BY2SYcw6B1pBpDk44ckUPP
         mAb7N+hpQvVy5kpqP9nSHuEdLkl6D8+KEp4lSJ1skOiGKq4UMDS2GDed+pDLPZCtejGj
         aS6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676198; x=1777280998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=UFMSfagjScBZlZvTVukT/fwLH27Cc4fj0RdpFfv7aDg=;
        b=D7iZIgND4VgMVtMlfN3T5PbYyIrq0grjBhIp9Y1Zqjb8ZKmZ/t6pcCFxImKPStyJHf
         mCW3hFJbIHk5CeWqtjaVtSTbGsHUYWRc9fkZjAo/2yFO02XthZEIlbO9kpKLrvMBB3ea
         U/yLF+yt4/q6yQF5M7yDf1+Eg/BSx9j4FiYGMU1kgJ1e6AL7rvonPh3SQAQ4DmnN2j3b
         8acr5ITJ/Lz/Sa2H70TYKpRbLBbaKWiftCuGsCpTTKFa0uUfI/2C7M6cCGdBOluS2QtP
         LH6Pvq3H4cEjD0Q7DK7ipUrpgAPral9dWNpcMINGc3ZCUHcGEXFuMIKrqdV67Mh53E5t
         qspA==
X-Gm-Message-State: AOJu0YzdhslXmYMynf82p+eYonxHbhhUiRJJd+mw9MeQtwjU/sWislP3
	t7TDTcVHCyKy7JorSrYe5KbMRRen5ED0vpGZiHhiUR+ULWBWQhZx+FtI917Vb/WbfOYcpU2yKhP
	4tbvJUlyq+WSCR5cPQhsQiAJyHPaqQ8iSCDX/4shQn3inLIaNWIz8/QMxh7tjDK2p3Iuq
X-Gm-Gg: AeBDieuV7/nb7AG4OgAZyxkTVVILzmcfqL+QVd8Mb8Ewdm8XlDDTR5rrZ4pmlOHKAr4
	FnD+F1WcPPykAtPFXqf/OMmV+beYcIZEE0J6UBO35N8xKz/UoAwHySU31Zmt3M9beAJnCvQHUak
	dbOC5y9dDJDyfP54SkCNzS8CDPbBGMlNp6TRfkiMcvxSBW6+ng0gY3YTCkdVOtK1yIXqc1HTUMh
	JWIiJlOz8DwgfZx7hlng7wILnytI08A57ZMPvHqUlnjQE77UevSDHDdz3ahMT3WBFs2T6NkgHaf
	40cmI8wTDtr05lcR71j9XiYtTtgGIXCJjS2QEu6H6nbY/aqOH9R9Ny5W35kHRfHyGzBVip4t362
	b4WFNAalGvBRLH0FgIOpsAGC8AQJg3xHy1+HTFaZxDJ5wbG3ZdDGRj4u7q0/9iNo0tg==
X-Received: by 2002:a17:90b:3e4e:b0:35f:9ab2:a5bb with SMTP id 98e67ed59e1d1-361403e93a5mr14081434a91.10.1776676198194;
        Mon, 20 Apr 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a17:90b:3e4e:b0:35f:9ab2:a5bb with SMTP id 98e67ed59e1d1-361403e93a5mr14081398a91.10.1776676197655;
        Mon, 20 Apr 2026 02:09:57 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:57 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 11/13] wifi: cfg80211: allow suppressing FTM result reporting for PD requests
Date: Mon, 20 Apr 2026 14:38:54 +0530
Message-Id: <20260420090856.2152905-12-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=KZridwYD c=1 sm=1 tr=0 ts=69e5ed67 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=0lZ_7x91LeotPFWbchoA:9 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXynygXJhPn50W
 utkTherzZNagWzZXlBWwzQsxCBlt8FkL1iPSh5DOagz1J+FyrITN3dEPdBSaL80NtToPp+5DJ6L
 qlUvBCshorHV7OBrANH3UQXcZkHfVYBijRhozV1uNbhGOWR7yz7OID/qp447cvVOTTn/hyEI1xH
 zTF9dsFBErQ0y1Wstj5JgZIs0UpHm2LDRYEzeDCiw8bYotJlYuTYkI6GvbBzgncWZOd52u6Y9uR
 VKnCke4glUAB3/3zUBX174zoDluvhz+7xFXeYg/BvRcMmu3VWjJWYIgbbwPq7uYSEWlALhARFuT
 cTmv39ThbOJliw/6R241BGY0ObH2t56q14XO8rTPEPchLJC8YytQZK2ju5KQ5yAWWa7qRMFpYZd
 F428ilzwK1r9LKjvUFxR9xhmVB49fPC3OFdPnFTHyMxRj1YDjz3Gs4sRuQ35jobklRHMi9+vO8D
 I8SHdS1dY4ZSJ/u0G9Q==
X-Proofpoint-GUID: pYAabg8ul9fAZo6OjX_GMQUPh6_iWHH2
X-Proofpoint-ORIG-GUID: pYAabg8ul9fAZo6OjX_GMQUPh6_iWHH2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 spamscore=0 bulkscore=0 malwarescore=0
 priorityscore=1501 clxscore=1015 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35034-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: A5297428B1C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Proximity detection often does not require detailed ranging
measurements, yet userspace currently receives full FTM results for
every request, causing unnecessary data transfer, host wakeups, and
processing overhead.

Add an optional control to suppress ranging result reporting for
peer-to-peer PD requests. Introduce the
NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS flag; when set with a
PD request, the device may perform the measurements (e.g. when acting
as RSTA) but must not report the measurement results to userspace.

Validate that the flag is only accepted when request_type is set to
NL80211_PMSR_FTM_REQ_TYPE_PD, reject otherwise.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  6 ++++++
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 11 +++++++++++
 4 files changed, 24 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1d19cb2f14fa..3efa8a124bba 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4631,6 +4631,11 @@ struct cfg80211_pmsr_result {
  *	is set, only the specified threshold is used. If both are set, both
  *	thresholds are applied. If neither is set, results are reported without
  *	threshold filtering.
+ * @pd_suppress_range_results: flag to suppress ranging results for PD
+ *	requests. When set, the device performs ranging measurements to
+ *	provide ranging services to a peer (e.g. in RSTA role) but does
+ *	not report the measurement results to userspace. Only valid when
+ *	@request_type is %NL80211_PMSR_FTM_REQ_TYPE_PD.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4659,6 +4664,7 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 num_measurements;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
+	u8 pd_suppress_range_results:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f701b862e50f..bbf1447162d8 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8352,6 +8352,11 @@ enum nl80211_peer_measurement_ftm_type_capa {
  *	threshold is used. If both are specified, both thresholds are applied.
  *	If neither is specified, results are reported without threshold
  *	filtering.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS: Flag to suppress ranging
+ *	results for PD requests. When set, ranging measurements are performed
+ *	but results are not reported to userspace, regardless of ranging role
+ *	or type. Only valid when %NL80211_PMSR_PEER_ATTR_REQ_TYPE is set to
+ *	%NL80211_PMSR_FTM_REQ_TYPE_PD.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8381,6 +8386,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_PAD,
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 322c7ed881d8..feb770fa6a87 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -487,6 +487,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 202e2c46522b..1c2db1f5a615 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -289,6 +289,17 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		out->ftm.egress_distancemm =
 			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
 
+	out->ftm.pd_suppress_range_results =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS]);
+
+	if (out->ftm.request_type != NL80211_PMSR_FTM_REQ_TYPE_PD &&
+	    out->ftm.pd_suppress_range_results) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS],
+				    "FTM: suppress range result flag only valid for PD requests");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


