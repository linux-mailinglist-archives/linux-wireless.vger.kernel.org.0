Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 316AD3699A7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243738AbhDWSaa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:30 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:3592 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243712AbhDWSa1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202590; x=1650738590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/cXS0EPppWnlG5mdMKig92lZ4mi8uHvsMDOgS/ZQOmA=;
  b=vJg8k6+9PAO0mIsqrv3ekuCfdPayk/GdZv6yd1JlEsSVAy2/bbiUFYqt
   dWn+qh6n0llaEkbKFjdhzjPeEVMc/FpTHG7jB8E3Y5g0AD7+tKN1q8byd
   Bx8/T5x0I9LCETch4EqDefWZUqExs9WDYQLAqjnNdML3tSay/N+axemRc
   NI4IQn3Y2uJFcsh/CAqbhCYxcE/+B7213CTuaoS9h+l/dOp+qCEQqjMCK
   fJMb3qA6R6vsn2XVvgoLohPTuvyii2ovGWU67mlo/riqkcmsw8Qvzf8o8
   fGvdsIPHe6upr4HBBk4DyaWk1Yo13rYRHhcLwMlY1AvaUm5W2Ip6EdQy7
   g==;
IronPort-SDR: 1AWWpZ6Bs0TymTO+ksAOCbkTuJVyKO12J9TvT12ivzbNzfBTzoTOZ6Xo71nkvuHQiPEZBdcOty
 Y+ZIt2i/0QI7wxlc3eRBYK+P/8diHU/Rg/CSdTNKiM10oTGPUYrsZNXIAHZLZNaoRqFGDT0kJi
 nQ88zNBbOOGOhcSdq/1Ot7yNMMTBO5Kd/AoarhspkeS8LNfg9wEzj6D1JrzrcYrQepMUT8hepK
 IW8O0LnnfXhbHiIlr/s9AQGhV55LqK1lAKPK2LSlBA49d+EkAyYs2Z+fnoLVpublXue0LqtKq2
 5wk=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="118174645"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:48 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2 via Frontend
 Transport; Fri, 23 Apr 2021 11:29:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UCOOJOE2ntN4NZKsy7LZeJ1iu44FYoKRLFy/CYeutEhv9EDhyWqz4jeA0CEbdCgCemqDMpwJrnDP1etLm1mIxpQ5d8FoE19/AtfezwcdbYio3w22Z+WnKJIcJZHU72sCs74wNx6Sg6jPvVnexRxSPkohGuxTt1M1zhen8iQEYZrKOSGyhjndc98nbvWnlRzgKqSWdF4W+LjWUPy/fHXN3L/y4hHbEhBPsdrjdHNjJbZBJxXiS2cgQp+MPuXBZfuVbEChofIT89J0kNdd0hSmm9e4jBYeZWuzafkMtJ7BaqOVmLQO9CpN2PZdK/QBypos2AMkq/1lkKWhBAX0b4atLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGEStLg0uD7i2caS+98TpA1OmmwC6/dsvg9jXl1dO0w=;
 b=ZQf80sUb4Aht1EWCWV2UcLaxkl6XskP97EW3SitNxDVfGPHP8CbvhxApdP/Ves0moi3no6EnWFpn4Tbn3NTBg5B/wzHScShbKmndb/LJLUj0iTuz5dJXmbri5M2LHCljWdLd4VL2z5lGXWxyYPrcmIos8AOwEWToAxPYgaoWxlVg49+me51X+xhcCXD6fhnehYTFA+PR5g2SS/vjBb+6ATQK5aYdHtjxM88KLGsgp+/ylA/YdUVrOxfw99bt+mtbJYQyJC7yXmYuTGgmI4+jqpstpW7oPILVtoF0m1i9L1IjhlwZ8fUyw9h/rYgllzCiSUseMIuE5YkbMsVOe2oXpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGEStLg0uD7i2caS+98TpA1OmmwC6/dsvg9jXl1dO0w=;
 b=Y48UfmyasWOT+ryDckAxdQaO5RHi/rXMi1dcUnSOTSBFM0MKz8552a1r+mtu1yGOWahVPfWBvu5LKp+JbsVSleJY5Vz1EZ41j049ZrnclgUdnC4LSW3DHAn3G2leYb2fkZ6yzZBIvw8rJVZb0S7zSIKGnIhk+nrm+mtNnDdSZF0=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:47 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:47 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 07/12] wilc1000: ignore error response for SPI clockless
 registers
