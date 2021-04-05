Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEEF2354215
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Apr 2021 14:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhDEMky (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Apr 2021 08:40:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:43730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235289AbhDEMkx (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Apr 2021 08:40:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 33F956138A;
        Mon,  5 Apr 2021 12:40:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617626447;
        bh=m353sHpeQCluanv88FhS5CJ1v+41g7avREx4FPyjSdA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9FlBrkJ/CkoNLrNbHwXN1aAB9GPqUWeHrHvRqHSifUcYflmoRu1CJjvmKulq9Ol/
         vriLb+nOPFRzVXVGVNPnSz88ZcloLU+NF6OPzxQhilCfUyhKeCoJqU8IqHZxQttuiw
         lbo1qeNysmdsXOakSEr0KQJzh4jIk0M/G+inFIn74lcUnpqTMbr2r145mV1jJCYlK+
         lxfWqdko8ShzqkOjatuzER0c3mGj6GAoyMPcf6xk7GJoTsAGfF75cpFWLrYpBvsT9k
         A8CNmxlMinPmCF3zXL2qLbFXw6lJTlaTUWJhXtpuWp/oSyc1y46jNb7MOpSHDRNtmb
         znnFglEDdvcwA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        shayne.chen@mediatek.com, devicetree@vger.kernel.org,
        robh@kernel.org
Subject: [PATCH 2/8] dt-bindings:net:wireless:mediatek,mt76: introduce power-limits node
Date:   Mon,  5 Apr 2021 14:40:26 +0200
Message-Id: <eb6998d12c7f60a28c7f3eab455d4339656f76e2.1617625912.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1617625912.git.lorenzo@kernel.org>
References: <cover.1617625912.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Introduce power-limits node in mt76 binding in order to specify
per-rate power limit values for each 802.11n/802.11ac rate

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/wireless/mediatek,mt76.yaml  | 79 +++++++++++++++++++
 1 file changed, 79 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
index d6f835d17d66..6ede331e3e52 100644
--- a/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml
@@ -72,6 +72,62 @@ properties:
       led-sources:
         maxItems: 1
 
+  power-limits:
+    type: object
+    properties:
+      regdomain: true
+
+    patternProperties:
+      "^r[0-9]+":
+        type: object
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
+                  cck:
+                    $ref: /schemas/types.yaml#/definitions/uint32-array
+                    minItems: 4
+                    maxItems: 4
+                    description:
+                      4 half-dBm per-rate power limit values
+
+                  mcs:
+                    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+                    description:
+                      Sets of per-rate power limit values for 802.11n/802.11ac
+                      rates for multiple channel bandwidth settings.
+                      Each set starts with the number of channel bandwidth
+                      settings for which the rate set applies, followed by
+                      either 8 or 10 power limit values. The order of the
+                      channel bandwidth settings is 20, 40, 80 and 160 MHz.
+
+                  ru:
+                    $ref: /schemas/types.yaml#/definitions/uint32-matrix
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
@@ -93,6 +149,29 @@ examples:
         led {
           led-sources = <2>;
         };
+
+        power-limits {
+          r0 {
+            txpower-5g {
+               regdomain = "FCC";
+               b0 {
+                   channels = <36 48>;
+                   ofdm = <23 23 23 23 23 23 23 23>;
+                   mcs = <1 23 23 23 23 23 23 23 23 23 23>,
+                         <3 22 22 22 22 22 22 22 22 22 22>;
+                   ru = <3 22 22 22 22 22 22 22 22 22 22 22 22>,
+                        <4 20 20 20 20 20 20 20 20 20 20 20 20>;
+               };
+               b1 {
+                   channels = <100 181>;
+                   ofdm = <14 14 14 14 14 14 14 14>;
+                   mcs = <4 14 14 14 14 14 14 14 14 14 14>;
+                   txs-delta = <12 9 6>;
+                   ru = <7 14 14 14 14 14 14 14 14 14 14 14 14>;
+               };
+             };
+          };
+        };
       };
     };
 
-- 
2.30.2

