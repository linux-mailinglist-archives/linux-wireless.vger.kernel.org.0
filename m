Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CF3115D6E3
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728815AbgBNLwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:25 -0500
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:38153 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgBNLwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:24 -0500
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
IronPort-SDR: ZbV8FXUZeRDEaCvu95JUGdjVxVxSvpCVKc649iZrijDtylZ7QVQp07mhJVWQNJmLRzhLFYE0dp
 ykdsZSBxEBJv4PO1YYM5xcXAkr0O/NzFpYh5gTEKAPwSGL06aI6qaVYTCWvBvS8EYzTySrlmV2
 OkZEg76rLbBl0fK/rjNxdIGHkPxJ+50yLhg2WEsesSnF7cHC/ApDcCAWXntZsK5QYztz+tympx
 qZiFgPc0VO2GHAjjyxh0w1qqJbBRtNlKMoiHncfzfu8VQcJcqnhLSVuZVnRu7pAkwEc9gnimNl
 Rlw=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="2407500"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:19 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hcY4eIPkkK9LCm9Eb4m0H+Glam1Nc5sK0yS4euGMf9I0DBdo7hDyJ8I7YTvSf9EWVuBEkth8wFNTsmcGR1Ii9Fky6o0wG1wWmKbebd8WpxyPG9q3b4IfQNugbJy11J0dCf6F+BwdOGFxbzB7Yd1ShY6ECdV5UWsDsY+7bM5SvgthSeqwyx6xmE+tpnvBvYEM7e18tkwP+gFCPaXuwdAWGP+68+B+FHPIVsT1LXUcjCDsbhkn37plXworjlFDGU4RduVqKdC+geiFYOLmDsjr9QIaZytvwe4rJO7X66Ct1Hc97rFpP98UjqjWa0TTL0GksN97XTfO0EMmLB/qv4T0+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgdvCm7s1YxFpluNUcAJ3TlrsooRFRN/fsQYrqSvzzI=;
 b=FvEShimJfuguISxIg2RQjWBPC9/HAglO5qSTvxpPy7g6R60lGwGP2o95iUL2+9v5V3L0H3kFe0eL6ZgBmX0Wq/BBXoPkoWvgC/KdehAOR5r2F17GRc5FLTrscmYmSebCzlCxu1kA07v5aZiCBKR/HR2dHDjDjow54Aipo8n8d4rqB7d8hWfq3ikB/aYRb8TQT3pgGYxjbxCiLMEaCOF5O5WQ9Wc00/NOyNKALOPuUyoiD8ShCwn++KiA3mOZpOnwRMTHJStbdZNmORBzA8WJDY4yzjDjZcph6QAQkYnW574SfZpZPFQajP/JXXKM292mQfLaG5EVJNh1EIj/K0N6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgdvCm7s1YxFpluNUcAJ3TlrsooRFRN/fsQYrqSvzzI=;
 b=DdwzWt3L2WTht18SQW+wffthyUjL+gv+J2fA2QCiBNy80w3r4oKQjCHNbrCChMWHvVscWfXC+WMcDD3EkobPC8/YMGaZfwFT1WcWr1DLdiLxn2OkGYlaAuNpm7E/3AMPxE+uO34/u8co6WqeQs+VB6+OAS252ZFmoFBLjDdJ/Mo=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:17 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:17 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 3/8] staging: wilc1000: refactor interrupt handling for sdio
Thread-Topic: [PATCH 3/8] staging: wilc1000: refactor interrupt handling for
 sdio
