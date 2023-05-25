Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E20F711385
	for <lists+linux-wireless@lfdr.de>; Thu, 25 May 2023 20:18:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjEYSSE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 25 May 2023 14:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241062AbjEYSRy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 25 May 2023 14:17:54 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693991A4
        for <linux-wireless@vger.kernel.org>; Thu, 25 May 2023 11:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1685038671; x=1716574671;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=Ft7rusawWuEgofAIMH91QubKx03Vdk8CjeKFpE9UC28=;
  b=Mu6PzlgsCYaZKe9KoCs5dO10zM66gRoGFKYfyglW8cODbRhNmSdKeIAk
   vviSuRocqp2aon5uDwi2O4wf9YRYs7fHJwKMX8gsbbSx+pXE4gTuk2SPn
   8yO3TUouSqXiPXPT9xjV+6suyK1xtm/5fF5fshfQktsSAlG7K0sjwrYvV
   m60fwiDdhexLD75OTZFnOw5/LfJioDyCX4or0eVfXZdAGRVoa89eQ4C+9
   JUCUeHj4ZREhLyFNinOZoqju2YQoHGoa7tsQ2DoVdzh+17H69UmzFuVpX
   8sCJB9VkHIdpT0axfL31TcaPQ2ZVNRBI3WFxa98viemnZX/11a+mV9h6r
   Q==;
X-IronPort-AV: E=Sophos;i="6.00,191,1681196400"; 
   d="scan'208";a="227026452"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 May 2023 11:17:51 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 25 May 2023 11:17:50 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Thu, 25 May 2023 11:17:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eMd88KVNoD57ED8RbRuJds4zkGRlg/FL7CDkPfmf/r88kUa7IpLNRehPBp6zLnIKgVg3kvZM0LacX/hag7wP52JW/taB3nXEf4dxvMNf+aBdvwTp97B+2LnCK2fUxVYjgWLDLJXWc7Hf3nTH0WpCzfn9ydaQW4ynne41Kwmvz+daJOE3gIJuCD4nOLpTmpc1dkcNcl+KxKLuj8Ims/0epdajKmuhXABb+Fn12cMvb5LRSY/pKxtYZXFN/SM9W1Wf7qMfGuTY6fwTSLac+Iu6vZt7F320sI0RcBY+XG+r0p9tbbyszLLLlIbNeCV+H4yiemf06RGwrOnWVCCixXIZnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j9PFY6gNu0vXDXoeVUzWPLL2fgk5CIywP+mF0qG2VOE=;
 b=NLjrJTkikdixU2TKOBSShla5Zio2QUos48roNYBid8uPl9/qx+dU5XWYrWzz4AjMHivYn2/4EQV/K5NzCYtIYK8zN0VsV6Loum1/GPQ8xBzRuV/gs1iedhHYcYZ89c9T9ahRhwcMll/K5OoVV8OgGFY5E4seGnt6QNZViaPpIuhWlytuuvrbgK4J8gLXREYlvWv9fn3yEs7nB5eNdqAvRcKVq7cMs1KHoz70SG9Krs6xmfQ4priAanaSM2+Yi4wviKAbpLh426Z5wY6ADSZgUBcX7WwOJgiCYvG+c/KqubqhUzj8aIfG+UZfJjKflVVRCqSGyl7CRLl+Rj/MP/Tgjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j9PFY6gNu0vXDXoeVUzWPLL2fgk5CIywP+mF0qG2VOE=;
 b=RITjY+6KtO2Muw5hQEhipHWE/rRKIToO5rPPnraxq3UMEzI27P+lXxUMzzv6OJXMooMMAPFfcJlMVxdIFzkwJqC3iCP8ys037gMAPbllCWFEiGdXVRapH9TbTezBKVPfgeb2xMuYGB7wdVSYW2J91JJdd1HMpX/hWSkwQjddbNM=
Received: from CY8PR11MB7393.namprd11.prod.outlook.com (2603:10b6:930:84::18)
 by DM4PR11MB5341.namprd11.prod.outlook.com (2603:10b6:5:390::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.15; Thu, 25 May
 2023 18:17:49 +0000
Received: from CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711]) by CY8PR11MB7393.namprd11.prod.outlook.com
 ([fe80::120a:e19e:e1d9:4711%7]) with mapi id 15.20.6433.015; Thu, 25 May 2023
 18:17:49 +0000
