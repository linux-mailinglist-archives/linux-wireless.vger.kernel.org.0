Return-Path: <linux-wireless+bounces-30958-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B3FECD3AB37
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 15:08:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BAAA7301D66F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C588A36E47F;
	Mon, 19 Jan 2026 14:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="k+B8GWtf";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DeYGlYYN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058A53502BF
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768831372; cv=none; b=k1YPRR8T8AuBjULsuwUbTy0amzGWloxBXQ/sp3UoOFMIiYC+2wXV6yoSkhHRhELIldxkOrQaPVQ9G+3Xr6c0Y5aXVxWnhNbjFu2i2/9Kg1QY4UA3/BUfto2x+iwT4bnKHM/DE97NTKYuDbtbFkkEKkkbU2V+lseqmWghS7MAk3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768831372; c=relaxed/simple;
	bh=E7fHKTwM5kQWA24lxy1RNzMv9gSOpyB9Vk3+2q6FLHs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KZi6ogRNXd6X0YOW6Fj46P6PleB7W4R9rtWHqTg5dZU20H8XQaa9xQoatrbUUt8FYnL4tacnL4T7ZfZLa2r+3ReHkek/q512uXf/excKTEVkkZtSTQ+kf1ItCPFoctrRQwm+ur/KLzZqII6s0gVOah9ZheQ11BifuXjMNcHyqYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=k+B8GWtf; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DeYGlYYN; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60JDdDqL1347463
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=fGhqupyolB5uH9UFQOHKkgJ43muW2xQ3TpC
	9A+8sGfY=; b=k+B8GWtfXi/Dw0gvpD0r0AyT1KUcu7tZb3u9W/XBqYt0Dg4PKjR
	oMSIMAcAq9zfEfHdkcgAiFWlDYhbwjAA0G91+96QXnMfLE+Nbj0Y9TkctgqEgy/c
	zOoRGAYTSE5JZixc/yUAYSmT6tfEGcKp/QbMgfqJuTFtSL9KPAWtrqJZpwJ3jxZZ
	X65OW8lY6R3jkTmsBjMBMc9BaPMUjXlksTKuzBNhGJ8Nnnl+Q9ok0KbGBKu8vTvo
	q2CmuMiISmKcxRltJJKNHcU5HiZm+n3UGpCGXz1+6VXLsyAyXz007SHk1r9bnKkS
	yxIehqgb/jSxEG1V868VuNVg2y/5tpX3Apw==
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4bsnpdg1v8-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 14:02:48 +0000 (GMT)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-29f1f69eec6so41887965ad.1
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 06:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1768831367; x=1769436167; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fGhqupyolB5uH9UFQOHKkgJ43muW2xQ3TpC9A+8sGfY=;
        b=DeYGlYYNjzBjqeUw6MmMxrTJqNH9jxsk2AS7dqJjntA77i5X57PTQ88dlaSazY/gNg
         c3iEvkGDNby6sglYoeRXc/NBs60t7X8W0OdSgCY9ufdFxEuVKzoWtWrk4PMDg3uliVm7
         fk/v3a/P7tinpNjA/2HHxj6LquHauPp1faG7YgP6+M35uXNN5iev0zRAQpolcL4qn/W1
         Fos5LBTS+pZeepi/O31DHgf43zRMm38W1qOcslvV43Bz1UKwpBpwv/aWEW468MaSv2OF
         kcoJKluVzp+TqU/tQ6dyrVtb0kMPOO13T7fdk9EzTfMDGUloXBu3M3eTraZU7uNRjGbq
         jt/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768831367; x=1769436167;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fGhqupyolB5uH9UFQOHKkgJ43muW2xQ3TpC9A+8sGfY=;
        b=mBv5sNYujl0aCQ4K8t+Hwc1Ze8mkn+umAHF1kQ4yNiEvWN/4LXbNt2byAnF0rZ6Tfh
         VgNc1DbV9r2MXwQHdVV6IPfKmihAE3T7TaPwCNVB9wkbgSc+7H52pGmVSIaPVdKysuoX
         8Hi4Fvn3VlC1fNfjCW1DQ+HDONMhMweILbEXV21NW6otTu/C1LuYcXznnNAyMMMvvSB7
         ASbxdtHEWtCm/8tXu+AbJD1Akc0ZL5UpecEAJTlzgtTGL500KZq16RBeP5NuQWocyeIR
         5tek12Vp74fGW+ikAtClbH4xCpSpVgWWHXWyqhZmrv+bevImQBPUw/Bacrl9axVjP+Wq
         iy/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVycw78nU6IBy62bbTTcWfeh7+grfIFabr/pucYPYFKWHM1c4mT6CJzHH+uoZ1lp2Y5Vroq8ju8Cfm3L7eBrA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyCOC+6oblWL/7jMMMk1jv1b816ZzAIoDQRfBfO6IVZDpOZDUY1
	B+jYk55eoy0TNtYscVFdSam6inb4LLVW2TbCvN/yHK/btqnWNnUJj3Uuuc8d04hxkEF6oDn60ce
	mrdowlGfO9yq5xwsupGCtu05xiIYG5odHeP+NltFCT8opKrJTz3oJ5D67RHi0WZ45ryNAgg==
