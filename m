Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1ED4AE4D4
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2019 09:46:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbfIJHqI (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 10 Sep 2019 03:46:08 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:15041 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbfIJHqI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 10 Sep 2019 03:46:08 -0400
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: KBLrEDd4NihuoDaLFp10Gg5WQT/rZWxxQ2bJZwnvN9yaTs5yU0nUeWdm66QCTlKHi/UfYYYNbE
 ur32h7xTU42dFsu00rs5j35XNyXGOcdmUA2Lttszs/tT1p/VGei6NelIjoFSyRoXSt+bXlT44o
 dBMjVT7nVtIHujbkqVqT25+4yHrkp57Yx4dRdSKZhV01Jxh8XicFucQ25BRao90bA+4Cm3UPbm
 Kj8rk/rPwef3JOTBOGUVhMy1sXdBSaHDBTrnq75Us3sMRlepb+pJQ3LRn2buD8JvPF3oiODjwF
 ci0=
X-IronPort-AV: E=Sophos;i="5.64,487,1559545200"; 
   d="scan'208";a="46867018"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 10 Sep 2019 00:46:07 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 10 Sep 2019 00:46:06 -0700
Received: from NAM03-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Tue, 10 Sep 2019 00:46:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IsQVRW0sFnxVEmqfUYYFwWpCthMGcke4lIx1oYYNqrDp4/HMNZLcy4Tz/2fdNlz7RiEnaCsf9W3fcX+w3a8iVVdLnCFEXMZOZQAKOAJ8BV602dNEhyeosAu3/XtE/uN31aLCaPnv7RRrv43sTrOSxhw8dXC4Iv/pCwDxWgsAJX/9IKMl8BonAUbw6pPaoHiY1/QkyuZ6Sj0OFncVcImkYqIGIiTasNSuhapJivMUQc7qEMF00ZOdTTpwUPIPrPW2uwCjL+1GXjjJYiBk6hHS477jAwR1HlnISnPAosZ9yAjoo/m/bfdEuIwVt+F6l/+0Wn7uuw66OlyNNTH5jshsig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ANFPoGNQGzKup1MLOP76wohv2h6FEkfMHrsonsw4Mg=;
 b=Y1yuQCKcqTwAv2A3uAFQJKuKXopB1jBgUgNh/YoFs1ydadExOyifKkkI3C5lobpQST39tQi2p/CxnokuTyctulcHLDqzevxcmKTWcBFIHGox7V8itX7sdXfBBM24rZQAuf/KnGIl6ytNJo3+tIQk6LiUPwy3yXDuf3l3nzkDcsyhtgI3GFhZzLYr9G9AODO6fCkN9Dc2GoP4+rA0wofg7eO9vhSyLFXokssJ3AYjFIYX9bS4COwHMWV1UFwg7NVpiVXrsDw/CZh/UqtR8M8xzBa2gF3kGWXt5u64AMgDigtxil6KQnQwmPKNZdvh/S3P+Wing/txLyr8xu+fprqyNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ANFPoGNQGzKup1MLOP76wohv2h6FEkfMHrsonsw4Mg=;
 b=fLJAudKmPxD/M1+Vh5GCP+YsBRnvONw96Y3qtnwtCZ2OUPTb6VjW9yY/1UZxxwUFEaxbhbtG9b24z2qPo+WZ8SKNM1JhzmY1WrKX98J88U5uZNaUydcb9mEdAbK4mxm45rfpqwvsfpOVrHmSZCuR+yhtDSWqr/A1W3PAMFSdiBc=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1985.namprd11.prod.outlook.com (10.173.31.22) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.15; Tue, 10 Sep 2019 07:46:04 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::5864:dae1:9b7e:ff83%4]) with mapi id 15.20.2241.018; Tue, 10 Sep 2019
 07:46:04 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 1/2] staging: wilc1000: remove unused interrupt status
 handling code
Thread-Topic: [PATCH 1/2] staging: wilc1000: remove unused interrupt status
 handling code
