Return-Path: <linux-wireless+bounces-19551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A359A48891
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 20:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67839167C75
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Feb 2025 19:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A25D26E653;
	Thu, 27 Feb 2025 19:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VxhI6ffH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7068226E646;
	Thu, 27 Feb 2025 19:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740683474; cv=none; b=mQ+ysk91/H7h9EYQfhKjZyu+9DZjEoTgpAXKDhoCOnV+4qzamHM5u8DsrlWqywvr9YO/u6pD/lMfsJcJvXoK46uV6teAe9H8DOJhzEXeNVKqZQ14X1ARkeOnEhUT1MC9Tx/boyj6WCzNb3M5U2IBmFBrFl7X6PnRkdoUQN5KPwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740683474; c=relaxed/simple;
	bh=ZZucndeGz8YJlP3QnwusiguLeB8CG46PIEH+M9GUr7A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lCWatTM97m7E0A6s5D0Q5rtOlW+/XWsrN+codVnlewUGlkynorj1Jy0I01WkjDORHUplICd4b/P7Mc0qqoxy1Ua+isrNtepkpGOlP2nR7sw8MypdRc5tgik7K5762Ltl+triZoSqrqSPiEMcQNTCYMI7qLR9/Nk6aXx0WBs9EyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VxhI6ffH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51R9kxuF017243;
	Thu, 27 Feb 2025 19:11:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	cJgfEAZ3jW3p0K1jHwxSepGimzOkXwxoLsGWzktTgfM=; b=VxhI6ffHXOJj+y5U
	QG8qWRfn0gIraRVWDZBYUpUm0JxRhHOR5UoyQgpBaQrAZR4A8il+xCC4QafH8Evl
	MqzFT/SdbFOrIp98VQrhmrBm2jaBZZucjCkxxjTIWXCoQZHdCPey7Q3pez0nAWXf
	qvimi3if8RGdkN69kUqLfEO2spBRjC/Wy9rLKuutsEtj/0e+ORNscRsoNWAY9uuE
	rfzds8p5kI8NG4EHMYNZflpVunyb8NpzxSxatu3WU8SYOzeMxAzTt9aUODB3rpJy
	zewbrGMJwnOdAHUP/oWMbsTYIFB3yHHOBDKz0Bzy9oXm8bq2NLHBv1SnCqcTQNT2
	mwsOWA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 452nqkhmu3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:03 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 51RJB2MG006003
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Feb 2025 19:11:02 GMT
Received: from hu-rajkbhag-blr.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 27 Feb 2025 11:10:59 -0800
From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
To: <ath12k@lists.infradead.org>
CC: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Raj Kumar
 Bhagat" <quic_rajkbhag@quicinc.com>
Subject: [PATCH v7 01/13] dt-bindings: net: wireless: describe the ath12k AHB module for IPQ5332
Date: Fri, 28 Feb 2025 00:40:22 +0530
Message-ID: <20250227191034.1949954-2-quic_rajkbhag@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
References: <20250227191034.1949954-1-quic_rajkbhag@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 90-EVRTEPrJW6EfZbPDoL1YMXnvLW3EG
X-Proofpoint-GUID: 90-EVRTEPrJW6EfZbPDoL1YMXnvLW3EG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-27_07,2025-02-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 adultscore=0 phishscore=0 bulkscore=0 clxscore=1015
 mlxlogscore=999 suspectscore=0 spamscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502270142

Add device-tree bindings for the ATH12K module found in the IPQ5332
device.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
---
 .../net/wireless/qcom,ipq5332-wifi.yaml       | 315 ++++++++++++++++++
 1 file changed, 315 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
