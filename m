Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC8EA15D6EA
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728987AbgBNLw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:27 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38153 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728427AbgBNLwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:25 -0500
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: kFrWksIESHNHWy58kc+J788uewWR83V4KIoHxkGZw77O0gTwbnthhBZJz3uCZrmeUEI9QN9Kai
 sRR+Rq6etqiShyJdqq/77QpQoS14LWlnPSqLWk/WGzkMvGtJkQb/XcxPjS7mdR28Tr2CVSZgMh
 e3Op2AMl3kwkNkE+6YXm8dbS3UkrhBZSKKIjTo2yDtQl913eaX0kSy0UcFVoLonhIEzcvZpMN2
 9hbAGT/U9X3vudHHKwziMcWaPCOPFA+L2Tqtf5AeK6zUIt6GB3b5HSeeJ7QXG0BPHjjvpGvR8c
 7lI=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="2407530"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:24 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:24 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpKxN1a+xj00F1i5Yh4xFsHtlYloc8nlXZGGM1MX261HfsxBXJbXTUGnx6aIlTPDKHs/eHCsE1ZWw8Z3d7sDNq9n6zsKKyvCIAWzbJUvyv9gaBdpR01KHG6FDn/OfThyASGuNusiKlReqd62eittTatwg5apU0l7w3eMnq38QIORbmOO/tJ2zZbtfuMcG9sTsnL5UedrCv+hw4IsDuRaLYT71DdGbliy567X5FWMAcl8PKKWol1EqZHouNnBgQ0dOd1Ag4c8akaD+hH1T/D1+8fB3LFe1+yTEjz2dm+O3JcLRvdsc9aiQoiQgbEkqugHW1jxBepXm/+SW3YOWA4/NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWlBmo6jxY/3TKM5si9sreXGoVrjbUsBaxMKlnx0ZF4=;
 b=kiXVMnoUdvJjfJW5Lor6zX5tLO7+T1vgFLMDxLFqS8YoMnY9vPsiuYcTP2/RBkq4iI3lQghshfVvwQRUN3hDmhC9AfP397f0RzcjE9YYR28t0n08+APAwTIgePzxFnVqKpLvnisaUq33uzS5RKIK+xeI5zt9jaH8P42QrbCL3GSqgF0AIIDawLbyJcDOuQ59DJOzmVwAYyT8RTg8aHiXnwr9IW/rFWJQ+TG9+BzjswUdSrRpUUxoE4XdxExKOgHOerT8Bffzs716extPpBjqPmwdJpUjV+mShIsXEyUOpd7r44hAdTrU1SzPCZdi8epd8FUzW9VWMQccGmYiXaqL4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JWlBmo6jxY/3TKM5si9sreXGoVrjbUsBaxMKlnx0ZF4=;
 b=LBwZesNUBOA0/dI9ISXfAZD+bsK+y56WRCDrkP9iyDONs6149+9fzFOjg2Vn8Z2V3y93U63p3nb9giYgazUtg1yxNWmG8OXVEB1rPHmTRkzCR7qDIMGFuqbKnw3H3F6gjiZFfburdwMd+l0MABlUuRcdoThiPcDpjfzxRQypCfQ=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:22 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:22 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 7/8] staging: wilc1000: use short name for hif local variable
 in chip_wakeup()
Thread-Topic: [PATCH 7/8] staging: wilc1000: use short name for hif local
 variable in chip_wakeup()
