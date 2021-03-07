Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F04213304D2
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Mar 2021 22:21:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233040AbhCGVVV (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 7 Mar 2021 16:21:21 -0500
Received: from mail.kernel.org ([198.145.29.99]:60646 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233036AbhCGVUv (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 7 Mar 2021 16:20:51 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id DCA9564F17;
        Sun,  7 Mar 2021 21:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615152051;
        bh=1V0b8OdNSYC8i5w1YGKrRetzGySCN1Duq26amPZ0llM=;
        h=From:To:Cc:Subject:Date:From;
        b=Uwk3Iq9FLeohINY03WKobvdhlymAKTvNSn3MtdVthbWNaapfid/P1ven6JArRVPxV
         mxzsEc2k6lqcVskEN361zqsPWlkErbdei39+wm6IFJaBTo6TyfhSgUZQyh4kYpy3k1
         LnFNJJ4fXwvwsGTGARBZPtcrJOKuSziSWNG+krAJt/iu3YEkA3uNlL9Ip0zPTeX/16
         PirQ3jKUj7tAlVEgb7qXwRKLaIdjZf4TYFdiKnSL8oG92ntjdRF+YAz1hXq7GJKFIH
         IlqCR2rC2tBEqOanfYLSFG/CTZldFr/39VVb2eJejaO3y7ZcZGG0qBnQgC+KcZ+xPJ
         OYXe1xIXo92IQ==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     robh@kernel.org, linux-wireless@vger.kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings:net:wireless:mediatek,mt76: txt to yaml conversion
Date:   Sun,  7 Mar 2021 22:20:44 +0100
Message-Id: <b78122c8ddcbf4ac66adc2c0280665a84e7e9010.1615151665.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert mt76 dts bindings from .txt to .yaml

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/wireless/mediatek,mt76.txt   |  78 -----------
 .../bindings/net/wireless/mediatek,mt76.yaml  | 125 ++++++++++++++++++
 2 files changed, 125 insertions(+), 78 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
deleted file mode 100644
index ab7e7a00e534..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.txt
+++ /dev/null
@@ -1,78 +0,0 @@
-* MediaTek mt76xx devices
-
-This node provides properties for configuring the MediaTek mt76xx wireless
-device. The node is expected to be specified as a child node of the PCI
-controller to which the wireless chip is connected.
-
-Alternatively, it can specify the wireless part of the MT7628/MT7688 or
-MT7622 SoC. For SoC, use the following compatible strings:
-
-compatible:
-- "mediatek,mt7628-wmac" for MT7628/MT7688
-- "mediatek,mt7622-wmac" for MT7622
-
-properties:
-- reg: Address and length of the register set for the device.
-- interrupts: Main device interrupt
-
-MT7622 specific properties:
-- power-domains: phandle to the power domain that the WMAC is part of
-- mediatek,infracfg: phandle to the infrastructure bus fabric syscon node
-
-Optional properties:
-
-- ieee80211-freq-limit: See ieee80211.txt
-- mediatek,mtd-eeprom: Specify a MTD partition + offset containing EEPROM data
-- big-endian: if the radio eeprom partition is written in big-endian, specify
-  this property
-- mediatek,eeprom-merge-otp: Merge EEPROM data with OTP data. Can be used on
-  boards where the flash calibration data is generic and specific calibration
-  data should be pulled from the OTP ROM
-
-The MAC address can as well be set with corresponding optional properties
-defined in net/ethernet.txt.
-
-Optional nodes:
-- led: Properties for a connected LED
-  Optional properties:
-    - led-sources: See Documentation/devicetree/bindings/leds/common.txt
-
-&pcie {
-	pcie0 {
-		wifi@0,0 {
-			compatible = "mediatek,mt76";
-			reg = <0x0000 0 0 0 0>;
-			ieee80211-freq-limit = <5000000 6000000>;
-			mediatek,mtd-eeprom = <&factory 0x8000>;
-			big-endian;
-
-			led {
-				led-sources = <2>;
-			};
-		};
-	};
-};
-
-MT7628 example:
-
-wmac: wmac@10300000 {
-	compatible = "mediatek,mt7628-wmac";
-	reg = <0x10300000 0x100000>;
-
-	interrupt-parent = <&cpuintc>;
-	interrupts = <6>;
-
-	mediatek,mtd-eeprom = <&factory 0x0000>;
-};
-
-MT7622 example:
-
-wmac: wmac@18000000 {
-	compatible = "mediatek,mt7622-wmac";
-	reg = <0 0x18000000 0 0x100000>;
-	interrupts = <GIC_SPI 211 IRQ_TYPE_LEVEL_LOW>;
-
-	mediatek,infracfg = <&infracfg>;
-
-	power-domains = <&scpsys MT7622_POWER_DOMAIN_WB>;
-};
diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
new file mode 100644
index 000000000000..1a6e3d36944f
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -0,0 +1,125 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/mediatek,mt76.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek mt76 wireless devices Generic Binding
+
+maintainers:
+  - Felix Fietkau <nbd@nbd.name>
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description: |
+  This node provides properties for configuring the MediaTek mt76xx
+  wireless device. The node is expected to be specified as a child
+  node of the PCI controller to which the wireless chip is connected.
+  Alternatively, it can specify the wireless part of the MT7628/MT7688
+  or MT7622 SoC.
+
+properties:
+  compatible:
+    enum:
+      - mediatek,mt76
+      - mediatek,mt7628-wmac
+      - mediatek,mt7622-wmac
+
+  reg:
+    maxItems: 1
+    description:
+      Address and length of the register set for the device
+
+  interrupts:
+    maxItems: 1
+    description:
+      Main device interrupt
+
+  power-domains:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle to the power domain that the WMAC is part of.
+      This property is MT7622 specific
+
+  mediatek,infracfg:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      Phandle to the infrastructure bus fabric syscon node.
+      This property is MT7622 specific
+
+  ieee80211-freq-limit:
+    maxItems: 1
+    description:
+      List of supported frequency ranges in KHz
+
+  mediatek,mtd-eeprom:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      Phandle to a MTD partition + offset containing EEPROM data
+
+  big-endian:
+    type: boolean
+    description:
+      Specify if the radio eeprom partition is written in big-endian
+
+  mediatek,eeprom-merge-otp:
+    type: boolean
+    description:
+      Merge EEPROM data with OTP data. Can be used on boards where the flash
+      calibration data is generic and specific calibration data should be
+      pulled from the OTP ROM
+
+  led:
+    type: object
+    properties:
+      led-sources:
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        description:
+          List of device current outputs the LED is connected to
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    pcie0 {
+      #address-cells = <3>;
+      #size-cells = <2>;
+      wifi@0,0 {
+        compatible = "mediatek,mt76";
+        reg = <0x0000 0 0 0 0>;
+        ieee80211-freq-limit = <5000000 6000000>;
+        mediatek,mtd-eeprom = <&factory 0x8000>;
+        big-endian;
+
+        led {
+          led-sources = <2>;
+        };
+      };
+    };
+
+  - |
+    wmac: wmac@10300000 {
+      compatible = "mediatek,mt7628-wmac";
+      reg = <0x10300000 0x100000>;
+
+      interrupt-parent = <&cpuintc>;
+      interrupts = <6>;
+
+      mediatek,mtd-eeprom = <&factory 0x0>;
+    };
+
+  - |
+    wlmac: wmac@18000000 {
+      compatible = "mediatek,mt7622-wmac";
+      reg = <0x10300000 0x100000>;
+      interrupts = <0 211 8>;
+
+      mediatek,infracfg = <&infracfg>;
+
+      power-domains = <&scpsys 3>;
+    };
-- 
2.29.2