Thread-Index: AQHV4y00e/jvJc9bxUmb1pIn/96kzg==
Date:   Fri, 14 Feb 2020 11:52:17 +0000
Message-ID: <20200214172250.13026-4-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 218715a2-dece-49ba-4e13-08d7b1445765
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16520C97477EFC61C171AC1CE3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0IIBvEcpN1/Fbj+u93YzwuE5rehrhunqu8TFc2wdTnDhWYJPDAF7DEhjcVdE9YMPkcoFPXnEdnMEWlUV3AoF5DmLQ3vFahZvRwa9Kha1vj+g6uMbz4WwEX81aj5CHI5j9Fpw4VUGmS5PJKQxKtF6Y8w9iIqVu747PbgaQgBjwyHDqzSfdeWIIGp5/Tyh7gMeMyPp3ZbRPAfbdC33dAQ4MRKm0qQZhZusWMqLGxtgnizKYla+PVPfJmpAN24oobVEx9Q/cC7byhtivQG11sfIXNaDghM1b2DRFTQveEUpBA06PSxIqBBqN6SeUOMr4OxBDbhTNZn/GJWaRRynh9bHEiD2G9+hDU+UL3Xsoi0qR77f6Svvll+quY/wEZIM5Sp72HH6j5ZcaLSwTKUKitB/mW+uBXE1La09mU/chgsqc2iRF30dwoJat6xmRyCAXKzj
x-ms-exchange-antispam-messagedata: GugRH9WFMoQWkwFhFjZT0u6u2iJlq/LhEKzFLAiQLsyhw3nn9P1hna5wq2rdhhovF19G50gvk/5TODcmvDiw4J7dglUOJefDXQbDssLeFNqH3yQCSILNsLJgALRtaPTmEoHGs5EWxJ3O3flCxDaG7A==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 218715a2-dece-49ba-4e13-08d7b1445765
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:17.6095
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3pvnl0Uh4F8cF+0XFscggtMy3xqjd5ScMv+AN1gvR8luZwEomfJ52y9yBPPNitT0zL93KEsi6N5bxtPMY+uoYDwUOBZsTL76Ge9r9W1g4jA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Make use of FIELD_PREP/FIELD_GET macro to refactor the interrupt
handling for SDIO.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 98 ++++++++++++---------------------
 drivers/staging/wilc1000/spi.c  |  4 --
 drivers/staging/wilc1000/wlan.h |  3 +
 3 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 77ef84f9cc37..66706efc5711 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -26,7 +26,6 @@ static const struct sdio_device_id wilc_sdio_ids[] =3D {
 struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
-	int nint;
 	int has_thrpt_enh3;
 };
=20
@@ -790,6 +789,7 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 *i=
nt_status)
 	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
 	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
 	u32 tmp;
+	u8 irq_flags;
 	struct sdio_cmd52 cmd;
=20
 	wilc_sdio_read_size(wilc, &tmp);
@@ -798,44 +798,22 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 =
*int_status)
 	 *      Read IRQ flags
 	 **/
 	if (!sdio_priv->irq_gpio) {
-		int i;
-
-		cmd.read_write =3D 0;
 		cmd.function =3D 1;
 		cmd.address =3D 0x04;
-		cmd.data =3D 0;
-		wilc_sdio_cmd52(wilc, &cmd);
-
-		if (cmd.data & BIT(0))
-			tmp |=3D INT_0;
-		if (cmd.data & BIT(2))
-			tmp |=3D INT_1;
-		if (cmd.data & BIT(3))
-			tmp |=3D INT_2;
-		if (cmd.data & BIT(4))
-			tmp |=3D INT_3;
-		if (cmd.data & BIT(5))
-			tmp |=3D INT_4;
-		for (i =3D sdio_priv->nint; i < MAX_NUM_INT; i++) {
-			if ((tmp >> (IRG_FLAGS_OFFSET + i)) & 0x1) {
-				dev_err(&func->dev,
-					"Unexpected interrupt (1) : tmp=3D%x, data=3D%x\n",
-					tmp, cmd.data);
-				break;
-			}
-		}
 	} else {
-		u32 irq_flags;
-
-		cmd.read_write =3D 0;
 		cmd.function =3D 0;
-		cmd.raw =3D 0;
 		cmd.address =3D 0xf7;
-		cmd.data =3D 0;
-		wilc_sdio_cmd52(wilc, &cmd);
-		irq_flags =3D cmd.data & 0x1f;
-		tmp |=3D ((irq_flags >> 0) << IRG_FLAGS_OFFSET);
 	}
+	cmd.raw =3D 0;
+	cmd.read_write =3D 0;
+	cmd.data =3D 0;
+	wilc_sdio_cmd52(wilc, &cmd);
+	irq_flags =3D cmd.data;
+	tmp |=3D FIELD_PREP(IRG_FLAGS_MASK, cmd.data);
+
+	if (FIELD_GET(UNHANDLED_IRQ_MASK, irq_flags))
+		dev_err(&func->dev, "Unexpected interrupt (1) int=3D%lx\n",
+			FIELD_GET(UNHANDLED_IRQ_MASK, irq_flags));
=20
 	*int_status =3D tmp;
