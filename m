Return-Path: <linux-wireless+bounces-20529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49FFBA685F6
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 08:43:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7908A189034D
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Mar 2025 07:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 900142505B8;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pONK8WM0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5933C16E863;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742370178; cv=none; b=HqYR+9zmJCZQv7kiK4A5N+IZxI8+X1bzrIQcHgvYJIY5LE7niqarXnAUXYDqVjL4B7Ue6MvL2+hGdCDeknVeMYbQQB9LZhzSrltmYEwuIyrRkuGyQG5f4J4je/G+f6epVeHeHli+fKaB+585ms03pBeDzhRyCy/wCB+i2qBHWTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742370178; c=relaxed/simple;
	bh=y6AwICu+KnCoslrMZrU1Jw3LN91sB/Dq5A7R2CbF414=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ARA5GAJ8Zj7zcI8uO1EAdJa9neRKyLbaVTMlNQowafgXnewctDY9NhIfeDFeeo6252GSE217fOr6U5m5SxzbvPVUtOSU1LFDhisKkoTUFQTzd58bv7+TP14Vv3UF92jzVMLyIRIVpxlqrvkxFeINyDiTzoNOiSBny2BEu0eVfzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pONK8WM0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 27B4AC4CEEA;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742370178;
	bh=y6AwICu+KnCoslrMZrU1Jw3LN91sB/Dq5A7R2CbF414=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=pONK8WM0I4MlCSPBUoMwh+nprIYj7PsBjujfLE8/DfHIfvsZ8Et0JHH/L4TKDI7eC
	 bARezvNEHQ4l7jmQSaZ+roTaBdTG4ejlfg4aIPU4zD0WccNjUzJYbYhDoZvYVo9W2/
	 9sqQBNhmtSDt9xvvXQTa2L//6a4LYz6/5aT1g9xNjBRmCcpxS9dkNnkURmuCV6Ea47
	 k8K6qCH+UrpL5FJxbhupaJ1RbPjs6RxGOJqCyJFXgidRUpmEHgmQL7dzhQ/lErNJfq
	 l7Ay5mqn/SdZ9pr3MHMfjcHz9Md3e5emcsoYCEqyNWJ4/c64NOSBSMotIvsXRdkZzm
	 kEXA06XmU4CTA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12FCDC28B28;
	Wed, 19 Mar 2025 07:42:58 +0000 (UTC)
From: David Heidelberg via B4 Relay <devnull+david.ixit.cz@kernel.org>
Date: Wed, 19 Mar 2025 08:42:46 +0100
Subject: [PATCH v4 1/5] dt-bindings: net: Add network-class schema for
 mac-address properties
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250319-dt-bindings-network-class-v4-1-2329336802b4@ixit.cz>
References: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
In-Reply-To: <20250319-dt-bindings-network-class-v4-0-2329336802b4@ixit.cz>
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
 Konrad Dybcio <konradybcio@kernel.org>, Andy Gross <agross@kernel.org>, 
 Mailing List <devicetree-spec@vger.kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, Janne Grunau <j@jannau.net>, 
 David Heidelberg <david@ixit.cz>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4552; i=david@ixit.cz;
 h=from:subject:message-id;
 bh=BKNeFwL3FQz2qg0ubOyl0m0TjIVlXMOiIVHwC04dGGA=;
 b=owEBbQKS/ZANAwAIAWACP8TTSSByAcsmYgBn2nV+VWCI3EUkh2oTdBKoTBm/gUSMo17TBRfM7
 cSoswg19jWJAjMEAAEIAB0WIQTXegnP7twrvVOnBHRgAj/E00kgcgUCZ9p1fgAKCRBgAj/E00kg
 cpMVEACY6xWeHma4WkkyZ3nLUE7pYdlk+YItmt+9Dh9SU3H62pnERgAtP5ZNLus8ai5BZGXKDya
 W3gRuMAvvwaUjpWit4hV6OPT3Krzb/677m24NwSz5T4yVZoeYfYGQyuIExmwiFTjCJB2glaH6li
 xLhG+54mPcJim5u9jT/TRIQfj6d6j3vd/BunxQerZNrR/6UCTNUrI6r8TNJaV3i5YqfwIEbUOll
 1KlMEQf66Vp41h54FWqfCxE0cCfpouF/9NUHESm6CaTmkTCBx/RNsD2Qg2ESddQCcs7anlYZfqs
 fRFuS2ojJWWeJkTDa+nnHZ79lJkNstuNDg5Xpam/fpj6ue27W0aPoxirKUL5sgMCw1/TQjV2Fpo
 MkP2HKug/ryO40YAE11GuNvh5AmS3bCKqkP1nh/xvP7kLd05ljPDXUIxarDcB89MK2itc1x2yCb
 ftSBmlLZfGnANS3oAC9bMF97P+x+qxCCvbB8fBdgpZNCFg/OaRq6OsEoaElGobmYhbegVMP3/XM
 CudfFiOIplbgYBP5yPb0OVrNg2SvXpTH/1fSCt9zb+FRQq+UqOI1WV8/OZV+LoGA2EodjDaxsVe
 SodNI9Ot9Sujr97PSS8RuaszWRDZjT48gSXPb5Aa9ILlXlbX8ReJ0I4ijXOn1r92Y4tLEefUFMW
 lyNFW4Ge0gBJJhg==
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
 .../devicetree/bindings/net/network-class.yaml     | 47 ++++++++++++++++++++++
 2 files changed, 48 insertions(+), 24 deletions(-)

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
index 0000000000000000000000000000000000000000..e0b3ed3fd3f13d94a214cf9a4bb474d1abcca2b1
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/network-class.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/network-class.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Network Class Common Properties
+
+maintainers:
+  - Devicetree Specification Mailing List <devicetree-spec@vger.kernel.org>
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
+      Maximum transfer unit (IEEE defined MTU), rather than the
+      maximum frame size (there\'s contradiction in the Devicetree
+      Specification).
+
+
+additionalProperties: true

-- 
2.49.0



