Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6C34C175FF8
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbgCBQfJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:35:09 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42837 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727113AbgCBQfJ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:35:09 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: P/OnNiCYt+P+/yLWRX9WfSrrPM7eqNEuXw9kXdfWwwGEtwrqAL9NP8LwtaO6IiY6eI/W8G3UDx
 2lUSok5sYDQFyRWqEDCIf4pP3fiR0YNHJgo0nAcxk77cRf2Hca+GYg0kwn/5gXLUrh75hsP3sO
 i/9fPDiRmO3IqVxcZaAKtPIACESvtf41RYExTipQoubij/OLDIhEflJPlHvjjQ0wO7NilF6tdk
 c50upoxKYC74l4r76QHLfeZmalN1duLkSeyeGVn0qZKcZMlnhVVB7o+xVaY2yd7ZoN++hGJnJ8
 ij0=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68544234"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:43 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:34:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h9C0PAgnfXbxvPDntYkJ4nVr1ggulm6mVLb1zLEYw7dZLFMZWsXTLK9gwOzIkGMKJ+Zspp3aLdmVi0ghRhZpCC1CLD4QgZXsUz7E0RunCjqE57FnDFb99S0WMjlw4tYNISpEq+jsndaWdJ4sRhS/CuFJ+BlPxviVjdU1J6KthxA5aKcb85em3mnevPZnS+X2GOo0s+TLYrOQJk8D+/ihUBBkyIJou/1J0CK7MgWY/LMVD1iMcs33jsTiUbh/zkHrqArseMCyctPnc7QD4ys9GDtcml5dvEo30zb5BaTLku7QT6YaBtWsaXp2i98a4+qrPXEw54qXruwfAVM56BdGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDujH185wChq8QX/moSUQB5eB5hG5vaJemsoHQdD5k=;
 b=M2Kkg50kAnxmvBCXscWDRWwIvVk7ylh78gaEy1YUVIVtOuOprNQa/ElwffXAphSIQp96vLDTs7dIyiwsyb2b4C/jeKFQ/4Zf+P/0wb7eJQcEtbYYFJ6PM4cV/1N1IyE0mi/6wjB/pq6mwDcfxz9ocTpVaYY1E9JiqGSEC6Icbl5emV6e00zQZjqcbAqtGpv1bf61FxRA5EGc1BibiNnvadO94cD/y+0/6MnRnPdnEOdOCnR2/tbKHvTcVOpWJcrwuKmRl3eXpuxHH+YVzE0n/o10fAdLVn+hXYS62lgJjEjzUVgGykR8k8RGiMbR6XUUrm3iaFRqmUCfnb3rlnrXXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MbDujH185wChq8QX/moSUQB5eB5hG5vaJemsoHQdD5k=;
 b=W1aAlZxrWFuofi53tWBbbphRudtcAhDdHWx2EYlS9WYrbxXRtRfDuFwUtJM9uKijI29X4LQUxVEJZq9gCbrmEhfMgxmB4gH0gCw0ArLVl+JiSz2vA9L7WulrXCS1e1xgvmSjo6MYJXuXqY+vl1s+EUEkO7gvHMZwYRuQjlt1uzQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:41 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 17/18] dt: bindings: net: add microchip,wilc1000,spi.yaml
Thread-Topic: [PATCH v4 17/18] dt: bindings: net: add
 microchip,wilc1000,spi.yaml
Thread-Index: AQHV8LB4yeo407y5WkaMy3sgQWSapA==
Date:   Mon, 2 Mar 2020 16:34:40 +0000
Message-ID: <20200302163414.4342-18-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e67eceb3-183f-48ee-25d8-08d7bec79b81
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB40981744616AA2D2CE1B83DCE3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(966005)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OiP1OnmGmiEDiZSUX1nIRLoODHJE7X+9rDEIs/MGOZkTHuICESY5AO8IZRkIxIjywxofvFFZveag96WgQwIzShquyKP3RjqEh8ji/XQXFm3MS/OEBhj0roDkv11mzujxfFnHpJbdzrIw84ZRmuoJ7XBdPC0T8b070VclP39KaeyAU73DLtGdf86WuVzY7oIkhx3C2svZVgSmpNx9S9cdBKIuPjllb2hoXcNIRgTFgYRdyXi9Jte/ONZg9vh4yENOw/tOGKCEBkj6kmNmMmcr7ZbC2qwzAzaRrJFBJKfAxYEyTYjtZfGNzrcq7t3b7jJwykTyGB5LTbzr9+fP58ZnQsY9Ck7H1zjSKiAsDnHQ8Gi09ZjMpmk8soqQEQ4ULNQeMEBPrL9MGxYlSWs9haKlnUl0BYvpG6ArhWk4btniubn1FUted2qrhGbIjXBM8kW4QE8SzYY8sfm6gvXs0CKdDUxwa0CNc0Ph2R26KXYgvLRZu+u6dOVlih5J4VI1YnsYY/e6edafEB473iPybsvQ+uvcpfh4hPMr6mzHEdNn40ZLHsz/HpnQtK5TM3y4/PEE
x-ms-exchange-antispam-messagedata: 0EGzeMIBkGnaSH1jc6Ujao0K6JWRpB2SLc7jHlYUNCYhSh3eTK48jvYEF3cPySTNiKOmJXFe6Ae6g+X6Ft2efM8SwY7+x+7dg+3S7Xj2iMIEsgLLb2kDi7fSXXcoCyRAIzsFyotWBOcB/xGyoLhGlw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: e67eceb3-183f-48ee-25d8-08d7bec79b81
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:41.0657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZDmwDCPmOkFP/qRkFUXilJYFSPQSVMFAr0aB2aOli5OWzK1bXcpD0zxjyCgPgakjd+zSndwd28E4qWcoOk+5RMfR0JPC8VvfJnowmRoFSH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
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
