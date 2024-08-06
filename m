Return-Path: <linux-wireless+bounces-11036-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44A7D949668
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 19:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91891B2B0C3
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Aug 2024 17:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D599178380;
	Tue,  6 Aug 2024 17:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="O1aAvY4b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44371175D5D;
	Tue,  6 Aug 2024 17:02:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722963722; cv=none; b=KDnmNGvY2H6dELqTkK/YO8yw6h/NtMBilpWj0nQQ0N7F5uA8JhPtZyXe5SEjdSSZk/gHWmJOXRQHwpqapXe4SK9DTv6APY4HRFb7h13la7B3MSthXJagbATs1j5YR5M+A0ETS71C3BDxAsCKy4DeYdWig0Jz0xvvvRYu6jys+1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722963722; c=relaxed/simple;
	bh=J0nkddXTq8UbBbnn7LdzSPXG8x1mRzcQEqfqo96r8rY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XjzTFbNvuz64d2Ou5MqUhF5s1ksgflifB3lP/3oMxa8ffWU2kZ8cs1dLLFsZZIrdlTDeR07Zjd+Wa92k7k2YJ4DzadztZjs37gL6VFxCz3dSfH755l2Do/nSHZs/eJqJcLOxviENRzoBZGsJAwhVtT5LUcbyqzCwrLhV+cM4NzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=O1aAvY4b; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 476H1qDq055351;
	Tue, 6 Aug 2024 12:01:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1722963712;
	bh=JyXcTvEw/pzgeDH2+1Argds+FcQPaqNw9s6zMo1fbhg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=O1aAvY4b0W0XnSRuIpZB9eBULycS1WIa2Tqs4Aoex/p3FL64tWrO6Oa+KCIVxYAJW
	 SeuRf5WTZiNEieC4lHjJzJpZcBQAfrJeCPepCAGbf6jQh8OF0LutM4e0n1WAqg2vg3
	 +njOlvJPOtguEyR8MdzUJ2L3XpqTTbu2vJqYxyhY=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 476H1pCG090738
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Aug 2024 12:01:52 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Aug 2024 12:01:51 -0500
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Aug 2024 12:01:51 -0500
Received: from localhost (udb0389739.dhcp.ti.com [137.167.1.149])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 476H1oDD039255;
	Tue, 6 Aug 2024 12:01:51 -0500
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
Subject: [PATCH v3 17/17] dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml
Date: Tue, 6 Aug 2024 20:00:18 +0300
Message-ID: <20240806170018.638585-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240806170018.638585-1-michael.nemanov@ti.com>
References: <20240806170018.638585-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

Add device-tree bindings for the CC33xx family.

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 .../bindings/net/wireless/ti,cc33xx.yaml      | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
new file mode 100644
index 000000000000..402ff7ec9239
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
@@ -0,0 +1,56 @@
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
+  compatible:
+    enum:
+      - ti,cc3300
+      - ti,cc3301
+      - ti,cc3350
+      - ti,cc3351
+
+  reg:
+    description:
+      must be set to 2
+    maxItems: 1
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
+    // SDIO example:
+    mmc {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        wifi@1{
+            compatible = "ti,cc3300";
+            reg = <2>;
+            interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
-- 
2.34.1