Thread-Index: AQHV4y03I2fF2LfS3US2FIJ4hO+iQQ==
Date:   Fri, 14 Feb 2020 11:52:22 +0000
Message-ID: <20200214172250.13026-8-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1d2c1f2d-c696-40be-87d1-08d7b1445a52
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16523BD71A9066DF3D8C3603E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3968;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jux6EI+BodbxUo338Wdw3xJh5RgdVd36XMHb9l0ipGbbrBRoBwUL4hhDlsWWmvOV4cG8nUpPiWmW3aTft9p54p/mK8DoPmf/emoiYGidGcZrB38jcr7e6Z45F9oqhUv5sY6E3MAD6G4eylvOztklRouQNnFys1wzuLBUg6PMdVvPOns1BwmwxR80sRgunpHOqZqTMj/todPmW5qRhirp5xyIR0H1QrOkJO0JBwptkoScklaSL7YPEMtvWkVs/9eOKgXPN5KFuqh1fF/hL8aYoPM+MAM03C2LfvQZjfal4e7SIgqHRxIlb0oqKRyDVvXv0wXiDQ2dughdpqlIPyZ6qfWspiBfhlLiLBK1AgKsx4UnYmL8vDihfrg0nU4BcL4dMcUQVomldOf6z9dR9sKkAtCOM6DCfmWZOdxTegEaYtUVd/W8QP4FVtLhNhBhfH0N
x-ms-exchange-antispam-messagedata: slNiZihQq8sO0kl6m++Jo5OSL46hVv2+mYnR24f45e08DApYMVWGhAr/grCMj5DWjaAwTS5js5P8Q5CO6PFM2Zcm6tTKX3JiH9Pqj737g67L56PbJDkbfz3Gh9JSo7phJVmjTXhfPp7hWVhUkCgYgQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d2c1f2d-c696-40be-87d1-08d7b1445a52
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:22.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JMy3YtgD+jJeIHOwwYsFOpeStfJ7bjByLIjxKS0ebRlaRviBrn/c7ovTutNCiKXbpKdMa+2+CHjZOb7XjRz0A1Xpp6ECu91a5ZHz54Tqs44=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use of a shorter name for 'hif' variable to avoid possible 80
character checkpatch warning while the replacing hardcoded value with
macros in chip_wakeup().

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wlan.c | 35 +++++++++++++++------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index db4ef175ccee..31f424efe01d 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -403,37 +403,34 @@ EXPORT_SYMBOL_GPL(chip_allow_sleep);
 void chip_wakeup(struct wilc *wilc)
 {
 	u32 reg, clk_status_reg;
+	const struct wilc_hif_func *h =3D wilc->hif_func;
=20
-	if ((wilc->io_type & 0x1) =3D=3D WILC_HIF_SPI) {
+	if (wilc->io_type =3D=3D WILC_HIF_SPI) {
 		do {
-			wilc->hif_func->hif_read_reg(wilc, 1, &reg);
-			wilc->hif_func->hif_write_reg(wilc, 1, reg | BIT(1));
-			wilc->hif_func->hif_write_reg(wilc, 1, reg & ~BIT(1));
+			h->hif_read_reg(wilc, 1, &reg);
+			h->hif_write_reg(wilc, 1, reg | BIT(1));
+			h->hif_write_reg(wilc, 1, reg & ~BIT(1));
=20
 			do {
 				usleep_range(2000, 2500);
 				wilc_get_chipid(wilc, true);
 			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
 		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
-	} else if ((wilc->io_type & 0x1) =3D=3D WILC_HIF_SDIO) {
-		wilc->hif_func->hif_write_reg(wilc, 0xfa, 1);
+	} else if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
+		h->hif_write_reg(wilc, 0xfa, 1);
 		usleep_range(200, 400);
-		wilc->hif_func->hif_read_reg(wilc, 0xf0, &reg);
+		h->hif_read_reg(wilc, 0xf0, &reg);
 		do {
-			wilc->hif_func->hif_write_reg(wilc, 0xf0,
-						      reg | BIT(0));
-			wilc->hif_func->hif_read_reg(wilc, 0xf1,
-						     &clk_status_reg);
+			h->hif_write_reg(wilc, 0xf0, reg | BIT(0));
+			h->hif_read_reg(wilc, 0xf1, &clk_status_reg);
=20
 			while ((clk_status_reg & 0x1) =3D=3D 0) {
 				usleep_range(2000, 2500);
=20
-				wilc->hif_func->hif_read_reg(wilc, 0xf1,
-							     &clk_status_reg);
+				h->hif_read_reg(wilc, 0xf1, &clk_status_reg);
 			}
 			if ((clk_status_reg & 0x1) =3D=3D 0) {
-				wilc->hif_func->hif_write_reg(wilc, 0xf0,
-							      reg & (~BIT(0)));
+				h->hif_write_reg(wilc, 0xf0, reg & (~BIT(0)));
 			}
 		} while ((clk_status_reg & 0x1) =3D=3D 0);
 	}
@@ -442,13 +439,13 @@ void chip_wakeup(struct wilc *wilc)
 		if (wilc_get_chipid(wilc, false) < 0x1002b0) {
 			u32 val32;
=20
-			wilc->hif_func->hif_read_reg(wilc, 0x1e1c, &val32);
+			h->hif_read_reg(wilc, 0x1e1c, &val32);
 			val32 |=3D BIT(6);
-			wilc->hif_func->hif_write_reg(wilc, 0x1e1c, val32);
+			h->hif_write_reg(wilc, 0x1e1c, val32);
=20
-			wilc->hif_func->hif_read_reg(wilc, 0x1e9c, &val32);
+			h->hif_read_reg(wilc, 0x1e9c, &val32);
 			val32 |=3D BIT(6);
-			wilc->hif_func->hif_write_reg(wilc, 0x1e9c, val32);
+			h->hif_write_reg(wilc, 0x1e9c, val32);
 		}
 	}
 	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
--=20
2.24.0
