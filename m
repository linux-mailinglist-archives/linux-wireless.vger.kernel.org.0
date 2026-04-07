Return-Path: <linux-wireless+bounces-34423-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D2XJpaV1GknvgcAu9opvQ
	(envelope-from <linux-wireless+bounces-34423-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:26:46 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 507983A9EBB
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Apr 2026 07:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AA8630086BC
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Apr 2026 05:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37EF337472A;
	Tue,  7 Apr 2026 05:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eq0E3dbY";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NyaIJwRL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D422B14B08A
	for <linux-wireless@vger.kernel.org>; Tue,  7 Apr 2026 05:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775539599; cv=none; b=pM4msZjQJAPKZxJjRUXlCcIOS71fmV8r2g93W+tpfXp/AVdLxw/8NDEECy7crE3oBvHtCEpWHlO38Pc19lfrWIDZfXfdaFrCtpJfuS8t7BTkLWzz/qfNbB2QVeA8NKYRhqrUBf5kZcsToi6HuWAnsbI4N9rLQV47RVZWp5skgbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775539599; c=relaxed/simple;
	bh=UGI17w4oVeqScNVO0ib5O1wZufPYmmmMh2QN9gvEDxc=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=lIQsuvrPwW6fnSzW34k8HQu35JNXrcMO6lvmwVX36B2XWm4CE0Zv+Gugv4Br60/rtHRwJYDw4xkD32KExNoPBvY559spSbuYMT4sv+8fdxXF422PYiLecgAZqFGcDjvhFyycnfb4R/NQz30pqOuVl2KcqKoSR65Fej+mSL9lBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eq0E3dbY; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NyaIJwRL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 636LQ0mT1403547
	for <linux-wireless@vger.kernel.org>; Tue, 7 Apr 2026 05:26:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=esLugqp0oA5GjPWw3xFHpZ
	etDg4cY8K0pJ/wq0+XVWo=; b=eq0E3dbY8hqt/QPi0q4G35Rqgx4SqRebqpmWOF
	unH+6k6AkTY9qD5vWzIZP0Jcqo7afk7Un/4OUMChPQLG3KGOGuwilj1k6Fgi9TBQ
	8FwKS3pctbSVG7Wc7lOkKvJKrLcPqbAf8eaWnHGX9MFQ+lslvZEjsCnJi3VunCaf
	bx2kRDvhr7JUqHFBXdFtjta8cWrrooT/+vb09Uf6eswIjNrc0lYvPa6FLRjJnY2t
	WrXZS9xHFAnqLX1+3nFLjkF2XrwXMG5UbF8j1kaGDihPojEtd//Y+tut4Fbtc4s8
	gLLuYzeeObXGZBWF+WuKh7vThA8GL9Aez8oJUrkTg7Zx3aVA==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr895er-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Tue, 07 Apr 2026 05:26:36 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-c76fe944e6fso301641a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 06 Apr 2026 22:26:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775539596; x=1776144396; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=esLugqp0oA5GjPWw3xFHpZetDg4cY8K0pJ/wq0+XVWo=;
        b=NyaIJwRL/n+1CDp7Itmc9gZ2BtbVTzPeCwMjeXijIzA11weRQW8Rnal+AHFBL0wMHA
         6YRY1sxPVADBvU5CvUZ85ROWrWoUjXvjCvbeZs4DM4Mq0lRL+X/mugh1F1KrUSEDcZLT
         rxqM32DIwcj9dUXfl4h4+d37T38ntLgukMeCdiY7ZlvG6IPt2SDFrzfk7RqNF/TRS94a
         bAHyFGTka+m7MQRTgdm74YOoPtsozJnzoANqkoiUuOVOtu4NCPZWtphNHPf0Tl5A2BwD
         Ajbd45+v9kKQvp6UHC4+iwKBo+oEsR2FzHxHI2UAhpKHK3q3+pzYGpvbETLtt3wCqxEv
         sxCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775539596; x=1776144396;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=esLugqp0oA5GjPWw3xFHpZetDg4cY8K0pJ/wq0+XVWo=;
        b=FPYYo5EUQh5SUvm4g6dPb+jsbHjVHGv15SErOFXiO7x0kpuPDPBt6pxdpmTgkQE1Sx
         k6mBTfBMX0odu3wJzkvNYuUpa01zeNkJQ4DGXJBgAEbhqEbU2jJXzJAtoTR09kMAOGPb
         GfImanZeEyY5KRgfb7RYP+zgcbqcGsKDMPrXS3BcQkWJnyLbLvMgIQ1tVAgw7oDJxzOT
         kkp/f4AwpH3g/FwZwdUXPpmn0CAx/DVyoBrTPhn/TfPYz789G6ndDagEilLO8xNPt9lv
         Ju4ECQ3pooZnb0e+iWlOBRypjMGq+v/I8IGxm9xTg8sIqszNZI8Ys+217Sx2LWRtJnoj
         i3xA==
X-Gm-Message-State: AOJu0YxWbIkXeoSJfdBk8yQWCxb0yydB2YDzPaLSuh5N9gSR1IlLp5sx
	IzfrJCfSkUmi0Dxmbvn2ZG8ODS57hPNSX5GaIe2D4f77qFA0DYV6oZZj3hmJOJPtnntevciAPO+
	FeXK0m3DLTLChv0r4drln2MsGnVvJvSXJ//KUjFjBFhaRSBOEufOUAAKtGYoSwIno+MFW559LPB
	e5qg==
X-Gm-Gg: AeBDiev/x0GzA/h8I7ZTijrYx2QAMxG0WSKk7D7UtrWcQXxXSz+f22s3QwMO5MLCkIF
	dmEyz2b1oA/MOAtUJPZAG5+jDAGMl/taSxPYUp4Wy/w7pyKatSxyTNF/+cNMPTdFlzWG7tAeY2s
	1qYasTImsp+bPH4bVr4/CSTrWrWYe4BA71PzI0iqPFLj46qf3217sQdzk1FolhLoDdeYJ9FWwls
	ouzii6XROxJ/ZgQQrBuOLDGsOgSwkU+36L/q0b5iZwCBI4yQJrH+29zhKktcVIjZNOa9F33gFsu
	NFcpKA9+O/mRZABSvKdw4efH7LG8POhbqK77cL8vAnKEDPYpXOjpqPiFaVlxHt+KttBUVwEsbas
	20g2RdkDed88fNfhoIAHvDcL/x8/Isx0WawQrWEhi4KY2o5IcmfhKq/co7BS4GKNVE4/OQ8Z1be
	HBBjlSaQ1JLWp93de8rue5OewQDTQTacgDHflQils=
X-Received: by 2002:a05:6a00:301f:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-82d0da90c83mr15364875b3a.20.1775539595599;
        Mon, 06 Apr 2026 22:26:35 -0700 (PDT)
X-Received: by 2002:a05:6a00:301f:b0:81f:3fa0:8c38 with SMTP id d2e1a72fcca58-82d0da90c83mr15364841b3a.20.1775539595098;
        Mon, 06 Apr 2026 22:26:35 -0700 (PDT)
Received: from hu-rajkbhag-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c68273sm19897219b3a.41.2026.04.06.22.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 22:26:34 -0700 (PDT)
From: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>
Subject: [PATCH ath-next v5 0/6] wifi: ath12k: Enable IPQ5424 AHB WiFi
 device
Date: Tue, 07 Apr 2026 10:56:27 +0530
Message-Id: <20260407-ath12k-ipq5424-v5-0-8e96aa660ec4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIOV1GkC/3WNyw6CMBBFf8V0bUlfVHDlfxgXpR2kKhQoEAzh3
 y114ULdTHIz956zIA+9BY+OuwX1MFlvXRNCut8hXanmCtiakBEjTBLOKVZDRdkd27ZLBRNYG1N
 IroRU+QGFUdtDaecIPKPQxQ3MA7q8P34sbqCHjbd1K+sH1z+je+Jx8U8zcUwwFWla5FoBy/XJe
 Z90o3poV9dJONExiQ9FEPZFEYGiDQVSEiV1lv2grOv6Ahj87LgVAQAA
X-Change-ID: 20260331-ath12k-ipq5424-cddb63a46a97
To: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ath12k@lists.infradead.org,
        Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>,
        Saravanakumar Duraisamy <quic_saradura@quicinc.com>,
        Baochen Qiang <baochen.qiang@oss.qualcomm.com>,
        Sowmiya Sree Elavalagan <sowmiya.elavalagan@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.14.3
X-Proofpoint-ORIG-GUID: pacVTU0F_b_URIEOBd2bkOAx6HxD5-o_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA0OSBTYWx0ZWRfXwlSwUVXFFj1K
 4GyKlTUAxGHrTF/xR6fWmP3YFQj433HwbifRs6nXb1PXB9PAerS59zg6k/NkessnRCUbaVy+pRJ
 dXv+pbrRpikKkgWEkdBbZviv2r295jSVizxfBWaDyM10Xf4fYlU6lYj72oPLzF52D7+Dlsr88I0
 gs2aMBeOitj+iYorQVeWF/YLPZIdU597uIhmDiu550sa4bgVlpORbGhy7bZABfs3l+Njv+TlX02
 y2b0o5WDrJtoSF544s+8EEdUGga98gRhhrNlDrZtXaFq6HdJ5Dh78GrnfIUeOviIUS9YdfjcCNh
 KvOUbg37WCJmYgMiu+uyJcqtkTimxwJfGHvT2WIpg5dBP35Wr78dWerShYoK86/KkmcKDWtssXG
 EeKuyXuK6eskXLFbddfAgujlLy30AZ7WOyb95SJmlUf8RMZI71JWPZe1ePsKe8/htjisg+vqp9q
 xU2qItDMpE60z7/cVFw==
X-Proofpoint-GUID: pacVTU0F_b_URIEOBd2bkOAx6HxD5-o_
X-Authority-Analysis: v=2.4 cv=A/hc+aWG c=1 sm=1 tr=0 ts=69d4958c cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bC-a23v3AAAA:8 a=COk6AnOGAAAA:8
 a=hfZH_8odhG_REILTePMA:9 a=QEXdDO2ut3YA:10 a=x9snwWr2DeNwDh03kgHS:22
 a=FO4_E8m0qiDe52t0p3_H:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070049
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[qualcomm.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[qualcomm.com:s=qcppdkim1,oss.qualcomm.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-34423-lists,linux-wireless=lfdr.de];
	DKIM_TRACE(0.00)[qualcomm.com:+,oss.qualcomm.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,oss.qualcomm.com:dkim,oss.qualcomm.com:mid];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[raj.bhagat@oss.qualcomm.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 507983A9EBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add support for the new ath12k AHB device IPQ5424, as currently, Ath12k
AHB only supports IPQ5332 WiFi devices.

The IPQ5424 is an IEEE 802.11be 2 GHz WiFi device, supporting 4x4
configurations. To enable the IPQ5424 device:
- Add the necessary hardware parameters for IPQ5424.
- Modify the boot-up sequence for ath12k AHB to accommodate the
  requirements of the IPQ5424 device.

---
Changes in v5:
- The mhi_config and current_cc_support hardware parameters are explicitly
  initialized to default values.
- Link to v4: https://lore.kernel.org/r/20260402-ath12k-ipq5424-v4-0-cd1e0f0a6c88@oss.qualcomm.com

Changes in v4:
- DT binding: dropped copyright update as per discussion in v3.
- DT binding: Used DT binding from v2 and retained Acked-by tag.
- Link to v3: https://patch.msgid.link/20260331-ath12k-ipq5424-v3-0-1455b9cae29c@oss.qualcomm.com

Changes in v3:
- DT binding: updated copyright.
- DT binding: Dropped Acked-by tag as copyright is updated.
- Rebased on latest ToT.
- Dropped ath12k_ahb_ops because qcom_mdt_load() and
  qcom_mdt_load_no_init() now have different number of arguments.
- Link to v2: https://lore.kernel.org/all/20250518-ath12k-ipq5424-v2-0-ef81b833dc97@quicinc.com/

Changes in v2:
- DT binding: Removed the redundant example for IPQ5424, as it is similar
  to IPQ5332.
- Added driver probe data structure to eliminate the redundant switch-case
  logic in the ath12k_ahb_probe() function.
- Validation completed, hence changed from RFC to PATCH.
- Link to v1: https://lore.kernel.org/all/20250130051838.1924079-1-quic_rajkbhag@quicinc.com/

Signed-off-by: Raj Kumar Bhagat <raj.bhagat@oss.qualcomm.com>

---
Raj Kumar Bhagat (2):
      dt-bindings: net: wireless: add ath12k wifi device IPQ5424
      wifi: ath12k: add ath12k_hw_version_map entry for IPQ5424

Saravanakumar Duraisamy (3):
      wifi: ath12k: Add ath12k_hw_params for IPQ5424
      wifi: ath12k: add ath12k_hw_regs for IPQ5424
      wifi: ath12k: Add CE remap hardware parameters for IPQ5424

Sowmiya Sree Elavalagan (1):
      wifi: ath12k: Enable IPQ5424 WiFi device support

 .../bindings/net/wireless/qcom,ipq5332-wifi.yaml   |  1 +
 drivers/net/wireless/ath/ath12k/ahb.c              | 36 ++++----
 drivers/net/wireless/ath/ath12k/ahb.h              |  1 +
 drivers/net/wireless/ath/ath12k/ce.h               | 13 ++-
 drivers/net/wireless/ath/ath12k/core.h             |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/ahb.c        |  8 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.c        |  7 ++
 drivers/net/wireless/ath/ath12k/wifi7/hal.h        |  3 +
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.c    | 88 ++++++++++++++++++++
 .../net/wireless/ath/ath12k/wifi7/hal_qcn9274.h    |  1 +
 drivers/net/wireless/ath/ath12k/wifi7/hw.c         | 97 +++++++++++++++++++++-
 11 files changed, 235 insertions(+), 21 deletions(-)
---
base-commit: 15551ababf6d4e857f2101366a0c3eaa86dd822c
change-id: 20260331-ath12k-ipq5424-cddb63a46a97


