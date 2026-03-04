Return-Path: <linux-wireless+bounces-32446-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0BbPJlzcp2kRkQAAu9opvQ
	(envelope-from <linux-wireless+bounces-32446-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:44 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 401821FB781
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:16:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB201304932E
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C72934D396;
	Wed,  4 Mar 2026 07:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E0ZsVgZo";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="TrjQN4HB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B79B351C2A
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608595; cv=none; b=B/K2dLW7VtQKEWVzVxnS8DFIo0g/BkbX6w4bzTFXgtUlc1Z5CKZbNq62pEAUUIkFHCc7oJr5//Q3zTnwrmv4FSbqknB9j0I9kZh5a31HA6EOXIg0vOiXoTFVtARPraH/s0CA8IW8OW5SjV/zuyBVUqACVTiHk3KvfdeNCu+T2nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608595; c=relaxed/simple;
	bh=iz/EHO/iDTci1d5v1gM8zEWnGLGq4e4v5uE/YLU7B6s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Bl8Cs6wu3JuM+hU279i4ukEHyDPtJGf5uXQvql73KXXdcnBSVlA2I2U+vFd2MtLDAG0XhABdIgFxbsrZpuWMpHdLnZQa4RJzoU2gzj1RABB0S+2Igi+nqYlYRPb9BCdpbXQsQeAdfcsD130S0sccfCHvNTn5t56a4Hh3kywblC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E0ZsVgZo; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=TrjQN4HB; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SPQ31677902
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6gkVX7LTOXj
	LdtB8pEzSIy3kzZ69I24bVL9YyNz0H/Y=; b=E0ZsVgZoeI3eIF6Z62LYZZKkZ1N
	tI3OOQPKIxtzreFzOq4/KnBzjU9HdSWuPkA9DkpOr4OW7rrgfqHj86WYEOB0QhQb
	GR2QrdB4uDOgF/uANqTVEXwH64Sn1FrTuTLfWYlsvlT0/4y8adrLNUuw7pvYkgUt
	8sKyg/BpqPB0QA0PXd6vV3a748nBCL9e6wmY2oxeuRYY09rCGmOTHFNCjQpgHdqE
	hRWG5mwN+1X1UOoTXOTFnb4K7QOjyekAoJVV/M/pqmqe1yRBZjwGvPEx6iByWTbC
	V+yInIoosQk2OVRm7P+pwTVebp+iOjhB18fNXCz4FJrQ0EapVM9WkTbSbtA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp73h9ru3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:33 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso5245055a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608593; x=1773213393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6gkVX7LTOXjLdtB8pEzSIy3kzZ69I24bVL9YyNz0H/Y=;
        b=TrjQN4HBk7oPGOPvuaTUfJjpyVpHexGuqhpHHgkiASUu19lbJDMLclbmeQw+6NdtEf
         KVNOEY3kEDmEhRUuj4CZKxwl8HBrpMR1XqPgqTRbdSo7A/bLLQl1J66ftWHd0SBdfQZn
         yaZ55TyfjSHAVkbw62SsHqZPDcZctiTvzzGFtT9iexbAeJWLPBbHq7wOshW0MiLiHLPB
         +dBiujdwGI/nN1F0Hsf4kevRYuPkaE4P2NqJaxYNBsTPQOv73fi1N1h7qBZ1X6LuDexk
         YNDpaC0kLJ6BMvzA4D6qhKhwM0Latv8CUW80jyi4Ai9N8Svq1Aqh5VaWObLBTcOPOnoe
         3BXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608593; x=1773213393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6gkVX7LTOXjLdtB8pEzSIy3kzZ69I24bVL9YyNz0H/Y=;
        b=Pja7ivZh/3M/OVrE+ppRi2coFSrSSoLBPhv9gCS5X1AyES+bl+Re1uSH6i1PbAa89Y
         JhFx/ms1KDOK0R0HE3qkBt7u1LXIO2zNAbMOv5wLk71jrilGuUyGHFClwr1U4FDXncqn
         C6Xfz4HZjlDz22XcCAhSDoN/hcOC7Zedxa56buuyExNCSrWTtwCpgZT8stEXgdEHEQZ6
         OeVxaD2Zdy7fcBf+I9gfk7x+QmTfKaD86LtDJYxcqjKFvBInt+1eb9ZihVnbMKMyuzjW
         YNLitVFf3K997YmslTaRpe5fEwY6rjGH5MPpUYBxN66VvFn5RtNRiQcAckSheI9Qv0y+
         tTMw==
X-Gm-Message-State: AOJu0YwJH/AncrblqfxRCpxMc7mUW2UTn52QJ84T7hXgLBjnlfKYRc+D
	PG3uSRoJcXA3sPemk1XFciGtikENhsBZHNzNhNAH1939ul2/eD+tcre2Ue45c2a8F/mlCtxg/1q
	wtjzPOZFjWb61QeOttqMwTPnxLrd8Lj50FFKZdC35FeLDuVCljF9jqMQDNLx4g48uFldL
X-Gm-Gg: ATEYQzweVr4xNbYSgaH+fYFjbMa5tN2rqjPByDvGa/btv7PTzGATiQEJk830xKFd4l+
	2wBKKl6mM0xzgF0LeUrGOd2H4nziXgh2M0m5pO85pT0sz3jp7AO5Bns68mlNk7OLYpEkWinXtVl
	53oYnbabv7CDTDBKXjEfMz3M/Es+iBFxw9VmYczuhOF7MOsfb+3qR6e/y1jAzdOpUGuNwtBAxJB
	H3eBAYQaaKKXVUx20UC7RnT+H5QTgej6dpzFeLMGKrETRUfcyvV3YL0wPv31EOrohzXjkzFXzPm
	KYHVYcxQ4SN4gN3uiPYaE/eTpvY94IHxrbk1enfbgDqHgZB7YY251Czmlj3BHPO6U4U58IZxuNW
	C7a6xIifqxzETwSmbLVQiKreSvws84+K6gjEJJrHDzTGXi77T1hmu7DM=
X-Received: by 2002:a05:6a21:60c8:b0:392:e5eb:f0f with SMTP id adf61e73a8af0-3982e24369bmr1020615637.68.1772608592826;
        Tue, 03 Mar 2026 23:16:32 -0800 (PST)
X-Received: by 2002:a05:6a21:60c8:b0:392:e5eb:f0f with SMTP id adf61e73a8af0-3982e24369bmr1020595637.68.1772608592334;
        Tue, 03 Mar 2026 23:16:32 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:31 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 10/16] wifi: cfg80211: add ingress/egress distance thresholds for FTM
