Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A131133A182
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Mar 2021 22:54:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234781AbhCMVxR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 13 Mar 2021 16:53:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234385AbhCMVxG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 13 Mar 2021 16:53:06 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B32EC061763
        for <linux-wireless@vger.kernel.org>; Sat, 13 Mar 2021 13:53:05 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id f26so11762001ljp.8
        for <linux-wireless@vger.kernel.org>; Sat, 13 Mar 2021 13:53:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zeMrkglujiTzPE4Zy3XbR9wMePA6IveVBZZS1HWZ7Jk=;
        b=I8llNvx42f7D2yt7Dl54YSWj/dQWZilBkqyva9Notkh8QB01o6HRAt07UWSuiKyD/i
         Q4u2A3RlAw+A7VYEjGI3ErFaD+MtlfjuEwQM3CQSqpj+TvGGWlIwVg3JhSAJVcLmy/OI
         KRRZig5UrSkH+ixqzUUOulo0ZHbouhn1ENMQb9rBTEWU29TdM3P2EbKMvt5w6Nkf78FN
         4vQR1F1dtaI1QG3dfperyVDRfF4VpmYm/OXQFHlJC9e0ogxEVrhmZQsMwSJhrbROuooE
         FirTqymUCp7KkhE4HjYmIsgAN/BEOq531mh95NltzCKob+K9cUlohEVA4dfBbo4loviX
         Y8aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zeMrkglujiTzPE4Zy3XbR9wMePA6IveVBZZS1HWZ7Jk=;
        b=BBaAFcxTxThksDt8GktYAVx8uCJHc5e7JlGHn4bYfTp43r8I7SCPjWaVoMHIiwtvpB
         MfCSwDElp2LZImfdXikbyJFcPxzDrmcgFP2u03gS+FCVcSByNadUs1FSAUZWpwzldESr
         Og3YXkxzsLxlRiT9N0JXstwHYPEH9ID2o6VemSlrSq7466yfYGdOGf+6rSKBgEnXerQO
         TA891Uy9Quuv3CdkZd3Jvx300iScclMM1iIcW/DwlZ/LHGHVUxBNDjImDOk8B54amm3m
         rDzQD3en0XjlTCYWP8QnQxIx/pSEneOKk0ad99mA59ADESRr9rc/+m5lRCNurSEPnlnV
         ey9A==
X-Gm-Message-State: AOAM531YR1fd9pmj6fXh3T1xIwqEBm6S3Baioo/aeF7qbsONzzq4CWMf
        wFLLbN9meqE04eqftIU2Qf26CQ==
X-Google-Smtp-Source: ABdhPJxxAn9QqdL1PA5RzazC1c1Qu/+dpClT2F8xC3pnTxnwkql2R6lP2I4ncLOcVLp+LyrQW9DKlA==
X-Received: by 2002:a2e:a58d:: with SMTP id m13mr6241354ljp.347.1615672384296;
        Sat, 13 Mar 2021 13:53:04 -0800 (PST)
Received: from localhost.localdomain (c-d7cb225c.014-348-6c756e10.bbcust.telenor.se. [92.34.203.215])
        by smtp.gmail.com with ESMTPSA id l7sm2442214lje.30.2021.03.13.13.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Mar 2021 13:53:03 -0800 (PST)
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-hsien Lin <chi-hsien.lin@infineon.com>,
        Wright Feng <wright.feng@infineon.com>,
        Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc:     linux-wireless@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: Convert the BCM4329 bindings to YAML and extend
Date:   Sat, 13 Mar 2021 22:53:02 +0100
Message-Id: <20210313215302.4076765-1-linus.walleij@linaro.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This converts the BCM4329 family bindings to YAML schema, and
extends and fixes the bindings like this:

- Name the bindings after the first chip (BCM4329) since
  wildcards like 43xx are nowadays frowned upon by the DT
  binding reviewers. We call this the "BCM4329 family"
- Add compatible strings for all the variants that seem to
  exist in the wild. (Derived from firmware listings.)
- Add required reg property (SDIO function number)
- Add reset-gpios property (some systems wire this to a GPIO
  line).
- I have only listed Arend as maintainer for now, volunteers
  can be added.

Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Chi-hsien Lin <chi-hsien.lin@infineon.com>
Cc: Wright Feng <wright.feng@infineon.com>
Cc: Chung-hsien Hsu <chung-hsien.hsu@infineon.com>
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com
Cc: linux-mmc@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 .../net/wireless/brcm,bcm4329-fmac.yaml       | 98 +++++++++++++++++++
 .../net/wireless/brcm,bcm43xx-fmac.txt        | 38 -------
 2 files changed, 98 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt

diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
new file mode 100644
index 000000000000..d172ee486cf6
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/brcm,bcm4329-fmac.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/brcm,bcm4329-fmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Broadcom BCM4329 family fullmac wireless SDIO devices
+
+maintainers:
+  - Arend van Spriel <arend@broadcom.com>
+
+description:
+  The Broadcom Single chip MAC part for the BCM4329 family and
+  later Cypress chips in the same family named CYW4373 and similar.
+  These chips also have a Bluetooth portion described in a separate
+  binding.
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - brcm,bcm43143-fmac
+          - brcm,bcm4341b0-fmac
+          - brcm,bcm4341b4-fmac
+          - brcm,bcm4341b5-fmac
+          - brcm,bcm4329-fmac
+          - brcm,bcm4330-fmac
+          - brcm,bcm4334-fmac
+          - brcm,bcm43340-fmac
+          - brcm,bcm4335-fmac
+          - brcm,bcm43362-fmac
+          - brcm,bcm4339-fmac
+          - brcm,bcm43430a0-fmac
+          - brcm,bcm43430a1-fmac
+          - brcm,bcm43455-fmac
+          - brcm,bcm43456-fmac
+          - brcm,bcm4354-fmac
+          - brcm,bcm4356-fmac
+          - brcm,bcm4359-fmac
+          - cypress,cyw4373-fmac
+          - cypress,cyw43012-fmac
+
+  reg:
+    description: SDIO function number for the device, for most cases
+      this will be 1.
+
+  interrupts:
+    maxItems: 1
+    description: Out-of-band (OOB) IRQ line for waking up the host
+      in response to WLAN activity. This corresponds to the HOST_WAKE
+      line into the chip.
+
+  interrupt-names:
+    description: Name for the OOB IRQ, this must be set to "host-wake".
+    const: host-wake
+
+  brcm,drive-strength:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: Drive strength used for the SDIO pins on the device in mA.
+    minimum: 0
+    maximum: 32
+
+  reset-gpios:
+    maxItems: 1
+    description: A GPIO line connected to the WL_RST line, if present
+      this shall be flagged as active low.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+    mmc@80118000 {
+      compatible = "arm,pl18x", "arm,primecell";
+      reg = <0x80118000 0x1000>;
+      clocks = <&clk 0>, <&clk 1>;
+      clock-names = "mclk", "apb_pclk";
+      interrupts = <0 60 IRQ_TYPE_LEVEL_HIGH>;
+      bus-width = <4>;
+      non-removable;
+      vmmc-supply = <&wl_bt_reg>;
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      wifi@1 {
+        compatible = "brcm,bcm4329-fmac";
+        reg = <1>;
+        interrupt-parent = <&gpio>;
+        interrupts = <24 IRQ_TYPE_EDGE_FALLING>;
+        interrupt-names = "host-wake";
+        reset-gpios = <&gpio 23 GPIO_ACTIVE_LOW>;
+      };
+    };
diff --git a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt b/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
deleted file mode 100644
index cffb2d6876e3..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/brcm,bcm43xx-fmac.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-Broadcom BCM43xx Fullmac wireless SDIO devices
-
-This node provides properties for controlling the Broadcom wireless device. The
-node is expected to be specified as a child node to the SDIO controller that
-connects the device to the system.
-
-Required properties:
-
- - compatible : Should be "brcm,bcm4329-fmac".
-
-Optional properties:
- - brcm,drive-strength : drive strength used for SDIO pins on device in mA
-	(default = 6).
- - interrupts : specifies attributes for the out-of-band interrupt (host-wake).
-	When not specified the device will use in-band SDIO interrupts.
- - interrupt-names : name of the out-of-band interrupt, which must be set
-	to "host-wake".
-
-Example:
-
-mmc3: mmc@1c12000 {
-	#address-cells = <1>;
-	#size-cells = <0>;
-
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc3_pins_a>;
-	vmmc-supply = <&reg_vmmc3>;
-	bus-width = <4>;
-	non-removable;
-
-	brcmf: wifi@1 {
-		reg = <1>;
-		compatible = "brcm,bcm4329-fmac";
-		interrupt-parent = <&pio>;
-		interrupts = <10 8>; /* PH10 / EINT10 */
-		interrupt-names = "host-wake";
-	};
-};
-- 
2.29.2

