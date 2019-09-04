Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 83358A848C
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730408AbfIDNeK (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 09:34:10 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:61249 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfIDNeK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 09:34:10 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9dw5Mu3yhRdDcPFjSifBpK+zJ3Fx6AgA/qBqGpnFGoxWh7h5uiAadfGZT14N3VNZmx3nXt5VQq
 wW+x2xBvxSE88TtLB+L9gkd/y6b9Xw+l5tV17ZfEbOWAWgg07pa8xW6qw8DpI9WGJcyVDKGh24
 sA1j7iIG5pfvIEOxrmEAkOdidFxXHKsvU4TjDw0eZXIxvC8pgZEh1pBqlzZSUgjzY0wLUbU8X/
 33E01owDmo0Wh3iN9Ga6Xj1tF3mclC2FLl8WG2L62ox0uCeg6ox+jcNnOsQUap//lRotPgH9zR
 iYk=
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="44886834"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2019 06:33:59 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Sep 2019 06:33:59 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 4 Sep 2019 06:33:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PoD+cN6xnTjIJhIusdi48GLFU5maKM6lk1w6nyHeTX5RLerlZNs54hSnUES2MKiYFFUd23zWtq6SMiqhNaq2VzBwa4VM48f+X4vw7kVqhtrWTNAZxrzcQbjNgRCsuUW38ds+nwbEC4ED7tov8zWLl6cRw2pbowg5LxTGM0CSNyM8jPHLirtvU32ivuphCDup7Db+6UxcacxkO1cdVPVZ+e2AHXCGbF/DM/gQPd+pu8+v5+a7RwXUPVKtlXoSIfbp4tQ2SAzePY1mQ+e6lZo7UjTVvVhxXjPkLC55jvq/0wXwRO+EPoBqf3GGJXIk5pujaWRPOZyd6dlKVQB/Z85bGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98r8VA+FBvuG3VHyYEAgjOVqSria5MDROp5XaDP8ggE=;
 b=hW303OuouJAqR5wEDOlFU1+ENISuTO+bDopMFwasKiE4Ssxz7QjoHdeqdpls0evhtZctGryd08nEyGQOlluReV7ST3dLJ+VgsxuikV+KqCt64DQ9E1c+d3AJZWXZ4oI5PKph/k28VUDrN0ZQebMqDLPQdQyC57MvdIoktOXk49/W7SfNaFFi/grzqUaJ71PjqfmkM2SDw2lfj3fpYYhICW0oU0ICXcdq6eJmbRnjRrVP5TXZl4BW8PtVHmpw4qLDLn7ZX00E8gN+ykW5QriQI7lo24c8QXB8b3Ba1beUW3Emud33jkQwN8GvoexFcp3AoQyE5bj0lbdUt85EPx6W2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=98r8VA+FBvuG3VHyYEAgjOVqSria5MDROp5XaDP8ggE=;
 b=dumOSBT70/dmps/e2WYO0qJXv0BN4nG3Pf/tvj22RR0Vk90R4Xplj4g1Dl588W7bKYb02ptiFv2nwtaqHMmkrbC/on+QE42XQE1I+c7atE2uZCzGjSOAEtvASnn1XmyBt4sacwcKLb6zA+EKIdl9PctPFdXv1bncNyB6bon1xcc=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1786.namprd11.prod.outlook.com (10.175.91.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 13:33:55 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.014; Wed, 4 Sep 2019
 13:33:55 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <Ajay.Kathat@microchip.com>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Topic: [PATCH 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Index: AQHVYyVmBkghZ7w+IkiStodl6jvpxA==
Date:   Wed, 4 Sep 2019 13:33:55 +0000
Message-ID: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:28::11) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 15457870-b926-4380-f340-08d7313c887d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1786;
x-ms-traffictypediagnostic: DM5PR11MB1786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB17868C297A0E73E5560B5003E8B80@DM5PR11MB1786.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(8676002)(99286004)(6486002)(478600001)(110136005)(52116002)(316002)(86362001)(107886003)(2501003)(4326008)(2201001)(3846002)(25786009)(6512007)(6436002)(305945005)(7736002)(53936002)(14454004)(6116002)(54906003)(66476007)(66556008)(186003)(66946007)(102836004)(64756008)(256004)(2906002)(26005)(6506007)(66446008)(14444005)(386003)(5660300002)(66066001)(486006)(81166006)(8936002)(476003)(2616005)(71200400001)(50226002)(71190400001)(81156014)(36756003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1786;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7h6OhCJEIm7PuI15KWQ9CW7f5KTlM46hfTQJrUdeSzKuqilkmSfxowSOc+qbep1cuWyDNnNPsN2J8ohntEv4fFYhdRCk4THwaZnuklpPExxmDMSgdc5x6IC23udXCsBVUHP0k59CM5hlaBJKq4TTjSsph6roKJsXDmVxLRZFHktIr2R7bm3LXf0bVlMdXdCkHKERzq01rjVBDqiGZ7TyyzNUa2dYsS6W8DBzDRUbzKLoiVsWtmF13c4rWmOhqFM/+k7lFIQGC5m/vLFuhTYqw9ScEqL3VbizXapVpqkSGj3aU3+7DsPQ4Z7IExs9jcQZL0DPkE45Om4MyXkhWu7YCZ7F2aHpkH0CVkQnLOSCx/8tFeM1cwVeYj7lS2Cv3FjJ0VAwUDyVmqTIgh6VQULELJv9olttbVGDNUvx2xOcRhU=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 15457870-b926-4380-f340-08d7313c887d
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 13:33:55.7807
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0TPtse8eIEEYYGMtnqaLI16gd+AzJkPiGe02r6FZ+dh5KRj7/KlLVHhTVVhPQnmgZs1zNaK8/hw+zO8w03YWjsIIHZhOhcRASRYECGioZos=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1786
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add bindings for optional rtc clock pin.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/staging/wilc1000/microchip,wilc1000,sdio.txt | 8 +++++++-
 drivers/staging/wilc1000/microchip,wilc1000,spi.txt  | 8 ++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt b/drivers=
/staging/wilc1000/microchip,wilc1000,sdio.txt
index 4f7d1c2..da52359 100644
--- a/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
+++ b/drivers/staging/wilc1000/microchip,wilc1000,sdio.txt
@@ -10,7 +10,9 @@ Required properties:
=20
 Optional:
 - bus-width	:	Number of data lines wired up the slot. Default 1 bit.
-
+- rtc_clk	:	Clock connected on the rtc clock line. Must be assigned
+			a frequency with assigned-clocks property, and must be
+			connected to a clock provider.
=20
 Examples:
 mmc1: mmc@fc000000 {
@@ -24,6 +26,10 @@ mmc1: mmc@fc000000 {
 		wilc_sdio@0 {
 			compatible =3D "microchip,wilc1000-sdio";
 			irq-gpios =3D <&pioC 27 0>;
+			clocks =3D <&pck1>;
+			clock-names =3D "rtc_clk";
+			assigned-clocks =3D <&pck1>;
+			assigned-clock-rates =3D <32768>;
 			status =3D "okay";
 			reg =3D <0>;
 			bus-width =3D <4>;
diff --git a/drivers/staging/wilc1000/microchip,wilc1000,spi.txt b/drivers/=
staging/wilc1000/microchip,wilc1000,spi.txt
index 87db87b..3423693 100644
--- a/drivers/staging/wilc1000/microchip,wilc1000,spi.txt
+++ b/drivers/staging/wilc1000/microchip,wilc1000,spi.txt
@@ -9,6 +9,10 @@ Required properties:
 - reg			: Chip select address of device
 - irq-gpios		: Connect to a host IRQ
=20
+Optional:
+- rtc_clk	:	Clock connected on the rtc clock line. Must be assigned
+			a frequency with assigned-clocks property, and must be
+			connected to a clock provider.
=20
 Examples:
=20
@@ -21,6 +25,10 @@ spi1: spi@fc018000 {
 			spi-max-frequency =3D <48000000>;
 			reg =3D <0>;
 			irq-gpios =3D <&pioC 27 0>;
+			clocks =3D <&pck1>;
+			clock-names =3D "rtc_clk";
+			assigned-clocks =3D <&pck1>;
+			assigned-clock-rates =3D <32768>;
 			status =3D "okay";
 		};
 };
--=20
2.7.4

