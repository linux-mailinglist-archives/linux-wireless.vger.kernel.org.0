Return-Path: <linux-wireless+bounces-17145-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 052E1A04005
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 13:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACF191888BE1
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 12:56:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE5E71EF093;
	Tue,  7 Jan 2025 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xPWsWKaQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261741F03E9
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 12:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736254585; cv=none; b=M1vUlpFjKTkt2jHjxVclS42pmhAGC3Q8fzHhmBqhLQrprW+TRIvFuGrXMr5eNEdESDU4E+ef9Q9+v8sHONJwPlUn+XxlwryVnRVuz5GF0xFTHBD+6pqEtkGBfNO8D+XWOazN17ULaBsag877zfbWo3IRg6FgX/6rgzggUkTwAk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736254585; c=relaxed/simple;
	bh=gpScx0BWvs2kzof7nhbX3G8y/7tcGnMeE8NgEC6P4xM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fC+Pg713yeugxrfrDdZ4zeXM7ShAOVHGwyH2r8BzBz0zhn8rw4jF+41NuGB7qawYomOQCWMVsMOXrUbBpBQMcC06mt6zqFxW8vKJvG8Z61ldO+YuYBUxOUDNT6U1MDLLgpiudR6mW1CDzlxrTon9ye2rADpGL+RK4ZoKU4YMyzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xPWsWKaQ; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-3862e2c9bb5so736637f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Jan 2025 04:56:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1736254578; x=1736859378; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SSJv9cd7B+Ts5chgbSK94dYazJRqIDFOFvz1Ru/QShk=;
        b=xPWsWKaQEC0OzdXImpped62pArFpBkLC1/4PHFgrMDsbE/MGXp0b/v0OZZOV9+IJYz
         DQP9vlpklb6lX87nYYjrd09zQUFEHnxUiGJLqEr3JNUYn3dkNa73RvoL+movbtBwtSHh
         6qOoG9H3T+fckWmWYRjO/ruMKo/nGEddRuBU7fP9VY8wJsWQ//5NwM5WyIjOUiBosOSr
         nlJH5VyDyerrJpQOzHsdCqOaZPiPxol6MpBRERrAKts0oFWocaC/HxotABI//ElPjoGk
         WE6gZhEbJcqmJd14WbSYKhYRWRmlDX0du1T4A26NQWUthKvaJIs4za0CFI0yH+hehSU7
         6IkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736254578; x=1736859378;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SSJv9cd7B+Ts5chgbSK94dYazJRqIDFOFvz1Ru/QShk=;
        b=BhDh2rXew80KskQUtb1pQH8/DWQjtnwMVy3GTZettz5XhK9zgoV4vbNd4vUWunihX+
         R47fbpdGlF8A22d3KCAud0hd6tRPNzDiwDM3nbjqmh8nWwb0DePPedEw2FRSOrinCAqC
         t2QZSKif5bShMT7KAuiO8HmvRUFK+BP6Wblj8akfBJL27GpZdd5rUjkXba26XDTermUT
         Ixd9RxtbdS6lvi7o0KbrG+NujHuBRgSLT1rxMiHiKc/mg/l0vz4qrLkMx3J0d09uFONz
         Q+0vTBE+j9Lmdc+vvPMMncY/YsfmVobmM++lA2YDgJ/H5pXw3jYJdne1ROpRCRm8eEUn
         t1NA==
X-Forwarded-Encrypted: i=1; AJvYcCUHzga2fqUBl8qtwEvfxO4m2dpbrnSStkqT7RlkmABIekSMEusDD5aQXomkyMkDcvc5nFR2VMEvl0OzRB4REA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzXVPU9om7lkqngob84ARSs1dz4+k0PHaVr+GPu/A4Fcfvwp50s
	pkBW1eEI+X6+8/z88+3tXlC43g9BLOnPCE9GB0Np7a41g1Zg974DoMV8aTASkBI=
