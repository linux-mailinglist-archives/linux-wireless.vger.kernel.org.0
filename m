Return-Path: <linux-wireless+bounces-31393-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4HRfCgvWfGlbOwIAu9opvQ
	(envelope-from <linux-wireless+bounces-31393-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:19 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 785A6BC596
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 17:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3E123028EEF
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Jan 2026 16:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 950CE303A3B;
	Fri, 30 Jan 2026 16:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ieh8Pj65";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Up6SAC/k"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154722F4A05
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769788876; cv=none; b=aPrh2q4SE+lZPodaswFwvk+69Kfmt8Zqnp02F50/quYKd2yEV7qheINe6G+wq2Eq6CP47Fx1dvZdrA1f9zofwENUHsbwsCTs13rXc+i8porP4nW9xaFyGVPI8H2wZYJBT1UAGMslkNk2h1nuKesqZbkkVPwoYtZEk8bLm0qS8xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769788876; c=relaxed/simple;
	bh=5llOnHUeS8uWkZFIA3EKGZCVYqyrYV3ojQBoU4qRAhw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZWZFJoY509RyAZNJJ7RJ7KhgaZkiiV0oOdvSreBpj/GkJqP6k7WRqWh+Ay0aZAoe9J5c/ddsb5szKJUP948FcgdJTun7vcxvmLwxHH/cz3gm/d3PcQzLTHfHUt2ITRezsydz3YjRLC4g36eYDAlix4WQ7/uouucCgUbT/9ym1cU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ieh8Pj65; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Up6SAC/k; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60UBV66w1022109
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=l9C5Piv3iIz
	CgdJMJn89nnHVxq/Tlr6z69vMMojxMQU=; b=ieh8Pj65eHzijvWGDEN21pK0z7K
	KS4oeknBSDtY/vBR1Wwt6LK/HKlr8hoiIoh64kd0yEQkrINByGHyRJl/FijKzdf5
	DR7K5uK7LEonykyUByRjeNLzt+M4673Ycyd+kG9g0pAHHhHTnIy2T2SE/xyWtEmD
	R8777g9zr5HNkFNjHl5thHANl5c8KO1RJWewvVI7Bc4ZhnhFJF1D1UMuuaKeigIr
	XSoZcQI76IlVWgtSsQ1F+HvJ8GawO50tbYaN+HlP+fNs9jEVXnwnWLxCuUJySP0N
	40FnImUixZGMes7Sdl+z2UB28Tk6yqS/WzYmqGj5qtiq9lCYZjLpChBIrXQ==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4c0e3kb6pj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 16:01:13 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-c5eed9a994dso1435234a12.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 08:01:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1769788873; x=1770393673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l9C5Piv3iIzCgdJMJn89nnHVxq/Tlr6z69vMMojxMQU=;
        b=Up6SAC/kDnyBOia+Qiw6Kykvlduu38g/Tw6O7m32w5QZJquuRCyBLb8fX58cQEQEsc
         ewHJ0hyCBeBMjYDzqRk8dbFXM1OQkf5NKwN5zPpx1xKGklKnxvjNyIHyU9B+/qzp0NFf
         bjLer6wgBreNPax99hwxaoeM6s+QohOlFO+aCU8szZrbrNDDGxcBmfQ+QzRYSS5SstwN
         BYlzpo5zV9wRZawqJ5EptVPCl2HIyuwyn27K6SlmDrArpBUaxaveZqrEZhSIQoa2cGHx
         t9VIEbv29JiIBOFe/EqYez4CSrFAZM/4CY4SgnoatQZrSWZKm1o8bLI432WT9YBXiti8
         FAkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769788873; x=1770393673;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=l9C5Piv3iIzCgdJMJn89nnHVxq/Tlr6z69vMMojxMQU=;
        b=i0dx4I6DH9DatVaVZshRG0s/kCyVDTNQnkC+1YGspK+xKV7ss5Nejt+9HrVsM0fxQG
         eo0kh1rRBPOhAUnina5EVWul3Ai2uPuabpLYts4l5Qecztv71QfkFtEtHL+j+nAoZz8w
         9kpigdD5BNbcicaTqey1KNdC9NuQhzf5nQEI1dODlquW5N5uadFeEJ8h6CYXqTJ+fYrp
         68ykuCLcoVS8OjhYqGPf1an2AsC4JAIBe3cIJVfREZU8PzISJPsYyrgfcqqHVV2UIo3I
         4mxgicTuDgwE1Ih9pR+SJC6/uV4Ec3LGrQd3uG3fJP5IyUuwQC6EeOeCBGe1zjyZT9yi
         rZyw==
X-Gm-Message-State: AOJu0YwsQZNrEzP2nxsWtZ+es44knEfF82Kqamgaq+DdpUcab3CWv0Xz
	T4XS87SkFy2r7AHXBMTIXRNMBaSRXPhqE0vNu0hE7bHUy/9EDDAxvE8bds4I3XkApkgP01Lx4I8
	dnyEvPCzfXvjbiaDifMSeibBX3YCg1WSqwjUUqUPvl5R1PSzT+7Luu5MYCEO+RIxNaE/L3p1eLL
	FX
X-Gm-Gg: AZuq6aILAvHeXqx3+p0BQ+Vx2m0Ll5ombWZJI5zE3zI4WdnhuLMFf+CH4h3gN0LHcPy
	fV59rbr2SkMUJGC79uYTF5PZ+JIl5yRurrIMqRpheN2J3W9gU8rTvl/a1HcwCdb89K+y8wb2Rz9
	khx668hG5HorbniUs2ZNOZ5z0vXQMPPbVQLoR2qyRyHzSny/X9Wc+rOSR1HQQZCW/77Onk+m0g0
	Oc270HB8dyBZ+4ufbuZKKtOMRucf0zibY9o7AsbV0trYvVyYXkRwIO/QwtaqQq+sQfDuZvg0AFe
	rMB1DzJyOlWpeS5LzjntnhWbkCg7UubBbyc2pi5Pfd3OOAnr3a3uS8cEzk3/GJ5uBPtRsMQVnmP
	1ZgYXTBl6ol76eD1WLaaeZSZ6RxFELOWUn5iCFfOqVOw=
X-Received: by 2002:a05:6a21:338b:b0:38d:eeca:b330 with SMTP id adf61e73a8af0-392e010a155mr3375849637.40.1769788872594;
        Fri, 30 Jan 2026 08:01:12 -0800 (PST)
X-Received: by 2002:a05:6a21:338b:b0:38d:eeca:b330 with SMTP id adf61e73a8af0-392e010a155mr3375806637.40.1769788872021;
        Fri, 30 Jan 2026 08:01:12 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c642a3359f4sm7621673a12.22.2026.01.30.08.01.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 08:01:11 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 09/13] wifi: nl80211/cfg80211: add FTM range report negotiation support
