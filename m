Return-Path: <linux-wireless+bounces-33607-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCaLEWqMvWnY+wIAu9opvQ
	(envelope-from <linux-wireless+bounces-33607-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B2EC62DF245
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 19:05:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8E0903092A48
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Mar 2026 18:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8ADA3DEAF3;
	Fri, 20 Mar 2026 18:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NMaCINOs";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="I7f480Fe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CD92318ED6
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774029661; cv=none; b=t8lEyyJ35EOgc1s6ys/8iBScqpFftmBj0LqUCtcG4u+BBhZqc23wO87ZA+smfBmoSdW9KoUTzssis/VIBcaF1m265XQ2EScFME6tKO92NhWsi62Vb1CLO1czPIObkW7mfHVL6tJsPSsgDj4pQygUC8/FyXVbSMsoGJxs0YbPLXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774029661; c=relaxed/simple;
	bh=Q+FrZW9ihR2IBhddLt+59TyJQtrPCM9boTuK7EOwEKs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nWYSFhPPPwFSqPscCRqsOmBlOd1Q6c6fVlMCnYSb579DfUnsUEIIkxb8ZGGwqXLZkoSwDtmokxLU7eQvqAeGYuGv7v7NpMCDe6m6FQXnH2oH1l/WFsAgiJPXlOTy2S3j+AtsLhi0qepOBTp706VYbtYb0kkouwrPM3F1T8+2N+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NMaCINOs; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=I7f480Fe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62K94Ump700891
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=pZce7ynRP/5
	j8c5hnH2td5jbMWGG+SvvH/o4vLOxQws=; b=NMaCINOs8fjh/wpNi6lbHeAHGUS
	aT38SRYGMr+DO8Rwu6YeWjSUP9osRVGOFlfUHzxG/UCkGw+u5a/odsF3HYAVsn8K
	kb5PWBB/Ed6TcyMWJ//KiMzrTjrUfzk/Xuh15hIfoZTF1O8pikWHlIy3uPDeobnd
	HTm9mhOtJpVr8VtbnKqA4ItM675XzxRb3uH47JGQ5FKda0S/rHskSDzUjzbeIk5r
	8bygjMjxLkCYymtFcaO09ra48ERM9nQ1xiSzOi6DBgPFAuXb31uVWRPm0NPVGMpF
	wHBctZUsRI5vpofazCLT3FcW8w4wUaSpDLPzaV+QMdH413p0S/CxM6eC/XA==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d139q190c-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 18:00:57 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b056b2f0cfso31726605ad.0
        for <linux-wireless@vger.kernel.org>; Fri, 20 Mar 2026 11:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1774029657; x=1774634457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pZce7ynRP/5j8c5hnH2td5jbMWGG+SvvH/o4vLOxQws=;
        b=I7f480FebkdM2PsaDnAnXWh1Jnm2FtkoQtF2Mvfp0guprxrctQNru00ZUba+FmUWPp
         ms5nstu6/pqWUj5hIym9+89HmepETt8E7j2NuhXIOzmpqoVk7pkoVP+hA5706OktdoJI
         NjBcp2jq37oPn2K1mrwM0b83RqE7uHhRzvXjpwUXpnUgcBZluNgiaNGpAd2E0pSImZuf
         jGe8g5THyZM43F6qDx1A/DsXNQt6/dl3hUtDFpNbNiFRPNsRtaK0D5aurzhllPmp8I0C
         39gcg205oitwJifDepKLGVAYXGXyhe8k4aSNmkJFfOzIcr2dOewpBI/a7sBk8fNHDiqs
         0HJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774029657; x=1774634457;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pZce7ynRP/5j8c5hnH2td5jbMWGG+SvvH/o4vLOxQws=;
        b=QgojSDnibYOjWQyuqXwYJZaX89iWV8qPoBb2eq9CGINAbW9SdCj5y5flhjqeifDh/u
         BOQa2sFHSmzQyESKwfl3xnkRucZX6Yjv6+EHK6fXhT99GZltGIQCLi6dW9sqaFPUTTLy
         LWmVD93WoYKC9NWxl+zKitSw5Z0qX+TJW1m1dXfsCAcJrAy0wmkeSOQ01PHLvASMMERp
         9/cBQe9NSZ6S3RlYKrngdHoLltn4iOkNM0o8BvYXK0CHF3skxQk+PDbxqApH82EinJ7E
         oWxuPHEgehhqR9eIjqrd2UWXxZf0+kogumGPc9pifYsFN+bYe94H+hkHiA9qpAFvx+iM
         Mm9A==
X-Gm-Message-State: AOJu0Yw+9j+mt7+ZNO61ki777WE8Xu4Rub7fQtFflTfCxxwLYgrANw6h
	rynCV4rM4LUCOVoTLAznYVJqTCXKqIGHMqGEiQCshyRmtdjKivCW8rvm/VZJyf2q9mTlOFKby9D
	L4N6M7/IdUBWydJzDhfXgCFxxCCEIiSEUR4RgiHUu7nm0YMKYFoa02/CGNKYeZA7p8GWLmGeOEk
	tN
X-Gm-Gg: ATEYQzyyu3cjIhCrbu31IoL6QaT/CiK6WfwDdVvZ4NSpSZ/C5x7uZt6243YD+plex5L
	LmAemNM51p6zikgZv97Ecw8nT1/groBfTiuuJOrbQEvZyo0xOLr++eFLWMJKpv673hhg3cM4bra
	yggzqRs2Aq/tb5aoMONocsPcIhsE11EyUUZ/FBqYYxVdTfc/85hg5ObuMF6iS1ThLsxS/ixKuAj
	eD5GSHZcoOLIgn/3uDiglWAAq6x8VdiZFfasMKQtL2usE+vudF9IVi1Sh6OfwwgUs3ftHmEAcNV
	yDYF8o5oVKJgi7u9Bk4JhbwTX2p1j86tUwXp+zcY1BfjLI5XJnuoFo5m7SBDhR3Gn84Yrgq6LAn
	aWTvkzynxEICdXRtf/FhDfrKgUcJ2voSt8E6r7qpGDDpX1nQtTzCg304=
X-Received: by 2002:a17:902:f70e:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0827b53b1mr33911695ad.40.1774029656592;
        Fri, 20 Mar 2026 11:00:56 -0700 (PDT)
X-Received: by 2002:a17:902:f70e:b0:2b0:6df2:8cd8 with SMTP id d9443c01a7336-2b0827b53b1mr33911315ad.40.1774029655746;
        Fri, 20 Mar 2026 11:00:55 -0700 (PDT)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b083529e8asm29926225ad.20.2026.03.20.11.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 11:00:55 -0700 (PDT)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v4 11/14] wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
