Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0C5C15D6E6
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2020 12:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBNLwZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 14 Feb 2020 06:52:25 -0500
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:42590 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbgBNLwY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 14 Feb 2020 06:52:24 -0500
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: U1niBVXvcirbDTDbeaw6FgfuS4a/elwOVrZULOWJqEwBDzgYy9O51R5PlRm92u5Vs+5kuQO/xD
 YwavTG4C+BIQAvDzmGOyQG94a7j1mGjGd36qwKCVInXOFdxhB70ZtueDveeKm7WGQs2lTGDpWo
 ExFs1I2hLIoc2F2T4FqdJ1UWyb/ex5JuVvxOOrOBEsDRjlQuTcek+ZQRtklzsNHobbALvbk2SG
 eGc2LrIKy8VHkMOpruKwAcX5OEdEsNmR3f7EoAtxk3sjw4plNvM8hhXgDcgjgWOp8gZ04ax2Am
 E7g=
X-IronPort-AV: E=Sophos;i="5.70,440,1574146800"; 
   d="scan'208";a="65913233"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Feb 2020 04:52:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 14 Feb 2020 04:52:20 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 14 Feb 2020 04:52:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PSiO4K09MAaf5d/+wvizFSMGtLNqU/9z/i6ca5fiATPQpkCXuaOneBUDSSmaJEzURwEEpx+zeXFPYuPmDSKWPuc97Xh3gCYHGG+WbjVYp98Of6e++llY4eXAGEnSyJBwwy8zF3KX9xrfsoyzWPwJBjG9vnIVrIK2Ny5BPDIU/9WgjpbWdmdwpOpfPhyytT0Vitz3P9OHIFj3sUvGypp4C1p1iQAHSWUg/d1clxtLryG7ZsNXpiz23fpBqOrz/urhBzj8w+ZcSo5H3LVrleHCIzPO8plgnmsekVHwFFCT83NAlWmFHd4akXE9LLbr9e62+TcIinz7Cu8e1SXYIo5G0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2VE6ZJqGMa/iPJFiRJMdGoKkneYzdKaghASYsDyGM=;
 b=U61ZjdC0rk+BUpPjfdJk2C4fo+Zhr0bTdkdJi3O65NTCG0JAxvS3SPMiLbuFinYWuTmrca5QrM7lvXg/ELsb1syIas8QrbnLHetZdtylCS+c4ZypG7/VfM3XodVBvezOg5hMAAt2RPgZU2V8NZk9cPTLwROs7LIt/t/bT5ROZDh+gaoBOwZ9kwCbK/dQ+kVQWEouPz3KzInCdIwQIi4kY2dVDPww8TBjRlxlENITNJjIwpn1tFdj2sqDoUVF3gA3I4I7S/fiGd720LNhD5020pIDTpzR2Rkh2+4rDkyMhoSc3uN3zEJ+QtUVR63sw3cAdmuuXYrRwZt8mUJVdnkhcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Tq2VE6ZJqGMa/iPJFiRJMdGoKkneYzdKaghASYsDyGM=;
 b=N+5QNq9oGdwrTldzQPdirTawcL6B/5ltyjCK4XVKm2PoyPeFZbfPZd+9qn0EevDbsf0RmoNVUJTZrLZKD4aSkpUFaWcRMerKXq3BbZlbxR3Yn9Nei3gf/WWNjmakV24q3jLVvfWAuVNNlhPadoGjMDtrCRqRGRUrIZ4LPIQTVfo=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1652.namprd11.prod.outlook.com (10.172.24.13) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2729.25; Fri, 14 Feb 2020 11:52:21 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2729.027; Fri, 14 Feb 2020
 11:52:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 6/8] staging: wilc1000: define macros for different register
 address for SDIO
Thread-Topic: [PATCH 6/8] staging: wilc1000: define macros for different
 register address for SDIO
