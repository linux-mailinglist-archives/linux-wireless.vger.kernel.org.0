Return-Path: <linux-wireless+bounces-33608-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6HRgGquLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33608-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECC32DF156
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31EAE3025E09
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68C13DEFFB;
	Fri, 20 Mar 2026 18:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="HiTLx1Ok";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Ojaix4PW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10A1E3DF002
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029663; cv=none; b=EBa/YZJkpKjNPKutSFQQtbXtXFfko29AfevufGKb2sdTXzL3BvCaAcTtSTFyspzhn0BBhrm69u/f7X1lyvBeI/EAubUHMJhNGP+4PZhz+IVPTlM0/lTQd4G90hC6uBV/yXC0pq5mLEQtLyTI+227WQtmsK0OaRLc2fBvLj6D09o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029663; c=relaxed/simple;
	bh=gCSMQvWc4awfSAKn+3gWL2fzFGiFwDmJnoFlpD5mmO8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cg/L1rBsp4N2jiMP6iKEKNjS+sCPQ7OVa6/uO+UBJOsRhv3Ze8r6XgXHKSd2Pg5z3aIbF2saI8wPmOhhmgih8HkqlMkqShKswJlTUnzv4F7LoxxFaYkAVSbO0yh6/w0mlISR+1Ei3gGkeIXZ+s6jtuQXgi6l5T9mOjWW2pitqHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=HiTLx1Ok; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Ojaix4PW; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K94Vhr700901
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=rdgniGSMh3j
	O3VTNeiyKO9TnX73whGWim+IZ23xpPDE=; b=HiTLx1OkFWQJbvrlFAv63BMT/Oa
	RTmL4yxaESU4PZTpvc/DYLY7NLuciY+oUvwHTDacMBHRigm3HeYgivae0qN4ZreC
	KWpZry6biw03u/FsgsEG9CTwGZwzAJH9dh7uWn0IiqVu4q5NPXpXqqFQnUFvTMfX
	94V24HSfuuyZENTMuh0JGip3sKNGsfEj8B5vT623asW7wx9B+muB9UjqC9GKyJ7A
	26RkIxIvvTtCfr4b4tBF9DMqQgDwfgc2ABL463oXbIlShZ2NUASWArMCFJmsikZc
	oHKPjSZIlbsupXluV1RbbdAfc+SfUkPHhA4UM+VsHgjjcxmAcTRSWBWa07A==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d139q190f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:59 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2b05a3c2421so26096365ad.1
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029659; x=1774634459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdgniGSMh3jO3VTNeiyKO9TnX73whGWim+IZ23xpPDE=;
        b=Ojaix4PWZ0mt8nGvOy+fpv6Kvh3AdtJwhK36dd5M6mLOSLrawDV5Onx+UWV1FtpJmV
         GHuRk6uNiaNFdqTnBjn54WLY0vZ2kBbrhdtC1X99S4YYbcxoas87acsS+3ZHxKRAjllG
         ApU06FaEfyLiCqQGWc5AzJr/a9vBrpGOxaEIE+OcMb/Xp0jaI8OnXOZ0MG0PFeQk6TAU
         mosTj396n6ry71qqWXf9EGf0xk70MvrVpaB1c+FxXpK2lgeUCZQb92oqEnYo69rhVRmz
         JQK+VDHEY5Mhvf5l80xngj7901mo21Dv1MNyDuyLvW+EKlwv/OwcksFw0/NlcDqDypIY
         +07Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029659; x=1774634459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rdgniGSMh3jO3VTNeiyKO9TnX73whGWim+IZ23xpPDE=;
        b=py/XrQvAJUsLlnzum0ZL0OF+7BMhDnGBZKdr3zMKksx43qS4XfvLe6xup2xale3r59
         u5SeWynjSzfmUCIcybx/vDEy/P/8rH1jkmWZAizYSlI1vUgdP2KnXt8m0jeiRtoy9PJ/
         +R1Vxd/fw4ag9u1S+AiMCh7LsOp7jA9P2aPv+8CfNzLIa735GfeDiV0eN3VxRGLIciCI
         F66kiKANSvyKMfgamJ/iq5FipK3BWTu1JeLqwZT3bM/p/BJdolqZqcRHimRqzkB1O33j
         h7UEU2MrYO7mGnSFpf5wboPdT9bVYMLgNHtbVSZYeNa8nlD0g595cl8at6MxEKnUZelS
         Dgzg==
X-Gm-Message-State: AOJu0YwWQlFjbTi4NdwOiJ6lfb2KAX/xUZAWtCEvznLcuxuLjnGcXlFG
	YKhM4EqM2AP07kS8nRyRFUhvKmg29iHiEzYwu5Mj4gzfKli1aYDhaQj/PqCR75tO5TB1zl2lmz0
	jALn1nb5o8+WOyIvMxfdEZC6+40i9sQ9y10BQXtqlqYyemC0pBdbfVeY/QdGO/hs1SLhz
X-Gm-Gg: ATEYQzz+3P2d6erO31jpjf2btKi3x5nabUJ8TIg/4fly451xu5eymB5deoKdWoe1zgq
	YQzLsK9pcqeSadNm6sgvB96cJ9AZfN+I89aMdNonZOoqybB6gWDHNOC1ej2uVngaHvoDsR4xOo2
	H/2cjWfgeeljFvNDMOtWuFg5Zc/Xkhp3c3ngzMIS9QTJTJY6PYUhKfjH3YNypGSLRf/cDLvHVxE
	p6MjN3QT6LQ7PtZFh00hyARnI3e7DjH+DXbC6lylZdQkkrQa7UCTU8uwXVCTWoL0ywVZOpt/uv6
	MBgFtFsB36dA35C8gkBO/MCCSQDW/2dUK1qXbOkDsL3Tv82cA5vfj63ekWALc9ZAXsDSGCHWfLL
	v7jizn5JSCJ9eF9iVCUGGSLMHnM3G55TNiNvm++FZacJv9ac4fZehfjg=
