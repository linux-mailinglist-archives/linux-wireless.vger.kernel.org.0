Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5794D348426
	for <lists+linux-wireless@lfdr.de>; Wed, 24 Mar 2021 22:51:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbhCXVu1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 24 Mar 2021 17:50:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:40030 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231934AbhCXVuS (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 24 Mar 2021 17:50:18 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7D8C761A10;
        Wed, 24 Mar 2021 21:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616622618;
        bh=7A3Cz/ENgM6t3YPJE+RTnXyJf3ePdP82kEmtoAFuNGQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=QIeORvNupkTVkfe1ofHOT+gAvq+ta4r2nmAiDYp4xDrE3za7h/wz/KEaSm91+kfvR
         a/bfsiKH3xJVPELE7LDLeSErY/q+NcOdGdLIsXA/oofDiYZeM2NLzez5+B9rcaYGSb
         mfE0TOQMIBuJWYzrTT9j2ystsS0eK+GeILzeXQLlB99IfYDCn7uEAsNd5KhAro2BIV
         DY1+AXtvAcGv6uE8lQyJ4A5+9hqyoHD5o1HLBOGDnhZjtlZoE8duprJVyUd6sndDjc
         4svrb+xZvFv7OSfK+Cdn8R/S3Sc0sXoutSLse9frwxyKxAh98qApKVcyRYu9UOawOr
         fKi7jbgTZwdeA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, robh@kernel.org,
        lorenzo.bianconi@redhat.com, sean.wang@mediatek.com,
        ryder.lee@mediatek.com, devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml conversion
Date:   Wed, 24 Mar 2021 22:49:59 +0100
Message-Id: <248bcf217858a827849758e5af48b02376bca28f.1616621229.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cover.1616621229.git.lorenzo@kernel.org>
References: <cover.1616621229.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert generic ieee80211 dts bindings from .txt to .yaml

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/wireless/ieee80211.txt       | 24 ----------
 .../bindings/net/wireless/ieee80211.yaml      | 45 +++++++++++++++++++
 2 files changed, 45 insertions(+), 24 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.txt
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ieee80211.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.txt b/Documentation/devicetree/bindings/net/wireless/ieee80211.txt
deleted file mode 100644
index f6442b1397f5..000000000000
--- a/Documentation/devicetree/bindings/net/wireless/ieee80211.txt
+++ /dev/null
@@ -1,24 +0,0 @@
-Common IEEE 802.11 properties
-
-This provides documentation of common properties that are valid for all wireless
-devices.
-
-Optional properties:
- - ieee80211-freq-limit : list of supported frequency ranges in KHz. This can be
-	used for devices that in a given config support less channels than
-	normally. It may happen chipset supports a wide wireless band but it is
-	limited to some part of it due to used antennas or power amplifier.
-	An example case for this can be tri-band wireless router with two
-	identical chipsets used for two different 5 GHz subbands. Using them
-	incorrectly could not work or decrease performance noticeably.
-
-Example:
-
-pcie@0,0 {
-	reg = <0x0000 0 0 0 0>;
-	wifi@0,0 {
-		reg = <0x0000 0 0 0 0>;
-		ieee80211-freq-limit = <2402000 2482000>,
-				       <5170000 5250000>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
new file mode 100644
index 000000000000..d58e1571df9b
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (c) 2018-2019 The Linux Foundation. All rights reserved.
+
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/ieee80211.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Common IEEE 802.11 Binding
+
+maintainers:
+  - Lorenzo Bianconi <lorenzo@kernel.org>
+
+description: |
+  This provides documentation of common properties that are valid for
+  all wireless devices
+
+properties:
+  ieee80211-freq-limit:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      minItems: 2
+      maxItems: 2
+    description:
+      List of supported frequency ranges in KHz. This can be used for devices
+      that in a given config support less channels than normally. It may happen
+      chipset supports a wide wireless band but it is limited to some part of
+      it due to used antennas or power amplifier. An example case for this
+      can be tri-band wireless router with two identical chipsets used for two
+      different 5 GHz subbands. Using them incorrectly could not work or
+      decrease performance noticeably
+
+additionalProperties: true
+
+examples:
+  - |
+    pcie0 {
+      #address-cells = <3>;
+      #size-cells = <2>;
+      wifi@0,0 {
+        reg = <0x0000 0 0 0 0>;
+        ieee80211-freq-limit = <2402000 2482000>,
+                               <5170000 5250000>;
+      };
+    };
-- 
2.30.2

