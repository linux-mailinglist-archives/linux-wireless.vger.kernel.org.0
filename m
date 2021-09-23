Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18D2F41668F
	for <lists+linux-wireless@lfdr.de>; Thu, 23 Sep 2021 22:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243128AbhIWUWE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Sep 2021 16:22:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243083AbhIWUWE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Sep 2021 16:22:04 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F76C061574;
        Thu, 23 Sep 2021 13:20:31 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id t7so20515633wrw.13;
        Thu, 23 Sep 2021 13:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvQd80Q8N6XTLht8So1aPXzdw4e24dwYp1a6hARpPnQ=;
        b=AIe4muyNOlKj3ugSMfEF1d7vXvkTj9mh3oyhP0ruzHUb/kT/a/qqQkzCAMkmptGMzu
         SRY7JFnmJ27czzYqhocDFEhCdAbImZj2dEgvmhqF6sAsEKon3uSdCXLMGU5kfFBh6TDG
         wNKzPigmSDs8sPRdw10OD8RjHBVfTqTO6NrEvdnKucRRlPepgol2NnSDgieZjS0afSIx
         ijowystKpD4ApGJByOmdiBGjXoMtPxooBPzDZgk2tvFvahLxIF0do1aS7tBZHCqx7bVK
         Fn8Yv08+L83cCNvcztiYcj+TqYfrOj8sBrBEAYEWkCyot/nXCkriOPTYeSKlrAh+2o/R
         +L7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mvQd80Q8N6XTLht8So1aPXzdw4e24dwYp1a6hARpPnQ=;
        b=hA6LGbB9uVkd9OyZf4Hp6jIMVQqLKRB32E3ILzik7oVrDpvaf4qwdsHR/ejCfLGwxd
         zYFb06AQrnpXDubnBXUdITWbulKFUKIQAJ8lcqt1XLSuk1qFHXf0wOWfJLarggx4d/Nw
         VCmZFfWpmWZFPjyJfVD8BCVO5E8BWxks/M1FFa0tuPy4i63KB+z/TwJwjT+fA1Iks28O
         qP0yXfkSU11xbxFk1WoSXldqs/sLclevsw3icZI8Co80sCXbSQ1IeoVFKLTkDINeMTMm
         l6xXc+0KHorGFisz66QnOBdq2MOT7/29cLO32V9QoemBoVlBQ5ptIhbX8AyezDZlEFbT
         inMg==
X-Gm-Message-State: AOAM532LWjmTGQjWfhrnDJY7WKrjWWdq/eJPIA0NxH9aGPiC65/z05rl
        p7Vey8e0hkBrq6T3BU5SRL6C3bQ78ZU=
X-Google-Smtp-Source: ABdhPJwzZtG1Yc9xaRpgcrRsyrCUA7wfOEv1cqiClq33Wvr2eJs1ULRRkTijS+FREXo2qMRtOBiPUQ==
X-Received: by 2002:a5d:444a:: with SMTP id x10mr7437517wrr.360.1632428430377;
        Thu, 23 Sep 2021 13:20:30 -0700 (PDT)
Received: from debian64.daheim (p200300d5ff115d00d63d7efffebde96e.dip0.t-ipconnect.de. [2003:d5:ff11:5d00:d63d:7eff:febd:e96e])
        by smtp.gmail.com with ESMTPSA id i187sm6721443wma.0.2021.09.23.13.20.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 13:20:29 -0700 (PDT)
Received: from chuck by debian64.daheim with local (Exim 4.95-RC2)
        (envelope-from <chunkeey@gmail.com>)
        id 1mTVCn-002Pl1-4b;
        Thu, 23 Sep 2021 22:20:29 +0200
From:   Christian Lamparter <chunkeey@gmail.com>
To:     devicetree@vger.kernel.org, linux-wireless@vger.kernel.org
Cc:     Kalle Valo <kvalo@codeaurora.org>, Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v3] dt-bindings: net: wireless: qca,ath9k: convert to the json-schema
Date:   Thu, 23 Sep 2021 22:20:29 +0200
Message-Id: <20210923202029.575660-1-chunkeey@gmail.com>
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
	  (Please ignore the v2 with the missing v2 I just sent.)

(I hope my changes didn't invalidate Rob's review there.
I did run "make dt_binding_check" and no warning/error
came up.)
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
index 000000000000..7c78b070f48a
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
+      - pci168c,0023	# AR5416
+      - pci168c,0024	# AR5418
+      - pci168c,0027	# AR9160
+      - pci168c,0029	# AR9220 and AR9223
+      - pci168c,002a	# AR9280 and AR9283
+      - pci168c,002b	# AR9285
+      - pci168c,002c	# AR2427 - 802.11n bonded out
+      - pci168c,002d	# AR9227
+      - pci168c,002e	# AR9287
+      - pci168c,0030	# AR9380, AR9381 and AR9382
+      - pci168c,0032	# AR9485
+      - pci168c,0033	# AR9580 and AR9590
+      - pci168c,0034	# AR9462
+      - pci168c,0036	# AR9565
+      - pci168c,0037	# AR1111 and AR9485
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
index 1a8e641d7edf..5a3af6b25000 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15457,6 +15457,7 @@ M:	ath9k-devel@qca.qualcomm.com
 L:	linux-wireless@vger.kernel.org
 S:	Supported
 W:	https://wireless.wiki.kernel.org/en/users/Drivers/ath9k
+F:	Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
 F:	drivers/net/wireless/ath/ath9k/
 
 QUALCOMM CAMERA SUBSYSTEM DRIVER
-- 
2.33.0

