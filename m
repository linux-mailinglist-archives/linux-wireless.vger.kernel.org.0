Return-Path: <linux-wireless+bounces-33606-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iN+tHJyLvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33606-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:04 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 156762DF137
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:02:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AC3B8302BBC8
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8C83DE42C;
	Fri, 20 Mar 2026 18:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="UjavDzXB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="N6fNq8Ao"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4B3335BA7
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029659; cv=none; b=ptDj60DIcaZDlj7c0W5Mcf15YG96lsrGNZTImR0BTitjJPt09gXT0cM291MY0Ws+EQRGw3S2vPEHi+vuWhVMc3jaWsDRY4Vrldg1uypQNQcs11jgY+bWq/WoN1sjzr+GzVul85kkanVa3E93mp4qdXG54hktLwgBM5/0pGujJog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029659; c=relaxed/simple;
	bh=BR6CdygtE3bFtcZqbYP+swe0RdK7bk7q9YTZlYysSeE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Skh0WXHm9PaQhXcicRQFvTPNQkU7eE80SCAw7RO1YHrMj53WP4GlaOaEKj9YV7abXKTQ3lVRqfBuuwVX40Dg6gw45UGTawtIk1i8Ugy4hQ4Nz+LLy5VhrJRZ+Q/1FAOv0ttaDg9ioOGdzog3vCfARAcGMVkH3H2P89BgvFwT0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=UjavDzXB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=N6fNq8Ao; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62KBsWc33876030
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=gk+h/P+7+tu
	lkpmDdyxpfQkYb8oFl4ZGLk92TWp6bys=; b=UjavDzXB70b1mjdYgE/pKuGt44q
	BFkB4qA3O2pi37t2/yd0aGnK84zrl/3cIGMNXdpZQoWBhHTYIeQLdJaPMxN+19uR
	emLdNWHoV47KaJXEe5F2eAO/U8101IotQZnQ+OIAm5pJDBPScKurpfrTwLtWbJYA
	+cY7H94MtD4kKl9bP5LRu5iytVNnXKv1c4VVVbvLe7WzduXSudvOQY5b/0Enz8g2
	SN6PRBwv356K2uZOx1qp4+yR0sV4sDaOM4417tvaz31xsTLSEi2nnSaoMbp2lOQr
	JJGjR4a/eUWzb6bWozcqS06uq1cb4wLHJ2fsIy2GiagrZTw2SAH2Fj1ANCg==
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com [209.85.214.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d15s08ws8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:55 +0000 (GMT)
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2aed1beaa73so23692685ad.2
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029655; x=1774634455; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gk+h/P+7+tulkpmDdyxpfQkYb8oFl4ZGLk92TWp6bys=;
        b=N6fNq8Ao/sJEc8PE0fPzUbT+1ZXbVG+5Ju3yrMUqPG2aU02OJT29KxHTICa8at+6Wt
         jAKywTFmq1FqxklImMT4syMbMOT9T4BVZfb1igT6i3EG2N/ZmJee6CVDczLQBWDz6bna
         VmmXzM0/uzSIKMNC05lPBIxCtIK3G3Y6tbTRmL0xRWmvF/PhdFK0GIj70oRADCWVO3Ak
         592iYSCb2Z4laemEnHQZtU2l1zPRCSJjNEExMuuY3XlDkbxj7o/r+3JTLO3GNmhWsGVe
         aC33EkIcC8rPeWmozy9fVGmr22LQPkXSVxZ3+RZH5+iln95pmlvzS28mTlKFw020yYyn
         9TvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029655; x=1774634455;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=gk+h/P+7+tulkpmDdyxpfQkYb8oFl4ZGLk92TWp6bys=;
        b=MJ0P4+pZvtXiPKvNRvmwOIi7m1CokaKJAoE81pbpGeByitTtwJRP8MlO81d/yx7xC8
         /Z8jM7iFVoWIW/NOIaiHomcocQG/MeePlpsw/7orWn8ehZGfN2J2EiZqtSvVhhoMpKgB
         BE+zZveOaQ3yhdzVvvsbA+84/g9azW15LEAiLBUFbp2UdYm0hzaUxcRX30EmDZnlo5Z4
         2xXA04yMUssHgy2InHrmzlBkcxqYhJcm1SZS97P94dL4FoXo+v8RL4nQS/P25WUm6UAM
         JM06wYUp2vWlblUWOyByDFzpT+U2uqtPGBR2iuXuDz7d3lOKfZ5FYr4lZQXFBQ9SqUGz
         cTlQ==
X-Gm-Message-State: AOJu0YyXJ9OzXOgrNL7SZU0ubxyEw0ECeNVfQkOXaWFLTaidqKVpUS6F
	AGtH/paJxEXINP3TLMLgA8potXskuUrCt4jYN8NPifoipVX6vhmCmfMKDrujrt5EO+kniOjO20m
	0oS1ALSu2wpelZ7SECS1KUZaRHk7e4FgcwBN/ymWEG1gf8GpvXeYSUlTOAEGIY3Qu7lbt
X-Gm-Gg: ATEYQzwYgBlAnEOAHlyL9QLM7EqlEAXFNQzS1iIT8w72xfwA3jTbz0e4pTDpyD0oHsM
	37gQs9bhZfSMpx/qn6lu83R2v6UKsSyAzxJUJjgSQfdmQb6xeCAcvqAudJ2a2ST69pLaojEDf3+
	omaodgCaCe8MYPYu5hEPdSKDdH5jl2CKLIliIDMseThOXhetlEyrrOG4H4rgi2BY7m3WYhx8Jey
	FVIRpD3U3QdpeqF2HPNw4odG6Gguj1hXfvsxXAlGBpFzAmVBzOmgp8Tk8PTlpFmWcasPNaV7hDM
	o9QsJFq0TEiwoGPizsUJ5fTmYeVK4wpIJq+KK9Tm+WzW6ztvol6epFmRGbVWaVOtY+UosZM7i6b
	xI0VJ87XOQS39mn60f3lMbxaCMvXwZnOmor/9leMj6AdhUHiAO075Kyo=
X-Received: by 2002:a17:902:f70e:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2b08277b109mr34054365ad.29.1774029654491;
        Fri, 20 Mar 2026 11:00:54 -0700 (PDT)
X-Received: by 2002:a17:902:f70e:b0:2ae:478f:2ec with SMTP id d9443c01a7336-2b08277b109mr34053985ad.29.1774029653622;
        Fri, 20 Mar 2026 11:00:53 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:53 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 10/14] wifi: cfg80211: add ingress/egress distance thresholds for FTM
