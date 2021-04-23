Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 562F43699AE
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:30:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243776AbhDWSad (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:33 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243751AbhDWSab (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202594; x=1650738594;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/1JtNMNbW5E5KyVpvYCEUP3YYug7y3xr9VA6bxZZVqI=;
  b=mWoNrh/3HAOu9mMKbWt0dRtKIMxVS5l8+MlmT1WeHXNQ6ZHPC3fCKAVP
   X+L5YuPdBI9GWFKZbWSpokobCF2nBW030NUiPPUvxdS1rZgpjmPSF2LaV
   RN+W8YajxF2+Ce2De67ntLFfsrFCAMEg2fvMU6uJul18++i95CU9GWAwW
   Mx13g7XoyeHi4UVN5Hx9NRb8B3E7kf2AYNBD2auyr4XIa222eJIfFxzW5
   uFqb+KqLIWQUehhw50joiARqvdfGQnbfRq/WUidErAbBgW3yP9XDZPNJK
   1tEj2Zh/sqnxJ1Rv9TiwVB38LK13vgQy6i6CWFmp3+NT1MVZHeNL8PqPr
   Q==;
IronPort-SDR: AZltm8P6rtoAi6PKUVp+Sf6dlSkgqY9Rv2MeK8iKV9vEOL6x2HetFm3PHLB+n9b5rtV4ty4PbS
 wQQ00fQLirGEMRHxEqB4ws7NmXS/J1jIzcfs5y+hlNZI+v829LjBgtIZMI7jzYeevCq/B6CJFM
 XnrOv1QsNpCfmF1C+MyTzkoY0MPjqdca1cz5Sq+zEGWQxmaJ9pQb1jPNS8ZHBtGCSGIaW8Z1Kt
 Oov+BvXYhvIheFrxbFHeWh6B27gSS7mcRCUINO6AC4d+z+bUNCSZnuLiRPP3covSkQydyaXSWr
 DdY=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174651"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:54 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:50 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vk8wQqsHS9YCqiBH4g1rutNDoCOMG9T8XQO6TSiAJlm0xzxCpVTQVHHV8kzU0zik2FYnfNrizrHBy8OuNqWvrm29nYXP9JJEsGCC8lfegwraj8MWoo70u+NW09uIMY7SRq7TYh2FiDzFvZQE7rYOh7zNgzpJx3Ku++BX7K4GLZmqJBzxCZhtmYKtauWKrzhncuHmgna9Ol3uavWeKq49rtiwwHBvofhpAHii7R+HaKAblSZwlJXm3kFFXTe7+aF+AfA+/88+yx39VGxpBo3m61xD2b57LPMCMTDXIw/f6bsc8bEWFkc7bFcku1Iu0MhnugfNLO9XmGkLCeIBRpEhwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl8N5k5qY1Aphqo1kL9oRKHTwDfKjsi3m7Y8wOut6eM=;
 b=lVIn1z7n09c1KsN7DoIRulPjA1n+3JQ+OWgdP0VMJSR0PWovIKDcp9quoabLRhHdRYqmeC6CFeeymZtQb8f7ffFe7sNSFAV8baDpET93bZlDtp9XhngahcXxu52RmaUzUzNU0C5sit5wuuPDXJ0MQbdJFP649HVfgFo4oGwacSKjeWOHElS+OhZxLrMXXFnWnIt2X6Mg5HC62AXN+fNIOPws9FiEzRHi6WnxEZdO4ndEiR6dJEZY+T4zql9wdxYZ8VBceGcvRUQIvGlxEd6iuzlzW6AhXyHSqoGj846enG7yjfIJ/ewG/Qg/wl2icH6g43rGsoRs1n2FkK2g+qWNMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xl8N5k5qY1Aphqo1kL9oRKHTwDfKjsi3m7Y8wOut6eM=;
 b=fTSzm/XOsRWL8/oCLuBXDx22YIS22C6S9L5ktVIbAxftL6Pg/w+uGDVbIRz8b4QhWYKDNHJqWE1BXndkfG2Brd1O0ZQm49swpb69znbONtO1gMocHSzA6JyO5Fs+rGlb/m20lLkkjaLkNYHASjQ74Bot9nSQuhY74BcV2etpD20=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3493.namprd11.prod.outlook.com (2603:10b6:a03:81::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 23 Apr
 2021 18:29:48 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:48 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 09/12] wilc1000: avoid 'isinit' static by moving inside priv
 data
Thread-Topic: [PATCH 09/12] wilc1000: avoid 'isinit' static by moving inside
 priv data
Thread-Index: AQHXOG6kVjxRQlZHKE2uwKahITeHMw==
Date:   Fri, 23 Apr 2021 18:29:48 +0000
Message-ID: <20210423182925.5865-10-ajay.kathat@microchip.com>
References: <20210423182925.5865-1-ajay.kathat@microchip.com>
In-Reply-To: <20210423182925.5865-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [106.51.107.119]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d0536074-855e-4683-291d-08d90685c6f8
x-ms-traffictypediagnostic: BYAPR11MB3493:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3493D47752FB852C3F8DA2A6E3459@BYAPR11MB3493.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Izf6QPDeRxk04CCZivn3rproK6SCUOb3+JIQeOYdvUb4gDL+9GRCQ8V303w2DmPrDb8a2HRz5vzJacDDoV8HgyfGVd0mo/FdDnzQl0rzxI010BmwCF3qFcFjB5rkOvuZ5DC3Ag+epdNoUB8kEXDftISekkTGAANs24odQrXOzNsDkeF1YHM2rBWf7QXNZhAgnYVSfOtIadi9pDx5BTr6QXWZdg+YTPLSHCgxFnQd2kI2roOQw3Gfaj/0o74uCKysB9iQGNcVMCye/WX0+hZ8rXIzTAFkjr+pb0HzyuL5ix6Bo2tuXWyKOjvFFIaaF3O2kE/0m0Q6ykHwf/6MLx53K7wF/rgKx3ifUGHGPmHGtC010qktQDZKtik80aHgQOBrnv2pTRUwauMHLClNhaEAZvuqFvtsXuDhb5vTTqcV3IEmBEnzFrqUnHDnfy5hwux7aVuGYYks4FUDCVQ0DPOjVjBp8rTKnlDsA73cm4Ggn/FvcfmMgF/zKVUC7AihmNdw6Mlu6epD88ydhAAF9HmaucL33a2VqEL6SZsIo48ux1/l+F4SmeAhMkJBgZO2jHKmkXStewQs0p5G+QNyqQpkXXEFucONdysKHkD52KMigyw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39860400002)(136003)(366004)(346002)(376002)(86362001)(83380400001)(8936002)(66946007)(6486002)(122000001)(66476007)(6512007)(8676002)(2906002)(54906003)(5660300002)(4326008)(38100700002)(6916009)(107886003)(2616005)(71200400001)(186003)(478600001)(316002)(36756003)(76116006)(64756008)(1076003)(66446008)(26005)(6506007)(91956017)(55236004)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?6ikdcm+XwZcQC+rSqlWG1w4v99RJhVVkWGgQSuF7dygGWeuxece5PzbYwR?=
 =?iso-8859-1?Q?+HXrtWsDH4T1BwzhgDTvUU038wc//vtyMOlbkUaSb5FQKZxtNaWykEYjwe?=
 =?iso-8859-1?Q?Mtot6bSp9hhZ118mMPizPMuJKOr2tPhlx6b1GFINsIFdV1gk757/1gucBc?=
 =?iso-8859-1?Q?sdBthvSCrjE9Kqxqu0FCoIGOt1LGiTpQfwgeoymQ/VrP3tDS33i6ET9514?=
 =?iso-8859-1?Q?JeealzcCHY0DcUKHf4CYGOBWUmWaFtAjMb2unjPVEJeJ5BdV+CcfXrO5Cw?=
 =?iso-8859-1?Q?2dbxQJZFSY34z/vmLAxkZx73vg1u+KoFVK9yjQjTfvRUzOMTII7JQcanEl?=
 =?iso-8859-1?Q?r8NZ2we7n6W6ngc62WEP+Qd222OK56lLftoFmq6XixrjxYAaHF7GI8KNTI?=
 =?iso-8859-1?Q?y2uLWv1Dsb8tsw5AH46n9k8cuow4EmKNsEiKSg6FOGbe9c1pnIYCIMAqMC?=
 =?iso-8859-1?Q?oyfmBe3aNGT7cBT3gHNcY1xccyfGTOQvRIkR8EZ9xGnrMTKlk9Swh8u4J2?=
 =?iso-8859-1?Q?QBrU7rLLCb4wzPwuoTlfs6eEnYLsFchBEllnWeKsu7Rscn79/dlpMK2Ymp?=
 =?iso-8859-1?Q?L8dR+oebjoFX6Guvwa+GGDZ1SmZ6twcFhWSGBX+EwIbpakZSiZ3Y86fMsF?=
 =?iso-8859-1?Q?WBFwp1uHMrWrbvqtEfCd4cIwOj2gBPWajzGJuRpYPtEtxDzVF8wNGthNiJ?=
 =?iso-8859-1?Q?p9I+tsofE60UvrpX9BRlpaPSGrH5wlbO+HQbROhn55gQ/pCWeCv74QHulh?=
 =?iso-8859-1?Q?Kg9GU+wvJQaKG5NMq1fdg73rXxIhuWsrL92aKVwAcdlRS5tqpqRa4okut+?=
 =?iso-8859-1?Q?LgqXh4aH1IL4xYrXnJRpGFmBAcghsXnxAggkcecl+zyjKo0lIDFOtkApoN?=
 =?iso-8859-1?Q?gQ1U5sDFnqfsye7/XiaexubCiGQGeFRBV+XQGu5R7DSpjBFCOeavxpZZl9?=
 =?iso-8859-1?Q?nnsTS+EzcjIZ5IDYfl011AKHN4mkfATY9pFaGT/Gbz8Q9yZKNkU66QnOXU?=
 =?iso-8859-1?Q?637Z4nu37jGLaOdZCW0WkdTPzy4zMumGRTRERAO4mVfSDkDH96uJVLFtzn?=
 =?iso-8859-1?Q?CH+pmv6qHEqjto0L+zCGmMOZ37yUYAiYHDcOEkjXLt8ucpcO2NmtFVhNE7?=
 =?iso-8859-1?Q?5eaH+Ail8Nv5xN0/MdGKMlYnagSdeM35hZReJ6zuxi8s/i0V04EpbiJNjL?=
 =?iso-8859-1?Q?yLn61VSTUrTd2GLmAXeHLYgBZoVVWABO7s98+2OnFo3VgrQWTg0309x0ud?=
 =?iso-8859-1?Q?HgKm1W1mIkUcYOnyGs1LE+bjz7fu+3aWP4u/NghK2rVxPYl9JCRnf1mrx/?=
 =?iso-8859-1?Q?1+QDfc2NZR5WNIt3lynv6QVhkQUHBERsxdRLki+JvUnP5ZhSb1WdotkayL?=
 =?iso-8859-1?Q?IwZL++OcXoJBeOOYKucoKE4PuA8AnePA=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0536074-855e-4683-291d-08d90685c6f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:48.6622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gY5IwVd7bDvrymLNAK/EaLby2P04+V1upKONWx/Kg5DG94VfCnyk7KZxO86PllapECUvcSKmPVlOwsoHD0enn9e9gQqRnvYwI3h90LYlb4I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3493
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Instead of using static variable(isinit) move to priv struct.
Added hif_is_init function to set is_init variable.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 13 +++++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c | 22 +++++++++++++------
 .../net/wireless/microchip/wilc1000/wlan.c    |  2 +-
 .../net/wireless/microchip/wilc1000/wlan.h    |  1 +
 4 files changed, 30 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index db490f449c27..9c9f46a171b3 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -26,6 +26,7 @@ static const struct sdio_device_id wilc_sdio_ids[] =3D {
 struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
+	bool is_init;
 	int has_thrpt_enh3;
 };
=20
@@ -188,6 +189,13 @@ static int wilc_sdio_reset(struct wilc *wilc)
 	return 0;
 }