Thread-Index: AQHV4y02d5Z3dnBw90ulNuON4rAHrg==
Date:   Fri, 14 Feb 2020 11:52:21 +0000
Message-ID: <20200214172250.13026-7-ajay.kathat@microchip.com>
References: <20200214172250.13026-1-ajay.kathat@microchip.com>
In-Reply-To: <20200214172250.13026-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 89abfd1d-fa6a-4bbf-dff0-08d7b144598e
x-ms-traffictypediagnostic: BN6PR11MB1652:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB16520D068DB895C80435AE5EE3150@BN6PR11MB1652.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:71;
x-forefront-prvs: 03137AC81E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(376002)(346002)(366004)(39850400004)(136003)(189003)(199004)(6506007)(2906002)(26005)(6512007)(2616005)(107886003)(6486002)(5660300002)(186003)(316002)(54906003)(4326008)(81156014)(81166006)(86362001)(64756008)(66476007)(66446008)(66556008)(8936002)(8676002)(76116006)(91956017)(66946007)(478600001)(36756003)(6916009)(71200400001)(1076003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1652;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: c2KyryzoS2JvaOn4e6o8UQzE7I6SwC9oDDB59yZ97aX03KuwidTfYmI41zquhPZnImO8JGEzbP7tYkHwezYVffC+ocS9pbKhYV5NRGM+jXy1f4LhaBUqFHkQiJPt1XgI544u3QfjPhMOcxM0ZmWmV5J2pfTsrC0IKPj110VwR96RhzmvhcSgL4dSDuxhfrCeTWEUCQL1Pov+HgE1niHxnMzLFdFRhW7TU/V2KcyEAPOwG/ULYiGXRyp4/khK/wRS9uZWa6Oy8UCpsSrKFk0+BijFu4EBKs5rhhxFvg34p/v3AsTD3VE66+y2kAYEY/JwFFiTJV7gM0EqcXthUAOrZ8/VCslWqYctOLfSZA6RdqpVMYhah6fFd47O1SRGsbdw6qq+SncQG0Wy9lUc8Ee4neSCfy2Zg72zTi5ASBEPqsP7g/j4DlU+wKuT3vf2Sv3W
x-ms-exchange-antispam-messagedata: ftfisfXMSCfcfTiIuD9y4YPLKpeQve3KQn6SVrkJkYzOFRf/ZsRtZLz2/Y/iFGbZTwgkZR1vW726/obSPMpLraiGxUAs2kqgPo2JuNU+7x1hd3d5Er2AbeBthoNznA7V9IGCtJIJVS15Y7+TWsPxLA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 89abfd1d-fa6a-4bbf-dff0-08d7b144598e
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Feb 2020 11:52:21.2873
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PE/889O7cE1FAilRcg7IqfIFNVqZhjG5lUbd5ifTF8DGqCm5MtQVj8DInXPMpHoc1XFRj7v+0sRt+qvX2mOg16gkNx3FSsIrmQcURSX1gMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1652
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Instead of using hardcoded value for SDIO register address added the
macro for them.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/sdio.c | 77 +++++++++++++++++----------------
 drivers/staging/wilc1000/wlan.h | 36 +++++++++++++++
 2 files changed, 76 insertions(+), 37 deletions(-)

diff --git a/drivers/staging/wilc1000/sdio.c b/drivers/staging/wilc1000/sdi=
o.c
index 57c0e8415bc9..0670c5956aef 100644
--- a/drivers/staging/wilc1000/sdio.c
+++ b/drivers/staging/wilc1000/sdio.c
@@ -183,8 +183,8 @@ static int wilc_sdio_reset(struct wilc *wilc)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 0;
-	cmd.address =3D 0x6;
-	cmd.data =3D 0x8;
+	cmd.address =3D SDIO_CCCR_ABORT;
+	cmd.data =3D WILC_SDIO_CCCR_ABORT_RESET;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, reset cmd ...\n");
@@ -266,27 +266,30 @@ static int wilc_sdio_set_func0_csa_address(struct wil=
c *wilc, u32 adr)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 0;
-	cmd.address =3D 0x10c;
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG;
 	cmd.data =3D (u8)adr;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x10c data...\n");
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
 		return ret;
 	}
=20
-	cmd.address =3D 0x10d;
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG + 1;
 	cmd.data =3D (u8)(adr >> 8);
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x10d data...\n");
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
 		return ret;
 	}
=20
-	cmd.address =3D 0x10e;
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG + 2;
 	cmd.data =3D (u8)(adr >> 16);
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
-		dev_err(&func->dev, "Failed cmd52, set 0x10e data...\n");
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
 		return ret;
 	}
=20
@@ -337,7 +340,7 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 a=
ddr, u32 data)
=20
 	cpu_to_le32s(&data);
