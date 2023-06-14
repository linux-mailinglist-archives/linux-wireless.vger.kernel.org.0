Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB2F8730934
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jun 2023 22:33:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233936AbjFNUdW (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jun 2023 16:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237004AbjFNUdN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jun 2023 16:33:13 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218082132
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jun 2023 13:33:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1686774791; x=1718310791;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=9g1EQABVX0ejU98RXhR4GxlmIeyGZ7Qb6OfjYb1UyHw=;
  b=Fr3sRVo7yXd6Kgskh/t0vdlmQG2YSSefzcAkScERVDt8H/P5QbzYrjmS
   bih+B0VXdf/XgCThdaiKLRzZ3oqmAmS00tmHdxf9axVPVVygBvSWJHOVU
   oWyuH2KhoaWYKTUoQHCulGwJojJ+i4IrL+7bC0zqCBwm/rJ/SwBw5uDj/
   Psj/6NxUrBrkBoisY2twqFVVFF0MmyXE+RUJXtBDjlds6eWfC/6wIlR/v
   q3HLQcoQG0uBrrJ2hmvrv+NpVTcGe8Egn6YYPjaMRm4t0t4Jf87FGfkVr
   SASnGDPtGtjKJJ0dVCa8TOHzS8FpX//bVMCUbew5nGu7NKeWabtEBWDX/
   A==;
X-IronPort-AV: E=Sophos;i="6.00,243,1681196400"; 
   d="scan'208";a="157007602"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 14 Jun 2023 13:33:10 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 14 Jun 2023 13:32:48 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21 via Frontend Transport; Wed, 14 Jun 2023 13:32:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QlnWGGU3MJ2c6+toC0JdbvNsGM1gxbO1rXJDWxSeh88jR+mFoRM4A30GDsWVYAimthXoy+lvrwNrJHVMXScW+p9kVbyUM0tvoFiBAFSOwIxSTY9EW/Zqbj/TBhDqdgmS2yopEMnh+uidrgfZ5CwFX7j+iik+QFvzPlFUOzxspClQB6mo7r2U22RX5iu9EKkTiOE27Zh6xriY4xr6GfrSJhzQDGEGDOwRxG+HAlBW1WDX9pd/zJ1YDl0Lc1gWMqhVSo8EbzVJ66Mq6b0xKkygwod/eNZI3wMDcyRqTzmqW4cxrxN95tw65ixWIfXx3NrRPfxO9msLjiZGUC6/Fb97Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bIqK6IeV/zUn9B4pZAc7rzt//glG6s/SH0S51IXjuMo=;
 b=gFJG9xdaH4IPvrbOSFPvp1G5h8ir/7ReaLINWioYdA4JSo1UWp7fKyVugf3MBgJO6t8It12P6PXgVBbG3b/290fI5v91BK8tFBesTTJB80u4U1p9LRC8zbcqpUqg0KbNbMLl88+WwTY4pJ7NJWbUuD2nVTNIr/v1QD4ZdMOMGuZxG+oFUi+M6i87JDx5sUL4nz74/7WSmp+n1qj+gCCwcqcAs3av28Q6IXQ9uBoDj4dDPtai2YBhgEZ1dmV0Zx4G3+1F4UQuI2p/D0ZUzLy9xHaX5EL6pUJ96jBAr00J7+UasVE+TGO6dNY4ceSGcUro/WkygBG74De54xFBas8o7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bIqK6IeV/zUn9B4pZAc7rzt//glG6s/SH0S51IXjuMo=;
 b=MS7Xnz6ML22ecxxp7B7VaAWmA/qDZmPqR5Q0mP0pTS9Xtc54JdfQzgPz4pr/qxpk5YMr76f5gs6dNfygdNXn6xMrNBTIL2MrY4+QI290kX2NWQO5xENmCHWoqiCSPz0DXxbdgtsmQn5TWqsK33tAel+6QD/YAynKei+kh3MfHWY=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by DM4PR11MB5423.namprd11.prod.outlook.com (2603:10b6:5:39b::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6477.37; Wed, 14 Jun
 2023 20:32:46 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%6]) with mapi id 15.20.6455.030; Wed, 14 Jun 2023
 20:32:46 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH v2] wifi: wilc1000: add SPI commands retry mechanism
