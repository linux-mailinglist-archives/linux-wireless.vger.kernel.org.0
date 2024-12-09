Return-Path: <linux-wireless+bounces-16062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39B839E9A89
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 16:30:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8AFC280FB4
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 15:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C111E9B1B;
	Mon,  9 Dec 2024 15:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RqLVJWdj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FE11BEF7D;
	Mon,  9 Dec 2024 15:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733758239; cv=none; b=Qlla/2yow1V2CN9O74UKEZ94ZYQ3mNYoW5RgiA+Ti4fKr2OjsyjI7S5dcMNn+h0qYyY5DQe209AQptpmYbejOxNv5OWWbYFpqAhr090K7Y17sMmB3K0Y+OYtTOd6+7Zr5ot7pUQDcOUWV87Y890t9eQz8D+0oIC1v4A8Q1fpAtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733758239; c=relaxed/simple;
	bh=e9WSZvVMzILRMJOu0NThf7D3Et045XEjYOPkTYEM8Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RP/EPdVPvmKqy7E+ydyIgNKPrV0YMkaGHpnSYRJP0or/o9Y5GOBchSimBsnsaQ5MR9tk2x8Hbge3dE3P9R4Y6S91S0+g4oOiFWC3ISKqf133MtrGAGlHto9f5TT5/Jb9pa3T27Vjcw1BOUCby8ghSNhhjHF9dD1PF65xqxhC6e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RqLVJWdj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2EE7C4CED1;
	Mon,  9 Dec 2024 15:30:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733758238;
	bh=e9WSZvVMzILRMJOu0NThf7D3Et045XEjYOPkTYEM8Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RqLVJWdjEk0YslqvYuvOX/PVho3/hhjj8+cb5D4nyX96+Ioay+tapZzFVGfJgYGlH
	 xXeEn29seneZUtRYcTkNnfehFLzLfHQBxJPmbBpmDjtGyO3AUHTkEpOkbGpmnTL2g4
	 +liXS9zgOJYN9EnhJVTup+UClkT9q/1SorcPxbtFNGTjq6wF/uImGEkc4u/JtEcpfi
	 T7jO8GVQmE0cajlDMIo3STjkNhtKZWEYp4UWKPOgW+eM3Vg0c2+gNWmiVYtYT/1/pG
	 7W0NMDNt5W2eRjtASUCM8U+KgJDWa3YbjsHg/l7qSa3ax5PnBJWl1yy0daET+79y6W
	 sJ+BFT7DiA5Zw==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 1/8] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
Date: Mon,  9 Dec 2024 17:30:27 +0200
Message-Id: <20241209153034.50558-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241209153034.50558-1-kvalo@kernel.org>
References: <20241209153034.50558-1-kvalo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>

The QCN9274 WiFi device supports WSI (WLAN Serial Interface). WSI is used
to exchange specific control information across radios using a doorbell
mechanism. This WSI connection is essential for exchanging control
information among these devices. The WSI interface in the QCN9274 includes
TX and RX ports, which are used to connect multiple WSI-supported devices
together, forming a WSI group.

Describe QCN9274 PCI wifi device with WSI interface.

Signed-off-by: Raj Kumar Bhagat <quic_rajkbhag@quicinc.com>
Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>
---
 .../net/wireless/qcom,ath12k-wsi.yaml         | 205 ++++++++++++++++++
 1 file changed, 205 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
new file mode 100644
index 000000000000..7fec15e10a94
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
@@ -0,0 +1,205 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qcom,ath12k-wsi.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies ath12k wireless devices (PCIe) with WSI interface
+
+maintainers:
+  - Jeff Johnson <jjohnson@kernel.org>
+  - Kalle Valo <kvalo@kernel.org>
+
+description:
+  Qualcomm Technologies IEEE 802.11be PCIe devices with WSI interface.
+
+properties:
+  compatible:
+    enum:
+      - pci17cb,1109  # QCN9274
+
+  reg:
+    maxItems: 1
+
+  qcom,ath12k-calibration-variant:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      String to uniquely identify variant of the calibration data for designs
+      with colliding bus and device ids
+
+  qcom,wsi-controller:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The WSI controller device in the WSI group aids (is capable) to
+      synchronize the Timing Synchronization Function (TSF) clock across
+      all devices in the WSI group.
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+    description: |
+      The ath12k devices (QCN9274) feature WSI support. WSI stands for
+      WLAN Serial Interface. It is used for the exchange of specific
+      control information across radios based on the doorbell mechanism.
+      This WSI connection is essential to exchange control information
+      among these devices.
+
+      Diagram to represent one WSI connection (one WSI group) among
+      three devices.
+
+               +-------+        +-------+        +-------+
+               | pcie1 |        | pcie2 |        | pcie3 |
+               |       |        |       |        |       |
+        +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
+        |      | grp 0 |        | grp 0 |        | grp 0 |     |
+        |      +-------+        +-------+        +-------+     |
+        +------------------------------------------------------+
+
+      Diagram to represent two WSI connections (two separate WSI groups)
+      among four devices.
+
+           +-------+    +-------+          +-------+    +-------+
+           | pcie0 |    | pcie1 |          | pcie2 |    | pcie3 |
+           |       |    |       |          |       |    |       |
+       +-->|  wsi  |--->|  wsi  |--+   +-->|  wsi  |--->|  wsi  |--+
+       |   | grp 0 |    | grp 0 |  |   |   | grp 1 |    | grp 1 |  |
+       |   +-------+    +-------+  |   |   +-------+    +-------+  |
+       +---------------------------+   +---------------------------+
+
+      These ports are used to connect multiple WSI supported devices to
+      form a WSI group.
+
+      properties:
+        port@0:
+          $ref: /schemas/graph.yaml#/properties/port
+          description:
+            This is the TX port of WSI interface. It is attached to the RX
+            port of the next device in the WSI connection.
+
+        port@1:
+          $ref: /schemas/graph.yaml#/properties/port
+          description:
+            This is the RX port of WSI interface. It is attached to the TX
+            port of the previous device in the WSI connection.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
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
+                qcom,ath12k-calibration-variant = "RDP433_1";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        wifi1_wsi_tx: endpoint {
+                            remote-endpoint = <&wifi2_wsi_rx>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        wifi1_wsi_rx: endpoint {
+                            remote-endpoint = <&wifi3_wsi_tx>;
+                        };
+                    };
+                };
+            };
+        };
+
+        pcie@1 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x1 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            wifi@0 {
+                compatible = "pci17cb,1109";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+
+                qcom,ath12k-calibration-variant = "RDP433_2";
+                qcom,wsi-controller;
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        wifi2_wsi_tx: endpoint {
+                            remote-endpoint = <&wifi3_wsi_rx>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        wifi2_wsi_rx: endpoint {
+                            remote-endpoint = <&wifi1_wsi_tx>;
+                        };
+                    };
+                };
+            };
+        };
+
+        pcie@2 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x2 0x0 0x0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+
+            wifi@0 {
+                compatible = "pci17cb,1109";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+
+                qcom,ath12k-calibration-variant = "RDP433_3";
+
+                ports {
+                    #address-cells = <1>;
+                    #size-cells = <0>;
+
+                    port@0 {
+                        reg = <0>;
+
+                        wifi3_wsi_tx: endpoint {
+                            remote-endpoint = <&wifi1_wsi_rx>;
+                        };
+                    };
+
+                    port@1 {
+                        reg = <1>;
+
+                        wifi3_wsi_rx: endpoint {
+                            remote-endpoint = <&wifi2_wsi_tx>;
+                        };
+                    };
+                };
+            };
+        };
+    };
-- 
2.39.5


