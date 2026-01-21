Return-Path: <linux-wireless+bounces-31042-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iNKTORakcGlyYgAAu9opvQ
	(envelope-from <linux-wireless+bounces-31042-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:01:58 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 966C954D63
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 11:01:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 583D26021C5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Jan 2026 09:51:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FBE834D4F6;
	Wed, 21 Jan 2026 09:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TfYz9nVO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DPa/QTX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9961B3382CE
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768989066; cv=none; b=KytHn6/doejtLdQsYQhFYup8wNkvwWucjh47xyXHpIJw8CBjR2huXqNRbcOjyqGkr7eN5BixCC6R0jOtemUh9fqD6/x/wrD8YdWwMduusOHIUb+LYmh2Uj16fw5xejkGXUjnPaZyu0AKPKxX25NULzsdk+K7pATMp01kNXc839s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768989066; c=relaxed/simple;
	bh=BNcIuJH8EUE2zF3vZQG9OzcXb+leeeY7urfxxzy60hY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MWQ5Y+3HSbA1HGbk3MqKV8oZtr6kdEvJSO4nevojTvDOKfVocgpIPzrH27MRBOnt2nEW0rviihbi6CXzAChy+goNfE6JU+iBBnAL0lB5sl72Q0Tsd/Qoca2dvsIpTsF7o/TClJm8UwxaLvj9h9SFbiHSDO341I5cmdkz4gL+s2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TfYz9nVO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DPa/QTX5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60L8vEHn2946280
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=PURqCEKMifr6B1GEdQBwSJlrDsBZNunu+PW
	kWKYvso4=; b=TfYz9nVOCmQAgibu+/xtDg1dYxQXsrIANkLIhx+JpxA9gqJlih9
	En7CCPNu54wGiQK06QIRvaS6HXUmzWjzpR1dEU6xkx9trQiu+FJHyvvRjL3rZX6m
	UQyCA/HoEFufwfeOlpuDS/xbrIykEk24f78BnT7TVJF7rV0CCt57CxkjI7zyKrbd
	1wSQWfI6+n5+GLC+knxiv8TcRaQC7VcnaKiUMC37MEEYzPRlJFcUfJbmroYgwKLg
	r7F45cYSERx5PQyIi49Efz2aTiewWA4ODBBMCNo5njoD1luNTzxAuyaEAd1a6+YU
	Uc+8GCT6gJVZF1buvDFkKEouXHcj1GMEyOg==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4btur98c8n-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 09:51:03 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2a76f2d7744so14888595ad.3
        for <linux-wireless@vger.kernel.org>; Wed, 21 Jan 2026 01:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768989063; x=1769593863; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PURqCEKMifr6B1GEdQBwSJlrDsBZNunu+PWkWKYvso4=;
        b=DPa/QTX5LmZk996l2ZVkN3ep4wiYX4vpR+FoYrcDz4NxT1CoxQxpeDsTTbEHluq8bi
         M0cgknKkq/GwAA/s7/+ZBCMYN0Fx986bhk7YITZxaQJ1X0n+DLxhsmmMavNfjshts9q4
         qxFnKP1flfD8aAMwVZ19K0fSbKMj0WK1sfwW793vnGjwSvkETTVO4iiBT6DaEiypnU6t
         l+NhUgjnSU5QZJchfSJQPni8Vo2iTK+5bOrzsppqNl9N3FmaZcIgKarhNJUfaY8qdBCg
         qq/0sb5t9c/NKStfLLp//yFmRwhkfA7IwNxai6XwlUeneUV/c+AP6gUf4e6mwj+9T/6s
         PZHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768989063; x=1769593863;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PURqCEKMifr6B1GEdQBwSJlrDsBZNunu+PWkWKYvso4=;
        b=k756cIbXo6RTXBh2eMc5876nPzAGiRlPpJrYqV0j/kFP8h05DcNuxS+D2JabGt4hD/
         v0yEN7jX+is67DjbJB7xF4MeIP+InZdQCGoVkKzRywpBzOHjpt3vlrR/C82EWUCEybSE
         Nz7uUuTrhou+KL781sxzxOisiwjVZPZZxPtmOLg2hEtnxG/ESN8BmfF2ClyKS8nTipMr
         dgescpTNBvstJQbzkz0lXJvoTRnMFrb19xW9d8LH0oIszpsImqVJJRimrIyPKQMIAJac
         a3luyyGpEhWCTFHByBAyUDMB9LByCo+F4uBu3ha2l5TzSORIfpgoz1ylOwah1Y14qn6r
         5k8Q==
X-Forwarded-Encrypted: i=1; AJvYcCWZu+dBKMUcEzoyd/V7Ef4bUo9rGliCQ5oNcfegwg26o6UbMPEvQjVPpfp3QMXbpzGy4hj7iyb50gWq43rm2g==@vger.kernel.org
X-Gm-Message-State: AOJu0YyUlaG6Diy4/UKVkc3yobFMoFwE02saEDJFtsc+h3gOQm46z6xZ
	q7HyLsygszxr9+d0jJKup8mmOepJ2Fu/E2gX0kszbKOTRt8a9AaelNv4BH1GxeHinC+WMX7LQJe
	GQWM2DINZb6mUyRmbHM3CgL2/4GSoB5kgONSfiozUI920yUO4Mha86JQ2hG8RhOPzk8T6BCGSSj
	KaXg==
X-Gm-Gg: AZuq6aJwXSiisQwJzk9bDQoGGAUrSGSv/Up9DGlYl5ZWfrKs9kKW1sBwEzCbT5jldyo
	8Cz2GRO1H8AKQUu/bAgIDmNsUpHgmWEBUI17exNp2/RS462iPA/hlkeQNBnnqO5DLq7FYIBn5No
	pc5TN3r0Uymt3PGya+QdYI4BDyQ7klx80L4zGP+TICf03B73OM0g2X/yr95zxT2RzbXZqOB2VpQ
	/ieL6WnnuyCrY4OVu9ZsaJZvM/fuYWbBgx7PN5EkDdD4rUElZJ76eMC8YZyYxcjhbFyid1KE9uN
	D4vYaWR3UxMedYC7Hx+hgMkAEa0UPEt7TNKGcCISLORWK2KL0GkzThM7nD7wT75j7mnczAcxKr2
	1k3XB6a47AVC70d/HsDLRaL2cdWVRN4EOWXf20q/kdRgIBnzlER+R30bs7J+ZcLwCHBMQ
X-Received: by 2002:a17:902:cccb:b0:2a7:5171:921f with SMTP id d9443c01a7336-2a76b066dfcmr44438205ad.46.1768989062953;
        Wed, 21 Jan 2026 01:51:02 -0800 (PST)
X-Received: by 2002:a17:902:cccb:b0:2a7:5171:921f with SMTP id d9443c01a7336-2a76b066dfcmr44437935ad.46.1768989062449;
        Wed, 21 Jan 2026 01:51:02 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-352678af047sm16997295a91.10.2026.01.21.01.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 01:51:02 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        jonas.gorski@gmail.com, krzk@kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v4 ath-current 0/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Wed, 21 Jan 2026 17:50:53 +0800
Message-Id: <20260121095055.3683957-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: pFdw5bxFx6oE8HqtK8tK4tej_EbHBfla
X-Proofpoint-ORIG-GUID: pFdw5bxFx6oE8HqtK8tK4tej_EbHBfla
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIxMDA4MiBTYWx0ZWRfXz4AZYHqgkJfj
 VYvRg2D80nfcToUUWIaBMgl++HBxM0D+Ip3/k+bQj8bYmBbF2Dvaqtxln5yYYrZ9FihXz9pq1s8
 +I98gj9IbdzBC7Bz/cZ4ToK4MYwjwhQZX6IMcLaCXF/PTndprE1UAeyOLP50FLqvs4i16SGd3U+
 XU63juAC9H6wkzTISJlwvalzirdhnl+de4DIvy59H4BbhGcnvZb1hT6/iUOv3xrL5SyjyoUG39c
 Rz2pd4f/BsiyuNGDmEboXyMESFayK6A5wk8Bh8PB/YGSDHuwQB764B9PtRLEfh4NKwRvkVHF9Cx
 bBGu1kEhBFA51WnrxiF5vT/U6PHBInpgIIW/2XAj07MdfJeKhs5JtjVXhP+HBS0gm8CwdsqSnz2
 pB9ZN1kWTt3geAr+lA7k6sf6/yU/3PvDMoUvK6mAqIyt68ra+uCSP+mSjVvmn+p60KXYFUum1K7
 J3waIcJK9UV76fXdPlQ==
X-Authority-Analysis: v=2.4 cv=QstTHFyd c=1 sm=1 tr=0 ts=6970a187 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AnkVv3gU2zmn-KRWxgsA:9 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-21_01,2026-01-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 spamscore=0 priorityscore=1501 bulkscore=0 clxscore=1015
 adultscore=0 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601210082
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31042-lists,linux-wireless=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,oss.qualcomm.com:mid,oss.qualcomm.com:dkim,qualcomm.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.infradead.org,vger.kernel.org,gmail.com,kernel.org,oss.qualcomm.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_NEQ_ENVFROM(0.00)[miaoqing.pan@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[qualcomm.com,reject];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	R_SPF_SOFTFAIL(0.00)[~all];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 966C954D63
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The 'firmware-name' property was introduced to allow end-users and
integrators to select use-case-specific firmware for the WCN6855.
But for M.2 WLAN chips, there is no suitable DTS node to specify
the 'firmware-name' property. In addition, assigning firmware for
the M.2 PCIe interface causes chips that do not use use-case-specific
firmware to fail. Therefore, abandoning the approach of specifying
firmware in DTS. As an alternative, propose a static lookup table
mapping device compatible to firmware names.

---
v2:
- Drops `firmware-name` from completely.
- Updates the commit message to clearly state that the property is
  obsolete and the change is ABI-breaking but safe for upstream.
v3:
 - Deprecate 'firmware-name' property instead of obsolete.
 - Keep the ABI backwards compatible.
v4:
 - Use of_machine_is_compatible() to simplify the code.
 - Add back Acked-by tag. 
---

Miaoqing Pan (2):
  wifi: ath11k: add usecase firmware handling based on device compatible
  dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name'
    property

 .../net/wireless/qcom,ath11k-pci.yaml         |  1 +
 drivers/net/wireless/ath/ath11k/core.c        | 27 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h        |  4 +++
 3 files changed, 32 insertions(+)


base-commit: d8e1f4a193101a72235416f189b01131a57e26e9
-- 
2.34.1


