Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40C8440E432
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346931AbhIPQ4Z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:56:25 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30349 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343901AbhIPQw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811096; x=1663347096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t6Ho8fsnJRT4pFlHTfBkDs5XdQV1QaQMzrMxvpD3BF4=;
  b=yEGQ7ZN4/KW6eiJQzd4SA0dq7m4XWa0FmFNpt2tnOGXPuM66XL8xlS0+
   T8TbrEOxmiYiDYO6tcA5D5AbYgJn7E/MpSHouBqe064beL8v8FzBlf0ep
   Wf4WIak3aaFDAI6b5sIPH/No7iCCdnKkeUWBt41d329VZd4u2mmkm4OX6
   fjgp6za5L2I8Pz9rj3vSPYDcYyd9dHxSPJKs2LFgj4aDj6kKOTT3ppeKL
   hwcAVNABmgSzwbu5OzZAz7CccQRN9NchD5mutZRoVOuqGfRdmoDU565Dp
   O1yFl9nNj85wGAHIzI/X6dY4csncTSxOWf0vecuBtHm6oA0LuB5TI0R6e
   A==;
IronPort-SDR: bsshP2BcF7v5bMcD+57lGHeZdqUME8o2Q0s0Zj3TXAkRg4c3r1aR4cEeHoa5lkzIHsjy0NL837
 hG0Ftyy1BtxdZfLxEFBlmCgm51H2hdlw7skv0LHfMzB7gPno2kfMcFhBYqrON0/VG+kzLY66ZX
 3jk08scrBQnvpYmWFg72xUXUOa3VVQal6hO8ASqpq3OF7WK9+VLs7DdcoN1DFu9t+hd6uGTPXG
 nBAhYzSw20nSDbD8rP32mwE97FwvlERFJ04AJIBHRnJNcCRTeIzAerO9jeqc/XUGfGhhBH4O45
 WSyDE9GF/3i1s1KhZfxAZ/Yg
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="136238779"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14 via Frontend Transport; Thu, 16 Sep 2021 09:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MEszD8CoIC/hsI5fmbCM264m9NepoT48IQ7NZlOQO7FrLhTKxa/1zpZTVGL9LQiYyN1WFeHQHaT25PsKza3phEM5PKP/ZzEZPhTb9pa6gao+hJUMRTN6RqjWIr8mwTknJGkLDcK+xtnIv0PdDjucC1PotciCKomhSHY2WOfowOsOBGmYTV/sIvIN/hUEOEaYureYxBl7rQSSbLt7GI4P2CvCw3B5Mvt0Ls0j+Wvx3HFxndVRWy/EdJwwG8KnDAHr0/kFWwgjAjzardEszHqOMSE1CalyVhW/BIEBHHu/eogOUMfCgG+47AMVNMEaobNqJqAHTJkpw22bU+CjybIjdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=7aPegxO/+CG115n3TIRRCS9a98He08E9uoNUMIfBpZA=;
 b=PTOL25pr2DQfcpyHdspTByjDvrE1EkMR8Tn9/52RHqCHRmAkbnN9NWUd2+7fu8fbwCS8vqJgbJ0DcGXlbVtcsFBwZ06oO0TsbqZqfxCYh65e1nJkNtpQtdthhKa9eUlKS/ZhfzYdLFUGIkHQNMmknRqwiM4vTkTb9BG/9RkRg8rHu+Ah9FSHsRnS6pPNbzjTWdb4es37ywDcspPYJmWVzMe5sU7H7SAClzO3EQ+N/oquF/2/fvDZO/77LGHjM7RY1kyEXOGBNkhv9/lML/7i6zPo4GPLX4vq2bZFqth4vF/CUVfwfHgpdVj1I+JmE7osmWHieMbfPLyEswBSfX72ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aPegxO/+CG115n3TIRRCS9a98He08E9uoNUMIfBpZA=;
 b=G3emZI/IlA6WJLNI780uYofC7PJeYEDwlh27D6gzRgrazIgyJ/AGgLtNWjQU1uhYRPxA4odKUZ8ZIL8CyX0HRNu34TH8zEgkN9nJfXwQ3ZMhuzS8X9CQHMqHWs5O3KwQKk6ftLPjvMBHbYl0o9PSEKUzNM1Z0mcY8FyXTG4tun4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB2565.namprd11.prod.outlook.com (2603:10b6:a02:c9::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:21 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 07/11] wilc1000: ignore clockless registers status response
 for SPI
Thread-Topic: [PATCH v2 07/11] wilc1000: ignore clockless registers status
 response for SPI