Date: Fri, 30 Jan 2026 21:30:35 +0530
Message-Id: <20260130160039.2823409-10-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=VI3QXtPX c=1 sm=1 tr=0 ts=697cd5c9 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=EUspDBNiAAAA:8 a=VVXV68YT4XQvxaWEPVoA:9 a=bFCP_H2QrGi7Okbo017w:22
X-Proofpoint-GUID: 0sTXQd04VrAoa_uz_NbgcDRXW7LafQYL
X-Proofpoint-ORIG-GUID: 0sTXQd04VrAoa_uz_NbgcDRXW7LafQYL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTMwMDEyOSBTYWx0ZWRfX39imFzHr1gm/
 Ed1EilnlX3Y2Z8hJK5IIey11rz7tt/D5Ol5RwF4/8BBRSQBXrCBaibR2LHCvWwFsDdSIDA8v6O+
 i13odW/VEBUuDJ6pPgWxo/qEx5fBT2Xwt/nHvHrlkRr1DreoijoB4n++R0r9Qve/keUS++6K33u
 GKosJTt4iFeX8FOx16/2f5XDWhwCpbAZTh4LolbGBvoSQ2Xj8qTaivdshpEc9+xmJTSZde0h6OI
 cJu3MpPehVV974/OGiYuleTTMM16ImVtr3CITU+YrkyOOdI93yeDWNz7qguRcH+0Wj1INHRbcjF
 PJO8K+3ro81POSXmgutBzPDFYsjqY8Stf3GEX7Vr9JNxSrG0J/3I/GyrWS758rlOV//6/CVHWjC
 emCbmIozla+PGTn5XwM059cGeO57C9PO/iUQWR25tZ+cKBBEs/dqKYhTDxnkfxyVzSX/f/xYODW
 8qm0do1HOxUqO2WLr9Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-30_02,2026-01-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 adultscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601300129
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	TAGGED_FROM(0.00)[bounces-31393-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,qualcomm.com:dkim];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 785A6BC596
X-Rspamd-Action: no action

Add support for FTM range report negotiation in EDCA-based
ranging operations. This allows devices to negotiate whether
range measurement reports should be exchanged after the FTM
session.

The implementation adds a new capability flag and request
attribute for range report negotiation. Devices advertise
range report support and userspace can request it for EDCA
ranging sessions only.

