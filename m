Return-Path: <linux-wireless+bounces-18192-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 387EEA2286F
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 06:19:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 834F118872C0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 05:20:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 379851865F0;
	Thu, 30 Jan 2025 05:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="lzaSlCz1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 891F62CAB;
	Thu, 30 Jan 2025 05:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738214383; cv=none; b=BCWJzwf2PTMWvmdxd/JgtMaRzCB2gQIt7R4SnaOaE/wamuMWQovJ61FgjrfDFTGJ89Gygh5K7/gTnICAw3t9FcNQB5ZrwCIPXuRt8UheDKN8NQkL2xEj2HjXazjP6NBSkyyxtZaNbsyMAgaR9yxLPJcBO5J2kpAQpZr4TGzCLwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738214383; c=relaxed/simple;
	bh=nNXeh8EgRRO+YztzUIy6w3vdAbBwseqASSEBNuWjYYk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNTzCxtH+qyY1PzB0MzcbriRVyPSOiy05cQ8vHUVgEC48svcasmdS2xm0DjK5W1xdnwpGrFXfLT22H6ODYSJF85SyJBwvYqYmM/m24cqdZ3PI19mtAde7sZOAziodHNoYnA5CWjN+h76wNBmfBp0b8gaXet3kgQOd4clBlkOQIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=lzaSlCz1; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TMki2X012279;
	Thu, 30 Jan 2025 05:19:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	dUezyGs2RdjGHsOnD/58OC7wQng7WD1B+BzO1yxfB0E=; b=lzaSlCz1BYbxJRn/
	4PyeP6AM/MC7vzW+HvvqROHGGYNGuum+/JA1jmanIhCTB/HA1fWF76jjNOEaCVbr
	ZDlAv8GPUBotplUBB0l2GVH9heTplxIhf3hvDDG+CfJvYRfOlhE5B37lTPP7sQbG
	nnN0UH+ziRECwmqsaNJ/XibHPDaZq/sJC/5bMZVK6qUXIpIbANMF8g9Dhkzvq0iz
	jc9j746oSipsr0FiHv3hePRAD8WToTHeBhNwyAVdvg114GU7Ky0nrG/DSGatdqkb
	u8tC46UNQuv+uRcx9qJ3LY8lzTnjTEq2jDsvtvZWuz+3Ogha2d2HQG3u/ViqucCZ
	W3lYkw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 44fwe28jn1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:36 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 50U5JZxh019373
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 30 Jan 2025 05:19:35 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 29 Jan 2025 21:19:31 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@kernel.org>,
        "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        Jeff Johnson <jjohnson@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Raj Kumar
 Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [RFC PATCH 1/5] dt-bindings: net: wireless: describe the ath12k wifi device IPQ5424
Date: Thu, 30 Jan 2025 10:48:34 +0530
Message-ID: <20250130051838.1924079-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
References: <20250130051838.1924079-1-quic_rajkbhag@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: kGZxBXSwX__DbgiYGtOfsRZH4Kz86cmH
X-Proofpoint-GUID: kGZxBXSwX__DbgiYGtOfsRZH4Kz86cmH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 adultscore=0 phishscore=0 mlxlogscore=999
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501300039

Describe and add the device-tree bindings for the ATH12K AHB wifi device
IPQ5424.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 .../net/wireless/qcom,ath12k-ahb.yaml         | 119 ++++++++++++++++++
 1 file changed, 119 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
index bd953a028dc3..1d24389a0ab3 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-ahb.yaml
@@ -18,6 +18,7 @@ properties:
   compatible:
     enum:
       - qcom,ipq5332-wifi
+      - qcom,ipq5424-wifi
 
   reg:
     maxItems: 1
@@ -317,3 +318,121 @@ examples:
                                 "stop",
                                 "spawn";
     };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    wifi1: wifi@c000000 {
+        compatible = "qcom,ipq5424-wifi";
+        reg = <0x0c000000 0x1000000>;
+        clocks = <&gcc GCC_XO_CLK_SRC>;
+        clock-names = "xo";
+        interrupts-extended = <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 11 IRQ_TYPE_NONE>,
+                              <&intc GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 518 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 519 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 520 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 521 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 522 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 523 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 524 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 525 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 526 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 527 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 528 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 529 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 574 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 578 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 576 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 627 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 540 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 580 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 537 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 536 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 535 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 534 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 571 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 567 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 637 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 637 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 632 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 590 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 583 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 582 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 581 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 533 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 532 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 531 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 530 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 626 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 569 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 565 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 502 IRQ_TYPE_EDGE_RISING>;
+        interrupt-names = "fatal",
+                          "ready",
+                          "spawn",
+                          "stop-ack",
+                          "misc-pulse1",
+                          "misc-latch",
+                          "sw-exception",
+                          "ce0",
+                          "ce1",
+                          "ce2",
+                          "ce3",
+                          "ce4",
+                          "ce5",
+                          "ce6",
+                          "ce7",
+                          "ce8",
+                          "ce9",
+                          "ce10",
+                          "ce11",
+                          "host2wbm-desc-feed",
+                          "host2reo-re-injection",
+                          "host2reo-command",
+                          "host2rxdma-monitor-ring1",
+                          "reo2ost-exception",
+                          "wbm2host-rx-release",
+                          "reo2host-status",
+                          "reo2host-destination-ring4",
+                          "reo2host-destination-ring3",
+                          "reo2host-destination-ring2",
+                          "reo2host-destination-ring1",
+                          "rxdma2host-monitor-destination-mac3",
+                          "rxdma2host-monitor-destination-mac2",
+                          "rxdma2host-monitor-destination-mac1",
+                          "host2rxdma-host-buf-ring-mac3",
+                          "host2rxdma-host-buf-ring-mac2",
+                          "host2rxdma-host-buf-ring-mac1",
+                          "host2tcl-input-ring4",
+                          "host2tcl-input-ring3",
+                          "host2tcl-input-ring2",
+                          "host2tcl-input-ring1",
+                          "wbm2host-tx-completions-ring4",
+                          "wbm2host-tx-completions-ring3",
+                          "wbm2host-tx-completions-ring2",
+                          "wbm2host-tx-completions-ring1",
+                          "host2tx-monitor-ring1",
+                          "txmon2host-monitor-destination-mac3",
+                          "txmon2host-monitor-destination-mac2",
+                          "txmon2host-monitor-destination-mac1",
+                          "umac-reset";
+
+        memory-region = <&q6_region>, <&m3_dump>, <&q6_caldb>, <&mlo_mem>;
+        memory-region-names = "q6-region", "m3-dump", "q6-caldb", "mlo-global-mem";
+        qcom,ath12k-calibration-variant = "RDP466_1";
+        qcom,rproc = <&q6v5_wcss>;
+        qcom,smem-states = <&wcss_smp2p_out 8>,
+                           <&wcss_smp2p_out 9>,
+                           <&wcss_smp2p_out 10>;
+        qcom,smem-state-names = "shutdown",
+                                "stop",
+                                "spawn";
+    };
-- 
2.34.1


