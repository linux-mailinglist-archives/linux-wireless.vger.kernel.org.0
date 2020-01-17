Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0347D1407FF
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2020 11:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726901AbgAQKbb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Jan 2020 05:31:31 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:55340 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726362AbgAQKba (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Jan 2020 05:31:30 -0500
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: k3ri91OHfHldoW61f821T7S20ZTDSywePNhHDV5L/bBp0HaVk442V+jxJKIACsVn7RdLXHVj4T
 4sIeLXO5XEw5/GqaVOHkhebsViMYD16EwLzUZPscLcZcj/uD7+lSazdsXmJxhIfuuGYD/zKirQ
 pOW3xX+UhMWoOQZjUbIcCZQNHDbOdEPzTX1WRj8e5pOatV5ycGhxY9+bVgu1G7YKEsNaOczRO8
 GKnXoKjDC90MiVCw3Xp+oFGDZpPM3KYn8vENXlidFvsUj9cRWYA7wV7AEEO/A9IIyHGJ30yVB6
 9Fc=
X-IronPort-AV: E=Sophos;i="5.70,329,1574146800"; 
   d="scan'208";a="61369414"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jan 2020 03:31:29 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Fri, 17 Jan 2020 03:31:29 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Fri, 17 Jan 2020 03:31:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GileH9ucLOZ0WmMbsJx/WXWLVGCMePxq9DoX06SjO0aUdzz98JP/kKMFlwMoYNpdVVDNG++EtNPBOkBncJ+7R/enymwv8ZBWBLcGVQzCv9BScv5n7/5W2MFH4hgsuE1hWfzNyBrzgNUGfVH9e/1ptxSX43AWSFYQOg+ICO/apmjqLC1IyL5x5kXRRTDF4xzJY2B5KdyJrMBrH9SlHIV6+RxlPgeXF8cHjOrHrEnOvrNeULFQBBB2yw/9WRPo5puglF/aH6rKblajPkkWXRUQg08ImGjtCgRhpt2c3W16qOlX6+2r9M7XQX+XKhkNJiGq+Hb5f+udkydQXtSD5jpJXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4sDtNbwx6vkaUI3w0nWsSCdnCCsvGh82TQsgrYmvxM=;
 b=Ww5xSgQeDhjNT6dV3ejpQChtci0xZOo/bT1u0Y72fJjegcy460lsigOg8U2kD6bF97f4xxpjhATwYhuGkMlTEzif7Dyi3f5FSrQpT92jwxFhYk1zDladmOFs6/daXWOJb6lKFFR5lX4eYZi/EADXSSpO9cJrW+9SKqLEM9rZvpkXG8enmlhDP50gveqd/MRmBnrh0wf2bx8yr1jGlcK9ySzSpkPRDvoVOst1D/0F4nVio8l85A9BX8i7zEKoSlfNLRjjnVVxDddf4SeoZolO6EDkGveNxl6t7vVpxUMMEDMz322Gpmke9hC+FCqir6M0iVkHARJFsyjvHaWNROUC5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4sDtNbwx6vkaUI3w0nWsSCdnCCsvGh82TQsgrYmvxM=;
 b=XwYB2HLnSruiVRghr45G/VsQI70kPQqCpUoQcZn0uWeeMEUOQJ8nR+L0U2YohzqQpec8BIcvLrB9+9mzqQ1WFDcBhbSryvv30KTe6XSIlqZUWYj9Ym623sVizOXa5M+Qt4yNjdrZne6METYq1wyKDbyuJo7da1QIUbSfiBd/3mU=
Received: from DM6PR11MB3996.namprd11.prod.outlook.com (20.176.125.206) by
 DM6PR11MB2907.namprd11.prod.outlook.com (20.177.217.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Fri, 17 Jan 2020 10:31:28 +0000
Received: from DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392]) by DM6PR11MB3996.namprd11.prod.outlook.com
 ([fe80::75b4:bb0c:c245:4392%5]) with mapi id 15.20.2623.018; Fri, 17 Jan 2020
 10:31:28 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <Adham.Abozaeid@microchip.com>, <johannes@sipsolutions.net>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH 4/4] staging: wilc1000: remove unused code prior to throughput
 enhancement in SPI
Thread-Topic: [PATCH 4/4] staging: wilc1000: remove unused code prior to
 throughput enhancement in SPI
