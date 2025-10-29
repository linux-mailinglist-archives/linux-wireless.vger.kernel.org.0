Return-Path: <linux-wireless+bounces-28360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D307C1B88F
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 16:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0716E5C0C28
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Oct 2025 14:27:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA912D0602;
	Wed, 29 Oct 2025 14:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HWOzqi9B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41CE2BEC30;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761748000; cv=none; b=kItTT8gjiLXIct+mad4vylnpgpI5aCvkBW9k1COMCW6xIxKn4mpXQrFYPpF2PWC3o1I8RlNaRZLOl8yqKe4oTCeN3n5lwGf233ut3Wdc4Rh7un30bDi13VMVx/zDiE2GTo7XbSepaGAING2u1rSFY0JKO/jDu2fhikBtMqC31Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761748000; c=relaxed/simple;
	bh=uAFaddzt+o5Jaxvpc4u0qmiEWtTqty66JcCDtI2hth0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=L2xr2o1SNHTAKyh9xRiX0nWPvmBkm7B4dtMvZqJ32QlXc0AYq4wEdB7XPrBl0jYctZBfhq3UxpgoJMVK4IOdJTjAzJhyedDEUzZTypagkk6AGU8GBcwEZBKbNrV1Dia1VBw/inoik0JkpSKV4qccEE9IwEkUFFFpx43TxVF4Pqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HWOzqi9B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63B83C4CEFF;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761748000;
	bh=uAFaddzt+o5Jaxvpc4u0qmiEWtTqty66JcCDtI2hth0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=HWOzqi9Bxd3FHXRdr4CFX8V6rgdrLULLiUfNUWKA/TnH4K7W3ygUUHvKfbUvD0n9F
	 BCqxIgLQ5YSqLKGJhQfVffKJlhU2lixUy0mBbkq0/UKfTw/NuFGQ8B65RAom6Sig3Z
	 tp96yXpR5vz77Jf/I2EgXD8p8E1XS1NZjwe54BV0an2KV/zmTIKukPEWHUD8dTxCEZ
	 WfgUvcP9Wij5fM8zSwBTtY8dgXuGFfMMlb7Kr5LUrp2YlE8s3gPo8dBO9ZTPaMxAze
	 CWuUOXbOe7cIILBSW/Gnwl00ScbPjNsMYHG2PS5XsalV1tW11ELXqmwjrb4ZdmBoAD
	 1jUDYwUg4e4VQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A06FCCF9EB;
	Wed, 29 Oct 2025 14:26:40 +0000 (UTC)
From: George Moussalem via B4 Relay <devnull+george.moussalem.outlook.com@kernel.org>
Date: Wed, 29 Oct 2025 18:26:22 +0400
Subject: [PATCH 1/6] dt: bindings: net: add bindings for QCN6122
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251029-ath11k-qcn6122-v1-1-58ed68eba333@outlook.com>
References: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
In-Reply-To: <20251029-ath11k-qcn6122-v1-0-58ed68eba333@outlook.com>
To: Johannes Berg <johannes@sipsolutions.net>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jeff Johnson <jjohnson@kernel.org>
Cc: linux-wireless@vger.kernel.org, devicetree@vger.kernel.org, 
 ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
 George Moussalem <george.moussalem@outlook.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761747997; l=4199;
 i=george.moussalem@outlook.com; s=20250321; h=from:subject:message-id;
 bh=8oCgkx2tBE/XoLjt2QmaWVlpynCUGOtanyX8ad9w9XQ=;
 b=+Lg/GmnlljSyRRhc0gmBi4zkwu92ultczCM8t+AFO50E/X2H02QHzXOZ5sQq/NWMTJ4ecsWAg
 BpYCx8WZCEsAmjBNYcHAARzuXPOGOojbgr8hchE+sS28bDo9FeHSEGM
X-Developer-Key: i=george.moussalem@outlook.com; a=ed25519;
 pk=/PuRTSI9iYiHwcc6Nrde8qF4ZDhJBlUgpHdhsIjnqIk=
X-Endpoint-Received: by B4 Relay for george.moussalem@outlook.com/20250321
 with auth_id=364
X-Original-From: George Moussalem <george.moussalem@outlook.com>
Reply-To: george.moussalem@outlook.com

From: George Moussalem <george.moussalem@outlook.com>

QCN6122 is a PCIe based solution that is attached to and enumerated
by the WPSS (Wireless Processor SubSystem) Q6 processor.

Though it is a PCIe device, since it is not attached to APSS processor
(Application Processor SubSystem), APSS will be unaware of such a decice
so it is registered to the APSS processor as a platform device(AHB).
Because of this hybrid nature, it is called as a hybrid bus device as
introduced by WCN6750. It has 5 CE and 8 DP rings.

QCN6122 is similar to WCN6750 and follows the same codepath as for
WCN6750.

Signed-off-by: George Moussalem <george.moussalem@outlook.com>
---
 .../bindings/net/wireless/qcom,ath11k.yaml         | 57 +++++++++++++++++++++-
 1 file changed, 56 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
index c089677702cf17f3016b054d21494d2a7706ce5d..4b0b282bb9231c8bc496fed42e0917b9d7d106d2 100644
--- a/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/qcom,ath11k.yaml
@@ -21,12 +21,13 @@ properties:
       - qcom,ipq6018-wifi
       - qcom,wcn6750-wifi
       - qcom,ipq5018-wifi
+      - qcom,qcn6122-wifi
 
   reg:
     maxItems: 1
 
   interrupts:
-    minItems: 32
+    minItems: 13
     maxItems: 52
 
   interrupt-names:
@@ -87,6 +88,14 @@ properties:
     items:
       - const: wlan-smp2p-out
 
+  qcom,userpd:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2, 3]
+    description: instance ID of user PD (protection domain) in multi-PD
+                 architectures to distinguish between multiple instances
+                 of the same wifi chip used by QMI in its interface with
+                 the firmware running on Q6.
+
 required:
   - compatible
   - reg
@@ -268,6 +277,31 @@ allOf:
             - description: interrupt event for ring DP20
             - description: interrupt event for ring DP21
             - description: interrupt event for ring DP22
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,qcn6122-wifi
+    then:
+      required:
+        - qcom,userpd
+      properties:
+        interrupts:
+          items:
+            - description: interrupt event for ring CE1
+            - description: interrupt event for ring CE2
+            - description: interrupt event for ring CE3
+            - description: interrupt event for ring CE4
+            - description: interrupt event for ring CE5
+            - description: interrupt event for ring DP1
+            - description: interrupt event for ring DP2
+            - description: interrupt event for ring DP3
+            - description: interrupt event for ring DP4
+            - description: interrupt event for ring DP5
+            - description: interrupt event for ring DP6
+            - description: interrupt event for ring DP7
+            - description: interrupt event for ring DP8
 
 examples:
   - |
@@ -467,3 +501,24 @@ examples:
             iommus = <&apps_smmu 0x1c02 0x1>;
         };
     };
+
+  - |
+    wifi1: wifi@b00a040 {
+        reg = <0x0b00a040 0x0>;
+        compatible = "qcom,qcn6122-wifi";
+        interrupts = <GIC_SPI 416 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 417 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 418 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 419 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 420 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 421 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 422 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 423 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 424 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 425 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 426 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 427 IRQ_TYPE_EDGE_RISING>,
+                     <GIC_SPI 428 IRQ_TYPE_EDGE_RISING>;
+        qcom,rproc = <&q6v5_wcss_pd2>;
+        qcom,userpd = <2>;
+    };

-- 
2.51.1



