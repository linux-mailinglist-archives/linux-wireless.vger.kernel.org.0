Return-Path: <linux-wireless+bounces-31391-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOUJC/nVfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31391-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:01 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AE3CBC588
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1EC563046B82
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF8DC2F4A05;
	Fri, 30 Jan 2026 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="U2q9OT7E";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kkz+k+k2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D8D6341660
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788872; cv=none; b=EYVjkUiJEsNpQ4R91EXlHDYkGxweUcsOeDBKxeGoEmhXA6VhqCQ/5ROdYlgPRNbjI0/fd+XlTpeK86juozbUl8vUVM7OSjQuzX3IEwYJLZ75DqEWkcYwCTmNkXe7obEfgL2Z7/9pfM6301d9SJE7aIXnAoA7q8Cp1APf2A+Ff9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788872; c=relaxed/simple;
	bh=C8sxlC595AYYJRUjKzbTYA1MZGqBXsZhSDJomp6wTbY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jzeKi50csnI7J8/T5B2tlUzzYGx50e+qAuXlUVk0SPdkgX6Evj2SzrG4UCpcp5uPFV7yLNdQdLb19tRxa5Nke0VTF5od4IVCMAeHUk4HmvfSa97Zuje8ffvj7QB//GOFFbs9+Zsc3srxZ8Uresd9ACyXXSA/aA+EhOZq0t9nkpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=U2q9OT7E; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kkz+k+k2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UEcmDt2419200
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=sZbDPNYjiuo
	o1JcdXHlXmIfsRq8x/plB74K3MSXs9gk=; b=U2q9OT7E3aXhKPs9Zf9USrPYrSK
	lWZn69M+IH7bdkSyf3/ADIz0jDZ07z+3BQk++bnRGZ4Qq7devvu0dhLSlkzsmPJo
	FU6MCx7s1ETWwxI5d+9u2oYWXJaRtSmfmDUDdiOT52zdvDfVNXw6hl/5JvijDgCS
	zVWZy3mUOA1CfN/cDMufjxwS8La3GMkA5HF77FQ2xauexvBhoIDtEuDsFfhtZnjR
	ZZOHaGZ0kHf3T1pVo15s/39kKGOi4vIUEY0xZDNIh17NvCsABFk06EaZOmvdpoFj
	cQ6xXa0bvh2SAulBCTUwINa5iEwWcRIJ9DLgcEX+DLBdCzk3aPSgt8nhpxQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0r41hjn1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:10 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-822f926eff5so1113439b3a.1
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788869; x=1770393669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sZbDPNYjiuoo1JcdXHlXmIfsRq8x/plB74K3MSXs9gk=;
        b=kkz+k+k2MCv2L1f13H8W2DkIYP4SKx8ecNuRAKpQjgquerfu0gMPNdr/W6FKixCIRR
         2h/vjRvdzOuCwOu6N/HgGzxPAoB6e+tRbif/FLNfI29CTwMwW6vPuTJKd/QW1EUELV3r
         Kn/O977ujS5wAyXp/pl8xWosR6bi8cV/RRE1fJgWgtM2DXRVauF5snPWhrFH23mCEGlR
         GEve/UMazvUEJBb4mebS798ZIq8houk2SlJfCsomA3/GFx0ZBktrMWRafLGXhBCWYeXW
         isXInqiKkcjjO0dgP780qoeZ4yKr8NE9UXSWK4Bfoi2mZAUVVTwarAagvmn/uE204bO9
         mIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788869; x=1770393669;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sZbDPNYjiuoo1JcdXHlXmIfsRq8x/plB74K3MSXs9gk=;
        b=W30Ouq0UZmI8P8/VuBaOToGsatK06WhHy/STXvqrGEXDpssXWRcNbL1OjJrQ2mg59p
         jyO9Q/IvW+CE52+1i0w/hncZbCAywZwaAdSDhYds/dLEAdCoc6FxhBWtGXzxt8hFhyAq
         WznBPrOea8+YWVdAOq2hUASC0/ZPMldyFKMxtHI5N8aunqpWWRcoh4WwTqpz99Acug36
         Ar7buvZMDdOC4VSTWMu4mr5sGZRVh+KCwUSbvG+d4wuC/j/83u5TNyURAFxlOG3ktYP5
         hLRLsq1Jzc3+v9tPKtNzhNjLOpsztGaB/JCA8awnCSACktvhUty2vJnhLbUQ6oAmxCiy
         c/0w==
X-Gm-Message-State: AOJu0Yz7hUWz3IBYBa9ouVqN++d8hIHQK6NwEIfvAWdqq2DE/vpPZdaZ
	nE8wEeMWzLSTSDBZidZNgobEerK4avPbSZZAf9BGKiOQpFuNGEJiEy4di0CxQKUyLMSHUz8Ryc6
	u0VPvp6eNYLLM4aS2bh2hkx0Y44v6GesNUAHFOTmxPX4eGeCueKmdNcpy6dNDCVXUTMlV
X-Gm-Gg: AZuq6aJQgmWz14pB90Xd7qETvtZNFvAMCYhSFOmeIzUVgKUCCW06cF1fXf43gR/4JE/
	UWRrk4fH6TyDMc7mkcNFtF3I2ekYdQO/6SM4QE7XIFMNAI/QpNQ8cqzyJzyuf1TH0j6J9iUmjfM
	cBTByfPvmzRF5MsRx7ELy5Mixlju59Pra1GdcVFxZZb0RwrL9ByxlI6GnoE6nfK57LrvZ7jvS7R
	nvPP7GXNm0y/4okOEanASw+RBknJ11qK+0MiOXl+B7UpSiR/fADfqocD/QWuJNQ2uq3XYbd7q9Z
	ld6gGtbXd3hqYUZT1hCMt+31XAV+4G7hMW5zaOLEaczvtFmAwknuviLFu0B+7Z2EbmiWvqkhw6F
	v1CqKysqlMgpBjjutC+hxT1ExiAT5ArmztuIBKORxfUQ=