Thread-Index: AQHVZ6vMJxNkB4UPSE+yElL8DxZzpw==
Date:   Tue, 10 Sep 2019 07:46:04 +0000
Message-ID: <20190910074514.3073-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: MAXPR0101CA0002.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:c::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.22.0
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [27.59.41.188]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 961d2cef-aa9d-474f-01fa-08d735c2eeaf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1985;
x-ms-traffictypediagnostic: BN6PR11MB1985:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB19856B7A1566045E99246721E3B60@BN6PR11MB1985.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 01565FED4C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(396003)(136003)(346002)(39860400002)(189003)(199004)(3846002)(6506007)(6486002)(25786009)(476003)(7736002)(1076003)(71190400001)(71200400001)(6116002)(2501003)(2616005)(305945005)(5660300002)(486006)(52116002)(2351001)(2906002)(14454004)(99286004)(26005)(186003)(478600001)(256004)(14444005)(50226002)(102836004)(66946007)(66476007)(66556008)(64756008)(66446008)(5640700003)(6916009)(81156014)(81166006)(86362001)(8676002)(8936002)(316002)(36756003)(66066001)(53936002)(107886003)(6436002)(54906003)(4326008)(386003)(6512007);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1985;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GoGmPLCoCBKJ9ALGcBE0uj5yEHZZ4kYVBgrwjohTvjQHeSKUvHRuAYtUZOvni5kbWY+43RyXp9SGy5mqlzX0ZfOJ7iU52i+N3RwR5SLylb2vFtVWTsEzWCn6UVBKzG+dsaKckHa+iHk5++BHbPqjoWXf2Lu7LWUIjS+C+otHOElMacMlxgh0X3ZDYWWkqQh65jR1CQ8E4R0Plqgn41cl79eymHY4hOcEzmpwlL4n6enSGCMYe6OuUX6pfujuYXnTqfNtOgO9NDmTCxBYlLkQorCmhq3Yt35orclSwXKqx+EuUqEqfJa9b8LY3bIZF62LC5JhhttYlcfr5dQ+ZLlJZzRvXYNauUWuW19Z6ZOAj6rSO+euUSxMOP34wOYFV907/Thy21GJjPlif0iw1yv/NvS7gbrSn2OqowVTmKsiZwM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 961d2cef-aa9d-474f-01fa-08d735c2eeaf
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Sep 2019 07:46:04.5316
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1ahRJROMkPMUxnxboLdXiFlInmxNyNne/o5op7cT7KozCfTg8y5CeYKEJn1u8a38/J9GvJRklBHn30sJdbAqHBRrdZYIajK00ueeeMqG++o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1985
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Remove interrupt handling for unused interrupt status(PLL update and
Sleep). The firmware only initiates the interrupt for the data transfer
to host and rest are not used anymore.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/wilc_wlan.c | 26 --------------------------
 drivers/staging/wilc1000/wilc_wlan.h | 10 ++--------
 2 files changed, 2 insertions(+), 34 deletions(-)

diff --git a/drivers/staging/wilc1000/wilc_wlan.c b/drivers/staging/wilc100=
0/wilc_wlan.c
index 2bbb359d2119..771d8cb68dc1 100644
--- a/drivers/staging/wilc1000/wilc_wlan.c
+++ b/drivers/staging/wilc1000/wilc_wlan.c
@@ -758,26 +758,6 @@ static void wilc_unknown_isr_ext(struct wilc *wilc)
 	wilc->hif_func->hif_clear_int_ext(wilc, 0);
 }
=20
-static void wilc_pllupdate_isr_ext(struct wilc *wilc, u32 int_stats)
-{
-	int trials =3D 10;
-
-	wilc->hif_func->hif_clear_int_ext(wilc, PLL_INT_CLR);
-
-	if (wilc->io_type =3D=3D WILC_HIF_SDIO)
-		mdelay(WILC_PLL_TO_SDIO);
-	else
-		mdelay(WILC_PLL_TO_SPI);
-
-	while (!(is_wilc1000(wilc_get_chipid(wilc, true)) && --trials))
-		mdelay(1);
-}
-
-static void wilc_sleeptimer_isr_ext(struct wilc *wilc, u32 int_stats1)
-{
-	wilc->hif_func->hif_clear_int_ext(wilc, SLEEP_INT_CLR);
-}
-
 static void wilc_wlan_handle_isr_ext(struct wilc *wilc, u32 int_status)
 {
 	u32 offset =3D wilc->rx_buffer_offset;
@@ -827,15 +807,9 @@ void wilc_handle_isr(struct wilc *wilc)
 	acquire_bus(wilc, WILC_BUS_ACQUIRE_AND_WAKEUP);
 	wilc->hif_func->hif_read_int(wilc, &int_status);
=20
-	if (int_status & PLL_INT_EXT)
-		wilc_pllupdate_isr_ext(wilc, int_status);
-
 	if (int_status & DATA_INT_EXT)
 		wilc_wlan_handle_isr_ext(wilc, int_status);
=20
-	if (int_status & SLEEP_INT_EXT)
-		wilc_sleeptimer_isr_ext(wilc, int_status);
-
 	if (!(int_status & (ALL_INT_EXT)))
 		wilc_unknown_isr_ext(wilc);
=20
diff --git a/drivers/staging/wilc1000/wilc_wlan.h b/drivers/staging/wilc100=
0/wilc_wlan.h
index f566d040bb72..7469fa47d588 100644
--- a/drivers/staging/wilc1000/wilc_wlan.h
+++ b/drivers/staging/wilc1000/wilc_wlan.h
@@ -128,8 +128,6 @@
 #define WILC_CFG_RSP_STATUS	2
 #define WILC_CFG_RSP_SCAN	3
=20
-#define WILC_PLL_TO_SDIO	4
-#define WILC_PLL_TO_SPI		2
 #define WILC_ABORT_REQ_BIT		BIT(31)
=20
 #define WILC_RX_BUFF_SIZE	(96 * 1024)
@@ -185,14 +183,10 @@
 #define EN_VMM			BIT(8)
=20
 #define DATA_INT_EXT		INT_0
-#define PLL_INT_EXT		INT_1
-#define SLEEP_INT_EXT		INT_2
-#define ALL_INT_EXT		(DATA_INT_EXT | PLL_INT_EXT | SLEEP_INT_EXT)
-#define NUM_INT_EXT		3
+#define ALL_INT_EXT		DATA_INT_EXT
+#define NUM_INT_EXT		1
=20
 #define DATA_INT_CLR		CLR_INT0
-#define PLL_INT_CLR		CLR_INT1
-#define SLEEP_INT_CLR		CLR_INT2
=20
 #define ENABLE_RX_VMM		(SEL_VMM_TBL1 | EN_VMM)
 #define ENABLE_TX_VMM		(SEL_VMM_TBL0 | EN_VMM)
--=20
2.22.0

