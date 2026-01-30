Return-Path: <linux-wireless+bounces-31394-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8P14ERTWfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31394-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:28 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D5351BC59E
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA5E0305262C
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A4F32F4A05;
	Fri, 30 Jan 2026 16:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="chK9MTm7";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VF39PmFr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D0E32B992
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788878; cv=none; b=dXQu63HyzbCZgOELsTYooyuLXnfj7WlT5A/TYxZWMvvGJDtZCa+FJJ7oiTZuVWiOjeP9lIG3Tf1M7j+8TbvuwT+eM4ksFj/q4Ff51vcpyzpKrojpXCcMxzo5gDzCXmtCvAiRsTW8lYFKCHjWZjgx/ZFuj2oSxYVu8kcQ/8G3wpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788878; c=relaxed/simple;
	bh=F5Mb4csWhvGfLDUwOCbItwLMepn3BQHLLwsIRv8MWVg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h+wJaB72ahxmAIKavLwSm9+loo2OmnOifPrVdLdHjW4u4CA1uGtplB3G/ndde/nFNS7w8vyiMels12CGHKmiQ3i+HZ8QJPv+HvVAyD9RBAzK0SNlxcT9NMdkoKWYU56CKmHRstoKFpUMTJHwhuoM6bG1Wl05USV6r8D2dtAzSk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=chK9MTm7; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VF39PmFr; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UDxtbR2412953
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=2AWWerLZMG4
	Q7uaPxItqrZdOaOT2hXOvgOjXgAMwHsU=; b=chK9MTm7zf5q98E0UnIhjqxXmVJ
	l+w7jcOZIsk9yS6eiM5qEQUjeEIobfyLoX5ygv/fc9xsRq1ChMICpIJdgm8s+0sQ
	6SloJA4AbLxY9X6xjbwQMDoKbbfsIUmt7WwwD3K7tjr3z9+muSaRZZikbzxfpOs/
	EQrezY+vskDvCcCgN+Wi9tU7KJR6RFYWeimveqRgTlBjtrjg2MEgk7i0JHcuGrQ4
	tjUBb13x7DJxoo3pMpHvc0LlUikiIO6+J+HZ1+ul3bUFgIrhalavJmXeuP4hnlU9
	pKc3bAsA4JZqanGY9GJWQJa7WEilKcLTu6qvazzHuiU0kKcAp2Vta9xsYHQ==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com [209.85.215.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41hjp8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:15 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id 41be03b00d2f7-c552d1f9eafso3966940a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788875; x=1770393675; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2AWWerLZMG4Q7uaPxItqrZdOaOT2hXOvgOjXgAMwHsU=;
        b=VF39PmFrfEDbQAajjPN0cqDCbTW+HK66nwrItpUW8PUH5MwXdsqFugR6SxSa2lOAOx
         FH6Ccmd6tiy7Q/YoYZIq8ACcQz1iqZr8dRHD/2zC/dIj6YVrnMdlKeEoqsiJsznIgpiQ
         5NveFhvKboYoMNo++jnDimVwES+ZZBnwBFBhU83x2IxEK5NpKhdmfcNqYnnXQxB+Mg1Z
         Bpfeo42C7AORMynAEC+wkMmp1sMLVpJFMPcjc0bL4f5dGJWfCxfcPXl2QMaTBbrW12Ro
         81ZnxRLDdQPhn/gv/1dvcYlIG6Eu4xjP+umnwTE0QzED9/deyPw0tW7qwX42iBo3CSjn
         BF/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788875; x=1770393675;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2AWWerLZMG4Q7uaPxItqrZdOaOT2hXOvgOjXgAMwHsU=;
        b=NOGdF7K+eumnZ1VcpjAmMp/kB5SXWg3nDmApIjB9A1U2QWZ3KaBUTm0EQPu7u+PZlL
         gvxCf222b1ZynGJgnihD2iShWweLboh84uY/W5hLBuPbP9cU3SC/iVFUlvKhw/c/tLB8
         IruVlaB5CFCUM8AoaXmSV5nKyt7uELS8BLYSzzcvfgXUOhTm4N6Ksp/SBYHxL5yN976K
         bm8jWxkbn6AjW/NNk1ahGRuTXrWQnSRqwGWRfjLFFlUIPZbhe3wCttYLwwOOef5gjxYk
         5yCxa51fnx7zvm3RqkPzAvsEehDsLgXRvkxGkgbUdBYHuUTgVRE1vHqPBd6UObjiWpL7
         EhNA==
X-Gm-Message-State: AOJu0YwRCTyNKE4E/AQGk5A0/nm6QKa4YCA46q7JEMTvJH4rJ9p/y5Ga
	Zy3MA4qsOQpSkGbVndkRzfQ3hqB9JgExDgLPLiQwYEZKixR+6ecta3zwhOJJuaKeqLuu+SGWhkL
	+HN6b7+gHIlcJS7miKiG5llj52TzScLceYaJF6r89hony9aIIbrLWqHQvDzScRjEbwQHo
X-Gm-Gg: AZuq6aLub7RWTnx4sgjUvVPGHWUruju8PziCNBMc+NQd403ZO8cZ8YGHt/p/yhV81Zo
	4Wjp8k9EdQVewTboaPKOAZng1DhCizRhjgNwkye5eFKrXY4kIm7eMzG6H++LoRJVZHSFjn76m0m
	Djdvysvs3kJyaDFrOn8fx0uAnRjjsELvEAZmyO2bGoppFw46lZdcpPfxaCqCRJDUv9dHzNbca73
	mGmtyycefBMSRTgSSk02mat6TE75XPZMJKZuZa4eAwRKtevMq/5scqs2rz7GVJFyGuR3/5Kswc1
	9OiRP7kMyJk142CgqxZh93R5bTBdcpFnpzfrcpKVzeWvZHEQ5LLMp9PNEEZaPQUwFvP8veHSuRS
	XQLOPQA8jsgVJMoTvccE2JwoO0wyQvDtYVFcP1dfmwWU=
X-Received: by 2002:a05:6a21:498:b0:38b:dd94:936d with SMTP id adf61e73a8af0-392e00458a9mr3542579637.21.1769788874677;
        Fri, 30 Jan 2026 08:01:14 -0800 (PST)
X-Received: by 2002:a05:6a21:498:b0:38b:dd94:936d with SMTP id adf61e73a8af0-392e00458a9mr3542525637.21.1769788873947;
        Fri, 30 Jan 2026 08:01:13 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:13 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 10/13] wifi: nl80211/cfg80211: add result reporting control for PD requests
