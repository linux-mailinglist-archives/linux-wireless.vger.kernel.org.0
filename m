Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8537340E424
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Sep 2021 19:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245700AbhIPQzf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Sep 2021 12:55:35 -0400
Received: from esa.microchip.iphmx.com ([68.232.153.233]:30532 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345252AbhIPQw4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Sep 2021 12:52:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1631811096; x=1663347096;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=RwfX4dRsYlliON8BZlbPlqItZSNn7Se6NcgsR4tq08Y=;
  b=LDlpvdGwlR3t8hm9hVE+gkRPm7U5YDmouCPsGAgtDd/k3mSg1aVEgipJ
   ka+23jY8yZeqKYogg8BsNDXqsUnYHc82Fv0xnBPRi3rWYDL5tRdpMQtWm
   Q+o0g/RfGGZuIz8UnFQosxuZlY8AUUBP/C22OJR+Mh7Xq6uYUDWCeEqJ+
   f7JMoWFNmeWiaxaDQdQrLy03wrRFqrZ4/g7A6r+NJ0gMC4wiQx/2JDtTR
   z7Vs9ffnKa6o5Ev0XW7NlVsxz9kvtdxmmqzGhD9VSmtT/qYBVLexmRTuP
   dWbn5qTX+RVH7AJsss3vFvlvuLmHf0fMvsmZ+HZV14vM5OKE8oJrvQ+bP
   A==;
IronPort-SDR: HkmHoC8Cht31YlFkA41Z4VEnkZ+5ckRqPqlDPs8Q0WtHb8SHNKm/xfdmXBDhIsWyeL4AFlkjbL
 8J38qFE1lSjdrBrPZB1V5Lbr36Ejh/DEVkAPG9wJY00hWPasjltA1KVQCKo6Yr7Ex1BdKdQvFK
 uNJPP1Me4zMLTp8WE/Q4cz7+wfkUMxWjLphBqaSI7Wo3h9mDsj9eKpavRPpNefsltqdrZdZPet
 Pbr00OJCItjHxZB+Ca215lm8cnHh471z1TQlBT97wE23Tz3jleQFOFIpNXrJrxGbJrtSpm53hh
 l33oZ7yjAbTpkPLeAY/5gJ9f
X-IronPort-AV: E=Sophos;i="5.85,299,1624345200"; 
   d="scan'208";a="136238777"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2021 09:49:22 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Thu, 16 Sep 2021 09:49:21 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.14 via Frontend
 Transport; Thu, 16 Sep 2021 09:49:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EdeTyTsxOOvPgD6iiVoovSM1iG+RHg1jWZZpWQZadWK69TdJqxOZbLVr24pzcjuDjvfkevk+ZMtddNgM6FQ9hJOV0umG/nrjK0IxIe1KLRJQOQzCDlBlWJtXm7CMkCgeWBsX99dUMa5Rsch/W7tJMqXuBOUn38c+aIt78lPgqjmu4Hr2dvevUxcb1s4qJOo+yZOmw7I7xqRwDfPOzLQYPG43pPedPyBNodF+0Dw44fq0dbv/vMyukNdUZj7XBUAgJDvOkstH3Mlzr5/TocumBHIad8XbT8DZPHLK0b83Jm4E+TA94enzvZdgc2X5TfoQ7q2oigydEtmFpj7ONatLBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=eO0wHRyWekZ/7wOn8M5wxYPVEQdCSDxLfpJSVt7IzEE=;
 b=dhLOhcBQYBbUwd5FeVWpWq2tjHldjWrst1gvdNldaveyeonwvtHsueubJhjtL7BKhT+aEJaW+G8FDV20RAmoHRr8lwHsV25nnO0cDklJzSCuL6JSnKr/pWMowTF7dOpPEHF4Limm0bcvXTU3RvGkramQ51JIkXavObXhVuJjUvjCwm30lxJLPR+IJRirBwslVoIWEcsRLmb+bui/bujOcSlITCtqTLitqF0+4O3+I/iVJhU2Zoc7hpH1tZWe0/5cL6fwiFJy/XY+Jbfj/D/ASa0GrOb7COfIfe1Wpxk9iK/ORw8a2bQh7hGQ/p8hxT7Lbv9Ccy5nuq3NRcQ50kAFqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eO0wHRyWekZ/7wOn8M5wxYPVEQdCSDxLfpJSVt7IzEE=;
 b=WMj8b23WaDfsL2YGTQiTjUdJctbXspz0f71SmR8RB9ruZkURIE6VCdoKoP8W34E1M3qs0nq+4VHJGDl7g40DGxXl8BB1r98IbKvvQGJ5pus8OY3w+KW77T0r1jnWAk7wSjuH5ZqHih0QJSHbwG6LpQ3SHLvce49hBX/ym4QMbM4=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by SJ0PR11MB5197.namprd11.prod.outlook.com (2603:10b6:a03:2d1::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14; Thu, 16 Sep
 2021 16:49:19 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::b095:c8cf:1d0c:a3bc%5]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 16:49:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 05/11] wilc1000: add reset/terminate/repeat command support
 for SPI bus
