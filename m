Return-Path: <linux-wireless+bounces-20513-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77E67A67D81
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 20:57:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 925AC425A0B
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E710213232;
	Tue, 18 Mar 2025 19:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhLvWKjr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F352A21149C;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742327809; cv=none; b=gWERnFOdGyX+xUtKIgZYFIgkczQLbzr3WRo7SIjp3NAx4f/w7kFjVOhIozhfDraNwvqUQZVDLTHr2YCyQd5UxVJS8i4HdWhhe/orF6gNaNUwfxaQEq0sqqbkjsVeLKwyBYmiCY3zjJaq2QuFP9Zbg9R/uL4Wxqfxwv7S66ivvGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742327809; c=relaxed/simple;
	bh=CzFbm+7L5Vyy9jjivohc2P9KYcboe4VapFvp3hF1W2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VG/b2N5W7Qg0R595AF076p2SiAf1LeNdmplVJUso7yy4KyF/k1zxIBYvZ1YCHeyFHwoWYTpdhrsEmeVOvoy5sEU13OsET4Iqnr02vQFPhL2O2a1L7+hN33StGuQY8Us6QkmB6NjtjerNao6utbZgsa6yGLH9s/tuRZPxOXwQChU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhLvWKjr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70BC5C4CEEF;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742327808;
	bh=CzFbm+7L5Vyy9jjivohc2P9KYcboe4VapFvp3hF1W2s=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HhLvWKjrxOJRYDW6Lb7AHm3LQtBf4RD+3oVEf4Qq5ROCRFIFY5lOIPyzvGLkpwYU6
	 3U44AGoqxn+eGPstA7W32Lq3f2KKr6OR0aQaVeUMWpOkd9X4D85eFf9YsehRZl2Se7
	 z07rX/8LmAfMWzYfa1+QgrbfLNvbu8aSwDFBxzhdAzavKAoJG6M/sRcBqskyZy2G2H
	 d3iI8QWv+5PMZUHQr4uYkxoLqgDNeNsi3XrxECBz+n2oBFYfvLCaT2ISg2uJ+UjgKw
	 v0lbo19rAi0KP0dRpET18ZdLIBSkiWifddIwdS7kH9cAYjtiJfcgZuoZV1qCni7p9a
	 XHBoVOuXtiCBA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59397C35FF3;
	Tue, 18 Mar 2025 19:56:48 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Tue, 18 Mar 2025 20:56:44 +0100
Subject: [PATCH v3 1/5] dt-bindings: net: Add network-class schema for
 mac-address properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-dt-bindings-network-class-v3-1-4d8d04ddfb61@ixit.cz>
References: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
In-Reply-To: <20250318-dt-bindings-network-class-v3-0-4d8d04ddfb61@ixit.cz>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Lorenzo Bianconi <lorenzo@kernel.org>, van Spriel <arend@broadcom.com>, 
 =?utf-8?q?J=C3=A9r=C3=B4me_Pouiller?= <jerome.pouiller@silabs.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4464; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=orfTbHEU99ipurv+cUYrmAsUPSP1cgMsKS/OBxtUqXo=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2c/+OZbKTMaBm68C09wuzyn1cQ7Jd/cnvVyQ8
 q0EzqxwxB+JAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9nP/gAKCRBgAj/E00kg
 ciwkD/9oq3Fz55PhkT6XXV7ZTfSWqzbrPJ4Enc+egCqkmqzYMB7GNFF6BX/JGwZBllIMjxYxxYS
 nkOtgziO6N2bDTtbkWhgc9YZDlZew0Qj29rbCfszfi6gu6D4wKGYrZumtbXrRygifVPQxZXNgPT
 L9Z0Binr28R58HOig7MinWLJV6m+rxbO2ome0QVGjGINh0LhpeoYbkY9rW1DCk6J/JTVKbZCrxb
 5ulZ3UPkO53JxbLP9o5zcjiJvpR9gcBpA7pXqwXLJySTmlsgHJhYABkcheJYu4cYO+/O5fgN0Rz
 6eDBOfe7qJG+kN6pxwvFkqzFZPmZ/xaWPFL5Ayz9Zg60YNobAwzIxjwzm/pRZURwcw9ajvCyNgv
 kV4AxkeulikyGRhKuvK0mFvPKsnd4YrqX46SuwbbBroGXGgndlDO8ZXr1NmgaINpULDXha1ElM6
 8aKFc5AD7Xm4cUK+fnRK+9+Lt0h6nKu67dbvkqYHjIY+Z1l5XXZPP2QDwVPhqMhn4+FaEwumovN
 ZmnA1Q3MbJ7SuIuDj3K86jH1BH5NOWZ5imAOsa5OYwatDjXxShAn64GGS/6DUi34h51LvEwu9eA
 cr63pjXNBrTe5aCf9l2luRkdQ7rJUydlBCv3ay6iTNuKy4ajxVH6UVioWF8pt9F08V2SadtPLRA
 uv425CORS2Y8YuA==
