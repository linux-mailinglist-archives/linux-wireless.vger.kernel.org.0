Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47F1A167D93
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Feb 2020 13:38:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgBUMig (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Feb 2020 07:38:36 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:18092 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726976AbgBUMif (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Feb 2020 07:38:35 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: iNedxNPI2UDQREqigH0JNH5+wKnFUl+euSjth4EeRwggTWL5X1uGe54HhIs+LnPLdINIxnd1df
 bTXQzzVVxm1E9IJNzZCehTNIUgg5uHg//OAj+g22kz5qaUlq67aChW6s1I9qRiMymmOK3iLCge
 NEYjhqT5BmIOQuRL8h0j0RhPb9t1uj7erSjT+I5uXQYT17LzaIgwDdmofQFwDLpaH+avD/PdNu
 2nyguWAGY+9cyap+It0aFVdwlYMul5Q1357l7yXkhJaBdjEnX4FkU0BaRJZi4dLglymXGLLDro
 sAs=
X-IronPort-AV: E=Sophos;i="5.70,468,1574146800"; 
   d="scan'208";a="3170023"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Feb 2020 05:38:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 21 Feb 2020 05:38:33 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 21 Feb 2020 05:38:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bSXxO0dyyiid0HUa2GP8ljOt9BjD1QXVrq/mc0C14nYxbXPso6xVkJibuXbmLFv/e5c7a5Tvshks9vTFrH6L6e0brvyD2ecxrDXtghT+NuFbsLJl7Hq0tP6nNeMYL0hsdD3IgPtw4OwY7WluCgVIDLeXfV8B0XwI2lWvRPSfKL0C8OrCggRhpz3/s/k13LXFf4zV6K5GbHNCZounv1hVE6EJWk4XOQuAis0UYZSTNyEV9CDyk7o3IJDhaOABc+oq2RRcJQsKv/+4PVArsQOkahIeabQptxSWxawoOX6WSsQMaFD/5oE5kJI/1B6dwNBPL/NvFbxnddumV4W2ViX/xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9WGO19QCOE1sUNHu+9B3KwK9b25At2Mv8a8+IUYwHE=;
 b=iyTcq8uSAE822kBlTXrou7fgQbqpCqxI6DAzlRsW3M73PohSUXnmJH/wRsgiDLXRnVjvSYl0uA0GP2IaaMIQ2q2myUu1fHyN29IIEdsn/G4FwYJlp8OMnuaFJ0ESPvv2ZoaArFs0glnhD68aEd2Sr4KAoXujOZwS2Mt1/lHtcsiGBZQV2RW9zMZ2cyofgeVWCXgE19+/SOQPc7LQR8QC38ZTEuq4gqqEOXjjVzLF05yNn0ZhCd91wTuyDqMupDWuHO8Nc7yiBE2LPidfQ7N5+bcrJQwd06ZZS+Mf3ALbDoeRWDpXC2NZuZ65eMQKGijestN2PVPB+S/dA1XXMxvWNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q9WGO19QCOE1sUNHu+9B3KwK9b25At2Mv8a8+IUYwHE=;
 b=TY8E0fzg80ctNXMDFlebamOQnl7JTgvR6tPJczaN1yqlfnKbLXwtg45sj7aFoIGbnHdky8fa7+lVhRhzX+bhvcdMue//U6KSRu+m4ct29xVMQMdAOyW3LeLzMLsxLVUkhCAIYEECOM006K2WHzpV/MFr1cfrRINP6LIhi4x1om8=
Received: from BY5PR11MB3989.namprd11.prod.outlook.com (2603:10b6:a03:191::17)
 by BY5PR11MB4483.namprd11.prod.outlook.com (2603:10b6:a03:1bc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2729.25; Fri, 21 Feb
 2020 12:38:30 +0000
Received: from BY5PR11MB3989.namprd11.prod.outlook.com
 ([fe80::c69:bf40:f4b7:e62f]) by BY5PR11MB3989.namprd11.prod.outlook.com
 ([fe80::c69:bf40:f4b7:e62f%6]) with mapi id 15.20.2729.033; Fri, 21 Feb 2020
 12:38:30 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <robh@kernel.org>, <mark.rutland@arm.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] staging: wilc1000: use YAML schemas for DT binding
 documentation
Thread-Topic: [PATCH] staging: wilc1000: use YAML schemas for DT binding
 documentation
Thread-Index: AQHV6LPSHXupcVX+3ky6oW9ru0fe1g==
Date:   Fri, 21 Feb 2020 12:38:29 +0000
Message-ID: <20200221123817.16643-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [183.82.19.162]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c6bbca22-51e1-44e7-c9b6-08d7b6caf4b8
x-ms-traffictypediagnostic: BY5PR11MB4483:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BY5PR11MB4483BC6B087993392FAA595DE3120@BY5PR11MB4483.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0320B28BE1
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(366004)(136003)(39860400002)(346002)(376002)(396003)(199004)(189003)(5660300002)(107886003)(1076003)(2616005)(6916009)(76116006)(66446008)(66476007)(64756008)(66556008)(66946007)(6506007)(186003)(36756003)(26005)(91956017)(966005)(71200400001)(54906003)(316002)(81166006)(86362001)(4326008)(6486002)(81156014)(478600001)(8936002)(6512007)(8676002)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BY5PR11MB4483;H:BY5PR11MB3989.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 4k41GIwhMiGiBv1MCnNSbv3LZgHylW8aHelxZEzvD1I2EyWn09+zfne41fd4BNdGGjUHW1fHNCFMDYzzu8E3D5ZNza2XKSuyoG00KRn63XG+u9s2bAqoPtJWSoi2kbVQCuLy865vv/x2us5dQXpi9t9kpC3OlBfuLgTAdtSlAf1go/lL80I13ELTGemrUcV7eQgyFtnl29o7tzw/XGhWkiDcRio6q4O6OORnjPPnYuyWzyLRDm7JSPrc6MC+CytpHygPduA3AiCoy3thxE3p0tZfngvMhJmkv9dz6d5K3CysIj3UCTSj5padXaIo/WBnQ96Ds9tJo5mYyeVDM3SlA447xqD0mdLYCOk6iQlcH12qwHFa4L8pPDLsMPE9lqEvAxNawfa5p3TnrmeqVZZ7SElGNOP/Zw0gkh9UxrzAUYFwnRt2lYijwDfWIVvCIdkcSfRhIt6OdyL++cmfLvXXv5j4ME73wbJZgYLb9riS0atwmUzdsx1gVTZw3Uv+tnus
x-ms-exchange-antispam-messagedata: r0ijI0vy2paO+NouEvYiFPlrxD94AIIHi5pppTEuqR5z2sQesoOlfq+jtE+w54YwODwR5sgRav95spy+e2PIewTyyM0s9Zu3BzyPB0KlYVnCzlIEYRIOKHnMuutmHkTyXMv894kFbXw6T94CnpIZJQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: c6bbca22-51e1-44e7-c9b6-08d7b6caf4b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2020 12:38:29.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XzvS4C6Z3RoNl4DSR+F8y4oxJoBtRN0GyGj390v1zIycFaLExRyU9nJdFFnxHI2NOz0CBdShxIeHWMSv190pwEW+YcgCJcB5vhHCihOz+cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR11MB4483
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use YAML schemas for wilc1000 DT binding documentations. Currently, the
files are present in '/drivers/staging/wilc1000/' but these will be
moved to '/Documentation/devicetree/bindings/net/wireless/' later once
the driver move out-of-staging.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wilc1000/microchip,wilc1000,sdio.txt      | 38 -----------
 .../wilc1000/microchip,wilc1000,sdio.yaml     | 68 +++++++++++++++++++
 .../wilc1000/microchip,wilc1000,spi.txt       | 34 ----------
 .../wilc1000/microchip,wilc1000,spi.yaml      | 61 +++++++++++++++++
 4 files changed, 129 insertions(+), 72 deletions(-)
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.txt
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.yaml

diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt b/drivers=
/staging/wilc1000/microchip,wilc1000,sdio.txt
deleted file mode 100644
index da5235950a70..000000000000
--- a/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
+++ /dev/null
@@ -1,38 +0,0 @@
-* Microchip WILC wireless SDIO device
-
-The wilc1000 chips can be connected via SDIO. The node is used to specifiy
-child node to the SDIO controller that connects the device to the system.
-
-Required properties:
-- compatible	:	Should be "microchip,wilc1000-spi"
-- irq-gpios	:	Connect to a host IRQ
-- reg		:	Slot ID used in the controller
-
-Optional:
-- bus-width	:	Number of data lines wired up the slot. Default 1 bit.
-- rtc_clk	:	Clock connected on the rtc clock line. Must be assigned
-			a frequency with assigned-clocks property, and must be
-			connected to a clock provider.
-
-Examples:
-mmc1: mmc@fc000000 {
-		pinctrl-names =3D "default";
-		pinctrl-0 =3D <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
-		non-removable;
-		vmmc-supply =3D <&vcc_mmc1_reg>;
-		vqmmc-supply =3D <&vcc_3v3_reg>;
-		status =3D "okay";
-
-		wilc_sdio@0 {
-			compatible =3D "microchip,wilc1000-sdio";
-			irq-gpios =3D <&pioC 27 0>;
-			clocks =3D <&pck1>;
-			clock-names =3D "rtc_clk";
-			assigned-clocks =3D <&pck1>;
-			assigned-clock-rates =3D <32768>;
-			status =3D "okay";
-			reg =3D <0>;
-			bus-width =3D <4>;
-		}
-	};
-}
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml b/driver=
s/staging/wilc1000/microchip,wilc1000,sdio.yaml
new file mode 100644
index 000000000000..b338f569f7e2
--- /dev/null
+++ b/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
@@ -0,0 +1,68 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,sdio.ya=
ml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip WILC wireless SDIO devicetree bindings
+
+maintainers:
+  - Adham Abozaeid <adham.abozaeid@microchip.com>
+  - Ajay Singh <ajay.kathat@microchip.com>
+
+description:
+  The wilc1000 chips can be connected via SDIO. The node is used to
+  specify child node to the SDIO controller that connects the device
+  to the system.
+
+properties:
+  compatible:
+    const: microchip,wilc1000-sdio
+
+  irq-gpios:
+    description: The GPIO phandle connect to a host IRQ.
+    maxItems: 1
+
+  reg:
+    description: Slot ID used in the controller.
+    maxItems: 1
+
+  clocks:
+    description: phandle to the clock connected on rtc clock line.
+    maxItems: 1
+
+  bus-width:
+    description: The number of data lines wired up the slot.
+    allOf:
+      - $ref: /schemas/types.yaml#/definitions/uint32
+      - enum: [1, 4, 8]
+      - default: 1
+
+required:
+  - compatible
+  - irq-gpios
+  - reg
+
+examples:
+  - |
+    mmc1: mmc@fc000000 {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      pinctrl-names =3D "default";
+      pinctrl-0 =3D <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
+      non-removable;
+      vmmc-supply =3D <&vcc_mmc1_reg>;
+      vqmmc-supply =3D <&vcc_3v3_reg>;
+      status =3D "okay";
+      wilc_sdio@0 {
+        compatible =3D "microchip,wilc1000-sdio";
+          irq-gpios =3D <&pioC 27 0>;
+          reg =3D <0>;
+          clocks =3D <&pck1>;
+          clock-names =3D "rtc_clk";
+          assigned-clocks =3D <&pck1>;
+          assigned-clock-rates =3D <32768>;
+          status =3D "okay";
+          bus-width =3D <4>;
+        };
+    };
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.txt b/drivers/=
staging/wilc1000/microchip,wilc1000,spi.txt
deleted file mode 100644
index 34236932dbb6..000000000000
--- a/drivers/staging/wilc1000/microchip,wilc1000,spi.txt
+++ /dev/null
@@ -1,34 +0,0 @@
-* Microchip WILC wireless SPI device
-
-The wilc1000 chips can be connected via SPI. This document describes
-the binding for the SPI connected module.
-
-Required properties:
-- compatible		: Should be "microchip,wilc1000-spi"
-- spi-max-frequency	: Maximum SPI clocking speed of device in Hz
-- reg			: Chip select address of device
-- irq-gpios		: Connect to a host IRQ
-
-Optional:
-- rtc_clk	:	Clock connected on the rtc clock line. Must be assigned
-			a frequency with assigned-clocks property, and must be
-			connected to a clock provider.
-
-Examples:
-
-spi1: spi@fc018000 {
-		cs-gpios =3D <&pioB 21 0>;
-		status =3D "okay";
-
-		wilc_spi@0 {
-			compatible =3D "microchip,wilc1000-spi";
-			spi-max-frequency =3D <48000000>;
-			reg =3D <0>;
-			irq-gpios =3D <&pioC 27 0>;
-			clocks =3D <&pck1>;
-			clock-names =3D "rtc_clk";
-			assigned-clocks =3D <&pck1>;
-			assigned-clock-rates =3D <32768>;
-			status =3D "okay";
-		};
-};
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml b/drivers=
/staging/wilc1000/microchip,wilc1000,spi.yaml
new file mode 100644
index 000000000000..cc8ed64ce627
--- /dev/null
+++ b/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,spi.yam=
l#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip WILC wireless SPI devicetree bindings
+
+maintainers:
+  - Adham Abozaeid <adham.abozaeid@microchip.com>
+  - Ajay Singh <ajay.kathat@microchip.com>
+
+description:
+  The wilc1000 chips can be connected via SPI. This document describes
+  the binding for the SPI connected module.
+
+properties:
+  compatible:
+    const: microchip,wilc1000-spi
+
+  spi-max-frequency:
+    description: Maximum SPI clocking speed of device in Hz.
+    maxItems: 1
+
+  reg:
+    description: Chip select address of device.
+    maxItems: 1
+
+  irq-gpios:
+    description: The GPIO phandle connect to a host IRQ.
+    maxItems: 1
+
+  clocks:
+    description: phandle to the clock connected on rtc clock line.
+    maxItems: 1
+
+required:
+  - compatible
+  - spi-max-frequency
+  - reg
+  - irq-gpios
+
+examples:
+  - |
+    spi1: spi@fc018000 {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      cs-gpios =3D <&pioB 21 0>;
+      status =3D "okay";
+      wilc_spi@0 {
+        compatible =3D "microchip,wilc1000-spi";
+        spi-max-frequency =3D <48000000>;
+        reg =3D <0>;
+        irq-gpios =3D <&pioC 27 0>;
+        clocks =3D <&pck1>;
+        clock-names =3D "rtc_clk";
+        assigned-clocks =3D <&pck1>;
+        assigned-clock-rates =3D <32768>;
+        status =3D "okay";
+      };
+    };
--=20
2.24.0
