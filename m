Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29C12417DCF
	for <lists+linux-wireless@lfdr.de>; Sat, 25 Sep 2021 00:35:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232695AbhIXWgq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 24 Sep 2021 18:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230030AbhIXWgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 24 Sep 2021 18:36:45 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D7C061571;
        Fri, 24 Sep 2021 15:35:12 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u18so31727235wrg.5;
        Fri, 24 Sep 2021 15:35:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0GKjDtn5asb6lNaXzUohAN8fZzeKt2FTsd1KxqHHug=;
        b=YIqxPfMfr8A9Lx+VIosjZXC88VpuzhKhs+4PdLfeiy3r42UanOOXSlfjLMCUb/tFeM
         JGuGIphxb8yvRQ/7KjoGYFZNfC/EV1SLJMhfxaSYb2+DEN9HqYTTNuwBf+SZSQh2jGr4
         Sb0SCGT67+uulUDiLtny3eG4uHw8ARYKz8uu1hO+vd/y5I0XoeA1flw1yOlqlb2nKa5D
         abtSO+Tfau1AVQMzQOqzSyN3JFwvG8haPLEjrfTD0QIbW5cAdHQ9PfvhzwWMd0PkAZzg
         UcUjTgz7F9NhgVxpJ24JEdu/JKllktAp+v6pS3U0HXcOQJASPXUymIVehPQ5jiWN+FmS
         OX7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=K0GKjDtn5asb6lNaXzUohAN8fZzeKt2FTsd1KxqHHug=;
        b=T4EB8WnGfpQ+1QBL/VBWwANmiBeNMaIwfoBgEuNbMP20gDd2PF14cKwc6MpwT9xysI
         tcOxPnyitrGOOUzOy70dHLxtRYT9yXN9CBTEY6UckXbmdF4CqJOXcUxw9heH2dqVZe/Y
         aOFCuiJNSxZejCF4+fXJxLfc4hLMZFpjzqWEvGM5PhBY62Dz5tDPMESa8+a9c3e76s5K
         IrZ19UiXqknFNMYAJ7kCXGPGIMhEfrlCt0p/9D5guP6U1KQeZXYVkKTV60Z3ePfOcGA4
         jE08cxx8oI0WlDyi+29I23HeVsGc/4pIQrLvKbOn88yGl7Sc6S5d9kiDTzlrvONcQFdf
         vQcg==
X-Gm-Message-State: AOAM530Qj7Q8Jc6A3OnHbawBUucHsrbjO+ztmGI5FmXJpvNyNoXpyQXt
        QsIAV/DaLZNcszUI9zmyXberotz8zwQ=
X-Google-Smtp-Source: ABdhPJyN5RiLONv0EwfBUoVQL+Qel19fegnmnRaSgBnxNJdJfWOwjPEekEm8fPjmXS2AoYA3UMBLgQ==
X-Received: by 2002:a7b:c7d3:: with SMTP id z19mr4356242wmk.86.1632522910349;
        Fri, 24 Sep 2021 15:35:10 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff055c00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff05:5c00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id o7sm11732330wro.45.2021.09.24.15.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Sep 2021 15:35:09 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95-RC2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mTtmf-000DfV-9j;
        Sat, 25 Sep 2021 00:35:09 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4] dt-bindings: net: wireless: qca,ath9k: convert to the json-schema
Date:   Sat, 25 Sep 2021 00:35:09 +0200
Message-Id: <20210924223509.52525-1-chunkeey@gmail.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This replaces the existing .txt binding file. Furthermore, this
also helps with validating DTS files.

