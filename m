Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 566DD17CD0B
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Mar 2020 09:55:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726139AbgCGIzi (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 7 Mar 2020 03:55:38 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:21630 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgCGIzh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 7 Mar 2020 03:55:37 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: SRAbEgCO/b3TN8dVKplT+Ikq+5IugR/zvZDhuFwij3GuaOdx+CG2mjdOt9Qz2VLVMF5KEyE5ju
 1sQRDK50yW6yXHhRMLCxHtL/q8+OXWIhSOyD045QbHwXYNI8c0REVqsnqamVNU1+ZRDYowgiRL
 9WBPove+edQ1NI6W/HhRQBLoAawabyXKzFwAciMCDojtqiM3eaOICvrEMjalLWclc8lCFZ2NyL
 59L2xXkoJ5G8zJwqvXYBE9tJseYlQA9W0oUCPg7JIAWYUolFMTUfegafivGDnI6pW1BJ5J1n7W
 XMw=
X-IronPort-AV: E=Sophos;i="5.70,525,1574146800"; 
   d="scan'208";a="67991521"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 07 Mar 2020 01:55:36 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 7 Mar 2020 01:55:35 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Sat, 7 Mar 2020 01:55:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elma2bc2dP2bHNG7Y0q0jPRs5H/Xi6P2OZre5fhSHQPK+54Wjc3Eh6FxMGUwUFqPUxGTEoA37N30ILj8I91j8eu3/oU6nyb5qkK+JT4x+yoIHQdJKHB4b5ykGD9Im1AFIItgLoDL+MQzIvbdcBXLGX4Zk6HL9fdhpvqQnq0REOekb1p+qpgqOU+RlBMWYfl+MiEI0VaQLIjRSlv19LEKYT5hgJb9vyM6+umnGpZkQKsf15JSQqvCP+jepzt92tCfhHs4UD2TwhdxtAvmSQMA7DLPx94QQcY8Yj3KhUZXfgs0lt6vXm7agQ4Ko1P0Sl918Y8sc81X1IRoDJkjSbT80Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24S8psTVHqqBbhHfGYhFVnKM10qZ+eBX1GHNImRCEvU=;
 b=U2ACZIuzDVGt21vklZgNnd3r5ZQuJMGkw3ISnApxc75/oEG6J5lZmFDvIm8J6nQZ8XQ5ZQ2XmkMOV+ttXCyjD40ATX1JrucGTTZUddFBqCRc6eIsp5rmYczSqWiLsPPJnb1b7/n/2Rs95nyjwtleXY1NNp04KCQg9ObBZ/aD6TVfJCGWVK/lU+y+WOysE8D6b8epnB/KpYqPcY+fFikaP0Y+WRSIrWYT207JiEGHMXB+Mar3Z6y/cPmhZSzuBi8zPwPzSwOQcIn3+0oIJdAsWwrty5aTR7XG32uds1ampI6dqgaEAXFWz3/Y9usqQjM0PqPJyx0bKWrVo5BoRw6h5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=24S8psTVHqqBbhHfGYhFVnKM10qZ+eBX1GHNImRCEvU=;
 b=fg+b8W/uzSLT9oJZZ2KLQ2m9X6fEacHS/P+gyspPddyj0KTib1e6wlgh+akJd95fKKg7CpR+O+7mfh/6BdYbOp+NjOT1p5IUwpM9tt/ZQp3ozSzicfAOO1Glio8/efNDCDyVncC/UY3dq3Bl4TJYts6/CKXEzX/TqUMty82U5ls=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1601.namprd11.prod.outlook.com (2603:10b6:405:f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.16; Sat, 7 Mar
 2020 08:55:34 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Sat, 7 Mar 2020
 08:55:34 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 3/3] staging: wilc1000: updated DT binding documentation
Thread-Topic: [PATCH v2 3/3] staging: wilc1000: updated DT binding
 documentation
Thread-Index: AQHV9F4oPSSY0EoaMU6tcS6RM9avyw==
Date:   Sat, 7 Mar 2020 08:55:32 +0000
Message-ID: <20200307085523.7320-4-ajay.kathat@microchip.com>
References: <20200307085523.7320-1-ajay.kathat@microchip.com>
In-Reply-To: <20200307085523.7320-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.205.217.30]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a7c1167d-7205-46ba-48a4-08d7c2754c1c
x-ms-traffictypediagnostic: BN6PR11MB1601:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16014A17676CABCFF619D2C4E3E00@BN6PR11MB1601.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03355EE97E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(396003)(136003)(39860400002)(199004)(189003)(76116006)(66446008)(66946007)(91956017)(66556008)(966005)(5660300002)(64756008)(66476007)(36756003)(71200400001)(478600001)(6486002)(6506007)(2616005)(54906003)(4326008)(26005)(107886003)(86362001)(316002)(6512007)(1076003)(81156014)(81166006)(8936002)(186003)(6916009)(2906002)(8676002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1601;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bd4H5xCuEQm7ypHYPt3zJzThVJAMXDCm8EQ4FmcLUdMginlMWoiq9NXXJLP3Mf+Nae496U41XqA51KsXuUsmtBmJsCkmCSeXVKpQS4JrxPNVbbkCkZTbY7DHmhIS0Qf1EjIGNzBqjiDwKnYCi2zufdid+YLFrxnW6b3Khc2udSuVotAQq8lVk+luZnbdfLwJq1SxMypicKcvjTGPtZvMxmFfx5SGQFXdFmsGpGqDtElHeMFqgJ1PubZUMcL6pZoACzLp2SpptPiJ3LF3wkcyyNOw2IyKbbO0FpRBPL6DDVAIcSRAwEsdbXHNh+DkiM7wAKMoPH33Y00HJ4lgP4AlRRcd0dMUC1JCAPYiLBBChBQTiu8uKuMvRt1kZ52glSK7IsIpVlM5Zq6xjktvAdhmBB12JcyH02NbV9TmMi8uCtiEHFwSpDU3H144DG85IFirmADuCR9I29mJ1j+EmjDiEPewGN0EW49yyeBOU+YJYYtICv2ulAoETQ+A0y/vb8PC
x-ms-exchange-antispam-messagedata: xoZsV/xnJ/JtTFm7HMbu7c7ruZrIqpsTgd1pJ3mIfZ/FFF1RE7AMlzulyZhwGl8EZZoq+EyHrseXTPEoSSzjYgHzpV2xB5rsRKSj9T2izYWCk48+Yh1F/Bv5c/hnrG9iH+CzhCLY9znbSjTqBS+jTg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a7c1167d-7205-46ba-48a4-08d7c2754c1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Mar 2020 08:55:32.9224
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qeySmvmeO/aJwDCflgc6+gLSUHsaMmC3FhqA1ZShmt5XZ7hKFGgm8Kaa7U7ywGVkBrU5yPTKHfX9nw5aci23n2WPjBodvrU7megsof52jOQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1601
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Merged the DT binding documentation of SDIO and SPI into a single file.
Removed documentation for some of the properties which are not required
and handled review comments received in [1] & [2].

[1]. https://lore.kernel.org/linux-wireless/20200303020230.GA15543@bogus
[2]. https://lore.kernel.org/linux-wireless/20200303015558.GA6876@bogus

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../wilc1000/microchip,wilc1000,sdio.yaml     | 68 ------------------
 .../wilc1000/microchip,wilc1000,spi.yaml      | 61 ----------------
 .../staging/wilc1000/microchip,wilc1000.yaml  | 72 +++++++++++++++++++
 3 files changed, 72 insertions(+), 129 deletions(-)
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
 delete mode 100644 drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
 create mode 100644 drivers/staging/wilc1000/microchip,wilc1000.yaml

diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml b/driver=
s/staging/wilc1000/microchip,wilc1000,sdio.yaml
deleted file mode 100644
index b338f569f7e2..000000000000
--- a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
+++ /dev/null
@@ -1,68 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,sdio.ya=
ml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Microchip WILC wireless SDIO devicetree bindings
-
-maintainers:
-  - Adham Abozaeid <adham.abozaeid@microchip.com>
-  - Ajay Singh <ajay.kathat@microchip.com>
-
-description:
-  The wilc1000 chips can be connected via SDIO. The node is used to
-  specify child node to the SDIO controller that connects the device
-  to the system.
-
-properties:
-  compatible:
-    const: microchip,wilc1000-sdio
-
-  irq-gpios:
-    description: The GPIO phandle connect to a host IRQ.
-    maxItems: 1
-
-  reg:
-    description: Slot ID used in the controller.
-    maxItems: 1
-
-  clocks:
-    description: phandle to the clock connected on rtc clock line.
-    maxItems: 1
-
-  bus-width:
-    description: The number of data lines wired up the slot.
-    allOf:
-      - $ref: /schemas/types.yaml#/definitions/uint32
-      - enum: [1, 4, 8]
-      - default: 1
-
-required:
-  - compatible
-  - irq-gpios
-  - reg
-
-examples:
-  - |
-    mmc1: mmc@fc000000 {
-      #address-cells =3D <1>;
-      #size-cells =3D <0>;
-      pinctrl-names =3D "default";
-      pinctrl-0 =3D <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
-      non-removable;
-      vmmc-supply =3D <&vcc_mmc1_reg>;
-      vqmmc-supply =3D <&vcc_3v3_reg>;
-      status =3D "okay";
-      wilc_sdio@0 {
-        compatible =3D "microchip,wilc1000-sdio";
-          irq-gpios =3D <&pioC 27 0>;
-          reg =3D <0>;
-          clocks =3D <&pck1>;
-          clock-names =3D "rtc_clk";
-          assigned-clocks =3D <&pck1>;
-          assigned-clock-rates =3D <32768>;
-          status =3D "okay";
-          bus-width =3D <4>;
-        };
-    };
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml b/drivers=
/staging/wilc1000/microchip,wilc1000,spi.yaml
deleted file mode 100644
index cc8ed64ce627..000000000000
--- a/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
+++ /dev/null
@@ -1,61 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000,spi.yam=
l#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Microchip WILC wireless SPI devicetree bindings
-
-maintainers:
-  - Adham Abozaeid <adham.abozaeid@microchip.com>
-  - Ajay Singh <ajay.kathat@microchip.com>
-
-description:
-  The wilc1000 chips can be connected via SPI. This document describes
-  the binding for the SPI connected module.
-
-properties:
-  compatible:
-    const: microchip,wilc1000-spi
-
-  spi-max-frequency:
-    description: Maximum SPI clocking speed of device in Hz.
-    maxItems: 1
-
-  reg:
-    description: Chip select address of device.
-    maxItems: 1
-
-  irq-gpios:
-    description: The GPIO phandle connect to a host IRQ.
-    maxItems: 1
-
-  clocks:
-    description: phandle to the clock connected on rtc clock line.
-    maxItems: 1
-
-required:
-  - compatible
-  - spi-max-frequency
-  - reg
-  - irq-gpios
-
-examples:
-  - |
-    spi1: spi@fc018000 {
-      #address-cells =3D <1>;
-      #size-cells =3D <0>;
-      cs-gpios =3D <&pioB 21 0>;
-      status =3D "okay";
-      wilc_spi@0 {
-        compatible =3D "microchip,wilc1000-spi";
-        spi-max-frequency =3D <48000000>;
-        reg =3D <0>;
-        irq-gpios =3D <&pioC 27 0>;
-        clocks =3D <&pck1>;
-        clock-names =3D "rtc_clk";
-        assigned-clocks =3D <&pck1>;
-        assigned-clock-rates =3D <32768>;
-        status =3D "okay";
-      };
-    };
diff --git a/drivers/staging/wilc1000/microchip,wilc1000.yaml b/drivers/sta=
ging/wilc1000/microchip,wilc1000.yaml
new file mode 100644
index 000000000000..bc6cc5d3f347
--- /dev/null
+++ b/drivers/staging/wilc1000/microchip,wilc1000.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/wireless/microchip,wilc1000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip WILC wireless devicetree bindings
+
+maintainers:
+  - Adham Abozaeid <adham.abozaeid@microchip.com>
+  - Ajay Singh <ajay.kathat@microchip.com>
+
+description:
+  The wilc1000 chips can be connected via SPI or SDIO. This document
+  describes the binding to connect wilc devices.
+
+properties:
+  compatible:
+    const: microchip,wilc1000
+
+  spi-max-frequency: true
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    description: phandle to the clock connected on rtc clock line.
+    maxItems: 1
+
+  clock-names:
+    const: rtc
+
+required:
+  - compatible
+  - interrupts
+
+examples:
+  - |
+    spi1: spi@fc018000 {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      cs-gpios =3D <&pioB 21 0>;
+      wifi@0 {
+        compatible =3D "microchip,wilc1000";
+        spi-max-frequency =3D <48000000>;
+        reg =3D <0>;
+        interrupt-parent =3D <&pioC>;
+        interrupts =3D <27 0>;
+        clocks =3D <&pck1>;
+        clock-names =3D "rtc";
+      };
+    };
+
+  - |
+    mmc1: mmc@fc000000 {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      pinctrl-names =3D "default";
+      pinctrl-0 =3D <&pinctrl_mmc1_clk_cmd_dat0 &pinctrl_mmc1_dat1_3>;
+      non-removable;
+      vmmc-supply =3D <&vcc_mmc1_reg>;
+      vqmmc-supply =3D <&vcc_3v3_reg>;
+      bus-width =3D <4>;
+      wifi@0 {
+        compatible =3D "microchip,wilc1000";
+        reg =3D <0>;
+        interrupt-parent =3D <&pioC>;
+        interrupts =3D <27 0>;
+        clocks =3D <&pck1>;
+        clock-names =3D "rtc";
+      };
+    };
--=20
2.24.0