=20
+static bool wilc_sdio_is_init(struct wilc *wilc)
+{
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+
+	return sdio_priv->is_init;
+}
+
 static int wilc_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func =3D dev_to_sdio_func(dev);
@@ -576,6 +584,9 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
=20
 static int wilc_sdio_deinit(struct wilc *wilc)
 {
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+
+	sdio_priv->is_init =3D false;
 	return 0;
 }
=20
@@ -695,6 +706,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 			 sdio_priv->has_thrpt_enh3);
 	}
=20
+	sdio_priv->is_init =3D true;
 	return 0;
 }
=20
@@ -976,6 +988,7 @@ static const struct wilc_hif_func wilc_hif_sdio =3D {
 	.enable_interrupt =3D wilc_sdio_enable_interrupt,
 	.disable_interrupt =3D wilc_sdio_disable_interrupt,
 	.hif_reset =3D wilc_sdio_reset,
+	.hif_is_init =3D wilc_sdio_is_init,
 };
=20
 static int wilc_sdio_resume(struct device *dev)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 4f5464170426..8e88986db9a4 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -42,6 +42,7 @@ struct wilc_spi {
 	bool probing_crc;	/* true if we're probing chip's CRC config */
 	bool crc7_enabled;	/* true if crc7 is currently enabled */
 	bool crc16_enabled;	/* true if crc16 is currently enabled */
+	bool is_init;
 };
