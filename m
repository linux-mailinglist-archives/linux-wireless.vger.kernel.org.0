Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C318F582E5C
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Jul 2022 19:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241122AbiG0RMG (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 27 Jul 2022 13:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241502AbiG0RLc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 27 Jul 2022 13:11:32 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749B55B062
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 09:41:39 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id v21so1847027ljh.3
        for <linux-wireless@vger.kernel.org>; Wed, 27 Jul 2022 09:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjrmIY6br0JwMML5I5IsH4l21ubS3Zd2UVsxfz0zrWQ=;
        b=jMMOnDuOyvT5MjTFryYduQK/RY48LBB89wkU1nKr3g22oGREE8Wlw5ovuddGmk1777
         C5oyCsNSgVwjzgaMVV3lrx/A9RSJXDUlw/6oRB6h95ewv0MRYNZ7JaiAXafHdi/AaMoR
         gwFiup9G4e394tdCjmRY8aQCKVjQndYSllXn3/tYsHVyAWsURSC+28LRzBtd1L9bG7tW
         YcSv/hu6PKMNjl/xVP/hN/HMu56kKFibCPKwO7n4NY8kpwTbTHQWwmbX1/BKLClzbw6G
         yiXqWnuj7YDnyDJ+zjd+XmiqP+SZbgUPMDOKgb7mr1M6reSluGSe2P2BR3fy+KXy9Km8
         e9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EjrmIY6br0JwMML5I5IsH4l21ubS3Zd2UVsxfz0zrWQ=;
        b=fwjakGfNk68WBin1Ws1TvaTpk6d/oFV7y/F5HLkMeEt02Cz9GKi1evkPxQ1mYVZf9q
         i2QN9HhWz1gknAKVkWH6bVNuUcgkr9gpBRnZPAspaPFZs3M93jLOPdb3d2uStgsHtRmF
         75x3BsF2EDSAZsW06OhkzpMrZwb8iPiJCK4Uvm37o3hKIhC+DRMxVeuQfP8BT35RoW5i
         daWAabviY2lYktDYKM/Im+I+gHqk42Ww8bsh4xhO+et1aUbVZwBAeIW04rGujkaYuZYX
         dGIxzBUxtfGWf6yaOu793F1C5y8iE4vnN7/KpotJXOEcLP9xnuQ656f8anX14S792Dpq
         qzRA==
X-Gm-Message-State: AJIora9WZ/qoZSpwg1pKHsIVNf+ENegp6YVqKcCDVICfTUN8ty6H9Lw/
        dNr3IX2b380FydCoDuBRGibsow==
X-Google-Smtp-Source: AGRyM1tbxmt+m0wPQaDPBmSI4ZOiMzOv0P2lpYBxlI5htHP/NbFnJvzztwcBcIVithfgzBx/B6J3Aw==
X-Received: by 2002:a05:651c:1587:b0:25d:7844:5910 with SMTP id h7-20020a05651c158700b0025d78445910mr8508285ljq.325.1658940093266;
        Wed, 27 Jul 2022 09:41:33 -0700 (PDT)
Received: from krzk-bin.lan (78-26-46-173.network.trollfjord.no. [78.26.46.173])
        by smtp.gmail.com with ESMTPSA id i17-20020a2ea231000000b0025a67779931sm3872519ljm.57.2022.07.27.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 09:41:32 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Greer <mgreer@animalcreek.com>,
        Kalle Valo <kvalo@kernel.org>,
        =?UTF-8?q?J=C3=A9r=C3=B4me=20Pouiller?= 
        <jerome.pouiller@silabs.com>,
        Adham Abozaeid <adham.abozaeid@microchip.com>,
        Ajay Singh <ajay.kathat@microchip.com>,
        Tony Lindgren <tony@atomide.com>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: [PATCH 1/2] dt-bindings: nfc: use spi-peripheral-props.yaml
Date:   Wed, 27 Jul 2022 18:41:29 +0200
Message-Id: <20220727164130.385411-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Instead of listing directly properties typical for SPI peripherals,
reference the spi-peripheral-props.yaml schema.  This allows using all
properties typical for SPI-connected devices, even these which device
bindings author did not tried yet.

Remove the spi-* properties which now come via spi-peripheral-props.yaml
schema, except for the cases when device schema adds some constraints
like maximum frequency.

While changing additionalProperties->unevaluatedProperties, put it in
typical place, just before example DTS.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Technically, this depends on [1] merged to SPI tree, if we want to
preserve existing behavior of not allowing SPI CPHA and CPOL in each of
schemas in this patch.

If this patch comes independently via different tree, the SPI CPHA and
CPOL will be allowed for brief period of time, before [1] is merged.
This will not have negative impact, just DT schema checks will be
loosened for that period.

[1] https://lore.kernel.org/all/20220722191539.90641-2-krzysztof.kozlowski@linaro.org/
---
 Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml | 4 ++--
 Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml   | 5 ++---
 Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml   | 7 ++++---
 Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml | 7 ++++---
 4 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml b/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
index 1bcaf6ba822c..a191a04e681c 100644
--- a/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/marvell,nci.yaml
@@ -58,7 +58,6 @@ properties:
 
   spi-cpha: true
   spi-cpol: true
-  spi-max-frequency: true
 
 required:
   - compatible
@@ -85,6 +84,7 @@ allOf:
           contains:
             const: marvell,nfc-spi
     then:
+      $ref: /schemas/spi/spi-peripheral-props.yaml#
       properties:
         break-control: false
         flow-control: false
@@ -108,7 +108,7 @@ allOf:
         spi-max-frequency: false
         reg: false
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
index ef1155038a2f..1dcbddbc5a74 100644
--- a/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/st,st-nci.yaml
@@ -30,8 +30,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   uicc-present:
     type: boolean
     description: |
@@ -55,10 +53,11 @@ then:
   properties:
     spi-max-frequency: false
 else:
+  $ref: /schemas/spi/spi-peripheral-props.yaml#
   required:
     - spi-max-frequency
 
-additionalProperties: false
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml b/Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
index 963d9531a856..647569051ed8 100644
--- a/Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/st,st95hf.yaml
@@ -25,8 +25,6 @@ properties:
   st95hfvin-supply:
     description: ST95HF transceiver's Vin regulator supply
 
-  spi-max-frequency: true
-
 required:
   - compatible
   - enable-gpio
@@ -34,7 +32,10 @@ required:
   - reg
   - spi-max-frequency
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
diff --git a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
index 404c8df99364..9cc236ec42f2 100644
--- a/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
+++ b/Documentation/devicetree/bindings/net/nfc/ti,trf7970a.yaml
@@ -40,8 +40,6 @@ properties:
   reg:
     maxItems: 1
 
-  spi-max-frequency: true
-
   ti,enable-gpios:
     minItems: 1
     maxItems: 2
@@ -65,7 +63,10 @@ required:
   - ti,enable-gpios
   - vin-supply
 
-additionalProperties: false
+allOf:
+  - $ref: /schemas/spi/spi-peripheral-props.yaml#
+
+unevaluatedProperties: false
 
 examples:
   - |
-- 
2.34.1

