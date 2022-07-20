Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6C4F57BB00
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Jul 2022 18:03:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbiGTQDS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Jul 2022 12:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbiGTQDO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Jul 2022 12:03:14 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E64854050
        for <linux-wireless@vger.kernel.org>; Wed, 20 Jul 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1658332990; x=1689868990;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=C+3jkmVl+oKEwK6VLNd1B0wSmmKIVjS9gW1drKfs5z0=;
  b=WxZHvNmCvAY7hM2GGUd99zBMuEDZlYTPF6hKZHSb5P1OFPpljfVTsKwy
   TCjEK0mugfs5d/kjB9n9UovVjobU6h1I0OxhGYfyQWxrFHeM7V6YXS3MO
   zt8LcpcDgJVKky7jLTNXCURnCRK2w4t0zAt1QcwWG6neCQf26oDsvbVnF
   nUirweSAC5ZQUTAZ6O/TV8nodCiza2pldURrp7+vixKznVHRoPkRTKfvP
   Zzo3BnKesFWfojMlGYF8AZlNHG0/afTHJvhOFpIVnfTyQSosRrXqbKVO3
   WGkRh9JuuZb5fuA05NNWmqe5rQL++NcUUex/aklU5A8yOvNnVB9iNY77v
   A==;
X-IronPort-AV: E=Sophos;i="5.92,286,1650956400"; 
   d="scan'208";a="168746667"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 20 Jul 2022 09:03:09 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 20 Jul 2022 09:03:09 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 20 Jul 2022 09:03:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a52jwPpWvKMfDUXj2jIRsO9wuDO4Q+SEBOoISyFRwf8VtGT+fUfhr9/IpfvHa4hH0qnJLUyDygnsku83HKScTZvAhdkrPnZDaBcHO/GIgrBEHp+tPHwUQfWxWkzEHjZteZdh1aatWaEhZvv6nmsMYYQNIjY00cOuTRr+RGBkINpLSos4l8vyKr5JcLPgPcjKNT91M84AHJbxZiBibs50h71yEFnHThZSGzK51nDVZIqNcL7/dFkIWV5sdZ8ovTJwx7YxrZkLwoFOZ63F4Epc4YfLdRpnCrbw5aX65L8yqndk5v1k4tW/4ButQdXL7kyMf2B0Zk+rgZCt2kY+XBzfdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9tFxon5SwZHzxOt6+HGNnOCN3Ums/89NvGND08UWU2w=;
 b=Q3Nk777oha6LflocJd1KBGq9XkpdVZnNccphaBzfMPaws7nEbBn6D3qCjW4jk/zyogBJwFE5q647PSNYkVnp41TeWwhKp+nik3RO6gIwjoqOfsfp0KzI6zlrsLUAYFBVm/E7lWcUZgzFTJBw3mtb23Q2POZRPv0XAtDfKTBbto/csoRlv1aJuwDNKpaHEF3ktxSf3yn0TgQz3SjW3FtgehoHd36QhDO1nmC8kgPYSA27QHGccyeFZrlUICveA4V8Re9e9NV3RLZCjZ8mfNlKxIBnx5kH79H+TPEHVbpUd91/VuXfPB5Ul1txONA6bqa4oCXx8nRht0OcQfYaIfBRwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9tFxon5SwZHzxOt6+HGNnOCN3Ums/89NvGND08UWU2w=;
 b=BzFeRtYdkN9FUZLtBjMcDh//RKYKzk+e0eoUWwi/ZX6vTZaYLTjUKgU/nazB5LWNGjNATbo3MbwQf00bHDNEjFiiWfs1aDtdGnIb56SxRKVb4f1VpKyiTSr6z+WgUf8gPU92tIM/SkJIKjEcMIMuOjAdOSVE1VDUUThh37nt4Nk=
Received: from PH0PR11MB5176.namprd11.prod.outlook.com (2603:10b6:510:3f::5)
 by MN2PR11MB4174.namprd11.prod.outlook.com (2603:10b6:208:154::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.12; Wed, 20 Jul
 2022 16:03:06 +0000
Received: from PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0]) by PH0PR11MB5176.namprd11.prod.outlook.com
 ([fe80::812f:fd29:44fe:6cb0%5]) with mapi id 15.20.5438.023; Wed, 20 Jul 2022
 16:03:06 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 7/8] wifi: wilc1000: add 'isinit' flag for SDIO bus similar to
 SPI
