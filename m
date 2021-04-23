Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0B93699A6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243459AbhDWSa3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:29 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44331 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243703AbhDWSaZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202588; x=1650738588;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NyyNGzKusK+33wmLQBQYk1NQCX6NHz42E1ZtTwDVE/4=;
  b=2UB2FBfLrowmw0ipdmXFNzQRuyPHbL9d2wHNnbfY0mTX1TLepohfeifK
   RiG2v8FYAzYnc/D5JD0OGR7zhe2W+Xdf+W3ZI1g/7of0iSOlmPGeUjSqt
   ak8DZsddHvDHiyzeX1uTpX7y5fSEnFR4k5YCcyjRIUCe5gkLQQ1Jjc0So
   gd/pIGTvHixAThG4EPsL93tR90gwzIf2xiSSW6vFKC6StsWx/N3qtWlkB
   Qu2lKVrNHSCeK/z3gkGxYJrQqvAtIpftRwLUU5O/w61ozijCLGmYfCofO
   4N5XppUDbhPCHJM98f7tnY0gMQqFlr4C4QlzkIQVV6YSiYzSpCwz60WKx
   w==;
IronPort-SDR: BK5AOTpUhkq/YHXMwH7J+SdN8lSkL/M+hMG5uy+I5FHReCkqDBmfwfSgJo+oGO7tT/sSP2Zgop
 CdbMPj8XlRssNeSQCufWYBdq+4Kf3eLCuNXcruyiGn7OqGW3trRfyLbrXLyQ9jrLahBjZHlcQa
 kSQQYQpeaQQ/SAxmGMziG4J8p8a5G13s+E89i9izjea7+rXF5bVlvnUgQe9aKHSmi4BOfnTlET
 7c1dZ1hKO9WFWMgaVdnOYGGnfMFBtbvinZoh1Wx7pB3nBjwtzWAl0MvZqUDEtZoZgJLqG9uAg9
 v5o=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="111995830"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=llK1zq8DEoGuSXN38ZHEuBGN0WhPCFP9opC2Iq0OuXfhJA6OXCNp22OR5MiHM/XZl6iB5r39Vz9COyx8rBRIOeNjTqhO5OY4YF09Q+mTFbHE5h7z1aosDMEkY/SBflSu7ixQN3RR69M0RDDNXTXx/caG2x5lZkypUj3Z76III1I6ST8f9DGw7EGB0xOCteuxq1nZzOMNM53znPm0fA1BOf7v2tuLU4uPMBQpuVgXEvdZLjY1dABGbG+D0Y8FmvrWB19eDc0L/4SEzYGtFYu5HRpbROEqDeinHhxzoIhA6CVZJBHtw5lzml/XSv3zUVP53p5hD2swNFZjynNUPUl+tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s4mW9Xs+ATWgpMX3R8Zl0Shrc+d2kXRwrQHH259c6w=;
 b=OsnKDQEXk4sJQnL4BAQRK84hJA+LNadp/RJoEz4UpOcdc11rM4qynondJhhJcAL7sSxhlCeSowg4BS2YVA5B+GEXfaVh4KtQLDOvNGZpYLehTFbEhOBDv036rhOKTDZNWYNltqCu1mPiwD6vCkezVtJ9V1N7m6dB/5C090CLzoDZ9cbDW/zZ22P6KlosUL37dtCqZ4rV6HTqy/wiov2Kqgl/+MQDsh23sT+xsCfM3Rzby6W36QPsVof6Iqz3tY+CnbU2YCl2pvwagYfPep7W2D2Ejoae7nSUrYc+rFadjvUAckXsauRLLRYFut+94qFEB3Q7wOsj7n3GyrHCGf6Ldg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7s4mW9Xs+ATWgpMX3R8Zl0Shrc+d2kXRwrQHH259c6w=;
 b=h8foofSqZ/sxptWKXB7EOkCIwTEKhF0pFKNOUTnqQnSb9cvw14rXpRHw/T2CsYGIQze+ERMkv0JgQDSYH43qatKAkGj6eIXSQoZJiwr/I+ElK5ETGOqZNgcqY3kLy688TCvsIt568dHPP4R27nFNTlcNtU4csarqnDcw+NZwDF0=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:46 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:46 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 06/12] wilc1000: handle register read fail issue for SPI bus
Thread-Topic: [PATCH 06/12] wilc1000: handle register read fail issue for SPI
 bus
