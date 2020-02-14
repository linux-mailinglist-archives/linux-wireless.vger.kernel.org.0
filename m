Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEA7015D6ED
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729043AbgBNLw3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:29 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:12309 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728689AbgBNLw2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:28 -0500
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
IronPort-SDR: vsaN7KGY1facWw1FoX7fomqTyhz7YJwfWgAe0zlt980TQRErwbO78MMEJ5NUVRbJ2UWz0aXUdU
 0aAQzPrPD3WTKk2XKOtnbCts+fYWO6Kir3hLgXepoJZhdXOPsXE5HwQPTobXppffq9zb2CSr6B
 nWNxuXAVGZFmtFlcDe9zDPvmG2w/O2wLZXZ07FIwllg6IOBdDS7+hTBPS3klXBH84AjI1Lh2mv
 7+c4prgYSKPYLzikzO5g3NaNFadr+SyHmwZiGKsU9muUWiAWJJ5fFa4X64wvv76AW+9sUFfepP
 bdQ=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="66696577"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:26 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Fri, 14 Feb 2020 04:52:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MArrHNcqXYYxlg4uzrDI8FpBKEJZ3TGDujokQSINkbg02WEo5osHchx8yurCu+pRQYTeS1XJvP80tuB5GZLoxcylNELYgO5rkbuzglKP+KzU+jlMR65wIbmsqs28ZJmGszfQ6ma2HKPcDe5txZyljqRMpWmZ/vWYqMGJjotI/2aNndlhcYsdTlz0nKiq5Pz2xpRwsFgbMZBHVwJ1cBWHbuwtYqtbAzaOcXmUu0iQwUImstkYLhojsNHl/vuED+v0KY1/He3/GW0uO62nQ17p72hGguyAGvr6/NtW8O90qSbCEV7rURFmZVuNbVsoaXVWsQLbO3o4AKxBRgSeeWlQDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mvY4+lBkx/9nXSxxyOI1oL+fY87mSQbDZTIc62+9rw=;
 b=cdlE2WPUULmwszCa3eA/2pLuNZJnqZe6ck7kQhWb+8ZIXPhiL1+pxVJBICj+BgQqLBb5kV0sH1oN6sPOx+sHjw6e8TrywQ+10U81sJa+gUsAjlpK6/ygUmpE/FakltU/y2CBm2kGZcVPCntEBwJjpIwlkM+V3kut7BeQgOlCzMyWC+YbgX+mjWkDX8/aq82Iv0Fb1QtcLNqUqkEOfKyF4sSbHs+CvhLbxhXFJZso5LECXXAvzU8wOg+Ol4oCRlJ4Hi7OcXRkpxMNZ93yx6pAQQ+28UxR+FvK86cXDR/ebVop3e4XLBgrg/g3avgp+TVhoAS4IPwWKgMPAUH8ri/hBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6mvY4+lBkx/9nXSxxyOI1oL+fY87mSQbDZTIc62+9rw=;
 b=dYPMNMpIRdZWGfZ0pWsC/HNtfbYOy05fp37h0oGs4bGNyCIsuI1xt1tDM5Ii+tA35Ns+xiZGwMoKkTrwA8T0p2am4Tf/QmYKDzMChJd+IMwbDyDp0Ui1k9M+hItSSp+AM2XSfqjSqNUopZydDhK9/OFEd1yMLRTI++Cp1u1istc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:24 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:24 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 8/8] staging: wilc1000: define macros to replace magic number
 values
Thread-Topic: [PATCH 8/8] staging: wilc1000: define macros to replace magic
 number values
