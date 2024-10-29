Return-Path: <linux-wireless+bounces-14659-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83FD79B5079
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 18:25:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1CE8BB23AC4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 17:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 939C31E883F;
	Tue, 29 Oct 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="XaPHWYss"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6576B2107;
	Tue, 29 Oct 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730222673; cv=none; b=Vvalla6aAvJMlirS7wKQ8y7rVSUrz71PeVbF6wgIxdnKjCch/c8lsEpOszAYJruYSJqsajSp76+X+VQ1K5HOQza1GbIJF8WV3TjlLwDPUTGpUfOChMsWo7tgUa3OWLGGmlF6kfe4GnlhS1eTYx+bBJPMtcZEPzD+EusCdLlkxdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730222673; c=relaxed/simple;
	bh=ZSbUqv0R3XYa2PRtKp3rLaNRaFAjWv3Nm1N/+rXsyKU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raNHRxSI7Mvz3bWpsj7ftO9PWHjz/DsXzbwHH3E7qbLWr5I9sc62RbpPQeaxB5BtuakTeAO97av5uCOV0HayKqg0M7waZu0fQCLYyDcOLux/X/yDs6MXJ5HUTOc/R0d+c1OMIGuiahs62QQ+qFVaIMkf6e48XtpSqc8AElMk4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=XaPHWYss; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 49THONql051035;
	Tue, 29 Oct 2024 12:24:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730222663;
	bh=crQ/89+Q/dU780iNAYsSX7NoS4Jed4NdwXsFTIAKXxg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=XaPHWYssZ/Yvv1EPBKmmeDyWsgjZXIydGxLs8q5H4PVKhL8mTY9KoJ+eS1MgC6Nus
	 rPUaoXOmT3OrerNBsTsjiMmwHWRbLipfbUg8IUPSr0b69xtX9EHOo/rb0N7a5apok6
	 VK3QM9HARAtHxCtYOHgtYta9W0CUI6+vGSwkssck=
Received: from DFLE110.ent.ti.com (dfle110.ent.ti.com [10.64.6.31])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 49THONQF022338
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Oct 2024 12:24:23 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 29
 Oct 2024 12:24:23 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 29 Oct 2024 12:24:23 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 49THOLvV006325;
	Tue, 29 Oct 2024 12:24:22 -0500
From: Michael Nemanov <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-wireless@vger.kernel.org>,
        <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH v4 01/17] dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml
Date: Tue, 29 Oct 2024 19:23:38 +0200
Message-ID: <20241029172354.4027886-2-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241029172354.4027886-1-michael.nemanov@ti.com>
References: <20241029172354.4027886-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

Add device-tree bindings for the CC33xx family.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 .../bindings/net/wireless/ti,cc33xx.yaml      | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
new file mode 100644
index 000000000000..12a0a2f52f44
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/ti,cc33xx.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments CC33xx Wireless LAN Controller
+
+maintainers:
+  - Michael Nemanov <michael.nemanov@ti.com>
+
+description:
+  The CC33xx is a family of IEEE 802.11ax chips from Texas Instruments.
+  These chips must be connected via SDIO and support in-band / out-of-band IRQ.
+
+properties:
+  $nodename:
+    pattern: "^wifi@2"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - ti,cc3300
+              - ti,cc3301
+              - ti,cc3350
+              - ti,cc3351
+          - const: ti,cc33xx
+
+  reg:
+    const: 2
+
+  interrupts:
+    description:
+      The out-of-band interrupt line.
+      Can be IRQ_TYPE_EDGE_RISING or IRQ_TYPE_LEVEL_HIGH.
+      If property is omitted, SDIO in-band IRQ will be used.
+    maxItems: 1
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
+
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@2 {
+            compatible = "ti,cc3300", "ti,cc33xx";
+            reg = <2>;
+            interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
-- 
2.34.1