Thread-Index: AQHVzSFG90oHFZftCU++AJhMAvfi1w==
Date:   Fri, 17 Jan 2020 10:31:27 +0000
Message-ID: <20200117160157.8706-5-ajay.kathat@microchip.com>
References: <20200117160157.8706-1-ajay.kathat@microchip.com>
In-Reply-To: <20200117160157.8706-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ebf2e9b7-92e9-47f0-5470-08d79b38692d
x-ms-traffictypediagnostic: DM6PR11MB2907:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM6PR11MB29077BD4C98349D84CF17F8CE3310@DM6PR11MB2907.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 0285201563
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(366004)(39860400002)(396003)(376002)(346002)(189003)(199004)(8936002)(6916009)(5660300002)(6486002)(81166006)(478600001)(26005)(76116006)(91956017)(8676002)(81156014)(66946007)(66476007)(66446008)(64756008)(66556008)(36756003)(4326008)(2906002)(86362001)(316002)(6506007)(2616005)(107886003)(71200400001)(1076003)(6512007)(186003)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:DM6PR11MB2907;H:DM6PR11MB3996.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: symNvoeiv2GXwonW1xpPwU0Yu4M/VwcAAjXu+WG7q2clSGjj7CcSfuAvWMGK0GbATABCV9iZJbL80DNYDDTSFMNQlPMaO8HZNyqi1KISf5lw3O93eYrPtASbSnaYuhE+YDYfWPv7pCyqJCv/Tw2M2ZOcZSlLPgiU2z3/qhh+PpF0MdWvxkRpcHXml311L4IWGtUzmAQmbUaFxGOB1xUooQUYX5CmG6DQUzR/DEoFiAN0SAfWpqGMhfpx8mXYkNLBCBF5DeJjAwaDGToUYYoVAZW7QFgAB0SU5hWh3Jy7U5kKee+yWXYhZhTI1Y7SV14u6505/x2ZenVUZnv7vnlvgsPSaexu3Ah5at/e785za+w+rKHaqxtIuU4ZX2U1PyRyQZHlHtAkbYQwd5AeB+nlosPkzC4AqQPmGt0YPSysm76Prs1NtjEP+ZlfBNj5+0hW
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ebf2e9b7-92e9-47f0-5470-08d79b38692d
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2020 10:31:27.9957
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: O83qTsPnmlWAWung21bc2Sbhp4wK6RP8ipv6mbmEOxu0uKWvHfgvmjZGCnL9QKIwcYpdJU796Ja87r31XVtjx7AGtpsMmEAT16AGN8TZhy8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB2907
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

The firmware now uses throughput enhancement code by default for SPI so
remove the previous implementation as its not used anymore. Removed the
use of 'has_thrpt_enh' element as its always true.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/staging/wilc1000/spi.c | 143 +--------------------------------
 1 file changed, 4 insertions(+), 139 deletions(-)

diff --git a/drivers/staging/wilc1000/spi.c b/drivers/staging/wilc1000/spi.=
c
index 8694ab5fcb22..4b883a933b44 100644
--- a/drivers/staging/wilc1000/spi.c
+++ b/drivers/staging/wilc1000/spi.c
@@ -13,7 +13,6 @@
 struct wilc_spi {
 	int crc_off;
 	int nint;
-	int has_thrpt_enh;
 };
=20
 static const struct wilc_hif_func wilc_hif_spi;
@@ -897,8 +896,6 @@ static int wilc_spi_init(struct wilc *wilc, bool resume=
)
 		return 0;
 	}
=20
-	spi_priv->has_thrpt_enh =3D 1;
-
 	isinit =3D 1;
=20
 	return 1;
@@ -906,154 +903,22 @@ static int wilc_spi_init(struct wilc *wilc, bool res=
ume)
=20
 static int wilc_spi_read_size(struct wilc *wilc, u32 *size)
 {
-	struct spi_device *spi =3D to_spi_device(wilc->dev);
-	struct wilc_spi *spi_priv =3D wilc->bus_data;
 	int ret;
=20
-	if (spi_priv->has_thrpt_enh) {
-		ret =3D spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE,
-					size);
-		*size =3D *size  & IRQ_DMA_WD_CNT_MASK;
-	} else {
-		u32 tmp;
-		u32 byte_cnt;
-
-		ret =3D wilc_spi_read_reg(wilc, WILC_VMM_TO_HOST_SIZE,
-					&byte_cnt);
-		if (!ret) {
-			dev_err(&spi->dev,
-				"Failed read WILC_VMM_TO_HOST_SIZE ...\n");
-			return ret;
-		}
-		tmp =3D (byte_cnt >> 2) & IRQ_DMA_WD_CNT_MASK;
-		*size =3D tmp;
-	}
+	ret =3D spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE, size);
+	*size =3D *size & IRQ_DMA_WD_CNT_MASK;
=20
 	return ret;
 }