Date: Fri, 30 Jan 2026 21:30:36 +0530
Message-Id: <20260130160039.2823409-11-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: bk5-92aRqkKMcjcPv-eoedQTeTcQkddo
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697cd5cb cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=3MGohSyn54gvIuBB5foA:9 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-ORIG-GUID: bk5-92aRqkKMcjcPv-eoedQTeTcQkddo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX/UG/LADHHPC4
 gHCSeQbY5uHlPh6t1foprcVOflXGj+5ynVvQwvGZWFRV5sPClBw1ycmkl8coHM64sk0jdTwxCSG
 3SgK8x5Z+2V6tQFRwOa02mVVIMukQaU17A9fkj2SgtwkfbxHmdvdstyRjf8bM2psHhUMI0SNEh1
 GjFtXwF3rtQzafBnysCWIgmO8iFYAxtVsn/QruXD/5Z6jyc0ljvNDh77N7jDa1N4WflfMYTT1l8
 9GFTAN9ThLm5HpknzDuTqPa3AfolF9O/wZIwbXOiEtZbedKpkr+hgrhmG/XO0QTJY51L4GdZZKI
 gMH9y9cuVRL4RdeZ0o3bT1laILpX7nyE+zkAzzCuVGZ3RA70quR3ritiC7vf2+pL4G/jJOMLpWF
 yd2Um808C4AaHi0pykaRChISAnuidi59VckLKfzeY1rcHPUCnEYoDlMW1Zvi5dxHNmv8H5z9Tw5
 zViWRhnpF65+JANDrnA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 impostorscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31394-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: D5351BC59E
X-Rspamd-Action: no action

Add optional result reporting control for proximity detection
(PD) requests, allowing userspace to disable ranging result
reports when measurement data is not needed. This reduces
unnecessary data transfer and processing overhead for
applications that only require proximity detection without
detailed ranging measurements.

The implementation validates that result reporting control is
only used with PD requests and ensures proper configuration
when operating as responder (RSTA role). For RSTA operations
requesting results, either LMR feedback or range report must
be enabled to provide a mechanism for result delivery. This
prevents invalid configurations where results are requested
but no delivery method is available.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  9 +++++++++
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 890d4b007033..00ef211f20f1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4394,6 +4394,11 @@ struct cfg80211_pmsr_result {
  *	in this case.
  * @range_report: negotiate for FTM range report. Only valid for
  *		 EDCA based ranging.
+ * @pd_require_range_results: flag to enable receiving results
+ *	for PD requests. if this flag is disabled then ranging result will not
+ *	be reported regardless of ranging role or the type or ranging. Only
+ *	valid if @pd_request is set. in case @rsta is set, either @range_report
+ *	or @lmr_feedback should be set inorder for the request to be valid.
  * See also nl80211 for the respective attribute documentation.
  */
 struct cfg80211_pmsr_ftm_request_peer {
@@ -4419,7 +4424,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 measurements_per_aw;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
-	u8 range_report:1;
+	u8 range_report:1,
+	   pd_require_range_results:1;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index af80248d24a1..85223b16eb84 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7995,6 +7995,14 @@ enum nl80211_peer_measurement_ftm_capa {
  *	(units mm, u64)
  * @NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT: Negotiate Range report in case of
  *	EDCA based ranging.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT: flag to enable receiving results
+ *	for PD requests. if this flag is disabled then ranging result will not
+ *	reported regardless of ranging role or the type or ranging. Only valid
+ *	if %NL80211_PMSR_PEER_ATTR_PD_REQUEST is set. in case
+ *	%NL80211_PMSR_FTM_REQ_ATTR_RSTA is set, either
+ *	%NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT or
+ *	%NL80211_PMSR_FTM_REQ_ATTR_LMR_FEEDBACK should be set inorder for
+ *	request to be valid.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8024,6 +8032,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT,
+	NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bbb80032d615..6d53eb3eb78c 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -374,6 +374,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
+	[NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index f89fcd9bb505..a55eb73e6938 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -260,6 +260,25 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT])
+		out->ftm.pd_require_range_results =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT]);
+
+	if (!out->pd_request && out->ftm.pd_require_range_results) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT],
+				    "FTM: require range result flag only valid for PD requests");
+		return -EINVAL;
+	}
+
+	if (out->ftm.pd_require_range_results && out->ftm.rsta &&
+	    (!out->ftm.range_report && !out->ftm.lmr_feedback)) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PD_REPORT_RESULT],
+				    "FTM: range results requested for responder without LMR or range report");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


