Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 317D940E444
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344383AbhIPQ4w (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:56:52 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30349 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346431AbhIPQyy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811213; x=1663347213;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=npvWdfgmR5vZ2mRxQ/8rud+z4aQccSrXIlCi2HVIHMg=;
  b=W0Y+G6ES7b4f8qhIDGKsijQotgQTMINU6VK2D+tRqD3UdmQgJAyRo33Q
   FOYrrBu88wxcs0m4oq/T4GBUFey7Awyr0whcR0qFBpIyDFLfCxbmmLbEx
   Jg4yyFeoLtsUqTakyJdlMxW/ATcVHWLi95k4qCHY7zzeQ6JGfnJC7y/LW
   li6ctqnRswn5mrXzAOqCsLa2Wkbm7+wMWsFu9drmTiFoxnESkFkCSQ/Ii
   bnKem2PC9AmPTpeTXE/FhA7RG0m39DNJB6THmkSP+XAZyzWDa8Op2zDl/
   A4hN3yPtZFKAKd/RiaxkzKzcYOlD9y86DtKgb0yOplRtvtgQtMEPhuVOW
   g==;
IronPort-SDR: hdKVVla6rJJ+i6DwE/0k2FDiIwgJ17IA5X9zPnT4icXvxO/HoLVaqQSFaQvDXmGv3vSmpTg4gT
 wps5KDG2orqe2nCRvwtGluLeLyBZd01RQgsc3Zy+O760R5XbkQhEvTWOJqx2hzjJ97p49EcdZo
 2asXN3YOaG4FOGwePP3cl/sZa1msyVgZx/POLQnahSkC+VFa/sN7V8Q7F/rGgJNBxFgMpRNYzE
 iFBp7loQoHrb7fPhQGM370IiQle6wc8IKs6RMJqXRnptJaPJHJRoStUGvN6oO/Shh3KrqAkhZp
 34fHfq/ds19RBdImjvlu6G0Y
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="136238778"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:22 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lkgEPMeCu8XLBYvFxPHhXnNc4hGqNGQna7AMqpsJkT2317rzuZr4OpKagcD7svcKsnYNdkIHaYRNdhSoJJ2LtHTN6BGqPuHMhpL9BRSlK1mhmrExwPancJvwdwPj/HrxlRkQ8Nn/Fr0xefAh6/FleqvLXBqsko7KfpJRwi8ae8Ox7QXlv4twTw7QSoC89ynN8tk1WIGecJElUcdU50tqs3YIUaSKr5mGC2AdsWBLgSG3yro/lXAg0Z0J/dBmm+o1EcCt6PEtFytxtuxmjhahLehMVcRq3yZBuoUjmmpx6pLlgmKfDf7xu00gaX3uCtOHwTJFAarwHQFvN2+6NGKGfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=WfaOey3xwOxR6UVcI822Dz9AOuglnm3tW3NCznzopVo=;
 b=WWoqNPeIVD3KGS/a4AU1DHttagoTt7gjIBE2blI9eTmZLoLgLuaMff7HXUD9/Vvjk5s9IXTJGkLHHMQbwJouwh4YJ+w3E39Jh+5YaRPXfgOinJDKNZV5/Q22+8tAP10jdQ58l4i3zhXZF4jQtDcdRtk6mbZp31k9eFWT7JPvvgndml2RnYtOrdY3uJK7uVuwxdqOH0xg/YEu0L5lIWr7H66A98QXy6Rn1zCh9umfNujSqA0AaNyF8tHNEzMDKzFOwMXXbWVO8JUoY+urwGeHiNPVy65VqSmiN/aDLwQRU5nRmNGft0zPNKdvzRG8K1hyjt7txJgmDQdNFU4J/5C2Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WfaOey3xwOxR6UVcI822Dz9AOuglnm3tW3NCznzopVo=;
 b=i6M0gKNWmcz9RzhDX4n9kvaznHjrPXHrMy87Q+NFkASJJymS7Gu988+/7vt8uFtreaYR05rbd4KrwcrWW2ku2jx9TsLfKWSE078BG4ROq+V2T8ILbsjf10idqfeW5XTfyJJzG0NbaGSzMUg9PvBuO6AMZibHCiO5aNzWi1X/2ew=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:20 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:20 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 06/11] wilc1000: handle read failure issue for clockless
 registers
Thread-Topic: [PATCH v2 06/11] wilc1000: handle read failure issue for
 clockless registers
