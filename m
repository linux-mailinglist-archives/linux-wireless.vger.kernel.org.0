Return-Path: <linux-wireless+bounces-14349-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 548AA9ABE44
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:04:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33421F24A27
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:04:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB3A1474A5;
	Wed, 23 Oct 2024 06:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Sdf5ntYS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EBD12FB34;
	Wed, 23 Oct 2024 06:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663467; cv=none; b=YIM91Dm3vD31j02Ay9rJ5lx625SmdiwiCoZ0UuYly0J0ixFHduj2y7uOT57JteCSfmyR+Ip+5yMKQPENZCSge9MOEBEBmCKlOxHB4ozMZfg4Cjq1wLfTTo4JLH8YrSDhTaSrIj4najcs7pNQNPWjXFiQxAuSnX664TIfMIEgDk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663467; c=relaxed/simple;
	bh=5l2IOBgMWufvMK45Va72JDgbBqy2UirqJFylGwY7jV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8C1wX+vuu9y7M4OHVDa1hDRnlQzsKEiai5nypX7Ltn+sjtVZBtHotv9cDZ7rjQ+7UW2dzqOxRWu0yO+jB4sa4DvPwGZngLWfEvrtMr8+jGqvJ5n2Nd2zLWP9QeUU8F4tSz94+h+cuTYPGoeo3FlByu1YaO8leZke1oLAuWmTKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Sdf5ntYS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLa5Wd024348;
	Wed, 23 Oct 2024 06:04:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2MlZa3dNLdwiSMgj2PMGkDGf7M38y7kDPQ5kmRSQk30=; b=Sdf5ntYSqxX9G/2S
	cx6AtERC/AH16QXh1GeZNeGuxP4IsZRUYPNTrjt9uCUT9nbOULvG844tK84GWws6
	gVqoIGF0iiJUnbcUYexBqIOWRMYQH7CCzykSCuBdt5zYnBVjzHty+pbS4mUrTmDU
	S9CNugGGKwkFxEmBsVxRlisWO8+6RrwpGzcxcDJOAp0smG93x+M+XKnYlL5JyvL+
	2YKp2sBPP9uBwwpIr0hbtMzm6GYIBA8HStkwjr0z01JmGa6jT1SDg279CjnGlj27
	zFfur7jnIxE/63xQ7pKFRP/l0ATktltC5X36GwqIrTEms8v8AJ0yXmq1flrpQuNM
	9gmFTA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3uh115-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:22 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N64LRh008447
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:21 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:04:17 -0700
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Bjorn
 Andersson" <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 1/6] dt-bindings: net: wireless: update required properties for ath12k PCI module
Date: Wed, 23 Oct 2024 11:33:47 +0530
Message-ID: <20241023060352.605019-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
References: <20241023060352.605019-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5RMuoJIn9Nf3-Qb7y-NA-waFCgEbFqGz
X-Proofpoint-ORIG-GUID: 5RMuoJIn9Nf3-Qb7y-NA-waFCgEbFqGz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=840
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230035

The current device-tree bindings for the Ath12K module list many
WCN7850-specific properties as required. However, these properties are
not applicable to other Ath12K devices.

Hence, remove WCN7850-specific properties from the required section,
retaining only generic properties valid across all Ath12K devices.
WCN7850-specific properties will remain required based on the device's
compatible enum.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 .../bindings/net/wireless/qcom,ath12k.yaml    | 29 +++++++++++++------
 1 file changed, 20 insertions(+), 9 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index 1b5884015b15..ecf38af747f7 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 # Copyright (c) 2024 Linaro Limited
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
 %YAML 1.2
 ---
 $id: http://devicetree.org/schemas/net/wireless/qcom,ath12k.yaml#
@@ -52,18 +53,28 @@ properties:
 required:
   - compatible
   - reg
-  - vddaon-supply
-  - vddwlcx-supply
-  - vddwlmx-supply
-  - vddrfacmn-supply
-  - vddrfa0p8-supply
-  - vddrfa1p2-supply
-  - vddrfa1p8-supply
-  - vddpcie0p9-supply
-  - vddpcie1p8-supply
 
 additionalProperties: false
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - pci17cb,1107
+    then:
+      required:
+        - vddaon-supply
+        - vddwlcx-supply
+        - vddwlmx-supply
+        - vddrfacmn-supply
+        - vddrfa0p8-supply
+        - vddrfa1p2-supply
+        - vddrfa1p8-supply
+        - vddpcie0p9-supply
+        - vddpcie1p8-supply
+
 examples:
   - |
     #include <dt-bindings/clock/qcom,rpmh.h>
-- 
2.34.1