Thread-Topic: [PATCH v2 05/11] wilc1000: add reset/terminate/repeat command
 support for SPI bus
Thread-Index: AQHXqxrLAGDaTZ6FREiE487aWekw2A==
Date:   Thu, 16 Sep 2021 16:49:19 +0000
Message-ID: <20210916164902.74629-6-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 813e7174-af53-487e-5cd9-08d97931edc3
x-ms-traffictypediagnostic: SJ0PR11MB5197:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR11MB5197DD19D63FD7786245F46DE3DC9@SJ0PR11MB5197.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OWhRy2wqNHKfiP0IHvUNuD5fwHAzLYhAafSBk625ecAo1KTl0RRmlG5Kgfyd+Inkiwkirei4voVdUFe8NxKlhMLDToZx0F3JYaRrb0Lc5rpMT4DaQNFHUTCZsRPEasIIwtAk4PwJK05lx1m9Szoj6pYOPzbPmeGCbLYvM52PHaPC2w4s4eVGEr3Ua9yF/DKn/Ey6ZXJEckwh2Z6qGEfzu497Lq6hLVf0bPbhovN/CV1Llx0j5I2bRXwp3t0kQ/qrG6A1LmUMkpEVucCu8nleDX/efKLEK6lCkSEXCwe7dv13TgjMesDs3rqPrJCVok9s8NmOZmEvFNxStvvW4UClrFFlwET0mOeRhzQ+48xbofG3LdughT2c5LoLYaTskBPTV6/zCewHY5P62/W/HFTQl7jnC9wl/gnEV9pD6G+LQUOteDU1h4eHFl0Mwx8LMjeBM9dvsFTkkuGhchuxE2Or7KV5uM6aUIHpa6kg+dt8n1yCKIhNC6cinZAfgllOrAeEndxF2g6rrRcivjj4saK0QAA5sD5oajyIbRvTpSjBb0P3pRUJTyGaEmt6VwZib4zJgwVBqQ3HxUrS/cKPELmlgGueyBHkTVia8ZjaJo8TgEKhH+av6P4L9eXzW00Uv+2bxrYiHOYE7QvYHwUotNGvuDlajX3mxu8V9StQHNJGCJ1hBAIWh716RTPOyNqB/Wex5vlAeEHvDxymOH374SCCAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(26005)(107886003)(54906003)(76116006)(8676002)(6512007)(6916009)(66556008)(66476007)(86362001)(64756008)(66446008)(8936002)(66946007)(91956017)(122000001)(38100700002)(316002)(83380400001)(186003)(5660300002)(38070700005)(1076003)(2906002)(508600001)(4326008)(71200400001)(6486002)(2616005)(36756003)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?PSMn3+dFNLEwDQvHUXUDBwzV53PckvMY30GDVKY4QkyYFcA2zNPxXcsa8Q?=
 =?iso-8859-1?Q?v/zq+A7Kcn5vhgDEtK96WmroyVL3qg0M5Sn0FLdeUnAecIHc5oZSUmIolH?=
 =?iso-8859-1?Q?gN8N+0Wgm2JMA1XudbjTKeLYjw02ZS9PXs/5SNi/5ZDYj6UuaMA1UwDRmf?=
 =?iso-8859-1?Q?pLwxmdCqcirstyMeJAqLkQfLpqEq2JDHSDZpgCbREup/GReFLadX0IZpfB?=
 =?iso-8859-1?Q?E7uEDTAhlkdlu4Rh1exO8AeAQ5lWSohtQZRL2jiM7bPfd3FRQwj12Rjmpl?=
 =?iso-8859-1?Q?RkmbCb5B20j0ELcnAabWVryV3S7ji7LK4+4gicGJK3KjnP7I3MF93gcEUD?=
 =?iso-8859-1?Q?NXC05QNetRUbZEIMSsS9QirL/X+VCiBj2vQK9tAUF/HftQ6DgM4TnQHX+L?=
 =?iso-8859-1?Q?qivulLOmjVo6AA57emABi7+/hu5tsTM+8AyuFpES5C5J64yaekg8uurTS1?=
 =?iso-8859-1?Q?kNv+0f56h63D49YQNyVQjjxJxvriuqAxnG3/B2STcF1eA0RnkZpEakPSCO?=
 =?iso-8859-1?Q?Xub8BoGnb3SskU5KPi+eWFDTkkrXw7dJQ6lvkPm3cBbjEA52D6jm3UI5KP?=
 =?iso-8859-1?Q?spoXjgW7nmuoEdL5L8DHofphF9pI3kOxVo20FYnESLOF2MsO76CAwYuf6G?=
 =?iso-8859-1?Q?+cbSECaP1eS1GAR+OSEU4B7HPl8hzTQZRKqqkm3JlksF9toNjP6WTMp1R5?=
 =?iso-8859-1?Q?uKs1OTl3c3kHNMJXDj2ie4oaXCrq0MedEEvpbO6aFD97y7n6YVUht31wV+?=
 =?iso-8859-1?Q?J3VxE6eonUopp3sZHBy+wd7JSLRqlfzcIpDrOJUzDalV2VfoF7COqxDxnm?=
 =?iso-8859-1?Q?Gw7MjZL82kXZjpIVD9yGw6gwtMcaerRC9XEgD1B+TwyVm6DPgdbIZI5Ns2?=
 =?iso-8859-1?Q?4MBYfDt0qTj8vTm7w8rvSrNo4ASxx6HNtRqaAu59rBoyBmJTvJGd53InQl?=
 =?iso-8859-1?Q?Qb0Szo5HScs3u0JSO5qZRZCjtTXq9oSk/cNWJsGbN6X6AxF7GwV65RxWgR?=
 =?iso-8859-1?Q?XVU7R090OZTVhhmhwye1xExF+fjVPYPTxxbk3uySAeLXgo1DCQYdZMbAgV?=
 =?iso-8859-1?Q?apPE49wKiJeyBD6j3PN9Oy5abaT6Enp8A7+uVBeuaBLSPPnTwtL3UYMKsQ?=
 =?iso-8859-1?Q?af5LejlWVo18l/bskSS6DDlYuMN3YS4ns7mibvUk7jsFE6FOEEAu7cufSZ?=
 =?iso-8859-1?Q?lAe9rkK96cHos8tvT/YwREBHXDka7u4dXEMHsoKxX/nJlW3K8CluzbBhtg?=
 =?iso-8859-1?Q?Kz99DawnGkOfA5yvlFKMv6bC58j6VZOktu5WVx6IPLBRxJ3rLdFW1SEDpM?=
 =?iso-8859-1?Q?PFJgmVxJUfCwBc9jq+qdhpjpTlaUbuVR2aRjhaIl2n6v+XHCBy1nRizICT?=
 =?iso-8859-1?Q?3QuLYfTacl?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 813e7174-af53-487e-5cd9-08d97931edc3
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2021 16:49:19.7862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KORdG8le6evgs/UdAWxH1peqJnn+Jzcy+jljClca0rVWsu9klIGvSRxempeLucWVU8lpwCd1N86lPeJ8CDUoNifvxhSvmdkMO2KGRfZFj3A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5197
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Add reset/terminate/repeat command for SPI module. In case of SPI commands
failure, the host should issue a RESET command to WILC chip to recover
from any temporary bus error.
For now, the new command support is added and later the SPI read/write
API's would be modified to make use of these commands for retry mechanism

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index dd481dc0b5ce..602316f4367c 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -144,6 +144,12 @@ struct wilc_spi_rsp_data {
 	u8 data[];
 } __packed;