Thread-Topic: [PATCH 07/12] wilc1000: ignore error response for SPI clockless
 registers
Thread-Index: AQHXOG6jBbCHtMS/ykS4i5hfusovnw==
Date:   Fri, 23 Apr 2021 18:29:47 +0000
Message-ID: <20210423182925.5865-8-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 2727b185-ffeb-42b0-4c79-08d90685c5fa
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB3318CF6A69835942E5D4D87EE3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: s1m/cz75OwKO0iitKbJLKxQl0lPQGaHZqJLFCHW1tMmOxTbSSBz1y2gahiitP9NrybHdcvefPJu1CNeRSt0/sxk7niXlL9hHm0iCNeOhtkfs18yEYPJmUmmfRY1W2PdhGEPfVdnMXH2qV5Oi39BIELqKVNDmWvdUoUgmtxkuIakCZkqLiZVg5Mo1sW+FSXKlMOYg+SDvUVVs6rFZJ2eCHlXRj9qUCphLA6BN9uQtFmFjtICh5/KKg/LqMkG7JWmv9qp/o+9eYiXfJ+PIbR5P8FGwCVbgkqIw+M0/o1Lo9AYuB83Y2GxoH7GUQ0MfHRJ2Ck2RFBa98JoAjLH9T1OZeLcijUzDhVMFSMx5D5Jtn7yoMmuOXgPWESnWZNsD3274xGy+/HsnwXu/QonjvnEhjNLZbautaRBgVH4+qLQf4fT0Xc185Zjw/AzKc0LJwCNGCw1jNT3bMpDjAz5ymj8tpYz9D7Gf1aDjmqrihqs3ZUEMk4T6iqTph6Q4surB8B0iAMI7N4ZWFgOSd2gg2501cYHptkFYPuJXIoZrfEzXl6y6Tbk4j9Nq8g+Tg7B9hiOqsfywPG6+CNY9Y5Q4rP45awxD18TksiAJa9hk+SZKQqM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(83380400001)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?cLYVUGnFyfaXRUF7L0vjvnSC/ytlAPoCf3HxhOkN5W1m3ofEkJMBgkZizK?=
 =?iso-8859-1?Q?JbxkO0BteJHlE+LvbJzCTwVm1ouagE+dH5nB/qBG4JR3B9keCzK72YeWm4?=
 =?iso-8859-1?Q?avLTH5DAumGwZ+EGjZo6F40+YrZ8milFLXnBVhzl0FzkTGduc6I44mQQ7c?=
 =?iso-8859-1?Q?4IG7el6LuQQOwNrfbF2EkWdyFoz2GZGi5MQUSeXHtO5IVJBOwp7WLAHZtH?=
 =?iso-8859-1?Q?0xTWny/tpNOHdAqJT9jMbyGMPhN8pi42u2ll1IrlX3LETAcVU1McFuYXPm?=
 =?iso-8859-1?Q?q4Wl9w5w8FCexHGJWcxeQ3lKNjIfM9LVO1P6prOsg1av1D9ZZ0ynHIbGYS?=
 =?iso-8859-1?Q?GejkxKbO+IsjWdievKSLKEVXBUdVNBFriXZFUgWtGP90IB2RIe7ennkdco?=
 =?iso-8859-1?Q?fyQcEXIpB5Rf4qlVbsHpUzplJlxlCn4YE+YBP1mpitMZG3LM5NANeZu3rE?=
 =?iso-8859-1?Q?YKpQ0JZkMa0iP+Obccf/ILa5pFeeDr4xshBZnqa1x424f1ZQVb6jf6/DHu?=
 =?iso-8859-1?Q?maE3ChDS32Ce16/9Kqz6zSlPNkIhoSSSeEaeCPpukix/I8Wf1S+NSk4q08?=
 =?iso-8859-1?Q?icDzMQ4CRu/rfOuAgcXoYeHzhFCvLWgu0Fo6tg5R3Gb0+PEJcmzMn2/i4M?=
 =?iso-8859-1?Q?MvhMC3h9BloGTSqF7y1IXWqrftTmoOpaujF7o2pDjvTrrHEc8H3g4FHdp4?=
 =?iso-8859-1?Q?vp5TUmDxVRuzlbdQhQD0IL/SK/dIidD+TekcfM/ndP6ubv0KL7519vYqic?=
 =?iso-8859-1?Q?IvmORFXNRg14feL2tLTNz9fnakY7OAuHZ39P/uI4Ku/qfp0FCnFiJ7Zf2w?=
 =?iso-8859-1?Q?BThvFAw1oeGLTq4fUE4euO6dT5Kfk6fbVviL8VKDj3sGOZqroA4HpDXGwI?=
 =?iso-8859-1?Q?0xHnG8y6tW2jMrNtOmE4YEASHJMYMSxi2gNLZYK0F/4yyavoph7S8aDYUH?=
 =?iso-8859-1?Q?2n2xsmcj/B4nF9HCKFh8hU5HN4EVJExx9wgSpjMfF2cZr+ONVEb66hACr8?=
 =?iso-8859-1?Q?f3WKUREJyUD/w+tbLnsYU1nIXBnAvJSeKezDlDx0QkL7Md9KfobkTaeOUG?=
 =?iso-8859-1?Q?3GfaKzfgNXqNXkGRHvjnMPvZIagMdtMHqllgHNDqRnT17SPmGJs5MAvox0?=
 =?iso-8859-1?Q?/6kfUxo7apSmNruxRs9diokHkexv4RUWVm1Jwgn2Xvw8ASby02rFPeh233?=
 =?iso-8859-1?Q?CHvjrKNv7gW3SwFx/LG87UcuMyMpKHAmEJwusC9zRc4LUJpuSiB14r4vHg?=
 =?iso-8859-1?Q?erd2XLkaSGUcv2dtFNznZ0HjTnK0U40lnTdoG6EE2zN4gJziV+QGMznuho?=
 =?iso-8859-1?Q?9kYuEm98PhopXSntmM6tDv616ES0UbGmb9L6duAWx48XgqlXwAz+O0/RAw?=
 =?iso-8859-1?Q?huOdu16PHUWNSk13BkF9klSb+eo7NTvg=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2727b185-ffeb-42b0-4c79-08d90685c5fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:47.0064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t4NtS34Sy571llh3TE6ZRVVJno6DOS9A3gt0gCXXSKrDTlrCBYSk66VBg2Svzng+BzGDLEPUVw260s5JPKYr5f6YD759Z1BeZ4l3C4OfnnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Sometimes during wake-up sequence, clockless register status is not
correct even when the operation is successful. Suppress error for
clockless register so that wake-up sequence is successful.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 95228dc2d7e0..4f5464170426 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -470,7 +470,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 c=
md, u32 adr, void *b,
 	}
=20
 	r =3D (struct wilc_spi_rsp_data *)&rb[cmd_len];
-	if (r->rsp_cmd_type !=3D cmd) {
+	if (r->rsp_cmd_type !=3D cmd && !clockless) {
 		if (!spi_priv->probing_crc)
 			dev_err(&spi->dev,
 				"Failed cmd, cmd (%02x), resp (%02x)\n",
@@ -478,7 +478,7 @@ static int wilc_spi_single_read(struct wilc *wilc, u8 c=
md, u32 adr, void *b,
 		return -EINVAL;
 	}
=20
-	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS && !clockless) {
 		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
 			r->status);
 		return -EINVAL;
@@ -567,14 +567,18 @@ static int wilc_spi_write_cmd(struct wilc *wilc, u8 c=
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
2.24.0
