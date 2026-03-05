Return-Path: <linux-wireless+bounces-32561-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gN5zGdaqqWlSBwEAu9opvQ
	(envelope-from <linux-wireless+bounces-32561-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C49D421529A
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:09:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C5CC831525FB
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FE93CF682;
	Thu,  5 Mar 2026 16:08:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="S8+utMxB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j09zhI5H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20A7F3CE4BE
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726897; cv=none; b=qBT+4aC5V4lfy08GoZVunxEPJLu0HCoUrCST+ohwjSiDj9cve4ijr3BYP4B+v+xKmntAM6ETh+/lUYiEhRi1TkrM0WIezLjUbBGtdtCP96LusAyIZebo9j+3UD1xfAxsyN4wI364JMVnZDKkOQ5zCqAI8tVk5NDnja9LXAjxeBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726897; c=relaxed/simple;
	bh=5iWeqSvCaa341dYGg7QfJLoIZZJl3ta6JGOuSACwdIU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VztfNwYeiBA0RUtY7QSF6OiUwsCR5KIoA35aK1lW2c86Btfe5jHPkBxDxHSgzaGxvy1tykLoqjMZc3fioqhctvA9MBk7QeywSQAKe9gpHL80fC+omNyW/lEN6BJFhdBmx3/NY9dyH0xVBd5y+bPOXWEpdjb/EHtad6X+KoUdqNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=S8+utMxB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j09zhI5H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFfVn2922564
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=LlFfO0epXMV
	cmS45zVN5cdHsuGzSapjHEN4SDtLEPhg=; b=S8+utMxBw7SUQg/sYN1IDlL3NOY
	wAnoTa/GJ2vTHNWxK3RvNOqVeSvYOdItpyGW7/o1rx985XcSwq+dxvq3uS+NU4d3
	QyqIuQw17qKE00gFwcE+fNAFiKNgrvqgTCjI60ZuAfcfyWyG8YsZ7fDTaDDJlKVV
	5xk/ekE8OkVye80dseY2glfcPCKZgfENgoNnmEOXnTfMQvagcn6/s6iAEhEkt/vZ
	FnjL0fDR4mvQzlgj401D0opEVff8+pM9gNlz9bzJs5zO67y7U1sLyUpti18gwXIV
	i5k20LOntNE7bP8WzsCpxsOB5kHHr3PQF9Qc6NuToZvBEbwXxeoCDj62jcA==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq2q8295s-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:14 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c7380305a9aso1089199a12.1
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726893; x=1773331693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlFfO0epXMVcmS45zVN5cdHsuGzSapjHEN4SDtLEPhg=;
        b=j09zhI5HaN2BvlykeZF6uJedYd/CZxlRBVkKkmBprE4fmMfGthLbsPryrRFFV608JI
         nBI6KAUzDo7o2bVyvUq8zDCP8d3475pV+hCOXQVUe1aw8nirr4vx8eu/tJnAPua+oytH
         zdH42j/L8s/m+62lBb+Ze5LdjfHIqu/ldXPzGo2G+S2A1xr7OYZAt+Kkon5rL8cURStQ
         1rwzi1kJ/CXyoVxebrdHsJp24rzLhw17yYoikDsn6Nb6ola5SE1qr5f2ZpXUtxhly9Ck
         Ghs+26kI9C7+Ndid5DdXEtjMf7gyybOL7OTiZckkpAg1bB/bJHhnIgEgB6mfJjzDqFui
         xS8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726893; x=1773331693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LlFfO0epXMVcmS45zVN5cdHsuGzSapjHEN4SDtLEPhg=;
        b=eQLpOJjy/bUE/0id+487zezbB+WkGEN8EHzYuyXymh4d+plDBzTDiUj0viwf2djCa4
         hzpPW32vecQsxYi0RbKKf296YwXn2TH1J3de/N98p2/rRzwcXaImrDaUvooOi+0f7U2W
         dRN02StFGA1VTWzC7iKtMiqJdtaRfH0vJ4hzffxKpjphj7YD4Ae5VqGgYlVhOaIxg3Mp
         3Ies3mhOaW56K/R62VCFQxC0cJhlf18VTmjDx3jr1SyByduIvz4oBBkoR82r2TWEIkNl
         RCN4O1sqMeoBd2NaGC42jM2i0VcWieHkJTXuEmr984I8zy9Lvvq7r0EGoDngez6/A3ag
         FGxQ==
X-Gm-Message-State: AOJu0Yxx9kMklEor0wvWWOK4LermpgV+BgMRxAzxTDLqgRUbo6Qa3dtw
	lKgVWrMvJd3Q0/nfZUPFaLtox2Xy/zxJHItBKj+5Wmkzw0M6pvZbqK60tuQcguTWDo/ztaQDlmF
	6GcRX8UPeP6BD728ASwh/gCQxQ2u4iFVtRgBA3LBTCSjGgiPubNqoXhpRIkyloHMSsrZRQ+J8kL
	kf
X-Gm-Gg: ATEYQzx2+lj8swGdxXZvkvHbAvyEv2Yi4SV+Dxd2RTi/eo/mdYJ8AKuNBUGYDx1xsb0
	ZO2i9bltJhEF+Ymdpr+ZR8yaTpTWeb8VLsu9t58N25PVQ0sh2AdEBmCUSLFUMmI4RxPvXFBJNAu
	bMqdtorQ9tsTZB1tVfSIudK0/ExuWAXKE6qoJEo99tJBNgbFwgO7JdXpYcEOAsMArLnhYJeqQu+
	+b+YbOww2YJz5tLp8vKCPdNGTwxzAItmuRbZIUOmFm3vcotyFz6Z6E1otTs1t8h5JftZdYaITiM
	lPtnJulBYNm6gAGi1DmiOSsjEknNQDE6q0kk0Rie9B9RGwf6WCVz8hqNpiwdVOsrsyeujLZ9XFF
	H56BGoB+AmzJH5uBLj7egAdRuTDat+4on6ssIKc//QmcvgZVR2TIigf4=
X-Received: by 2002:a17:903:46c6:b0:2ae:8001:27fd with SMTP id d9443c01a7336-2ae80012997mr2020535ad.27.1772726893313;
        Thu, 05 Mar 2026 08:08:13 -0800 (PST)
X-Received: by 2002:a17:903:46c6:b0:2ae:8001:27fd with SMTP id d9443c01a7336-2ae80012997mr2020245ad.27.1772726892716;
        Thu, 05 Mar 2026 08:08:12 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:12 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 12/15] wifi: cfg80211: add FTM range report negotiation support