=20
+struct wilc_spi_special_cmd_rsp {
+	u8 skip_byte;
+	u8 rsp_cmd_type;
+	u8 status;
+} __packed;
+
 static int wilc_bus_probe(struct spi_device *spi)
 {
 	int ret;
@@ -709,6 +715,61 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, =
u32 adr, u8 *b, u32 sz)
 	return 0;
 }
=20
+static int wilc_spi_special_cmd(struct wilc *wilc, u8 cmd)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u8 wb[32], rb[32];
+	int cmd_len, resp_len =3D 0;
+	struct wilc_spi_cmd *c;
+	struct wilc_spi_special_cmd_rsp *r;
+
+	if (cmd !=3D CMD_TERMINATE && cmd !=3D CMD_REPEAT && cmd !=3D CMD_RESET)
+		return -EINVAL;
+
+	memset(wb, 0x0, sizeof(wb));
+	memset(rb, 0x0, sizeof(rb));
+	c =3D (struct wilc_spi_cmd *)wb;
+	c->cmd_type =3D cmd;
+
+	if (cmd =3D=3D CMD_RESET)
+		memset(c->u.simple_cmd.addr, 0xFF, 3);
+
+	cmd_len =3D offsetof(struct wilc_spi_cmd, u.simple_cmd.crc);
+	resp_len =3D sizeof(*r);
+
+	if (spi_priv->crc7_enabled) {
+		c->u.simple_cmd.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+		cmd_len +=3D 1;
+	}
+	if (cmd_len + resp_len > ARRAY_SIZE(wb)) {
+		dev_err(&spi->dev, "spi buffer size too small (%d) (%d) (%zu)\n",
+			cmd_len, resp_len, ARRAY_SIZE(wb));
+		return -EINVAL;
+	}
+
+	if (wilc_spi_tx_rx(wilc, wb, rb, cmd_len + resp_len)) {
+		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
+		return -EINVAL;
+	}
+
+	r =3D (struct wilc_spi_special_cmd_rsp *)&rb[cmd_len];
+	if (r->rsp_cmd_type !=3D cmd) {
+		if (!spi_priv->probing_crc)
+			dev_err(&spi->dev,
+				"Failed cmd response, cmd (%02x), resp (%02x)\n",
+				cmd, r->rsp_cmd_type);
+		return -EINVAL;
+	}
+
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
+			r->status);
+		return -EINVAL;
+	}
+	return 0;
+}
+
 static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
 {
 	struct spi_device *spi =3D to_spi_device(wilc->dev);
--=20
2.25.1