X-Gm-Gg: AZuq6aLyk/6yBiN5jLMLu1yeEmjR3rMmrhnL8ExwSO0ss4PXSm6QKDe3UdQQZb7QsDK
	t27VzEqGUrCIZLU8Fpa1Qjdywi6FZDX6tp2NDbt02vdZiYCATQAfsCKqQ/uNIeheYVyfCgzeGRd
	ixiyoedbh2XWuMIGIDNCOSySfnyE+Ljt9SRnmmkYqD/2g64z5ZhGDwYe1X31LlA9Icer7VRnb57
	8n1rngC0VqcscUtHXnunk7D0CKV+hwEOp0qE48SyOwnPuRRTDqpF1rRDS7eU9JS0miM3Rz8PW76
	oaWPe+42Xx5SYLdsw48XXYyeFY1Q27/f5rJnMNcBl+C+b565LJNH4Ku5FTjseq2AkmS/0yw880X
	Y9hDEObm4qGfDakGx8sBwszTLKEcFjFYSCHAjSyplcEIaKD+FtzyuwXMfmFR304LfZbgh
X-Received: by 2002:a17:903:3d0f:b0:298:33c9:eda1 with SMTP id d9443c01a7336-2a7177cea20mr112457365ad.43.1768831367432;
        Mon, 19 Jan 2026 06:02:47 -0800 (PST)
X-Received: by 2002:a17:903:3d0f:b0:298:33c9:eda1 with SMTP id d9443c01a7336-2a7177cea20mr112456915ad.43.1768831366809;
        Mon, 19 Jan 2026 06:02:46 -0800 (PST)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a71941b915sm97416715ad.90.2026.01.19.06.02.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 06:02:46 -0800 (PST)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        krzk@kernel.org, Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH v3 ath-current 0/2] wifi: ath11k: add usecase firmware handling based on device compatible
Date: Mon, 19 Jan 2026 22:02:36 +0800
Message-Id: <20260119140238.3360658-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=NtncssdJ c=1 sm=1 tr=0 ts=696e3988 cx=c_pps
 a=JL+w9abYAAE89/QcEU+0QA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=vUbySO9Y5rIA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=AnkVv3gU2zmn-KRWxgsA:9 a=324X-CrmTo6CU4MGRt3R:22
X-Proofpoint-GUID: Q9x0XHlo3nEUZCdpAypef-fk6Gc7xkxw
X-Proofpoint-ORIG-GUID: Q9x0XHlo3nEUZCdpAypef-fk6Gc7xkxw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDExNyBTYWx0ZWRfX7Q9Z1yUnmGuP
 nhP45JnmJfHSbqrcyMduyZchXt04YCaTIzZrI98xpnEFlwQD8jjPaao5LroSb3bcPyjU9Pt+Gph
 x+96dXikTf5QZpVre1Qn4NhOypXSq4z+8O2AMChuCVhZyYm6uhi08IuK3JxhTGz1dt6tFEuZ1lN
 kYzUESPmfT5p7UX5BzCjHJZ21yl5bo4CCo+Ig6LB7BflS6V8pEjvbmER5cM6GGRRaRdL47IBd8Q
 dsgk1tZ1J2lKmQIC/o1OHGHy6YwNP6qJI+H45kzLq8VHxoZxDHfKD3NV4ZRG8wY474F3ye6klrQ
 jIZ7g1XIUFfdL64ErydSRbapnPyuRKTEaUbcIHsnJxWSo/I+uO+b+o4E8AKcoUa2DXTXe47GQeF
 VdSOeXMRaCfslUxiIR+6xta3Hw7GxlwdS8axVIbrq+hSyL0dV6IQrCyQEcvTfoTckDGQjyz9HFP
 Dj1Ebug9FlxPXBwuRgQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_03,2026-01-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0 suspectscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601190117

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
---

Miaoqing Pan (2):
  wifi: ath11k: add usecase firmware handling based on device compatible
  dt-bindings: net: wireless: ath11k-pci: deprecate 'firmware-name'
    property

 .../net/wireless/qcom,ath11k-pci.yaml         |  1 +
 drivers/net/wireless/ath/ath11k/core.c        | 36 +++++++++++++++++++
 drivers/net/wireless/ath/ath11k/core.h        |  4 +++
 3 files changed, 41 insertions(+)


base-commit: d8e1f4a193101a72235416f189b01131a57e26e9
-- 
2.34.1


