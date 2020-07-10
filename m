Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8A021AE70
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2020 07:21:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgGJFUs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 10 Jul 2020 01:20:48 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:28893 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725966AbgGJFTA (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 10 Jul 2020 01:19:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1594358339; x=1625894339;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EwKxLflnNQ3Cs8U/J0bt4/m/SZ1h3tDv0qw7rVVPBnI=;
  b=MUZmXdHXN35T8Jq5kojilFxvO/KNxo0HnKlro9T21A7ddS15O5F03ORF
   +f/gnapI/2f+NJV9tVOBlUvy6Ax1IiMtOiOfGTgLP/zcU/0ocgSHERR1d
   nAarWH9tIsGJ6fy0ye5+bWpd5X/rCXJ5DlREM5wie7e0bJVDQB8ZV+LTK
   1hQQFhgjuMm8CEbtzNA2t4OBWRVpDBTosWbWDp58e3YD6O0PhHSWKInpt
   SBOkzW/1eCV7rSe8RSHXqk3UND4y1gnctCM5xLaMAnQwE83Hd5B2hzfW3
   /KLevyi9KA+8rD5Trm7H0EEf2HLcvSe9mxxa+FzvvZml3vH0DKLznZNV/
   w==;
IronPort-SDR: 1Yw0iO/a/QqUbS6GbhqnEOT/9vXltmKFdD7CBDGLYRknnJYnNrl197CJccBiDcMxSdVE3ilXUp
 yNt9tceFaW1yEKMFoIiWUJ7WWdSqkGxIz2J5vUkmf6kAcg7yvVVWLjW/lx+sJrouMGMt3GWpcc
 rBjnqFrtINcnzblJKNsKLxalMD6CDFUMW4Ve9McUjued+wY3pnF8j7ZP8X1kn0il7OzsFQI1X1
 MnZSIkUt2cD+pIHzrX1PI3Iv2qa0A7bQK3DZ1PVy9Sj/Rt99XJBEaRWXrzZuOD+bWaciy9cEkg
 N8g=
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="scan'208";a="82539359"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jul 2020 22:18:35 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 9 Jul 2020 22:18:05 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Thu, 9 Jul 2020 22:18:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sc83JrsEd9breS0N9EKHiv95o77+kNRzU0rBXkT/o0IJN2u/6al1JZJ90zTRaO919Ai32C7byPTA9rVKeKfZQms5gc3VP7b4lyR7u4yWV/zfp0deHf7XaJ927vSMOxdcBNRowy9a87bHlOLc98o7V9eTD2grfkQJCi/kIC3YI2ox7RjOp7ZkYQ5ydaOj7i8os/peA2xFbIyknBJFUgbHKJRB3O8gWfQ+07B06MQJri1Q71jdZR8EdJ6IeWxZTqcazOKCU9WWZ4Pgm7iNmfieD7NmZKZkQy4J90sTogMETujJzQGHsTkWGBS9zyWATM06xDL0FWfb88gKkSxXro4VMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LAzlgkGYqEp/t7GEl2gBZC0wzsfGlbME5+41aHIxAU=;
 b=X0PsIqnQ75UgQbLMF3eUzwInqsLKSLjThtq6l5mbVaaJbokjOLalJ2pmDGn2NyzbPeVPnzzinYR3DB4hXTYTJcB1VQBq0/aIqJniVTFn/yNkVQet5Qto8QEBwdJ20aIdromfBshvpg1cAiwBxaxQDBuD4+bZWEMm0jcWRWJmmeXM82aIS6+nmLCEc1IqXbug40gjwPVkHFqDH6k0e2CnbYdBSgyS6JvqLvkqtZn/sBrvPo2q2qTuzi12IGs4pPefCd0nGXxbgW8KBUO374ZQVSqNnWMZmQuhUSyyzpOV9WI/zXAMXKHNYIu/GY/hS3UaYPjtmmq/KwLcCjBHl0KUDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3LAzlgkGYqEp/t7GEl2gBZC0wzsfGlbME5+41aHIxAU=;
 b=LiDDhxWzd0E1KXsl36J03Dgyw5Hl9UERLX3X40Jap7DALgABt3JMZ2QCxbQ0TluTCtZel1soZtnneUl+Sjz3v+D2enOZVNPtkQyFzP3YXwKg7qGscm6OrJHlDWx6cq/PiGlTQW3jHkaPoqNF81G52DCRUpywjuvdd4GxbS5oSAc=
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
Subject: [PATCH wireless-drivers-next 4/5] wilc1000: use unified single
 wilc1000 FW binary
Thread-Topic: [PATCH wireless-drivers-next 4/5] wilc1000: use unified single
 wilc1000 FW binary
Thread-Index: AQHWVnmN/7GFufJWcUuxIpCgE4RRPg==
Date:   Fri, 10 Jul 2020 05:18:31 +0000
Message-ID: <20200710051826.3267-5-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 93e9e3fa-c8da-43af-d43d-08d82490af86
x-ms-traffictypediagnostic: MN2PR11MB4128:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB4128272E08DF19BFBA0FBF3BE3650@MN2PR11MB4128.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:196;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jko5nE4unCvQugBte5QZ3XL9LKAk1ed8GnOSNr8J0xLwgObBq8WNeyQQBX/gZdGHa1tU4pZZOff/3KeldrnTiJK3vmsvBTV0kD5tIzuXvpF+d9skaySkC8B9HRI4uoAA9GrOFGwBXKPngzbDTdR7pfJk2DtXj92bsJ53keQG2oij82ctrKFq6XveoR2j5JMCDQYmLuVz38atCR9wug4XS4BOHlo/4PFapeq2SFXxFsiXZOIrHsAajJC/JWJphAYuP898of2RI5ufGfTBikgo6tiSridO6NRVyYLxk/GVIo0zhEyAgfIJOgQwfbzLBVKbgg2Oxa0tjEj6cA2u5P/h4w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(136003)(39860400002)(346002)(366004)(376002)(396003)(2616005)(36756003)(186003)(6512007)(26005)(66446008)(66476007)(83380400001)(66556008)(8936002)(71200400001)(64756008)(8676002)(6486002)(2906002)(4326008)(478600001)(107886003)(86362001)(316002)(5660300002)(66946007)(54906003)(1076003)(76116006)(91956017)(6506007)(6916009)(55236004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: XPJFariYAaRg/paxrZoJPG2H86Vutkl5MbsIXuhfcitaigSVIr9uDGPyee6KRpiJcYB/H3Mn4Ymt3qD+/nd8h0HzizwJ7ibof1Dp8HXYxd5YHphsXovOUEVsVJeLoFbaU1BoiYoy/i0ilN2RsqlMj294InnHTb+eV3f/Kl5TJwUJCA20RC5n3OHVm2oyQJh4UhOU0naPR04/+TP5he9hUi8m7SWiWCX9HQ+fYooChBFindwMzAjDmpSv1SYwvRI0dkQtxXamldHdZtqU7Jmg8RrknWK1/4agHNoBTxUeWKlgF2y3Sy15t0uiYm6V9u4LDDDGpP+SaoDGL5iSlOnxzFmkFcC/KLsAAyghUdXOjz7nQdfgaBQgU4GKWqyng4xr2eYAn5O9jv/S7g1lIcKUZgYutCi5J7H7w45E4+SMqHlA+KT0wCEisdEmumhaJTlnm5ASGwlJy3RDf05vhF0MN+QBeHkI/PIu8bGB+e+a4UtxnWpcO1+gjxSjLHjG3Wrp
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR11MB4030.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93e9e3fa-c8da-43af-d43d-08d82490af86
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Jul 2020 05:18:31.0945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sWhVH9Qe8iTvpRycnkd50lVA81yYyQGw1TC9NeikNHE5G+lgy8f3sFmCNS4pjM3Lospaa8eHTINS/fnSkaaM9u1nmTY7DXDSKatbiPmkNw8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4128
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Modify WILC1000 binary filename to use single unified wilc1000 FW.
A single wilc1000 binary is used for different wilc1000 revisions.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/Makefile   |  3 +--
 .../net/wireless/microchip/wilc1000/netdev.c   | 18 +++++++-----------
 2 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/Makefile b/drivers/net=
/wireless/microchip/wilc1000/Makefile
index a3305a0a888a..7d1ed5f40cbb 100644
--- a/drivers/net/wireless/microchip/wilc1000/Makefile
+++ b/drivers/net/wireless/microchip/wilc1000/Makefile
@@ -1,8 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_WILC1000) +=3D wilc1000.o
=20
-ccflags-y +=3D -DFIRMWARE_1002=3D\"atmel/wilc1002_firmware.bin\" \
-		-DFIRMWARE_1003=3D\"atmel/wilc1003_firmware.bin\"
+ccflags-y +=3D -DFIRMWARE_WILC1000=3D\"atmel/wilc1000_wifi_firmware.bin\"
=20
 wilc1000-objs :=3D cfg80211.o netdev.o mon.o \
 			hif.o wlan_cfg.o wlan.o
diff --git a/drivers/net/wireless/microchip/wilc1000/netdev.c b/drivers/net=
/wireless/microchip/wilc1000/netdev.c
index fda0ab97b02c..1005526ae896 100644
--- a/drivers/net/wireless/microchip/wilc1000/netdev.c
+++ b/drivers/net/wireless/microchip/wilc1000/netdev.c
@@ -176,23 +176,19 @@ static int wilc_wlan_get_firmware(struct net_device *=
dev)
 	struct wilc_vif *vif =3D netdev_priv(dev);
 	struct wilc *wilc =3D vif->wilc;
 	int chip_id;
-	const struct firmware *wilc_firmware;
-	char *firmware;
+	const struct firmware *wilc_fw;
=20
 	chip_id =3D wilc_get_chipid(wilc, false);
=20
-	if (chip_id < 0x1003a0)
-		firmware =3D FIRMWARE_1002;
-	else
-		firmware =3D FIRMWARE_1003;
-
-	netdev_info(dev, "loading firmware %s\n", firmware);
+	netdev_info(dev, "ChipID [%x] loading firmware [%s]\n", chip_id,
+		    FIRMWARE_WILC1000);
=20
-	if (request_firmware(&wilc_firmware, firmware, wilc->dev) !=3D 0) {
-		netdev_err(dev, "%s - firmware not available\n", firmware);
+	if (request_firmware(&wilc_fw, FIRMWARE_WILC1000, wilc->dev) !=3D 0) {
+		netdev_err(dev, "%s - firmware not available\n",
+			   FIRMWARE_WILC1000);
 		return -EINVAL;
 	}
-	wilc->firmware =3D wilc_firmware;
+	wilc->firmware =3D wilc_fw;
=20
 	return 0;
 }
--=20
2.24.0
