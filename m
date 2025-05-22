Return-Path: <linux-wireless+bounces-23261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8448BAC01C1
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 03:35:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB0511BC22F4
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 01:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CB178F4A;
	Thu, 22 May 2025 01:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YmSZrNha"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13BF176025
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877715; cv=none; b=UjayhXOlwgD3XOIuR/vB82u/6XqsvjSdzhmkhQAgi8Q3UNH5bhX7U6T5Q0be9IYUMzfg0FVwz8C9JEW6u2QfsIs04cLvZQwz0xxtgfa+wo+DLaP3vJxTmqLQW4mTVhLQKvHK5KrRfy3O/cBR4plgfUV87fyU7zzWxX7U3ELYJ3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877715; c=relaxed/simple;
	bh=SZhkIa3nHiSD2OwCgjn51cgXa6dp4u51++oRoR24ruA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Iy7tf2zej8bRK2AmRTA8wcUAMOzMcJmB69F4yRzU95RjOmQTunKMK7FCH7MuvDTsZbEQe2RAlZOdjCd7P5UkEKZRX6qR3Ijlxdsqcf/V9j3bbP5yjFD0CDQkVH7A1UdTPpLBswP5fG7rI8ewBE7PnQ5VCM/8fYf872ScYArVhAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YmSZrNha; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIipFN011332
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=3zGBRTqAmBn
	vpxhEF2Dmcbo1fNVeSsL+RLE2tNu0FwQ=; b=YmSZrNhaKyrp5isvd/iCkUDyO4v
	b+LNo7foICPxlskIxA1UFovhLjB7ajYOcJ7Tts6YHkhiaOHNNqmfVl/tnM93/Coh
	aeBDS0w6wQjP++GbA4c2zOSxk4tx1WlalQ3Vd4wWw7nXiWC3EoinuKg6UZih0MLu
	TEn/2MTRON4rIg22kvZo/F4YBvYAF0iT0S8itmY05Re23XOLOvhZGk6lk0QBodRY
	n7BR6wLN4OrTgEU/CxUgVntbFWDl1bsL0LcA0vEgRNFGdWqNrGdmUFvcMjA+62HM
	CP9nXe+E9iQFcRNNvRwCMMNuVX+o452YZxKwIpzNd20/WPhAD7/DczHARyQ==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwfb4kex-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:13 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2326a6d667eso28085275ad.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 18:35:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877712; x=1748482512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3zGBRTqAmBnvpxhEF2Dmcbo1fNVeSsL+RLE2tNu0FwQ=;
        b=genfc0GwPTwydF51W/BvT8fsnihdhf/KFoSSUg+2dmfkuQE16+ualiiJ2RGC/Rj38j
         P/MSrorKVFcLzbLaANvCyiRKHXqFUN3gjYAlq9Nq8glP8y6KMWx07kRPa/oUdCKJAx9G
         hXKiqeg/fJJPmZiRJgHRFKFB6S2xaHByeL8C3P0/tyq2q4rK/NWttwzQjCXL545tKaaB
         Tk5jtRP5IuCmJ+ZfHHsOAbzvOXYrf55BWZ5t2ksLnjPR8U83b6iLe/N2bb+xx4hdicWK
         tfw0TytYqWbT3/y7GkQEHi1i7K+qdGPqaFFQVcSW26lViRq0CAH5xQ917o4UahpJa96V
         5tLg==
X-Forwarded-Encrypted: i=1; AJvYcCWR9SnqxqAF7ibEDwn+BF+JlQZCyMqAsu2sWLtUw3E+85R1xMHZu/qVfG8C3EhWf6BMxQHBdiMBkQSqikqg0g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzZ18HfWffADlRYfxgKHUnqW1FyrvPdSxjSnTNDXgppTkUY+Pg6
	0RrQjQ2mgRNX9QQHiVcietu+OuBoodauDzxz3VQ4Ei+8KE0dsaHfwoBmSmQl3fhatO+IXNGPbuC
	C+3iuZYy0nwzQ0aQseTfD9d0vJzWXoSOBAAgoQGlG58Jr99gdV1cRC21mlK87Ywugkn8ylw==