Signed-off-by: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
---
 include/net/cfg80211.h       |  8 +++++++-
 include/uapi/linux/nl80211.h |  6 ++++++
 net/wireless/nl80211.c       |  4 ++++
 net/wireless/pmsr.c          | 19 +++++++++++++++++++
 4 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 5224a68867cc..890d4b007033 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -4392,6 +4392,8 @@ struct cfg80211_pmsr_result {
  *	to be indicated in case the device moves out of this range.
  *	(units mm, u64). measurement results need be sent on a burst index basis
  *	in this case.
+ * @range_report: negotiate for FTM range report. Only valid for
+ *		 EDCA based ranging.
  * See also nl80211 for the respective attribute documentation.
  */
 struct cfg80211_pmsr_ftm_request_peer {
@@ -4417,6 +4419,7 @@ struct cfg80211_pmsr_ftm_request_peer {
 	u8 measurements_per_aw;
 	u64 ingress_distancemm;
 	u64 egress_distancemm;
+	u8 range_report:1;
 };
 
 /**
@@ -5772,6 +5775,8 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
  *	request for EDCA-based ranging
+ * @ftm.support_range_report: capable of negotiating for FTM range report. Only
+ *	valid for EDCA based ranging.
  * @ftm.pd_edca_bandwidths: bitmap of bandwidths supported
  *	(&enum nl80211_chan_width) in case of PD request with EDCA based
  *	initiator or responder role. ignored if @pd_support is not set.
@@ -5812,7 +5817,8 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_edca;
 		u32 min_allowed_ranging_interval_ntb;
 		u8 support_rsta:1,
-		   support_edca_responder:1;
+		   support_edca_responder:1,
+		   support_range_report:1;
 		u32 pd_edca_bandwidths;
 		u32 pd_ntb_bandwidths;
 	} ftm;
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 181595ec960e..af80248d24a1 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7875,6 +7875,8 @@ enum nl80211_peer_measurement_attrs {
  *	Note that a higher channel bandwidth may be configured to allow for
  *	other measurements types with different bandwidth requirement in the
  *	same measurement.
+ * @NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT: flag indicating if range report
+ *	negotiation and reporting is supported in case of EDCA based ranging.
  *
  * @NUM_NL80211_PMSR_FTM_CAPA_ATTR: internal
  * @NL80211_PMSR_FTM_CAPA_ATTR_MAX: highest attribute number
@@ -7907,6 +7909,7 @@ enum nl80211_peer_measurement_ftm_capa {
 	NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 	NL80211_PMSR_FTM_CAPA_ATTR_PD_EDCA_BANDWIDTHS,
 	NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
+	NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_CAPA_ATTR,
@@ -7990,6 +7993,8 @@ enum nl80211_peer_measurement_ftm_capa {
  * @NL80211_PMSR_FTM_REQ_ATTR_EGRESS: the measurement result of the peer needs
  *	to be indicated in case the device moves out of this range.
  *	(units mm, u64)
+ * @NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT: Negotiate Range report in case of
+ *	EDCA based ranging.
  *
  * @NUM_NL80211_PMSR_FTM_REQ_ATTR: internal
  * @NL80211_PMSR_FTM_REQ_ATTR_MAX: highest attribute number
@@ -8018,6 +8023,7 @@ enum nl80211_peer_measurement_ftm_req {
 	NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW,
 	NL80211_PMSR_FTM_REQ_ATTR_INGRESS,
 	NL80211_PMSR_FTM_REQ_ATTR_EGRESS,
+	NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT,
 
 	/* keep last */
 	NUM_NL80211_PMSR_FTM_REQ_ATTR,
diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 571d96a5ddf4..bbb80032d615 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -373,6 +373,7 @@ nl80211_pmsr_ftm_req_attr_policy[NL80211_PMSR_FTM_REQ_ATTR_MAX + 1] = {
 	[NL80211_PMSR_FTM_REQ_ATTR_MEAS_PER_AW] = { .type = NLA_U8 },
 	[NL80211_PMSR_FTM_REQ_ATTR_INGRESS] = { .type = NLA_U64 },
 	[NL80211_PMSR_FTM_REQ_ATTR_EGRESS] = { .type = NLA_U64 },
+	[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT] = { .type = NLA_FLAG },
 };
 
 static const struct nla_policy
@@ -2384,6 +2385,9 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	if (nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_PD_NTB_BANDWIDTHS,
 			cap->ftm.pd_ntb_bandwidths))
 		return -ENOBUFS;
+	if (cap->ftm.support_range_report &&
+	    nla_put_flag(msg, NL80211_PMSR_FTM_CAPA_ATTR_RANGE_REPORT))
+		return -ENOBUFS;
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index 0ed0f401db11..f89fcd9bb505 100644
--- a/net/wireless/pmsr.c
+++ b/net/wireless/pmsr.c
@@ -241,6 +241,25 @@ static int pmsr_parse_ftm(struct cfg80211_registered_device *rdev,
 		out->ftm.egress_distancemm =
 			nla_get_u64(tb[NL80211_PMSR_FTM_REQ_ATTR_EGRESS]);
 
+	if (tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT])
+		out->ftm.range_report =
+		nla_get_flag(tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT]);
+
+	if (!capa->ftm.support_range_report && out->ftm.range_report) {
+		NL_SET_ERR_MSG_ATTR(info->extack,
+				    tb[NL80211_PMSR_FTM_REQ_ATTR_RANGE_REPORT],
+				    "FTM: Range report negotiation not supported");
+		return -EINVAL;
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


