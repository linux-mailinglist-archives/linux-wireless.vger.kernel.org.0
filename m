Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4E02D2911
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Dec 2020 11:39:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728878AbgLHKjJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 8 Dec 2020 05:39:09 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:26077 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgLHKjI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 8 Dec 2020 05:39:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1607423947; x=1638959947;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=S5yswKEFOBdPGpPLJmC7mkI5Uy442wbHpTFVGT5qCg0=;
  b=EhRligxQ9Uqd7b4UvcKRHATAuxgwF2AEAvnL0HSHgg2RqcbLyk/ZteLx
   1cNlUlcx262yITkeQpr1dDXTdcCxCQqnwgO3S2FLCK6h+a4EGkcsV7EOJ
   7DxepdErehp6HtfkX2ziRZbXFHwZKdHDvVmUdyhYC5sjjyg+tDgH0W3ZN
   cpQNMnY0WddNHdVqo2naH7Ey3HIHXjPT6MVDpsTIt62AZleNZK7gIQkFt
   XBzoo9VdeLpUFLRizuo8WH/TXQPwmdo8E3oEJlxLx8bVGlK7+XtfmbE5Z
   tw5PBePmBZ1q62Gpx70P1sVx1VEogkUk8HEA3rg2TicDa37eEgs4Abm1v
   g==;
IronPort-SDR: sohzFpREqIwKpH9q3aDfqWXmj0ecrl1d4ycRrRmrgfulM88Zcp5wYRLrEAxC2uCyxxvEQvA13d
 ymDZcA4AKn6eUnvW55g3/BiWW3KE+frYjQHAXMkcdGMlB70yRJowq149y75B2A7MizykkTq4BB
 wEX3Ugq7nc+8PeBhycANf6q/Bknml6+i6pQdy56KGg9mHtgMYR4HQ8/IrkbCSBsDDIxogJTIBO
 AhtD/mGSa5jwm3wPI4BpsQMovUWAbbWSFmHaCCEE9GVHACuhs6nHPXHba/NNRFgBu+Po635WZt
 p74=
X-IronPort-AV: E=Sophos;i="5.78,402,1599548400"; 
   d="scan'208";a="101910370"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Dec 2020 03:38:02 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 8 Dec 2020 03:38:02 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 8 Dec 2020 03:38:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Yn1VuqJGC3IGVWgMCRIvrXFIJSK8DU8ZqvG8QP4AzwBCtkIXveteDtwEAEJAQQNPLtcPuuvEXUX/icjzEYtGRvg81QeFBrdcsvWZnoLs71bLZ5WK7FrmAJidae2XY7JCoSo+H/tAkplIXdonpmLK1fRYcfh9TPwH98e6aH/TxcM9V5F3IJ/4BoMhh4en7rVzcnxqEE3UifCnyBqtxkIOum4ViuXLXmEupfIIsh5I+6y5e7Gb1JbjM+nfPQJXb48a7X+XyBofH/coH1FeorEb93fextRe7p6DzFqCFHBmW/UDJNF0GPd0KWlCrLjWzz+RbGJTcqavODPPCbTUzubcXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAfAT3rrR3lahql6So1BFYUzUHQrbBXuBzZUWgEj0z0=;
 b=WyI0Akm0JwaybVEY7PHO/gLQyzXAUoUkdcLccPQHk3HqfcIBspPiJgSNL2R1CCzKOXJQl5mCHdZh+zso62YTKkW8UD9SiBRrpwCKwRa6S5kb2COONUZtyG6tBMyATsF1DylRfelNfdJ8jjXc47yW3Ta5Fa/7+uMF+4DLPkgUoTRB6i+tLUc+g5adYTF8NyPLM/KH1rtg4WFVRM8f8SFQrHekjtf+w93bAungjc4stpcym4YNQ1LCzAoOKCIT8BKDVgHOtb2MJ7XXdXtvbfGQMC+eKmOlMvlsD6+1T4IWYmZD6k+SDXr7Bc6e95KCVDBCfL+KENnGbdZefMeJuhyGqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yAfAT3rrR3lahql6So1BFYUzUHQrbBXuBzZUWgEj0z0=;
 b=SQU8myOgaZSWbwZkPbACaVdtiJoSHhVRL8K9Np0gCJ+QIj7H7vW9uqRCKyvVmAwlvrF5o+G55q0oDmiuDAB8eXJ4q+BRn8oTZW7+Hhh4sEeiVUGJzC9j29A9QaSc0MgmZrl/IowQUxtokFLi9+tuu14KlKnfJRwTzrglrWq/3gQ=