Date: Fri, 20 Mar 2026 23:29:35 +0530
Message-Id: <20260320175938.2547288-12-peddolla.reddy@oss.qualcomm.com>
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzIwMDE0NiBTYWx0ZWRfXylFN050dGVjH
 Ie/ucYJqnDJuhrXuOiyo1woZ1gcNTiuE/OoCBL0KP9+fRM2mMM6a4b02yz3U+Iayphyvfa10e1+
 sp0KH278m/xhcGQFyBrQ77EC/u0CX6qmUsyAeUE3VKoAA0yucbZVgc9d0rhudsGXSGrM8Rf8hdX
 vblAVVfWX9ZiDvnS7eVGsw8rmiwVFbJA0/OIX2XVkj3l4QkUXYLXiT0wMNfAKfAOlWl6a6s2lJz
 nV2R2MBoBmjdyGmqxDWKUDbBgLhwUTp8tC1Kj5P7vGsL5++qxtpe/wavxx9z/UOPr71yZ8V6PQL
 URPQu2cznDnLc1SAFvMPtSXBxtZkPqxE36U044b3FD0Qt51h9rF9yCONLXTpXz6qDaTyz0FcY5p
 7fEBdQicaUvt0Zh0ZruridJ/91Zsbh9nJlYK5yblBUD9QFw/u+giXN7ot2aU8pLHwFbIWyqfBZ7
 DZ9ngVJMSsr4sKe0Ucw==
X-Authority-Analysis: v=2.4 cv=FOAWBuos c=1 sm=1 tr=0 ts=69bd8b59 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=4vWfpPhE-hgqtSKhTn4A:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: mgyqtNmmbxAbqqorc4mJ3xsQzBNWdTBW
X-Proofpoint-ORIG-GUID: mgyqtNmmbxAbqqorc4mJ3xsQzBNWdTBW
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-33607-lists,linux-wireless=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: B2EC62DF245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Some devices support different preamble and bandwidth configurations
for proximity detection (PD) versus standard ranging, but capabilities
currently report only a single set for all FTM measurements.

Introduce separate preamble and bandwidth capability reporting for PD
requests with EDCA and NTB-based ranging, allowing devices to advertise
different supported preambles and bandwidths for PD operations.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       | 16 ++++++++++++++++
 include/uapi/linux/nl80211.h | 22 ++++++++++++++++++++++
 net/wireless/nl80211.c       | 14 ++++++++++++++
 net/wireless/pmsr.c          | 21 +++++++++++++++++++--
 4 files changed, 71 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 651d1645bc32..d841ada4ddc1 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5855,6 +5855,18 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  *	a multi-peer request this will indicate if the device can act
  *	simultaneously as initiator and a responder. Only valid if
  *	@ftm.rsta_support is set.
