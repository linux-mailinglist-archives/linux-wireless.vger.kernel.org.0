Return-Path: <linux-wireless+bounces-38425-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kVR5Ay5yRGq3uwoAu9opvQ
	(envelope-from <linux-wireless+bounces-38425-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 03:49:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 965206E91A0
	for <lists+linux-wireless@lfdr.de>; Wed, 01 Jul 2026 03:49:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=qualcomm.com header.s=qcppdkim1 header.b=G+g6KUFc;
	dkim=pass header.d=oss.qualcomm.com header.s=google header.b=LGf4ZZjU;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38425-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38425-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=reject) header.from=qualcomm.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0E2A0301FF91
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Jul 2026 01:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27518360EF6;
	Wed,  1 Jul 2026 01:49:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA94D35E1CC
	for <linux-wireless@vger.kernel.org>; Wed,  1 Jul 2026 01:49:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782870572; cv=none; b=FPmVGWqzWfwORRpPahv6A1QdfErjk5DLZ2kxrWuAe6HqC5qPR2s/UyUHaaV53iVovEcRlpfUILoNuZ84vfqMf1R9KYizECG5TKs92yCeCn/TZkGoXkbAC2C7eTqUJWEAdVvE3z7nqgQKfCCJ7t/4QYMptw1TiMauEQHp2oCh87U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782870572; c=relaxed/simple;
	bh=Bg585QrVJ+kMtpUD+EOkwugs6VgbmrohBmyInOtRxJ8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hsxxsBG5wHmIsU4w5fXKXBT2CpnfiltG4ZzLNWEJHvtMkwEi5TmuwZdGKV53McXLhrqDIkyvji3GLFLHz3VEPTea2ZGy+Ft1vhZOfPErC+BXf1NoKVJGMIm7pjPZhqnaQTvz2TVsBojo2oyvWgf7Dft6u3uAUPr9DONZeVUQmaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G+g6KUFc; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LGf4ZZjU; arc=none smtp.client-ip=205.220.168.131
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65UNLnUJ3483394
	for <linux-wireless@vger.kernel.org>; Wed, 1 Jul 2026 01:49:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=jQexzviQesYtFmxybT4rIP
	ZDP12EthyB0Le/+SnIPwU=; b=G+g6KUFcUlWkAQ/I++DjgHKVZgFUNQXQE/BBLd
	v0wjRJGispG0jR9DtVplq2F5qzPmoDjlO5FS4YR0O7zdqdK6BpWXLbuVCgLfrKL6
	yc6G8iSw2ajYkYgOGvCTFCj4MCKepzGgD/o2zVCR4oKLw9MASCMO5j4L6ZRVl53Y
	qjb8MwPRgGu5DcnkV+n6jtIwa0z3+MnVt9KUsTO+ejkUnnbi7FTatkwMORXHvvuY
	2ATprD1kPYYVvyNgxKH3Mj7OKz+nqFdLd78tg9boLF5fXR9b2/Ozf4OjLSeMrIM7
	84sY/ahOrIUGA/45luszpekFsvK3mV8R0Wo+i0BISOrayWtg==
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f4kgw1bxk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 01 Jul 2026 01:49:29 +0000 (GMT)
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-847a00bcbd0so252936b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 30 Jun 2026 18:49:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782870569; x=1783475369; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jQexzviQesYtFmxybT4rIPZDP12EthyB0Le/+SnIPwU=;
        b=LGf4ZZjUAX9GcADuNUcchLuYY8NwmSxw7lngsMHdF4LLTjV5Q1RSD1dsPMdsCkwdtp
         xq46XGzGyI0/jwm+IFfH1lsuTNswofNHyg+exB9okiFAENxaidT6XKko6cmGne1BHhNK
         wICeKjbj6HKGvuhd6AW38XYHWc4YV1BY6PlE5cjBP493tvglT9qzXkoqya4mhZi5aEZs
         RXFckwRcFan55Cr22wbCj79iLQK9eRbTVXTDceef4FHn2J3k+iX7paoDzRwCFDRMWCR1
         Qf37dzxT26bR0L+DNuLX/olaoL6k9AzrgGhW3FKBJALVRxD3ZrJO4v6Z6QtISdOgiGsO
         UkPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782870569; x=1783475369;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQexzviQesYtFmxybT4rIPZDP12EthyB0Le/+SnIPwU=;
        b=cyjqhv/Zi5LMKXnvXRuYxtFUqqBjGWiAOzNH7v1ocPm8q7nJnsSyO34hDg8yM7ZBT8
         oEqn01dX3iNuPOzXBVWGE6PloIoc9Tyv9x7zGozRBHhH9+xrgi6tZiXfTG3JTi/hDFh5
         u36h/2W+VQWKgAhbszR4Yr+i7fn57PzFvkmlkEFZr9N4nT6JM8M1BPEo8C6IgY6BGGvZ
         iJPJ1+IFlZPqG5a4l/n1h4uvkLlmQ3T9HUjVwFqFIkND+CzsIoAyFUIvO5IEzqeGFXOg
         5QIXirNQk9/mJMZ5w1svp/kv1JTMK2lQbMQNJsjmwMqu/XC/XFrVqnloYXg3wgig4s5a
         +ZkA==
