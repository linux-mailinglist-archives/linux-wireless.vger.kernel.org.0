Return-Path: <linux-wireless+bounces-15064-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 556CE9C0633
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 13:52:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D34B1F23654
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 12:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A04E20FA9B;
	Thu,  7 Nov 2024 12:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="J4S9hkTU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE60020F5C8;
	Thu,  7 Nov 2024 12:52:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730983967; cv=none; b=XYuK5G920gnG1h22HWpZbD3XLh/3hMakXsPfEHCPsFFU4HJKJwgrb42H64v2qP1rtYGrxuSnBD4gzSNrLBJ9Z+AVl/bYqk4UhkCoro98UJ1V+kWlElb572wEax7mxg/q7WD6ZnSOxn4Iqh+zICdjm/gBrhwzM6e92kgvFGhqBJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730983967; c=relaxed/simple;
	bh=1LPhXNYqqYpRr9qolKY+f18qbAVT2RtF2x3mmk0Nq48=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uNJrXGnx+MxlndjWN57ybUj7ZxoLeMRQ9g1W4Vy40bkzjtKOXduxIvsc006ZTyZLxUekLaJzyxnnrMvqf4MpgdKDTXvtuhuNS5/YULs4sPuDCakQqsCVhUxGLb0j/SDyy+TLnh8uYEP/m/VErAHS0bBjbZt4oVeRVexLjqoPPfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=J4S9hkTU; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 4A7CqccR073781;
	Thu, 7 Nov 2024 06:52:38 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1730983959;
	bh=gTKZ+qBVNvEEQB6fnFwZmJHL8XfxEFTBmWVWVafOYqc=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=J4S9hkTU2lbkoC31+chqFpdVE+1OM6c2/p2VjWANN+IZ6EUYN0nIlH7DMLyIjQlgX
	 1l5wS6x55VvzoAV13NCto1m7HgSSFiJ6CmfX1lRrtbukzbYIm9Uif9kS/dymRLjyjv
	 g2sUrT2Ulblnhdh5NCN13hbJamTwmybtGhxvCDP8=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 4A7Cqcl3116035
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 7 Nov 2024 06:52:38 -0600
Received: from DLEE111.ent.ti.com (157.170.170.22) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 7
 Nov 2024 06:52:38 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE111.ent.ti.com
 (157.170.170.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 7 Nov 2024 06:52:38 -0600
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 4A7CqbYN038352;
	Thu, 7 Nov 2024 06:52:38 -0600
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
Subject: [PATCH v5 01/17] dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml
Date: Thu, 7 Nov 2024 14:51:53 +0200
Message-ID: <20241107125209.1736277-2-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241107125209.1736277-1-michael.nemanov@ti.com>
References: <20241107125209.1736277-1-michael.nemanov@ti.com>
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
index 000000000000..fd6e1ee8426e
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
+      - const: ti,cc3300
+      - items:
+          - enum:
+              - ti,cc3301
+              - ti,cc3350
+              - ti,cc3351
+          - const: ti,cc3300
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
+            compatible = "ti,cc3300";
+            reg = <2>;
+            interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
-- 
2.34.1


