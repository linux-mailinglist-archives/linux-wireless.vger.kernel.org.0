Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9D9C4287DA
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Oct 2021 09:40:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhJKHl7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Oct 2021 03:41:59 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:43832
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234602AbhJKHlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Oct 2021 03:41:52 -0400
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D87163FFF8
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 07:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1633937991;
        bh=rLmXqmzzo5GGghYT5vRh2TAaGHt8AG7Im5K0tL2thlE=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=SkKq/HWQymJT5fsebdus3F/tA7B4ayob+A3Nab59nqVUtqG/znUNysVXx0WAj6Vog
         37CJ6Q29yILYaO4O7Ux2qWhSdKk43mqV5vBcCpFcPlBT8gOuQvmz1G2aLq7eBOq1mV
         3/Kf1GqnMr0+NFVc8m1IZeTZlIEaW39l78QiOr6DgLNty7ESWPZB2Li6C5sA0D7p6R
         tS3UPEHCCAmkFnfAIUJP97IWpYTkmznLYnHevVSNaJxSFgK8RpRnLQSqnSGFThBTI2
         sqBGLW5FYw+NG1uSOE14j5UArXvuhy20dL7bNn9by8X2mBOxjm4XfVBGUXOWICxmsf
         hKGy7ZqL/jiSg==
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso15105447edx.2
        for <linux-wireless@vger.kernel.org>; Mon, 11 Oct 2021 00:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rLmXqmzzo5GGghYT5vRh2TAaGHt8AG7Im5K0tL2thlE=;
        b=ZFuWtBqxp+Wg0zSLXiaoCxWmZnf9U4roxl6kPcZWdIdfuzEhqvPH/Q8Gx1r19q7//A
         oboPh+95AxEtnG2kGdGWle6oOiSaOkNBJE6S7vm2zo/CcE8WoQk9qvlo+hPFnppXpZXd
         iw9Plx2hPs8EMh5PvK6QpxTZG/JMJmpEQVx1zrkNXs8XzCDLlfoDzrDkn03w/HZqA4tx
         rKkuC9B0P3Tjz+48chu/4zSD+fE8JQcbgEU3TMU6HJcZEwKAQBGxq/FW4YO9iikuAi2X
         IuW3IsldwAK71rAXDIvZMZ8hLo7FrZ78+jepSvfw0SCD8Gyp8H0Pcece2SKY8Y1U6FXC
         QQ9w==
X-Gm-Message-State: AOAM533PN2YHJ3DcDjHH8pOcbHXMOdKuDcMDDwqOqZVpKxBzBGnLPCVP
        LTA6zBBWEuYuJo1cLC1OTjhWBkFwFn4aP7oxTBKc3XzMWqfRRPy5GCq9Ml/zmMmx0Eoryz0noMJ
        Qt9ZZhwNvXc1RraPTMylaFF/qsabMC2QLaso5AYVdLolE
X-Received: by 2002:a05:6402:348a:: with SMTP id v10mr16185668edc.0.1633937990461;
        Mon, 11 Oct 2021 00:39:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2Ucwh17SL6sj5EvOGVNYMDI+/+fXsfm0C96VKhvnPfPMpzHqS1gw2RJ59i7Z57suwl5vG/w==
X-Received: by 2002:a05:6402:348a:: with SMTP id v10mr16185642edc.0.1633937990273;
        Mon, 11 Oct 2021 00:39:50 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id y8sm3023965ejm.104.2021.10.11.00.39.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Oct 2021 00:39:49 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Charles Gorand <charles.gorand@effinnov.com>,
        Mark Greer <mgreer@animalcreek.com>, linux-nfc@lists.01.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: [PATCH v2 4/8] dt-bindings: nfc: st,st21nfca: convert to dtschema
Date:   Mon, 11 Oct 2021 09:39:30 +0200
Message-Id: <20211011073934.34340-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
References: <20211011073934.34340-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert the ST ST21NFCA NFC controller to DT schema format.

Changes during bindings conversion:
1. Add a new required "interrupts" property, because it was missing in
   the old bindings by mistake.
2. Drop the "clock-frequency" property during conversion because it is a
   property of I2C bus controller, not I2C slave device.  It was also
   never used by the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/net/nfc/st,st21nfca.yaml         | 64 +++++++++++++++++++
 .../devicetree/bindings/net/nfc/st21nfca.txt  | 37 -----------
 2 files changed, 64 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/nfc/st21nfca.txt

diff --git a/Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml b/Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
new file mode 100644
index 000000000000..4356eacde8aa
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nfc/st,st21nfca.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nfc/st,st21nfca.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics SAS ST21NFCA NFC controller
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+
+properties:
+  compatible:
+    const: st,st21nfca-i2c
+
+  enable-gpios:
+    description: Output GPIO pin used for enabling/disabling the controller
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
+  uicc-present:
+    type: boolean
+    description: |
+      Specifies that the uicc swp signal can be physically connected to the
+      controller
+
+required:
+  - compatible
+  - enable-gpios
+  - interrupts
+  - reg
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
+        nfc@1 {
+            compatible = "st,st21nfca-i2c";
+            reg = <0x1>;
+
+            interrupt-parent = <&gpio5>;
+            interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
+            enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
+
+            ese-present;
+            uicc-present;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/net/nfc/st21nfca.txt b/Documentation/devicetree/bindings/net/nfc/st21nfca.txt
deleted file mode 100644
index b8bd90f80e12..000000000000
--- a/Documentation/devicetree/bindings/net/nfc/st21nfca.txt
+++ /dev/null
@@ -1,37 +0,0 @@
-* STMicroelectronics SAS. ST21NFCA NFC Controller
-
-Required properties:
-- compatible: Should be "st,st21nfca-i2c".
-- clock-frequency: I²C work frequency.
-- reg: address on the bus
-- enable-gpios: Output GPIO pin used for enabling/disabling the ST21NFCA
-
-Optional SoC Specific Properties:
-- pinctrl-names: Contains only one value - "default".
-- pintctrl-0: Specifies the pin control groups used for this controller.
-- ese-present: Specifies that an ese is physically connected to the nfc
-controller.
-- uicc-present: Specifies that the uicc swp signal can be physically
-connected to the nfc controller.
-
-Example (for ARM-based BeagleBoard xM with ST21NFCA on I2C2):
-
-&i2c2 {
-
-
-	st21nfca: st21nfca@1 {
-
-		compatible = "st,st21nfca-i2c";
-
-		reg = <0x01>;
-		clock-frequency = <400000>;
-
-		interrupt-parent = <&gpio5>;
-		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
-
-		enable-gpios = <&gpio5 29 GPIO_ACTIVE_HIGH>;
-
-		ese-present;
-		uicc-present;
-	};
-};
-- 
2.30.2

