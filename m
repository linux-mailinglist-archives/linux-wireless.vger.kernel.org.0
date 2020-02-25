Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53C8516BB0A
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729658AbgBYHla (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:30 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:25139 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgBYHl3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:29 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: cJfQvJ4hXM0+iyHiFBZxIFDO4qk1mQFVg4RCkYBQ6oJW74JgsKZv/uM7Be+XblJOLDi8qb7qvp
 2ympQrz1iqQC38g/S1br0wcCixfok47LhnOAVYepZRNZfQQyAiazoHbPDiicMUU71h38tAC/jo
 D4y+Ig0VjvGznwv4ifgmnQkTY1uJsCAXfprhaiM/M/THrMj5oTrKhG7rm2Fq5qz5pMjVfrp155
 5g8HKm5gobb+lVUZsNWVU4agvUYlHZeV9WxZ1UiNZIAIo7x4USrQ64E+fEN1Vv95IyHEbOT1mH
 iTU=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="69675649"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:33 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 25 Feb 2020 00:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bV4XOXbyIEIatN3nMbPFcVfmynNn8Cjmh762KX1tU0VmeSMkO6abXW6aGz2Wbi268OCVI/1D67jvkl6tOFv32ByePQGczZ6CZfoyiCXL7lQHXTS9OI4L3LsyUO/mAZ3rkyoO5c1ZAFNtGwmB9oyt5gbmS12hrMMvZEeomMA5N1psz2MEXSKcpzZJMk+NxRtptx8c3hAgOht5OzHLKu5k+XzQp+w+MRHx82hwwuMPPzo2Ij0kpU2mDBN6p2Z7PKRoMvs9x1XAHblavAMYM4E5/4SpHEPYNo1HxSFKtwlK8e3v+pwG6GhnXam9cnrETkZNjuTyuw0Wfa6Y/gJNRKwCPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDujH185wChq8QX/moSUQB5eB5hG5vaJemsoHQdD5k=;
 b=CCuAQ1cUC555xyc9YzfXXFK7yWyospWlrylb88bBByHSg6ZkJXPKatfbxbhGUVfFmoN4EJ1xfC6gOEttTC6qxMTuTgiH3H9PeYH2YxfyK46rdRZ7NF+a0Sl8XebTaTzmuq/+OYR5JermMMrPJ6vLWuZFsJGywBzUpEuQoFagd5c2vQkBlOMKVtlyPio02TEkBEtVTHM6YBUBMJy4y1e2sxkmPMCYZBjuO8flGiREG3tt9a+3qbY4cPFY75Ll3P37UyZWjLhqPv04DFTxjhp94T8ZWDuKo25xY01MgmFYsaslCh/IcVHcLOHYnBam8TfvRkzsmxnwBIgGB+LymkRQBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDujH185wChq8QX/moSUQB5eB5hG5vaJemsoHQdD5k=;
 b=fN/uoEj2vf/0DmnpfbxL6tvyZAyrYxIqwPQ5lg3GvZ/Dv7Cb8s7tqhXMbU7HknKIveUiKibX5pBKa0e95sL/5njjFdRve//eJhQZiegPdyI5W23a6L2Vfltw4UDcEFpYOCuA5shMERewd/NGoIyLJoxyIJwv/Ol9G9syYJ6yRgA=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4162.namprd11.prod.outlook.com (2603:10b6:405:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:41:21 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 17/18] dt: bindings: net: add microchip,wilc1000,spi.yaml
Thread-Topic: [PATCH v3 17/18] dt: bindings: net: add
 microchip,wilc1000,spi.yaml
Thread-Index: AQHV6674+23AU/64g0SDUHlH3hVCyg==
Date:   Tue, 25 Feb 2020 07:41:20 +0000
Message-ID: <20200225074105.7740-18-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59dc1c45-048b-4b98-fb75-08d7b9c61b8e
x-ms-traffictypediagnostic: BN6PR11MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4162D0F48674CAE09B191F38E3ED0@BN6PR11MB4162.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(81156014)(2616005)(8676002)(186003)(6512007)(6486002)(5660300002)(26005)(81166006)(8936002)(6506007)(54906003)(66476007)(66446008)(66556008)(316002)(966005)(86362001)(4326008)(71200400001)(66946007)(6916009)(2906002)(76116006)(64756008)(478600001)(91956017)(1076003)(36756003)(107886003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4162;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +0mX4ABW4xILGo6xfH8EN3UhRll6j1mT4rvDarvCRAs8cGYDN+FQu3Fd+dwcu2xj+gOGWNqeqROh6pGjr2RUFUYCYcwfTDsGZxrSsR4Ns2+UHx+UYT5joebDlHJAaVfn4qJZwfb5meojrXbg7h7SocS8wv9ZjWC0VvEETHI3lr08tsEYtxaOKUvnXtihnaPfx9jv+wS3xkDWtCQJLiadZxb0gWzimGyGeUhJLGDc5DY9GLNap+xNphZ+R1iwAZTCY+QlHn0+XPmBdwFO+0NC4TEJmpm2JuT8HP/czQjnau7p1hH2mmHUZVFPvaqs2RMXIbePlPpT+P+8qnZ4v1Qn4SRRsTE4bYkIX6bGGa5CuDi0lqZcJ7UC8VvlmvFxlK53p3xxVZtCeTtcjXrNjQKrrm4O2ZPneZJ7SU4cs7m2YPenHcnEFFMVUSHyVjggxQYXc43eIWU6BBXz+bCj6cSVkewLvLb8oVrhjbN8G2YsIgAVqUazK5uPm5w8h8tfCF6vNdYjFA2r4hGUM9557/JG8lIqmto5MMx1hvyDhpKndlmXqIUlEWxxO9Ju+AEf1vfG
x-ms-exchange-antispam-messagedata: lESX6Nxs+EyyWUjIu5ss4fWVLtAS2KHVaAz+AucjhPidwPukTQt/W9Uk8fy+FyIT4BCnmf0QT3XyEhCDKJWe4kUquSK5nT2+51LBkGOJJA1H4QQ4OC5MCQda/9kMb+n8ChvSFipuMBe8NRD5LrPTuQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59dc1c45-048b-4b98-fb75-08d7b9c61b8e
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:20.4098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bt8qmIseJucrvPk94vIcmsdfOlaJtKwmx6OXKKV97hFebWFRa0kaTnG/xH0CYFYz6B0sJNuOAdYNu8b7x+45/2VwUETvzFnEYB+A7N/5UAo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4162
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/drivers/staging/wilc1000//microchip,wilc1000,spi.yaml' to
'Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi.yaml=
'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip,wilc1000,spi.yaml  | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000,spi.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1=
000,spi.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wil=
c1000,spi.yaml
new file mode 100644
index 000000000000..cc8ed64ce627
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,spi=
.yaml
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