Thread-Topic: [PATCH 7/8] wifi: wilc1000: add 'isinit' flag for SDIO bus
 similar to SPI
Thread-Index: AQHYnFIyYI7AczOOjEW0BkCmtI5UJQ==
Date:   Wed, 20 Jul 2022 16:03:05 +0000
Message-ID: <20220720160302.231516-7-ajay.kathat@microchip.com>
References: <20220720160302.231516-1-ajay.kathat@microchip.com>
In-Reply-To: <20220720160302.231516-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.34.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 65c0c45c-ad79-44fe-60a1-08da6a6955b8
x-ms-traffictypediagnostic: MN2PR11MB4174:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CIGkeKBPYOus8Ae4G07fXCEQqcSbXlb0DGNfcVI5udeCeUtCUr6pwjbl6/7Nem/TvX3J/mdLMtsCzS64olawBCCEPRjsZyPfltpuVxzbcIvPAN40gBFKr1xzS34l4iojhdzPZgfdtLGz3XWEU1S7UBwaTs3fIbYKJrT7q+DbDvnzJMpkMnTYrR2o3o3D6Md7ZwSLFhBlFQ7hGQOwNQUOQOrv+bIkOEUy+iVKhc6/9+BCwHnWTtiVg5wopJ1B2jlQg8eaJDM+ipcrAwokytGf4GnlzXBQWpIG/okKqx8AKpNCJkMasIHh6ZGAKy8CyudFCVzcQbiJ8t/vUMCwuroPGygysz4SNVZNWCSPGwbwg8dKCfs2IK0dqAEqs7o6+/0HP1y4m2Yp98ESxAKFO7BTQWfPreRHOdPyQZ0rSXWpR/uBghw3SIR5AyOXlu4bjnDHHhOvdGMWc/yjQ/NEL/+uDNNVeAuuJn9bPoXjBkE+gUL7U3yIxQQ635ibwP/UYmLuDDWgtKzXw4uY3QesVQLUAAJNBK/t0iNP+4puUKVtJQwxb6YKGKzwSi/wi7t+cIY7FGF5DZf68QSelKPtNcf36rEpixAqqlPpvd4+s+W1BUtAUv+6bdKRSI2IC5V2mO3272PzVyEu3PGddHXMy700hFU5vu6ga4oUfsBtPvt/43GO8UD6DJ/6VFii5XT/hCcD7s8Jp9NsVGBnt0g2wvks3ukk/ws8c851fY/OukcIL6tvhbSca8Ww/KXgotazTS8ckg828voTgCUtep57H/RATCp9jKm82B5FGd2NdZPV9VjCX52w2m1VOgKcTW9SZ/Ri
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5176.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(346002)(396003)(136003)(366004)(376002)(2616005)(64756008)(86362001)(6486002)(122000001)(8936002)(1076003)(2906002)(107886003)(5660300002)(41300700001)(26005)(38070700005)(478600001)(6506007)(4326008)(186003)(6512007)(71200400001)(76116006)(6916009)(54906003)(36756003)(66446008)(316002)(66476007)(66556008)(8676002)(91956017)(83380400001)(66946007)(38100700002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?Sf4rhbuSIrmk9ubKlvdHMFSKRHlBPOqo5ATX1NqomRumHdiyhvl1itsdu3?=
 =?iso-8859-1?Q?RApSoZVYuykRViMuKFYnCaVjKmwuM2vv/gcdWjm8lr1fVcx7I61tWDZpts?=
 =?iso-8859-1?Q?NL6pBP9h4KgrsAVlJjpcnA5d/hZ3CEuiW5jRFBya8XK3pBCnAn1ZnTtOF3?=
 =?iso-8859-1?Q?VhVbi6T6b0AC+bHjscAFjydje4heb5Qk8ldJCO9UxYpGo9oRFNfnKx8vA+?=
 =?iso-8859-1?Q?hIl22kI8KPETNKqlWUcvTo4vcN2qGyRsjeB8ofI4g5khYZ0pyAP02nrV0v?=
 =?iso-8859-1?Q?/03XxEKz0j+/wFywDsOjrouZ+GBkC1c7asia1YDBe8GdRrAe+/2K1a20su?=
 =?iso-8859-1?Q?Mxi9fKt0EOOe3yb1Ze/ux+toVfkAtIs2xH0SW3kxOoSeWjKbEn92arCvdI?=
 =?iso-8859-1?Q?YuYZClEH1u7LhL99VFJnf1PI+N7gllyn+YrnKLPhislYE8hG38RF/uCUPc?=
 =?iso-8859-1?Q?+9iI5DV2w/SAJFebKQRZ/JDErIoH+xsTeB47UThbB0rXj23kMiB/YCBL0/?=
 =?iso-8859-1?Q?GWbJ6yXTTb1lNpirHJYi4ApQt+efR8kBNDjLo4m51E62XNXCpkDiojyvVm?=
 =?iso-8859-1?Q?L0aQcWaLCTjtMo+Vzv+taGBfi2FECTD4Hfuid+BWm0s35MQOw4djxIDFip?=
 =?iso-8859-1?Q?XOzGni5GPzZ0EcOvmfwQWsz5uK5goXkjP+Fbyle/kRhgo7CqzTpY1GDW0r?=
 =?iso-8859-1?Q?CCknliB6BW8eHiISD253q75LDsXKsvIbIIFkVhuwSBYkn3LoW7l9xQ8gex?=
 =?iso-8859-1?Q?M0gHajbEXRfgtgQMcD/gQwn/YqI9/UKoVpF4snClI1ohmnlcaLf+XhhHDl?=
 =?iso-8859-1?Q?XrO6e9RkVCWU+bGCIhqmp/lVekcObowDpvOebE0SDFKffR70/idcYmmgYG?=
 =?iso-8859-1?Q?ko3syT5/fbuxyYw038giAZRMAlMBUQS0fxKr54qyrc+M4abqRQWqxNTkCB?=
 =?iso-8859-1?Q?YwL2zDVjysXBDywSALF5aUuJ5dMaxlCQVfiIoEbdm9IwFdAZULwEhTPTcB?=
 =?iso-8859-1?Q?3kLYz9i4jF9dttmKdYzaCThO1KJykoNJxejcBesZyMa93DWukziFk2jV0h?=
 =?iso-8859-1?Q?YI0UDqM/5SImd9B73TfxjlnCY4B8AaEGCTTmhJWN1D69Zg/9s5cPyiBlVw?=
 =?iso-8859-1?Q?san/NomeJA7Z5xn42CtS1R8ynRqfokGGh4SEPdmcykuJzmcNkCEtsVcW2t?=
 =?iso-8859-1?Q?ioF7JINbgrVK48R2OFaGq/naRX6XUM6s5Ep65CoedrD7BOmNtv1kGb35HY?=
 =?iso-8859-1?Q?Y1l7ROmuUVkXnR65WN2WSEk0rnbw2pMIuOrv0pxnsv8+Lch5Dg+X0AXtSj?=
 =?iso-8859-1?Q?arMON1FARTyFisn1H6+wuYhsi5TYGGA9x3G2KXMm1runik7MWrbzRisNCu?=
 =?iso-8859-1?Q?FwVRcM960CK0YaqSs0oCcZMmiB3g3HvikxELvhEfizBD3NYtZfhvN33ke3?=
 =?iso-8859-1?Q?QH7dKIJfpsolCKVVIHIEIEyU5BH0drYAcjrrcfqhOP6HoCeVlBdGyI/0vp?=
 =?iso-8859-1?Q?lM0LcCbHit7gOOCYS8uGbn6FMojwRWl+LB5ZQCem3mZ/AY3G8fwd+mYE8Q?=
 =?iso-8859-1?Q?wFiZg8JiBL1dEzV38TvT0eqiHC8t5jZpR28pKpnkD0KZBs47u3ycfbXltA?=
 =?iso-8859-1?Q?Eryf4mQQftFh2cWFFPYW8gvmzX+M9Gni6iCSkvR/lJNxvry6K53M1O7shS?=
 =?iso-8859-1?Q?kdsng0XFZQy5HPDWWJ8=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5176.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65c0c45c-ad79-44fe-60a1-08da6a6955b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jul 2022 16:03:05.8293
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: evsLp8HIR2WlKuGpB3KkpU2IE1bQ+KIvw4xz6EMKaJaLFSco6iUt8FVlOCp7VNh1/0yGoVAi3jhjBqxOEJbYMP9/XktNZOm3X1LqqNU1iZE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4174
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Similar to SPI priv data, add 'isinit' variable in SDIO priv. Make use
of the state to invoke hif_init() once, and acquire the lock before
accessing hif function.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c | 13 +++++++++++++
 drivers/net/wireless/microchip/wilc1000/spi.c  |  8 ++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.c |  9 ++++++---
 drivers/net/wireless/microchip/wilc1000/wlan.h |  1 +
 4 files changed, 28 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index 7962c11cfe84..600cc57e9da2 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -26,6 +26,7 @@ static const struct sdio_device_id wilc_sdio_ids[] =3D {
 struct wilc_sdio {
 	bool irq_gpio;
 	u32 block_size;
+	bool isinit;
 	int has_thrpt_enh3;
 };
=20
@@ -193,6 +194,13 @@ static int wilc_sdio_reset(struct wilc *wilc)
 	return 0;
 }
=20
+static bool wilc_sdio_is_init(struct wilc *wilc)
+{
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+
+	return sdio_priv->isinit;
+}
+
 static int wilc_sdio_suspend(struct device *dev)
 {
 	struct sdio_func *func =3D dev_to_sdio_func(dev);
@@ -581,6 +589,9 @@ static int wilc_sdio_read(struct wilc *wilc, u32 addr, =
u8 *buf, u32 size)
=20
 static int wilc_sdio_deinit(struct wilc *wilc)
 {
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+
+	sdio_priv->isinit =3D false;
 	return 0;
 }
=20
@@ -700,6 +711,7 @@ static int wilc_sdio_init(struct wilc *wilc, bool resum=
e)
 			 sdio_priv->has_thrpt_enh3);
 	}
