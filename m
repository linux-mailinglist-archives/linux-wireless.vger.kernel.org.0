Return-Path: <linux-wireless+bounces-23260-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 346BEAC01BE
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 03:35:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDC3616653F
	for <lists+linux-wireless@lfdr.de>; Thu, 22 May 2025 01:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1D92CCA5;
	Thu, 22 May 2025 01:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CB3Weyw+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CBD414A82
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747877710; cv=none; b=QLWvBxzCrIgDsNBqpzIu71J0Za7tWoYfcS2Oyi13en1qiH1TUhEO+f0GIHyhplkBjMK6jpncKqTiM2HK5mEyLWx6rfMI6VKihxJI7pp4jZDoisVPCPZguLJ/0xF2r8VQHz4t54q0LrJrimUXKt6w8aNFA7XiGp+DUJJ6/aGLCcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747877710; c=relaxed/simple;
	bh=cMCnnc7X/yklxiDU9hwwsSkevTU+xRlusst0496/U3c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=i1dqmV/OqomCeYMj0X0vAxDxZ5GjWay9afdFcutkidT/uHCxSGc28Eyr0iicHbb6S5N+Qd0GDlE+2Jj0nolaX2nJT3E3WI4X4ApxApYVBWhH5WWfkJAJbpp3I1HIckXtrIRVnoO3OLYbW+5BdEZKq8KOodRFOHlpOr0FyePROmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CB3Weyw+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54LIZCUj000836
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=qcppdkim1; bh=HPUGdKm+6wjWn2dW0R+KWWtLOsj1VrZbuMm
	juk7/Syc=; b=CB3Weyw+sfP0cfKIOVfUqmpzc/ZTtNMuemRT6UZvoDlbzr32mPa
	4hGOXCLAXS/fs721n19jgwFt3fjQW356eddsJrv/y4C6OPL0WX7gWUV0XwDcZ/6k
	jkmn/OlecZ/37kf8RioM+8m2q6rNX6iA6wrGc4ZkTDZ3gF6vktcPdFg46gkgZQke
	6qm7eX74b/04Mf2aUlY95msGMdlu/14pcVQPfsQ2+Q11okR48x4bAFu9bx6kHiug
	jJp+vZoCePMCcAvcdkVJ/05hSF8FP22YEGTsTJXM8ygOi703owddk8FiVbzi6ftq
	UDi8jB/+QOZb3nDSl0O42e6APTkholRsi0g==
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 46rwf6vm83-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-wireless@vger.kernel.org>; Thu, 22 May 2025 01:35:06 +0000 (GMT)
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-30e6980471cso5968116a91.1
        for <linux-wireless@vger.kernel.org>; Wed, 21 May 2025 18:35:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747877705; x=1748482505;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HPUGdKm+6wjWn2dW0R+KWWtLOsj1VrZbuMmjuk7/Syc=;
        b=xR5pZwJ3b1XvP9YYekVwZiaTCSK30S/qRGfnKF0BXHBPOBLchob9NyktlPvOF0kAdJ
         rb7at9qoJpYDsQXD8eqTxn1U2lQRBOVTaPDGkKdXaouduyxoXkBO8LFwaOqMSb1+rj8Z
         mc3Q3BhVkBVMlB/Y0PczrufVYCpGgGyp52+KIkO2zogNSGmJQLeXAq1SpZXAXdoJwQcN
         TZwq+/pTKYaHlK0JrzjtevbLRoSKRQkGPYfrHIxm2O0LGPKbVa/YaxFtJLYd0W5RPNzE
         N3GgcD/CaiLbJx+rTZOsxwNH+FMOLrci5UGPbnFWBHw2fhTWL0G7hT8qsVTFQI8VEHb5
         fw9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVevoLsgiyPRMPwIVsSzL1jBnphn42pCb3OkdtQjcgHJXT0WtJGXPJah0Jxf+GHwJ2iPIDDl99VMVIeiuVjzw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2F1wxaojLuKlB0wL6mhvXhJEdGN9PD97vsbTghop2cyBG4AVi
	GKbDedBkilB0VfZ1wffxec12O3tpZtBeRnu4y/EX8tdhXS4auHb4Rzh+nzU8fRzVU8qlQpnaZ/Z
	kx5tdeywK1y/O4qFvXhDrB2OwMtTiVql2Hy4PEzLln40R+vMTY1Hf/lh/VuFNINGLSZwv0w==