Date: Thu,  5 Mar 2026 21:37:09 +0530
Message-Id: <20260305160712.1263829-13-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-GUID: f4l7FhK7APqahM5JIDWt-P4it7OR93Oi
X-Proofpoint-ORIG-GUID: f4l7FhK7APqahM5JIDWt-P4it7OR93Oi
X-Authority-Analysis: v=2.4 cv=GecaXAXL c=1 sm=1 tr=0 ts=69a9aa6e cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6xOF6ixiuyMj6pbCpegA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEyOSBTYWx0ZWRfX5DurfWWsBZt1
 d52/NmFCQwQz/tmCOTgKbSvrtTkjG5Xsf+A1imb+M72Ooxr4ZayFmgX99l5E2oxVmEqEsfChvgg
 7kOxq0hvXEcCcFoZkfnlIP6KC2LcnUvOJd9bSoQycwuDtjGXC9eW4W468+Nn4516RdnQyCvPcwu
 RgnfpJHqhBToV4ujsxsWR5ldun6HQd71bDnhKzD0gT/jb4+ZgVbLNu53g3yPqOH1FCkyCS/HMNN
 r7YQFERrEuUwEbirnp8HL82dnx7pK2lMUoWhOmfb2Gd5M4oKsZuu6kPD9Wit1vhVqHYsORstQHT
 lwb2cg+80FQ+R5jkczUuQqwqppOAZh2+ThtGkuqvuFvfo0W524hebRnmiVuITg2WYtn0BW1V6vI
 R0Sg72P4enIDp7Yc496GsSBaiW8OFZ0Gd8hIiF5tKL0ExoV8t8eSHsYDPbEqYAHD2YEr7LYMF0r
 ocSVuKA8XrL8t1ZosLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050129
