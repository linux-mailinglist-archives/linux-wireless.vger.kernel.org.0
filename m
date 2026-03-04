Return-Path: <linux-wireless+bounces-32448-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePG3OKbcp2lnkgAAu9opvQ
	(envelope-from <linux-wireless+bounces-32448-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 552BB1FB7E3
	for <lists+linux-wireless@lfdr.de>; Wed, 04 Mar 2026 08:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2035B302CD21
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Mar 2026 07:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2012E3101A0;
	Wed,  4 Mar 2026 07:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oQ5lXVvv";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J9jld1mj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C45EC36998C
	for <linux-wireless@vger.kernel.org>; Wed,  4 Mar 2026 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772608600; cv=none; b=Ultk71KPmXL2cd5zcQ+75xI6ODQ4bkwma0mHrKtJtIoFK/8QmdqhcNEhsjSiXVGMkGwwyoULZkgBGF7LcNW4C+1N0PNIFgtGjwqz4FLTNqTcDhvRjIQ1XVQupvI3CSvpYnrn7O9QleMzGmtr+3inaLvscrDT9aZULuMPe45lBtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772608600; c=relaxed/simple;
	bh=LYePKTdeCMwADLtLjhJkRgcYl2LSOVPIg72Mjb+tnvY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iurJ74AgmMmfjnzwvBGfSiBYB7KPsXVmiXebAPox6HMzzgfFjk4YNVFLfRA1lPgUNOx9D3cJyclC5iUUexFv9VccVXA+xYEaRUW6hjEatbWqLyX5ZioxPRJJq734HYyz+gmRZfkccsV8CuguuaRZanPS+mss6P3xDKwdkAGixB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oQ5lXVvv; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J9jld1mj; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6245SsjA3110945
	for <linux-wireless@vger.kernel.org>; Wed, 4 Mar 2026 07:16:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=8CSBrq9T3fM
	mtMh/eoTPUc2xh2rcpJyOEHkNcO7NNSE=; b=oQ5lXVvvvadr6Y9CvAi6zpFuYWo
	OFF7A8IHR/7BznQHDpldD5uAn587odj/wr8B1l7VdAnpcRP4B/vv/xUOcH9HJ8PB
	igTa6jl/+gO7k42ikQnVmb07ergaP2HhyOlbcgYnnGb7jtvJU3YO1/8aULLPpl95
	nRtmpfVj+5+NyoUVOB40m2FRgmzZIPnYPHh4kDvR1vZBhPK6HWDbbG8b56PBKTbf
	8IW1YIAP7umZjX1EIzuL9x64XXtergTd3r60+aeGw7RocTHwapWWbEF1e7hcsrSK
	6X+GItTmQEw7Yue2NRUHzsfYIzGnerQC30UaLhTubjVAQbz7cxh8y1jzM5g==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cp5h2a44m-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 04 Mar 2026 07:16:37 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c70f19f0f37so3688029a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 23:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772608597; x=1773213397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8CSBrq9T3fMmtMh/eoTPUc2xh2rcpJyOEHkNcO7NNSE=;
        b=J9jld1mjwvJn40I8NeBPXkaLwidfuw8XM1MU0UVqLtJtpNJAJSiIxljrFIG4MwC5d0
         GqEuMCFgJpXg6iO73Jzh8loiLlI8nTZHau6xGPQaIgzm2O9gnoAu1LckjvPwhZB12QH3
         gSBRpm1+BNGRIT7iqNStMUj5dUHghULpHCjWkKaY1OMY/vx8UQB2by/fQCKhpheydfrD
         USYNno5huiI6BhVx2BFb6G8z4xkJiY/8vjQSTZJT2QM+fLyviOw9D3GT/If/2QrRve4N
         tklPX693TQeScMhqeQ/pkSEMwvxsmu8E3l9KQrUObCPSdVPAi9YgTKL4DwBbbEGbCMWD
         DA6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772608597; x=1773213397;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=8CSBrq9T3fMmtMh/eoTPUc2xh2rcpJyOEHkNcO7NNSE=;
        b=xR7jOJEK/qR5+U1StrPJytEtgCTILTR0+EHpRKJsfHFdlv8R2qN1CeiRyVA8I6EZfW
         G/oaASOLj3dAa7EQ4cWmxalQDsKvFwprslrWo/EFRq8GWYIrHjBnlVOKwVF7lfdoWN75
         9ynWBD6tv+WD6DULJ4blgSkaT93GYqkUH/NBwaZv5l+6KsNYQNr4DOcZ8Zyp7DHdox7E
         30OoO8NJzM6Rs3zw3vLN/pdQZmbzasL36a/ahFK2avOoAZklz9f2tEM6vmqNiELSy7jS
         FMdbDrH7TEu2UbBbEcKqqKajCENPxR7KMLoaf/wgb8BpVgSH8Li7S5XNH9litfuNtYLi
         Fh5A==
X-Gm-Message-State: AOJu0YxGcVJV30qsCxQHwPl1wx91Nl7n9XmLrd8qs3laz6gKZ5qTxnL6
	/vnx1C1BaKp0NWgmFiiINDrJI73Iy5LXihlwnpifr2r9eJZyv4kKv1a2eP0qgP+Z0oFYmXskQAC
	AxYMuQQxDIJ1t/UqpZHcLPyZ4VIb7NNiwEuYJtw5R66och/cMpqeukpLE+UHyk6Cb7Ve0
X-Gm-Gg: ATEYQzwEFyVQRlVMWCiMt2hATVHiK5PA2dU1+zUzCACERltlH/nFagNNxPKJNurlF97
	NeE8c8qewqvrTY8lnC6TmC8MtIrsOqiYbPtwUsuavB9Yf/jdhWiZ5jslyl0M0JmCrzrJnaaiMXl
	fI7EhjjyiO0SS275+XBCBqdKmP8N6DYYCcO/02GKf3G9vkKf/Pwj4qQMXBFY8Ut96f2cfw4pYPZ
	e60+gT/JW5nLWV0TXZu5fJ2FwWDMyclNkUfhXriH0lEnIGdT8o0a33BQ/vSAIvWWEj/SyFuWEGQ
	2ueW3PfofGRlrp/XDg8qz2/Hmt+o6sF+uCdrsw4qDOrF5wNRSmyKR8mSaffanwk+R2r6sZbvFak
	Kg8rQw/u98Va5K2m0GuM9dwLb1teT+516+/cK04+FGbJrW9y7pOw72cY=
X-Received: by 2002:a05:6a20:c70e:b0:394:64c1:da83 with SMTP id adf61e73a8af0-3981439e738mr5036603637.15.1772608597349;
        Tue, 03 Mar 2026 23:16:37 -0800 (PST)
X-Received: by 2002:a05:6a20:c70e:b0:394:64c1:da83 with SMTP id adf61e73a8af0-3981439e738mr5036578637.15.1772608596699;
        Tue, 03 Mar 2026 23:16:36 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c7378125320sm994121a12.20.2026.03.03.23.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 23:16:36 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v2 12/16] wifi: cfg80211: add FTM range report negotiation support