Received: from CY4PR11MB1286.namprd11.prod.outlook.com (2603:10b6:903:2e::21)
 by CY4PR1101MB2168.namprd11.prod.outlook.com (2603:10b6:910:18::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.17; Tue, 8 Dec
 2020 10:38:01 +0000
Received: from CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988]) by CY4PR11MB1286.namprd11.prod.outlook.com
 ([fe80::a0d1:a499:1c83:a988%6]) with mapi id 15.20.3632.021; Tue, 8 Dec 2020
 10:38:01 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>, <kvalo@codeaurora.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH] wilc1000: changes for SPI communication stall issue found
 with Iperf
Thread-Topic: [PATCH] wilc1000: changes for SPI communication stall issue
 found with Iperf
Thread-Index: AQHWzU4z9ZWBhWbUDEWTavke0mxVkQ==
Date:   Tue, 8 Dec 2020 10:38:00 +0000
Message-ID: <20201208103739.28597-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [122.168.39.229]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31b61bf0-b323-44e5-67b9-08d89b655619
x-ms-traffictypediagnostic: CY4PR1101MB2168:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR1101MB216820039D7BD1C34DAE1BFCE3CD0@CY4PR1101MB2168.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:820;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Y17hTy0u+vpwSkQWdV/7LxPr2xRmN0jiLD0QazJclML6aqc2zt5dT1KFJjq+68YboRYGPN/DlgZEBAsHRdBeRMH7QhDCZRKmSErbVLr7LVToP+2HPE3AjFE+5D9och15irzLTXly6QqOCh2c08wqo4AnCtFo78IH7zq0g+SOpz9ICMl9AqgIfXaViM+FVBvZVU1WHJXX7/+ce0Tpu94oDrwDLZ3QHTsmudGoxLYMK2h/FqIzLO4AanD9iDIbTfdgpZEGXoF7L0JwRgX+oEg/IK5eRll3eYLhKFTOTMto0hsFH6GWmPLC6Xkdm3NTx7Ksxq1VdmfRK+fJnvT4+57x7A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY4PR11MB1286.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(136003)(396003)(346002)(39860400002)(5660300002)(91956017)(64756008)(66446008)(2616005)(66946007)(66556008)(8676002)(6506007)(26005)(71200400001)(6512007)(107886003)(54906003)(86362001)(36756003)(2906002)(66476007)(186003)(316002)(4326008)(76116006)(478600001)(110136005)(6486002)(8936002)(83380400001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?zTnhJAl7vN65bFOCFbRWhAsfCpXQw9TwxnHMDvJ2iSUgRsxsNYtKDbWVIK?=
 =?iso-8859-1?Q?PhE4NmWx+Rkv4Ox948ePZz1FGHcYchszns1pA0jN3rLp8+TisdccbYim/b?=
 =?iso-8859-1?Q?EtpTz6nDxcbeyM/FxmgI/MGXYGEpukz52d4GTC418XoWf6Glp/9lAvQCU0?=
 =?iso-8859-1?Q?pN5nIfkb2FVWdzetxlarbD+jWL22+Fz97Q0B+PFOeY14ghgfgkoA3CjRkp?=
 =?iso-8859-1?Q?7usUwZsHY0EqwmUzV2bYFf+7Z5TROOt01I/u9+kxnfgKu2ceCuB1+LfVec?=
 =?iso-8859-1?Q?VLSvbLJYTZupCobD1NV9S+yAOY3/elefOhDbbp31cKGguQBGRzB92tTVwF?=
 =?iso-8859-1?Q?JPp3DSx/L66o+BQcsEO8YxayUFw6O95u/R2qqnOEx4upvRIJzL2TTI7Gn1?=
 =?iso-8859-1?Q?T4rPFxBrXLMVLSx7FKVilgFtL/KLIs/q3J18JmUquoaVuQp6sORwTVJfaQ?=
 =?iso-8859-1?Q?R2jRBRXqkiD617EndsMx5zJy7p+laFtWpt0IR3GRxRqWtyOMZoNAPx9ci5?=
 =?iso-8859-1?Q?U8hyTJnUzeQdevSp1Evexvdh1LlJcGl9DG6RJ2yvmHGW9/nZmL57Su6efi?=
 =?iso-8859-1?Q?LVizlSXeMs8oLF/a+QfQCo0yqcQp/FtVeBkZJuLFa7ek34C7qlQJx7schd?=
 =?iso-8859-1?Q?1b3JDO9JwkWjvNwAM6ElGjiFwqmoEHI6teD5wzvsbn9uiQgH9vgPmI5Y2u?=
 =?iso-8859-1?Q?eaXWmu2cwZuZdvOCo6TCtTJ6duGXcu2LCGDC/32osviXeoC1VqximLeGlN?=
 =?iso-8859-1?Q?XMS5+r4kTNeHDhOpwD8D9Yax6+m+yB86mfgLlsfTx+nBMF85ty/xX8Vhwo?=
 =?iso-8859-1?Q?ALcE+ZiedIIOIhMyLxcmAoDjeVVaB2YP/FEBE6Jy7iMcsOFv6nYUv9o83M?=
 =?iso-8859-1?Q?ak/NShbElQGgqrxEwtCeMp55I6YQavO/+6eUoLVycv9qxBCtDVMYF/jN5t?=
 =?iso-8859-1?Q?dC7Vlziy3i77lJ0Olqo2Qtyn2F409BBWeQDSCnQg4e8HylehVawObNtQPg?=
 =?iso-8859-1?Q?/Tzt/u4N75W4jL2dw2GcoJZhxFrj7+CLX3eJZO?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY4PR11MB1286.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31b61bf0-b323-44e5-67b9-08d89b655619
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Dec 2020 10:38:01.0353
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1sq6Xnzt3k2rzeHi2XO1NiZ1HUA83NcHvB4uV8tuJRQAI6VilP10Eqr6q0S/vNaFA80OIXky7vCE4eW4RU1cjDMpQySEH6vMfAQzWqyC9Z4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1101MB2168
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added retry mechanism to ensure VMM enable bit is set during the
block transfer of data between host and WILC FW.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 23 +++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index a18dac0aa6b6..be732929322c 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -35,6 +35,7 @@ static const struct wilc_hif_func wilc_hif_spi;
 #define CMD_SINGLE_READ				0xca
 #define CMD_RESET				0xcf
=20
+#define SPI_ENABLE_VMM_RETRY_LIMIT		2
 #define DATA_PKT_SZ_256				256
 #define DATA_PKT_SZ_512				512
 #define DATA_PKT_SZ_1K				1024
@@ -856,8 +857,26 @@ static int wilc_spi_read_int(struct wilc *wilc, u32 *i=
nt_status)
=20
 static int wilc_spi_clear_int_ext(struct wilc *wilc, u32 val)
 {
-	return spi_internal_write(wilc, WILC_SPI_INT_CLEAR - WILC_SPI_REG_BASE,
-				  val);
+	int ret;
+	int retry =3D SPI_ENABLE_VMM_RETRY_LIMIT;
+	u32 check;
+
+	while (retry) {
+		ret =3D spi_internal_write(wilc,
+					 WILC_SPI_INT_CLEAR - WILC_SPI_REG_BASE,
+					 val);
+		if (ret)
+			break;
+
+		ret =3D spi_internal_read(wilc,
+					WILC_SPI_INT_CLEAR - WILC_SPI_REG_BASE,
+					&check);
+		if (ret || ((check & EN_VMM) =3D=3D (val & EN_VMM)))
+			break;
+
+		retry--;
+	}
+	return ret;
 }
=20
 static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
--=20
2.24.0