X-Gm-Gg: ASbGncucnHuuYpja8kgE9pLfBwCjA9GZBX+45q16NmiN50LCogjdhK+kfEJMSP0mi3l
	+Sixlv4Sh+uuH9GL5qy+9kA7QW5IIKxjnj+bEwxGnyLd6UOi+GYFoBbhvlLLPpdACSeT6t+6P1a
	UISoFDmnXszByOo7/j6w03r7wzfy/8hiSJJloJB+dSXap9nqH0wdb+m9kBpHLTfrAc7Gjk2iKmf
	CdM4VPokVFche6MX9LbrFQ++xQUcrdFpPHPYApuVGlkz5AehIIR12JnEXlop/PDZUFEFSe4oPyg
	cQWRtfuOiDUJR4A1bIny9dqmT/iQMLUzlVdrHa6/v1TIsgSrIKnXwnNRSxAhM3wVk/igwxI=
X-Received: by 2002:a17:903:2f10:b0:233:ae8c:9a0a with SMTP id d9443c01a7336-233ae8c9a2emr77802565ad.30.1747877711655;
        Wed, 21 May 2025 18:35:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHoxobwttIqNxEUDAXBpCLS6Mo7zWZ1W1Sk/YXCKQXES926y90bJCRSSYZBb9X03RqZdoqx6g==
X-Received: by 2002:a17:903:2f10:b0:233:ae8c:9a0a with SMTP id d9443c01a7336-233ae8c9a2emr77802255ad.30.1747877711212;
        Wed, 21 May 2025 18:35:11 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d45b2sm4341488a91.26.2025.05.21.18.35.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:35:10 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 1/2] dt-bindings: net: wireless: ath11k-pci: describe firmware-name property
Date: Thu, 22 May 2025 09:34:43 +0800
Message-Id: <20250522013444.1301330-2-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
References: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: cDctLlfYx14H0HSH_BE0TQdlFVTePnTg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAxMyBTYWx0ZWRfX9xePMi4iysNO
 C/WU1v+H9bLe954VwjOKi/k1RJ7eGXOKn5V7Ye3PBpiac905tRUMci2ldnsxs2N4i/RoNhX/q4V
 5bZJW8U1NPr6QBx/VWHOHFfcAC4omnCjI8diyQmb0tlOn15fK4GTfKb6sBcT6/MG9YO1g/xzNUI
 mqVzRDjUUofm1dO+/nfzTIV45BXksEdhSanKRN7ZTdw5DGd8NCm5z/RKZe07kNxEUTFb4zLamGd
 mEO2t0e8k5Y+gcDyAF6th7ZtOHLQk6YdI5NuCgAnEGy0eat4X2wVDfQ5C8BCj9+oetNU99dCRgQ
 YgcvMkK0zMJDqIC5dXg/6EnJkDkkjaZG4/T5NefshKWwitK5Q+hThLCr6F7ZncrXwmrSRMW8mwH
 KJIbwyPBckRjc8DrOdQMkJhZ1MfcSdCi9akJLVswFOxYEe2a/P4qYrBjhKFuhJivM6MHdQtS
X-Proofpoint-GUID: cDctLlfYx14H0HSH_BE0TQdlFVTePnTg
X-Authority-Analysis: v=2.4 cv=dLCmmPZb c=1 sm=1 tr=0 ts=682e7f51 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=Hda1I3ypr0uxOpTqMjQA:9
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 clxscore=1011 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505160000
 definitions=main-2505220013

Introduce 'firmware-name' property to allow end-users and/or integrators
to decide which usecase-specific firmware to run on the WCN6855. This is
necessary due to resource limitations such as memory capacity and
CPU capability, or performance and power optimization for different
application scenarios.

Two firmwares are supported: 'WCN6855/hw2.0' and 'WCN6855/hw2.0/nfa765'.
The former is the default firmware, suitable for most WiFi 6 STA
functions. The latter adds support for commercial-quality SAP and
optimizes power consumption for IoT applications.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml   | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index 653b319fee88..e34d42a30192 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -35,6 +35,12 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup
+      usecase-specific firmware files for the device.
+
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
-- 
2.34.1


