Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6320610799F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Nov 2019 21:52:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbfKVUwH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 22 Nov 2019 15:52:07 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:44168 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbfKVUwG (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 22 Nov 2019 15:52:06 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com -exists:%{i}.spf.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: OJOiQWufm5oLVMdxwsg7fzxHt0/XVWpDN25BUHFqli8htfi/PZklTYNkdOcIgmX9YvqLgqb8RW
 Je47UM3vIVMexaKSEnuDkwD4qTGKg8uQ2eieUNUSmlePS6pBcncxMVSh55NnOkkNve1P2nCfHv
 6uP49lgLf3e/aT5Pwm2CWKDiYONW6rXbm6V2EorXluQWrBtXrAl6ohn5Zsc4RSR09ah8OxmzQT
 2fEpz81B7235TT/jJlFF3T/TAidJYpUECU3cgKowjTDOxW75sNDPkkxhZGgv5frhbcyAd9EwpF
 k8I=
X-IronPort-AV: E=Sophos;i="5.69,231,1571727600"; 
   d="scan'208";a="57656079"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 22 Nov 2019 13:52:05 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 22 Nov 2019 13:52:05 -0700
Received: from NAM05-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 22 Nov 2019 13:52:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y1yovavYnKV1hXO9HzsTk3Bjm9RMygZNNOqNddBYvlMBVDcbipxQbHTkUDsnKAJIzwIGTtiL2/eVvmEpEAe3Z+BWcTfE0Wd+jPKWi3mHjMi4fP2dVxyynnEQaJnN0gmmt16l3qPL5aZpbehwbPzRNSzXTFx4FDUdymVYBPKigQhTUPNkh9V83T89P3EXPIwPsMkaksHiahE3hyXfSv4FbIOsNg9+Tfdy7335cc25CVaxa25AMmUFppk4pJrngPngXCrzFs7M4GR332Wi9JULaVzNW5jJsjgVh1Yj/uIAvSdivaGQcBdaWTpiSXyZ7xZAnijw0dm4umaSFR90ICQk5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcQOXd6HZqhxdYx4Y0YG55oQIuketf/2I5Dz3iybv0Y=;
 b=gIXq6WG+cIVMM2yCIEBtgL/SglKvUC0Q/c8VEIFxMvHipyXg7QNngLkXRzA+8Gqn8OxkEmmaWa7MxTZfQm8dMlgXipfUu6ZhE/zgYVpsvWIonjR4jWcMl+mCvmDfsY9c/k8+6llaSjCwb0Jvp9bxwZdoNolJq1Rx2Ii49oJoGfllqKDI7GPAvoJjQwftQmmjyVQCNnLeBAQLY2Y5fDPdSkvOPPdkffe8jZHybb0oUq+m/T1KleFbN5mOGm8FcAZp7tyRcg47GpNDy+oUZuvaeVgVt41CdqG4DBlEl5ArTwcWJeSwI1l5w5XNhSExJT5w/Jhb43VcWveWwWFgthVTWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XcQOXd6HZqhxdYx4Y0YG55oQIuketf/2I5Dz3iybv0Y=;
 b=M5BdCFej02kSB+srW6ty8VJRf4KDXXIxQIYGwSMo5jMwaxuwX3L2cpLLHnVvzXuvoz6rpkGuesoWSn8Iv7kPsApRhVinhXM8fEFDExhhf544LsIiSMIWJ7GPis1A1ByAB9E2e1SAoRAlaN1rYuhXj73pdyFL1Kp19QyhOpTz64Y=
Received: from MWHPR11MB1373.namprd11.prod.outlook.com (10.169.234.141) by
 MWHPR11MB1472.namprd11.prod.outlook.com (10.172.54.144) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.22; Fri, 22 Nov 2019 20:52:02 +0000
Received: from MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::fc6d:2ed:d470:fb56]) by MWHPR11MB1373.namprd11.prod.outlook.com
 ([fe80::fc6d:2ed:d470:fb56%8]) with mapi id 15.20.2474.019; Fri, 22 Nov 2019
 20:52:02 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/4] staging: wilc1000: use runtime configuration for sdio oob
 interrupt
Thread-Topic: [PATCH 1/4] staging: wilc1000: use runtime configuration for
 sdio oob interrupt
