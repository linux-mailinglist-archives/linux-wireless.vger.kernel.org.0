Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6454615D6E7
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgBNLw1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:27 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12309 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728595AbgBNLwZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:25 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 9mQBf00YgoWVBEC/SVAy1cTTA8uP1EJm1mwssT2HaC10Iibu8ns/Z+br5+1JfBplIpTrDpXPpL
 J+N329TI03+nLiBztdNVVaBK+r5jdYTjOqq0GjK8ePr/sHn0nBnts+AoMThocIQvf2QRPm7D4p
 ciMjkqb5efKGlrdZCWR8nXajgOHz+G5RlUJ6Cv8kd7qTutf3RG7wOTrqudblKgmScrLXGQntW4
 BbDavhR3xbe5aYIqd1fA6G29N1IwnDye2L6LCQX8RFWx7Utkp0rC+w2xsg25oBmopvUy9y55OG
 9ug=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="66696566"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:21 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bujOsUU1sJVn4tpNl6DdGNC8J3YBJbr2ec6oP5U8kofRMBQ14eLikPdKnAEzU0W7vKUqB6EFbXB9bLK2XwAf4PyOUD731RmA7jnGVSuu0GpaJ1Y2GjABmNhnVser2Ht5/3bnudVRfR2q2Y1H8ydhcqFOw4UFjmdKKxC2kaKA7aR3ax2DNXVjXlCCqySn7YmcRzTsTipnqttcEngPaJtK5F0T1sizJ3h5NY2ydxJyOqBPeWX+JN+PaX521UjuQrAfK8I0NU2KYTuOcfzxQrp6tvoe5Z8FOQIerBY+Uh17NuApSzkqkQo0ADyyWZ5f7n+kUCwW67+01w+x6HvNWX41YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTsTwpXVCcc/XEMlj+i3yx9evQXL+2DOj8hdRoHOWX4=;
 b=mwoDfktbzBAQaRLa7oQdFfXJwc3PqmE5eIBr3EPs/r6FP7NtUUJGl5VSSFZws9KsdzoHzuWJisi0/xLTraL3yGyGUJsYQ7AA2Feqi6nXdSgctV9g3MEe2QRdjnAinhv69iQQC+M6eIINjujKOpquaCLG5dlAyRHpei/COSEQK2tX7h5hTZ9lRURDZJ5ICWqvGMOoomSPyaztSjUrFGxYa0Hn6mhcxe7h/kguMnpxpa0PwXqpmI53a5RdYxyuLI4382iF3kaK60wd0GML86nO2fXPknXIQ0qAa6JFKTCERm+SuVSWOPvbLtVB35FLNoWTiXKsA5/8m+UGXw3oRvTlKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gTsTwpXVCcc/XEMlj+i3yx9evQXL+2DOj8hdRoHOWX4=;
 b=ZqMZ+YDLU1a2COZU7tGm7OX3zfI8+kASOkWPSfD42rESsLqxkUz31Tvh1Pp9or0opIJBLMLoAEqL1Foxe5KDfUdtSxaC4bPSjfCizKKQnNyyDNV+Xq5WVTCvc1WtuGxH8lg3jAIcdVZjRF1/6h+1fFr2RLcpB+UXMmqRkyXXizY=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:20 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 5/8] staging: wilc1000: use commmon function to set SDIO block
 size
Thread-Topic: [PATCH 5/8] staging: wilc1000: use commmon function to set SDIO
 block size