=20
-	if (addr >=3D 0xf0 && addr <=3D 0xff) {
+	if (addr >=3D 0xf0 && addr <=3D 0xff) { /* only vendor specific registers=
 */
 		struct sdio_cmd52 cmd;
=20
 		cmd.read_write =3D 1;
@@ -361,7 +364,7 @@ static int wilc_sdio_write_reg(struct wilc *wilc, u32 a=
ddr, u32 data)
=20
 		cmd.read_write =3D 1;
 		cmd.function =3D 0;
-		cmd.address =3D 0x10f;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
 		cmd.count =3D 4;
@@ -390,13 +393,13 @@ static int wilc_sdio_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
 		 *      func 0 access
 		 **/
 		cmd.function =3D 0;
-		cmd.address =3D 0x10f;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 	} else {
 		/**
 		 *      func 1 access
 		 **/
 		cmd.function =3D 1;
-		cmd.address =3D 0;
+		cmd.address =3D WILC_SDIO_F1_DATA_REG;
 	}
=20
 	size =3D ALIGN(size, 4);
@@ -455,7 +458,7 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
 	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
 	int ret;
=20
-	if (addr >=3D 0xf0 && addr <=3D 0xff) {
+	if (addr >=3D 0xf0 && addr <=3D 0xff) { /* only vendor specific registers=
 */
 		struct sdio_cmd52 cmd;
=20
 		cmd.read_write =3D 0;
@@ -478,7 +481,7 @@ static int wilc_sdio_read_reg(struct wilc *wilc, u32 ad=
dr, u32 *data)
=20
 		cmd.read_write =3D 0;
 		cmd.function =3D 0;
-		cmd.address =3D 0x10f;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 		cmd.block_mode =3D 0;
 		cmd.increment =3D 1;
 		cmd.count =3D 4;
@@ -511,13 +514,13 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr=
, u8 *buf, u32 size)
 		 *      func 0 access
 		 **/
 		cmd.function =3D 0;
-		cmd.address =3D 0x10f;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
 	} else {
 		/**
 		 *      func 1 access
 		 **/
 		cmd.function =3D 1;
-		cmd.address =3D 0;
+		cmd.address =3D WILC_SDIO_F1_DATA_REG;
 	}
=20
 	size =3D ALIGN(size, 4);
@@ -598,8 +601,8 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 1;
-	cmd.address =3D 0x100;
-	cmd.data =3D 0x80;
+	cmd.address =3D SDIO_FBR_BASE(func->num);
+	cmd.data =3D SDIO_FBR_ENABLE_CSA;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, enable csa...\n");
@@ -622,8 +625,8 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 1;
-	cmd.address =3D 0x2;
-	cmd.data =3D 0x2;
+	cmd.address =3D SDIO_CCCR_IOEx;
+	cmd.data =3D WILC_SDIO_CCCR_IO_EN_FUNC1;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev,
@@ -637,7 +640,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	cmd.read_write =3D 0;
 	cmd.function =3D 0;
 	cmd.raw =3D 0;
-	cmd.address =3D 0x3;
+	cmd.address =3D SDIO_CCCR_IORx;
 	loop =3D 3;
 	do {
 		cmd.data =3D 0;
@@ -647,7 +650,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 				"Fail cmd 52, get IOR register...\n");
 			return ret;
 		}
-		if (cmd.data =3D=3D 0x2)
+		if (cmd.data =3D=3D WILC_SDIO_CCCR_IO_EN_FUNC1)
 			break;
 	} while (loop--);
=20
@@ -671,8 +674,8 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 	cmd.read_write =3D 1;
 	cmd.function =3D 0;
 	cmd.raw =3D 1;
-	cmd.address =3D 0x4;
-	cmd.data =3D 0x3;
+	cmd.address =3D SDIO_CCCR_IENx;
+	cmd.data =3D WILC_SDIO_CCCR_IEN_MASTER | WILC_SDIO_CCCR_IEN_FUNC1;
 	ret =3D wilc_sdio_cmd52(wilc, &cmd);
 	if (ret) {
 		dev_err(&func->dev, "Fail cmd 52, set IEN register...\n");
@@ -711,12 +714,12 @@ static int wilc_sdio_read_size(struct wilc *wilc, u32=
 *size)
 	cmd.read_write =3D 0;
 	cmd.function =3D 0;
 	cmd.raw =3D 0;
-	cmd.address =3D 0xf2;
+	cmd.address =3D WILC_SDIO_INTERRUPT_DATA_SZ_REG;
 	cmd.data =3D 0;
 	wilc_sdio_cmd52(wilc, &cmd);
 	tmp =3D cmd.data;
=20
-	cmd.address =3D 0xf3;
+	cmd.address =3D WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
 	cmd.data =3D 0;
 	wilc_sdio_cmd52(wilc, &cmd);
 	tmp |=3D (cmd.data << 8);
@@ -740,10 +743,10 @@ static int wilc_sdio_read_int(struct wilc *wilc, u32 =
*int_status)
 	 **/
 	if (!sdio_priv->irq_gpio) {
 		cmd.function =3D 1;
-		cmd.address =3D 0x04;
+		cmd.address =3D WILC_SDIO_EXT_IRQ_FLAG_REG;
 	} else {
 		cmd.function =3D 0;
-		cmd.address =3D 0xf7;
+		cmd.address =3D WILC_SDIO_IRQ_FLAG_REG;
 	}
 	cmd.raw =3D 0;
 	cmd.read_write =3D 0;
@@ -789,14 +792,14 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 			cmd.read_write =3D 1;
 			cmd.function =3D 0;
 			cmd.raw =3D 0;
-			cmd.address =3D 0xf8;
+			cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
 			cmd.data =3D reg;
=20
 			ret =3D wilc_sdio_cmd52(wilc, &cmd);
 			if (ret) {
 				dev_err(&func->dev,
-					"Failed cmd52, set 0xf8 data (%d) ...\n",
-					__LINE__);
+					"Failed cmd52, set (%02x) data (%d) ...\n",
+					cmd.address, __LINE__);
 				return ret;
 			}
 		}