Thread-Index: AQHVoXawsACklCtDcEijfkbhUigNzg==
Date:   Fri, 22 Nov 2019 20:52:02 +0000
Message-ID: <20191122205153.30723-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR03CA0028.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::41) To MWHPR11MB1373.namprd11.prod.outlook.com
 (2603:10b6:300:25::13)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5cdaa1e5-201c-4e81-afa5-08d76f8dd360
x-ms-traffictypediagnostic: MWHPR11MB1472:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR11MB14723FE428090955CDD853478D490@MWHPR11MB1472.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 02296943FF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(396003)(136003)(346002)(366004)(376002)(189003)(199004)(316002)(66946007)(7736002)(8936002)(107886003)(81156014)(81166006)(186003)(66556008)(6486002)(26005)(66066001)(99286004)(6506007)(5640700003)(4326008)(6436002)(52116002)(71190400001)(71200400001)(1076003)(5660300002)(14454004)(6916009)(2501003)(102836004)(2906002)(386003)(6512007)(25786009)(54906003)(66446008)(50226002)(3846002)(36756003)(66476007)(256004)(64756008)(2351001)(2616005)(8676002)(6116002)(86362001)(478600001)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:MWHPR11MB1472;H:MWHPR11MB1373.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: =?iso-8859-1?Q?nJfcbuX00r8r6key/5BPkfSEOGklBPJAGYfl4tzIAX6LYh+ZEM2HMaUK4f?=
 =?iso-8859-1?Q?L3TDwV8QX05U79bkSvy1iDaqqRhayzBs4bAqxVVQkMFpEcQA8al9FPE5Ow?=
 =?iso-8859-1?Q?6WCHwYYENmCVoy38BwIdzTuck4iQ+ZhxYZU6zKWamjBUIp/+jWxOr3d0hG?=
 =?iso-8859-1?Q?p44GQtWFLlMqSUrb8ZaxIAdVSPNDJsKQDY/9O2DwRR3YyM+MSR8lx+IYPL?=
 =?iso-8859-1?Q?ikTE+ii+/PB/gjGfY79AScO2c8JwttzVXLjkDAheRWj0t9SufCuH6sRXS0?=
 =?iso-8859-1?Q?qRRrBL9uxblIgmTpv8wruAAfoeOvGeBe2JB3ZDUl8Z8+mClmFiRlRizdkW?=
 =?iso-8859-1?Q?0ZTf7IRHl1GA5aTTzFsDtUlxA8GCEFnFCUeSBL8QjMRXZb1qv9vrRzbQAJ?=
 =?iso-8859-1?Q?00dEpyBtItJEk+fm60wQlkP+NVa/SZHFWY0pQjn79L06PqweXtz8Qr5fCt?=
 =?iso-8859-1?Q?yFQgFefEHzvRSTbDEb4/2ZGzmg3H0nID0V2j82tIzSdmakAaja96qAMxkT?=
 =?iso-8859-1?Q?ZplVxlTlGHnc60ZKGXNpflX2eoWxW+0AnNlQe7V3t/TBOkSFiWHD43exa+?=
 =?iso-8859-1?Q?V8FQ8qoSQlA8ktonfnTu3JGD7YB8M8rTQBnCHDBFg8CJiSLTY9y1uN7kec?=
 =?iso-8859-1?Q?/4ENH9RxxIcl2d+d+5IRMLri+jMhBVVf71lLLbX9FOhXhqSUHlbhcHJ6J5?=
 =?iso-8859-1?Q?a+Gyr6b0E4kvFd3OqWUHQkzUB8/6GRfsD4K5YUEebZt/0HrDAMiWgc7t3h?=
 =?iso-8859-1?Q?OQnmq89srGBNr/OXlrUkRpvhsSAQxg/scN5Kw7z+jstYJhgtxxk/hUZoBJ?=
 =?iso-8859-1?Q?XDT0if/eTyF+Ny+qizWyPB++L5gCme2bVCOBqnUc1vxRZ6u5lze79pRWvY?=
 =?iso-8859-1?Q?pPsdJd2HvPMsesT269AqX5jgNPoUD21WmBCVH4Qh7IDxhiw4CIp4Z0rCsY?=
 =?iso-8859-1?Q?Vi/JkTqukXmW+V73z14jRfrg1g3GlKOqQ7FCuzYHi1wevm83n4edwY0RXD?=
 =?iso-8859-1?Q?35WSYsY9+QGhuWqdAt6LEXxuirmBHmtykamcrBKcJ4UpuwmL5hVaGTZkNT?=
 =?iso-8859-1?Q?dsdJ+nE6lcXwUY2oGu0sGHM4lXPtjypvytHIxnzkQvXKcJ++iC8AP/ujEa?=
 =?iso-8859-1?Q?VXlPXZzefuPKt7wnr4WpmsRsqFXxaN4b3jAwW4e7Ousy8ZEhy6dqyHUy74?=
 =?iso-8859-1?Q?S6VcSM9+ctpLGWeRg9xzyB5tySWZr5f6PlWEWw3ytjc4nJFuhCrOVm4zqj?=
 =?iso-8859-1?Q?zSlS37eN8MZSuHPsyzoQzErNLeLOYkd1qgMuTwXb5cQtIC9k79CeRCfDQF?=
 =?iso-8859-1?Q?j57n38DnI42vvoXSbdZVVFaj4A6iYSYA0GYcj82zo9lGQ537W9j1bYcta2?=
 =?iso-8859-1?Q?mH9xbIZsIkxxT5xZjgez5MHFYaU8kqYpUDnX39WI6Qd91C5zP2rx76M0sF?=
 =?iso-8859-1?Q?wKG4eluXVulkmCEoWq0nyZpt4eh3A17ckuqhQhCHrBeD6bP7hI4rD5aX8K?=
 =?iso-8859-1?Q?0XlT1kOMeMyLp3BHA0chiz8xa/7OwxEZO//q+3j6SEDQeoNytl3MjefBzr?=
 =?iso-8859-1?Q?nTYDuGUCOb8xDJb2Ya32uZ8yobUP4fqaB+Y6imXtiJKukjaVHMINQRILOx?=
 =?iso-8859-1?Q?9rhvsATehyDfZsQAuGcCx3v+qUWsr9YaYwPg/TJfRQl8QjC3MLv7t9+u73?=
 =?iso-8859-1?Q?Isspn2SAI8pOp+2m7M7MMDPs4bDcuV2YkSyzOTgJNiEGlxF0AIO3Kl2nFJ?=
 =?iso-8859-1?Q?91GA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cdaa1e5-201c-4e81-afa5-08d76f8dd360
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2019 20:52:02.5994
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3oPdIokbQpXdozG2bOzoeAPor1aDgHX0PYHl6hQPCadNFbk0E+5aNosgzCkFqf8ObEVZybk6GElldVlOvGvw9Xshn3v3YsxZfxfSCCqyC78=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1472
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Set SDIO Out-of-band interrupt configuration at run time by passing
parameter during module load.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/Kconfig | 10 ----------
 drivers/staging/wilc1000/sdio.c  |  7 ++++++-
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/staging/wilc1000/Kconfig b/drivers/staging/wilc1000/Kc=
onfig
index 59e58550d139..e556d3c9039b 100644
--- a/drivers/staging/wilc1000/Kconfig
+++ b/drivers/staging/wilc1000/Kconfig
@@ -30,13 +30,3 @@ config WILC1000_SPI
 	  full-duplex slave synchronous serial interface that is available
 	  immediately following reset when pin 9 (SDIO_SPI_CFG) is tied to
 	  VDDIO. Select this if your platform is using the SPI bus.
