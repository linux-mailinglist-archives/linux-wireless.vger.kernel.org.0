Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8D875FC5A
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Jul 2023 18:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbjGXQkk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 24 Jul 2023 12:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbjGXQk1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 24 Jul 2023 12:40:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96B471FEF
        for <linux-wireless@vger.kernel.org>; Mon, 24 Jul 2023 09:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1690216807; x=1721752807;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=GgfIcdVjshc8a0J8ZKDaoGtQ6aQvKvwvAgtN+4u9UCU=;
  b=AYS7rZrxuL+VCjG2nHTzqJ8oWaVxOLsWjJxIFFzoKfBnuNE9PNLngsan
   Xp7cj550GHZHm3O+qgBhKEJozOTlHWgvP6ZjBcca/c4Ma2Ejh5X+L7+r3
   5RmTqebJ63bPY8d9nKlBWJpmMmLiDFecZNwOI/U5+lpcM7RZlPO2He96V
   Rq3myXFbp03U3aKief8GzhRvezbAntnagd7lpE+B0Z2Mq9BgNB57Remzq
   7Li/nWmtTR+MhVI1dIgp29+tZ8AFZlpe55FPOSTkHudUEFlh3SkJKR+k4
   GI6evmTnFOkYvz9gRhV/7Nj4phyxQLQkWlVyNEjlRtvXvbTPQikLihhQm
   A==;
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="221927550"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Jul 2023 09:40:06 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Mon, 24 Jul 2023 09:40:03 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Mon, 24 Jul 2023 09:40:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CVK1YqjMRKhIvwmyqiTjGfKOKdGfKhYgKHgmFPyCERJMN4ubdL+E8w34NXEIqGUwTGQdXAVFzT8o6wrVv9Ve9Ibu5oRpFgMgJJ1fGeZXc+p3HMbH64SQsDknyCdE7muMaOLmaB0mzGPcrA/LW9rUDTT6SGcRqnqrsoA8Ox1pjBmwt4ItfGUbQZi8gjtNpx57SOiRelRDeOQONbRBN4ZgEJ8tHyk76rN4+aQJq9QbuUlUATwMIoX4CCpC/EbvGwkJNHPNxI5nfEvg6DKSxLFGiwOplVJL5yRiUuNn2M8TTmzmc+KZI/T0HjU5K2kzM8oy6bYuT9fFp9+auZKUi17oJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PBc0PVm+ZZ/8UjMeRJ5Ks8IJHFqzxoKZxzey/axGkjY=;
 b=VyHAYNka6+eBNTZRYthL3LkAmfUUVbUbhISOI93RSJiDotaquul6BjuIIt8frrs6e3ECnf6g9SS38psN1UJRykMIhGA6zTwx36dDEVqAcZaiDFC1GtZNZEIzjpEWKTYu9ENpB6nS5AmlE28Um6IlaQoSo0uMZxOBGC8Riv67nF5xEm4m9G62S8QVa2ns5iYPNyiZQGTCNu6+TUXx+znHwCTp9DFrUnzTYwh5IwQIPsa6/hr/pTw9WwLSJzCe1C/6l8yTlKFHDcNbmAT3Z6/mV2w8YeJ0agRTWQ4jj0qRw7tyocV42iXK/4CxYnxu/OgLY5gEfIrUcbeP+M9i8wPgAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PBc0PVm+ZZ/8UjMeRJ5Ks8IJHFqzxoKZxzey/axGkjY=;
 b=uu4oR58kTi3gLWw3PtY4KrneKn7cUI/Hey0+8NN+aAIr28BfBvUsRiG5j2zms4p12rrI4GSSEKh4JSMeMxa97peQGsKhATqsBTck9VTfGwpQdQbpPvru+YQrskOAPV3friiMYZyYTKUsfhSyQZcG8jGkkXCkWNbykU8qXXVcREg=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by IA1PR11MB7890.namprd11.prod.outlook.com (2603:10b6:208:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.25; Mon, 24 Jul
 2023 16:40:01 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::a9af:d9e7:e19f:913]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::a9af:d9e7:e19f:913%4]) with mapi id 15.20.6609.032; Mon, 24 Jul 2023
 16:40:00 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH v3] wifi: wilc1000: add SPI commands retry mechanism
