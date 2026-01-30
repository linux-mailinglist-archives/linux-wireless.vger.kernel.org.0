Return-Path: <linux-wireless+bounces-31392-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AEieNwHWfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31392-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:09 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82AC7BC58F
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95E27302410D
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F04F303A3B;
	Fri, 30 Jan 2026 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bJB9uGYu";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="VNl55TLk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7B4432B992
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788875; cv=none; b=VuaxrBJnblaeHQpWz0yURgjnw37z2ujF/pCQeiM3qIl+b/lsOqSlu8TcLb63zwbL4JlwPa3NBVijj6zsI/WJzYXMMTaoDfOJ9PirKfc+l9IjIFdrYpyJN5PoxCXVwfzdhXGFjdOcJZaBEKkcbIvkGZ5DH+FmFJ1NbrhvBxFfWck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788875; c=relaxed/simple;
	bh=KdA/xa6HiDzKUjIddqJXvoBVF1VGrdukOTZ6wcEDtUM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bGTodp38JZ7d3BgjiBbheXmyPt8mptSp+CvGZZ/7qSKTAvwOlvAnqDz1kBi0mo7mFlr/z9kmVpoIhun6+KP8+CtWuss6HAwbH4FHyJM4KnO8CKDe5OxkyoLuQXUPEh4DAS+QBZNKPHc+mgCerJbNGNlWykguLXSYLDnS7L7JMc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bJB9uGYu; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=VNl55TLk; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UAoXbO995907
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=xh617qGgHBW
	Q1Y9BNS3QowATTZL08x/nq0KYIgORb+c=; b=bJB9uGYuv22jPPcrtLKOR47sPsP
	UlYe6q2fIAl4QhCKqBNjacl6BZSKmitUG9Q+eMcEJ4+DnvdBQnIVdXVoj6KVbfi+
	Zm+TnsfGONTp5qtpr/zd/smficDhBKzGCACvoZTXKbu2zwHsI7+WMts9JXLYZJzM
	jp3WbZcaj4OdsOVCT7KSRPQ7x5rh+WVgE0Iv5yFkU5qVI2iY/fqsiQbZS3NOkwEs
	J2kZL6nan67CrwctfItHQhTAvZOfQFVPe+F1qP8n2XTuRfICiHkyICmEvD5xJmfN
	AI7j4bE/QdJWhy3gXSq9jj9P4058AQZlLfWFhh6eGUvxjPwtiHgYIV1FXYQ==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0bvvkqts-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:12 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-81ecb6279d9so2349797b3a.3
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788871; x=1770393671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xh617qGgHBWQ1Y9BNS3QowATTZL08x/nq0KYIgORb+c=;
        b=VNl55TLkBJsHchHvMV7GCdk4D7Cyk3a19gflllfYTBRyBDFg6cxgiGRxMskDRoNog4
         coMgNvjeKAls/BVZmqbx9ZrnKH/8+ZyQV4qNDeLvBhdj5fMTVYr+6x9OaD5W6pqorRku
         2IU8G17BhmgiBstk5MycTwqQ3lo7xblarwXxygogRtriH/3es+YPetFxZ/htZVv24VDR
         Qw4dj739OuAHo1w6Q/SU07kK6KBYUDdgkQp4+aQoLhngRfHZmz17zANV9LyHOD/sYMPZ
         2od16ki/gGMsc28bBNf9Csg0iTov9XdD4ZFKNeVCQMLYiKOTI6kcWl8wpftuo3fKrwjB
         gO+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788871; x=1770393671;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xh617qGgHBWQ1Y9BNS3QowATTZL08x/nq0KYIgORb+c=;
        b=W/d8w7ZZTa2c09Lfz2qY2Qm8aLCIAJ4RZ2xzrQuULs1z2avDh0KaGbCYo6m23aUqA9
         HGoe3+JNO7ULjW8dDSgh5JTkqMQf95Ycom9e/i2NOule2fHRbIK8m3UhOQ8ZmWYYRABX
         651XHRkY9KCuxpMsRZVT1wlkqx/ad0NGD1/1AwFLkMLlJNjGIU5Z3W38oVb7LqqF3Ts6
         YEcitn3KBMnYpPx3VCmZeQiYESJ4kBgdt3QE3KIUf3B3ubML2N2Y3RyA8Nk2uKsSnPHY
         eS9Z/Jqw1C/NTgwWscJr688RbogpI5BD+FxboWCmS75y+14guhitg6WOw/OZ5yKlgP4x
         0SBw==
X-Gm-Message-State: AOJu0YzvJE6C1Z1MphEO6uWrcdKA+voZssKyhtzJn6xVH2VKOppXpAQU
	0ytL2bO56qMMzHepM+w+TL0bYxValvDVCstZGklKP8kTqZOYDuTJI73ImEv9Q/ZILxThsHlTEKj
	a+NHTFr+0GmlKzc83NK6YCvA3iMkMO4VvwCIrH15LlrvqUVjbcxLfMzVOX/g6gWGbV48PTH1cap
	4y
X-Gm-Gg: AZuq6aKIaknkbVkGlYFzHhdrRRmWfl8cQKxcdsCyb/W0O6ZJRlPtwy0G5oDbCHbMM1P
	e6wzHDUWI5XYjbBl+8d1bmKUjKoUNKDIj7ZaXpnUF2QeW+brdaxlc20EDAwdtIWqgi34x2Cx2+5
	DN5LWiq6Rj0phh6Qe/54BJMoe7CvhxjLPPfhAHxQwI0ESsZjO8NItjOXL7blXs/D6TjmMLDhP1Q
	U/YhL/e0N22sKpRQOQIIalwuX6ds5j2xECjuiH6OrlbHF+HQ6UJyo4gtfX0MNd3DaloujjAgFHS
	qyG6YF4rWweKzM5lMyzrAJIDCDZtlqLtzUVxxBxtFiGjtu+CKo1oSBMVBnpJ0Oll+Elv9Nhm/Op
	pEL3HOOqxqNvT+/KTH7WAbfloq9duWdAd7arfqUxJM9o=
