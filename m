Return-Path: <linux-wireless+bounces-7918-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7753E8CB2CA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 19:22:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A301C217F0
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 17:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6E4A14A4EF;
	Tue, 21 May 2024 17:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="BKttZFon"
X-Original-To: linux-wireless@vger.kernel.org
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DE2149DF3;
	Tue, 21 May 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716311975; cv=none; b=IFgSZecPgPQo3VJUqnqqG9i5ZlAVJwuonFvnjdVbWhwFH/0Y74l9rqOYuvnBdxT+CRkJdFzOZcoexYeganYx/NxWCvcTUgjr8VZZTxbcQociWbIW15vcIbrlMKVlnbxRqfcVSCgMH/2MARBbERyyIXEnwnBDef8VxTSIrBm7SPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716311975; c=relaxed/simple;
	bh=H+k5pwMVAH1TrCVZ+UnRjUspzQhspP1lsEjFjjjU2TA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rqsrtz0Lyn3RLLRb9CgSA+BNxGDj9dEJ7yogp46JGmgMljckOWrkYSftbbAZ4pBgB9MkUXZoskxg7Dx7UwK2BbE13Wxmj/eutzcDlKAJBK5mwAHcj2lVyV347b+vB/AFpq3lclLz0UTpAxbwW8sc16WXzufY9tj1ASqxO3SFBkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=BKttZFon; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJKw7096885;
	Tue, 21 May 2024 12:19:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1716311960;
	bh=Bi5+8k3P0V55rdOxPtYkR4ijU3UD3RgqR+lnNSBqfu0=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=BKttZFonPi1Kk6fcQJNScOaq2A42wDNM94pInlpQhb4Kss12Pg9y7GqYNkr82P5Lo
	 fdWNcfxb8PPTA2UlSxtEwHdaY/O83q0g3/JZyHZntjMssvT4tOeeVbCABknbDDzxhk
	 /F0Fa/6DEXcoDGCc47e5ewTKrSh9Gubb2NTPrBoM=
Received: from DFLE100.ent.ti.com (dfle100.ent.ti.com [10.64.6.21])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 44LHJKCW015211
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 May 2024 12:19:20 -0500
Received: from DFLE112.ent.ti.com (10.64.6.33) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 21
 May 2024 12:19:20 -0500
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 21 May 2024 12:19:20 -0500
Received: from localhost (uda0389739.dhcp.ti.com [137.167.1.114])
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 44LHJJq5023637;
	Tue, 21 May 2024 12:19:20 -0500
From: <michael.nemanov@ti.com>
To: Kalle Valo <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
        Breno Leitao <leitao@debian.org>,
        Justin Stitt <justinstitt@google.com>,
        Kees
 Cook <keescook@chromium.org>, <linux-wireless@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: Sabeeh Khan <sabeeh-khan@ti.com>, Michael Nemanov <michael.nemanov@ti.com>
Subject: [PATCH 17/17] Add ti,cc33xx.yaml
Date: Tue, 21 May 2024 20:18:41 +0300
Message-ID: <20240521171841.884576-18-michael.nemanov@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240521171841.884576-1-michael.nemanov@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
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

Signed-off-by: Michael Nemanov <michael.nemanov@ti.com>
---
 .../bindings/net/wireless/ti,cc33xx.yaml      | 60 +++++++++++++++++++
 1 file changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml b/Documentation/devicetree/bindings/net/wireless/ti,cc33xx.yaml
new file mode 100644
index 000000000000..342e4e59d4cf
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


