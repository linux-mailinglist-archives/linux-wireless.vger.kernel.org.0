Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8448917C0BA
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Mar 2020 15:44:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbgCFOoI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 6 Mar 2020 09:44:08 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:36892 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgCFOoH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 6 Mar 2020 09:44:07 -0500
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
IronPort-SDR: IdyBzn8gZcLGbaPLf+AdDBtGyD/ndVKn5XWjpOEfXe94sHdvrKvFhFlwoqBrdayHFbJG/bpWHy
 qkRM9ma/0xCxRHw/QxhENQJy4Lf0zCtBfTlmnXni4+qHCOD6UfAnPN1wOGut89A/0oWQQDagky
 5cP09lrDjBkFdftvRA69rFMvoXx02NOPAOzBQV/anTNuyLkd0LD/4OS1Hy6Dz++nBLEYmPc2VX
 t2GN+vqFje1LAQ2jh8e2AQ+cwEEYoeBELeHN+qGtnNOrFDuyWNaAeqdsEPheUhAC4R6sXOyxm4
 ugM=
X-IronPort-AV: E=Sophos;i="5.70,522,1574146800"; 
   d="scan'208";a="71088665"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Mar 2020 07:44:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 6 Mar 2020 07:44:05 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 6 Mar 2020 07:44:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YAMWqrbEHCWupKNal2kxxSdqDNWdkSC2FdtrB/ZfBNYOVir/GnXKqGcteKolC3Qgvu8U8IMyu72XwrDX42MQBCpVGBzYyOUuXzpsgwkf75EbzfKNWEYelmlvyrRl7nJhgAjgW7rVOIcvLtMflzbEbUOB39tFTNBW6K4dElh2WemZapTIerbc+UBqAbgGXmAQXGP9ncGUUWa/j/1LXmNuIDHf41ZHLcW8z5MKCVk7MPYYFZ/crLQlzHMwQAwAtwvzGP4wMBaNUW0fgvuKecECJ2vITwgUBjGoyw2PyK3WeLF84j5OjTdYBpHayDJ50KzVOVu9kGziqRTEI/TY7ZxBOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+JuC77O5ziNokcNq6Mgvrnj8K/x1oJVU14p2hiMFUk=;
 b=J2FKxrPF1dbxQklk+ReKQJFdRZ600Ply1PTRGMazAvYzbgkQSOWlPVXbclwGv5TTnNm49qlBYqXa6VlR1AG6d18m6wT/gYiQfuU88RBk/bj0yTwFYGOzokcnW8v2GSFYPYlxkMpYUpT186BYlSB3js8ifjPtw9P7fOx3K7638+/xoDkvx4x1MXnbtuSm8vHDW9XY+PWH41cfp4VvqqsTOHAjVCJVqvQ+lJSVKH7kCTw6yW79JFM7u2cBJJvktt5Fvr4dUW7KQfNH/GZJixqBOdQxZzPXncCbN2QqWZjsSWty5uNJ1R4FrVIym/qby4Z8KkJdC9h163bemHlGOnlp+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L+JuC77O5ziNokcNq6Mgvrnj8K/x1oJVU14p2hiMFUk=;
 b=N6QqnMH3qAXWC/TOSa1mYeGpQKj7yAml2CKr7anGdZFDhqYzshuQjaaGGnnvEXTebyajj1F6gQV4azZzMfSklk78H2QIO/gwg6wUfJbfzZewndyZ/IB6JPJZzHLn4G2yXK7yy3feMlfe/zpNU+MlmoUM7EJhHhJQaXxWTN4Yb8E=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB1362.namprd11.prod.outlook.com (2603:10b6:404:3c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2793.15; Fri, 6 Mar
 2020 14:44:04 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::a0be:9e7c:714e:e2bd%6]) with mapi id 15.20.2793.013; Fri, 6 Mar 2020
 14:44:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <Adham.Abozaeid@microchip.com>,
        <johannes@sipsolutions.net>, <robh@kernel.org>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/2] staging: wilc1000: use 'interrupts' property instead of
 'irq-gpio'
Thread-Topic: [PATCH 1/2] staging: wilc1000: use 'interrupts' property instead
 of 'irq-gpio'