Thread-Topic: [PATCH v3] wifi: wilc1000: add SPI commands retry mechanism
Thread-Index: AQHZvk191dswHOSYmU6VZgz9X6Jhdg==
Date:   Mon, 24 Jul 2023 16:40:00 +0000
Message-ID: <20230724163955.4583-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|IA1PR11MB7890:EE_
x-ms-office365-filtering-correlation-id: 0d930fc9-fd88-4f01-e456-08db8c649fd2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: giPATC87+4GiJoRWFhZy+2QbeVkfaPL6eZ7t38uPLe13hmzaVCOs0psc+ar6ixVlbUArBAPUGI+mvT7xpoqrn7IRe7VA17zrOsFGxYSrm35YCRErVhqw8jEfz8+pyckMSEi0WABUUkAUX3xeEiY6HEXtoInUbksW+PlixGvLR0R8EBYUi7nU9gnRcwKGuqXE+oFxe4hEYAdlnHOAf3M/wgmOmMLiJV25v/Nts+P3DwmGe2uln3LBeTlkONXN8zQu5XwY/bNrQQgZskwQEM8m0rTpmxisKTMNeb4D/rE0e/cFxPJBkKKn0Tc8ROKR3DE+OqKYiElWy8NEvPtEPF+7AZbURIJ7ozusB4ddf45HnIxPrTRCExj+h3WUoZ6n6IHwk9ylWw9wbDDY/Zq+K0HOGutzWPuvaKx4IEmJHOGdIDsrAmHx8ZKz1nzOwe30J17JOHKvUdPDIi2pSs4gUDeMR4/lYmv7MjlbB3WKZKTrfMqEuiJZvog14nZY6W+62188pe7S5Yu8Sw1rkwOe7RZQ75cXQEzr8LfhuAgHhon5xkJ6SOkYPmZZYQac4JUI5Wddz90y2Yo75pH0MMG4943OrHKAr6tgUMvDPWmXw2kspRbveEiAO4HqYP2bBfqNFdi5
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(366004)(396003)(376002)(346002)(39860400002)(451199021)(66446008)(66476007)(91956017)(76116006)(71200400001)(186003)(6512007)(64756008)(316002)(6916009)(66946007)(4326008)(66556008)(26005)(6486002)(1076003)(41300700001)(107886003)(6506007)(5660300002)(54906003)(8676002)(8936002)(478600001)(2616005)(83380400001)(2906002)(38100700002)(38070700005)(122000001)(36756003)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?6cvWMVRlAxMCrdi/2x/l7PGb0Stn5/43m2ohyPoIQCa0GtCdnLMk51llkY?=
 =?iso-8859-1?Q?8GSj+0Sp2mfKJAFxECRWmtEY4Fmnq0RNKeJLR9UcJdC/u58NWiifN7rgLp?=
 =?iso-8859-1?Q?NOuoL8+iiF7K7f/DddQ0pO8kJOuDZ1ociBm4TstzrlVi4kK9N2V71FhXEA?=
 =?iso-8859-1?Q?4iiBQaNpgfaE7Ly9pAY+LnYOrVMIn5zCUrdzRJGW1btKh7pPfd7zc81Tcx?=
 =?iso-8859-1?Q?LncNh1ZvVPnncfoUkWODIrcHlJGIQqOAc2HNmnJqbFUQzbURzhUif/Iqrz?=
 =?iso-8859-1?Q?kP5KKfWBHkNdJqa3252DT6SQ1NkPUKwcxOJgaWRJzshlPTDd3usHcaiet1?=
 =?iso-8859-1?Q?yVEPR11GPGvsTxAMqLLYcrBT/aC0FeEvKhLDhHCQABxJ51iMoDRwqOKH2I?=
 =?iso-8859-1?Q?L3/yiVJCPrmOblC5C/82UdEvzQMOuMv2sSTwc34+oEsUnKgtpVe1S4h0zL?=
 =?iso-8859-1?Q?KQw5eXXsV50OSccay312E3glYba6OVD3ud7yh9gC5x8U/DS6nKE6WgD2aw?=
 =?iso-8859-1?Q?8HBH9SdzXpjke9FZYkvKS/lwahpZCY22SvFbxtjjT3SNP5sH7GOCUF8REw?=
 =?iso-8859-1?Q?uJzhnIkaqth7TXyUNmQcT/Rj/2XuF8IYqXMvsy8N9JNFfPXC9bVJzk6m7b?=
 =?iso-8859-1?Q?NWTvlpH1jvjIGocYq49GKkz7l/HMeeAr7Y7jGDYZEFXoUgztunWzyddec+?=
 =?iso-8859-1?Q?DyncoV6bvFNB+vyHS8gW2EnEPORHYgcPRYahGo4Q/MqrixPBl2aJxyEqmS?=
 =?iso-8859-1?Q?5BM53Ad4H92TWpiPFrx73jndSEVMDe9709neAmZuDKtcwebu87lAXrNWb1?=
 =?iso-8859-1?Q?6U7XBPZsh2+HHuThPkOzA4VlEs3+UTSqvMEdqjo5Huj1gmONcArGuMSb0U?=
 =?iso-8859-1?Q?hF816NYf5bDgFjDKqkUcjL4W6Rs2w+iEGFYLtP/RsStjBwH116F8rcd9+g?=
 =?iso-8859-1?Q?OOEJ0PegK/7xVhAPviIldatebTMGdZz1MyC7OTAAkB0AcNgSF2xOULs8+m?=
 =?iso-8859-1?Q?12bpTBGPNCAloA/f06vFruvignoiRH2XoXrlgrLk1yEsKZZQo3Tz6yzwPn?=
 =?iso-8859-1?Q?3WUs6y1CIZ4FlLvBTq6Z0qWYJhPLocdLwhpd43rG+yKnu5qkfzrQMBH4zt?=
 =?iso-8859-1?Q?6DSJnOdSK34SPC2TC+DqKVKlA4/ZZGycJzgHT/tzFtqgjnq3DQli4NSZTl?=
 =?iso-8859-1?Q?S3j+ercjsCNuPYzl6YQUmDq25lO+j+XQiGtvyCD7ekY4kushYgVyEoJnrA?=
 =?iso-8859-1?Q?xZr3EBApIIah1ltozdNgBJLqWBc4Cjz0ZQFOsyOgnQYhh2WqWo8RrJpCa3?=
 =?iso-8859-1?Q?8OLbN7KfInYD66G28Re/m46fci2GT0/+k26ACnLZDrHuY53gjyznX0rCrr?=
 =?iso-8859-1?Q?BtZrrBtiwPplkv9HYJqZVhsOyD5RIuhsIstUBbdkcwNPxz7bwyErJlrZpY?=
 =?iso-8859-1?Q?aoHigrQIIc8KQHPQs/Pi8KCr8gkkNglMrdN1JQGVKU1aJJTMcfAwlBji79?=
 =?iso-8859-1?Q?YUkXk9ioh9pEKuOCowIzV8XN6aRZwStrkY+LiNALNgSV+EIN2XhBoatTdl?=
 =?iso-8859-1?Q?PaiMEiXVbVwdfhTZ1x8L60cW/o9eyecr0smtr8qx1k0Ub7eJA8AACMdOWk?=
 =?iso-8859-1?Q?KaPQCpRpcezgXoUlVKr7eH8SAtNksQhU4hkKz6Y+r5wOEZ9BwBMxa8HA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d930fc9-fd88-4f01-e456-08db8c649fd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Jul 2023 16:40:00.8769
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m5VT/2mG68hp1LcjY1lgvLrLROcVD713VP3XdIJ+ZAEdDLiK7Cpu608HYb7SceCt4ht3K6OYs+BYKeZ3A+2cKCgQ5HBc6mELR2R/nJcV+eU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7890
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Amisha Patel<amisha.patel@microchip.com>

