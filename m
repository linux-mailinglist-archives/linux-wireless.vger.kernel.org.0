Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6695D4281BF
	for <lists+linux-wireless@lfdr.de>; Sun, 10 Oct 2021 16:23:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbhJJOZ3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 10 Oct 2021 10:25:29 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:60038
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232931AbhJJOZ0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 10 Oct 2021 10:25:26 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id A4AD23FFEE
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 14:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633875807;
        bh=qgri1L0KhFh/RnI/H2zoBpT+z6G38bInX4GBDJQ63dQ=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=vBf+CtRgg1YX0XgWGemt2XUUd6/EaEhl8B+AHMhFfgTINq4Y/ihYDNg5PaqbBZOo9
         1XgjkJJtQQhozEKaaOlkNlOG7fQv4aDo7Vy2jDuuhUiQoE9O9GKFKYO5wqGwvJPgHD
         GPme5UdhFeQccJJxxk6+F8tL10tnSSCRLB/e/W03AMD5gPi/IZ9Vn0jc59/USwEigt
         R034tsQ4hBn5V3K0niLXaX0odHbvcXZi8BsKd1AWODg2OCGmAW3+iiIKVK5CUS5C1h
         BZeWmXAaptMpucgRc73oenLb+licWtHr5VYULMCC429N66xpc8xLHNIKlxuslQzhty
         paYDtC1JRT2Nw==
Received: by mail-ed1-f70.google.com with SMTP id h19-20020aa7de13000000b003db6ad5245bso4847265edv.9
        for <linux-wireless@vger.kernel.org>; Sun, 10 Oct 2021 07:23:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qgri1L0KhFh/RnI/H2zoBpT+z6G38bInX4GBDJQ63dQ=;
        b=tDtku5+9CODVrzY7WgFTrG5cwRL5bzDxGzVAjmHZ6PITAqHEBVauN7eqsyyJEfMmUI
         iGzCneprcu9BL/4okWy3KUwxGldnLzFL+HtgbdsY/0F3fnAKuT1wBMMf9pK9QBNr96Gv
         KsAUMRLbeo3OEnltsa7b1bVOQVehRZHp169rrd357l7nRo7RRjUd6ryRxVZe7tMgVcu5
         V4Zvtm/DXev2No8mR8GUj26kO317qehcSq+A38AOvOC9J13zYnTiI3GaHsqYBkmXFS/n
         aHpaX66uiVHtKAcNAESzhogwuAoejSw2yUl13aRyA0KRh0n4/0yWtsHzXSd9VohpQ9XI
         5WDw==
X-Gm-Message-State: AOAM5337WIiCalrb10q1UxvN1nu1Vg8IKO/bknP9oeL+eHkakwKH3ZCN
        y0UCFOvTuK2ajFfGP/Vd4qFmVjZF4yF8225vyNbvA7wM8TO1NG74pLgjBGzALkYjziLnlV8T0T/
        bmIV0OJzBNvYBj/kOk3PTeL/xkdr3fK6l7s8+96HSyHKG
X-Received: by 2002:a17:906:6819:: with SMTP id k25mr19643367ejr.423.1633875807177;
        Sun, 10 Oct 2021 07:23:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz6gyduGgsH5Gq98NwhAmLbU7sM0X4/f1GLLStXo4wqXw1cZY5ufgiwDS3jywJhli65sNIoQw==
X-Received: by 2002:a17:906:6819:: with SMTP id k25mr19643345ejr.423.1633875807006;
        Sun, 10 Oct 2021 07:23:27 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id 6sm2129017ejx.82.2021.10.10.07.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Oct 2021 07:23:26 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH 2/7] dt-bindings: nfc: nxp,pn532: convert to dtschema
Date:   Sun, 10 Oct 2021 16:23:12 +0200
Message-Id: <20211010142317.168259-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211010142317.168259-1-krzysztof.kozlowski@canonical.com>
References: <20211010142317.168259-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert the NXP PN532 NFC controller to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/net/nfc/nxp,pn532.yaml           | 70 +++++++++++++++++++
 .../devicetree/bindings/net/nfc/pn532.txt     | 46 ------------
 2 files changed, 70 insertions(+), 46 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/pn532.txt

diff --git a/Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml b/Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
new file mode 100644
index 000000000000..c6f41b483297
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nfc/nxp,pn532.yaml
@@ -0,0 +1,70 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nfc/nxp,pn532.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP Semiconductors PN532 NFC controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    oneOf:
+      - const: nxp,pn532
+      - description: Deprecated bindings
+        enum:
+          - nxp,pn532-i2c
+          - nxp,pn533-i2c
+        deprecated: true
+
+  clock-frequency:
+    description: Required if connected via I2C
+
+  interrupts:
+    description: Required if connected via I2C
+    maxItems: 1
+
+  reg:
+    description: Required if connected via I2C
+    maxItems: 1
+
+required:
+  - compatible
+
+dependencies:
+  clock-frequency: [ 'reg' ]
+  interrupts: [ 'reg' ]
+
+additionalProperties: false
+
+examples:
+  # PN532 on I2C bus
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@24 {
+            compatible = "nxp,pn532";
+
+            reg = <0x24>;
+            clock-frequency = <400000>;
+
+            interrupt-parent = <&gpio1>;
+            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+        };
+    };
+
+  # PN532 connected via UART
+  - |
+    serial@49042000 {
+        reg = <0x49042000 0x400>;
+
+        nfc {
+            compatible = "nxp,pn532";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/nfc/pn532.txt b/Documentation/devicetree/bindings/net/nfc/pn532.txt
deleted file mode 100644
index a5507dc499bc..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/pn532.txt
+++ /dev/null
@@ -1,46 +0,0 @@
-* NXP Semiconductors PN532 NFC Controller
-
-Required properties:
-- compatible: Should be
-    - "nxp,pn532" Place a node with this inside the devicetree node of the bus
-                  where the NFC chip is connected to.
-                  Currently the kernel has phy bindings for uart and i2c.
-    - "nxp,pn532-i2c" (DEPRECATED) only works for the i2c binding.
-    - "nxp,pn533-i2c" (DEPRECATED) only works for the i2c binding.
-
-Required properties if connected on i2c:
-- clock-frequency: I²C work frequency.
-- reg: for the I²C bus address. This is fixed at 0x24 for the PN532.
-- interrupts: GPIO interrupt to which the chip is connected
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-
-Example (for ARM-based BeagleBone with PN532 on I2C2):
-
-&i2c2 {
-
-
-	pn532: nfc@24 {
-
-		compatible = "nxp,pn532";
-
-		reg = <0x24>;
-		clock-frequency = <400000>;
-
-		interrupt-parent = <&gpio1>;
-		interrupts = <17 IRQ_TYPE_EDGE_FALLING>;
-
-	};
-};
-
-Example (for PN532 connected via uart):
-
-uart4: serial@49042000 {
-        compatible = "ti,omap3-uart";
-
-        pn532: nfc {
-                compatible = "nxp,pn532";
-        };
-};
-- 
2.30.2

