Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 04A17ADADF
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 16:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405255AbfIIOM2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 10:12:28 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:53660 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405252AbfIIOM2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 10:12:28 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 5kiwmUK8Ewd45hWfyo2pA6INogFRY+uVi7RbOvNKZVk4p4jLRiy2jqm/QF1lrAgZz7TtUlrzlA
 D6EPnt3NLsBiVVRR8yfS2vEbeq6qnlnnnVO2p0p5DDR9YqEsTOy3oNDl4SxV5sDOkcYp2GGWP3
 mQHRJLEnksJADVcGxHgs0iIjzco2iXvHb3Vw7g6ytfS11SE5sKId2pMKkfmJYE5lBbNfLIOhoy
 Wg8mz0Pq/yUuYLjmx6Svlt47xIB9WG3YCcNs2pquI9H5iCKmnAiEcqCAaHQOBxQCUjBmfGWfEc
 C7g=
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="46739463"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2019 07:12:28 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 07:12:27 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 9 Sep 2019 07:12:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=STxf0lcmzjrOspVCVvB7hZV4M+/zklmPJnR0Twc39ef3bQR/fMc0MO7kIIxnw80JGviemgj8PSuIDQBwLV6w+aZuZHiPacgsAW+savfWNivNWmrNCQoQAkru+UFrqCNhMmgFoA8tXPqSrsXps+duj3ewCevCmnTgs+1MQXZYU4knl+kT+j8+TCah4iYdQunC1eyBFNiRri4NOp/WVpI6NvXGp0NTtEjzCFx+2Uy4a6BGt7QGHlfKwAdignTeF2Z4iaPVS22pZLg0YDFttiknGhsUTKR2KmNLemO4v2lLg5vK+Vkwew4wjRPyp2nqd80RJVNywyKv8eM5hXf7kiuAhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Lh24QEQmaHqB01e3FpfPH0zlF9cF7bsFyhwHxyBUY=;
 b=R2HNqoCpuOxcRZRmvYKAYNFTL3ns57TZvK04kf6Kopv0C9u5mU9mktUENf0wbEZOKbmS1odzwpwqBE8LC/qHNp/D2O94b87kMG6sqrG6XDZf/T8ARFPUFvEMmWUv4uSB9p/nhf/rf9F/tTRZcIryzxiIfh4zaH+VyMl/Nun3EVjwb93DVB/ZSokqqAXjjitUbuUao2R5Z5dj3meFMusFuZOT9Ln0POnXC9JveSUA9v/6j/6FdUE4eHVERucK87+gLy51ezn4jfp9M1ugmT9zp+5FadUKZxAiTzxsleeEo+fNQMwJqNG1rcrSVg0HEkXRoYfYBW2CowYQunwNluMc9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+6Lh24QEQmaHqB01e3FpfPH0zlF9cF7bsFyhwHxyBUY=;
 b=lOHNYexDFczOxmLoBPHYDyV7VFe0nhv0HBX8yhhLmnyIVafsizjfDE+5ntyIEtCNBDhRmORkXJsT8HV+k6pEJ+vefj3FZDjWBHjcsvjtOpvh0sq3ezgpN2Nx9oK1Q2X8hBv0m7axFP5/FlWeyNiWSgl4KvfQqzWTmO0JRNHQpeo=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1596.namprd11.prod.outlook.com (10.172.37.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 14:12:25 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 14:12:25 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <Ajay.Kathat@microchip.com>,
        <gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 1/2] staging: dt-bindings: wilc1000: add optional rtc_clk
 property
Thread-Topic: [PATCH v2 1/2] staging: dt-bindings: wilc1000: add optional
 rtc_clk property
Thread-Index: AQHVZxiavmpLh0KgOECjW3gs9jSV7g==
Date:   Mon, 9 Sep 2019 14:12:25 +0000
Message-ID: <1568037993-4646-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0080.eurprd09.prod.outlook.com
 (2603:10a6:802:29::24) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 57d44e7b-29ce-4306-c272-08d7352fbd0d
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1596;
x-ms-traffictypediagnostic: DM5PR11MB1596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB159670C85EE8D5B5C9E00D27E8B70@DM5PR11MB1596.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(2501003)(3846002)(6116002)(4326008)(81166006)(50226002)(186003)(26005)(8936002)(2616005)(476003)(486006)(71200400001)(71190400001)(81156014)(8676002)(66476007)(66556008)(64756008)(66446008)(25786009)(7736002)(66066001)(66946007)(305945005)(102836004)(6506007)(386003)(5660300002)(316002)(99286004)(54906003)(110136005)(14454004)(256004)(14444005)(36756003)(2906002)(6436002)(107886003)(2201001)(53936002)(86362001)(6512007)(52116002)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1596;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 8OG3VdMYesZikVrNSRD/62AefmtM8ExVlQwAqrcQn++Zm4lOWGx6wJJroWRQ/lJu0N46q4J1ACj1D235w4EYhyG3mvgppzIR1+uRjAWyI2If+ZZMJPhxamsywkj8HZCzCWgI7rmptAHilRSeg7xFNTGR/33EAAMObxbjfRkV4O3F4ZhUHjJ5ijzNi7mBYzZqD3n4n+zOydR2QC5n6aXijZ4M2VUmhj9U2hgQIPVsKH001jERSoqUCXag07W7/FGlEK/sprMclkFkAKStq8iyI9cKkW+Bzf9bcEtVjaClMEdB2nTkCtSOk9Akwm90HtRuM9qYw8Iq21qurqLq/o509ZlKtJFtrWUZ4luYF4TCX/hYzwnEcaUZkT0DTQ7K6cG5L0AfX/5aC6XgPhM+p32XIXwRUlRUY+3mGeZKl5M6PuA=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 57d44e7b-29ce-4306-c272-08d7352fbd0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 14:12:25.1363
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kXczfmnkTgxMbvnIXpyhbXM5MutSu3nYYLOyH0s+bv3qItZ51ponnEbedDelNxi9JwCIyaE6/K+eBImVaJwfqdXTAYWZTtK9T63NWPNBI/0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1596
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

Add bindings for optional rtc clock pin.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
---

Changes in v2:
- none

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