Thread-Index: AQHV4y04Pa/fqdvkgUei+QBjm2Y+9g==
Date:   Fri, 14 Feb 2020 11:52:23 +0000
Message-ID: <20200214172250.13026-9-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9307f65c-5d65-46a8-e9ee-08d7b1445b1a
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB1652833DC18110204D2318F5E3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:159;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(30864003)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 04ddSOsTH5CIFyTWtj4rcwb7G7B4V4Vv7cQGsyPk6S6Sv/oStNXi9UXQ6CuJunO+OCI+jW/spN+Kgdgtma9noUKlR899Qh1GW8yQeGEczmSoU4lr25+eE/3kkoFVzjPtXlnCESDS4TvMZ8uuxnLC615fy70u9iii9n9LrOMvex2eZd9jRV7jPuDYZ4jSwibxuEg7jfX/zT/26GltEDZtJi7tm2TTvC/etaXFMVz5YtNBHFU2yazpByTvTUCYcXAZPbF9lGQgH7jsAa597tN9jw2S9b+lT+v5PNd89KQFjontBFTFnwq5Lz3v++PII1ql2JS1FNT6HUpcCkYXvIWqoQFctLDAxQ9mGls/ONF1d6WSXfDr7vgUidZKjR4F8Q+KnlZCtQ527s8AsTlOz8wBo49qd6Mq12VGKn+cvH50D6EwtN97rqawvDwGp6sIMu7Q
x-ms-exchange-antispam-messagedata: nNM8luQRht4akNKLmGa5Qrs8LqpbSsQEe4IF+2U0KF5XkZHVSbD8QQ7VlWiyjwyuF6q9u3kQBdqBCZmgm1HDh1z2vRjvk5/bvY+yuZFrfD577jibmusXRFQ+eGxDbHmbTp1TJLI1t1T7HzG4qq+teg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 9307f65c-5d65-46a8-e9ee-08d7b1445b1a
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:23.8448
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8BrYKU6bvmEBmdAhynopJ1EH7jYjRQOTpcpcelEHZvEvc+xCRvA5T/19uMo+KOephaDzFTWCYbWTI2R04AiUjrkPfvinhypejbsh9TnUDdk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Define macros for global as well as SPI/SDIO specific register to avoid
use of magic numbers.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c |  7 ++-
 drivers/staging/wilc1000/spi.c  | 17 ++++---
 drivers/staging/wilc1000/wlan.c | 83 +++++++++++++++++++--------------
 drivers/staging/wilc1000/wlan.h | 35 ++++++++++++++
 4 files changed, 99 insertions(+), 43 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 0670c5956aef..2301e90c21ca 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -686,13 +686,16 @@ static int wilc_sdio_init(struct wilc *wilc, bool res=
ume)
 	 *      make sure can read back chip id correctly
 	 **/
 	if (!resume) {
-		ret =3D wilc_sdio_read_reg(wilc, 0x1000, &chipid);
+		int rev;
+
+		ret =3D wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
 		if (ret) {
 			dev_err(&func->dev, "Fail cmd read chip id...\n");
 			return ret;
 		}
 		dev_err(&func->dev, "chipid (%08x)\n", chipid);
-		if ((chipid & 0xfff) > 0x2a0)
+		rev =3D FIELD_GET(WILC_CHIP_REV_FIELD, chipid);
+		if (rev > FIELD_GET(WILC_CHIP_REV_FIELD, WILC_1000_BASE_ID_2A))
 			sdio_priv->has_thrpt_enh3 =3D 1;
 		else
 			sdio_priv->has_thrpt_enh3 =3D 0;
diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 37be627e72ce..44f7d48851b5 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -683,7 +683,7 @@ static int wilc_spi_read_reg(struct wilc *wilc, u32 add=
r, u32 *data)
 	u8 cmd =3D CMD_SINGLE_READ;
 	u8 clockless =3D 0;
=20
-	if (addr < 0x30) {
+	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_READ;
 		clockless =3D 1;
@@ -760,7 +760,7 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 ad=
dr, u32 data)
 	u8 cmd =3D CMD_SINGLE_WRITE;
 	u8 clockless =3D 0;
=20
-	if (addr < 0x30) {
+	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_WRITE;
 		clockless =3D 1;
@@ -829,7 +829,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume=
)
 	int ret;
=20
 	if (isinit) {
-		ret =3D wilc_spi_read_reg(wilc, 0x1000, &chipid);
+		ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 		if (ret)
 			dev_err(&spi->dev, "Fail cmd read chip id...\n");
=20
@@ -881,7 +881,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resume=
)
 	/*
 	 * make sure can read back chip id correctly
 	 */
-	ret =3D wilc_spi_read_reg(wilc, 0x1000, &chipid);
+	ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 	if (ret) {
 		dev_err(&spi->dev, "Fail cmd read chip id...\n");
 		return ret;
@@ -896,7 +896,8 @@ static int wilc_spi_read_size(struct wilc *wilc, u32 *s=
ize)
 {
 	int ret;
=20
-	ret =3D spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE, size);
+	ret =3D spi_internal_read(wilc,
+				WILC_SPI_INT_STATUS - WILC_SPI_REG_BASE, size);
 	*size =3D FIELD_GET(IRQ_DMA_WD_CNT_MASK, *size);
=20
 	return ret;
@@ -904,12 +905,14 @@ static int wilc_spi_read_size(struct wilc *wilc, u32 =
*size)
=20
 static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 {
-	return spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE, int_status);
+	return spi_internal_read(wilc, WILC_SPI_INT_STATUS - WILC_SPI_REG_BASE,
+				 int_status);
 }
=20
 static int wilc_spi_clear_int_ext(struct wilc *wilc, u32 val)
 {
-	return spi_internal_write(wilc, 0xe844 - WILC_SPI_REG_BASE, val);
+	return spi_internal_write(wilc, WILC_SPI_INT_CLEAR - WILC_SPI_REG_BASE,
+				  val);
 }
=20
 static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
diff --git a/drivers/staging/wilc1000/wlan.c b/drivers/staging/wilc1000/wla=
n.c
index 31f424efe01d..f633c6b9f0a9 100644
--- a/drivers/staging/wilc1000/wlan.c
+++ b/drivers/staging/wilc1000/wlan.c
@@ -11,7 +11,7 @@
=20
 static inline bool is_wilc1000(u32 id)
 {
-	return (id & 0xfffff000) =3D=3D 0x100000;
+	return (id & (~WILC_CHIP_REV_FIELD)) =3D=3D WILC_1000_BASE_ID;
 }
=20
 static inline void acquire_bus(struct wilc *wilc, enum bus_acquire acquire=
)
@@ -393,10 +393,11 @@ void chip_allow_sleep(struct wilc *wilc)
 {
 	u32 reg =3D 0;
=20
-	wilc->hif_func->hif_read_reg(wilc, 0xf0, &reg);
+	wilc->hif_func->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
=20
-	wilc->hif_func->hif_write_reg(wilc, 0xf0, reg & ~BIT(0));
-	wilc->hif_func->hif_write_reg(wilc, 0xfa, 0);
+	wilc->hif_func->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+				      reg & ~WILC_SDIO_WAKEUP_BIT);
+	wilc->hif_func->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG, 0);
 }
 EXPORT_SYMBOL_GPL(chip_allow_sleep);