X-Received: by 2002:a05:6a00:1acf:b0:81f:46ba:1817 with SMTP id d2e1a72fcca58-823ab9a1e24mr3390296b3a.66.1769788868767;
        Fri, 30 Jan 2026 08:01:08 -0800 (PST)
X-Received: by 2002:a05:6a00:1acf:b0:81f:46ba:1817 with SMTP id d2e1a72fcca58-823ab9a1e24mr3390240b3a.66.1769788868047;
        Fri, 30 Jan 2026 08:01:08 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:07 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 07/13] wifi: nl80211/cfg80211: add ingress/egress distance thresholds for FTM
Date: Fri, 30 Jan 2026 21:30:33 +0530
Message-Id: <20260130160039.2823409-8-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: f4cMMod1iNRZYQAD5VkX-ul0phePNHOb
X-Authority-Analysis: v=2.4 cv=W541lBWk c=1 sm=1 tr=0 ts=697cd5c6 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=BeJEL0HO4be_EaA0mV4A:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-ORIG-GUID: f4cMMod1iNRZYQAD5VkX-ul0phePNHOb
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX4oWLn2ExKqI/
 LcVcCGbM+0RqppclzghaL37LH8TA667VjaYOWv+B9eZTZfvZshxNijliicYZOAP2fBJ0r4Pi2J1
 ZfyRa7IVhU/k3xi9h8CGA7MzKoZV/ZtaIj3Sv5hS7fcnf4dngm+EjCl3NfTrXorX8GKv5x8Drb9
 udO6Al7c0A9btyLXhGJu84KW8DEK0pMfONaBRZj8U7/l4Xi5nMQaNLtVQpjND0O9iigzUaasTxN
 xDaDHBEcGOusndfMZ2OKlIkWPUZMlPtmokb0dxr6QK0GI0TkMPlG9BILgeJwt7mcFWoXlys/iyJ
 gScTg/EHZWwzTf3vCvH/UEhuT3pvyKNnxvCwVZqVFB3zla096oOtjEgzHo2GV2/RT5ARR5gig2z
 /qSk5Q+aJZ78nmsjfWRZxK7Y2g1dioeG/00FY25VUmM1oDXP8/aXPbWlzj3SdWqswI/ovQn23xF
 xj1MdmvzBy5uWS5ro7w==
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
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-31391-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 8AE3CBC588
X-Rspamd-Action: no action

Add support for configurable distance-based measurement reporting
thresholds in FTM peer measurement requests. This enables proximity
detection applications to receive measurement results only when
devices move into (ingress) or out of (egress) specified distance
ranges in millimeters.

The implementation adds NL80211_PMSR_FTM_REQ_ATTR_INGRESS and
NL80211_PMSR_FTM_REQ_ATTR_EGRESS attributes with corresponding
u64 fields in cfg80211_pmsr_ftm_request_peer. When configured,
measurement results are reported on burst index basis only when
peer crosses these distance boundaries.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 9 +++++++++
 include/uapi/linux/nl80211.h | 7 +++++++
 net/wireless/nl80211.c       | 2 ++
 net/wireless/pmsr.c          | 8 ++++++++
 4 files changed, 26 insertions(+)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index ae63a3ead165..73ef64d86a63 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4385,6 +4385,13 @@ struct cfg80211_pmsr_result {
  *	in units of milli seconds. Only valid if @non_trigger_based is set.
  * @measurements_per_aw: number of measurement attempts per availability window
  *	with a maximum value of 4. Only valid if @non_trigger_based is set.
+ * @ingress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ *	measurement results need be sent on a burst index basis in this case.
+ * @egress_distancemm: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64). measurement results need be sent on a burst index basis
+ *	in this case.
  * See also nl80211 for the respective attribute documentation.
  */
 struct cfg80211_pmsr_ftm_request_peer {
@@ -4408,6 +4415,8 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 availability_window;
 	u32 nominal_time;
 	u8 measurements_per_aw;
+	u64 ingress_distancemm;
+	u64 egress_distancemm;
 };
 
 /**
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index b6c28c75e141..4d91c73a4ed2 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7971,6 +7971,11 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW: meas per AW field shall indicate the.
  *	number of measurements attempts per AW with a maximum value of 4 (u8).
  *	Only valid if %NL80211_PMSR_FTM_REQ_ATTR_NON_TRIGGER_BASED is set.
+ * @NL80211_PMSR_FTM_REQ_ATTR_INGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves into this range.(units mm, u64)
+ * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer needs
+ *	to be indicated in case the device moves out of this range.
+ *	(units mm, u64)
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -7997,6 +8002,8 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME,
 	NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION,
 	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
+	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index bfe88f7068da..b1865668feb4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -371,6 +371,8 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_NOMINAL_TIME] = { .type = NLA_U32 },
 	[NL80211_PMSR_FTM_REQ_ATTR_AW_DURATION] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = { .type = NLA_U8 },
+	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
 };
 
 static const struct nla_policy
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index e1b4cc7244cd..c9915b1f57cb 100644
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