Thread-Index: AQHXqxrL9ivDMYK1EUmCexlRqdXQpA==
Date:   Thu, 16 Sep 2021 16:49:20 +0000
Message-ID: <20210916164902.74629-7-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: fc5ce5ad-fab2-4291-5b40-08d97931ee3d
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB51976A016C2ABC2CD00A4D49E3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EvajlVP7lyGF71ZNBk3NmgzygQKrz8AzvnbSC2dDQdMpYkjK5wFfPC21EHgveLVjC8ijLr+LOrWl3gL98aRQy7CxmVFF4zcM7riwcXz9RyQy08DpoxiBRzvfMkDkceXKqSi+YgQIcZACtkRdBLHdAmGYWD8MtOGjyNruaJjyI0DhpLyNYgguX4e78zcNdYTQAoHwcQEFmiC/Si91Nb46JKNuQjsrUzIE/QTzkwEqan6oQAVz4UJ00gDZmMvkK4lKRHgLCRR/ZPPLEwjTVyKGTtZXlnxQqJj4R/HLYplO1ZII2uVZ+wYlloFq+EJrd44073Wfzn7ieeUSQGQNpI1+V8eCiZhTH7NVjnhi0fJjPlq2IjtOjCe4MDiFTUioTDiCZl4Xsz1S5JOYHBa6CzyGtGPzV1EWY2ouccJsr/VHW/+78DWXZzl+QFPfsdVk3tPGCGfVlvTX9jG2rJZgW23Ho/31Ad7hLTKHKKW+6PWRSimD2u+AxVKJEgYjRcQbzvlVYXDLQ/04SquWENTft5YE4BD0Ra6X9taEXGC1Zi+hTKSr9hXW/qh2RmxpxFq56pL0XdtZGoEcMqJIIM0hM6xJBNkKkBMluDiLEBN0F0kypXqiTYo1EU3FqqO2iVDMUh0+0SFILzNkAyMz+fyr1smGMk2jnhPjCG5Gr7X43Jr6lTIBMqmPvxSRnxUdff/Jv+7B0/6+pK9P2NwREGeu5iAKbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?9i0LGiUUnzHYoO72jf1NC8MgOaJme9yU+d2R3rEw5+jdOTKU1+zFdmP0kB?=
 =?iso-8859-1?Q?4b9wcMNoEeK9kvDYzS3Iuw8SghH3UkvsDMN0j+D26xfj5etlPXCjVEK7E1?=
 =?iso-8859-1?Q?kWz/eVJLMfpjlkDu1vxGp+o51av9ymsvmUuorHba5lLS8+FCgKZ7IrfUpm?=
 =?iso-8859-1?Q?Pp2gMj7uY2ZkAoUtF62PEU7t3fQPRanZIH4lLvgJO3M+7DMVVryWle5UB6?=
 =?iso-8859-1?Q?AZlD3uGNOLr0P2/cnp4MrFdDXNHHgIRGumTuSwp5/4aP68oztxCzjEvzHH?=
 =?iso-8859-1?Q?4SM9KvmwEeVLAANFuOzXLybkFoqeabyUefApIl4ZOnbUUSUYKve4W422WS?=
 =?iso-8859-1?Q?835tnWo1/5Jy3Yr4kB4F0sEYrQ68QEGUF1scIEeeDuIRPmahfR+N9M0FIT?=
 =?iso-8859-1?Q?nPiGjIU+pKKxcs9zAYC7wo1VvwpA+ehqr6je8rx1IJ2FlJInTaZPu5kCyJ?=
 =?iso-8859-1?Q?e4ngDgaPiJQd9EAgyb03iJvukM3GsOUJbPkr31PHkTIIlIORZvL2O6hmY/?=
 =?iso-8859-1?Q?Noio/ZWEoq/e8vnWtTJ9MTTWH4Ei5OeL8nS1E1ktdNJTTdpnUpKWx/XhqY?=
 =?iso-8859-1?Q?hMGic4hgYyktqEeMCPfCwxN4vhfQrEnumkw+wE5cCYBDA5UYCqPSAz8us4?=
 =?iso-8859-1?Q?2eYpcSQEzCC4A3UllCf6Ceaow7Ion8ACio6QsdMTPO5v2PbF8TleL+KijK?=
 =?iso-8859-1?Q?P+KGitA5lMArSKUTqInA3P30qMiAHXyi1YDqDtpWsUlM68Ikfe+XZlyaoI?=
 =?iso-8859-1?Q?PXXRwhjg9gMKaT3BgFWXMqW09RkZyULFRC6dM9fGBSXkK81IWye5Ff8wEe?=
 =?iso-8859-1?Q?pPMmlwREhST5CQQUf0vDyWddYVY3FYlvYojavR10JNaDfWDoghOyT+peC3?=
 =?iso-8859-1?Q?sTIRzvpudSuh03VLvA9wf/ZjQ03qxxJwGhqAABTExlp4S5ZBH5CFoiaQmF?=
 =?iso-8859-1?Q?itADYF5LwtcibVDNLW7OPin+vqPi6vKRpxOGKHH1QQDEMGNmbomX6hPC8j?=
 =?iso-8859-1?Q?RPimjrC9EhS6Q4//4wjfKJi53IkSbBkbqBTNv+9ScOpNynALt3CJPqnNTA?=
 =?iso-8859-1?Q?N+L1Mh/jRfCGYZE/9bByT/zHFDdDpk8fgoXnopx3bPWOeEE3/nlI7OAa8z?=
 =?iso-8859-1?Q?W6/Iac7FrqVYdwCzMet+lAT5DVR2O9K7Fgrkbqz0MEnj2ZddZTam3Op9Ga?=
 =?iso-8859-1?Q?ZJ1G4X+Nih38F7KO6kbhvWBXnaQrYrIxpX+vRTYMC5tko6YIleGfVJ7+LH?=
 =?iso-8859-1?Q?EZWvene+6aVfaeP61KYNpa7cVQWvxz5Uo+YN9Up8qS5IusQq0E7uDrjNey?=
 =?iso-8859-1?Q?BXsR60Jz+VYSR9NnD65ekgNDyCDsJnTQMT3zKkCWuhK74AV2ob0MuwMAQa?=
 =?iso-8859-1?Q?PQwZKM/+so?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc5ce5ad-fab2-4291-5b40-08d97931ee3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:20.3308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zGCr070fUMfSNabIQiDYoprJlMOAjlAatVYDUvv8sI4olo8ydbC/Ja9ippeT/+XOO8IRRb0yeRT/kt7qt4ZN0oyW0R0A0SXtRS77EAVJ9RI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