In some situations like, chip wake-up with powersave enabled, SPI
commands are failing temporarily. Reissuing commands after reset helps
to overcome the failure. So, add the retry limit and reset command
sequence API for read/write SPI commands.

Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
---

v2->v3: Changed goto logic to for loop based on review.

v1->v2: Removed some false indentations and unnecessary if condition
check of result variable

---
 drivers/net/wireless/microchip/wilc1000/spi.c | 148 ++++++++++++------
 1 file changed, 103 insertions(+), 45 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index b0fc5e68feec..77b4cdff73c3 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -74,6 +74,7 @@ static int wilc_spi_reset(struct wilc *wilc);
 #define CMD_SINGLE_READ				0xca
 #define CMD_RESET				0xcf
=20
+#define SPI_RETRY_MAX_LIMIT			10
 #define SPI_ENABLE_VMM_RETRY_LIMIT		2
=20
 /* SPI response fields (section 11.1.2 in ATWILC1000 User Guide): */
@@ -830,59 +831,91 @@ static int wilc_spi_special_cmd(struct wilc *wilc, u8=
 cmd)
 	return 0;
 }
=20
+static void wilc_spi_reset_cmd_sequence(struct wilc *wl, u8 attempt, u32 a=
ddr)
+{
+	struct spi_device *spi =3D to_spi_device(wl->dev);
+	struct wilc_spi *spi_priv =3D wl->bus_data;
+
+	if (!spi_priv->probing_crc)
+		dev_err(&spi->dev, "Reset and retry %d %x\n", attempt, addr);
+
+	usleep_range(1000, 1100);
+	wilc_spi_reset(wl);
+	usleep_range(1000, 1100);
+}
+
 static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
 	u8 cmd =3D CMD_SINGLE_READ;
 	u8 clockless =3D 0;
+	u8 i;
=20
-	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+	if (addr <=3D WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_READ;
 		clockless =3D 1;
 	}