Thread-Index: AQHXqxrLGIjBTiaNfUSpoDTifV22Fw==
Date:   Thu, 16 Sep 2021 16:49:20 +0000
Message-ID: <20210916164902.74629-8-ajay.kathat@microchip.com>
References: <20210916164902.74629-1-ajay.kathat@microchip.com>
In-Reply-To: <20210916164902.74629-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.25.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: de28360d-71f9-4d36-505d-08d97931ee71
x-ms-traffictypediagnostic: BYAPR11MB2565:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB25650B8658295B4BCC378DB8E3DC9@BYAPR11MB2565.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3GVurQPY3rdtcf0Uzxj8OxPBa8wK2EkFBJVCt9dlr6hVUHkDwFGMAoamEasfS0T9eYO5rAC1/R9wgq43uBp5sTuRM/3UrSQvOn7T+JMHvwpKuIm6yRmE0MUUYU4S+LLqyndKpAGn3hhyRarrlKWkLwYbT4/TDMbIQzIrYQVw33wPhiz85WHlNjK1/PPQB1H2wlo/unwbooop6LVYbBUczD/gUlOf9O09BVpNd2XjxUoVDA/DXDQGZTqyjX+KJ8W7NHU/218+0HDijZU721Jm5EIV+zUFKGdyCT61SKLU9p7qI8KDDLPLtceTE2DPBFnq+5f2Z9J+mlhhFppot4T74g6pz4faoajD0u4/ROucIw1LVR341rlv+poav2h7mrjDcaH7yeDS3CJ17rRexGidpg/WlC086pZsFi/9NEY3QpJaThc34vPHP8sZtPFWWqRnQbIEalCNktQG4hI7ZqPwAIQMucMuEueXiU1t046FEfjhpLZkfpzZr74bbj+qs0GC78r033OVkHBMc5UYXBsXn8o5ysmxZp9k/2WlUp6JV+yZDjoEyySZlB+veQ3UMwUlHRCmACtetyQ9ecuf2/JOOi8w5FVqLNGBw4RtnVulQXrPIhySYfAGu4iI9p5Tkqggo4+bMTSdk+w/RMaYcjckIV/x6IZwCL+bCgIJViuIIzZiSJYiIeUM7+SZUzmXCBcWFXbaWTEN7bGZ9syKZ1/1gw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(346002)(376002)(396003)(366004)(26005)(107886003)(71200400001)(5660300002)(8936002)(2616005)(122000001)(6512007)(186003)(76116006)(38070700005)(2906002)(66946007)(38100700002)(66446008)(91956017)(6506007)(6916009)(8676002)(64756008)(66556008)(1076003)(54906003)(66476007)(4326008)(478600001)(6486002)(86362001)(83380400001)(36756003)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?bAHxoTT5WFXpFy2EJFjpKNnyrBjq5Dx1KcR/R245aB0LsfBTDXx+nXqgos?=
 =?iso-8859-1?Q?+zdpVo3u+YDzg9rke7oMWwdZ9C0cplxxUczDdq5v5BhABvWmPJzSn/MeSp?=
 =?iso-8859-1?Q?An2nwjU1NaUJjCyFIDMTBrR4IJ3SC82ELR7uIcUFSHSQ8a+tuNGZDvVKGl?=
 =?iso-8859-1?Q?n5LC5Ybx/uKXpe89EbbQoOZQL1oGGcytIF5pa6jC/UGWG8XUHX+oLCshkO?=
 =?iso-8859-1?Q?Cw+cqXmUenDVYn4sb+rhsBBGcPvWfoekQVKRLVFJEfT85wT1EfyxpAZidz?=
 =?iso-8859-1?Q?JN/E8Yx8hX9WDhzpRexp6CCQXwWk2Q3rs3ruL4RaZDEM+ktg8Kz4ZkEPjQ?=
 =?iso-8859-1?Q?PEDGalFAtDOm2dN55Vko1d4rqEnk7qaz/dhdnm00Gu0Z4xzIbhsJAAR3QC?=
 =?iso-8859-1?Q?zhh40IN1d5TZfQm8e5xcRq3b3D+D5KhIGYJqbWZJAcko7y2mvTAUcE5+4Y?=
 =?iso-8859-1?Q?WmXHgIQQrvYHQokr7+Xfy1dlY529GbbKmuhrBl6oUYaSqCx2CFnjX0dAwa?=
 =?iso-8859-1?Q?fGZUpUDsduErNN6dz9Gzjo/j4Vt2Skfjl21hHfAiwy0XTqGUJrPpnMG0yJ?=
 =?iso-8859-1?Q?Awp/nOiDoAloovjU5msPpKBFt3WhkjIUS1QmKSRTc4O0A3d2SvQTXTnltu?=
 =?iso-8859-1?Q?JZnsI5yjEAw+nT+LjBCm7Ygu+Vq5C+8x0RGB0vxy+DgfUoZp6SlIi9Na18?=
 =?iso-8859-1?Q?A+9KTMO1eLyHkV1QP5AVKCU1354h92LLggPPjMvy6ysgE3OhNkHHX8GMwY?=
 =?iso-8859-1?Q?QDLZcO3SM8f11F3faeXXfwK5Jc23VVWpkSF3e6tcTgosCMwsDoOcFyX2NX?=
 =?iso-8859-1?Q?Mcu81ev/E9jW3jSbDh+US4GxxS8A4AgRvkQXwFRaxRGrOYUuu6dI+u6kAB?=
 =?iso-8859-1?Q?XX3yk+h3ATM43Yf0CjTPsDul1QjXsSlkV6ESomDi4uZFgVSWYPKp/i4yL1?=
 =?iso-8859-1?Q?SA+mOzJUOTXV5rjo7cC0Y/yJQwVWgKD0yvC1oakvelNZVLPDPnZpUBD9fo?=
 =?iso-8859-1?Q?lG4pQ5TgB+/NxTzoyUsz6sSsPCVBwrXmP9jNP0W6CiGPV8b+SVEOLKf01T?=
 =?iso-8859-1?Q?EvAHWW3rEwcsOkoRPjju7bN1QmYvj+5S03axS4f/qs12YyHLG1LbeLHWUD?=
 =?iso-8859-1?Q?JuNRFxpoxSe9ATVMSmQyUjNCdbrSghj95+LS9w3E3APcq91hU/8yP9UZ+Q?=
 =?iso-8859-1?Q?BEhvtU5rg9lk6ocTsZAV3hwo8+rAJ9Uce2VdH7FK0gFnZQ8lw86/5my9Gh?=
 =?iso-8859-1?Q?Resrp55kN8J3IIuFOa+yZXRworeSUhb1dbUc3LBy2Gv29Bba+sdnNXlDvg?=
 =?iso-8859-1?Q?GDXO1r55YSd+kHXNOJVjHGZosdMXGmine5RcN+zmNH6DIGJ7ZHJy7Bwpax?=
 =?iso-8859-1?Q?CzjNWNE/kM?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de28360d-71f9-4d36-505d-08d97931ee71
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:20.9242
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: J8HD0iij8F7zZLrWPn6LHuQpYtX8f4v4FShIwWW3h/bRGht7IYWyn/jJ9OEb6fGv7PRBEOz9LfydEyiyFBAAbwPm90QE4Bmrk+pm7XHlabw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB2565
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