For SPI bus, the register read fails after read/write to the clockless
register during chip wakeup sequence. Add workaround to send CMD_RESET
command during chip wake-up sequence to overcome the issue.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/sdio.c |  1 +
 drivers/net/wireless/microchip/wilc1000/spi.c  | 16 ++++++++++++++++
 drivers/net/wireless/microchip/wilc1000/wlan.c |  5 +++++
 drivers/net/wireless/microchip/wilc1000/wlan.h |  1 +
 4 files changed, 23 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
index 42e03a701ae1..26ebf6664342 100644
--- a/drivers/net/wireless/microchip/wilc1000/sdio.c
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -978,6 +978,7 @@ static const struct wilc_hif_func wilc_hif_sdio =3D {
 	.hif_sync_ext =3D wilc_sdio_sync_ext,
 	.enable_interrupt =3D wilc_sdio_enable_interrupt,
 	.disable_interrupt =3D wilc_sdio_disable_interrupt,
+	.hif_reset =3D wilc_sdio_reset,
 };
=20
 static int wilc_sdio_resume(struct device *dev)
diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 602316f4367c..511b9264185f 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -47,6 +47,8 @@ struct wilc_spi {
=20
 static const struct wilc_hif_func wilc_hif_spi;
=20
+static int wilc_spi_reset(struct wilc *wilc);
+
 /********************************************
  *
  *      Spi protocol Function
@@ -956,6 +958,19 @@ static int wilc_spi_write(struct wilc *wilc, u32 addr,=
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
@@ -1173,4 +1188,5 @@ static const struct wilc_hif_func wilc_hif_spi =3D {
 	.hif_block_tx_ext =3D wilc_spi_write,
 	.hif_block_rx_ext =3D wilc_spi_read,
 	.hif_sync_ext =3D wilc_spi_sync_ext,
+	.hif_reset =3D wilc_spi_reset,
 };
diff --git a/drivers/net/wireless/microchip/wilc1000/wlan.c b/drivers/net/w=
ireless/microchip/wilc1000/wlan.c
index 1aad537c468f..f9256c1bad45 100644
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
2.25.1