X-Gm-Gg: ASbGnctb49dC2GNmGU/HlzUW8f3QHE/lYK5wkbt/I8iBltKWCJu5KhH2vONrXwwcb3W
	tTy3+Z5GtPiwlmoeYMufzRCxNjpq53DbcTS6unCZC7xXHf6bXLzwu7fIiP/X5i6kuPPmrcG6uXD
	dE7ZJtBq+0C3M4SmI4aIZwtBDifb9fE4wZPWOUjH99toAoug9FT+0eEDMKZWQlOngkMrNVp5Qan
	LzQmwc603n5N3Qu53Q/ey/XoUmTsd3g/8gOw7+eReaswena0IXsxPUcrOgxrl9DVotslfY=
X-Google-Smtp-Source: AGHT+IGFEJdX3s3JzkTAxu1HuQQv34HUHDN0bVD1EDnfGo+xIctyAQDkT+Ihr//lYJ/3ypgD4WRiww==
X-Received: by 2002:a05:6000:1a8f:b0:382:41ad:d8e1 with SMTP id ffacd0b85a97d-38a223f9c1dmr20778414f8f.14.1736254578226;
        Tue, 07 Jan 2025 04:56:18 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.165])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c847263sm50118575f8f.50.2025.01.07.04.56.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 04:56:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Kalle Valo <kvalo@kernel.org>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Dario Binacchi <dariobin@libero.it>,
	Christophe Roullier <christophe.roullier@foss.st.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	Siddharth Vadapalli <s-vadapalli@ti.com>,
	Roger Quadros <rogerq@kernel.org>,
	Brian Norris <briannorris@chromium.org>,
	Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-can@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-wireless@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH net-next] dt-bindings: net: Correct indentation and style in DTS example
Date: Tue,  7 Jan 2025 13:56:13 +0100
Message-ID: <20250107125613.211478-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DTS example in the bindings should be indented with 2- or 4-spaces and
aligned with opening '- |', so correct any differences like 3-spaces or
mixtures 2- and 4-spaces in one binding.

No functional changes here, but saves some comments during reviews of
new patches built on existing code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/net/amlogic,meson-dwmac.yaml     | 14 +--
 .../devicetree/bindings/net/asix,ax88178.yaml |  4 +-
 .../bindings/net/brcm,bcmgenet.yaml           | 32 +++----
 .../bindings/net/brcm,mdio-mux-iproc.yaml     | 46 ++++-----
 .../bindings/net/can/bosch,c_can.yaml         | 10 +-
 .../bindings/net/can/microchip,mcp2510.yaml   | 18 ++--
 .../devicetree/bindings/net/stm32-dwmac.yaml  | 94 +++++++++----------
 .../bindings/net/ti,davinci-mdio.yaml         | 10 +-
 .../bindings/net/ti,k3-am654-cpsw-nuss.yaml   | 20 ++--
 .../bindings/net/ti,k3-am654-cpts.yaml        | 36 +++----
 .../bindings/net/wireless/marvell,sd8787.yaml | 17 ++--
 11 files changed, 150 insertions(+), 151 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
index d1e2bca3c503..798a4c19f18c 100644
--- a/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/amlogic,meson-dwmac.yaml
@@ -166,11 +166,11 @@ unevaluatedProperties: false
 examples:
   - |
     ethmac: ethernet@c9410000 {
-         compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
-         reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
-         interrupts = <8>;
-         interrupt-names = "macirq";
-         clocks = <&clk_eth>, <&clk_fclk_div2>, <&clk_mpll2>, <&clk_fclk_div2>;
-         clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
-         phy-mode = "rgmii";
+        compatible = "amlogic,meson-gxbb-dwmac", "snps,dwmac";
+        reg = <0xc9410000 0x10000>, <0xc8834540 0x8>;
+        interrupts = <8>;
+        interrupt-names = "macirq";
+        clocks = <&clk_eth>, <&clk_fclk_div2>, <&clk_mpll2>, <&clk_fclk_div2>;
+        clock-names = "stmmaceth", "clkin0", "clkin1", "timing-adjustment";
+        phy-mode = "rgmii";
     };