=20
 static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
 {
-	struct spi_device *spi =3D to_spi_device(wilc->dev);
-	struct wilc_spi *spi_priv =3D wilc->bus_data;
-	int ret;
-	u32 tmp;
-	u32 byte_cnt;
-	bool unexpected_irq;
-	int j;
-	u32 unknown_mask;
-	u32 irq_flags;
-	int k =3D IRG_FLAGS_OFFSET + 5;
-
-	if (spi_priv->has_thrpt_enh)
-		return spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE,
-					 int_status);
-	ret =3D wilc_spi_read_reg(wilc, WILC_VMM_TO_HOST_SIZE, &byte_cnt);
-	if (!ret) {
-		dev_err(&spi->dev,
-			"Failed read WILC_VMM_TO_HOST_SIZE ...\n");
-		return ret;
-	}
-	tmp =3D (byte_cnt >> 2) & IRQ_DMA_WD_CNT_MASK;
-
-	j =3D 0;
-	do {
-		wilc_spi_read_reg(wilc, 0x1a90, &irq_flags);
-		tmp |=3D ((irq_flags >> 27) << IRG_FLAGS_OFFSET);
-
-		if (spi_priv->nint > 5) {
-			wilc_spi_read_reg(wilc, 0x1a94, &irq_flags);
-			tmp |=3D (((irq_flags >> 0) & 0x7) << k);
-		}
-
-		unknown_mask =3D ~((1ul << spi_priv->nint) - 1);
-
-		unexpected_irq =3D (tmp >> IRG_FLAGS_OFFSET) & unknown_mask;
-		if (unexpected_irq) {
-			dev_err(&spi->dev,
-				"Unexpected interrupt(2):j=3D%d,tmp=3D%x,mask=3D%x\n",
-				j, tmp, unknown_mask);
-		}
-
-		j++;
-	} while (unexpected_irq);
-
-	*int_status =3D tmp;
-
-	return ret;
+	return spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE, int_status);
 }
=20
 static int wilc_spi_clear_int_ext(struct wilc *wilc, u32 val)
 {
-	struct spi_device *spi =3D to_spi_device(wilc->dev);
-	struct wilc_spi *spi_priv =3D wilc->bus_data;
-	int ret;
-	u32 flags;
-	u32 tbl_ctl;
-
-	if (spi_priv->has_thrpt_enh) {
-		return spi_internal_write(wilc, 0xe844 - WILC_SPI_REG_BASE,
-					  val);
-	}
-
-	flags =3D val & (BIT(MAX_NUM_INT) - 1);
-	if (flags) {
-		int i;
-
-		ret =3D 1;
-		for (i =3D 0; i < spi_priv->nint; i++) {
-			/*
-			 * No matter what you write 1 or 0,
-			 * it will clear interrupt.
-			 */
-			if (flags & 1)
-				ret =3D wilc_spi_write_reg(wilc,
-							 0x10c8 + i * 4, 1);
-			if (!ret)
-				break;
-			flags >>=3D 1;
-		}
-		if (!ret) {
-			dev_err(&spi->dev,
-				"Failed wilc_spi_write_reg, set reg %x ...\n",
-				0x10c8 + i * 4);
-			return ret;
-		}
-		for (i =3D spi_priv->nint; i < MAX_NUM_INT; i++) {
-			if (flags & 1)
-				dev_err(&spi->dev,
-					"Unexpected interrupt cleared %d...\n",
-					i);
-			flags >>=3D 1;
-		}
-	}
-
-	tbl_ctl =3D 0;
-	/* select VMM table 0 */
-	if (val & SEL_VMM_TBL0)
-		tbl_ctl |=3D BIT(0);
-	/* select VMM table 1 */
-	if (val & SEL_VMM_TBL1)
-		tbl_ctl |=3D BIT(1);
-
-	ret =3D wilc_spi_write_reg(wilc, WILC_VMM_TBL_CTL, tbl_ctl);
-	if (!ret) {
-		dev_err(&spi->dev, "fail write reg vmm_tbl_ctl...\n");
-		return ret;
-	}
-
-	if (val & EN_VMM) {
-		/*
-		 * enable vmm transfer.
-		 */
-		ret =3D wilc_spi_write_reg(wilc, WILC_VMM_CORE_CTL, 1);
-		if (!ret) {
-			dev_err(&spi->dev, "fail write reg vmm_core_ctl...\n");
-			return ret;
-		}
-	}
-
-	return ret;
+	return spi_internal_write(wilc, 0xe844 - WILC_SPI_REG_BASE, val);
 }
=20
 static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
--=20
2.24.0
