Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 197A633A7F6
	for <lists+linux-wireless@lfdr.de>; Sun, 14 Mar 2021 21:23:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbhCNUWO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Mar 2021 16:22:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:36244 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233332AbhCNUVh (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Mar 2021 16:21:37 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8E22364E6B;
        Sun, 14 Mar 2021 20:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615753297;
        bh=pSJFZfcj/20gH3g3OCEReCh/lO8yZoCOp9RvZZGBm6g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Gh4ui04mPupsdHAffq6LyHhcZ+zF5FksGpAKCU3UPPqkxLjeYbKFA1yQ3zzFQqPkr
         1RaQ9WcaeLiWIQc1emS+JxHwjKP1ZEB/TOVuZhFjX1u0WBQWBoNMCDIT5j0JVS1SPs
         tYfg41rgV64H9OgsWkBi0vT5dCizqPrl2G31czFr51ZvIdMlxhyFFzznyhtoJo7IlZ
         nWAdyVpL/f1I0Uq1tQsPGiNrKdd+GqpuNJpipyuqLJW19wCsn2Xc6MAErKgcNjiQFJ
         GsL3xgEHb9H/G1gFCBUcRUWANGKx4vkZbNfRuZ7mauZ716rSEXHwT8NAfZBNe0Ir8P
         /f+T4pIpsHQsg==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        robh@kernel.org, devicetree@vger.kernel.org,
        sean.wang@mediatek.com, ryder.lee@mediatek.com,
        johannes@sipsolutions.net
Subject: [PATCH v2 1/2] dt-bindings:net:wireless:ieee80211: txt to yaml conversion
Date:   Sun, 14 Mar 2021 21:21:06 +0100
Message-Id: <3dca0518c14e3a8e563933c903de0d62429a3667.1615752835.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1615752835.git.lorenzo@kernel.org>
References: <cover.1615752835.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Convert generic ieee80211 dts bindings from .txt to .yaml

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../bindings/net/wireless/ieee80211.txt       | 24 -----------
 .../bindings/net/wireless/ieee80211.yaml      | 41 +++++++++++++++++++
 2 files changed, 41 insertions(+), 24 deletions(-)
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
index 000000000000..6fb9ae7403c1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
@@ -0,0 +1,41 @@
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
+  - Johannes Berg <johannes@sipsolutions.net>
+
+description: |
+  This provides documentation of common properties that are valid for
+  all wireless devices
+
+properties:
+  ieee80211-freq-limit:
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
2.29.2

