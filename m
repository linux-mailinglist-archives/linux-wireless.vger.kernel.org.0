Return-Path: <linux-wireless+bounces-21414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FAAFA853D3
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 08:02:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 499C4161BC6
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Apr 2025 06:02:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6810F1E0E15;
	Fri, 11 Apr 2025 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="n46d3/Oz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DCF6FB9
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351337; cv=none; b=uGHD8nCPZi4TVPia6iACsgL6nWThD7cEGe4qW1q8saKq1yFOXkU4hXWtsLXLVGtSdjCYX1qvaJQwuSeUu3h6M+b+SIlD3DTvUZZwgif7IFTTgh5jM01dntmf457nPGkz6KzDis/GSmW/Ohi3VmBQT6GbqRZ3LI/B0EsX8+vt5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351337; c=relaxed/simple;
	bh=bEE3uIbvtG/N6kY+S4K0RyHhE4lowN4qktmEQUsL6aw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cy9F++DLOcWISM5VO2ffE74Yub75KvWKBM8FPQ08lss0eI2fQPHuOMoCFl9qo4KDaDTtGeSDbLfIVL6B0sap8W7g+8jyCs/hKkUbdIzDpBVaRupFEIBpOhrmvwLT/EMaL6AkNnXDhCMG6XpHPrVvZRWkgCsJnxXxcH2l+2SVSjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=n46d3/Oz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5569w000726
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=oJ2TCsE35p2j37jzKpl48esGLYtNeNTDcBy
	vcDQWow0=; b=n46d3/OzYVW/w9oAmBILFh2ueCV1HM4Yp2u67BjAHRCI43VhvFo
	y3KeTXF6R49A44EgkGFpdSBWQ2VLvtZ/MOxRWJ3DmrPFn8UlHzOtql1nzg/a3QCD
	tlg2wnipIuUxBWjHz103SmyFOOo9jeVr+vUQRTfpyEZ1RO2s0OYE2qaMIbsII4Dj
	QNixESrPnrXuxPqvmStGzArLxkGWWsfNi57/FkAhxtQkaBkm0LO4tM/QbSyxaPkl
	cbBN8lwfVpiAE3x+1J87dArWSvAvIBHXCwZCN/tcr3IbQ+7uAHJ+r5a+/vYy5m6w
	O5NBz8sPMV+BnL+Qq4dh3i78DgfFOKjl3DQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 45twd31adt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Fri, 11 Apr 2025 06:02:14 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-736c7d0d35aso2043184b3a.1
        for <linux-wireless@vger.kernel.org>; Thu, 10 Apr 2025 23:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351333; x=1744956133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oJ2TCsE35p2j37jzKpl48esGLYtNeNTDcByvcDQWow0=;
        b=DWxxAtsQ8TgtbFGGYHYvtykwHR91JdcjUR2fRAtd6KWwyed8vPDs9HSJpc9W7oxTU7
         tWHUTxT/3bO3bhl/u/e27BIcDK9O79VcXrun1g9+i8RDLeArVIWMrTZmhp0MZ0m2NbOt
         IamW1hk2uMnEsKRA+KRsx4gvUBo5KtBYTUVXyBqnWBMBYEpLdkFhvtnHxKp1yl9A02/b
         7HErmTgAHp0OZZ03Ot1nner4bdL7W72EwUVsgSX5RJnamM+/pvhiX258Gk8PUz2AZsvk
         O1guw4mfuUXOHhS+vFi8DCO0yJjBbaeMZi9Gv13EGjSUAPYfZdkbK9PvswkEJpbFXspz
         Y3aQ==
X-Gm-Message-State: AOJu0Yw7KmAD5fTAH2D08QLqjrckKkDbfhrzQaUT1+yaSps4Lg+R+zhe
	Z9+lhC2LwuxDy8Jy4CNSBN3lNp0z5IQwDYg85SNYrsQ57gGA7R3zZA8X8ZO/J4fVgbQ1wcS+/Sn
	MZ+cB8pZ4usANnJKUxGlBhiLaPdN8E16l1VJvYey32un4TcAKLUNpf72zL+e2/RiKisGgq3+iFQ
	==