Thread-Index: AQHXOG6i85tNg+bmH0+MCYF+QIwh0Q==
Date:   Fri, 23 Apr 2021 18:29:46 +0000
Message-ID: <20210423182925.5865-7-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 43ff8a8c-c0e3-468d-fc60-08d90685c56e
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33181004B597584B8F469216E3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WAD2L97p4G5OYHRtA9QSCAJf9vePCMTgwBOJ8PYA/8Gu4uhQcepflMdEgb85ybKU/QbKVOOQHLoYh0BEteaWQEAgDabHufxorW5TMIvpkiy5ejKJIUIGmcQAhZB1HEnr+fJMy3EDLWjXi72GBpTSfs3+Y6RxSsjk7Z2Sfq6vEvLtKTxEXws08xKc3J3eiUfNIrD2vsdhe5JOatBidzlif9CqUBwrAzPjoicEZtAxoB61JIk4d8BLjBDhA+J17k8mKr3jd4l8vdWNGrYqSEAnkArwz8Vw1Rv9mct+cgJekeB72oGXXCphj+NRAAB7L9QAd9D6rmeKexvs1EeWrk/ii/qPdW3gsOYl3vlN/E8qKW2E/ldq/psxEVzYtTLmEw58QU0xhQ8j6S/QzQxMHau/ILPloViiHNunFHD+j58XJwBLTwhTNR2wC8V77vki6iOwYQy+CnKPoItXIXgG7ACQ4GiAb9BNVG8PBEd2vnA3Y+T9Dd8bTp5KY/1K9H5Vf5QiAeMJUHCyvcSBXiR0hdn1VmMla4bpjyARZHA2lFDyvJd+gPmwleflLLJEaUAz74WMCpG22mb9pM1TJ8PVK5ZO2OIXkmlth4iazMcr+G72ua0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?KNUDpTTGCpelau4kz7tcCamyjv2a36GMZzQDfgdtL5yzVtbEQ+M37d9/IM?=
 =?iso-8859-1?Q?Zwg/R/jsNjWnrJek29dltlA+EAEDkHejvqUJeyMjvuyXFDMKCjdQyh4XU1?=
 =?iso-8859-1?Q?bEqa7wI3y+Pghi7HtZlOJnzmAuxdYhESanvvldUz1Oxl0JratGy3S/WBFd?=
 =?iso-8859-1?Q?EmR1s34Ggah28dMy4otKKTd6jd2GB7Aixkl3LF8qTa9QoqOAEB4AM8zQbn?=
 =?iso-8859-1?Q?+NrGrHA1ulDPQI3jqpCE1qU0N3Gq54A77qYLfKcoGcwMivvMrQnBjD9y5y?=
 =?iso-8859-1?Q?qhMkSoITe+6oG57OIEgv45wJVBdGsuIrThCQMJXV8VWHvFDZqaaByt8u0f?=
 =?iso-8859-1?Q?kZW6Usy09NNCPlVoBBrhnk4Oi+scDKuwipDX6mXEyriBynp2gFWf/x+BKL?=
 =?iso-8859-1?Q?kb9/e/CMZBipky+e+QPOwrj1B6L86crKXbkjZraCy0LPq5yQ9l7Do8TQta?=
 =?iso-8859-1?Q?N0K6aeNIG1GGs9K1Yo3QHm5VgUn0SlzRqIsqpsS+pJ/9QjGBjNc5PohqLo?=
 =?iso-8859-1?Q?E6RsRmCx4mc4oeDSPBRz4lr4jhFXjzXEdWbVwzMghmo6v1tFF7OhI54weR?=
 =?iso-8859-1?Q?w7mxaHO/+GRyBY6ZW+r6D64sAmpQW/NYoWXkcI5Yw9oSA2qqc5BSmW1XnS?=
 =?iso-8859-1?Q?NwgPvINLTsWIo71gPlVCNtBXYqxoHQ/jxTmy3VND06pfzjS/wevPhnE856?=
 =?iso-8859-1?Q?NXI7S4gTT1gtjReURy8+gXmvTC8NfvuNt56LIr5RjPLGBwNuF33tg584ja?=
 =?iso-8859-1?Q?MaRqCkw/MrNu5Gd2BvHsfLXk9w91qmhYBgwD0pRsuWHum/gX/v0RrH0xXw?=
 =?iso-8859-1?Q?ytdqbV2Qj4G4wPJhDs7lBwBkTYrFn7AS6/Ul8twQEoiZ+Ne3pLXQo7Edwr?=
 =?iso-8859-1?Q?XLw/2Z4LQVmJQV1CjPn9u8GXcwFr3pkyc+2/W+anPQ5WcP4J/4fEP1cfCT?=
 =?iso-8859-1?Q?Dd+OK4iTVY8vD0QlY22NF2jDO9YZQqerLAJi15NMf3BedFBqHbUuxc7P8L?=
 =?iso-8859-1?Q?dicczNOirEH5le75DpRtHLYJJPGNX0IO6jyeqI1xUfn4pUYLfgR7kzbrYf?=
 =?iso-8859-1?Q?W41NiFDbp3BMisRFeD33SUrXAKDKsfdtZx58ZkSKi+Q8WV/+clezrSO1TR?=
 =?iso-8859-1?Q?7hic8tG8MXmw0yEBWWHwPTSVL0sf+UwtNFzOPNrsF4s96n07lfloYvM0NG?=
 =?iso-8859-1?Q?JDodYKBaT4ON9b60cb2QRXJ61hQyMhJAViMrzNMssxhYGcsdGXqgGZ8LMF?=
 =?iso-8859-1?Q?xZs0DHK2xjyz2g9Zmm1sLEoZN+XplJDhlBGWrZcta3tbLVFz8rCC+CIMhO?=
 =?iso-8859-1?Q?V4/j531sAL2+KOXfzi+t/GFeJ9zuhPWeVhG4t2rd3DuBQ6eBaCrAcff4WA?=
 =?iso-8859-1?Q?EpIlBsKfBLzmVupTSoCRSvSvDxaXJyLw=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43ff8a8c-c0e3-468d-fc60-08d90685c56e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:46.1472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ztCLpYWR8Oj9OHDWw5Hig/4K8eZkcYz5RLhfk0M4cYwTGv55QU8CMhC2AQQ4RD9qSn5WZfAelyXeKLotY1TleZNAogo+9Av8EhKceEH4hrU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