X-Gm-Message-State: AOJu0YzAIDDTVsf4uVTMu+GM3lGJ9k1GHFUC7cye2b34PECBRVosDXgC
	/eXucA61phaAApty+qknI66HuZ8PFgKK1MABqmUZFVD0v9LCDcvLCO3IdpjuzV3tRwL4TenG4L1
	y+j9gwQAHFwWhLBMDVyBvXWlCTOMdc35TKP/gMMKOpCJZwamVy68cI0oP4R4ov8s0y8UvonyKeg
	QlaQ==
X-Gm-Gg: AfdE7clm1pHZWCztMgov/PGJWsDi1CrZZMFjPSAyUMVp72IBMzBjorRpYjip0Pm+ifm
	sQ2N8KPOY/NdXE2se0KUrIU+UMUPDos69OdTsNZp7tl9bxT2yCTzD2Fr895Is8KFUGCG2DC4jjt
	CoysiIdddT3fgTwfOLMPgMnaBKMgR5XxMsNtezajZhVDm6HP4+nCrwWpkcNPeNJTQgl0Ug/buK6
	GlZzMyFQBGTC4IcFc07dJcNlPqOvga58peWmmW14DUXhMtoBLUW34my9QsAjSF7IvamXM3iYY7C
	qEdVOlyKcfKESxr8oA0YOezCbNO43BbW0/r+xa+sPc9QDTlhKW20mHT+y5jAJImaj8Vrow6aOMm
	pLUqmT0jc+9xZp49nfcGgjNqpfoQyGQSXDTiCMPa0KaLTEGRtOI03jnOx13WYR8HT
X-Received: by 2002:a05:6a00:aa09:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-847addb217dmr2580812b3a.24.1782870569234;
        Tue, 30 Jun 2026 18:49:29 -0700 (PDT)
X-Received: by 2002:a05:6a00:aa09:b0:842:48ae:1d6c with SMTP id d2e1a72fcca58-847addb217dmr2580798b3a.24.1782870568783;
        Tue, 30 Jun 2026 18:49:28 -0700 (PDT)