Date: Wed,  4 Mar 2026 12:45:32 +0530
Message-Id: <20260304071538.3833062-11-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: KTs0LILI23oPxXdx4rXKnJfhSks_iF58
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX/49ncjGEU2aO
 V7WK7a5U2ogdcOS57ZHAb16yf5oyPwjy97H+deAU9iFYUvIgzl4vIyuWs2BW6AyTpT2ZvA7Erqz
 nMK4vSrDlu2Jk4Pej6nkpfO3MswMhamB33tvDFGEhMqC2pyf5tT87GZmcNXWOUdLerh+xirssPv
 Ctj1tbWDBTOzX6oREXOpfSucEfCjEJze3JW+w4mEsz7m8+CFzajUwZPeY36D6GQ0tXfecGgeNbG
 vYI3HUpU1Mb5KBSoo9uVIBos3bOaMC4CzI1T1dOmnIdaD6DHkoj2wSERRwNBIss5iWdd9QL9T/H
 AEcUyohlrQ6h230dL1HI33zzn0h2+pPZleEYsYs/Nxh6XM8GUGlptveOMS/e+5Xj3PPEJJdmnkV
 vY/OJMYa29XBlk9FURS9yvd+UC8G8xcfTx6iS54sQsAtbEiof0wKUIWM/OhyJ/ZcojztnCAe/w0
 zhBbmvLP42fg+T6wFvQ==
X-Proofpoint-ORIG-GUID: KTs0LILI23oPxXdx4rXKnJfhSks_iF58
X-Authority-Analysis: v=2.4 cv=BpWQAIX5 c=1 sm=1 tr=0 ts=69a7dc51 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=34tgYfNVuceZXYEjieIA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 priorityscore=1501 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 401821FB781
X-Rspamd-Server: lfdr
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
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32446-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Proximity detection applications need to receive measurement results
only when devices cross specific distance boundaries to avoid
unnecessary host wakeups and reduce power consumption. Currently,
there is no mechanism for applications to specify these distance
thresholds.

Introduce configurable distance-based reporting thresholds that
drivers can use to implement selective result reporting. Add
ingress and egress distance parameters allowing applications to
specify when results should be reported as peers cross these
boundaries, enabling drivers to reduce unnecessary data transfer
and host wakeups.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 9 +++++++++
 include/uapi/linux/nl80211.h | 9 +++++++++
 net/wireless/nl80211.c       | 2 ++
 net/wireless/pmsr.c          | 8 ++++++++
 4 files changed, 28 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8bbca2a98ac1..1b663627a0e6 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4439,6 +4439,13 @@ struct cfg80211_pmsr_result {
  *	in units of milli seconds. Only valid if @non_trigger_based is set.
  * @measurements_per_aw: number of measurement attempts per availability window
  *	with a maximum value of 4. Only valid if @non_trigger_based is set.
+ * @ingress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ *	measurement results need to be sent on a burst index basis in this case.
+ * @egress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64). measurement results need to be sent on a burst index
+ *	basis in this case.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4463,6 +4470,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 availability_window;
 	u32 nominal_time;
 	u32 measurements_per_aw;
+	u64 ingress_distancemm;
+	u64 egress_distancemm;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 83d2a822c770..174592017486 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8049,6 +8049,12 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the
  *	number of measurements attempts per AW with a maximum value of 4 (u32).
  *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PAD: ignore, for u64/s64 padding only
+ * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64)
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8075,6 +8081,9 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
 	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
 	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+	NL80211_PMSR_FTM_REQ_ATTR_PAD,
+	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 5222ac8e8471..e6969578f4f1 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -381,6 +381,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
+	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 3ca0e589d7cc..f2bbbf8eb6f2 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -225,6 +225,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		return -EINVAL;
 	}
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_INGRESS])
+		out->ftm.ingress_distancemm =
+			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_INGRESS]);
+
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS])
+		out->ftm.egress_distancemm =
+			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
+
 	return 0;
 }
 
-- 
2.34.1