Introduced binding changes:
 1. added inherited mac-address nvmem property
 2. added inherited ieee80211-freq-limit property
 3. added new calibration nvmem property
 4. added second example (taken from the Netgear WNDR3700v2)
    Reason: Setting qca,no-eeprom; takes presedence over
    nvmem-cells. I think a different example is needed,
    because the driver can only reads from one calibration
    source per device.
 5. (re-added) chip list (based on data from ath9k's pci.c)

Added binding .yaml to MAINTAINERS.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Christian Lamparter <chunkeey@gmail.com>

---
v1 -> v2:
	- added second example (pci device - AR9220)
	- added commented chip list from the qca,ath9k.txt+ath9k's pci.c

v2 -> v3:
	- forgot to include patch version in tag. Oops.

v3 -> v4:
	- replaced tabs with 2 spaces (Rob - yamllint needs 2).
---
 .../bindings/net/wireless/qca,ath9k.txt       | 48 ----------
 .../bindings/net/wireless/qca,ath9k.yaml      | 90 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 91 insertions(+), 48 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
deleted file mode 100644
index aaaeeb5f935b..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-* Qualcomm Atheros ath9k wireless devices
-
-This node provides properties for configuring the ath9k wireless device. The
-node is expected to be specified as a child node of the PCI controller to
-which the wireless chip is connected.
-
-Required properties:
-- compatible: For PCI and PCIe devices this should be an identifier following
-		the format as defined in "PCI Bus Binding to Open Firmware"
-		Revision 2.1. One of the possible formats is "pciVVVV,DDDD"
-		where VVVV is the PCI vendor ID and DDDD is PCI device ID.
-		Typically QCA's PCI vendor ID 168c is used while the PCI device
-		ID depends on the chipset - see the following (possibly
-		incomplete) list:
-			- 0023 for AR5416
-			- 0024 for AR5418
-			- 0027 for AR9160
-			- 0029 for AR9220 and AR9223
-			- 002a for AR9280 and AR9283
-			- 002b for AR9285
-			- 002c for AR2427
-			- 002d for AR9227
-			- 002e for AR9287
-			- 0030 for AR9380, AR9381 and AR9382
-			- 0032 for AR9485
-			- 0033 for AR9580 and AR9590
-			- 0034 for AR9462
-			- 0036 for AR9565
-			- 0037 for AR9485
-- reg: Address and length of the register set for the device.
-
-Optional properties:
-- qca,no-eeprom: Indicates that there is no physical EEPROM connected to the
-			ath9k wireless chip (in this case the calibration /
-			EEPROM data will be loaded from userspace using the
-			kernel firmware loader).
-
-The MAC address will be determined using the optional properties defined in
-net/ethernet.txt.
-
-In this example, the node is defined as child node of the PCI controller:
-&pci0 {
-	wifi@168c,002d {
-		compatible = "pci168c,002d";
-		reg = <0x7000 0 0 0 0x1000>;
-		qca,no-eeprom;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
new file mode 100644
index 000000000000..8cd0adbf7021
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -0,0 +1,90 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/qca,ath9k.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Atheros ath9k wireless devices Generic Binding
+
+maintainers:
+  - Kalle Valo <kvalo@codeaurora.org>
+
+description: |
+  This node provides properties for configuring the ath9k wireless device.
+  The node is expected to be specified as a child node of the PCI controller
+  to which the wireless chip is connected.
+
+allOf:
+  - $ref: ieee80211.yaml#
+
+properties:
+  compatible:
+    enum:
+      - pci168c,0023  # AR5416
+      - pci168c,0024  # AR5418
+      - pci168c,0027  # AR9160
+      - pci168c,0029  # AR9220 and AR9223
+      - pci168c,002a  # AR9280 and AR9283
+      - pci168c,002b  # AR9285
+      - pci168c,002c  # AR2427 - 802.11n bonded out
+      - pci168c,002d  # AR9227
+      - pci168c,002e  # AR9287
+      - pci168c,0030  # AR9380, AR9381 and AR9382
+      - pci168c,0032  # AR9485
+      - pci168c,0033  # AR9580 and AR9590
+      - pci168c,0034  # AR9462
+      - pci168c,0036  # AR9565
+      - pci168c,0037  # AR1111 and AR9485
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  ieee80211-freq-limit: true
+
+  qca,no-eeprom:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      Indicates that there is no physical EEPROM connected
+
+  nvmem-cells:
+    items:
+      - description: Reference to an nvmem node for the MAC address
+      - description: Reference to an nvmem node for calibration data
+
+  nvmem-cell-names:
+    items:
+      - const: mac-address
+      - const: calibration
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
+        compatible = "pci168c,002d";
+        reg = <0 0 0 0 0>;
+        interrupts = <3>;
+        qca,no-eeprom;
+      };
+    };
+  - |
+    pci0 {
+      #address-cells = <3>;
+      #size-cells = <2>;
+      wifi@0,11 {
+        compatible = "pci168c,0029";
+        reg = <0x8800 0 0 0 0>;
+        nvmem-cells = <&macaddr_art_c>, <&cal_art_1000>;
+        nvmem-cell-names = "mac-address", "calibration";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 58e3264b96c2..28da8421ad11 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15456,6 +15456,7 @@ M:	ath9k-devel@qca.qualcomm.com
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
+F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
-- 
2.33.0