X-Rspamd-Queue-Id: C49D421529A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32561-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Non-trigger based and trigger-based ranging use Location Measurement
Report for result exchange. EDCA-based ranging lacks an equivalent
mechanism to negotiate whether range measurement reports should be
exchanged after the FTM session.

Introduce FTM range report negotiation for EDCA-based ranging as
specified in "Proximity Ranging (PR) Implementation Consideration
Draft 1.9 Rev 1, section 5.2.2". Add a capability flag and request
attribute allowing devices to advertise support and applications
to request range reports for EDCA sessions.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       |  4 ++++
 net/wireless/pmsr.c          | 18 ++++++++++++++++++
 4 files changed, 35 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 61651ecc3c9d..e398a594082a 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4446,6 +4446,8 @@ struct cfg80211_pmsr_result {
  *	to be indicated in case the device moves out of this range.
  *	(units mm, u64). measurement results need to be sent on a burst index
  *	basis in this case.
+ * @range_report: negotiate for FTM range report. Only valid for
+ *	EDCA based ranging.
  *
  * See also nl80211 for the respective attribute documentation.
  */
@@ -4472,6 +4474,7 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u32 measurements_per_aw;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
+	u8 range_report:1;
 };
 
 /**
@@ -5832,6 +5835,8 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
  *	request for EDCA-based ranging
+ * @ftm.support_range_report: capable of negotiating for FTM range report. Only
+ *	valid for EDCA based ranging.
  * @ftm.pd_edca_preambles: bitmap of preambles supported
  *	(&enum nl80211_preamble) in case of PD request with EDCA based
  *	initiator or responder role. ignored if @pd_support is not set.
@@ -5878,7 +5883,8 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_edca;
 		u32 min_allowed_ranging_interval_ntb;
 		u8 support_rsta:1,
-		   support_edca_responder:1;
+		   support_edca_responder:1,
+		   support_range_report:1;
 		u32 pd_edca_preambles;
 		u32 pd_ntb_preambles;
 		u32 pd_edca_bandwidths;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index f064d6a260fb..a70dcb2aa111 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7960,6 +7960,8 @@ enum nl80211_peer_measurement_attrs {
  *	Note that a higher channel bandwidth may be configured to allow for
  *	other measurements types with different bandwidth requirement in the
  *	same measurement.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT: flag indicating if range report
+ *	negotiation and reporting is supported in case of EDCA based ranging.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7994,6 +7996,7 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
 	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
 	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
+	NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
@@ -8077,6 +8080,8 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer needs
  *	to be indicated in case the device moves out of this range.
  *	(units mm, u64)
+ * @NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT: Negotiate Range report in case of
+ *	EDCA based ranging (flag).
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8106,6 +8111,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_PAD,
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 4de5ec8c5aaf..69f972af7e64 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -383,6 +383,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -2419,6 +2420,9 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 			cap->ftm.pd_ntb_bandwidths))
 		return -ENOBUFS;
+	if (cap->ftm.support_range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 364034843df7..9a2e84805a31 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -259,6 +259,24 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		out->ftm.egress_distancemm =
 			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
 
+	out->ftm.range_report =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT]);
+
+	if (!capa->ftm.support_range_report && out->ftm.range_report) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT],
+				    "FTM: Range report negotiation not supported");
+		return -EOPNOTSUPP;
+	}
+
+	if ((out->ftm.non_trigger_based || out->ftm.trigger_based) &&
+	    out->ftm.range_report) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT],
+				    "FTM: Range report request is not valid for TB/NTB ranging");
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.34.1