Thread-Topic: [PATCH v2] wifi: wilc1000: add SPI commands retry mechanism
Thread-Index: AQHZnv9gFN9kADG4j0qS511M1NMyaA==
Date:   Wed, 14 Jun 2023 20:32:46 +0000
Message-ID: <20230614203215.9652-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|DM4PR11MB5423:EE_
x-ms-office365-filtering-correlation-id: e06581a2-a9fb-4205-3aa4-08db6d168372
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jz1ddBEXd/L1/Un/2NBsFZdj9INhqRDjHbfcdYliWZCXsMWC2OmMtQ/XZqxUzQCeDGrCPqbHgFecVN0pzAhc8ko8vFmBethbI//8O9jXcrMDCYCiZVXpAhHKt4OS26TLQB4TJUPosqj1uhru22/JmP+WOVSRsGxx3veDhs83Teh8WCO67n+5Fyqr1Qn6J5M/7neYNaBSBiqkN/A0hqWVSszKr1ZWyxuuWsTP9fyir4Qssosr/h8Glh7vpS+XGl+a+SAUnEHTKXy2khVFenUTTmT0yU7sstWX07plm3onJzMJDXeLjGYWcYWwkFK6w1O4jF+nOiFdiNYpJuMTTGYqF9JpU+VDZ7gOaJABFVjhXwUQiny55s/Yt/cu8fsGTVkxuNO6hPdcOpPGVfT8ZrNjr8P6qpKvkWO9xOwhFEgP+0GYRBKjIndA2ZI0ERHW52reqmNt8Qx/TqVoHxz1o5OJDIZvm4IwArM/ocG+LCWVxF5fW9i2tirEZMax2+7/2SFot8InAemVhs03Ot2bCKXSI7pRX5MIq3+YKzJGlLVD8POwLs54Cix3W+PB+fzZ0iWTbU1JsF93QTCMj7jFdA/BstBvedF9tpDOiyhfGYx2uy+yjMSmeD6bHWnp8LjJlK3U
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(136003)(376002)(451199021)(122000001)(86362001)(38070700005)(38100700002)(5660300002)(8676002)(316002)(41300700001)(8936002)(66446008)(66476007)(66556008)(64756008)(66946007)(6916009)(91956017)(76116006)(4326008)(83380400001)(54906003)(2616005)(186003)(478600001)(1076003)(6506007)(26005)(36756003)(107886003)(6512007)(2906002)(6486002)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Ywf2BGGUq9AZGBlQ9xspGfTLY+YDUrnMksZX0YhfuREMCPlsMe3EBiuus6?=
 =?iso-8859-1?Q?/OggsTvtgMHDu/8qwPANTdOxVVb2T+sDTq7q9XR4LbJT5rFNBcHE/n8Hbb?=
 =?iso-8859-1?Q?qIW3rjeQDcc4Kra2NqH3x6vzujvn4CYYkQcjnjY31ns4W/RU7uF/SLw3aQ?=
 =?iso-8859-1?Q?c5xAZrrXW34Luw7Qx/66TPQ+t5M1ebyr7HbQM5Mvysa2HQoTgTzVEB/SsL?=
 =?iso-8859-1?Q?j14nSLtpllcIXZ3Osp5xAmJt0/AUyjIDqPmGmhsXlwm2gdeqJhyQxS9IKd?=
 =?iso-8859-1?Q?x2opPwFr4W71Gxw60qSXSTnDu1NRKsH7Y2QYXjd6F4cfUsQWKZt7yOm5FB?=
 =?iso-8859-1?Q?8HFO6uoCfsUnGi6cqfyDGYfXsS8rmBAumrBgJWGdp2y3szVBTNSQGdvIUL?=
 =?iso-8859-1?Q?pdIdD9AMy+S853EE6nfPSu5UHXjCG4l2q2t+JI1OxJOfZahW8rYC4zhJHR?=
 =?iso-8859-1?Q?Bj2Ir5umX+tMXuO4kzChZvdd+zUnWjIGUNsyTRPVupV/O5YkjD/UxhAM+m?=
 =?iso-8859-1?Q?bWflBiD7d081jJbarE9pvqU1831PBOnYYZwUSkMllJB0omhDB74HOJVBLd?=
 =?iso-8859-1?Q?TTvEBt7oaW8dcwUlh8eWvY12TFTp24xd9U2wgAykS6RBrfDqu8dLkuFOfW?=
 =?iso-8859-1?Q?G78OLYrLBugt/1LxmMfNCP7yDNG52DriZTnRDFEW/KXNDTr906ereaVXjE?=
 =?iso-8859-1?Q?QBsAp+AvGDjUeO2YLRUkR/LSRrW0sz9rKllbR8LD2rySG7yJSHVBtv57y8?=
 =?iso-8859-1?Q?4ZWFw5UdWohHaHg81t8AFOqqxm8FZsutwjua4af1ak2XwKtiSzyC2en1sa?=
 =?iso-8859-1?Q?b8IiolLs3lJkgKTxOBabu/RYTkClwNGuc80M9FJaJzzIAHsHePab+lLuRI?=
 =?iso-8859-1?Q?dFxjZ4PaWzCtaknEAZHMukLz3LIf3sDv3LGY5y+1LJ7pev4mu7FgYuL4Tl?=
 =?iso-8859-1?Q?oKwLbga0eg0c3QRVjVCyHSUHu0woPUpwIA0j8TOPaIpJworAZIWgG9T7qX?=
 =?iso-8859-1?Q?zCy1SRp60hU7gKacWf/xq0bax1W+kow17sRSPCvvY36ne/CbBf1C4OYkrW?=
 =?iso-8859-1?Q?CMmxy5kzdPjEfu6pvABGHwZvZTLiIxeags59LRbyb1Jq7D0ftAYjK25nNu?=
 =?iso-8859-1?Q?WBoRpbnSjOMJ8KdyUYd6QuJ9K5WHbJ3jldwymZFAzTxQ0vOkHEaxsCfH/k?=
 =?iso-8859-1?Q?EdHWTpkO5c1xzUxp0NSZuxCK8itrKVmp6bb8sLec3aTC45RYOYT1x4qPpY?=
 =?iso-8859-1?Q?pJTtbUmKPRSW8Did3Z2dlwWvtH95mFAD6J6hkpbI3ClINYfh60b0lGGXWC?=
 =?iso-8859-1?Q?NlpGLURJvsI0St7k4vV4mVXrDijc/v35pzhXWt5r81FYfFtUuo6ZKEs1Gs?=
 =?iso-8859-1?Q?ZOT/28EM51kefil0DZL11Km0rqhaXoth8QKU66A6lxDJY2lPzxtvLtOgJK?=
 =?iso-8859-1?Q?y5t9y/kX3xE24YRGcCe+DO+APJwJDtC72xB2b3HEPg8kzpx+DaI25hcw1b?=
 =?iso-8859-1?Q?c81y4Juves+0iCzzLR1vxnczN/PL+t1wAwZoKaFfInUlCqunkoLzi3p5u4?=
 =?iso-8859-1?Q?LMpbD3rDCOkQNMkLmwIB8z2ORcq1SUywIKgAp0RFwh6f53me1qaOeWKGXv?=
 =?iso-8859-1?Q?34LaAr7tju882Hh41Z62qTJLUJ4sz8IEKbVs/W4RkkUqNtWxb7VGl9mA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06581a2-a9fb-4205-3aa4-08db6d168372
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jun 2023 20:32:46.5014
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vRjiNTAqpVwGogo6JA5GSryiad8I2WN/Qu07E0tpOn6q1r9vOAzaLIV0EwO2GA1I0tVR/w3xefsdT7/4Tp6BALd0tap5QUe/Nfr3RIZBPSo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5423
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Amisha Patel <amisha.patel@microchip.com>