X-Received: by 2002:a17:902:ce8b:b0:2b0:4b3a:9b6b with SMTP id d9443c01a7336-2b082715ee2mr36167655ad.19.1774029658314;
        Fri, 20 Mar 2026 11:00:58 -0700 (PDT)
X-Received: by 2002:a17:902:ce8b:b0:2b0:4b3a:9b6b with SMTP id d9443c01a7336-2b082715ee2mr36167345ad.19.1774029657756;
        Fri, 20 Mar 2026 11:00:57 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:57 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 12/14] wifi: cfg80211: allow suppressing FTM result reporting for PD requests
Date: Fri, 20 Mar 2026 23:29:36 +0530
Message-Id: <20260320175938.2547288-13-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfX+4p8VnG+Glzd
 zWihYUijZm/KA6Rhykuyb7EXApehxhkqLaxnAo9JCChP7bY6rqtZHOIgmTBh4aeI7FBON8EhuJ8
 EwoVmFnNKliA9Of7B9GI/3nq6LcxQif6fGeD9KObfbKB6HTwFZ50UZDpqn7b7+4Wlkg7zvJZK54
 xxAdRPt4ChQH3AS+b+qlesE8eYg6c9oTMz1fLrktOuEipAfeowlxNAa8hFeFlym0BJuGMPf90bh
 8/nIcmBdr6UDGQMlW7FQAVRMt1MVHzPwtI851HRFZW+YBrpi82LuPUpbc7eSahzMmXl+WpJIsBQ
 WlqxDElgvhRTL54JFGIOmfAGBqKy39DvZZJbs00ONQW27pm8EUMYWy5gpFWql5zXo3ATlB56Pym
 7s67yamUKFVkkwUaZ6EN3uzNJepvQaA6usgJPjkfCxbPnHq4Rg/FuKibmIzBqXU3VMp2sSUFlHt
 r9q0hL152ed8t6G3dvw==
X-Authority-Analysis: v=2.4 cv=FOAWBuos c=1 sm=1 tr=0 ts=69bd8b5b cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=0lZ_7x91LeotPFWbchoA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-GUID: LttqXz4OJFyn0y_bMgDGllNUMh1zF7Mz
X-Proofpoint-ORIG-GUID: LttqXz4OJFyn0y_bMgDGllNUMh1zF7Mz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-20_03,2026-03-20_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 clxscore=1015 adultscore=0 impostorscore=0
 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603200146
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33608-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_NONE(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 0ECC32DF156
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Proximity detection often does not require detailed ranging
measurements, yet userspace currently receives full FTM results for
every request, causing unnecessary data transfer, host wakeups, and
processing overhead.

Add an optional control to suppress ranging result reporting for
peer-to-peer PD requests.
Introduce the NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS flag, when
set with a PD request, the device may perform the measurements
(e.g. when acting as RSTA) but must not report the measurement results
to userspace.

Validate that the flag is only accepted when a PD request is present,
reject otherwise.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  6 +++++-
 net/wireless/nl80211.c       |  1 +
 net/wireless/pmsr.c          | 10 ++++++++++
 4 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index d841ada4ddc1..96abe2eb28bb 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4427,6 +4427,11 @@ struct cfg80211_pmsr_result {
  *	indicate the driver should set the BSS color. Only valid if
  *	@non_trigger_based or @trigger_based is set.
  * @pd_request: indicates a peer-to-peer PD request.
+ * @pd_suppress_range_results: flag to suppress ranging results for PD
+ *	requests. When set, the device performs ranging measurements to
+ *	provide ranging services to a peer (e.g. in RSTA role) but does
+ *	not report the measurement results to userspace. Only valid when
+ *	@pd_request is set.
  * @min_time_between_measurements: minimum time between two consecutive range
  *	measurements in units of 100 micro seconds, applicable for
  *	non trigger based ranging. Only valid if @non_trigger_based is set.
@@ -4477,7 +4482,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 ftmr_retries;
 	u8 bss_color;
 
-	u8 pd_request:1;
+	u8 pd_request:1,
+	   pd_suppress_range_results:1;
 	u32 min_time_between_measurements;
 	u32 max_time_between_measurements;
 	u32 availability_window;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f6bd944fea1b..d5ac40a385f0 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8118,7 +8118,10 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer
  *	needs to be indicated in case the device moves out of this range.
  *	(units mm, u64).
- *
+ * @NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS: Flag to suppress ranging
+ *	results for PD requests. When set, ranging measurements are performed
+ *	but results are not reported to userspace, regardless of ranging role
+ *	or type. Only valid when %NL80211_PMSR_PEER_ATTR_PD_REQUEST is set.
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
  */
@@ -8148,6 +8151,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_PAD,
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 74b7c4651061..cd4129ae61eb 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -397,6 +397,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d010d19d148f..21df12680839 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -288,6 +288,16 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		out->ftm.egress_distancemm =
 			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
 
+	out->ftm.pd_suppress_range_results =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_PD_SUPPRESS_RESULTS]);
+
+	if (!out->ftm.pd_request && out->ftm.pd_suppress_range_results) {
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