=20
@@ -407,9 +408,11 @@ void chip_wakeup(struct wilc *wilc)
=20
 	if (wilc->io_type =3D=3D WILC_HIF_SPI) {
 		do {
-			h->hif_read_reg(wilc, 1, &reg);
-			h->hif_write_reg(wilc, 1, reg | BIT(1));
-			h->hif_write_reg(wilc, 1, reg & ~BIT(1));
+			h->hif_read_reg(wilc, WILC_SPI_WAKEUP_REG, &reg);
+			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
+					 reg | WILC_SPI_WAKEUP_BIT);
+			h->hif_write_reg(wilc, WILC_SPI_WAKEUP_REG,
+					 reg & ~WILC_SPI_WAKEUP_BIT);
=20
 			do {
 				usleep_range(2000, 2500);
@@ -417,35 +420,40 @@ void chip_wakeup(struct wilc *wilc)
 			} while (wilc_get_chipid(wilc, true) =3D=3D 0);
 		} while (wilc_get_chipid(wilc, true) =3D=3D 0);
 	} else if (wilc->io_type =3D=3D WILC_HIF_SDIO) {
-		h->hif_write_reg(wilc, 0xfa, 1);
+		h->hif_write_reg(wilc, WILC_SDIO_HOST_TO_FW_REG,
+				 WILC_SDIO_HOST_TO_FW_BIT);
 		usleep_range(200, 400);
-		h->hif_read_reg(wilc, 0xf0, &reg);
+		h->hif_read_reg(wilc, WILC_SDIO_WAKEUP_REG, &reg);
 		do {
-			h->hif_write_reg(wilc, 0xf0, reg | BIT(0));
-			h->hif_read_reg(wilc, 0xf1, &clk_status_reg);
+			h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+					 reg | WILC_SDIO_WAKEUP_BIT);
+			h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
+					&clk_status_reg);
=20
-			while ((clk_status_reg & 0x1) =3D=3D 0) {
+			while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
 				usleep_range(2000, 2500);
=20
-				h->hif_read_reg(wilc, 0xf1, &clk_status_reg);
+				h->hif_read_reg(wilc, WILC_SDIO_CLK_STATUS_REG,
+						&clk_status_reg);
 			}
-			if ((clk_status_reg & 0x1) =3D=3D 0) {
-				h->hif_write_reg(wilc, 0xf0, reg & (~BIT(0)));
+			if (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT)) {
+				h->hif_write_reg(wilc, WILC_SDIO_WAKEUP_REG,
+						 reg & ~WILC_SDIO_WAKEUP_BIT);
 			}
