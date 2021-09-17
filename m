Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C97640FE1D
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Sep 2021 18:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239023AbhIQQsB (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Sep 2021 12:48:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238554AbhIQQsB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Sep 2021 12:48:01 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BD6C061574;
        Fri, 17 Sep 2021 09:46:38 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id u15so16177497wru.6;
        Fri, 17 Sep 2021 09:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt6A2qb6oWFQ6edNGQ8+cV/ziNjOtyoAn3e7h0OhE+Q=;
        b=i2Vvue+eyIfuU8FPs3GLhTu7MwQGyGP7z9FXEnP++ZmkiUXp+SVPZQGAhvGuJ/gvbm
         iMT1ZCMy+FZ0DcG6xRAEx9ddN//8Fw66zp9fNYb7BxUlvu4MkeuS/nAHOSmjAogns9jo
         cf8OQYfkoyO/h1M1DZ5Faa2V1GOcEz1LS3QtFBmiXUKXxhZ5ufS+qdgCz6Oih6VTJ7W8
         19OstUXcUQGSnpVrXbJUHcEAJpzb2VK7X6mMZ25Sh3dLFgynIkUxGhbsSNI4YxlW7ykw
         0gb0Bf3HM1+cD1Pnt+ET/1bzC6QZgqfSFpc/fjLLESLzANtD35/BMesPQ4RbxUthTuR7
         56DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kt6A2qb6oWFQ6edNGQ8+cV/ziNjOtyoAn3e7h0OhE+Q=;
        b=sPLj71XnOjokAyRAOpKvxEw+nA9pz9x/pVQpudotF0xdyfFsEhZAXiYZtaJnhzytmF
         e0F2VuaEoz6VoaVfoGZ+Bua/gnmr8zTH4iSl3gWK6/OSlgh2CqGLWxs44TfPUjBShHu5
         VXLQY0lRoN6B22EelDYXCVSBvM03aNuSjoVM8uYXhCco/IFT6rh2MnIfgwdpP32Y3nyC
         C0ArwqM4NReYTQ/hNSVzdlZkl4BZNVMB1Pj5nPpZwULlZcasL9Q4XH5GSy/M8giQb33G
         QYm8niGu8SnDwFUDEIIze3+0nDGkYhrRlg3i9XJWJm60moPZanwe2yGK4CuiggFKjk5R
         d9fA==
X-Gm-Message-State: AOAM533WC0oKS7lv4pVBU+SWIUMXl05hFJ5mehj3OjFstQs2eTG3NsZE
        ueadIQnYSg0vlkJlfyDrCwy43JHVq64=
X-Google-Smtp-Source: ABdhPJwf18wLs8f0Y4zumawGIv0/wD72HZD46dTxKZ6NoFNfIMU6yvnbcjjz2wwG2Ks7OJFwUOMpNg==
X-Received: by 2002:adf:d239:: with SMTP id k25mr12964228wrh.383.1631897197130;
        Fri, 17 Sep 2021 09:46:37 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff0aec00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff0a:ec00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id j134sm3785774wmj.27.2021.09.17.09.46.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 09:46:36 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95-RC2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mRH0W-000VOI-3K;
        Fri, 17 Sep 2021 18:46:36 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH] dt-bindings: net: wireless: qca,ath9k: convert to the json-schema
Date:   Fri, 17 Sep 2021 18:46:36 +0200
Message-Id: <20210917164636.120658-1-chunkeey@gmail.com>
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

Added binding .yaml to MAINTAINERS.

Signed-off-by: Christian Lamparter <chunkeey@gmail.com>
---

Q: Is there a way to encode the pci-id device value to the
specific chip? This is because the qca,ath9k.txt had this
nice list:
                  - 002e for AR9287
                  - 0030 for AR9380, AR9381 and AR9382
                  - 0032 for AR9485

I would like to preserve this information.

Thanks,
Christian

---
 .../bindings/net/wireless/qca,ath9k.txt       | 48 -----------
 .../bindings/net/wireless/qca,ath9k.yaml      | 82 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 3 files changed, 83 insertions(+), 48 deletions(-)
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
index 000000000000..af00105f39c7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
@@ -0,0 +1,82 @@
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
+      - pci168c,0023
+      - pci168c,0024
+      - pci168c,0027
+      - pci168c,0029
+      - pci168c,002a
+      - pci168c,002b
+      - pci168c,002c
+      - pci168c,002d
+      - pci168c,002e
+      - pci168c,0030
+      - pci168c,0032
+      - pci168c,0033
+      - pci168c,0034
+      - pci168c,0036
+      - pci168c,0037
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
+
+        nvmem-cells = <&macaddr_art_c>, <&cal_art_1000>;
+        nvmem-cell-names = "mac-address", "calibration";
+      };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 6abfd3e36c31..5b42798637a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15346,6 +15346,7 @@ M:	ath9k-devel@qca.qualcomm.com
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
+F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
-- 
2.33.0

