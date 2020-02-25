Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D319516BB09
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729648AbgBYHl2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:28 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:53476 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729625AbgBYHlX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:23 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: GdiLa4UeHatXY9i3PCctXDdbqMOBugg3mGZrPbhKjzFjHF5hW8fwAMr/6rFgj6Lf3uHVLbIL+x
 gvFIudkdu5tfxpOkAXulyDdwhyTstlgFvd1UKoom0Rz2pGc7Qk4JAy2TvNk/K3//UbRqb54uZt
 pQCOW9FzTm5zpfHP90hN2X4/Imd147uQtqgZAwdqV2GmT5Z86evupmGuCzCfRtmO2O0LmEmg3b
 X+21XTTGq/MQjwdi+iWvJyHTy+IIfys93X0DM0sxrCw+U28fylntlRJJE3IE8LH5cIMbCGIu9/
 eto=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="66951736"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:18 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 25 Feb 2020 00:41:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbou54GokxAfJW7mEcWKe1FMbGCcxs43UQFsVSDGTSRz+X0lpBPlONKhCbfdSpuogH6vVx1VQooxSXhp1wr9pfiSOnp2TewhyVcwzC+sNbkLhba/s84BYA/p2WPpGCWR1JTmVzvmB9A8YQcgrvXgWfiGFRxFLYVD6NGLk2BHtPYKq1tWhOdx8f5R9MAP3eE0HKKJvuQixstF4Us7d4FPSaGL5Xld7l3cO+mHWRLGwrm/l+6bb7kbLIWhShAFF9pe1jE2Gxoiu5yEogRy5aIKpjfCcrcMTZW8385PcdJoecAfiea0SZB9B1H2kJSo7+pucX7ZLaJxF453VdIyeRxqHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvarfK+/S0ecrg6zLY5Xsxmr2UJbcp8fz2EdH8BHRX4=;
 b=WeWRYwnrE3cfSKWIMfk/myCMO0qJ1GofNTSCwzrYyeLS5R5bZXYvDxvu3UbYmHj00E3ElOJwsG+EhBjWYjl6A8z1PTMoqcMTR6ktZEy1zkOR5f2u49X90fKd+RqkcXpWJaEkZoyFjPV/UjW0NXniEt1mmqACem8oRwB5A9aO+rknKHztJ2Xr60VPBd2TbeqTdhGN4TWbJHm4I/dIpohTwzs4Vl5EE10jicljbSeTtkN2fAGZR69mrDQ4XzzBoMTVJvfksR9hc0oSEBT+lIkcdGaglPIddeL/nDjOxzQo9+E6oMQmruRpJcp/F2hhsRnbCBae+c6LtCVq4ip6UM7/AA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TvarfK+/S0ecrg6zLY5Xsxmr2UJbcp8fz2EdH8BHRX4=;
 b=DlGCa/rW4h/f3fVXVHK4iYRbWC8RWPjKPMVXi4FY5GJRz4eH0zytljnup7E9fWimzBJqrIXKWAv8VbBd/B3BqFEwG74B+gQgWmnSJ6todeVO52LF2XqxI27EWWYV6NC4MlmvwiqJmiI+OTEy6uU/AkuZvIyGrT7KjkvvaMNwSfI=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4162.namprd11.prod.outlook.com (2603:10b6:405:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:41:20 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 16/18] dt: bindings: net: add microchip,wilc1000,sdio.yaml
Thread-Topic: [PATCH v3 16/18] dt: bindings: net: add
 microchip,wilc1000,sdio.yaml
Thread-Index: AQHV66743VR7q8PFykyysBAemJauEQ==
Date:   Tue, 25 Feb 2020 07:41:19 +0000
Message-ID: <20200225074105.7740-17-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b6f4032a-1dd9-4e2b-666a-08d7b9c61b2b
x-ms-traffictypediagnostic: BN6PR11MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4162CFB76A1B0B6020C7FBDDE3ED0@BN6PR11MB4162.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3173;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(81156014)(2616005)(8676002)(186003)(6512007)(6486002)(5660300002)(26005)(81166006)(8936002)(6506007)(54906003)(66476007)(66446008)(66556008)(316002)(966005)(86362001)(4326008)(71200400001)(66946007)(6916009)(2906002)(76116006)(64756008)(478600001)(91956017)(1076003)(36756003)(107886003)(142933001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4162;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: i1A7ItX0clFCBc1Z12L0oWhfcatzrvSsMynUBGoHumxIP72bUBA1aOMJPsPgakw/IqhWXO5AZWZd3sNX0AXRAkikgQJagZp2NgT/TYbVD6EggobnssDw+u/mmE9sU/Hc9fLzGh8TI/GsFIbmV6JQpN9bkbmsLPzhfiC2cbEwECWGySDaEEsVp95CMP6tseJhM1FogU40jLt6UJLJN+wo0wOsEiTMavE1u1HGYuQtocedM6s2bTADBtvxJX4D/DzsZfsfXrs/m6xae0EdJYlDLdkqEm0e4kB0UvlUQ2SojPtnq4MUiVCyywbzcIjP5poGJBjcDzzL6lALkjjdk1El+K35wu+bCoO2eK8NvRQzwKMTXlXV9I+N10osS06iyv6W34JXgp4Qx5BRv3btZDRQWdHgiqeUm7UTHZTQyOg2R80UBuhUF0kQcuTHAqDv4Z2bW8bEMpYMSlV4ZIXneWORGgAn9gtd+EHE6rn2zWOzr7V8QzDlmc14qGaBjZgaueK7xiRGXnW5flMit9oTMoFQlEPan8c8PbZwhPWttVRGpdwnokqSE5fX3vF42sLh5nZr
x-ms-exchange-antispam-messagedata: xcGPYLV968RR5OwzhcWmshey693RYKDHuvtkSFo6kj4haeruP7j/4DrLmuZtPfZqg9Bz62hKhaD7y+ANglxxvMZ7F7dJCQYrCeEyC2fdqWyMvMQGw0Tp8szyWr8S7S6jNTzCTHNHmzOHw53l4gJyoA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b6f4032a-1dd9-4e2b-666a-08d7b9c61b2b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:19.8611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cZ4kiGaTqiqGDdbNQhTF4Tq98wvnBu95n6ZCVHHs3gkdbYrQu4X+/JUlVHMQuQN1MScrWQP9107Z6TCx7aHsxOlbHmSWjL+nVTefmYyb24g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4162
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