diff --git a/Documentation/devicetree/bindings/net/asix,ax88178.yaml b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
index 768504ccbf74..03341b7438d5 100644
--- a/Documentation/devicetree/bindings/net/asix,ax88178.yaml
+++ b/Documentation/devicetree/bindings/net/asix,ax88178.yaml
@@ -63,8 +63,8 @@ examples:
             #size-cells = <0>;
 
             ethernet@1 {
-               compatible = "usbb95,772b";
-               reg = <1>;
+                compatible = "usbb95,772b";
+                reg = <1>;
             };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml b/Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
index 7c90a4390531..0e3fb4e42e3f 100644
--- a/Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,bcmgenet.yaml
@@ -85,16 +85,16 @@ examples:
         #size-cells = <1>;
 
         mdio0: mdio@e14 {
-           compatible = "brcm,genet-mdio-v4";
-           #address-cells = <1>;
-           #size-cells = <0>;
-           reg = <0xe14 0x8>;
+            compatible = "brcm,genet-mdio-v4";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0xe14 0x8>;
 
-           phy1: ethernet-phy@1 {
+            phy1: ethernet-phy@1 {
                 max-speed = <1000>;
                 reg = <1>;
                 compatible = "ethernet-phy-ieee802.3-c22";
-           };
+            };
         };
     };
 
@@ -110,10 +110,10 @@ examples:
         interrupts = <0x0 0x16 0x0>, <0x0 0x17 0x0>;
 
         mdio1: mdio@e14 {
-           compatible = "brcm,genet-mdio-v4";
-           #address-cells = <1>;
-           #size-cells = <0>;
-           reg = <0xe14 0x8>;
+            compatible = "brcm,genet-mdio-v4";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0xe14 0x8>;
         };
     };
 
