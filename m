Return-Path: <linux-wireless+bounces-32560-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLVjOh2sqWmtCAEAu9opvQ
	(envelope-from <linux-wireless+bounces-32560-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4404D215424
	for <lists+linux-wireless@lfdr.de>; Thu, 05 Mar 2026 17:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C7BD93023AAA
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2026 16:08:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9384B3CE48F;
	Thu,  5 Mar 2026 16:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nILxUhvb";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GnC+BTnN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B797628134C
	for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2026 16:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772726896; cv=none; b=Q/xFAviPNw87ms7UwTydIor1Jy/twUX/a+4RF+TSAbXxbutsg09H4eBn0AlLH5jrlnQzHoNvfhoKASoqSwF39P8DqhYpZE7z8XeEnRGPVkzvBLL8pcAcwIE6kOEkHgYf2YD/HV0FMaMbzsQQQ45+YRR+NkTWwgWpMHIl6KYF9j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772726896; c=relaxed/simple;
	bh=Rvdkf+HtoBPmTReaY6fPVZnTrFbo1K4itxuCnZ6d/8Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aihi1+K6I6kDjlnxQi5h3v4OcyAg4KoI/LZNp2DbOQBCw8EaEJuYiyIxhzEJd96vpd4qyntJsYxsJpuNcPTbQbWoPvQfY9UifSG/XA0+6K+sUC/zFGPlQgNwDtcyGRcQgH2JAtIOg/a3SDqmr7bvpvtkA2Byyp4/9Q1cuTAGbdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nILxUhvb; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GnC+BTnN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 625AFw4s917385
	for <linux-wireless@vger.kernel.org>; Thu, 5 Mar 2026 16:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ACkU8RlZBID
	TUeapj+PdY+JC9nTDPp2k4NoygbGMzVc=; b=nILxUhvbG2eV60zNLEobD9M4RPS
	ESnVc3my70LySK0Ylme/XVxYfCWIFmMFbEXhCmb0IZnVhZWNJuDA6Pwb05LqPCja
	2aA8Qt4syWAx3bxYIyBFpAvbm4bh8tAgLNVxajdB4XeSdobbq6nhq0U5drmCYwkt
	+kroJgb63aLam1T70yIhExoL+2DTyCNaQ4HBn0wJo5USXeJGqaKryY7HTKb7686v
	la2/e/+LNCaKLv1kWYH/Oo5zC+y9eciok5gsfTsRpBTT/6gKNsusH1RzL7LhO9aJ
	DdPdEjlluKyBDYqfAnqJmsr2ZzqQ/1fJW/NZJS52VZW5hlcGFk5isAQOChQ==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cq380t5jv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 16:08:12 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2ae50463ba8so212553005ad.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Mar 2026 08:08:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1772726891; x=1773331691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ACkU8RlZBIDTUeapj+PdY+JC9nTDPp2k4NoygbGMzVc=;
        b=GnC+BTnNzUK/gk9FScDfLo7p9kcXeO/eGQ6ESn3nu25UeZyPE4KvwHJSbL2iZa6Ab1
         5VVWVVaaJx2ijOjLscY0KcK5RurDzfIoZnu2zGMK7rxXR2IfzcegAp5M33veT+wMlmdn
         TZG4q+JBt627UCFYu1iDQULhi+8hz+zBmdEpr00ha3L0RGi6G8YN/JZEa38eWu49a9nl
         Qxwllpoh2kFwUcF8tSjhIUclEaQ7WaweBx0MnqF843R83i62p4R8VIvG6flOhREJo4Ds
         ui5/Y7UQ+SAD2/UWO6zs/sQAwJZ2Z4qfcJkCLKOeWu88w+Kg6mMQdjcx54vjxKp3KJQg
         uDrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772726891; x=1773331691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ACkU8RlZBIDTUeapj+PdY+JC9nTDPp2k4NoygbGMzVc=;
        b=T0M/LYtJUlx54rtzswDvFK6jeDpBYyl7f8KYIorIRTC5mLL7ufaK8/99f/j5VZZXIy
         EiG6dhPUuYgiTsUSEGi5ePXpFQWPfGhCu9ebfHfE1iLp/7cG5XM0OlAcOVH93sL92yus
         jPAaZhZefe6DV3YRHrh/92pLTFT1/+rS5oZmc6wHeAoWL2bPYew6mD5Oy/ElNPetpdLg
         /XHjomWj7vWooBtGVPPWWySWeGYFjGfdrMJpFjr4yw5tKFvUYohpLFpVdp1pfWQXNrFX
         Z9eYzM+d09PiEr0QGrBl2bPUTVf7Ic9HXSQLk0NH1M2+kjG9v/aWjgGnQBmHyv6S4/K+
         521A==
X-Gm-Message-State: AOJu0Ywe4ol1t3TVYuCHzk5r0XD93x7MTKUYs10kTkW7ky5nCHlGkEQU
	Px+XEops1ypFOI4FaTr5DRpbAc5yIbYHquJqSPukcjhZPhV8rH/0AjAyq4xYnarVK3+5oBKLMrG
	Qf89WwT+NIj/pqg9b+WQATY6nrWSSwcRWFTWg3W9tpe3OdktXF0SfL40K0+clsTvivqrq
X-Gm-Gg: ATEYQzwCFqFyZERImWppIm0B7X64fEUVfvFpAr/ntEiIa/qXAX14CLjgLPWWCOpRZIl
	kXoNDbOJHmRFQL5gQTIsfsDNUETvGtxZ5cbX0c+UhCZCa4578TlqYkroZatvZJYc9/sUnw3DIsv
	aC3RTICigF+0z+IfhgmcmoMx7CJ55ZAaV2WUrRPBYBt3ga0IaS+qKNAqt8Gv4BUJTVM82qPV8av
	8xbb2Fcb8UnjIhK9I36a2V80lirP61jtPxSn+E9gt8kf5dW4PL1Tc6C+KEVk0l3kIFQDcj60+JI
	CSzToQUmUG/7qvkm3vz7bzdP+rt/vZhnJtXdY97Bi57pJhWFmpPaeCIp7IqU0y2XPmqIt25qSWP
	R59KIyoZKS2IcE9k4Q/FEG576VCQrNSsa0gItYwU+uqfUhlI+riV8/gg=
X-Received: by 2002:a17:903:2a8b:b0:2ae:63b5:1791 with SMTP id d9443c01a7336-2ae8028e53dmr1229035ad.55.1772726891241;
        Thu, 05 Mar 2026 08:08:11 -0800 (PST)
X-Received: by 2002:a17:903:2a8b:b0:2ae:63b5:1791 with SMTP id d9443c01a7336-2ae8028e53dmr1228775ad.55.1772726890728;
        Thu, 05 Mar 2026 08:08:10 -0800 (PST)
Received: from hu-peddolla-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae489c3626sm133773575ad.8.2026.03.05.08.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 08:08:10 -0800 (PST)
From: Peddolla Harshavardhan Reddy <peddolla.reddy@oss.qualcomm.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org, kavita.kavita@oss.qualcomm.com
Subject: [PATCH wireless-next v3 11/15] wifi: cfg80211: add PD-specific preamble and bandwidth capabilities
Date: Thu,  5 Mar 2026 21:37:08 +0530
Message-Id: <20260305160712.1263829-12-peddolla.reddy@oss.qualcomm.com>
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
X-Authority-Analysis: v=2.4 cv=I5Johdgg c=1 sm=1 tr=0 ts=69a9aa6c cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=ZePRamnt/+rB5gQjfz0u9A==:17
 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=EUspDBNiAAAA:8
 a=hlLq49h-dZ90OnsncDQA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-ORIG-GUID: pkqZx4xmfrGEbVwohMjIi0UNqAmT-qTu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDEzMCBTYWx0ZWRfX4Yv37QUaF+R6
 0gqIfejG+tprQqPuTGrHSbkKAsbIZ7hhv96glBtw2v6DNXFj1sk6qikD/DrSkvT54ueJD7BI6XM
 V64DXoeq+GIaTc+ZqJafwedxWLrmNCQdXEAvyqUZF5IBSAHnC6fLHM0omIW4k3WGAH6b4i7y0S7
 13RSDzUNpLkBuPwm2Wtts4F/wlsoWY8AeZWYNAMnfIkHYmGog5FUAWLtwNL9wV0wmYlFj6pKSKt
 fm+sIbfFSNAH15U4teCJdBgQJR3Cac6YMq6P/CjcDm32L5AIPaIvA+hAfObO8PPJAjRi5eVYVPx
 s+ymWFJP8rcDd6pYD0xio2OgL0kj8k5LuPPrGlm4QaVecCRSVV+7gr1UCWS6AzV4coRebgSVR1B
 ohqrk8EBwzVRAc71RJ2tgFcqYSMHARMmsm0a/QNe4bXoiJs+9Lbtx1fINc6ktCc/nwhu8DhafPb
 8BPql9li9NIPmoYQEMA==
X-Proofpoint-GUID: pkqZx4xmfrGEbVwohMjIi0UNqAmT-qTu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 bulkscore=0 malwarescore=0 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050130
X-Rspamd-Queue-Id: 4404D215424
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32560-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[peddolla.reddy@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

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
 net/wireless/nl80211.c       | 12 ++++++++++++
 net/wireless/pmsr.c          | 21 +++++++++++++++++++--
 4 files changed, 69 insertions(+), 2 deletions(-)

diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
index 1b663627a0e6..61651ecc3c9d 100644
--- a/include/net/cfg80211.h
+++ b/include/net/cfg80211.h
@@ -5832,6 +5832,18 @@ cfg80211_get_iftype_ext_capa(struct wiphy *wiphy, enum nl80211_iftype type);
  * @ftm.support_rsta: supports operating as RSTA in PMSR FTM request
  * @ftm.support_edca_responder: supports operating as FTM responder in PMSR FTM
  *	request for EDCA-based ranging
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
@@ -5867,6 +5879,10 @@ struct cfg80211_pmsr_capabilities {
 		u32 min_allowed_ranging_interval_ntb;
 		u8 support_rsta:1,
 		   support_edca_responder:1;
+		u32 pd_edca_preambles;
+		u32 pd_ntb_preambles;
+		u32 pd_edca_bandwidths;
+		u32 pd_ntb_bandwidths;
 	} ftm;
 };
 
diff --git a/include/uapi/linux/nl80211.h b/include/uapi/linux/nl80211.h
index 174592017486..f064d6a260fb 100644
--- a/include/uapi/linux/nl80211.h
+++ b/include/uapi/linux/nl80211.h
@@ -7942,6 +7942,24 @@ enum nl80211_peer_measurement_attrs {
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
@@ -7972,6 +7990,10 @@ enum nl80211_peer_measurement_ftm_capa {
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
index adbc53808135..4de5ec8c5aaf 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -2407,6 +2407,18 @@ nl80211_send_pmsr_ftm_capa(const struct cfg80211_pmsr_capabilities *cap,
 	    nla_put_u32(msg, NL80211_PMSR_FTM_CAPA_ATTR_MIN_INTERVAL_NTB,
 			cap->ftm.min_allowed_ranging_interval_ntb))
 		return -ENOBUFS;
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
 
 	nla_nest_end(msg, ftm);
 	return 0;
diff --git a/net/wireless/pmsr.c b/net/wireless/pmsr.c
index b7e3f3a33460..364034843df7 100644
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
+	if (!out->pd_request && !(capa->ftm.preambles & BIT(preamble))) {
 		NL_SET_ERR_MSG_ATTR(info->extack,
 				    tb[NL80211_PMSR_FTM_REQ_ATTR_PREAMBLE],
 				    "FTM: invalid preamble");
 		return -EINVAL;
 	}
 
+	if (out->pd_request &&
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