+ * @ftm.pd_edca_preambles: bitmap of preambles supported
+ *	(&enum nl80211_preamble) in case of PD request with EDCA based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_ntb_preambles: bitmap of preambles supported
+ *	(&enum nl80211_preamble) in case of PD request with NTB based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_edca_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with EDCA based
+ *	initiator or responder role. ignored if @pd_support is not set.
+ * @ftm.pd_ntb_bandwidths: bitmap of bandwidths supported
+ *	(&enum nl80211_chan_width) in case of PD request with NTB based
+ *	initiator or responder role. ignored if @pd_support is not set.
  */
 struct cfg80211_pmsr_capabilities {
 	unsigned int max_peers;
@@ -5899,6 +5911,10 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_ntb;
 		u8 pd_support:1,
 		   pd_concurrent_ista_rsta_support:1;
+		u32 pd_edca_preambles;
+		u32 pd_ntb_preambles;
+		u32 pd_edca_bandwidths;
+		u32 pd_ntb_bandwidths;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index c1ecf61a9563..f6bd944fea1b 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7960,6 +7960,24 @@ enum nl80211_peer_measurement_attrs {
  * @NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB: u32 attribute indicating
  *	the minimum NTB ranging interval supported by the device
  *	in milli seconds. (0 means unknown)
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES: u32 bitmap of values from
+ *	&enum nl80211_preamble indicating the supported preambles for FTM in
+ *	case of PD based EDCA initiator or responder role.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES: u32 bitmap of values from
+ *	&enum nl80211_preamble indicating the supported preambles for FTM in
+ *	case of PD based NTB initiator or responder role.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS: u32 bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based EDCA initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS: u32 bitmap of values from
+ *	&enum nl80211_chan_width indicating the supported channel
+ *	bandwidths for FTM in case of PD based NTB initiator or responder role.
+ *	Note that a higher channel bandwidth may be configured to allow for
+ *	other measurements types with different bandwidth requirement in the
+ *	same measurement.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7997,6 +8015,10 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MAX_NUM_RX_ANTENNAS,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_EDCA,
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 25e5d9d5c72a..74b7c4651061 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2482,6 +2482,20 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 				cap->pd_max_peer_rsta_role))
 			return -ENOBUFS;
 	}
+
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_PREAMBLES,
+			cap->ftm.pd_edca_preambles))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_PREAMBLES,
+			cap->ftm.pd_ntb_preambles))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
+			cap->ftm.pd_edca_bandwidths))
+		return -ENOBUFS;
+	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
+			cap->ftm.pd_ntb_bandwidths))
+		return -ENOBUFS;
+
 	nla_nest_end(msg, ftm);
 	return 0;
 }
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 183b5cac015e..d010d19d148f 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -17,11 +17,19 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 	u32 preamble = NL80211_PREAMBLE_DMG; /* only optional in DMG */
 
 	/* validate existing data */
-	if (!(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
+	if (!out->ftm.pd_request &&
+	    !(rdev->wiphy.pmsr_capa->ftm.bandwidths & BIT(out->chandef.width))) {
 		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth");
 		return -EINVAL;
 	}
 
+	if (out->ftm.pd_request &&
+	    !(rdev->wiphy.pmsr_capa->ftm.pd_edca_bandwidths & BIT(out->chandef.width)) &&
+	    !(rdev->wiphy.pmsr_capa->ftm.pd_ntb_bandwidths & BIT(out->chandef.width))) {
+		NL_SET_ERR_MSG(info->extack, "FTM: unsupported bandwidth for pd request");
+		return -EINVAL;
+	}
+
 	/* no validation needed - was already done via nested policy */
 	nla_parse_nested_deprecated(tb, NL80211_PMSR_FTM_REQ_ATTR_MAX, ftmreq,
 				    NULL, NULL);
@@ -44,13 +52,22 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		}
 	}
 
-	if (!(capa->ftm.preambles & BIT(preamble))) {
+	if (!out->ftm.pd_request && !(capa->ftm.preambles & BIT(preamble))) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
 				    "FTM: invalid preamble");
 		return -EINVAL;
 	}
 
+	if (out->ftm.pd_request &&
+	    !(capa->ftm.pd_ntb_preambles & BIT(preamble)) &&
+	    !(capa->ftm.pd_edca_preambles & BIT(preamble))) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
+				    "FTM: invalid preamble for PD request");
+		return -EINVAL;
+	}
+
 	out->ftm.preamble = preamble;
 
 	out->ftm.burst_period = 0;
-- 
2.34.1


