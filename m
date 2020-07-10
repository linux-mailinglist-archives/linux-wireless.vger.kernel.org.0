Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B621AE77
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726925AbgGJFWd (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:22:33 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28889 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgGJFTI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:19:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358348; x=1625894348;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=l2+0rXca19dr7NRH/LsNBoT1ezEmVNY2DW9sIrPMSXM=;
  b=ywN2jOsF4hWR2IDrDPr28/uybRQrJu7RAYJJsn0LAWtXlo53AUC7KPdU
   rq9+4URw6s9FOSF/m7hCZQWfu2QGsTv1zM7tsyIc81NHj07aTpLpKP8hx
   qiw5pNFzLiNaXSqxeaF3qNyi1mEEqpMW0Z4J3NWyUtqm+ZS9VeLETqoVk
   ZlEQNxBmr0T6tFKB7AbddAOrUZYhpayBUezsOLfkkfOK+fK6FvrWvYsdI
   OM21zJQw1VsIuxkRj+Yv5I7JQFeDUk2PMIb2mKU/vdkWbsLGIm0t/T42C
   Xvgh+HI4e0kONs+SEHcHueE/MfyBt7nVFNmwoTx26v4dHcrObxcA2Jlzb
   w==;
IronPort-SDR: R17nd6fdhLH10F03Z/uKXuM+9aIFJUdaltudCX2JJ0Orh3NPjwXyGD174SRvkJ37LA4/sfVcZV
 tGxqoltKH5N8b1dk+0Obl3mtgJP1hchQAu6sq7GYt6+Sc6C2FY5cS8GJNFPi1YhnI3j/vMErZ5
 Zx95jUGnCGqgPuSPibp76bU8AvXSQ1rbyBu9KWqAJBRaN3QriDxPEd31kHa9p496v4Mywd5Etz
 ioBmtD1PO61I0CZjX3qqAzKF4bNg5nOGlJteG8iCCEhc5BikWoP2J2YBi3zvMfQ3skkK1tQ/hB
 +Og=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="82539360"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NWDjH1MCkL5wHggqJCnLyG02S0pdM7LLwKwjQcB9w7lwbQiiKUUkGVgCXk49dy1freg4L1L/eKhXWfoiEfgKX4E2K3Bff65GRXIHUfwEfACk4KBcJsryseAaLJ0WWGLUB3EX/6rPBrLrV67UsFj4OCZ4p8kZE/AShsoVFMPaxvob1sbY8LttOo93E1/vpO/Ne2PQSBZZbuqN6dbhbEosx7OYdyXIt96sthd14W+IMZCk7t9T2u4DeNXvfhP+jvp92agC3HOOyNoQCzu54tkZWcaI15rX/yz5TwcNDZKS3kux+5d+6R7DYG2NJrhhvAPjQTBRatJ5xTr0z77a6oTV3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzo3O8vWrPLBamQohZL/ZRDaLKE+rJfuDkStDSX4eH8=;
 b=GtoYtvyMl7DLpPP2QGO89KshkTCjeSKrT2IZSDrXQ50zslB1hp3s5lb/JNveHv2NFa35+UWX4i6Cp8kQXiXjeYaWeFAI/26TtG+tcgU3L5eWw3tW4WIpnrRaJ2YwvECOaKgkQfGoX6VwxjdlzcaIm4ASC2bs7SUkCwYGHSHvol8B8VhuW8DA+1JSnPMr97TM++XZ5pfOLs8tGP96GlBTdnyKgn0W4eI46d0nTlEtHdEntSGtKy9UxOk6aACWnUbydiEm/oD32yvjFsED32L0KVhmsAVrF6x+1mxfnU9vn8pu2c1xKqgEz8LO1axnD2UVstbjcD1SD8/7MYGTr4SpEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yzo3O8vWrPLBamQohZL/ZRDaLKE+rJfuDkStDSX4eH8=;
 b=FKgFnEa724VdnnnEQ2+ahK/1axCQ0vopDj00apZft0/Tt9TuYrIk6Y5E3VJl7NurefWcrZ4hIILdcyLk3WQl3MYfqOylnVgjiY3vyaeM0g/51fWKJpuRrM4ByXz4oQ43xChI3q4xBKxPkoD3J3pD5D/M4OPa/iW4h/y62VMxBRc=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB4128.namprd11.prod.outlook.com (2603:10b6:208:139::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3174.22; Fri, 10 Jul
 2020 05:18:31 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3174.022; Fri, 10 Jul 2020
 05:18:31 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Sripad.Balwadgi@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH wireless-drivers-next 5/5] wilc1000: use API version number
 info along with firmware filename
Thread-Topic: [PATCH wireless-drivers-next 5/5] wilc1000: use API version
 number info along with firmware filename
Thread-Index: AQHWVnmNy48lGSuBV0O6YXhxpnWyow==
Date:   Fri, 10 Jul 2020 05:18:31 +0000
Message-ID: <20200710051826.3267-6-ajay.kathat@microchip.com>
References: <20200710051826.3267-1-ajay.kathat@microchip.com>
In-Reply-To: <20200710051826.3267-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.205.82]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 53fac475-9abc-4fa1-c880-08d82490afeb
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB412897ADBFC165907ECD0D49E3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:230;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3Yu+ZEF51S8CYJlOwcRfa6IROnGJYOcEIVWHF9lRThVAj6qBGNSmyoXFp+WseGhiat+V7puwn2u6cXmgnNivN3s+YhDgxM48SaIOTj5IYG2gppMMMBZEUNdJi3TnygiaRt937SkQt4Jf1vAQ64kQAJ29kq9I9yIbin5hk1ysP8jneDS9Mu4UoLKZy75p8JAxmvWS6fXU+CRr7VkDqB/STltQ37xgEHSi3kxbJxF5W0DHII4zh3o40sHIwb6VayupZuUEAf3L0EZdjX9j2t3GiEe1YhJopu7flUTvZGj18YhgbAF4yFFByhHdGGqVMYy9
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: g7y/fUSHeww3hgDGN0SSus7zK/x9x492MtdOu6HIx9aBrvj4sq1FZ8UZ/J+FXy7B+kYvXDoDoIbysDX0XJxmueWtxvNWun3sbxUZ4UI9nnCfcdJvvQDGmdyrHZGpbMBfdcfyx9rwUqpHUqYrycMx+LA/O9ofHY+4oOhvx5SxW3Ssiwq3D68Sq0VmdksoypmOp+sfcqtFgaPk96xTjnwcoDSdtYWmiNvPypgeP1COmPH0gaiMzPu0C04sg+umqe+KMZQwJMdvhNOJ8ELw1Uj1U8frqnStFAvE5F60uLUFlY0sDx3b9UOjbM0EOHiBnt4M9toZXPF6zzi3B9dE+70ZgvI8uiqbT/ZASsWsHRniFn1ZICp1O2IsP3brZPLqXYdMEFj1dMhLMnXrmOf62YBLfoQ3ZggcgCQNNIIVkQYsBG0S0tGadNSXvLX84qWDGJDdQNeVh4xfNKH45YuFBTkHKWBbNxD8gOIpODtVa3WWvMhcZ5QZlsXYFewMhTF7fySI
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53fac475-9abc-4fa1-c880-08d82490afeb
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:31.7451
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UKQpnR0j1ZMAkidodCwBS7Uh9mO/QfN2QHLplejsTlNSBdF1UeU6xMZOANABd4QTp0KeweaSbaEScTw5nq0XYrJBXLmrlU6aLQ09MF3uU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added version number info along with firmware name so driver can pick
the correct revision of FW file. Moved FW filename macro as part of
driver code & added MODULE_FIRMWARE to specify FW needed by module.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/Makefile    |  2 --
 .../net/wireless/microchip/wilc1000/netdev.c    | 17 ++++++++++++++---
 2 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/Makefile b/drivers/net=
