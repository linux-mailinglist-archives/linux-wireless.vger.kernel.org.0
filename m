Return-Path: <linux-wireless+bounces-14452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F36369ADDF9
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FCC91F22886
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 07:42:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F7811AF0B5;
	Thu, 24 Oct 2024 07:42:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="X+RN8FkU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2292A1A76B0;
	Thu, 24 Oct 2024 07:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729755741; cv=none; b=Q84Dh3q6jMvEvjQOo3buiJGvnOLHCb0Uq/aZPiWE1FtJ/S3sbN/AXmp0Sq0KCPota6hjQjJyC40xmtXBKBSknxtwnxRRJ/o+hkxov42ktoUup2wSy8oSc2ame2nKYR9U6qGA4yJl7D9zTNSU6+lL0gzY6ZanjgIxam7aqZq1k+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729755741; c=relaxed/simple;
	bh=YrpthfNQ+GbzT8ZULqGupYFXckIUsqgDSEk29sp/mao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lx7n5gF7+rbUztxqCFoL13g8Q1gFmavg3XRo/x6dgq63jPB+/yy+xFrZW+JD9Z88Ul86lw3WF03qZz9oK7DxhmPFwwA4mJKWaoXhT1P/3d74Gby3I4ifqbrkEwmrAWwyxunCs+9PiD1MEh3Hlv3D4oFhsjijFSxGThhmxXnRguA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=X+RN8FkU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49NMbpgf025445;
	Thu, 24 Oct 2024 07:42:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	nveTTtWi/IOzGp+i8IafJAXKLu4PpCQzTMgEOopL/30=; b=X+RN8FkUHpLQko0t
	K/ecCC6NfK4iODQU0biXIvB46WxvEucMx2Ql7rryBww5neDGpGZfF/FzUxfWHEZh
	U5u1XHMFG4wi1NT/Bg7uXa+xk2SEuiosijhtoHCnawJduUKzNnIsIR+roM7h4FBw
	I4fNkMP/sQNR1O0bvXi58UoRHYTK+RTDZZ9lngJrcPQZcRmKDVs749UcCctsd7BX
	SiaWBbP3QP5jzd8AMdqT82KmDdBuXbCQQifj8PKx4bSZ/AvfD9HkbWM0M9Qa2L+H
	CR/o9NQx+uq0LAr0RK8JN+zq8B7ffjCYwc1vJBBhK93E8O+Ei8wRS0a1Kjom1lFh
	wS3Hvw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em40cwtd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 07:42:09 +0000 (GMT)
Received: from nalasex01c.na.qualcomm.com (nalasex01c.na.qualcomm.com [10.47.97.35])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49O7g8Bp018415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Oct 2024 07:42:08 GMT
Received: from Z2-SFF-G9-MQ.ap.qualcomm.com (10.80.80.8) by
 nalasex01c.na.qualcomm.com (10.47.97.35) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 00:42:05 -0700
From: Miaoqing Pan <quic_miaoqing@quicinc.com>
To: <kvalo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
CC: <quic_jjohnson@quicinc.com>, <ath11k@lists.infradead.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <dmitry.baryshkov@linaro.org>, <krzk@kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Miaoqing Pan
	<quic_miaoqing@quicinc.com>
Subject: [RESEND PATCH v2 1/2] dt-bindings: net: wireless: ath11k-pci: add firmware-name property
Date: Thu, 24 Oct 2024 15:41:43 +0800
Message-ID: <20241024074144.179868-2-quic_miaoqing@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241024074144.179868-1-quic_miaoqing@quicinc.com>
References: <20241024074144.179868-1-quic_miaoqing@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PhWEx4wJOuiEZ0BK7K3k6XZEq7PaynHb
X-Proofpoint-GUID: PhWEx4wJOuiEZ0BK7K3k6XZEq7PaynHb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 impostorscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 lowpriorityscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410240059

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


