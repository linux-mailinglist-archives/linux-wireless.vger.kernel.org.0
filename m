Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A154035A8FC
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Apr 2021 00:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235093AbhDIWwR (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 9 Apr 2021 18:52:17 -0400
Received: from mail.kernel.org ([198.145.29.99]:43380 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234602AbhDIWwR (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 9 Apr 2021 18:52:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 03A43610D1;
        Fri,  9 Apr 2021 22:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1618008723;
        bh=FJAhJZVeviWw1QlFoZmCJYYQgttdWObqAmg30iQFq3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=l0+5+/1n+q75fsrb0flPhHTyHE1XSvd4r4CA3fTqubM6koK0y9Y3bc+4KBlyB/Iph
         OJjZPXnqI0wdDhrwkww4gGWdzipNvKzgojf0ahOv+JAL+bWymFPi3aOisWC3PCrvzj
         fGkaxWgYD4DGYSRsD4iPK6O2hYTqbXbpsFtEaUmoCEQCp7q7/ttOV2dn3YU5rIwL+v
         1ionaSU/UnODdOA1sU2ISGPWmBGKd+tsVxHxkbPeMiYxLLt4NOmvn9PmAWCiVScko6
         hQKfJMT0Wp6OsZ+MABgWzEaE9UA5H7sFJvpGeIqW2EPvQzSFKaz+OP255NeMBTdTVU
         0P4B+PxUGcRkg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH v2 1/7] dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
Date:   Sat, 10 Apr 2021 00:51:46 +0200
Message-Id: <5712c0901cd826d49f881b6c632df35db1678a37.1618008449.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1618008449.git.lorenzo@kernel.org>
References: <cover.1618008449.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce power-limits node in mt76 binding in order to specify
per-rate power limit values for each 802.11n/802.11ac rate

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 96 +++++++++++++++++++
 1 file changed, 96 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index d6f835d17d66..f459323b8972 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -72,6 +72,79 @@ properties:
       led-sources:
         maxItems: 1
 
+  power-limits:
+    type: object
+    patternProperties:
+      "^r[0-9]+":
+        type: object
+        properties:
+          regdomain:
+            $ref: /schemas/types.yaml#/definitions/string
+            description:
+              Regdomain refers to a legal regulatory region. Different
+              countries define different levels of allowable transmitter
+              power, time that a channel can be occupied, and different
+              available channels
+            enum:
+              - FCC
+              - ETSI
+              - JP
+
+        patternProperties:
+          "^txpower-[256]g$":
+            type: object
+            patternProperties:
+              "^b[0-9]+$":
+                type: object
+                properties:
+                  channels:
+                    $ref: /schemas/types.yaml#/definitions/uint32-array
+                    minItems: 2
+                    maxItems: 2
+                    description:
+                      Pairs of first and last channel number of the selected
+                      band
+
+                  rates-cck:
+                    $ref: /schemas/types.yaml#/definitions/uint8-array
+                    minItems: 4
+                    maxItems: 4
+                    description:
+                      4 half-dBm per-rate power limit values
+
+                  rates-ofdm:
+                    $ref: /schemas/types.yaml#/definitions/uint8-array
+                    minItems: 8
+                    maxItems: 8
+                    description:
+                      8 half-dBm per-rate power limit values
+
+                  rates-mcs:
+                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
+                    description:
+                      Sets of per-rate power limit values for 802.11n/802.11ac
+                      rates for multiple channel bandwidth settings.
+                      Each set starts with the number of channel bandwidth
+                      settings for which the rate set applies, followed by
+                      either 8 or 10 power limit values. The order of the
+                      channel bandwidth settings is 20, 40, 80 and 160 MHz.
+
+                  rates-ru:
+                    $ref: /schemas/types.yaml#/definitions/uint8-matrix
+                    description:
+                      Sets of per-rate power limit values for 802.11ax rates
+                      for multiple channel bandwidth or resource unit settings.
+                      Each set starts with the number of channel bandwidth or
+                      resource unit settings for which the rate set applies,
+                      followed by 12 power limit values. The order of the
+                      channel resource unit settings is RU26, RU52, RU106,
+                      RU242/SU20, RU484/SU40, RU996/SU80 and RU2x996/SU160.
+
+                  txs-delta:
+                    $ref: /schemas/types.yaml#/definitions/uint32-array
+                    description:
+                      Half-dBm power delta for different numbers of antennas
+
 required:
   - compatible
   - reg
@@ -93,6 +166,29 @@ examples:
         led {
           led-sources = <2>;
         };
+
+        power-limits {
+          r0 {
+            regdomain = "FCC";
+            txpower-5g {
+               b0 {
+                   channels = <36 48>;
+                   rates-ofdm = /bits/ 8 <23 23 23 23 23 23 23 23>;
+                   rates-mcs = /bits/ 8 <1 23 23 23 23 23 23 23 23 23 23>,
+                                        <3 22 22 22 22 22 22 22 22 22 22>;
+                   rates-ru = /bits/ 8 <3 22 22 22 22 22 22 22 22 22 22 22 22>,
+                                       <4 20 20 20 20 20 20 20 20 20 20 20 20>;
+               };
+               b1 {
+                   channels = <100 181>;
+                   rates-ofdm = /bits/ 8 <14 14 14 14 14 14 14 14>;
+                   rates-mcs = /bits/ 8  <4 14 14 14 14 14 14 14 14 14 14>;
+                   txs-delta = <12 9 6>;
+                   rates-ru = /bits/ 8  <7 14 14 14 14 14 14 14 14 14 14 14 14>;
+               };
+             };
+          };
+        };
       };
     };
 
-- 
2.30.2