-
-config WILC1000_HW_OOB_INTR
-	bool "WILC1000 out of band interrupt"
-	depends on WILC1000_SDIO
-	help
-	  This option enables out-of-band interrupt support for the WILC1000
-	  chipset. This OOB interrupt is intended to provide a faster interrupt
-	  mechanism for SDIO host controllers that don't support SDIO interrupt.
-	  Select this option If the SDIO host controller in your platform
-	  doesn't support SDIO time devision interrupt.
diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 319e039380b0..098094ab5156 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -11,6 +11,11 @@
 #include "netdev.h"
 #include "cfg80211.h"
=20
+static bool enable_oob_interrupt;
+module_param(enable_oob_interrupt, bool, 0644);
+MODULE_PARM_DESC(enable_oob_interrupt,
+		 "enables sdio out-of-band interrupt support");
+
 #define SDIO_MODALIAS "wilc1000_sdio"
=20
 #define SDIO_VENDOR_ID_WILC 0x0296
@@ -131,7 +136,7 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	if (!sdio_priv)
 		return -ENOMEM;
=20
-	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
+	if (enable_oob_interrupt) {
 		gpio =3D gpiod_get(&func->dev, "irq", GPIOD_IN);
 		if (IS_ERR(gpio)) {
 			/* get the GPIO descriptor from hardcode GPIO number */
--=20
2.24.0