X-Gm-Gg: ASbGnctjmMMw8QN2y8JfV1Ql8aQYV8Jd6lV73T+0IgxIInLXRuXqjfFTt8fV8QMrg3j
	lNzBlAQTixI4PQ9JkMLYKJoVWlgwF0r7XCdMnBosOBiemX4VhezhMss1JfNL9mamt/5N0ww7gf+
	kSLyyycjwY/l02GNBPVAWjIX9SXO2mz7xxMl24QD5MCPDgmzuHJs6fyn5Tol3d4TmhF4j4VJHF9
	KCHX9sSt14sGNAawans60CxMt+jslArRgYMcHMj0N+J1uAUkdHWFuZ4gJua/bI1VyZJZox88W4Z
	kLwSFYKNeJ1dygaIRB94sTFutcymZad2DYuIdkJXFZeflyrwJewJsjsgbcfxtNIyzH79L+Y=
X-Received: by 2002:a17:90b:5750:b0:30e:3737:7c71 with SMTP id 98e67ed59e1d1-30e7d57e4e6mr33408568a91.20.1747877705472;
        Wed, 21 May 2025 18:35:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3oA7UpKoPxzuimQInRPDM0fZl6JIUILi/4VKjHEG11sIfyclQQp1d2zav0ocl3qvvA5YdVg==
X-Received: by 2002:a17:90b:5750:b0:30e:3737:7c71 with SMTP id 98e67ed59e1d1-30e7d57e4e6mr33408543a91.20.1747877705134;
        Wed, 21 May 2025 18:35:05 -0700 (PDT)
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365d45b2sm4341488a91.26.2025.05.21.18.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 18:35:04 -0700 (PDT)
From: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
To: jjohnson@kernel.org, johannes@sipsolutions.net, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>
Subject: [PATCH ath-next 0/2] wifi: ath11k: support usercase-specific firmware overrides
Date: Thu, 22 May 2025 09:34:42 +0800
Message-Id: <20250522013444.1301330-1-miaoqing.pan@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: L155pyCsoYtD9rhVtjoexrIVqlAspfi5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTIyMDAxMyBTYWx0ZWRfX5NYYnQ+E0ORu
 URV5YYmny8AwJGiWhhuwgSUQxu6c0XTVKnsLwiUPm1rmnn4SsOiGaY4CMeX70+103Voq9lt4th7
 xOTBeDxaUzMLXd8elaqbMz/ZM/+j/lsEjmB8LED7RgTaiQJfy2Oqte3+1R53NyrYOjzgNVAbnHp
 2W1KFMaiZ2wKmHCIyBI4KDD0RkZ4LLJQxtH7KjetNbDYGLNnX0UQJedlJSOk6DiIR49bYbyPA9k
 9JLWLs9pEOE/7Mm4CSjhDa+JJAIkM1sh6vDYrS47Y4cWQaD9DTL0wAzTxmTS9MXS2nMnAISk5ui
 +5zixjbS9LiYLLXeV80hk+6KvTLYAXcSpD4FTevfzbJMFTodV+9nSmE97yyFlCGHrCMKzaLcJLu
 lJoiY+Ps/qHsyKBoQSFOP2n8G2WMSWcycEZBuoEEQ73MN30l5CDChLYB3Cu8SgGvOIqG3YUZ
X-Authority-Analysis: v=2.4 cv=fZOty1QF c=1 sm=1 tr=0 ts=682e7f4a cx=c_pps
 a=RP+M6JBNLl+fLTcSJhASfg==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=dt9VzEwgFbYA:10 a=EUspDBNiAAAA:8 a=5mkN5bLxXfCjVL2fFVgA:9
 a=iS9zxrgQBfv6-_F4QbHw:22
X-Proofpoint-ORIG-GUID: L155pyCsoYtD9rhVtjoexrIVqlAspfi5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-22_01,2025-05-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 priorityscore=1501 impostorscore=0 mlxlogscore=991
 lowpriorityscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505160000 definitions=main-2505220013

Introduce 'firmware-name' property to allow end-users and/or integrators to
decide which usecase-specific firmware to run on the WCN6855.

Signed-off-by: Miaoqing Pan <miaoqing.pan@oss.qualcomm.com>

Miaoqing Pan (2):
  dt-bindings: net: wireless: ath11k-pci: describe firmware-name
    property
  wifi: ath11k: support usercase-specific firmware overrides

 .../bindings/net/wireless/qcom,ath11k-pci.yaml      |  6 ++++++
 drivers/net/wireless/ath/ath11k/core.h              | 13 +++++++++++--
 2 files changed, 17 insertions(+), 2 deletions(-)


base-commit: db5a2f8ef8d4be926d29ed62182d003110c1a6ca
-- 
2.34.1