X-Developer-Key: i=david@ixit.cz; a=openpgp;
 fpr=D77A09CFEEDC2BBD53A7047460023FC4D3492072
X-Endpoint-Received: by B4 Relay for david@ixit.cz/default with auth_id=355
X-Original-From: David Heidelberg <david@ixit.cz>
Reply-To: david@ixit.cz

From: Janne Grunau <j@jannau.net>

The ethernet-controller schema specifies "mac-address" and
"local-mac-address" but other network devices such as wireless network
adapters use mac addresses as well.
The Devicetree Specification, Release v0.3 specifies in section 4.3.1
a generic "Network Class Binding" with "address-bits", "mac-address",
"local-mac-address" and "max-frame-size". This schema specifies the
"address-bits" property and moves the remaining properties over from
the ethernet-controller.yaml schema.

The "max-frame-size" property is used to describe the maximal payload
size despite its name. Keep the description from ethernet-controller
specifying this property as MTU. The contradictory description in the
Devicetree Specification is ignored.

Signed-off-by: Janne Grunau <j@jannau.net>
---
 .../bindings/net/ethernet-controller.yaml          | 25 +-----------
 .../devicetree/bindings/net/network-class.yaml     | 44 ++++++++++++++++++++++
 2 files changed, 45 insertions(+), 24 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/ethernet-controller.yaml b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
index 45819b2358002bc75e876eddb4b2ca18017c04bd..c91b41b83d1dc1294e99ec72c7cdcc16550cb33e 100644
--- a/Documentation/devicetree/bindings/net/ethernet-controller.yaml
+++ b/Documentation/devicetree/bindings/net/ethernet-controller.yaml
@@ -16,30 +16,6 @@ properties:
   label:
     description: Human readable label on a port of a box.
 
-  local-mac-address:
-    description:
-      Specifies the MAC address that was assigned to the network device.
-    $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 6
-    maxItems: 6
-
-  mac-address:
-    description:
-      Specifies the MAC address that was last used by the boot
-      program; should be used in cases where the MAC address assigned
-      to the device by the boot program is different from the
-      local-mac-address property.
-    $ref: /schemas/types.yaml#/definitions/uint8-array
-    minItems: 6
-    maxItems: 6
-
-  max-frame-size:
-    $ref: /schemas/types.yaml#/definitions/uint32
-    description:
-      Maximum transfer unit (IEEE defined MTU), rather than the
-      maximum frame size (there\'s contradiction in the Devicetree
-      Specification).
-
   max-speed:
     $ref: /schemas/types.yaml#/definitions/uint32
     description:
@@ -262,6 +238,7 @@ dependencies:
   pcs-handle-names: [pcs-handle]
 
 allOf:
+  - $ref: /schemas/net/network-class.yaml#
   - if:
       properties:
         phy-mode:
diff --git a/Documentation/devicetree/bindings/net/network-class.yaml b/Documentation/devicetree/bindings/net/network-class.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..e126a02193e8cfba24215d3c850fde1e1b26480e
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/network-class.yaml
@@ -0,0 +1,44 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/network-class.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Network Class Common Properties
+
+maintainers:
+  - Devicetree Specification Mailing List <devicetree-spec-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
+
+properties:
+  address-bits:
+    description:
+      Specifies number of address bits required to address the device described
+      by this node. This property specifies number of bits in MAC address.
+    default: 48
+    const: 48
+
+  local-mac-address:
+    description:
+      Specifies MAC address that was assigned to the network device described by
+      the node containing this property.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 6
+    maxItems: 6
+
+  mac-address:
+    description:
+      Specifies the MAC address that was last used by the boot program. This
+      property should be used in cases where the MAC address assigned to the
+      device by the boot program is different from the
+      local-mac-address property. This property shall be used only if the value
+      differs from local-mac-address property value.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 6
+    maxItems: 6
+
+  max-frame-size:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description:
+      Maximum transfer unit (IEEE defined MTU).
+
+additionalProperties: true

-- 
2.49.0