X-Received: by 2002:a05:6a20:d48b:b0:2fb:2e04:eeae with SMTP id adf61e73a8af0-392e003d350mr3482569637.21.1769788871293;
        Fri, 30 Jan 2026 08:01:11 -0800 (PST)
X-Received: by 2002:a05:6a20:d48b:b0:2fb:2e04:eeae with SMTP id adf61e73a8af0-392e003d350mr3482470637.21.1769788870069;
        Fri, 30 Jan 2026 08:01:10 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:09 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 08/13] wifi: nl80211/cfg80211: add PD-specific bandwidth capabilities for FTM
Date: Fri, 30 Jan 2026 21:30:34 +0530
Message-Id: <20260130160039.2823409-9-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=ZdEQ98VA c=1 sm=1 tr=0 ts=697cd5c8 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=baz0SFNEh9tLq6XKQnIA:9 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-GUID: RxW31ClRJEXTAdHnTNJP-jmwQ9Srr0cK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfXzyBoUUdbN4Pr
 UyQyL9hyJJEm9VwC665Klk7FbffsTphp04bTC864KAA5hGSuYY++1jX09pHgoD6gYK47ibB5gB0
 Ta0nn4IyKq/yB4vu57GsW2Jh4BM5EMnX5IBgyTEdZSRzYnpRDMkGw7n+5SROTzP6+kNSDYTJTNd
 uSI9IZ3rjmrd9mZPvAmcZLxUCoSB/j3hS4C8TN4Tr7ykoJ0C1cvDkLRj7clh0eVI89hFth/jIAf
 tKqjvGb1UAoBz8wc14561D2PCE+ktYp/jVE1A6PSDGrS38HtpmoZ0SIIAtJ1KEteJP6Bi4EM97n
 L5V7/BQfMLCARZ2f5hM2e1HAOCZ9PAh2AFvQ39uGIdQ9G8Joo7UlI5JF6fhzG4spJ7SSzZM796x
 Aa7hrO8XrF1X4wagKkfpS684HsKSmJgniFTOQSVFBW2dt4spAvtNNv3wihE+dF8EyGwJ6vT/AQX
 wFmSPqp81ozPwz7iDeA==
X-Proofpoint-ORIG-GUID: RxW31ClRJEXTAdHnTNJP-jmwQ9Srr0cK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1011 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2601300129
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
	TAGGED_FROM(0.00)[bounces-31392-lists,linux-wireless=lfdr.de];
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
X-Rspamd-Queue-Id: 82AC7BC58F
X-Rspamd-Action: no action

Add separate bandwidth capability reporting for proximity detection
(PD) requests with EDCA and NTB-based ranging. This allows devices
to advertise different supported bandwidths for PD operations
versus regular FTM measurements, enabling more flexible capability
negotiation for proximity ranging scenarios.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 ++++++++
 include/uapi/linux/nl80211.h | 14 ++++++++++++++
 net/wireless/nl80211.c       |  6 ++++++
 net/wireless/pmsr.c          | 10 +++++++++-
 4 files changed, 37 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 73ef64d86a63..5224a68867cc 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5772,6 +5772,12 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
  *	request for EDCA-based ranging
+ * @ftm.pd_edca_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with EDCA based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_ntb_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with NTB based
+ *	initiator or responder role. ignored if @pd_support is not set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5807,6 +5813,8 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_ntb;
 		u8 support_rsta:1,
 		   support_edca_responder:1;
+		u32 pd_edca_bandwidths;
+		u32 pd_ntb_bandwidths;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 4d91c73a4ed2..181595ec960e 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7863,6 +7863,18 @@ enum nl80211_peer_measurement_attrs {
  * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
  *	the minimum NTB ranging interval supported by the device
  *	in milli seconds. (0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS: bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based EDCA initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS: bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based NTB initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7893,6 +7905,8 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index b1865668feb4..571d96a5ddf4 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2378,6 +2378,12 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 			cap->ftm.min_allowed_ranging_interval_ntb))
 		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+			cap->ftm.pd_edca_bandwidths))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
+			cap->ftm.pd_ntb_bandwidths))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c9915b1f57cb..0ed0f401db11 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -17,11 +17,19 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	u32 preamble = NL80211_PREAMBLE_DMG; /* only optional in DMG */
 
 	/* validate existing data */
-	if (!(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
+	if (!out->pd_request &&
+	    !(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
 		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth");
 		return -EINVAL;
 	}
 
+	if (out->pd_request &&
+	    (!(rdev->wiphy.pmsr_capa->ftm.pd_edca_bandwidths & BIT(out->chandef.width)) &&
+	    !(rdev->wiphy.pmsr_capa->ftm.pd_ntb_bandwidths & BIT(out->chandef.width)))) {
+		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth for pd request");
+		return -EINVAL;
+	}
+
 	/* no validation needed - was already done via nested policy */
 	nla_parse_nested_deprecated(tb, NL80211_PMSR_FTM_REQ_ATTR_MAX, ftmreq,
 				    NULL, NULL);
-- 
2.34.1