-		} while ((clk_status_reg & 0x1) =3D=3D 0);
+		} while (!(clk_status_reg & WILC_SDIO_CLK_STATUS_BIT));
 	}
=20
 	if (wilc->chip_ps_state =3D=3D WILC_CHIP_SLEEPING_MANUAL) {
-		if (wilc_get_chipid(wilc, false) < 0x1002b0) {
+		if (wilc_get_chipid(wilc, false) < WILC_1000_BASE_ID_2B) {
 			u32 val32;
=20
-			h->hif_read_reg(wilc, 0x1e1c, &val32);
+			h->hif_read_reg(wilc, WILC_REG_4_TO_1_RX, &val32);
 			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, 0x1e1c, val32);
+			h->hif_write_reg(wilc, WILC_REG_4_TO_1_RX, val32);
=20
-			h->hif_read_reg(wilc, 0x1e9c, &val32);
+			h->hif_read_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, &val32);
 			val32 |=3D BIT(6);
-			h->hif_write_reg(wilc, 0x1e9c, val32);
+			h->hif_write_reg(wilc, WILC_REG_4_TO_1_TX_BANK0, val32);
 		}
 	}
 	wilc->chip_ps_state =3D WILC_CHIP_WAKEDUP;
@@ -455,7 +463,7 @@ EXPORT_SYMBOL_GPL(chip_wakeup);
 void host_wakeup_notify(struct wilc *wilc)
 {
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
-	wilc->hif_func->hif_write_reg(wilc, 0x10b0, 1);
+	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_2, 1);
 	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 }
 EXPORT_SYMBOL_GPL(host_wakeup_notify);
@@ -463,7 +471,7 @@ EXPORT_SYMBOL_GPL(host_wakeup_notify);
 void host_sleep_notify(struct wilc *wilc)
 {
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
-	wilc->hif_func->hif_write_reg(wilc, 0x10ac, 1);
+	wilc->hif_func->hif_write_reg(wilc, WILC_CORTUS_INTERRUPT_1, 1);
 	release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 }
 EXPORT_SYMBOL_GPL(host_sleep_notify);
@@ -884,7 +892,7 @@ int wilc_wlan_start(struct wilc *wilc)
=20
 	wilc->hif_func->hif_sync_ext(wilc, NUM_INT_EXT);