X-Gm-Gg: ASbGncszY8Cpxgfg80bxj2iVxpvxNJnfylGpJizK+5jHbwaz6WGbs7MxTzkFKCRPJ5O
	Nx6T8ou4IXP5h8ORK6AKArJz6K/6heiXlRABa0w4BmAl7QeD4mcpV6JwHG7Reb5iSqec0c/DggF
	OyV2eM1hnpS2lb10SXVaC8W5BWUlTI8hkAN1w8xXrQsn4WRKwlUDgVLgGJr9++2sfXP+cAB0COZ
	gSHPVrmCR6hFXG1rIWBac5tMKvwfPSvK9koykZwjXcxzUSZxfaOY1d5pRj5XynbD5aEf6z6U5bX
	LSle+P9ak9tf4hrVlsuFxEW77d9tpzmwWk+WHgVBsJyVsG0vsNWePGduauDIl5vZX2RVnCL8573
	2kzr2UemPB10Q+Tfrj9QOitFQ5m7eFg==
X-Received: by 2002:a05:6a00:3cc2:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73bd0e8f5b1mr2013843b3a.0.1744351333331;
        Thu, 10 Apr 2025 23:02:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEGAW7IWT4c0PXDvp6hA/y1UH04YsR2/mzX9OciQ15+3OnUM35y+XJiKJ88EZCQMq9QdHob2w==
X-Received: by 2002:a05:6a00:3cc2:b0:736:bfc4:ef2c with SMTP id d2e1a72fcca58-73bd0e8f5b1mr2013770b3a.0.1744351332618;
        Thu, 10 Apr 2025 23:02:12 -0700 (PDT)
Received: from hu-ppranees-blr.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73bd2328435sm624567b3a.157.2025.04.10.23.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:02:12 -0700 (PDT)
From: P Praneesh <praneesh.p@oss.qualcomm.com>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH ath-next v3 0/4] wifi: ath12k: Fix multicast memory leak in tx path
Date: Fri, 11 Apr 2025 11:31:50 +0530
Message-Id: <20250411060154.1388159-1-praneesh.p@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: b6jTdMUL3Nzpx4DEF-gvcBj2GAN6bOBv
X-Proofpoint-GUID: b6jTdMUL3Nzpx4DEF-gvcBj2GAN6bOBv
X-Authority-Analysis: v=2.4 cv=NaLm13D4 c=1 sm=1 tr=0 ts=67f8b066 cx=c_pps a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17 a=XR8D0OoHHMoA:10 a=18hAiPG3HQP0OPlRAisA:9 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_01,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=1 bulkscore=1 mlxlogscore=598 clxscore=1015 phishscore=0
 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504110042

Address the memory leak caused by extended skb allocation observed during
multicast transmission in this series.

---
v3:
	- Rebased on top of TOT.
v2:
	- Rebased on top of TOT.
---
P Praneesh (4):
  wifi: ath12k: Handle error cases during extended skb allocation
  wifi: ath12k: Refactor tx descriptor handling in tx completion handler
  wifi: ath12k: Fix memory leak during extended skb allocation
  wifi: ath12k: Use skb->len for dma_unmap_single() length parameter

 drivers/net/wireless/ath/ath12k/dp.c    | 10 ++-
 drivers/net/wireless/ath/ath12k/dp.h    |  7 ++
 drivers/net/wireless/ath/ath12k/dp_tx.c | 87 ++++++++++++++-----------
 3 files changed, 64 insertions(+), 40 deletions(-)


base-commit: 1a7000fb8348e04ab486513d6ebd4b6074a94be2
prerequisite-patch-id: f2cd6035cd8769da70721efd8354cf8131edc926
prerequisite-patch-id: 08db299a9f0375f556005283219456e1725bc37f
prerequisite-patch-id: 15f3b1e458a979254c34be57e7449bbc05febd7f
prerequisite-patch-id: 8cf261ae105d066b527e467ffe24b4372cff0b3c
prerequisite-patch-id: adbcbd1770169e05e4d69c7ad86ff644b22f2c54
prerequisite-patch-id: 43e5c01088694110a0e528ee709d5d2ae2492f99
prerequisite-patch-id: cbabcace5dfce8d0f72e9c4061c0b9d43178ba81
prerequisite-patch-id: b21a6dec4281f6bcf49681b9add2ea41de849dd1
-- 
2.34.1


