Return-Path: <linux-wireless+bounces-8737-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DD39017C5
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 20:28:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FA801F211C7
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Jun 2024 18:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792C381720;
	Sun,  9 Jun 2024 18:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="rff9nvNV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF1E7BAEC;
	Sun,  9 Jun 2024 18:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.249
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717957386; cv=none; b=Kzguc7dr5JW88w5rVM9tGYEkhcuIKA40PtQ4AmJ+F66nvTERao0PQP8vL5zgU35a7joO7fK//4Taj1I/Nrqt3Y0UF7BsqJjvvKcknCeIIUVfKHT07RpW6kXxxwhnAUHn2jEFlJ74sFczYvKmwvdgo5byJ+eQJzMZ2iEHQEwc2XI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717957386; c=relaxed/simple;
	bh=nLAtyX+sMSNLownEsioM+2H9J5TUgvIY4KOtJTk8Pxs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fObeJGuLhPormpHPxo5l77INfkUcAadi4RjiVPIegaHcv7RT0WUT29KaNNnabBp5SKm3EfYy28aPb/57rq3SdQvdQYmAaxe1PWPfpLzf9W8zsRwmTMJfyt+QXaNz9Z+irnGHtrkDt25cmYzHzuZZitFMZLpTThv0k8XYcAtRcKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=rff9nvNV; arc=none smtp.client-ip=198.47.23.249
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 459IMtrj004420;
	Sun, 9 Jun 2024 13:22:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1717957375;
	bh=TrImBSsj42vjw87Hnv20IUv4a+9OWTACR1LYASuI6bg=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=rff9nvNVVzK6oz5P35U29agvUk8OblVn7Dne0asvSQwJZgo7osCX30SgthwKk8fyy
	 lHsa5Q9WKBVDvq/vpl/tgBNNJANbGGa5P+0qgvz53rB/LlExKfVl+Z+E5Kxub5mMi3
	 FM7X+ESMTJBHrdqyjffYY6FoHD+EtbY6E7iBLrWg=
Received: from DFLE113.ent.ti.com (dfle113.ent.ti.com [10.64.6.34])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 459IMt0c035597
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 9 Jun 2024 13:22:55 -0500
Received: from DFLE111.ent.ti.com (10.64.6.32) by DFLE113.ent.ti.com
 (10.64.6.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Sun, 9
 Jun 2024 13:22:55 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE111.ent.ti.com
 (10.64.6.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Sun, 9 Jun 2024 13:22:55 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 459IMs4t034809;
	Sun, 9 Jun 2024 13:22:55 -0500
From: <michael.nemanov@ti.com>
To: Sabeeh Khan <sabeeh-khan@ti.com>, Kalle Valo <kvalo@kernel.org>,
        Johannes
 Berg <johannes.berg@intel.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo
 Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Michael Nemanov
	<michael.nemanov@ti.com>
Subject: [PATCH v2 17/17] dt-bindings: net: wireless: cc33xx: Add ti,cc33xx.yaml
Date: Sun, 9 Jun 2024 21:21:02 +0300
Message-ID: <20240609182102.2950457-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240609182102.2950457-1-michael.nemanov@ti.com>
References: <20240609182102.2950457-1-michael.nemanov@ti.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

From: Michael Nemanov <michael.nemanov@ti.com>

---
 .../bindings/net/wireless/ti,cc33xx.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
new file mode 100644
index 000000000000..08ab2ed93dba
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
@@ -0,0 +1,60 @@
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
+  These are dt entries for the IEEE 802.11ax chips CC33xx from Texas Instruments.
+  Currently, these chips must be connected via SDIO.
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
+      For WLAN communication, <reg> must be set to 2.
+    maxItems: 1
+
+  interrupts:
+    description: The interrupt line. Can be IRQ_TYPE_EDGE_RISING or IRQ_TYPE_LEVEL_HIGH.
+      When SDIO is used, the "in-band" interrupt provided by the SDIO bus is used
+      unless an interrupt is defined in the Device Tree.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    // SDIO example:
+    mmc3 {
+        vmmc-supply = <&wlan_en_reg>;
+        bus-width = <4>;
+        cap-power-off-card;
+        keep-power-in-suspend;
+
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        cc33xx: cc33xx@0 {
+            compatible = "ti,cc3300";
+            reg = <2>;
+            interrupts = <19 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
-- 
2.25.1