=20
-	ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1000, &chipid);
+	ret =3D wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
 	if (ret) {
 		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
 		return ret;
@@ -1125,18 +1133,24 @@ static int init_chip(struct net_device *dev)
 	chipid =3D wilc_get_chipid(wilc, true);
=20
 	if ((chipid & 0xfff) !=3D 0xa0) {
-		ret =3D wilc->hif_func->hif_read_reg(wilc, 0x1118, &reg);
+		ret =3D wilc->hif_func->hif_read_reg(wilc,
+						   WILC_CORTUS_RESET_MUX_SEL,
+						   &reg);
 		if (ret) {
 			netdev_err(dev, "fail read reg 0x1118\n");
 			goto release;
 		}
 		reg |=3D BIT(0);
-		ret =3D wilc->hif_func->hif_write_reg(wilc, 0x1118, reg);
+		ret =3D wilc->hif_func->hif_write_reg(wilc,
+						    WILC_CORTUS_RESET_MUX_SEL,
+						    reg);
 		if (ret) {
 			netdev_err(dev, "fail write reg 0x1118\n");
 			goto release;
 		}
-		ret =3D wilc->hif_func->hif_write_reg(wilc, 0xc0000, 0x71);
+		ret =3D wilc->hif_func->hif_write_reg(wilc,
+						    WILC_CORTUS_BOOT_REGISTER,
+						    WILC_CORTUS_BOOT_FROM_IRAM);
 		if (ret) {
 			netdev_err(dev, "fail write reg 0xc0000\n");
 			goto release;
@@ -1156,20 +1170,21 @@ u32 wilc_get_chipid(struct wilc *wilc, bool update)
 	u32 rfrevid =3D 0;
=20
 	if (chipid =3D=3D 0 || update) {
-		wilc->hif_func->hif_read_reg(wilc, 0x1000, &tempchipid);
-		wilc->hif_func->hif_read_reg(wilc, 0x13f4, &rfrevid);
+		wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &tempchipid);
+		wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
+					     &rfrevid);
 		if (!is_wilc1000(tempchipid)) {
 			chipid =3D 0;
 			return chipid;
 		}
-		if (tempchipid =3D=3D 0x1002a0) {
+		if (tempchipid =3D=3D WILC_1000_BASE_ID_2A) { /* 0x1002A0 */
 			if (rfrevid !=3D 0x1)
-				tempchipid =3D 0x1002a1;
-		} else if (tempchipid =3D=3D 0x1002b0) {
+				tempchipid =3D WILC_1000_BASE_ID_2A_REV1;
+		} else if (tempchipid =3D=3D WILC_1000_BASE_ID_2B) { /* 0x1002B0 */
 			if (rfrevid =3D=3D 0x4)
-				tempchipid =3D 0x1002b1;
+				tempchipid =3D WILC_1000_BASE_ID_2B_REV1;
 			else if (rfrevid !=3D 0x3)
-				tempchipid =3D 0x1002b2;
+				tempchipid =3D WILC_1000_BASE_ID_2B_REV2;
 		}
=20
 		chipid =3D tempchipid;
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index ceec4801f18f..5999c5490ea5 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -66,6 +66,8 @@
 #define WILC_INTR_CLEAR			(WILC_INTR_REG_BASE + 0x30)
 #define WILC_INTR_STATUS		(WILC_INTR_REG_BASE + 0x40)
=20
+#define WILC_RF_REVISION_ID		0x13f4
+
 #define WILC_VMM_TBL_SIZE		64
 #define WILC_VMM_TX_TBL_BASE		0x150400
 #define WILC_VMM_RX_TBL_BASE		0x150500
@@ -89,10 +91,17 @@
 #define WILC_SPI_TX_MODE		(WILC_SPI_REG_BASE + 0x20)
 #define WILC_SPI_PROTOCOL_CONFIG	(WILC_SPI_REG_BASE + 0x24)
 #define WILC_SPI_INTR_CTL		(WILC_SPI_REG_BASE + 0x2c)
+#define WILC_SPI_INT_STATUS		(WILC_SPI_REG_BASE + 0x40)
+#define WILC_SPI_INT_CLEAR		(WILC_SPI_REG_BASE + 0x44)
+
+#define WILC_SPI_WAKEUP_REG		0x1
+#define WILC_SPI_WAKEUP_BIT		BIT(1)
=20
 #define WILC_SPI_PROTOCOL_OFFSET	(WILC_SPI_PROTOCOL_CONFIG - \
 					 WILC_SPI_REG_BASE)
=20
+#define WILC_SPI_CLOCKLESS_ADDR_LIMIT	0x30
+
 /* Functions IO enables bits */
 #define WILC_SDIO_CCCR_IO_EN_FUNC1	BIT(1)
=20
@@ -149,6 +158,32 @@
 #define WILC_HAVE_DISABLE_WILC_UART	BIT(7)
 #define WILC_HAVE_USE_IRQ_AS_HOST_WAKE	BIT(8)
=20
+#define WILC_CORTUS_INTERRUPT_BASE	0x10A8
+#define WILC_CORTUS_INTERRUPT_1		(WILC_CORTUS_INTERRUPT_BASE + 0x4)
+#define WILC_CORTUS_INTERRUPT_2		(WILC_CORTUS_INTERRUPT_BASE + 0x8)
+
+/* tx control register 1 to 4 for RX */
+#define WILC_REG_4_TO_1_RX		0x1e1c
+
+/* tx control register 1 to 4 for TX Bank_0 */
+#define WILC_REG_4_TO_1_TX_BANK0	0x1e9c
+
+#define WILC_CORTUS_RESET_MUX_SEL	0x1118
+#define WILC_CORTUS_BOOT_REGISTER	0xc0000
+
+#define WILC_CORTUS_BOOT_FROM_IRAM	0x71
+
+#define WILC_1000_BASE_ID		0x100000
+
+#define WILC_1000_BASE_ID_2A		0x1002A0
+#define WILC_1000_BASE_ID_2A_REV1	(WILC_1000_BASE_ID_2A + 1)
+
+#define WILC_1000_BASE_ID_2B		0x1002B0
+#define WILC_1000_BASE_ID_2B_REV1	(WILC_1000_BASE_ID_2B + 1)
+#define WILC_1000_BASE_ID_2B_REV2	(WILC_1000_BASE_ID_2B + 2)
+
+#define WILC_CHIP_REV_FIELD		GENMASK(11, 0)
+
 /********************************************
  *
  *      Wlan Defines
--=20
2.24.0