=20
+	sdio_priv->isinit =3D true;
 	return 0;
 }
=20
@@ -981,6 +993,7 @@ static const struct wilc_hif_func wilc_hif_sdio =3D {
 	.enable_interrupt =3D wilc_sdio_enable_interrupt,
 	.disable_interrupt =3D wilc_sdio_disable_interrupt,
 	.hif_reset =3D wilc_sdio_reset,
+	.hif_is_init =3D wilc_sdio_is_init,
 };
=20
 static int wilc_sdio_resume(struct device *dev)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 2ae8dd3411ac..b0fc5e68feec 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -1029,6 +1029,13 @@ static int wilc_spi_reset(struct wilc *wilc)
 	return result;
 }
=20
+static bool wilc_spi_is_init(struct wilc *wilc)
+{
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+
+	return spi_priv->isinit;
+}
+
 static int wilc_spi_deinit(struct wilc *wilc)
 {
 	struct wilc_spi *spi_priv =3D wilc->bus_data;
@@ -1250,4 +1257,5 @@ static const struct wilc_hif_func wilc_hif_spi =3D {
 	.hif_block_rx_ext =3D wilc_spi_read,
 	.hif_sync_ext =3D wilc_spi_sync_ext,
 	.hif_reset =3D wilc_spi_reset,
+	.hif_is_init =3D wilc_spi_is_init,
 };
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index f3f504d12873..947d9a0a494e 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -1481,9 +1481,12 @@ int wilc_wlan_init(struct net_device *dev)
=20
 	wilc->quit =3D 0;
=20
-	if (wilc->hif_func->hif_init(wilc, false)) {
-		ret =3D -EIO;
-		goto fail;
+	if (!wilc->hif_func->hif_is_init(wilc)) {
+		acquire_bus(wilc, WILC_BUS_ACQUIRE_ONLY);
+		ret =3D wilc->hif_func->hif_init(wilc, false);
+		release_bus(wilc, WILC_BUS_RELEASE_ONLY);
+		if (ret)
+			goto fail;
 	}
=20
 	if (!wilc->tx_buffer)
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index b45e72789a0e..a72cd5cac81d 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -373,6 +373,7 @@ struct wilc_hif_func {
 	int (*enable_interrupt)(struct wilc *nic);
 	void (*disable_interrupt)(struct wilc *nic);
 	int (*hif_reset)(struct wilc *wilc);
+	bool (*hif_is_init)(struct wilc *wilc);
 };
=20
 #define WILC_MAX_CFG_FRAME_SIZE		1468
--=20
2.34.1
