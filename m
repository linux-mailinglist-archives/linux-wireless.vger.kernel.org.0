Return-Path: <linux-wireless+bounces-34554-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UEJGLLnz12llVAgAu9opvQ
	(envelope-from <linux-wireless+bounces-34554-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:45:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5224E3CECF6
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 20:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 03052302BE0E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 18:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21F803E2750;
	Thu,  9 Apr 2026 18:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="FeAEk9oJ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="IgrpdPop"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE46D3603C9
	for <linux-wireless@vger.kernel.org>; Thu,  9 Apr 2026 18:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775760271; cv=none; b=dOFeL3nfNsKGeES8I/QFoYEIe6KJhQzZxzi2aJAMs+kybcygPS3i3ZYAisTsSH1nYVLUIijKMt3emN9/ygf9BZSMN44A6RQiYjuOs745jHZvCsn1maKSZEGt64ZK26elY5bKYGM3GXqPtgPXQJJN8lqMsVcxu3iZtYhNp1+Sp+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775760271; c=relaxed/simple;
	bh=JjU57mhUE0CRd94gOh9gtgirGUkGef8DnpDtXylVSFM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VPMMMOe45BmzY/fiFWdUR+z8kEbqZTnL6qhG+mdCqD9kngltVWm0NXJJurJvdiaNDv+7ZMeUYSXsqXH54nFHllIDyGm5PCuyBMLXH1gOkjwGVh8kDrBQHI96Ti1cgm+nhkvpI6fIGBWI8jlBd+yYzLwMoABpJZGKl1SdEJeGLDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=FeAEk9oJ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=IgrpdPop; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 639DbjNa3934572
	for <linux-wireless@vger.kernel.org>; Thu, 9 Apr 2026 18:44:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	kLOLuOwfq3+RKuL9d7Vb9jCVumI7Dw9kQT1jzNszUNY=; b=FeAEk9oJAe9ji7xI
	Yp64MUaQ4bvaqppQp4FOpaxXO64K7DdfFLIvdVBX1Pqjh9z8sP1GV/N7be1KC09j
	1POwsbof6NT63ViDPOFQBzyassE578ZP9BqdhTvTzdTbZJ5t3782Rvhzkjh41yGI
	OHmO6uzDux1iscABZlbd+nFAm8gWsE4FVjk/mGBhYqvnuw7oCUwGfdbvOVilWA9a
	PgeiXNBJBjO8B4ls10WNSiKjFt/oPB3lQkdxV3hzmW80l8nfS42paLuaNEQOljl0
	BK14ddZyaRlc4YgMTCtGIko0Bq9sxmu6dJ3+oNg8VvJax5VyHaj00e7o6QcTEAqZ
	/0JQlA==
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com [74.125.82.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ded5s9528-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 18:44:28 +0000 (GMT)
Received: by mail-dl1-f69.google.com with SMTP id a92af1059eb24-12737f276a2so11223110c88.1
        for <linux-wireless@vger.kernel.org>; Thu, 09 Apr 2026 11:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775760267; x=1776365067; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kLOLuOwfq3+RKuL9d7Vb9jCVumI7Dw9kQT1jzNszUNY=;
        b=IgrpdPophvPk6Ha8/fr96E7/FAE48BhFRswzMXb1NukqBc2If+NpMqrCZDD6OAKpXk
         cElippgeFu7+sFUhzOPu7HHupZdFGYsHM7hoVRyfeOENxSUNeIcHo96lLI6gCsP6mRS7
         yLIfQX/Q4KyP/qYLGvorL+k45I3lYy4mxLdTit9KQaUJETroDeehNDMui1EtJQR+Wx7y
         xeD0X2OyhE4+mkbjvkWFsq0Ue5zaRTiiwPX7cs32tiMVC0Bn8daN7lQH7XEMbxvV/FJ5
         +XlKGmd/9SUsgt83U76GqhwaniHPUpGg2WTOat1ZNL+zpIb70kN0v/5puwskUW+c+tZw
         gwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775760267; x=1776365067;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=kLOLuOwfq3+RKuL9d7Vb9jCVumI7Dw9kQT1jzNszUNY=;
        b=JamjiPnHXX6e/DmX3CIRyA4wUBZwU1K7e3tqS8RYwYitYVrGS3Bv0pspW0McBsIaIa
         KlHd2961kYTASWu25a1OcBWFWeh4cXFI9nG5WLI2UHizSZ3A2XDsCNJwvx2/W1oEktz7
         siM2XmcIZ52wannYK+OrU/Prvgi2hV74ZPfLXxPawHaBVxib68SrPovH4UvfolLN7f33
         i8BMHO6V4F6wBVhn+VpFXRjmSUViDox/67tXYFJYoU0PE5gkwjXLUK5jDCcOkUSaNkd8
         8eFT76ZajvbmcaK1OybTAs9fo5gL/6p5OkjZGdeilM5erVWZ4s1QMP1JkLmxi2GDhphC
         A+2Q==
X-Gm-Message-State: AOJu0YwfPr8y+8GcwAjEJtuxpzO/0EnGxGGWvHXKAZVJ5ZL647NqTds1
	YLVEJZpY9LxdseYWLECZ4qsyviZ6gJeXpaIs6c5SYtgNgxCiYf/YGudyBm/LRRw088v/qOg1sqY
	SyuQ/Ns4dKpJxydUVQEuNo1YKaBH30WkhikjrkfdzZa6ecoloQeqxsOcO6IVVjgjqC9vy8rckKm
	0+kg==
X-Gm-Gg: AeBDieuufj7K3M+MZCoQPVcp+GmfumcYqf7BbNShqgtReOV58yI+QN86vSX1oKarrCX
	wQE7IkgpOs7BDfMHmMjM/YyMR5TdJ8+/xAgohNIyi3UI5uv5zNRoajjUpmU6KXTiKCCzLoLkGCh
	2JgJjf+aHlfGgFu4pb7LGoRDSbGkweuEatPL/D5hiXVKMzQIuGbFUhRbC7wb091JYDajKm/hUTG
	jrUY9GfZrqN/ifFr+OLXLKRPscS+HXPYBCDLnrp3eMZS02xIbzXGldrgBwzwpSHIQq3kZODfUea
	AvORx0oGCeTPiLoEjSLin9Tmi0o//WvvnZAlseb0ifRnDl54E613dRnYMv9PfSQHiK++LKM+IcP
	2t5i9ejRF7Q5us4bUWjYlJok1ml8lqn2a3gT36EYdVmfqQrQDpj6g+ttWNnEktiMakVdc6K/Y0z
	Kh
X-Received: by 2002:a05:7022:e986:b0:127:15cd:9f52 with SMTP id a92af1059eb24-12c34e37b1fmr127134c88.5.1775760267340;
        Thu, 09 Apr 2026 11:44:27 -0700 (PDT)
X-Received: by 2002:a05:7022:e986:b0:127:15cd:9f52 with SMTP id a92af1059eb24-12c34e37b1fmr127060c88.5.1775760266762;
        Thu, 09 Apr 2026 11:44:26 -0700 (PDT)
Received: from hu-jjohnson-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c34352490sm513985c88.0.2026.04.09.11.44.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Apr 2026 11:44:26 -0700 (PDT)
From: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Date: Thu, 09 Apr 2026 11:44:23 -0700
Subject: [PATCH ath-next 1/2] wifi: ath12k: Fix HTC prototype ath12k_base
 parameters
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260409-ath12k-htc-proto-v1-1-cda86d6355f1@oss.qualcomm.com>
References: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
In-Reply-To: <20260409-ath12k-htc-proto-v1-0-cda86d6355f1@oss.qualcomm.com>
To: Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: fED7cIBa_QAWQ83uD3cNJdeL4hwLKE51
X-Proofpoint-GUID: fED7cIBa_QAWQ83uD3cNJdeL4hwLKE51
X-Authority-Analysis: v=2.4 cv=Ko59H2WN c=1 sm=1 tr=0 ts=69d7f38c cx=c_pps
 a=kVLUcbK0zfr7ocalXnG1qA==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=TfkjnaP5MeWC5N93_1wA:9 a=QEXdDO2ut3YA:10
 a=vr4QvYf-bLy2KjpDp97w:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA5MDE3MSBTYWx0ZWRfXyjKDGlRkrwnO
 mQjEkubBJVBDtVhWxFCM5wWtxPHh+6T14k3dOvozPu8uWngTnGSy1PRzXq8Bw7LVpHHDXgu/fLk
 nhhSgSB/WfG/7eU3SpFGaXqyICZdnGoJ+4E61A4yYFMkGjqQfX8rru4yCBLxvz2lOga7oxcnxn4
 Xzj/s74xBmrpeCzQfogNCkzxwhI4ldVtqYctOY5Dc6HmadJDpa2ofhhwPbP0D8t/+R1BN1/dQDL
 kehBhBcmdU9Z3b1J+YbJ7f+Eec1N/7Tm1AzCrDjoxvVfAilWMFsNB2s5XubTq7mbbHhOc3yXTer
 JWJ8ds1K2JVXOS8uU7etefuwC8Z++7zN+zokUo3/0D+eAh/ntH7J6WCQ458dCisqkBNoQ4PJ96n
 dhj1kuGL68LM1DD/tQdXh5czzvS35V2toleVbgzQgTI2yoG5SVkQLsWS4KUziC66RQKx+K8cKT6
 NrglYdaPw13Q3rjf2sw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-09_04,2026-04-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 priorityscore=1501
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604010000
 definitions=main-2604090171
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-34554-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oss.qualcomm.com:dkim,oss.qualcomm.com:mid,qualcomm.com:dkim,qualcomm.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jeff.johnson@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 5224E3CECF6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Per ath12k convention, a pointer to struct ath12k_base should be named
'ab'. However, in htc.h, several function prototypes do not follow the
convention, and instead use 'ar'. Conversely, in htc.c, the function
implementations all correctly use 'ab'. So update the prototypes to
match the implementations.

No functional changes, compile tested only.

Signed-off-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
---
 drivers/net/wireless/ath/ath12k/htc.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/ath/ath12k/htc.h b/drivers/net/wireless/ath/ath12k/htc.h
index 7e3dccc7cc14..05b3e593542d 100644
--- a/drivers/net/wireless/ath/ath12k/htc.h
+++ b/drivers/net/wireless/ath/ath12k/htc.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause-Clear */
 /*
  * Copyright (c) 2018-2021 The Linux Foundation. All rights reserved.
- * Copyright (c) 2021-2022 Qualcomm Innovation Center, Inc. All rights reserved.
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #ifndef ATH12K_HTC_H
@@ -301,7 +301,7 @@ struct ath12k_htc {
 	u8 wmi_ep_count;
 };
 
-int ath12k_htc_init(struct ath12k_base *ar);
+int ath12k_htc_init(struct ath12k_base *ab);
 int ath12k_htc_wait_target(struct ath12k_htc *htc);
 int ath12k_htc_start(struct ath12k_htc *htc);
 int ath12k_htc_connect_service(struct ath12k_htc *htc,
@@ -309,8 +309,8 @@ int ath12k_htc_connect_service(struct ath12k_htc *htc,
 			       struct ath12k_htc_svc_conn_resp *conn_resp);
 int ath12k_htc_send(struct ath12k_htc *htc, enum ath12k_htc_ep_id eid,
 		    struct sk_buff *packet);
-struct sk_buff *ath12k_htc_alloc_skb(struct ath12k_base *ar, int size);
-void ath12k_htc_rx_completion_handler(struct ath12k_base *ar,
+struct sk_buff *ath12k_htc_alloc_skb(struct ath12k_base *ab, int size);
+void ath12k_htc_rx_completion_handler(struct ath12k_base *ab,
 				      struct sk_buff *skb);
 
 #endif

-- 
2.43.0