Date: Fri, 20 Mar 2026 23:29:34 +0530
Message-Id: <20260320175938.2547288-11-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-ORIG-GUID: QVr6OLbVSZjmhzfqYxcIwJSJWPFGkwEw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfXxrC5XJ7IDvyV
 sWCvTYkMONHLhMl8H/VTPydueqmIQNrP3wZtZqclWsEArYfwUDqOMIm0UsXxXl1Wpt37yjH+/4Y
 Txq1US9DenrV+iTKR7/HxasBKUBD8m0QLyCSZudiVccwn2iWeFRlZs5LnTT19ZtdAnmelfFPiIo
 Crbco7WXZlRM1ev5ytKbBTqJG9LB1NBqSe6HUYo+rSle7MAZskmcRnnRA2o2loGeK/eiNF2/8qG
 26OBGb8haLxsgZDt8rEDCczfCin4hnTIUZvRoKVBs4VyCKAY8T2Goyq7F++Yy8r4cFhSYY8l060
 phylYsAMm6ian3SMO62aOuIKyH4cigDcg6DRb0rJtlARolpfpmPEUQ4Gx3HUex28OAk7g9YeZQx
 wbIoU8I1dGOPmHRLISjBZSghza9ueeoh/miQNvg9WzTKGT5nZOR8XpVIwgD85ZASkl3WmTF9lut
 qUeFOrvDUUnE3mxmoDA==
X-Proofpoint-GUID: QVr6OLbVSZjmhzfqYxcIwJSJWPFGkwEw
X-Authority-Analysis: v=2.4 cv=KORXzVFo c=1 sm=1 tr=0 ts=69bd8b57 cx=c_pps
 a=MTSHoo12Qbhz2p7MsH1ifg==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=34tgYfNVuceZXYEjieIA:9 a=GvdueXVYPmCkWapjIL-Q:22
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33606-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 156762DF137
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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
 include/net/cfg80211.h       | 10 ++++++++++
 include/uapi/linux/nl80211.h | 10 ++++++++++
 net/wireless/nl80211.c       |  2 ++
 net/wireless/pmsr.c          |  8 ++++++++
 4 files changed, 30 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 9437533d0edf..651d1645bc32 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4449,6 +4449,14 @@ struct cfg80211_pmsr_result {
  * @num_measurements: number of measurements to be performed in total.
  *	Only valid if @non_trigger_based is set. If set to 0, the firmware or
  *	driver can automatically select an appropriate value.
+ * @ingress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.
+ *	(units mm, u64) measurement results need to be sent on a burst index
+ *	basis in this case.
+ * @egress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64). measurement results need to be sent on a burst index
+ *	basis in this case.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4476,6 +4484,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 nominal_time;
 	u32 measurements_per_aw;
 	u32 num_measurements;
+	u64 ingress_distancemm;
+	u64 egress_distancemm;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 1217fe492af7..c1ecf61a9563 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -8089,6 +8089,13 @@ enum nl80211_peer_measurement_ftm_capa {
  *	%NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
  *	If the attribute is absent ("no preference"), the driver or firmware
  *	can choose a suitable value.
+ * @NL80211_PMSR_FTM_REQ_ATTR_PAD: ignore, for u64/s64 padding only.
+ * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer
+ *	needs to be indicated in case the device moves into this range.
+ *	(units mm, u64).
+ * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer
+ *	needs to be indicated in case the device moves out of this range.
+ *	(units mm, u64).
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8116,6 +8123,9 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
 	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
 	NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS,
+	NL80211_PMSR_FTM_REQ_ATTR_PAD,
+	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 98eef98939c1..25e5d9d5c72a 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -395,6 +395,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = NLA_POLICY_MAX(NLA_U32, 255),
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
 	[NL80211_PMSR_FTM_REQ_ATTR_NUM_MEASUREMENTS] = { .type = NLA_U32 },
+	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index d2b43bf584a9..183b5cac015e 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -263,6 +263,14 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
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