=20
 static const struct wilc_hif_func wilc_hif_spi;
@@ -971,11 +972,19 @@ static int wilc_spi_reset(struct wilc *wilc)
 	return result;
 }
=20
+static bool wilc_spi_is_init(struct wilc *wilc)
+{
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+
+	return spi_priv->is_init;
+}
+
 static int wilc_spi_deinit(struct wilc *wilc)
 {
-	/*
-	 * TODO:
-	 */
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+
+	spi_priv->is_init =3D false;
+
 	return 0;
 }
=20
@@ -985,10 +994,9 @@ static int wilc_spi_init(struct wilc *wilc, bool resum=
e)
 	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	u32 reg;
 	u32 chipid;
-	static int isinit;
 	int ret, i;
=20
-	if (isinit) {
+	if (spi_priv->is_init) {
 		ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
 		if (ret)
 			dev_err(&spi->dev, "Fail cmd read chip id...\n");
@@ -1059,8 +1067,7 @@ static int wilc_spi_init(struct wilc *wilc, bool resu=
me)
 		return ret;
 	}
=20
-	isinit =3D 1;
-
+	spi_priv->is_init =3D true;
 	return 0;
 }
=20
@@ -1189,4 +1196,5 @@ static const struct wilc_hif_func wilc_hif_spi =3D {
 	.hif_block_rx_ext =3D wilc_spi_read,
 	.hif_sync_ext =3D wilc_spi_sync_ext,
 	.hif_reset =3D wilc_spi_reset,
+	.hif_is_init =3D wilc_spi_is_init,
 };
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 24e016a0dfa8..6ae5d82c6f99 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1255,7 +1255,7 @@ void wilc_wlan_cleanup(struct net_device *dev)
 	wilc->rx_buffer =3D NULL;
 	kfree(wilc->tx_buffer);
 	wilc->tx_buffer =3D NULL;
-	wilc->hif_func->hif_deinit(NULL);
+	wilc->hif_func->hif_deinit(wilc);
 }
=20
 static int wilc_wlan_cfg_commit(struct wilc_vif *vif, int type,
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 150648b2c872..8b7c3d1034ec 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -374,6 +374,7 @@ struct wilc_hif_func {
 	int (*enable_interrupt)(struct wilc *nic);
 	void (*disable_interrupt)(struct wilc *nic);
 	int (*hif_reset)(struct wilc *wilc);
+	bool (*hif_is_init)(struct wilc *wilc);
 };
=20
 #define WILC_MAX_CFG_FRAME_SIZE		1468
--=20
2.24.0
