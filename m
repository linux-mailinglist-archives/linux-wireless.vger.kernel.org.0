Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 043084287EA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 09:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234695AbhJKHmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 03:42:19 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43894
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234687AbhJKHl4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:56 -0400
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 101793FFF3
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 07:39:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937996;
        bh=/XeYfendRIFkvRSIer1TvzFUH2i0JBuqjZibDPlwRDM=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=va+ZpTcM47+BdWqsCXjNNXyG5ldnlRV4dmKKn+2MMoNZzx+cY9jFEoCg0D6w5HYCH
         DPlWLtjA8iNnZj8j66X4WZ/yVo1U6Wp3qiJbtX8QY6goZqse6wYAbNVHszsX54xeN3
         6siGTqNUuChuT5gFoS3dDwTtWcb+ZutSEA6QRrPI+UnqPqQqv4r72IfKTamhVW0JMA
         Vkw1woIc3ESuPcQVUlwL3i3VTGWek1UE2+c51HBoEyr7njAmXKXLB3ywDdUzWhZqxE
         Hkw8YcxMha9DHRm2yPRBNiVHnUTLLUvHLiiYvGdiPIzkjCPE43uqobUeVv8P0fUtIv
         8gqp/TGBhnPCQ==
Received: by mail-ed1-f70.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so13035709edy.14
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 00:39:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XeYfendRIFkvRSIer1TvzFUH2i0JBuqjZibDPlwRDM=;
        b=jht1GMowJnHyJeGRoggCXV/VUThoxOOf+0Sz/Z4/olTLiSHNskY9ez/NTv4lA13tAA
         cvatVTsVuotVqwCc1WzIi5QGf194x2ubGdyRjFIYtS+/18P/9y9YBs4/+RgnKsZE/qTf
         0fdghYIXsUF0ptk4Fxrss4TNIUqQZ1pMoG2oZUmcG3w8k/XmAPXjUx4LQ7CPRmIkFC18
         u6gOpCERF173BPGyon1zwgVnIUUEhIx+bVC7RTK0aLuFY+A3OwUV95LNgY6caZ0QCtBS
         b4tW+0PlJgHKU4tdvl+bx/u0n2kWMOAqq0Rt8tW0p3zTnb99Y/dmMc9wo8FqwvCdSaVe
         TIBw==
X-Gm-Message-State: AOAM532x1H3tIGMZsWw/JJx7WVsXJ5KvG30g/zI4DNAIbiYMgbmtcZvB
        CYn4BNDUTsDxbMh6xe9NYVxTh3QROkJCVGnU84wgsih0+K/rdGadxAEDHWGydONxfD+LhnJyGV/
        Q5gC+S8j0QeZHQxp8nPvZ2kq9ALRArPUcZTkCb5p2zWiE
X-Received: by 2002:a17:907:7646:: with SMTP id kj6mr8875527ejc.152.1633937993537;
        Mon, 11 Oct 2021 00:39:53 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw9iqe6eRX8bi+xuljjGbOC/sGTF2/LP6nad/H8ICj05RanR/nyRcOA/0y3B69U5ovTpKatFg==
X-Received: by 2002:a17:907:7646:: with SMTP id kj6mr8875504ejc.152.1633937993356;
        Mon, 11 Oct 2021 00:39:53 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:52 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 6/8] dt-bindings: nfc: st,nci: convert to dtschema
Date:   Mon, 11 Oct 2021 09:39:32 +0200
Message-Id: <20211011073934.34340-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
References: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert the ST NCI (ST21NFCB) NFC controller to DT schema format.

Changes during bindings conversion:
1. Add a new required "reg" property for SPI binding, because SPI child
   devices use it as chip-select.
2. Drop the "clock-frequency" property during conversion because it is a
   property of I2C bus controller, not I2C slave device.  It was also
   never used by the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/net/nfc/st,st-nci.yaml           | 106 ++++++++++++++++++
 .../bindings/net/nfc/st-nci-i2c.txt           |  38 -------
 .../bindings/net/nfc/st-nci-spi.txt           |  36 ------
 3 files changed, 106 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt

diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
new file mode 100644
index 000000000000..a6a1bc788d29
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
@@ -0,0 +1,106 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nfc/st,st-nci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics ST NCI NFC controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    enum:
+      - st,st21nfcb-i2c
+      - st,st21nfcb-spi
+      - st,st21nfcc-i2c
+
+  reset-gpios:
+    description: Output GPIO pin used for resetting the controller
+
+  ese-present:
+    type: boolean
+    description: |
+      Specifies that an ese is physically connected to the controller
+
+  interrupts:
+    maxItems: 1
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency: true
+
+  uicc-present:
+    type: boolean
+    description: |
+      Specifies that the uicc swp signal can be physically connected to the
+      controller
+
+required:
+  - compatible
+  - interrupts
+  - reg
+  - reset-gpios
+
+if:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - st,st21nfcb-i2c
+          - st,st21nfcc-i2c
+then:
+  properties:
+    spi-max-frequency: false
+else:
+  required:
+    - spi-max-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@8 {
+            compatible = "st,st21nfcb-i2c";
+            reg = <0x08>;
+
+            interrupt-parent = <&gpio5>;
+            interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
+            reset-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+
+            ese-present;
+            uicc-present;
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        nfc@0 {
+            compatible = "st,st21nfcb-spi";
+            reg = <0>;
+
+            spi-max-frequency = <4000000>;
+
+            interrupt-parent = <&gpio5>;
+            interrupts = <2 IRQ_TYPE_EDGE_RISING>;
+            reset-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+
+            ese-present;
+            uicc-present;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt b/Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
deleted file mode 100644
index baa8f8133d19..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/st-nci-i2c.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* STMicroelectronics SAS. ST NCI NFC Controller
-
-Required properties:
-- compatible: Should be "st,st21nfcb-i2c" or "st,st21nfcc-i2c".
-- clock-frequency: I²C work frequency.
-- reg: address on the bus
-- interrupts: GPIO interrupt to which the chip is connected
-- reset-gpios: Output GPIO pin used to reset the ST21NFCB
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-- ese-present: Specifies that an ese is physically connected to the nfc
-controller.
-- uicc-present: Specifies that the uicc swp signal can be physically
-connected to the nfc controller.
-
-Example (for ARM-based BeagleBoard xM with ST21NFCB on I2C2):
-
-&i2c2 {
-
-
-	st21nfcb: st21nfcb@8 {
-
-		compatible = "st,st21nfcb-i2c";
-
-		reg = <0x08>;
-		clock-frequency = <400000>;
-
-		interrupt-parent = <&gpio5>;
-		interrupts = <2 IRQ_TYPE_LEVEL_HIGH>;
-
-		reset-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
-
-		ese-present;
-		uicc-present;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt b/Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt
deleted file mode 100644
index d33343330b94..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/st-nci-spi.txt
+++ /dev/null
@@ -1,36 +0,0 @@
-* STMicroelectronics SAS. ST NCI NFC Controller
-
-Required properties:
-- compatible: Should be "st,st21nfcb-spi"
-- spi-max-frequency: Maximum SPI frequency (<= 4000000).
-- interrupts: GPIO interrupt to which the chip is connected
-- reset-gpios: Output GPIO pin used to reset the ST21NFCB
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-- ese-present: Specifies that an ese is physically connected to the nfc
-controller.
-- uicc-present: Specifies that the uicc swp signal can be physically
-connected to the nfc controller.
-
-Example (for ARM-based BeagleBoard xM with ST21NFCB on SPI4):
-
-&mcspi4 {
-
-
-	st21nfcb: st21nfcb@0 {
-
-		compatible = "st,st21nfcb-spi";
-
-		clock-frequency = <4000000>;
-
-		interrupt-parent = <&gpio5>;
-		interrupts = <2 IRQ_TYPE_EDGE_RISING>;
-
-		reset-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
-
-		ese-present;
-		uicc-present;
-	};
-};
-- 
2.30.2