From:   <Amisha.Patel@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Ajay.Kathat@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Amisha.Patel@microchip.com>
Subject: [PATCH] wifi: wilc1000: add SPI commands retry mechanism
Thread-Topic: [PATCH] wifi: wilc1000: add SPI commands retry mechanism
Thread-Index: AQHZjzU2TDHO/Hut7kWwqno7z6RMDw==
Date:   Thu, 25 May 2023 18:17:48 +0000
Message-ID: <20230525181739.30063-1-amisha.patel@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR11MB7393:EE_|DM4PR11MB5341:EE_
x-ms-office365-filtering-correlation-id: 5a541268-8614-464e-bd9b-08db5d4c58ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5Zuz+bbBequrefEhUDJIb5wCm3IUpsTrYHKm36WAjxkmciCr/NP4O/8t2dmC1ZH8B6EWHhreirtpsOAwDL5xuF7orYVqGzvV5xZSt+lqj5OnZLiMkrF0k7ltFUSDrGbOD7bOOeKGbD8ghBTfzFS0wGIIeLQmFGbeHEXvI0M3+A/yRhap8nnH/QCE7v/JsY6koEfOY7modcN/J3YiJCznK5Pw/eZcG/dX/9k6eTEgDwO3DFz4uh8f+TvFRwFje98u69dk9teQCc1daVLnGbSIWaR+GF9vZ6Yv/5BgtrEGGPgydlHHyTMw8bUcHBKdpwDejHgQAO689pszzzmalUVBauLvMCTTV4jWyFBtB8H0nYGfie58sWuEhfEi4eI3E0dlBc31QIN41sYVCIwRukJcVryFI62oxtvHK9EKYMWThjT9f0eAz7o/dUyCnpwSCS0m0qSe8SxsmfQwlVnmea9vg+dBrDwYCvWTmbQjXLbf2dJKUQprVBQlf4kUtr2iRGjX4tOYS9IsNgaex+FA9VayCDktd+fv12qkj4d8ipCvcb6YyHNVtB2LTcsZxQOtlIUQH7CY0aKYBpnkQHoF+heRxYuWwFaCYj5lTtnzxnnMH2dW+UdcYMX9QnhhxLqv5R4A
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR11MB7393.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(366004)(346002)(376002)(396003)(451199021)(2906002)(2616005)(36756003)(186003)(107886003)(8936002)(8676002)(5660300002)(26005)(1076003)(6506007)(6512007)(478600001)(91956017)(76116006)(66946007)(66556008)(66476007)(6916009)(4326008)(64756008)(86362001)(66446008)(54906003)(38100700002)(38070700005)(122000001)(6486002)(83380400001)(316002)(41300700001)(71200400001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?WyS9xd93F/x7QqAGL8oUQmqlQc6ghRJYL/83NXe35X6RRgSU7Mp25Y2YtS?=
 =?iso-8859-1?Q?6p7HOBtU9tqbv2PzpptKhSosHao4gD9kf8OVgGMWnwBwPGftOYHiOR4w+K?=
 =?iso-8859-1?Q?cvUCiLn2dgEKb0bH9qKKckrHLW4SSo81gpmwb8dBFvrD458+JCRpz9bC3g?=
 =?iso-8859-1?Q?O7eiaXcG8pdOHMdl/zsUTw2+k20I1F3ge/S3LG0ViHgUyST/S4ogoMjlS5?=
 =?iso-8859-1?Q?xWHcE0MHWWcJG/4fMivMaQcBKJ9PoW94w3HeXCIBbmc8EXtmG1m1EA1O8p?=
 =?iso-8859-1?Q?bhhe1FDd5fKh8dWFE5ytS6aCUyTP1yy12DwLoJjsglBhkwsyomcc4+RP1k?=
 =?iso-8859-1?Q?FRTumcHJP/zh9RV5BOVn7283IyxdNu8Qc3EDmxZVPAuwPteI+GlyF4aIfa?=
 =?iso-8859-1?Q?DP5CJxe4vD0WgSIVZW10a9uor910+vBmA4vWc6xd+kUG3Hr9ctx52HpEp+?=
 =?iso-8859-1?Q?uTJfu6YmKFuVw0Ss+8RgJzbgD/znFK1HsHzla/xmtWm8cPkIpL7O6d82g+?=
 =?iso-8859-1?Q?CLl7KeI1Gi/GoYaTDvV2QnRbkYs3jlSz/WsiH+UFwDfP4Bw0iqHl9kqM9a?=
 =?iso-8859-1?Q?s7myeKGn8bLIS3sIkmKWPiu1kJ+wNj2HFOhiGwWJ26Cou633DfHiROXsks?=
 =?iso-8859-1?Q?5Ox+527OUp5rEii/Fb3lcbElKkDb44E4WZgN392Ia0s6pwdaoSUw+oFXo3?=
 =?iso-8859-1?Q?9QZeLaE4SO94IR4/fMj3uKu9Ea5cIK0vJum6rtlZxP6iRb6BgjW5yWdxiX?=
 =?iso-8859-1?Q?CIXDziGVeuGSWYtRjn8H6SW9wznjzC+8MQfYrKIbuqiKHL+1vwpkhK4tAv?=
 =?iso-8859-1?Q?onmhViSLov6M6Xo1UQ/VlNE0Ew/WfuE0zlSIkWrBNvcpzOCdVGsn8wNs1r?=
 =?iso-8859-1?Q?cipQGjclsjIQYzXX8kOtmjg45i3R/beD1Q+Y6UROZq1Y73mXljrkLK4EeB?=
 =?iso-8859-1?Q?O4vLhyKE5iTsAQbC56MbYDh8XrD9wp7Es1NFYrJ40S1/jRsr83HWdnY5cB?=
 =?iso-8859-1?Q?0kBnejyrGxLyX21xLv3WjnXtSFkmgnQVRQ5Pfs7HVb443rxPblnBGVPe+f?=
 =?iso-8859-1?Q?Zz9IZrm72576yBKFQ3fuWYDhVxAwkvdhcwtfbAgHI9yc9f3q3mHzeA6458?=
 =?iso-8859-1?Q?z9sPl1OEhq9tutfm6HkyQJAwA54Kcp551plPU3tsyHhMFAxhZdeVrDsrHW?=
 =?iso-8859-1?Q?jyZB6HOL60j2aFdAE6XnL1O0LS7esH+BbEN18vQ8y66T8D8knJZF2inlhw?=
 =?iso-8859-1?Q?2gjqdc9BsqGwXQq0P1JpprePcARtMvPeE1jTyPeDVoMV1BP/q8NRG4MIpu?=
 =?iso-8859-1?Q?BD5b7CM+44aXXgkRESYZ4gwOTLe84IRBjXBh0rf29sryZniaPFKH8ON9lo?=
 =?iso-8859-1?Q?WJ9wV7y0JNbzq6TTnFIed4ZDbpqE4YTIm3dtJ8dQylXShdxgd/OlD14DHx?=
 =?iso-8859-1?Q?tLUX8D67hmqG3AiFmYGvvTXPvu6piNR22ExTxU5Awn/smrOc00/ZBctEVb?=
 =?iso-8859-1?Q?YFkgqdkR9tAOUoCdkSrGdesJLpeCh3VqtAAxN5FJLqscKkF/ZKMMBHd51L?=
 =?iso-8859-1?Q?S3o0m3JINiymYuErd988TgpzHv4Rc5GqIs3uKpcvzz1QJ5IBI5Sc9ItOtD?=
 =?iso-8859-1?Q?2tgwHUy7GRuNwKDjjdispMziF9RL2MAoiAkUC1pVX9Zx3dDeVrnW8c2g?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7393.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a541268-8614-464e-bd9b-08db5d4c58ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 May 2023 18:17:48.9330
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KsREusc5MIEIkGtzyXXnNz+Lw94B2Ttc7I6D46I3v6cT/obg/uuEantOFT2/+XcsMIAheMyU/yJwgpzXWFHpc3umLCgzUUIAsWT67px55Zk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5341
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
 drivers/net/wireless/microchip/wilc1000/spi.c | 96 ++++++++++++++++---
 1 file changed, 83 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index b0fc5e68feec..35856cdbfb08 100644
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
-
+=09
+retry:
 	result =3D wilc_spi_single_read(wilc, cmd, addr, data, clockless);
 	if (result) {
 		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
-		return result;
+	=09
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
+	=09
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
+	=09
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
+		=09
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
-
-	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+	u8 retry_limit =3D SPI_RETRY_MAX_LIMIT;
+=09
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
+	=09
+		if (clockless || !retry_limit)
+			return result;
=20
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
+	if (result && retry_limit) {
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