@@ -819,14 +822,14 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 				cmd.read_write =3D 1;
 				cmd.function =3D 0;
 				cmd.raw =3D 0;
-				cmd.address =3D 0xf8;
+				cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
 				cmd.data =3D BIT(i);
=20
 				ret =3D wilc_sdio_cmd52(wilc, &cmd);
 				if (ret) {
 					dev_err(&func->dev,
-						"Failed cmd52, set 0xf8 data (%d) ...\n",
-						__LINE__);
+						"Failed cmd52, set (%02x) data (%d) ...\n",
+						cmd.address, __LINE__);
 					return ret;
 				}
 				flags &=3D ~BIT(i);
@@ -860,13 +863,13 @@ static int wilc_sdio_clear_int_ext(struct wilc *wilc,=
 u32 val)
 		cmd.read_write =3D 1;
 		cmd.function =3D 0;
 		cmd.raw =3D 0;
-		cmd.address =3D 0xf6;
+		cmd.address =3D WILC_SDIO_VMM_TBL_CTRL_REG;
 		cmd.data =3D vmm_ctl;
 		ret =3D wilc_sdio_cmd52(wilc, &cmd);
 		if (ret) {
 			dev_err(&func->dev,
-				"Failed cmd52, set 0xf6 data (%d) ...\n",
-				__LINE__);
+				"Failed cmd52, set (%02x) data (%d) ...\n",
+				cmd.address, __LINE__);
 			return ret;
 		}
 	}
diff --git a/drivers/staging/wilc1000/wlan.h b/drivers/staging/wilc1000/wla=
n.h
index 27f08b375345..ceec4801f18f 100644
--- a/drivers/staging/wilc1000/wlan.h
+++ b/drivers/staging/wilc1000/wlan.h
@@ -93,6 +93,42 @@
 #define WILC_SPI_PROTOCOL_OFFSET	(WILC_SPI_PROTOCOL_CONFIG - \
 					 WILC_SPI_REG_BASE)
=20
+/* Functions IO enables bits */
+#define WILC_SDIO_CCCR_IO_EN_FUNC1	BIT(1)
+
+/* Function/Interrupt enables bits */
+#define WILC_SDIO_CCCR_IEN_MASTER	BIT(0)
+#define WILC_SDIO_CCCR_IEN_FUNC1	BIT(1)
+
+/* Abort CCCR register bits */
+#define WILC_SDIO_CCCR_ABORT_RESET	BIT(3)
+
+/* Vendor specific CCCR registers */
+#define WILC_SDIO_WAKEUP_REG		0xf0
+#define WILC_SDIO_WAKEUP_BIT		BIT(0)
+
+#define WILC_SDIO_CLK_STATUS_REG	0xf1
+#define WILC_SDIO_CLK_STATUS_BIT	BIT(0)
+
+#define WILC_SDIO_INTERRUPT_DATA_SZ_REG	0xf2 /* Read size (2 bytes) */
+
+#define WILC_SDIO_VMM_TBL_CTRL_REG	0xf6
+#define WILC_SDIO_IRQ_FLAG_REG		0xf7
+#define WILC_SDIO_IRQ_CLEAR_FLAG_REG	0xf8
+
+#define WILC_SDIO_HOST_TO_FW_REG	0xfa
+#define WILC_SDIO_HOST_TO_FW_BIT	BIT(0)
+
+#define WILC_SDIO_FW_TO_HOST_REG	0xfc
+#define WILC_SDIO_FW_TO_HOST_BIT	BIT(0)
+
+/* Function 1 specific FBR register */
+#define WILC_SDIO_FBR_CSA_REG		0x10C /* CSA pointer (3 bytes) */
+#define WILC_SDIO_FBR_DATA_REG		0x10F
+
+#define WILC_SDIO_F1_DATA_REG		0x0
+#define WILC_SDIO_EXT_IRQ_FLAG_REG	0x4
+
 #define WILC_AHB_DATA_MEM_BASE		0x30000
 #define WILC_AHB_SHARE_MEM_BASE		0xd0000
=20
--=20
2.24.0
