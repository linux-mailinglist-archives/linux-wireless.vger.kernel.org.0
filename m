Return-Path: <linux-wireless+bounces-14350-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 306769ABE48
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 08:05:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E043A284F6F
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 06:05:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D8614A4EB;
	Wed, 23 Oct 2024 06:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g2UDNZgH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 761BC14A4D4;
	Wed, 23 Oct 2024 06:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729663471; cv=none; b=Mje7Aa4EbPSxWGeeMjzYLXqW0KUFGBb+yBogdh4Uo6YkN9DdxQNpzab0aKrdsZdjq2+ZVcWuUc6v/0VNM2GUH0PYqzFIV7gyoGdoNq3RO/hxdU9yxrqNzL55kNo0RA+nn5oINFXpEmU/4eqF84DLAkRk8/tvn6teE5iMbjTWBmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729663471; c=relaxed/simple;
	bh=mq5dE1KEBgxTYwePc3oHmA2Y11gmEGWUuK9WwdyaBYc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzjbE8IIKpVisd/U+vh1HWZ/hwJtGxCwY21SamM1jUmAOK2IBXUlBPv4wrfbuHR5fxa7yf5nasqIZKT1jROBeexnxHw1cog5n4+jIPwGKpkGQ2XpCfnkvLNoV7xsJjJlv8ehPRAYGyDtWFw9QOOb8etzrPfQNBUWWne+gzP421k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g2UDNZgH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49MLaFPI016699;
	Wed, 23 Oct 2024 06:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rs3dR3lIk9LXliUg7JlV/IabmOYVvaAGYWji+hb3VLU=; b=g2UDNZgHklG8+79d
	ZDJAfilKlPk74U5KsbX/jTOuemg+e0CRxPF5rcTGgAdtksEDUfE8ZCQljTOqdAEf
	ILB9Fb0pVrHTyZ1FXeG+odZnYTdK4uLv4PwlTxTPehrilVvyt8n24QSth58PJ743
	POa7bMcLIQMAgG4Q3ZCAh/+U/MIvy1TsZSkulXo/Cee0OGbP49gdTIh+bhF6Vqxk
	rMJ7Kood6sFbD1BqyFzkFMVZUEGpqKGcMLKJ2atRHL9HY2by6g01fUdDodW9YLUU
	6h1by5RUKsGSmbvWdbiSjqUjJY0czprumYMB60/nuEpiTbPpvkVzBAxxrBx6dAeK
	JeMDgA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42em3xh115-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:26 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49N64Phl019400
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Oct 2024 06:04:25 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 22 Oct 2024 23:04:21 -0700
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
Subject: [RFC PATCH 2/6] dt-bindings: net: wireless: ath12k: describe WSI property for QCN9274
Date: Wed, 23 Oct 2024 11:33:48 +0530
Message-ID: <20241023060352.605019-3-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-GUID: QUhtInOjT1dhVnFOagTK6imMalmgsB9W
X-Proofpoint-ORIG-GUID: QUhtInOjT1dhVnFOagTK6imMalmgsB9W
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 impostorscore=0 mlxscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 mlxlogscore=999 malwarescore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410230034

QCN9274 device has WSI support. WSI stands for WLAN Serial Interface.
It is used for the exchange of specific control information across
radios based on the doorbell mechanism. This WSI connection is
essential to exchange control information among these devices

Hence, describe WSI interface supported in QCN9274 with the following
properties:

 - qcom,wsi-group-id: It represents the identifier assigned to the WSI
   connection. All the ath12k devices connected to same WSI connection
   have the same wsi-group-id.

 - qcom,wsi-index: It represents the identifier assigned to ath12k
   device in the order of the WSI connection.

 - qcom,wsi-num-devices: Number of devices connected through WSI in
   the same group ID.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 .../bindings/net/wireless/qcom,ath12k.yaml    | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
index ecf38af747f7..6c8f97865075 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k.yaml
@@ -19,6 +19,7 @@ properties:
   compatible:
     enum:
       - pci17cb,1107  # WCN7850
+      - pci17cb,1109  # QCN9274
 
   reg:
     maxItems: 1
@@ -50,6 +51,41 @@ properties:
   vddpcie1p8-supply:
     description: VDD_PCIE_1P8 supply regulator handle
 
+  wsi:
+    type: object
+    description:
+      The ath12k devices (QCN9274) feature WSI support. WSI stands for
+      WLAN Serial Interface. It is used for the exchange of specific
+      control information across radios based on the doorbell mechanism.
+      This WSI connection is essential to exchange control information
+      among these devices.
+
+    properties:
+      qcom,wsi-group-id:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          It represents the identifier assigned to the WSI connection. All
+          the ath12k devices connected to same WSI connection have the
+          same wsi-group-id.
+
+      qcom,wsi-index:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          It represents the identifier assigned to ath12k device in the
+          order of the WSI connection.
+
+      qcom,wsi-num-devices:
+        $ref: /schemas/types.yaml#/definitions/uint32
+        description:
+          Number of devices connected through WSI in the same group ID.
+
+    required:
+      - qcom,wsi-group-id
+      - qcom,wsi-index
+      - qcom,wsi-num-devices
+
+    additionalProperties: false
+
 required:
   - compatible
   - reg
@@ -108,3 +144,28 @@ examples:
             };
         };
     };
+
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            wifi@0 {
+                compatible = "pci17cb,1109";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+
+                wsi {
+                    qcom,wsi-group-id = <0>;
+                    qcom,wsi-index = <0>;
+                    qcom,wsi-num-devices = <3>;
+                };
+            };
+        };
+    };
-- 
2.34.1


