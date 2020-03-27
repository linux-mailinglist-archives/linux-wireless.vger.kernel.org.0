Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 385E019513A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727755AbgC0Gd0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:26 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49575 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726418AbgC0GdZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:25 -0400
IronPort-SDR: bWrI+/1sooNlaKPB5JsYf0pb4p+GxVuYBNHp/y9ZnpA6poFL2CVsL1kvlU5A10DgkJRBGIuGgS
 vQF8221zz5EhzVC8GLq0jwWRV5P3ECoLt3vbHPu1nBX/T5fQG9Wbw8g2vLienA/ZAeM5MdLlg7
 Ul9L8ucsfv5rd0bRe7N41P19sYqPUBplLSsSMpn5L4/MWGZk5WwRVSjiXqiCYdzGkPGwmx/WbB
 gFrH0/+dznN58YRKGH3qTJ7biLmm6bsaveFVi1WCYDYCb3UUHIETqZLM9ilPzKlSWZ6yqTrDmi
 /WU=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452428"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:25 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AEBvOjvYjaqBk6OZNUXgMfovK2m9akxQW2RSvgLrbSLMG0JyJc6sAUmTauVEByFYVZg1rbUHGyax2N+P6IHkAqDxFQLHg62HXLdzCOTDCP8aGlHjRdJu0G4C9Rt76NE8XAaHnoDCvPXpeTNsVhPZTkhUjLZ6W9NBtMmRcyzGN6AqikdOaqnhvDqhn9wf+d/2r4buthy2YrJ8eukBgzS9BTvo5M1aal46gqcMGfYsHGMur3f94chsSsaPN9ZeZXytIJR5Kn7bYXNOyYrcjOBgNtcVRgljT/TwoLeDVGTVGh1AUHX3/gr2ZtpFNqDl6TNIjf5fQqAK/8Fy1sb0uj9seQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/BoVYXn2lq4iGPqZA1q/vKljI3Oyh5/xTCyUj+luj8=;
 b=SG6MAcsmQW/JsdcQWpyCsCfGlVYJsaYMs4DJd5BgoUmgMq9AdNjSiKOyTrBBSm8Jx8KQTWm78V5zwjFcz/cCkuIKt+GMif/WBESydhmbCCIXeGBD7bEw1UuZp+Rien2E2woBfHkwuLQDvNb99Ssd89HBgTzRbHrykwl94ZFIlVMHtzg8hDAYsk6ZlFII3S+lZwe8JUpAULE6ik2fl4KgyBrfLiBJDzmUXcLleIydsuz+xY1E0QUlLt2ZoABixgSJqiQgRCVJqHtbEOuuwhhg1fjj1nZJCLeTWVEThvadQ/ppbDuFXEPdJRpG8EDzhxwAWeXPNQ6/gFV4a7HfnFy4qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2/BoVYXn2lq4iGPqZA1q/vKljI3Oyh5/xTCyUj+luj8=;
 b=cwoqKh6Tp0m2JPsSP2GqnvuSum/f0ieTcHvChMmPaEW1hFbRElCatcg/UXl7x+h8vGky2YkIBL7k9YOrTFfB1ES9F99ecLI02ZbCqSz0Bv691foD++OMQalcnqr3grfo7/4FiPI6b8NCEsa5Z3jXtJkwcIgihU06xM5LtK3LGPY=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:20 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Thread-Topic: [PATCH v6 16/17] dt: bindings: net: add microchip,wilc1000.yaml
Thread-Index: AQHWBAGbUtCuPQkvaUybiSTrHN256g==
Date:   Fri, 27 Mar 2020 06:33:20 +0000
Message-ID: <20200327063302.20511-17-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9e0f4392-4e02-4f26-5203-08d7d218be0c
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3397FD57BCED83CD8D0C9FF4E3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(966005)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: FIaGTH7ZoLn7F8pixBXk6CNc/zgVB0B0tZsyepCScCY8iThyiTNOPMokGvQMLemBfBevqX/I+ZM+Wx+23kJGqKxO6859k0ZnV+vs6gBTjxsFy2ANYk8FcZYD8YH/j3i7L382OmIqOfvf2DG//R0qz6O2VId8nGa9NkLbwL5gyPrFnA2swa43dVfvsooH+vOvN30a9+WivMbVPvpICNkB/gonyLi5ouFxLvEO58YJdFAhX0166tuTmVkQrof6JUArPrHvuhoGKHhrm+vNYvxMFCNMAAmxeOblCWy/U2Vn1WxDIBwGBjrDqtzfu0n/40xfEy+t0VqPrpqO6/mnlNzCuKL7wrhoW56gNm72YUz3i6/xZULJBjMnkxtSzuHCuCpHhkFRGcKJzwhre8UmfaixHp2aVX9u61c7r1Wc83J1hBKK6rWmW3ufixWtVFGLhd8cCQF3K7eY0VXgxgkCPoR22kurZUat8AdMWNoqxXrTOiU0K/dE3vfnYTo8M/BAgOXzf48zVKKdNYD/8hKNAT1h9leU4bgeV7Jp1yFvN8RTauttGholkHTh3+xzB0kCYEdf
x-ms-exchange-antispam-messagedata: dBTGXH3u5WGK2F3YIoRexfloa0gFZfyW2M4olsTZU+hbA//VKhP59i9cVNjpAFYSYfPIqs/oR6C+xT5heGMrkwCySALRb/i8O218nloYj/Le/cC+yPBLUTWKRPhS6WEOsERy7UgnyAhFMt3AIYPqRQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e0f4392-4e02-4f26-5203-08d7d218be0c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:20.3902
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: USWD4FAVvWn6R26XkLmsMEI/+TlQ9Ywlsp4kPIeALgs/7BYv/bklugTViYseKkbM2uTvS8hNyLefjKY5w7grxnjVj7g0pUSQArFHlT+vX8k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

This file describes the binding details to connect wilc1000 device. It's
moved from staging to 'Documentation/devicetree/bindings/net/wireless'
path.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip,wilc1000.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1=
000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc100=
0.yaml
new file mode 100644
index 000000000000..2c320eb2a8c4
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yam=
l
@@ -0,0 +1,71 @@
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
+    spi {
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
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
+    mmc {
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
