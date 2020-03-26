Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 220801942F6
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2020 16:23:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727347AbgCZPXk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Mar 2020 11:23:40 -0400
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:49855 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726296AbgCZPXk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Mar 2020 11:23:40 -0400
IronPort-SDR: m+gl4gc7QmAWNdWyXQ86x/tZnjoaYyZb1j+NzBCtGUY2Md6y9z2Vurkxri3XFFFcZAsEpB49uW
 bP3oBLthheHytNYu/2d02S1em+KgwlmlPQ/rQvF01EDWESo9cRVjDqAqeL1Z8uvXfYtDxWf06w
 9yqwEoDz23AgubNBstLt0u7ddyOzFOAXAxyYfUlBimWzNeUeWYcuE/Vp4Exw5h6P0HVLY3uGU4
 uVj23A+TWgCQrp8laeGxC52RrWl+fRta5x05y+vmWz5r2fI0EV8tUMVwjxCSD0M0aCNeOWK4bw
 6D8=
X-IronPort-AV: E=Sophos;i="5.72,308,1580799600"; 
   d="scan'208";a="73594206"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 08:23:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 08:23:37 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 08:23:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GReNFoig7ZKPmYtKjF1xzB64BI1mrmOzDP3AaSaTz4yVvOCs+OyDvpSt3N4DN0fuf2tBm1wtnUSGZI+F0BVHxeb5xr13uUtrc7AMuAHyctzjwiodhN+ZhhjPi/uukACxCnG4XabL8sSpYhyYa6KgLH+gj8Uq80OGJORg+vgVnNo6k8yV7FvcH4E4MMt0EdsDXpQwXO4N2v0KqXS5AMDosKGDiP9gObKd+YCVdOGiucSuOYJJ9MdQkwTAvj+C60aS+2zSrNSFmtCxZko6+19ZC46gJxCOXdzAUkLbjgmAuutSOrt2lUDZJ5KDWJegaMkiEdP+dhqwMpgcw575r3nzOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dorCgrnXaMzT+c51w5eXZJTrerAAX8jyZMs+2kK6AWA=;
 b=J2Pf2LlSZYnUfQSSux2A3T3OVr3RCihcRxpE17/pmT+M/5QS6GGrD5RmJds4zvQiHBezpaGX1oiEIVvkf246mdGK9IGN4rozjAhDiV83Zz7E6zNyPgpI2mZ1L7nl2l+SOPhfEnaluxBH/7uYWdQv8oo6nYo5t0BKshg9iy1ekKM8clJo8Wrt7PTqrFJ4v6GlIROM8PzuiUSZCXzF5ff9sUEysrZRmyb/sDUJbc/fo+0hG8M8lyVJycTB/PzkRfNEgSR17YP1/xR+mDWqmiiQGfNetQG7AcYdtX5DnDRJuVOe3GA2JhsTb1XnHYiB1tbMRYuE+sS0qefwcwAZ5FstXA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dorCgrnXaMzT+c51w5eXZJTrerAAX8jyZMs+2kK6AWA=;
 b=iWNG2ihueLeo7masAzyO2UbTilCO4h6jen5zo0fhZxP4G0pvF0k+BKyQiErsoTlrqjneg+zYa6x3Im62swwOEqPFw/l1y9HtQTorRGTPuZfN6C0sMAOg0UnU4SaH00TDh8+WXrKoFYY2uK2AWmFozNMhyWldJjbMwvMLraQrxMU=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3512.namprd11.prod.outlook.com (2603:10b6:a03:8f::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.18; Thu, 26 Mar
 2020 15:23:36 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Thu, 26 Mar 2020
 15:23:36 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <lkml@SDF.ORG>, <lkml@sdf.org>
Subject: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a private
 copy
Thread-Topic: [PATCH v3] staging: wilc1000: Use crc7 in lib/ rather than a
 private copy
Thread-Index: AQHWA4KEkW7XFxV0nkCn6WUH3cFHMA==
Date:   Thu, 26 Mar 2020 15:23:36 +0000
Message-ID: <20200326152251.19094-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9ae9ced2-48c2-4269-2a4a-08d7d199a753
x-ms-traffictypediagnostic: BYAPR11MB3512:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB35121D81F8B7CEE7C74337D9E3CF0@BYAPR11MB3512.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0354B4BED2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(71200400001)(76116006)(54906003)(6512007)(4326008)(66946007)(91956017)(6506007)(66476007)(66556008)(66446008)(64756008)(81166006)(2906002)(26005)(86362001)(5660300002)(478600001)(6916009)(2616005)(8936002)(8676002)(6486002)(81156014)(316002)(36756003)(186003)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3512;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OMy9tpt89dKBUFRaFf1CoSYZyPfTdoXrr9Qt8LTLv6X7LVfEByGn3kzn0VswXRU8rWgPF+dQcParAI0rB5OIFTx14HndFUpJsu0ZofxiVFJLJYi9TSeLviQyR2Gp0r84xaPEW0CptWUxJaTRdv1ODgj0kWSmpGA01HysuN69LsV5aUwjDTtspdjBHGTs69IXzCi0PlN6J8H8S125snumzOn9+EVLl9MKQttUuBMcHnVknqhQun4UTKAEjrxwQHA68mDd78UyR/Df/U+hvGsnlFsT4braaNqjmFFp7MdKQ0zEeAHaiwmrj88FtTYwXr8PhGiHhGvZwo4kfWru0Bd2yZuuYy+Wol13RKgEtroTSqsQfzXuVk9UxYUyMkQvsfgYea1mygsfggxXldRPTOixRDM2U6YcXj12ds8P4WU+GGudAG8sPyZgwUAIvcexKj06
x-ms-exchange-antispam-messagedata: hHOEKDlWRN34OF7lCsHOwsaFByNNhgbE9UIirTXgO/Mj9IhQ6ukeMrvb+N7qr4YJoXaq8BTDAJJNkk3pTTSDQ2+p4N25bXbE3Heoj8k8PI5skgLmPTFzEvok8P5eoMRSR0vXEmRxzTbR76yHsd9MJQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ae9ced2-48c2-4269-2a4a-08d7d199a753
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Mar 2020 15:23:36.2302
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tJOb/1v/jvFmjipoTBAcSX7IHarVLFNV2l0B9WCIaRY9cPgvuQbmxmPnlchXNS1YtzXyudIw1OWD+LvQhDMgCL3RejwnjJzaG9auu1P6dyY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3512
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: George Spelvin <lkml@SDF.ORG>

The code in lib/ is the desired polynomial, and even includes
the 1-bit left shift in the table rather than needing to code
it explicitly.

While I'm in Kconfig, add a description of what a WILC1000 is.
Kconfig questions that require me to look up a data sheet to
find out that I probably don't have one are a pet peeve.

Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
Cc: linux-wireless@vger.kernel.org
Reviewed-by: Ajay Singh <ajay.kathat@microchip.com>
Signed-off-by: George Spelvin <lkml@sdf.org>
---
v3: added 'staging' to subject and submit to devel@driverdev.osuosl.org

v2: Rebase on the staging-next tree

 drivers/staging/wilc1000/Kconfig |  5 +++
 drivers/staging/wilc1000/spi.c   | 64 +++-----------------------------
 2 files changed, 11 insertions(+), 58 deletions(-)

diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kc=
onfig
index 59e58550d139..80c92e8bf8a5 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -2,6 +2,10 @@
 config WILC1000
 	tristate
 	help
+	  Add support for the Atmel WILC1000 802.11 b/g/n SoC.
+	  This provides Wi-FI over an SDIO or SPI interface, and
+	  is usually found in IoT devices.
+
 	  This module only support IEEE 802.11n WiFi.
=20
 config WILC1000_SDIO
@@ -22,6 +26,7 @@ config WILC1000_SPI
 	tristate "Atmel WILC1000 SPI (WiFi only)"
 	depends on CFG80211 && INET && SPI
 	select WILC1000
+	select CRC7
 	help
 	  This module adds support for the SPI interface of adapters using
 	  WILC1000 chipset. The Atmel WILC1000 has a Serial Peripheral
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 8d4b8c219c2f..3f19e3f38a39 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -6,6 +6,7 @@
=20
 #include <linux/clk.h>
 #include <linux/spi/spi.h>
+#include <linux/crc7.h>
=20
 #include "netdev.h"
 #include "cfg80211.h"
@@ -16,64 +17,6 @@ struct wilc_spi {
=20
 static const struct wilc_hif_func wilc_hif_spi;
=20
-/********************************************
- *
- *      Crc7
- *
- ********************************************/
-
-static const u8 crc7_syndrome_table[256] =3D {
-	0x00, 0x09, 0x12, 0x1b, 0x24, 0x2d, 0x36, 0x3f,
-	0x48, 0x41, 0x5a, 0x53, 0x6c, 0x65, 0x7e, 0x77,
-	0x19, 0x10, 0x0b, 0x02, 0x3d, 0x34, 0x2f, 0x26,
-	0x51, 0x58, 0x43, 0x4a, 0x75, 0x7c, 0x67, 0x6e,
-	0x32, 0x3b, 0x20, 0x29, 0x16, 0x1f, 0x04, 0x0d,
-	0x7a, 0x73, 0x68, 0x61, 0x5e, 0x57, 0x4c, 0x45,
-	0x2b, 0x22, 0x39, 0x30, 0x0f, 0x06, 0x1d, 0x14,
-	0x63, 0x6a, 0x71, 0x78, 0x47, 0x4e, 0x55, 0x5c,
-	0x64, 0x6d, 0x76, 0x7f, 0x40, 0x49, 0x52, 0x5b,
-	0x2c, 0x25, 0x3e, 0x37, 0x08, 0x01, 0x1a, 0x13,
-	0x7d, 0x74, 0x6f, 0x66, 0x59, 0x50, 0x4b, 0x42,
-	0x35, 0x3c, 0x27, 0x2e, 0x11, 0x18, 0x03, 0x0a,
-	0x56, 0x5f, 0x44, 0x4d, 0x72, 0x7b, 0x60, 0x69,
-	0x1e, 0x17, 0x0c, 0x05, 0x3a, 0x33, 0x28, 0x21,
-	0x4f, 0x46, 0x5d, 0x54, 0x6b, 0x62, 0x79, 0x70,
-	0x07, 0x0e, 0x15, 0x1c, 0x23, 0x2a, 0x31, 0x38,
-	0x41, 0x48, 0x53, 0x5a, 0x65, 0x6c, 0x77, 0x7e,
-	0x09, 0x00, 0x1b, 0x12, 0x2d, 0x24, 0x3f, 0x36,
-	0x58, 0x51, 0x4a, 0x43, 0x7c, 0x75, 0x6e, 0x67,
-	0x10, 0x19, 0x02, 0x0b, 0x34, 0x3d, 0x26, 0x2f,
-	0x73, 0x7a, 0x61, 0x68, 0x57, 0x5e, 0x45, 0x4c,
-	0x3b, 0x32, 0x29, 0x20, 0x1f, 0x16, 0x0d, 0x04,
-	0x6a, 0x63, 0x78, 0x71, 0x4e, 0x47, 0x5c, 0x55,
-	0x22, 0x2b, 0x30, 0x39, 0x06, 0x0f, 0x14, 0x1d,
-	0x25, 0x2c, 0x37, 0x3e, 0x01, 0x08, 0x13, 0x1a,
-	0x6d, 0x64, 0x7f, 0x76, 0x49, 0x40, 0x5b, 0x52,
-	0x3c, 0x35, 0x2e, 0x27, 0x18, 0x11, 0x0a, 0x03,
-	0x74, 0x7d, 0x66, 0x6f, 0x50, 0x59, 0x42, 0x4b,
-	0x17, 0x1e, 0x05, 0x0c, 0x33, 0x3a, 0x21, 0x28,
-	0x5f, 0x56, 0x4d, 0x44, 0x7b, 0x72, 0x69, 0x60,
-	0x0e, 0x07, 0x1c, 0x15, 0x2a, 0x23, 0x38, 0x31,
-	0x46, 0x4f, 0x54, 0x5d, 0x62, 0x6b, 0x70, 0x79
-};
-
-static u8 crc7_byte(u8 crc, u8 data)
-{
-	return crc7_syndrome_table[(crc << 1) ^ data];
-}
-
-static u8 crc7(u8 crc, const u8 *buffer, u32 len)
-{
-	while (len--)
-		crc =3D crc7_byte(crc, *buffer++);
-	return crc;
-}
-
-static u8 wilc_get_crc7(u8 *buffer, u32 len)
-{
-	return crc7(0x7f, (const u8 *)buffer, len) << 1;
-}
-
 /********************************************
  *
  *      Spi protocol Function
@@ -403,6 +346,11 @@ static int spi_data_write(struct wilc *wilc, u8 *b, u3=
2 sz)
  *      Spi Internal Read/Write Function
  *
  ********************************************/
+static u8 wilc_get_crc7(u8 *buffer, u32 len)
+{
+	return crc7_be(0xfe, buffer, len);
+}
+
 static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *=
b,
 				u8 clockless)
 {
--=20
2.24.0