Date: Wed,  4 Mar 2026 12:45:34 +0530
Message-Id: <20260304071538.3833062-13-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=JqL8bc4C c=1 sm=1 tr=0 ts=69a7dc56 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=6xOF6ixiuyMj6pbCpegA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-ORIG-GUID: MWQkyWo9MlhZzS-ufZObx9Z2JLaEclU0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA0MDA1OCBTYWx0ZWRfX1ay8DV+uZLJc
 N81EN+UofxnoMZvPiSRMtnOXyfD/Q+fGhtd920u/YCfkXsrVXfd+2UxK8hpbRP7RDFK1wreXPX7
 Bi2w7GFlJyNB9JZPgEkWUiHTbbLl7Nvc+7J5OJBv1A+hpizlnG5OdmC9oj8wzZYe/b5onoogP0I
 5qfAWRf342xl8Rv6Ee3lDMNePRNW8sXy+42PQOchcjM6UWCFHCXDRrCkxqtAyGSPv0bkBYuWo1H
 aiB7A9RsUTf4kY/l1tpp8SgFL+6WGkeBikkR53l3UEEQ48c+Ul750KytcDI3iIIqNw12ZRRsrt9
 y/PHPKzlvpEel2lGDZ4hN2hl7ieyO194T6Jo0RVxQ0ohOGmL/6esuiRui2OajQADgC9nTaRNien
 CwapR6wJIGi2xNeZD/1CKQ0LOp2lLdkBhs8TxWlg/ReIp01STrxBoi16wmJN9f5W7zyXvQzRVyD
 jI4ZFUQr/SsVfBauZIA==
X-Proofpoint-GUID: MWQkyWo9MlhZzS-ufZObx9Z2JLaEclU0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-04_02,2026-03-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 priorityscore=1501 lowpriorityscore=0
 clxscore=1015 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2602130000
 definitions=main-2603040058
X-Rspamd-Queue-Id: 552BB1FB7E3
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-32448-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
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
index 1deedb1c6c50..ea46c5e215ba 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -383,6 +383,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = NLA_POLICY_MAX(NLA_U32, 4),
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -2424,6 +2425,9 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 			cap->ftm.pd_ntb_bandwidths))
 		return -ENOBUFS;
+	if (cap->ftm.support_range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index c4c027fc0b63..2b3d7d260e35 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -250,6 +250,24 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
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