@@ -129,15 +129,15 @@ examples:
         interrupts = <0x0 0x18 0x0>, <0x0 0x19 0x0>;
 
         mdio2: mdio@e14 {
-           compatible = "brcm,genet-mdio-v4";
-           #address-cells = <1>;
-           #size-cells = <0>;
-           reg = <0xe14 0x8>;
+            compatible = "brcm,genet-mdio-v4";
+            #address-cells = <1>;
+            #size-cells = <0>;
+            reg = <0xe14 0x8>;
 
-           phy0: ethernet-phy@0 {
+            phy0: ethernet-phy@0 {
                 max-speed = <1000>;
                 reg = <0>;
                 compatible = "ethernet-phy-ieee802.3-c22";
-           };
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.yaml b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.yaml
index af96b4fd89d5..3f27746d9a56 100644
--- a/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.yaml
+++ b/Documentation/devicetree/bindings/net/brcm,mdio-mux-iproc.yaml
@@ -38,43 +38,43 @@ unevaluatedProperties: false
 
 examples:
   - |
-    mdio_mux_iproc: mdio-mux@66020000 {
+    mdio-mux@66020000 {
         compatible = "brcm,mdio-mux-iproc";
         reg = <0x66020000 0x250>;
         #address-cells = <1>;
         #size-cells = <0>;
 
         mdio@0 {
-           reg = <0x0>;
-           #address-cells = <1>;
-           #size-cells = <0>;
+            reg = <0x0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-           pci_phy0: pci-phy@0 {
-              compatible = "brcm,ns2-pcie-phy";
-              reg = <0x0>;
-              #phy-cells = <0>;
-           };
+            pci-phy@0 {
+                compatible = "brcm,ns2-pcie-phy";
+                reg = <0x0>;
+                #phy-cells = <0>;
+            };
         };
 
         mdio@7 {
-           reg = <0x7>;
-           #address-cells = <1>;
-           #size-cells = <0>;
+            reg = <0x7>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-           pci_phy1: pci-phy@0 {
-              compatible = "brcm,ns2-pcie-phy";
-              reg = <0x0>;
-              #phy-cells = <0>;
-           };
+            pci-phy@0 {
+                compatible = "brcm,ns2-pcie-phy";
+                reg = <0x0>;
+                #phy-cells = <0>;
+            };
         };
 
         mdio@10 {
-           reg = <0x10>;
-           #address-cells = <1>;
-           #size-cells = <0>;
+            reg = <0x10>;
+            #address-cells = <1>;
+            #size-cells = <0>;
 
-           gphy0: eth-phy@10 {
-              reg = <0x10>;
-           };
+            eth-phy@10 {
+                reg = <0x10>;
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/can/bosch,c_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,c_can.yaml
index 4d7d67ee175a..ff1b59a0294e 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,c_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,c_can.yaml
@@ -99,11 +99,11 @@ examples:
     #include <dt-bindings/reset/altr,rst-mgr.h>
 
     can@ffc00000 {
-       compatible = "bosch,d_can";
-       reg = <0xffc00000 0x1000>;
-       interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
-       clocks = <&can0_clk>;
-       resets = <&rst CAN0_RESET>;
+        compatible = "bosch,d_can";
+        reg = <0xffc00000 0x1000>;
+        interrupts = <0 131 4>, <0 132 4>, <0 133 4>, <0 134 4>;
+        clocks = <&can0_clk>;
+        resets = <&rst CAN0_RESET>;
     };
   - |
     can@0 {
diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
index db446dde6842..e0ec53bc10c6 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
@@ -56,15 +56,15 @@ examples:
         #size-cells = <0>;
 
         can@1 {
-             compatible = "microchip,mcp2515";
-             reg = <1>;
-             clocks = <&clk24m>;
-             interrupt-parent = <&gpio4>;
-             interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
-             vdd-supply = <&reg5v0>;
-             xceiver-supply = <&reg5v0>;
-             gpio-controller;
-             #gpio-cells = <2>;
+            compatible = "microchip,mcp2515";
+            reg = <1>;
+            clocks = <&clk24m>;
+            interrupt-parent = <&gpio4>;
+            interrupts = <13 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&reg5v0>;
+            xceiver-supply = <&reg5v0>;
+            gpio-controller;
+            #gpio-cells = <2>;
         };
     };
 
diff --git a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
index bf23838fe6e8..85cea9966a27 100644
--- a/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/stm32-dwmac.yaml
@@ -154,56 +154,56 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/clock/stm32mp1-clks.h>
     //Example 1
-     ethernet0: ethernet@5800a000 {
-           compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
-           reg = <0x5800a000 0x2000>;
-           reg-names = "stmmaceth";
-           interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
-           interrupt-names = "macirq";
-           clock-names = "stmmaceth",
-                     "mac-clk-tx",
-                     "mac-clk-rx",
-                     "ethstp",
-                     "eth-ck";
-           clocks = <&rcc ETHMAC>,
-                <&rcc ETHTX>,
-                <&rcc ETHRX>,
-                <&rcc ETHSTP>,
-                <&rcc ETHCK_K>;
-           st,syscon = <&syscfg 0x4>;
-           snps,pbl = <2>;
-           snps,axi-config = <&stmmac_axi_config_0>;
-           snps,tso;
-           phy-mode = "rgmii";
-       };
+    ethernet0: ethernet@5800a000 {
+        compatible = "st,stm32mp1-dwmac", "snps,dwmac-4.20a";
+        reg = <0x5800a000 0x2000>;
+        reg-names = "stmmaceth";
+        interrupts = <GIC_SPI 61 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "macirq";
+        clock-names = "stmmaceth",
+                      "mac-clk-tx",
+                      "mac-clk-rx",
+                      "ethstp",
+                      "eth-ck";
+        clocks = <&rcc ETHMAC>,
+                 <&rcc ETHTX>,
+                 <&rcc ETHRX>,
+                 <&rcc ETHSTP>,
+                 <&rcc ETHCK_K>;
+        st,syscon = <&syscfg 0x4>;
+        snps,pbl = <2>;
+        snps,axi-config = <&stmmac_axi_config_0>;
+        snps,tso;
+        phy-mode = "rgmii";
+    };
 
   - |
     //Example 2 (MCU example)
-     ethernet1: ethernet@40028000 {
-           compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
-           reg = <0x40028000 0x8000>;
-           reg-names = "stmmaceth";
-           interrupts = <0 61 0>, <0 62 0>;
-           interrupt-names = "macirq", "eth_wake_irq";
-           clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
-           clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
-           st,syscon = <&syscfg 0x4>;
-           snps,pbl = <8>;
-           snps,mixed-burst;
-           phy-mode = "mii";
-       };
+    ethernet1: ethernet@40028000 {
+        compatible = "st,stm32-dwmac", "snps,dwmac-3.50a";
+        reg = <0x40028000 0x8000>;
+        reg-names = "stmmaceth";
+        interrupts = <0 61 0>, <0 62 0>;
+        interrupt-names = "macirq", "eth_wake_irq";
+        clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
+        clocks = <&rcc 0 25>, <&rcc 0 26>, <&rcc 0 27>;
+        st,syscon = <&syscfg 0x4>;
+        snps,pbl = <8>;
+        snps,mixed-burst;
+        phy-mode = "mii";
+    };
 
   - |
     //Example 3
-     ethernet2: ethernet@40027000 {
-           compatible = "st,stm32-dwmac", "snps,dwmac-4.10a";
-           reg = <0x40028000 0x8000>;
-           reg-names = "stmmaceth";
-           interrupts = <61>;
-           interrupt-names = "macirq";
-           clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
-           clocks = <&rcc 62>, <&rcc 61>, <&rcc 60>;
-           st,syscon = <&syscfg 0x4>;
-           snps,pbl = <8>;
-           phy-mode = "mii";
-       };
+    ethernet2: ethernet@40027000 {
+        compatible = "st,stm32-dwmac", "snps,dwmac-4.10a";
+        reg = <0x40028000 0x8000>;
+        reg-names = "stmmaceth";
+        interrupts = <61>;
+        interrupt-names = "macirq";
+        clock-names = "stmmaceth", "mac-clk-tx", "mac-clk-rx";
+        clocks = <&rcc 62>, <&rcc 61>, <&rcc 60>;
+        st,syscon = <&syscfg 0x4>;
+        snps,pbl = <8>;
+        phy-mode = "mii";
+    };
diff --git a/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml b/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
index 53604fab0b73..08119b6880ee 100644
--- a/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
+++ b/Documentation/devicetree/bindings/net/ti,davinci-mdio.yaml
@@ -72,9 +72,9 @@ unevaluatedProperties: false
 examples:
   - |
     davinci_mdio: mdio@4a101000 {
-         compatible = "ti,davinci_mdio";
-         #address-cells = <1>;
-         #size-cells = <0>;
-         reg = <0x4a101000 0x1000>;
-         bus_freq = <1000000>;
+        compatible = "ti,davinci_mdio";
+        #address-cells = <1>;
+        #size-cells = <0>;
+        reg = <0x4a101000 0x1000>;
+        bus_freq = <1000000>;
     };
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
index 02b6d32003cc..b11894fbaec4 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpsw-nuss.yaml
@@ -302,16 +302,16 @@ examples:
                     ti,fifo-depth = <DP83867_PHYCR_FIFO_DEPTH_4_B_NIB>;
                 };
             };
-        };
 
-        cpts@3d000 {
-             compatible = "ti,am65-cpts";
-             reg = <0x0 0x3d000 0x0 0x400>;
-             clocks = <&k3_clks 18 2>;
-             clock-names = "cpts";
-             interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
-             interrupt-names = "cpts";
-             ti,cpts-ext-ts-inputs = <4>;
-             ti,cpts-periodic-outputs = <2>;
+            cpts@3d000 {
+                compatible = "ti,am65-cpts";
+                reg = <0x0 0x3d000 0x0 0x400>;
+                clocks = <&k3_clks 18 2>;
+                clock-names = "cpts";
+                interrupts-extended = <&gic500 GIC_SPI 858 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "cpts";
+                ti,cpts-ext-ts-inputs = <4>;
+                ti,cpts-periodic-outputs = <2>;
+            };
         };
     };
diff --git a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
index 3888692275ad..3572749147fb 100644
--- a/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
+++ b/Documentation/devicetree/bindings/net/ti,k3-am654-cpts.yaml
@@ -131,23 +131,23 @@ examples:
     #include <dt-bindings/interrupt-controller/arm-gic.h>
 
     cpts@310d0000 {
-         compatible = "ti,am65-cpts";
-         reg = <0x310d0000 0x400>;
-         reg-names = "cpts";
-         clocks = <&main_cpts_mux>;
-         clock-names = "cpts";
-         interrupts-extended = <&k3_irq 163 0 IRQ_TYPE_LEVEL_HIGH>;
-         interrupt-names = "cpts";
-         ti,cpts-periodic-outputs = <6>;
-         ti,cpts-ext-ts-inputs = <8>;
+        compatible = "ti,am65-cpts";
+        reg = <0x310d0000 0x400>;
+        reg-names = "cpts";
+        clocks = <&main_cpts_mux>;
+        clock-names = "cpts";
+        interrupts-extended = <&k3_irq 163 0 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "cpts";
+        ti,cpts-periodic-outputs = <6>;
+        ti,cpts-ext-ts-inputs = <8>;
 
-         main_cpts_mux: refclk-mux {
-               #clock-cells = <0>;
-               clocks = <&k3_clks 118 5>, <&k3_clks 118 11>,
-                        <&k3_clks 157 91>, <&k3_clks 157 77>,
-                        <&k3_clks 157 102>, <&k3_clks 157 80>,
-                        <&k3_clks 120 3>, <&k3_clks 121 3>;
-               assigned-clocks = <&main_cpts_mux>;
-               assigned-clock-parents = <&k3_clks 118 11>;
-         };
+        main_cpts_mux: refclk-mux {
+            #clock-cells = <0>;
+            clocks = <&k3_clks 118 5>, <&k3_clks 118 11>,
+                     <&k3_clks 157 91>, <&k3_clks 157 77>,
+                     <&k3_clks 157 102>, <&k3_clks 157 80>,
+                     <&k3_clks 120 3>, <&k3_clks 121 3>;
+            assigned-clocks = <&main_cpts_mux>;
+            assigned-clock-parents = <&k3_clks 118 11>;
+        };
     };
diff --git a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
index 1715b22e0dcf..930b700b73d0 100644
--- a/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
+++ b/Documentation/devicetree/bindings/net/wireless/marvell,sd8787.yaml
@@ -79,15 +79,14 @@ examples:
     #include <dt-bindings/interrupt-controller/irq.h>
 
     mmc {
-         #address-cells = <1>;
-         #size-cells = <0>;
+        #address-cells = <1>;
+        #size-cells = <0>;
 
-         wifi@1 {
-             compatible = "marvell,sd8897";
-             reg = <1>;
-             interrupt-parent = <&pio>;
-             interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
-             marvell,wakeup-pin = <3>;
+        wifi@1 {
+            compatible = "marvell,sd8897";
+            reg = <1>;
+            interrupt-parent = <&pio>;
+            interrupts = <38 IRQ_TYPE_LEVEL_LOW>;
+            marvell,wakeup-pin = <3>;
         };
     };
-
-- 
2.43.0


