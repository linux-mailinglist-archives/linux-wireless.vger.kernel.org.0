Return-Path: <linux-wireless+bounces-35032-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEdRBqvt5WnxpAEAu9opvQ
	(envelope-from <linux-wireless+bounces-35032-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1393428B1D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 11:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B2EC8301CDB3
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Apr 2026 09:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 369F0382372;
	Mon, 20 Apr 2026 09:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="pbdJI/Ez";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j95sP4XZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8C338B148
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776676197; cv=none; b=eQNjFT2w8YUu9lag4bjHnqKm2f9stp6K76mJGQgvdzwvgLiOXxgJRT5DxslpfC/FYeRDYbqK9CXCfJxEujy1QU/T5T3q9SlffEBcu8yGZ5ZVujnDJi+0ORA1FA8Ks+QU3wSKDbCOnJYQEKfs/1DHJMUzvIEuruG7V05dlzp0QRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776676197; c=relaxed/simple;
	bh=n5w32pI9oll6vV+hVvhT5ZY9vGIBvu7aMsgDm8kAi7E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MIlXLBduJRzf2TP5mG4K/hAcha8yKvtILPymsLfbJIjO8N3dUptEwJqnd6l/JV293pEBsV1beYELvqXyElMEPUYHJTsHbyO1k71kkkm34rb9S27qdDVH3Dr+Cd6TBvkYvz95eSvdMsAwxyb4OvuGOjcUjg0rymLTUjwnz0/gePw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=pbdJI/Ez; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j95sP4XZ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K7Tf6Y3682699
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=dUERyGPtK1s
	+YEpXPtHulE4bFc2eKpVzF/PFjvIYP1M=; b=pbdJI/EzWsbJSBp9iVpcheMVbwB
	wYhcKnY0+9NGN/epUSnVXteB6pTaqM6bgaMunlZlxnL3FwC9M8+eLyOPu1/9tQIY
	Qj4ltXR9Nas67eCGENISNBaIxaO+IpbKvxU8AXQGy0WB4vWTxYm/Mcgg0wTssDOx
	vN4uP4klc1Ypbsl3dHm0XbwAZpf/LQQxlsm/DSwLbKl9Of6PuvaVWwrlr7nPRzxP
	3KyVR5QXQn4RK6UIhpuBEcU7iojbvRgMimVFGAYm9z5dipiPibfEu7YQlGaPiCEG
	mAD7ApqO2oZ3cDXk2Y4BSZJD55kZ0c4R90QzDpPy7z5lHLsHlxcwOKIdXdg==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm388n774-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 09:09:54 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-35da97f6a6dso2612393a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 20 Apr 2026 02:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776676194; x=1777280994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dUERyGPtK1s+YEpXPtHulE4bFc2eKpVzF/PFjvIYP1M=;
        b=j95sP4XZcmjQvV0NOGl5g0UmYf6ctAkPUS2+mt803bJza1kY3/GAkve5xwNqFnLjVa
         8esRTCV5OizZyE4FfzIy5nDxMBupu4HHlTIBjCV/ip55apt8qDCR4w3+WxYrutWuTkMk
         q9NF+orA9EGhelAFBnr4yYztPVurxT/ZIAZsPYIcUkfq5/jL1QUkCLYK5a+cagCxCEKU
         A0qXXEvJJkfZ9HRgTi84Nwwy63myxk0iq5hpi6rU9PiCjBebaMbrQxIjcFfY2uyBE8rk
         4osZs6Q7NgjRXO76MnB4HwE1/+r80ocj+A0yMdpMSOXYpnuDW+7F8hsWvgkwpTEJxfQJ
         PNBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776676194; x=1777280994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dUERyGPtK1s+YEpXPtHulE4bFc2eKpVzF/PFjvIYP1M=;
        b=EdKLQGFH/RoSjufjwn7vTBcnEgi0DL15EpD2ZYhIUqwgILssTKNiVX8FYb93Jn+E/C
         d64u96B0109akpXC6JIDDOqTT5cOJkcAj5PuAKWFaZwxuqY/vuIedYEHKDkND+TYO35g
         glLQBTXiDmZ0xhsNBvTemroDI/pe3s0G5Kz0GajPCDfUv7XSsvLv9DzmRjTZgryYdGIE
         2anVOqF/RyOOfIexBxnxqEm2YQ1B03QtObrnLjBCRtVEHxZM7ls3iUl33TePzAzTQxzI
         rEBfVBLqhbgkGZ2m/LG9lCgBjMU8zrygkDYfhap9dW85SZ7tMtaaQ36UxWEbe+hDTetd
         crMw==
X-Gm-Message-State: AOJu0YwRhuRuD5wXdFvshhNq0xFf/ZXd8dHaPjvrr9UMLUK+zmsA2+0k
	hPYFKZREEOYIJfs3xYogpKOby/ZY7lmfF20QG6uxPhj7CagJ1BgiozoblMU24z/k7dOwuTD80/f
	aW8YmwgFpUae+jyMNp+cUI63BjbpZLUEwi4gY1IAFkFDEOYJbvKwyYhywFlyGHFrY7nKS
X-Gm-Gg: AeBDies/3+XCLYjxFXRDbTcaXJ5LurVyYDUbsQ2KeU3ZzM3KNeK0zR+Y9hubMPSqC+y
	Uos6bwDv7ajL+no2lzm13DqJdcKgFWhL6hTkCWZD0TLTY06J93aJklpheE9X8Aoak6wKW8KepPB
	cqe4MidUJwtwWdh9PQZncNxO1hEglEiL7/FsrO5HroU+IVjX6cuov15oY8JQJbHfVvaq+ro6YNW
	SA7WIXbyhHvqEkwVWB8OnJ1OXiU4IT5P/ZSk+acR99wbi10v+4AIJUL1QlERCOVpPR8xo+t7fgn
	3k1YsZcirIASd8+mRSerGrIkJQOYjm9rkj4U3OSb8jYyJgBntcuneSOZv7DI2OMWR4/yYfJzDZc
	bdN1snlqFUnPNxdWhcdwzMg93JK5+GHuMkZZkt3SJHcsPlyq1Lvb8ixfnkr5eVdUCMA==
X-Received: by 2002:a17:90b:2891:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-361404ae963mr11906317a91.22.1776676193621;
        Mon, 20 Apr 2026 02:09:53 -0700 (PDT)
X-Received: by 2002:a17:90b:2891:b0:359:fd9a:c50c with SMTP id 98e67ed59e1d1-361404ae963mr11906295a91.22.1776676193118;
        Mon, 20 Apr 2026 02:09:53 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3613fba1436sm3812551a91.11.2026.04.20.02.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 02:09:52 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com,
        peddolla.reddy@oss.qualcomm.com
Subject: [PATCH wireless-next v5 09/13] wifi: cfg80211: add ingress/egress distance thresholds for FTM
Date: Mon, 20 Apr 2026 14:38:52 +0530
Message-Id: <20260420090856.2152905-10-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=GthyPE1C c=1 sm=1 tr=0 ts=69e5ed62 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=EUspDBNiAAAA:8
 a=gamxJzifOTb9NOJThcEA:9 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-GUID: -HBpPzHZJ2I5W5mDY-3_skcKOO6kZGV3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA4NyBTYWx0ZWRfXw3nHfKvqHKgT
 ECLn44AyTkwnDS9Qqvu2l2BQwYDSKBsF8Go0uFSNDW2rQYvHgpsFwZeTuBIr7F82br0nsXkPt0+
 2v2tAuSjR19uKBcui76b2kLhPSQkc2qvIrEg1e9thgvVRAvjQQmYfX7QdImTG3CE8VUUU15xw0R
 VzX6KRrw8fiuFnDPWvyqWO60IPBpFAgURJFFUuiQnW34BrI25pNuTbTKT8ADb9LzdgqDvcLFDzA
 V1xqCn5VbC8ONMzsEX9EvJcXsp+t4rXP6JapUp/GR8m3UHIuzCbkbdE7ut8u+Bmby4FnAUrfehm
 ZQOwy66/Tl9KTPkK/grFJgxJ9VmjM2BthWt2/jSCfg1KE04waEMX/fyh6NLXA/3BO8ehRjS3hT6
 NQYv5gegk+fl1BI5bw4nmKgCnquO6T2PPhdSz0z85+I3hAB7wi31waWd2BSgVXnGsw0yXKQfIVJ
 ComZd8Z60TQSCsE1mXw==
X-Proofpoint-ORIG-GUID: -HBpPzHZJ2I5W5mDY-3_skcKOO6kZGV3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_01,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 malwarescore=0 spamscore=0 bulkscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200087
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35032-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C1393428B1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Proximity detection applications need to receive measurement results
only when devices cross specific distance boundaries to avoid
unnecessary host wakeups and reduce power consumption.

Introduce configurable distance-based reporting thresholds that
drivers can use to implement selective result reporting. Add ingress
and egress distance parameters allowing applications to specify when
results should be reported as peers cross these boundaries.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 14 ++++++++++++++
 include/uapi/linux/nl80211.h | 15 +++++++++++++++
 net/wireless/nl80211.c       |  2 ++
 net/wireless/pmsr.c          |  8 ++++++++
 4 files changed, 39 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 8c82f33bfc40..b16f36473b2f 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4619,6 +4619,18 @@ struct cfg80211_pmsr_result {
  *	exchanges as configured by @ftms_per_burst. Only valid if
  *	@non_trigger_based is set. If set to 0, the firmware or driver
  *	can automatically select an appropriate value.
+ * @ingress_distancemm: optional ingress threshold in units of mm. When set,
+ *	the measurement result of the peer needs to be indicated if the device
+ *	moves into this range. Measurement results need to be sent on a burst
+ *	index basis in this case.
+ * @egress_distancemm: optional egress threshold in units of mm. When set,
+ *	the measurement result of the peer needs to be indicated if the device
+ *	moves out of this range. Measurement results need to be sent on a burst
+ *	index basis in this case.
+ *	If neither or only one of @ingress_distancemm and @egress_distancemm
+ *	is set, only the specified threshold is used. If both are set, both
+ *	thresholds are applied. If neither is set, results are reported without
+ *	threshold filtering.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4645,6 +4657,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 availability_window;
 	u32 nominal_time;
 	u32 num_measurements;
+	u64 ingress_distancemm;
+	u64 egress_distancemm;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index a42bae666d02..1400adfee10b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8330,6 +8330,18 @@ enum nl80211_peer_measurement_ftm_type_capa {
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *	If the attribute is absent ("no preference"), the driver or firmware
  *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PAD: ignore, for u64/s64 padding only.
+ * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: optional u64 attribute in units of mm.
+ *	When specified, the measurement result of the peer needs to be
+ *	indicated if the device moves into this range.
+ * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: optional u64 attribute in units of mm.
+ *	When specified, the measurement result of the peer needs to be
+ *	indicated if the device moves out of this range.
+ *	If neither or only one of @NL80211_PMSR_FTM_REQ_ATTR_INGRESS and
+ *	@NL80211_PMSR_FTM_REQ_ATTR_EGRESS is specified, only the specified
+ *	threshold is used. If both are specified, both thresholds are applied.
+ *	If neither is specified, results are reported without threshold
+ *	filtering.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8356,6 +8368,9 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
 	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
 	NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_PAD,
+	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4f6612311de3..0e0c66fe39db 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -485,6 +485,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 432d34be7945..46c444d0327b 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -264,6 +264,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 				nla_get_u32(tb[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS]);
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