Thread-Index: AQHV88WupU/867Y5g0u3Z47AmpcYLQ==
Date:   Fri, 6 Mar 2020 14:44:04 +0000
Message-ID: <20200306144400.4269-2-ajay.kathat@microchip.com>
References: <20200306144400.4269-1-ajay.kathat@microchip.com>
In-Reply-To: <20200306144400.4269-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [49.205.218.40]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 45dd51ea-e824-4377-f98f-08d7c1dcd184
x-ms-traffictypediagnostic: BN6PR11MB1362:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1362886ABF1A1F841022EEBBE3E30@BN6PR11MB1362.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 0334223192
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(39860400002)(366004)(346002)(376002)(396003)(189003)(199004)(2906002)(81166006)(6506007)(5660300002)(6512007)(81156014)(64756008)(6486002)(4326008)(8936002)(8676002)(36756003)(91956017)(66556008)(76116006)(71200400001)(54906003)(66946007)(66476007)(66446008)(2616005)(316002)(86362001)(1076003)(6916009)(966005)(107886003)(478600001)(186003)(26005);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1362;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y4pnyMUC/6n/ZT6xBVQePt1Q0SfMOTUg8Wzv2Y7Dc+mQnpK3e+db3l7rsk9hyXJeNdscdoL9y7LQ+Vgt48130lPMS6dz8JdOiL2eHqhAGHcWddg277q8qZIoDAaKh3gNFXsZ/Y5ijCUpEqMFDO0OcGj/w3SMQKYiyReKoaW8MBNQPUQM65KhQMz9f5kcP/ZzDFG2ApYTiY56n/6ItWTONqylMpVAPjqVOJvwbQpBgxugazzuOWh3xH5/7zQrpgeSNYo/ZDM2wVaNMBBosKlgc9sofDnHefl33CYChr9zlzrHxhiFvq6nVo4fbdX+UPWJahMH5HJ5o0KrwZ/V+0N7Z8dSmj/VR5LfUetOjgp1gsNPnjmIy4nV0rBA/f8NSdW8QnFIEB/rYlFuRwx4wjIio2n0aBcB/Yjz2n3ksgBa87Fa5SJRX37xnRrjjh2QQDzixkTtVARSwMBMRWNdqL/21iFJwtWgv1awJ6+daDLFFJ+CGTHkH8BhK9oOGGTs1VZH
x-ms-exchange-antispam-messagedata: T80WkTgCjgcv6JVthYtF+b+EddOqeRWXU9PCdC/MlBNew5/q3vHvWwZvdY34THfJDQCekdEB7gCg0lk6jCQEnp1YgvspswncPCGK5+jseVW4yCPH6tTrbJ247Oze1bN23snaqus3qmQvPD3Efv+gCw==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 45dd51ea-e824-4377-f98f-08d7c1dcd184
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Mar 2020 14:44:04.6534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uxseXKGiaxaCQYFDI6Npyg34li0VxX2Xm4ZYoqS9adhwSBXCA2hxvmr3td1rBuao7bOw6wpmjDgWUHWKhmTdpelDLbATIZX9s1esYdTXAdA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1362
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use of 'interrupts' property instead of using gpio for handling
the interrupt as suggested in [1].

[1]. https://lore.kernel.org/linux-wireless/20200303015558.GA6876@bogus/

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip,wilc1000.yaml      | 79 +++++++++++++++++++
 .../wilc1000/microchip,wilc1000,sdio.yaml     |  8 +-
 .../wilc1000/microchip,wilc1000,spi.yaml      |  8 +-
 drivers/staging/wilc1000/netdev.c             | 24 ++----
 drivers/staging/wilc1000/netdev.h             |  1 -
 drivers/staging/wilc1000/sdio.c               | 31 +++-----
 drivers/staging/wilc1000/spi.c                | 15 +---
 drivers/staging/wilc1000/wlan.h               |  1 -
 8 files changed, 108 insertions(+), 59 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/wireless/microchi=
p,wilc1000.yaml

diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1=
000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc100=
0.yaml
new file mode 100644
index 000000000000..a1914449ad07
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yam=
l
@@ -0,0 +1,79 @@
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
+  spi-max-frequency:
+    description: Maximum SPI clocking speed of device in Hz.
+    maxItems: 1
+
+  reg:
+    description: Chip select address of device.
+    maxItems: 1
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
+  - reg
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
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml b/driver=
s/staging/wilc1000/microchip,wilc1000,sdio.yaml
index b338f569f7e2..9df7327bc668 100644
--- a/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
+++ b/drivers/staging/wilc1000/microchip,wilc1000,sdio.yaml
@@ -19,8 +19,7 @@ properties:
   compatible:
     const: microchip,wilc1000-sdio
=20
-  irq-gpios:
-    description: The GPIO phandle connect to a host IRQ.
+  interrupts:
     maxItems: 1
=20
   reg:
@@ -40,7 +39,7 @@ properties:
=20
 required:
   - compatible
-  - irq-gpios
+  - interrupts
   - reg
=20
 examples:
@@ -56,7 +55,8 @@ examples:
       status =3D "okay";
       wilc_sdio@0 {
         compatible =3D "microchip,wilc1000-sdio";
-          irq-gpios =3D <&pioC 27 0>;
+        interrupt-parent =3D <&pioC>;
+        interrupts =3D <27 0>;
           reg =3D <0>;
           clocks =3D <&pck1>;
           clock-names =3D "rtc_clk";
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml b/drivers=
/staging/wilc1000/microchip,wilc1000,spi.yaml
index cc8ed64ce627..dd5e8da1f562 100644
--- a/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
+++ b/drivers/staging/wilc1000/microchip,wilc1000,spi.yaml
@@ -26,8 +26,7 @@ properties:
     description: Chip select address of device.
     maxItems: 1
=20
-  irq-gpios:
-    description: The GPIO phandle connect to a host IRQ.
+  interrupts:
     maxItems: 1
=20
   clocks:
@@ -38,7 +37,7 @@ required:
   - compatible
   - spi-max-frequency
   - reg
-  - irq-gpios
+  - interrupts
=20
 examples:
   - |
@@ -51,7 +50,8 @@ examples:
         compatible =3D "microchip,wilc1000-spi";
         spi-max-frequency =3D <48000000>;
         reg =3D <0>;
-        irq-gpios =3D <&pioC 27 0>;
+        interrupt-parent =3D <&pioC>;
+        interrupts =3D <27 0>;
         clocks =3D <&pck1>;
         clock-names =3D "rtc_clk";
         assigned-clocks =3D <&pck1>;
diff --git a/drivers/staging/wilc1000/netdev.c b/drivers/staging/wilc1000/n=
etdev.c
index 045f5cdfdca0..a61c1a7aefa8 100644
--- a/drivers/staging/wilc1000/netdev.c
+++ b/drivers/staging/wilc1000/netdev.c
@@ -46,29 +46,21 @@ static irqreturn_t isr_bh_routine(int irq, void *userda=
ta)
=20
 static int init_irq(struct net_device *dev)
 {
-	int ret =3D 0;
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wl =3D vif->wilc;
-
-	ret =3D gpiod_direction_input(wl->gpio_irq);
-	if (ret) {
-		netdev_err(dev, "could not obtain gpio for WILC_INTR\n");
-		return ret;
-	}
-
-	wl->dev_irq_num =3D gpiod_to_irq(wl->gpio_irq);
+	int ret;
=20
 	ret =3D request_threaded_irq(wl->dev_irq_num, isr_uh_routine,
 				   isr_bh_routine,
 				   IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
 				   "WILC_IRQ", dev);
-	if (ret < 0)
-		netdev_err(dev, "Failed to request IRQ\n");
-	else
-		netdev_dbg(dev, "IRQ request succeeded IRQ-NUM=3D %d\n",
-			   wl->dev_irq_num);
+	if (ret) {
+		netdev_err(dev, "Failed to request IRQ [%d]\n", ret);
+		return ret;
+	}
+	netdev_dbg(dev, "IRQ request succeeded IRQ-NUM=3D %d\n", wl->dev_irq_num)=
;
=20
-	return ret;
+	return 0;
 }
=20
 static void deinit_irq(struct net_device *dev)
@@ -501,7 +493,7 @@ static int wilc_wlan_initialize(struct net_device *dev,=
 struct wilc_vif *vif)
 		if (ret)
 			goto fail_wilc_wlan;
=20
-		if (wl->gpio_irq && init_irq(dev)) {
+		if (wl->dev_irq_num && init_irq(dev)) {
 			ret =3D -EIO;
 			goto fail_threads;
 		}
diff --git a/drivers/staging/wilc1000/netdev.h b/drivers/staging/wilc1000/n=
etdev.h
index e3689e2a4abb..61cbec674a62 100644
--- a/drivers/staging/wilc1000/netdev.h
+++ b/drivers/staging/wilc1000/netdev.h
@@ -209,7 +209,6 @@ struct wilc {
 	const struct wilc_hif_func *hif_func;
 	int io_type;
 	s8 mac_status;
-	struct gpio_desc *gpio_irq;
 	struct clk *rtc_clk;
 	bool initialized;
 	int dev_irq_num;
diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 2301e90c21ca..44b426874c1b 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -8,6 +8,7 @@
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/sdio.h>
+#include <linux/of_irq.h>
=20
 #include "netdev.h"
 #include "cfg80211.h"
@@ -122,33 +123,32 @@ static int wilc_sdio_probe(struct sdio_func *func,
 {
 	struct wilc *wilc;
 	int ret;
-	struct gpio_desc *gpio =3D NULL;
 	struct wilc_sdio *sdio_priv;
=20
 	sdio_priv =3D kzalloc(sizeof(*sdio_priv), GFP_KERNEL);
 	if (!sdio_priv)
 		return -ENOMEM;
=20
-	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
-		gpio =3D gpiod_get(&func->dev, "irq", GPIOD_IN);
-		if (IS_ERR(gpio)) {
-			/* get the GPIO descriptor from hardcode GPIO number */
-			gpio =3D gpio_to_desc(GPIO_NUM);
-			if (!gpio)
-				dev_err(&func->dev, "failed to get irq gpio\n");
-		}
-	}
-
 	ret =3D wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
 				 &wilc_hif_sdio);
 	if (ret) {
 		kfree(sdio_priv);
 		return ret;
 	}
+
+	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
+		struct device_node *np =3D func->card->dev.of_node;
+		int irq_num =3D of_irq_get(np, 0);
+
+		if (irq_num > 0) {
+			wilc->dev_irq_num =3D irq_num;
+			sdio_priv->irq_gpio =3D true;
+		}
+	}
+
 	sdio_set_drvdata(func, wilc);
 	wilc->bus_data =3D sdio_priv;
 	wilc->dev =3D &func->dev;
-	wilc->gpio_irq =3D gpio;
=20
 	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc_clk");
 	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
@@ -164,10 +164,6 @@ static void wilc_sdio_remove(struct sdio_func *func)
 {
 	struct wilc *wilc =3D sdio_get_drvdata(func);
=20
-	/* free the GPIO in module remove */
-	if (wilc->gpio_irq)
-		gpiod_put(wilc->gpio_irq);
-
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
=20
@@ -592,9 +588,6 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	int loop, ret;
 	u32 chipid;
=20
-	if (!resume)
-		sdio_priv->irq_gpio =3D wilc->dev_irq_num;
-
 	/**
 	 *      function 0 csa enable
 	 **/
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index dfd25df75780..852f318a86f0 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -151,21 +151,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 {
 	int ret;
 	struct wilc *wilc;
-	struct gpio_desc *gpio;
 	struct wilc_spi *spi_priv;
=20
 	spi_priv =3D kzalloc(sizeof(*spi_priv), GFP_KERNEL);
 	if (!spi_priv)
 		return -ENOMEM;
=20
-	gpio =3D gpiod_get(&spi->dev, "irq", GPIOD_IN);
-	if (IS_ERR(gpio)) {
-		/* get the GPIO descriptor from hardcode GPIO number */
-		gpio =3D gpio_to_desc(GPIO_NUM);
-		if (!gpio)
-			dev_err(&spi->dev, "failed to get the irq gpio\n");
-	}
-
 	ret =3D wilc_cfg80211_init(&wilc, &spi->dev, WILC_HIF_SPI, &wilc_hif_spi)=
;
 	if (ret) {
 		kfree(spi_priv);
@@ -175,7 +166,7 @@ static int wilc_bus_probe(struct spi_device *spi)
 	spi_set_drvdata(spi, wilc);
 	wilc->dev =3D &spi->dev;
 	wilc->bus_data =3D spi_priv;
-	wilc->gpio_irq =3D gpio;
+	wilc->dev_irq_num =3D spi->irq;
=20
 	wilc->rtc_clk =3D devm_clk_get(&spi->dev, "rtc_clk");
 	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
@@ -190,10 +181,6 @@ static int wilc_bus_remove(struct spi_device *spi)
 {
 	struct wilc *wilc =3D spi_get_drvdata(spi);
=20
-	/* free the GPIO in module remove */
-	if (wilc->gpio_irq)
-		gpiod_put(wilc->gpio_irq);
-
 	if (!IS_ERR(wilc->rtc_clk))
 		clk_disable_unprepare(wilc->rtc_clk);
=20
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 5999c5490ea5..7689569cd82f 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -206,7 +206,6 @@
 #define WILC_TX_BUFF_SIZE	(64 * 1024)
=20
 #define MODALIAS		"WILC_SPI"
-#define GPIO_NUM		0x44
=20
 #define WILC_PKT_HDR_CONFIG_FIELD	BIT(31)
 #define WILC_PKT_HDR_OFFSET_FIELD	GENMASK(30, 22)
--=20
2.24.0
