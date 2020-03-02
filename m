Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B83F176002
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727422AbgCBQfZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:35:25 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:11639 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726872AbgCBQfX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:35:23 -0500
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
IronPort-SDR: stCEy/2X3q8KYoUKS1zpYy48aJTGIudPGNZxLKOMQrFz3MorIQUEV01bt+WEC+tD7OFA4Uoj9l
 QsBstyDVzJwmbHPh3FibPVZgTfFxNZ/7+TeXQv0jyKpmYlorEIRZciGC+e7m3EJg45r2pciAVm
 aJSvyC4mFJAy9lK821dYoaDg5FolVWq9a8TCFGi3a5mS0OMWrH04rhiIecMQ5MWLZrImC173Aw
 /ydp5GF1CuHLwTs5w5UUeSQig3y0P3wJPy+cJldGXyJA0jJaeTX+bHe2qL6fBByvqrqlG1znQV
 s1E=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="70445279"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:56 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:56 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 09:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KmQIUVq9bY/GCViRO7sTm9YrNph7NOMqvhs40JHrNF+svVlmTPX5lHDtwHh4Km39DsNfHLKTJVHvTDBLL6gkgN2NYDtlaz32LNo/STQxZKoiQ/ldKv6kdTuUqSMvQozvhsUfrcEhRKsDhidLEkwTQhwN0hjU//4KLa+61eGsJ4zsisNwzUb1RG5csdwCDSdTVV9ct7v+IuQz3QHLs9DLAAa0Hp+sNltK7gSBIgCym4R5dUGkrNswje7WNlWqdYeKxm5RXzgUnP1AQ0dd7xIr0u87cJQsdQ9UlG0I2fmruJ8v+X2N6DfWCfv9CadWuiJCAXiljrP8nwxu2rQZSqxJ+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvarfK+/S0ecrg6zLY5Xsxmr2UJbcp8fz2EdH8BHRX4=;
 b=SK9q8f8eoYdpInrnnMTN0QN9WiqwjO6s9FewhQXuJimBSxmJ9JGnP7ZYiGeye1LjoMYKBJP/PQ3xI9OWDfaCj7t5QaPkmg9gNCE66cBZOXgWMfUtyQwSlnPNRrLsCnoVGCtXIto7O8mOVcsUxY8ISoBvo65BSzI5Tyfl2ZNWxUFm5HbIG6VLyQ0lactZX3VMvJK+AsiJYfj0Yp+dCks6b3q7iAnVBdapPAED6VsNkB6awGwy7hCVd7SKfUc2ymNHJnSd3VXoMxzZm+pqfJi9t8ZqRwVaV/KXL5en7XfEmph2mJdjS8T4B/tVX+kj55CEVGZZ8+YTpeuRfhIvetbNNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvarfK+/S0ecrg6zLY5Xsxmr2UJbcp8fz2EdH8BHRX4=;
 b=ESuy/v4+JEE8PeuZ7+oWTUecC5xHZ3dzD55lDFYv1EHHZofGFtqIMEQ4gXFlaiHlT3+WexR0n3wFrdf/6bs0yRZQFXvRJGIH251Siw9u0+/MaTm0nW4SVO2B44g/W9T+dXaXlrQnodtcyWYaBXFkrW178AOCgh+LXAWrZ3RjErw=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:40 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:40 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 16/18] dt: bindings: net: add microchip,wilc1000,sdio.yaml
Thread-Topic: [PATCH v4 16/18] dt: bindings: net: add
 microchip,wilc1000,sdio.yaml
Thread-Index: AQHV8LB4evB5uOBIuUadeV/L9u3vJA==
Date:   Mon, 2 Mar 2020 16:34:40 +0000
Message-ID: <20200302163414.4342-17-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0b20f430-2b08-41c0-e95e-08d7bec79b19
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB40988C2B9079529540405D56E3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(966005)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XKaub4SF3b+Ne6XA13HxSyBZlOnqZVj4yLtpYyYGTpXUztOkXILEkP3h0T5Q4FbkYEAZ/xfRmPStxbxDuysMqrEkxj0hOQxdjtKRQs5eQFh2Imumq+kEwtp8gtmkkjJpKaxzLVdH0+1yOFd8ZQGGwOpgrnsY8ON5yEFZbsLJC2X+4N9GYVvwdnN/nRCUlVSvtBQ4wR7sI6OPWMW2eUbQrXRHNnQHnDZW2li3Z2sJYoEx41SdtmERn3o+lk/BJ1qHO7F8I70kcIDYsSbHlxUnoAK2XXi4VIhSnKw0GSnd39xzS1smIXQw8JbliJCDZzeNFuZc73vbmKbrWMnyt+28sYZwA/+u5IYvA0E9B3pRG8X3Hz9j95L7SCYi1oqr5CWtp/eGQHMTaERxVKwRT8msI5CYiypreQzjX+PxmgtYf+QsdyqHTHB246oC1vHotEOSPMQqnbKOi+yppDl9dL9NCjSfNGKlgXt+DCxYUXk7KBYPh1GHe/9j+0BxgDce8qtNVrUsrBIOTLAxl/yQQ5JMWEJ8xS/6oitdA9GcWPHsk05vJ8DVeGNBixr48XH5urcg
x-ms-exchange-antispam-messagedata: bZAIzcd/mF9xUz/n72POgKdoazJNyPZkIPnSPXGuL9xyj21smVYJ1FX/FRyh559I5eArOt2YQXpycnqbIqLwMoJAL0B+jaj/4UQLlWkCCLYt6zk9iZrJJmO45Q0E0zJx2V9oa7/k6ApG10NcP0vOWg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b20f430-2b08-41c0-e95e-08d7bec79b19
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:40.4101
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zNNBxEa9nkEKxGlWZ8uaGZL6476scby47RT4hFvT6x4WihLMRAOFpwHC8oGVH6dHE8BFS6Rsz4hWPtu3FFzjK3OmfEM6SNkSvZWk5pH0BTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml' to
'Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdio.yam=
l'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip,wilc1000,sdio.yaml | 68 +++++++++++++++++++
 1 file changed, 68 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000,sdio.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1=
000,sdio.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wi=
lc1000,sdio.yaml
new file mode 100644
index 000000000000..b338f569f7e2
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000,sdi=
o.yaml
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
--=20
2.24.0