Thread-Index: AQHV4y023xTLXituAkSbMSiOMiI3jA==
Date:   Fri, 14 Feb 2020 11:52:20 +0000
Message-ID: <20200214172250.13026-6-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fdc85ade-116c-4853-2a01-08d7b14458da
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652906AFB6B5816E2F7FD37E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:65;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003)(49343001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L2s0vk1PF+w0IcT9kTGP9yAd7prl7xRE7Mhxwmx4kks0E/QFi05X2rzLQCtSoKXRDyN9M1OoUMOr+FR7Fl93gmseeqTn3t73qu26w5VtwVbJnATUCE/Ht3dsCNxSgUyxkonIxuMoNCUtkLVAAfYumR9l1OrL1uBRHkINd/jmkmnO1V/4t3B4TTJ0HsXiqYtZMaCPn+AyJ5ifqRAeI+S+3HzQw8hC9WUA6HABUrcTKVn0f4udoPVClou+MyG//cTqrHZhKx91BWNoaz9XkSreaJTDtWIp4cKzqjiT7KXciUvhwbD8mqUolAc0wQLGaG9hESllQiaX5tCt28lANU7lsP0GYl1Rk9SL97Ab47uxbKfPO2dmiAnyiZ9dnVOUtZPFN164s/GyPNNJgayF4GZR+nT59mhEjxLL9OIb2Fzpkr7XSFm3U/3p4O6fhBWNI3vErs8PSnG0eitdf0X9ATgYbdRaX4RVUSEHEWlouTT7nPcEsf2Zwz7AW/Y+cGyEphpQ
x-ms-exchange-antispam-messagedata: 9sDqqrvGeBKUeyu1ldUldDEj8QMS6qo0JmJsOHSE7xFSUjF2k0mOkVWeN2Ey6QQRI2rcqy0Hb6uPoDryZU7Vw3AFkNkNyPReGt78cpEYU6J1o9v+HdcCD4VHNy72rldZeF8HNKwFrfhG0mv98251lg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: fdc85ade-116c-4853-2a01-08d7b14458da
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:20.0241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIVZwi8cdpm+ykHslP+/sjWW+o127SPe0pdMht9Ncr3yEh7AtdqLSrMbNhWZT/FwisfYSSZbTj1fQp5tyXa9YykDoyK8xKefdODP5O+YxVk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Use common function wilc_sdio_set_block_size() to set the block size for
SDIO.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 51 +++++++--------------------------
 1 file changed, 11 insertions(+), 40 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 212affc4b9c1..57c0e8415bc9 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -7,6 +7,7 @@
 #include <linux/clk.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/sdio.h>
=20
 #include "netdev.h"
 #include "cfg80211.h"
@@ -292,7 +293,8 @@ static int wilc_sdio_set_func0_csa_address(struct wilc =
*wilc, u32 adr)
 	return 0;
 }
=20
-static int wilc_sdio_set_func0_block_size(struct wilc *wilc, u32 block_siz=
e)
+static int wilc_sdio_set_block_size(struct wilc *wilc, u8 func_num,
+				    u32 block_size)
 {
 	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
 	struct sdio_cmd52 cmd;
@@ -301,52 +303,21 @@ static int wilc_sdio_set_func0_block_size(struct wilc=
 *wilc, u32 block_size)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 0;
-	cmd.address =3D 0x10;
+	cmd.address =3D SDIO_FBR_BASE(func_num) + SDIO_CCCR_BLKSIZE;
 	cmd.data =3D (u8)block_size;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x10 data...\n");
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
 		return ret;
 	}
=20
-	cmd.address =3D 0x11;
+	cmd.address =3D SDIO_FBR_BASE(func_num) + SDIO_CCCR_BLKSIZE +  1;
 	cmd.data =3D (u8)(block_size >> 8);
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x11 data...\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-/********************************************
- *
- *      Function 1
- *
- ********************************************/
-
-static int wilc_sdio_set_func1_block_size(struct wilc *wilc, u32 block_siz=
e)
-{
-	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
-	struct sdio_cmd52 cmd;
-	int ret;
-
-	cmd.read_write =3D 1;
-	cmd.function =3D 0;
-	cmd.raw =3D 0;
-	cmd.address =3D 0x110;
-	cmd.data =3D (u8)block_size;
-	ret =3D wilc_sdio_cmd52(wilc, &cmd);
-	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x110 data...\n");
-		return ret;
-	}
-	cmd.address =3D 0x111;
-	cmd.data =3D (u8)(block_size >> 8);
-	ret =3D wilc_sdio_cmd52(wilc, &cmd);
-	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x111 data...\n");
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
 		return ret;
 	}
=20
@@ -638,7 +609,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	/**
 	 *      function 0 block size
 	 **/
-	ret =3D wilc_sdio_set_func0_block_size(wilc, WILC_SDIO_BLOCK_SIZE);
+	ret =3D wilc_sdio_set_block_size(wilc, 0, WILC_SDIO_BLOCK_SIZE);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, set func 0 block size...\n");
 		return ret;
@@ -688,7 +659,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	/**
 	 *      func 1 is ready, set func 1 block size
 	 **/
-	ret =3D wilc_sdio_set_func1_block_size(wilc, WILC_SDIO_BLOCK_SIZE);
+	ret =3D wilc_sdio_set_block_size(wilc, 1, WILC_SDIO_BLOCK_SIZE);
 	if (ret) {
 		dev_err(&func->dev, "Fail set func 1 block size...\n");
 		return ret;
--=20
2.24.0