new file mode 100644
index 000000000000..363a0ecb6ad9
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ipq5332-wifi.yaml
@@ -0,0 +1,315 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ipq5332-wifi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (AHB)
+
+maintainers:
+  - Jeff Johnson <jjohnson@kernel.org>
+
+description:
+  Qualcomm Technologies IEEE 802.11be AHB devices.
+
+properties:
+  compatible:
+    enum:
+      - qcom,ipq5332-wifi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: XO clock used for copy engine
+
+  clock-names:
+    items:
+      - const: xo
+
+  interrupts:
+    items:
+      - description: Fatal interrupt
+      - description: Ready interrupt
+      - description: Spawn acknowledge interrupt
+      - description: Stop acknowledge interrupt
+      - description: misc-pulse1 interrupt events
+      - description: misc-latch interrupt events
+      - description: sw exception interrupt events
+      - description: interrupt event for ring CE0
+      - description: interrupt event for ring CE1
+      - description: interrupt event for ring CE2
+      - description: interrupt event for ring CE3
+      - description: interrupt event for ring CE4
+      - description: interrupt event for ring CE5
+      - description: interrupt event for ring CE6
+      - description: interrupt event for ring CE7
+      - description: interrupt event for ring CE8
+      - description: interrupt event for ring CE9
+      - description: interrupt event for ring CE10
+      - description: interrupt event for ring CE11
+      - description: interrupt event for ring host2wbm-desc-feed
+      - description: interrupt event for ring host2reo-re-injection
+      - description: interrupt event for ring host2reo-command
+      - description: interrupt event for ring host2rxdma-monitor-ring1
+      - description: interrupt event for ring reo2ost-exception
+      - description: interrupt event for ring wbm2host-rx-release
+      - description: interrupt event for ring reo2host-status
+      - description: interrupt event for ring reo2host-destination-ring4
+      - description: interrupt event for ring reo2host-destination-ring3
+      - description: interrupt event for ring reo2host-destination-ring2
+      - description: interrupt event for ring reo2host-destination-ring1
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac3
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac2
+      - description: interrupt event for ring rxdma2host-monitor-destination-mac1
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac3
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac2
+      - description: interrupt event for ring host2rxdma-host-buf-ring-mac1
+      - description: interrupt event for ring host2tcl-input-ring4
+      - description: interrupt event for ring host2tcl-input-ring3
+      - description: interrupt event for ring host2tcl-input-ring2
+      - description: interrupt event for ring host2tcl-input-ring1
+      - description: interrupt event for ring wbm2host-tx-completions-ring4
+      - description: interrupt event for ring wbm2host-tx-completions-ring3
+      - description: interrupt event for ring wbm2host-tx-completions-ring2
+      - description: interrupt event for ring wbm2host-tx-completions-ring1
+      - description: interrupt event for ring host2tx-monitor-ring1
+      - description: interrupt event for ring txmon2host-monitor-destination-mac3
+      - description: interrupt event for ring txmon2host-monitor-destination-mac2
+      - description: interrupt event for ring txmon2host-monitor-destination-mac1
+      - description: interrupt event for umac-reset
+
+  interrupt-names:
+    items:
+      - const: fatal
+      - const: ready
+      - const: spawn
+      - const: stop-ack
+      - const: misc-pulse1
+      - const: misc-latch
+      - const: sw-exception
+      - const: ce0
+      - const: ce1
+      - const: ce2
+      - const: ce3
+      - const: ce4
+      - const: ce5
+      - const: ce6
+      - const: ce7
+      - const: ce8
+      - const: ce9
+      - const: ce10
+      - const: ce11
+      - const: host2wbm-desc-feed
+      - const: host2reo-re-injection
+      - const: host2reo-command
+      - const: host2rxdma-monitor-ring1
+      - const: reo2ost-exception
+      - const: wbm2host-rx-release
+      - const: reo2host-status
+      - const: reo2host-destination-ring4
+      - const: reo2host-destination-ring3
+      - const: reo2host-destination-ring2
+      - const: reo2host-destination-ring1
+      - const: rxdma2host-monitor-destination-mac3
+      - const: rxdma2host-monitor-destination-mac2
+      - const: rxdma2host-monitor-destination-mac1
+      - const: host2rxdma-host-buf-ring-mac3
+      - const: host2rxdma-host-buf-ring-mac2
+      - const: host2rxdma-host-buf-ring-mac1
+      - const: host2tcl-input-ring4
+      - const: host2tcl-input-ring3
+      - const: host2tcl-input-ring2
+      - const: host2tcl-input-ring1
+      - const: wbm2host-tx-completions-ring4
+      - const: wbm2host-tx-completions-ring3
+      - const: wbm2host-tx-completions-ring2
+      - const: wbm2host-tx-completions-ring1
+      - const: host2tx-monitor-ring1
+      - const: txmon2host-monitor-destination-mac3
+      - const: txmon2host-monitor-destination-mac2
+      - const: txmon2host-monitor-destination-mac1
+      - const: umac-reset
+
+  memory-region:
+    description:
+      Memory regions used by the ath12k firmware.
+    items:
+      - description: Q6 memory region
+      - description: m3 dump memory region
+      - description: Q6 caldata memory region
+      - description: Multi Link Operation (MLO) Global memory region
+
+  memory-region-names:
+    items:
+      - const: q6-region
+      - const: m3-dump
+      - const: q6-caldb
+      - const: mlo-global-mem
+
+  qcom,calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
+  qcom,rproc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the Qualcomm Hexagon DSP(q6 remote processor), which is utilized
+      for offloading WiFi processing tasks, this q6 remote processor operates in
+      conjunction with WiFi.
+
+  qcom,smem-states:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: States used by the AP to signal the remote processor
+    items:
+      - description: Shutdown WCSS pd
+      - description: Stop WCSS pd
+      - description: Spawn WCSS pd
+
+  qcom,smem-state-names:
+    description:
+      Names of the states used by the AP to signal the remote processor
+    items:
+      - const: shutdown
+      - const: stop
+      - const: spawn
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+  - memory-region
+  - memory-region-names
+  - qcom,rproc
+  - qcom,smem-states
+  - qcom,smem-state-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/clock/qcom,ipq5332-gcc.h>
+
+    wifi0: wifi@c000000 {
+        compatible = "qcom,ipq5332-wifi";
+        reg = <0x0c000000 0x1000000>;
+        clocks = <&gcc GCC_XO_CLK>;
+        clock-names = "xo";
+        interrupts-extended = <&wcss_smp2p_in 8 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 9 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 12 IRQ_TYPE_NONE>,
+                              <&wcss_smp2p_in 11 IRQ_TYPE_NONE>,
+                              <&intc GIC_SPI 559 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 560 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 561 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 428 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 429 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 430 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 431 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 432 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 433 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 491 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 495 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 493 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 544 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 457 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 466 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 497 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 454 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 453 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 452 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 451 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 488 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 484 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 554 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 549 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 507 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 500 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 499 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 498 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 450 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 449 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 448 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 447 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 543 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 486 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 482 IRQ_TYPE_EDGE_RISING>,
+                              <&intc GIC_SPI 419 IRQ_TYPE_EDGE_RISING>;
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
+        qcom,calibration-variant = "RDP441_1";
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