During WILC chip wake-up sequence, the clockless status register sometimes
reports failure even when the actual status is successful. So, for the
clockless register, remove the incorrect error status reporting during the
read and write command API's.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 511b9264185f..4f0bc24d2a78 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -474,7 +474,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 c=
md, u32 adr, void *b,
 	}
=20
 	r =3D (struct wilc_spi_rsp_data *)&rb[cmd_len];
-	if (r->rsp_cmd_type !=3D cmd) {
+	if (r->rsp_cmd_type !=3D cmd && !clockless) {
 		if (!spi_priv->probing_crc)
 			dev_err(&spi->dev,
 				"Failed cmd, cmd (%02x), resp (%02x)\n",
@@ -482,7 +482,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 c=
md, u32 adr, void *b,
 		return -EINVAL;
 	}
=20
-	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS && !clockless) {
 		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
 			r->status);
 		return -EINVAL;
@@ -571,14 +571,18 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 c=
md, u32 adr, u32 data,
 	}
=20
 	r =3D (struct wilc_spi_rsp_data *)&rb[cmd_len];
-	if (r->rsp_cmd_type !=3D cmd) {
+	/*
+	 * Clockless registers operations might return unexptected responses,
+	 * even if successful.
+	 */
+	if (r->rsp_cmd_type !=3D cmd && !clockless) {
 		dev_err(&spi->dev,
 			"Failed cmd response, cmd (%02x), resp (%02x)\n",
 			cmd, r->rsp_cmd_type);
 		return -EINVAL;
 	}
=20
-	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS && !clockless) {
 		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
 			r->status);
 		return -EINVAL;
--=20
2.25.1
