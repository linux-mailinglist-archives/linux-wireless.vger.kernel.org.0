Return-Path: <linux-wireless+bounces-14518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DCAC9AFF77
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 12:05:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 04CB01F216F1
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 10:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAF81DBB24;
	Fri, 25 Oct 2024 10:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UEH+5mR7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB8201D9A6D;
	Fri, 25 Oct 2024 10:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850683; cv=none; b=H22cNMHDAhaevReAKJ5e6FLB0STCjbu86kGfrLbwxsA2aWUy9VC1YzBpiRjRgTFPVznc/xAvMrNWwRk3dm+hjgI+4jjFvgr2l8AwfrsOOXuctIplngjevHEoI5841jaSVmPfAM2Q5w9M8Qm9RfwpXfbRKmWgRhwbSuQOShhGOco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850683; c=relaxed/simple;
	bh=YrpthfNQ+GbzT8ZULqGupYFXckIUsqgDSEk29sp/mao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FbA0LCR6lfb8av2UhylgyZt8/45f59PZX3JLRODJV8i8H/eOCovv3O52heZtJH/2hcCMnNx21Eb+g4hEOSwunIki+kOqHCHDr/k/K236JtXhrFPTkFD/4iKP22Y8FiOO3TXz2xpAPkKPttseag8FqNVswj03Ge67leF6C6wLIyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UEH+5mR7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P62C3u011403;
	Fri, 25 Oct 2024 10:04:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nveTTtWi/IOzGp+i8IafJAXKLu4PpCQzTMgEOopL/30=; b=UEH+5mR7T0+rTVKu
	RZaEon3O3ti4JkWjQsShlJKEQpLJhh2yhycJ6otc+2TGL39rLUqhk5RXFYQzNMaY
	aRR0Y72ZDlFgBDHVExnmz1OD91vAgo/ggXd6bkrThrbqW05DJhynFEn3CC5TZ6eV
	rhjuQM87+faZoJ2EwL+d8QBZ06SCOCuU0LE9weKKXhUMQUocTGh7nQHF4J2MvnVs
	LaO2/6j7jNsddPsvW8nz1//dZdxw/28d6ZsIN9E3DuYO1Ntnjvn5KYY927JqAixA
	BvnkzgoCZMYwobSNivSOxHRWWGhBzW1Jmo9O/Gx2iglpw9JmXpT//3+eVcSc/Srl
	wQcRrA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g5q80knh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:35 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49PA4YSZ020646
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 10:04:34 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 03:04:31 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [PATCH v3 1/2] dt-bindings: net: wireless: ath11k-pci: add firmware-name property
Date: Fri, 25 Oct 2024 18:04:18 +0800
Message-ID: <20241025100419.2128604-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
References: <20241025100419.2128604-1-quic_miaoqing@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01c.na.qualcomm.com (10.47.97.35)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 8hN0NQQieWs96edd3CvwMyQqfXV_Y3fe
X-Proofpoint-GUID: 8hN0NQQieWs96edd3CvwMyQqfXV_Y3fe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 impostorscore=0 priorityscore=1501 mlxlogscore=999 bulkscore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250077

This is the same optional property that defined in qcom,ath10k.yaml. It's
useful for the platform / board to specify firmware through device-tree.

Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
---
 .../devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml  | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
index a71fdf05bc1e..2aa81690f7d5 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k-pci.yaml
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2023 Linaro Limited
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ath11k-pci.yaml#
@@ -29,6 +30,12 @@ properties:
       string to uniquely identify variant of the calibration data for designs
       with colliding bus and device ids
 
+  firmware-name:
+    maxItems: 1
+    description:
+      If present, a board or platform specific string used to lookup firmware
+      files for the device.
+
   vddrfacmn-supply:
     description: VDD_RFA_CMN supply regulator handle
 
-- 
2.25.1