In some situations like, chip wake-up with powersave enabled, SPI
commands are failing temporarily. Reissuing commands after reset helps
to overcome the failure. So, add the retry limit and reset command
sequence API for read/write SPI commands.

Signed-off-by: Amisha Patel <amisha.patel@microchip.com>
---

v1 -> v2: Removed some false indentations and unnecessary if condition
check of result variable

---
 drivers/net/wireless/microchip/wilc1000/spi.c | 92 ++++++++++++++++---
 1 file changed, 81 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index b0fc5e68feec..bdde444394dc 100644
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
@@ -830,23 +831,45 @@ static int wilc_spi_special_cmd(struct wilc *wilc, u8=
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
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
-	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+	if (addr <=3D WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_READ;
 		clockless =3D 1;
 	}
=20
+retry:
 	result =3D wilc_spi_single_read(wilc, cmd, addr, data, clockless);
 	if (result) {
 		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
-		return result;
+
+		/* retry is not applicable for clockless registers */
+		if (clockless || !retry_limit)
+			return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
+		retry_limit--;
+		goto retry;
 	}
=20
 	le32_to_cpus(data);
@@ -858,14 +881,22 @@ static int wilc_spi_read(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
 	if (size <=3D 4)
 		return -EINVAL;
=20
+retry:
 	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_READ, addr, buf, size);
 	if (result) {
 		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
-		return result;
+
+		if (!retry_limit)
+			return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
+		retry_limit--;
+		goto retry;
 	}
=20
 	return 0;
@@ -875,11 +906,19 @@ static int spi_internal_write(struct wilc *wilc, u32 =
adr, u32 dat)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
+retry:
 	result =3D wilc_spi_write_cmd(wilc, CMD_INTERNAL_WRITE, adr, dat, 0);
 	if (result) {
 		dev_err(&spi->dev, "Failed internal write cmd...\n");
-		return result;
+
+		if (!retry_limit)
+			return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, adr);
+		retry_limit--;
+		goto retry;
 	}