=20
-	result =3D wilc_spi_single_read(wilc, cmd, addr, data, clockless);
-	if (result) {
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_single_read(wilc, cmd, addr, data, clockless);
+		if (!result) {
+			le32_to_cpus(data);
+			return 0;
+		}
+
+		/* retry is not applicable for clockless registers */
+		if (clockless)
+			break;
+
 		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
-		return result;
+		wilc_spi_reset_cmd_sequence(wilc, i, addr);
 	}
=20
-	le32_to_cpus(data);
-
-	return 0;
+	return result;
 }
=20
 static int wilc_spi_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 i;
=20
 	if (size <=3D 4)
 		return -EINVAL;
=20
-	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_READ, addr, buf, size);
-	if (result) {
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_READ, addr,
+					 buf, size);
+		if (!result)
+			return 0;
+
 		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
-		return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, i, addr);
 	}
=20
-	return 0;
+	return result;
 }
=20
 static int spi_internal_write(struct wilc *wilc, u32 adr, u32 dat)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 i;
=20
-	result =3D wilc_spi_write_cmd(wilc, CMD_INTERNAL_WRITE, adr, dat, 0);
-	if (result) {
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_write_cmd(wilc, CMD_INTERNAL_WRITE, adr,
+					    dat, 0);
+		if (!result)
+			return 0;
 		dev_err(&spi->dev, "Failed internal write cmd...\n");
-		return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, i, adr);
 	}
=20
-	return 0;
+	return result;
 }
=20
 static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
@@ -890,17 +923,22 @@ static int spi_internal_read(struct wilc *wilc, u32 a=
dr, u32 *data)
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	int result;
+	u8 i;
=20
-	result =3D wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr, data, 0);
-	if (result) {
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr,
+					      data, 0);
+		if (!result) {
+			le32_to_cpus(data);
+			return 0;
+		}
 		if (!spi_priv->probing_crc)
 			dev_err(&spi->dev, "Failed internal read cmd...\n");
-		return result;
-	}
=20
-	le32_to_cpus(data);
+		wilc_spi_reset_cmd_sequence(wilc, i, adr);
+	}
=20
-	return 0;
+	return result;
 }
=20
 /********************************************
@@ -915,20 +953,27 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 =
addr, u32 data)
 	int result;
 	u8 cmd =3D CMD_SINGLE_WRITE;
 	u8 clockless =3D 0;
+	u8 i;
=20
-	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+	if (addr <=3D WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_WRITE;
 		clockless =3D 1;
 	}
=20
-	result =3D wilc_spi_write_cmd(wilc, cmd, addr, data, clockless);
-	if (result) {
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_write_cmd(wilc, cmd, addr, data, clockless);
+		if (!result)
+			return 0;
+
 		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
-		return result;
-	}
=20
-	return 0;
+		if (clockless)
+			break;
+
+		wilc_spi_reset_cmd_sequence(wilc, i, addr);
+	}
+	return result;
 }
=20
 static int spi_data_rsp(struct wilc *wilc, u8 cmd)
@@ -981,6 +1026,7 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 i;
=20
 	/*
 	 * has to be greated than 4
@@ -988,26 +1034,38 @@ static int wilc_spi_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
 	if (size <=3D 4)
 		return -EINVAL;
=20
-	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size);
-	if (result) {
-		dev_err(&spi->dev,
-			"Failed cmd, write block (%08x)...\n", addr);
-		return result;
-	}
+	for (i =3D 0; i < SPI_RETRY_MAX_LIMIT; i++) {
+		result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_WRITE, addr,
+					 NULL, size);
+		if (result) {
+			dev_err(&spi->dev,
+				"Failed cmd, write block (%08x)...\n", addr);
+			wilc_spi_reset_cmd_sequence(wilc, i, addr);
+			continue;
+		}
=20
-	/*
-	 * Data
-	 */
-	result =3D spi_data_write(wilc, buf, size);
-	if (result) {
-		dev_err(&spi->dev, "Failed block data write...\n");
-		return result;
-	}
+		/*
+		 * Data
+		 */
+		result =3D spi_data_write(wilc, buf, size);
+		if (result) {
+			dev_err(&spi->dev, "Failed block data write...\n");
+			wilc_spi_reset_cmd_sequence(wilc, i, addr);
+			continue;
+		}
=20
-	/*
-	 * Data response
-	 */
-	return spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
+		/*
+		 * Data response
+		 */
+		result =3D spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
+		if (result) {
+			dev_err(&spi->dev, "Failed block data rsp...\n");
+			wilc_spi_reset_cmd_sequence(wilc, i, addr);
+			continue;
+		}
+		break;
+	}
+	return result;
 }
=20
 /********************************************
--=20
2.25.1