=20
@@ -890,38 +868,36 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 		 * Must clear each interrupt individually.
 		 */
 		u32 flags;
+		int i;
=20
 		flags =3D val & (BIT(MAX_NUM_INT) - 1);
-		if (flags) {
-			int i;
-
-			for (i =3D 0; i < sdio_priv->nint; i++) {
-				if (flags & 1) {
-					struct sdio_cmd52 cmd;
-
-					cmd.read_write =3D 1;
-					cmd.function =3D 0;
-					cmd.raw =3D 0;
-					cmd.address =3D 0xf8;
-					cmd.data =3D BIT(i);
-
-					ret =3D wilc_sdio_cmd52(wilc, &cmd);
-					if (ret) {
-						dev_err(&func->dev,
-							"Failed cmd52, set 0xf8 data (%d) ...\n",
-							__LINE__);
-						return ret;
-					}
+		for (i =3D 0; i < NUM_INT_EXT && flags; i++) {
+			if (flags & BIT(i)) {
+				struct sdio_cmd52 cmd;
+
+				cmd.read_write =3D 1;
+				cmd.function =3D 0;
+				cmd.raw =3D 0;
+				cmd.address =3D 0xf8;
+				cmd.data =3D BIT(i);
+
+				ret =3D wilc_sdio_cmd52(wilc, &cmd);
+				if (ret) {
+					dev_err(&func->dev,
+						"Failed cmd52, set 0xf8 data (%d) ...\n",
+						__LINE__);
+					return ret;
 				}
-				flags >>=3D 1;
+				flags &=3D ~BIT(i);
 			}
+		}
=20
-			for (i =3D sdio_priv->nint; i < MAX_NUM_INT; i++) {
-				if (flags & 1)
-					dev_err(&func->dev,
-						"Unexpected interrupt cleared %d...\n",
-						i);
-				flags >>=3D 1;
+		for (i =3D NUM_INT_EXT; i < MAX_NUM_INT && flags; i++) {
+			if (flags & BIT(i)) {
+				dev_err(&func->dev,
+					"Unexpected interrupt cleared %d...\n",
+					i);
+				flags &=3D ~BIT(i);
 			}
 		}
 	}
@@ -967,8 +943,6 @@ static int wilc_sdio_sync_ext(struct wilc *wilc, int ni=
nt)
 		return -EINVAL;
 	}
=20
-	sdio_priv->nint =3D nint;
-
 	/**
 	 *      Disable power sequencer
 	 **/
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 300c5c832572..37be627e72ce 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -12,7 +12,6 @@
=20
 struct wilc_spi {
 	int crc_off;
-	int nint;
 };
=20
 static const struct wilc_hif_func wilc_hif_spi;
@@ -916,7 +915,6 @@ static int wilc_spi_clear_int_ext(struct wilc *wilc, u3=
2 val)
 static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
-	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	u32 reg;
 	int ret, i;
=20
@@ -925,8 +923,6 @@ static int wilc_spi_sync_ext(struct wilc *wilc, int nin=
t)
 		return -EINVAL;
 	}
=20
-	spi_priv->nint =3D nint;
-
 	/*
 	 * interrupt pin mux select
 	 */
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 876b02e93a81..27f08b375345 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -176,6 +176,8 @@
 #define INT_4			BIT(IRG_FLAGS_OFFSET + 4)
 #define INT_5			BIT(IRG_FLAGS_OFFSET + 5)
 #define MAX_NUM_INT		5
+#define IRG_FLAGS_MASK		GENMASK(IRG_FLAGS_OFFSET + MAX_NUM_INT, \
+					IRG_FLAGS_OFFSET)
=20
 /*******************************************/
 /*        E0 and later Interrupt flags.    */
@@ -203,6 +205,7 @@
 #define DATA_INT_EXT		INT_0
 #define ALL_INT_EXT		DATA_INT_EXT
 #define NUM_INT_EXT		1
+#define UNHANDLED_IRQ_MASK	GENMASK(MAX_NUM_INT - 1, NUM_INT_EXT)
=20
 #define DATA_INT_CLR		CLR_INT0
=20
--=20
2.24.0