For SPI bus, sometimes registers read fails after read/write to
clockless register so added workaround to issue reset command during
wakeup sequence.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c |  1 +
 drivers/net/wireless/microchip/wilc1000/spi.c  | 16 ++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.c |  5 +++++
 drivers/net/wireless/microchip/wilc1000/wlan.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index e14b9fc2c67a..db490f449c27 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -975,6 +975,7 @@ static const struct wilc_hif_func wilc_hif_sdio =3D {
 	.hif_sync_ext =3D wilc_sdio_sync_ext,
 	.enable_interrupt =3D wilc_sdio_enable_interrupt,
 	.disable_interrupt =3D wilc_sdio_disable_interrupt,
+	.hif_reset =3D wilc_sdio_reset,
 };
=20
 static int wilc_sdio_resume(struct device *dev)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 607c8b642865..95228dc2d7e0 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -46,6 +46,8 @@ struct wilc_spi {
=20
 static const struct wilc_hif_func wilc_hif_spi;
=20
+static int wilc_spi_reset(struct wilc *wilc);
+
 /********************************************
  *
  *      Spi protocol Function
@@ -952,6 +954,19 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr,=
 u8 *buf, u32 size)
  *
  ********************************************/
=20
+static int wilc_spi_reset(struct wilc *wilc)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int result;
+
+	result =3D wilc_spi_special_cmd(wilc, CMD_RESET);
+	if (result && !spi_priv->probing_crc)
+		dev_err(&spi->dev, "Failed cmd reset\n");
+
+	return result;
+}
+
 static int wilc_spi_deinit(struct wilc *wilc)
 {
 	/*
@@ -1169,4 +1184,5 @@ static const struct wilc_hif_func wilc_hif_spi =3D {
 	.hif_block_tx_ext =3D wilc_spi_write,
 	.hif_block_rx_ext =3D wilc_spi_read,
 	.hif_sync_ext =3D wilc_spi_sync_ext,
+	.hif_reset =3D wilc_spi_reset,
 };
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 177e42a9a603..9f0bb876975a 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.c
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.c
@@ -669,6 +669,11 @@ void chip_wakeup(struct wilc *wilc)
 		pr_err("Failed to wake-up the chip\n");
 		return;
 	}
+	/* Sometimes spi fail to read clock regs after reading
+	 * writing clockless registers
+	 */
+	if (wilc->io_type =3D=3D WILC_HIF_SPI)
+		wilc->hif_func->hif_reset(wilc);
 }
 EXPORT_SYMBOL_GPL(chip_wakeup);
=20
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.h b/drivers/net/w=
ireless/microchip/wilc1000/wlan.h
index 285e5d9a2b48..150648b2c872 100644
--- a/drivers/net/wireless/microchip/wilc1000/wlan.h
+++ b/drivers/net/wireless/microchip/wilc1000/wlan.h
@@ -373,6 +373,7 @@ struct wilc_hif_func {
 	int (*hif_sync_ext)(struct wilc *wilc, int nint);
 	int (*enable_interrupt)(struct wilc *nic);
 	void (*disable_interrupt)(struct wilc *nic);
+	int (*hif_reset)(struct wilc *wilc);
 };
=20
 #define WILC_MAX_CFG_FRAME_SIZE		1468
--=20
2.24.0