/wireless/microchip/wilc1000/Makefile
index 7d1ed5f40cbb..c3c9e34c1eaa 100644
--- a/drivers/net/wireless/microchip/wilc1000/Makefile
+++ b/drivers/net/wireless/microchip/wilc1000/Makefile
@@ -1,8 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_WILC1000) +=3D wilc1000.o
=20
-ccflags-y +=3D -DFIRMWARE_WILC1000=3D\"atmel/wilc1000_wifi_firmware.bin\"
-
 wilc1000-objs :=3D cfg80211.o netdev.o mon.o \
 			hif.o wlan_cfg.o wlan.o
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index 1005526ae896..198354670fe1 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -15,6 +15,13 @@
=20
 #define WILC_MULTICAST_TABLE_SIZE	8
=20
+/* latest API version supported */
+#define WILC1000_API_VER		1
+
+#define WILC1000_FW_PREFIX		"atmel/wilc1000_wifi_firmware-"
+#define __WILC1000_FW(api)		WILC1000_FW_PREFIX #api ".bin"
+#define WILC1000_FW(api)		__WILC1000_FW(api)
+
 static irqreturn_t isr_uh_routine(int irq, void *user_data)
 {
 	struct net_device *dev =3D user_data;
@@ -177,15 +184,18 @@ static int wilc_wlan_get_firmware(struct net_device *=
dev)
 	struct wilc *wilc =3D vif->wilc;
 	int chip_id;
 	const struct firmware *wilc_fw;
+	int ret;
=20
 	chip_id =3D wilc_get_chipid(wilc, false);
=20
 	netdev_info(dev, "ChipID [%x] loading firmware [%s]\n", chip_id,
-		    FIRMWARE_WILC1000);
+		    WILC1000_FW(WILC1000_API_VER));
=20
-	if (request_firmware(&wilc_fw, FIRMWARE_WILC1000, wilc->dev) !=3D 0) {
+	ret =3D request_firmware(&wilc_fw, WILC1000_FW(WILC1000_API_VER),
+			       wilc->dev);
+	if (ret !=3D 0) {
 		netdev_err(dev, "%s - firmware not available\n",
-			   FIRMWARE_WILC1000);
+			   WILC1000_FW(WILC1000_API_VER));
 		return -EINVAL;
 	}
 	wilc->firmware =3D wilc_fw;
@@ -925,3 +935,4 @@ struct wilc_vif *wilc_netdev_ifc_init(struct wilc *wl, =
const char *name,
 }
=20
 MODULE_LICENSE("GPL");
+MODULE_FIRMWARE(WILC1000_FW(WILC1000_API_VER));
--=20
2.24.0