Received: from [127.0.1.1] (tpe-colo-wan-fw-bordernet.qualcomm.com. [103.229.16.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8479ff89fe5sm3027326b3a.5.2026.06.30.18.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 18:49:28 -0700 (PDT)
From: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
Date: Wed, 01 Jul 2026 09:49:13 +0800
Subject: [PATCH ath-next] wifi: ath11k: cap out-of-range rx MCS instead of
 leaving bogus rate
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260701-ath11k-invalid-he-mcs-v1-1-7d963080c079@oss.qualcomm.com>
X-B4-Tracking: v=1; b=H4sIABhyRGoC/4XNQQ6CMBAF0KuQWTuEKbRVV97DuCilSCO0SrHBE
 O5uw8qFxs0kPz//zQLBjNYEOGYLjCbaYL1LgXYZ6E65q0HbpAysYKIQxQHV1BHd0LqoettgZ3D
 QARnnkutWlZJKSNv7aFo7b+4Z0gSdmSe4pKazYfLja3sYaev/2JGQsNaCtJEVp6I++RDyx1P12
 g9Dns4GR/aBkfyFsYSVvGqEFFTva/EFW9f1DdGAazQYAQAA
X-Change-ID: 20260609-ath11k-invalid-he-mcs-25575cfa3713
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Authority-Analysis: v=2.4 cv=Co2PtH4D c=1 sm=1 tr=0 ts=6a447229 cx=c_pps
 a=WW5sKcV1LcKqjgzy2JUPuA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=7DreTgk5lnmQ1XNskeAA:9 a=0bXxn9q0MV6snEgNplNhOjQmxlI=:19
 a=QEXdDO2ut3YA:10 a=OpyuDcXvxspvyRM73sMx:22
X-Proofpoint-ORIG-GUID: Xa5iOvT7DAFHOk2LrOqPVcmTtAQZAPKB
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX9hf8WgxovNla
 CD37LRkdYfyW+kZBbUWYW1sOWGeYOjdFsp42JOdz4iUS4gwyr64JKvoQtxOKkYNRrMvRKwmnq+x
 RlKXYja5lCkMiJlMz1ZDxUSZLXaN9pM=
X-Proofpoint-GUID: Xa5iOvT7DAFHOk2LrOqPVcmTtAQZAPKB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDAxNyBTYWx0ZWRfX7d9T2ytyTUUW
 8bXEN2nmG7/0ZHQaVEW7/aDjV744jJCS0gVDcXe945tsxFp8rk/pvUmOQu9TOm+5C3l9jz9p9U1
 Lnqq8N5psD63iO96VMr8rv1VCvp7aTdzxK+qPN19Q1p4wI99C4rT9cQkl2InyReyxOwPZMwiBIW
 ES7ElYcBQvkPKZTe9obCxcHah/qL1DdYo3siB86xQCp3hvNz7Kb1w6KHHZ6XcRtyIcpdXqT3L6H
 lrpV/T9S6mdmE+MHaeam74TIrxa/hlt959rllZ9PFZnVnaGmFZMpE06WWswzXPZSI2rVWViaYl6
 M+f51S9B7rhXMByhwXHchuaw6ce9MLy+iv37l3GowbEd5Rv89VmwUZX7f7an2Z16AcN8jlTBcnO
 NxKd/lZppSaHF4x0VaiNUbT1Hs/w4tEyGO9tS3dKqe2TdV5V7fhAXhk2FIVd1kWfZccwfksyR6l
 K1AcahkwHJnV/m2Co0A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_06,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 bulkscore=0 suspectscore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607010017
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-38425-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jjohnson@kernel.org,m:linux-wireless@vger.kernel.org,m:ath11k@lists.infradead.org,m:baochen.qiang@oss.qualcomm.com,s:lists@lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCPT_COUNT_THREE(0.00)[4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,qualcomm.com:dkim,qualcomm.com:email];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[baochen.qiang@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 965206E91A0

ath11k can receive HT/VHT/HE frames whose reported MCS is above the
maximum that can be expressed in the corresponding mac80211 rate space
(e.g. an HE frame reported with MCS 12, while HE tops out at MCS 11).

The frame itself is valid and decodes correctly, but for such a frame
ath11k_dp_rx_h_rate() leaves rx_status->rate_idx set to the out-of-range
value and never assigns rx_status->encoding, so it stays RX_ENC_LEGACY
from the ath11k_dp_rx_h_ppdu() initialization. Once that frame reaches
mac80211 it trips the rate sanity check and the frame is dropped with a
splat:

  ath11k_pci 0000:03:00.0: Received with invalid mcs in HE mode 12
  WARNING: CPU: 0 PID: 0 at net/mac80211/rx.c:5433 ieee80211_rx_list+0xb0a/0xe90 [mac80211]

Dropping the frame would discard otherwise valid data, so instead cap the
reported MCS to the maximum the rate space can express and deliver the
frame. Set rx_status->encoding before the range check and assign rate_idx
from the capped value, so a frame with an out-of-range MCS no longer
leaves partial or bogus rate metadata behind. Also downgrade the logging
level since they are not treated as invalid frames now. The only loss is
that such a frame is reported as the capped MCS in the rx rate statistics.

Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.41

Fixes: d5c65159f289 ("ath11k: driver for Qualcomm IEEE 802.11ax devices")
Signed-off-by: Baochen Qiang <baochen.qiang@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath11k/dp_rx.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/drivers/net/wireless/ath/ath11k/dp_rx.c b/drivers/net/wireless/ath/ath11k/dp_rx.c
index 9e90d8e3f155..896d30181754 100644
--- a/drivers/net/wireless/ath/ath11k/dp_rx.c
+++ b/drivers/net/wireless/ath/ath11k/dp_rx.c
@@ -2334,10 +2334,10 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 	case RX_MSDU_START_PKT_TYPE_11N:
 		rx_status->encoding = RX_ENC_HT;
 		if (rate_mcs > ATH11K_HT_MCS_MAX) {
-			ath11k_warn(ar->ab,
-				    "Received with invalid mcs in HT mode %d\n",
-				     rate_mcs);
-			break;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DP_RX,
+				   "Received HT frame with out-of-range mcs %d, capping to %d\n",
+				   rate_mcs, ATH11K_HT_MCS_MAX);
+			rate_mcs = ATH11K_HT_MCS_MAX;
 		}
 		rx_status->rate_idx = rate_mcs + (8 * (nss - 1));
 		if (sgi)
@@ -2346,13 +2346,13 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AC:
 		rx_status->encoding = RX_ENC_VHT;
-		rx_status->rate_idx = rate_mcs;
 		if (rate_mcs > ATH11K_VHT_MCS_MAX) {
-			ath11k_warn(ar->ab,
-				    "Received with invalid mcs in VHT mode %d\n",
-				     rate_mcs);
-			break;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DP_RX,
+				   "Received VHT frame with out-of-range mcs %d, capping to %d\n",
+				   rate_mcs, ATH11K_VHT_MCS_MAX);
+			rate_mcs = ATH11K_VHT_MCS_MAX;
 		}
+		rx_status->rate_idx = rate_mcs;
 		rx_status->nss = nss;
 		if (sgi)
 			rx_status->enc_flags |= RX_ENC_FLAG_SHORT_GI;
@@ -2362,14 +2362,14 @@ static void ath11k_dp_rx_h_rate(struct ath11k *ar, struct hal_rx_desc *rx_desc,
 			rx_status->enc_flags |= RX_ENC_FLAG_LDPC;
 		break;
 	case RX_MSDU_START_PKT_TYPE_11AX:
-		rx_status->rate_idx = rate_mcs;
+		rx_status->encoding = RX_ENC_HE;
 		if (rate_mcs > ATH11K_HE_MCS_MAX) {
-			ath11k_warn(ar->ab,
-				    "Received with invalid mcs in HE mode %d\n",
-				    rate_mcs);
-			break;
+			ath11k_dbg(ar->ab, ATH11K_DBG_DP_RX,
+				   "Received HE frame with out-of-range mcs %d, capping to %d\n",
+				   rate_mcs, ATH11K_HE_MCS_MAX);
+			rate_mcs = ATH11K_HE_MCS_MAX;
 		}
-		rx_status->encoding = RX_ENC_HE;
+		rx_status->rate_idx = rate_mcs;
 		rx_status->nss = nss;
 		rx_status->he_gi = ath11k_mac_he_gi_to_nl80211_he_gi(sgi);
 		rx_status->bw = ath11k_mac_bw_to_mac80211_bw(bw);

---
base-commit: df81349fece7e61084feae04f301a5655c710c49
change-id: 20260609-ath11k-invalid-he-mcs-25575cfa3713

Best regards,
-- 
Baochen Qiang <baochen.qiang@oss.qualcomm.com>


