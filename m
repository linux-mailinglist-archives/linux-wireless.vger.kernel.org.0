Return-Path: <linux-wireless+bounces-16247-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9C49ECFCE
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 16:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 394591671F8
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 15:34:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18861C07D2;
	Wed, 11 Dec 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hyeNf2pP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98ACE13B2A9;
	Wed, 11 Dec 2024 15:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733931277; cv=none; b=VV5g4k7YN5rvOxXPxPmIYrS2LWSR9YtQgGt5uCD4iouvRWSii4l1dGnx6Yihr8OIa6rZJCI9VS2DBegGZZY2fLj75cecQ7S+QEx1/P1HYxTjl46c08MjN33n20oxVVQBW+d6ecq/SL1O9XkCQf8DOKgzeGQ469Hm/ei9AFgPtnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733931277; c=relaxed/simple;
	bh=gD+erWKg1WYx/d4VCqYCo1hgx/4qc9+Utl+HoeSnyT8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jCIfY+HssBNiZ1rqbJHzv860Peeh3W8G0J6pY6WYLVfycTNeM/yGqMPYAwvmDds1XbyGuWr6nW7frDwgGFKMixx20PFw/YAENG6dXXDsFjE6lSkO5rUkTI0YedQnarsSBTQzq1vGwj9R2PWUe1JlCtMrLeNSMb1ifqAZWMnBRbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hyeNf2pP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C17C4CED4;
	Wed, 11 Dec 2024 15:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733931277;
	bh=gD+erWKg1WYx/d4VCqYCo1hgx/4qc9+Utl+HoeSnyT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hyeNf2pPhxf8OrXPynw3ZOnsQRAiKq2XlKgysFLHjNEeondWlJi1qYzAJqvr3nyTw
	 mz3Yah9fUlONwnwrXY7bURsih52xrL+tlzo6lDb80FE5fdDQ4fyFzI7gVc86Ixlf2p
	 WNWGCFUq3OqYxiOvszzEAhhX8fBooyknPPE/Nq52hrip5c9etxr8so0xgEqh4c1NZa
	 doh9hnTTIfg2em46LXr64ffSLauOZX2rWcsHViU2xFvnVAQhBpOUKg2PEPm6VJMjjl
	 pMGMALN8PqTgZI/WFZE3lpvbAtjMP2mpzKf1JJgFI20yVOtYvPop9bOclD38FA47Wi
	 ca2yi+7iUZbow==
From: Kalle Valo <kvalo@kernel.org>
To: ath12k@lists.infradead.org
Cc: linux-wireless@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/8] dt-bindings: net: wireless: Describe ath12k PCI module with WSI
Date: Wed, 11 Dec 2024 17:34:25 +0200
Message-Id: <20241211153432.775335-2-kvalo@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241211153432.775335-1-kvalo@kernel.org>
References: <20241211153432.775335-1-kvalo@kernel.org>
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
 .../net/wireless/qcom,ath12k-wsi.yaml         | 204 ++++++++++++++++++
 1 file changed, 204 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
new file mode 100644
index 000000000000..cbfb559f6b69
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath12k-wsi.yaml
@@ -0,0 +1,204 @@
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
+description: |
+  Qualcomm Technologies IEEE 802.11be PCIe devices with WSI interface.
+
+  The ath12k devices (QCN9274) feature WSI support. WSI stands for
+  WLAN Serial Interface. It is used for the exchange of specific
+  control information across radios based on the doorbell mechanism.
+  This WSI connection is essential to exchange control information
+  among these devices.
+
+  The WSI interface includes TX and RX ports, which are used to connect
+  multiple WSI-supported devices together, forming a WSI group.
+
+  Diagram to represent one WSI connection (one WSI group) among
+  three devices.
+
+           +-------+        +-------+        +-------+
+           | pcie1 |        | pcie2 |        | pcie3 |
+           |       |        |       |        |       |
+    +----->|  wsi  |------->|  wsi  |------->|  wsi  |-----+
+    |      | grp 0 |        | grp 0 |        | grp 0 |     |
+    |      +-------+        +-------+        +-------+     |
+    +------------------------------------------------------+
+
+  Diagram to represent two WSI connections (two separate WSI groups)
+  among four devices.
+
+       +-------+    +-------+          +-------+    +-------+
+       | pcie0 |    | pcie1 |          | pcie2 |    | pcie3 |
+       |       |    |       |          |       |    |       |
+   +-->|  wsi  |--->|  wsi  |--+   +-->|  wsi  |--->|  wsi  |--+
+   |   | grp 0 |    | grp 0 |  |   |   | grp 1 |    | grp 1 |  |
+   |   +-------+    +-------+  |   |   +-------+    +-------+  |
+   +---------------------------+   +---------------------------+
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
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          This is the TX port of WSI interface. It is attached to the RX
+          port of the next device in the WSI connection.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description:
+          This is the RX port of WSI interface. It is attached to the TX
+          port of the previous device in the WSI connection.
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