=20
 	return 0;
@@ -890,12 +929,20 @@ static int spi_internal_read(struct wilc *wilc, u32 a=
dr, u32 *data)
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	int result;
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
+retry:
 	result =3D wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr, data, 0);
 	if (result) {
 		if (!spi_priv->probing_crc)
 			dev_err(&spi->dev, "Failed internal read cmd...\n");
-		return result;
+
+		if (!retry_limit)
+			return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, adr);
+		retry_limit--;
+		goto retry;
 	}
=20
 	le32_to_cpus(data);
@@ -915,19 +962,26 @@ static int wilc_spi_write_reg(struct wilc *wilc, u32 =
addr, u32 data)
 	int result;
 	u8 cmd =3D CMD_SINGLE_WRITE;
 	u8 clockless =3D 0;
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
-	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+	if (addr <=3D WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
 		/* Clockless register */
 		cmd =3D CMD_INTERNAL_WRITE;
 		clockless =3D 1;
 	}
=20
+retry:
 	result =3D wilc_spi_write_cmd(wilc, cmd, addr, data, clockless);
 	if (result) {
 		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
-		return result;
-	}
=20
+		if (clockless || !retry_limit)
+			return result;
+
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
+		retry_limit--;
+		goto retry;
+	}
 	return 0;
 }
=20
@@ -981,6 +1035,7 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
 	int result;
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
=20
 	/*
 	 * has to be greated than 4
@@ -988,11 +1043,12 @@ static int wilc_spi_write(struct wilc *wilc, u32 add=
r, u8 *buf, u32 size)
 	if (size <=3D 4)
 		return -EINVAL;
=20
+retry:
 	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size);
 	if (result) {
 		dev_err(&spi->dev,
 			"Failed cmd, write block (%08x)...\n", addr);
-		return result;
+		goto fail;
 	}
=20
 	/*
@@ -1001,13 +1057,27 @@ static int wilc_spi_write(struct wilc *wilc, u32 ad=
dr, u8 *buf, u32 size)
 	result =3D spi_data_write(wilc, buf, size);
 	if (result) {
 		dev_err(&spi->dev, "Failed block data write...\n");
-		return result;
+		goto fail;
 	}
=20
 	/*
 	 * Data response
 	 */
-	return spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
+	result =3D spi_data_rsp(wilc, CMD_DMA_EXT_WRITE);
+	if (result) {
+		dev_err(&spi->dev, "Failed block data rsp...\n");
+		goto fail;
+	}
+
+	return 0;
+
+fail:
+	if (retry_limit) {
+		wilc_spi_reset_cmd_sequence(wilc, retry_limit, addr);
+		retry_limit--;
+		goto retry;
+	}
+	return result;
 }
=20
 /********************************************
--=20
2.25.1
