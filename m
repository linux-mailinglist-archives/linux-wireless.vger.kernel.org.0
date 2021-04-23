Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0AF3699A5
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Apr 2021 20:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243728AbhDWSa1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Apr 2021 14:30:27 -0400
Received: from esa.microchip.iphmx.com ([68.232.154.123]:44326 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbhDWSaX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Apr 2021 14:30:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1619202586; x=1650738586;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QFicB3L4qgvsaTe1LnysfuYZ2JLhR9ebVCygbVi5giU=;
  b=sJYbg50K6doQzJTNK1ZtCXDtGPkLTQZNO6R9yIYUyyxGC49UoixLEGDn
   /fMr5GMtlx78jf56sQ+IK8WGuOj/YVE2I7bDtNImDf3MMDwC2cmhEl2q9
   2bSwIezN45j91b6LpV7/GW0IVzG8kBsSPQwCYloyhMrX3Tn4rXoV21Dwe
   877SDj//4JBAxgEDb8giojLVIeEykr3o9QRgqalkbI7RcO9oZSZH+VB/M
   pfl8XzKI4TsTk8HcCJMYC2Y/kTk3YTuyKafEf0p46DBhycMO3nOF+gqaF
   A7Qc3Ko5Sr+M+X1D9n/cDPLwYlf2pv1Izff+g64LegWB3u0e+2GcWyoNv
   g==;
IronPort-SDR: zDsOARGEu+fv8gCimRShngcaLaSKNqLbhNxs5x3VzleXpyxj2ekGEkbtOSWwyp0sxh/yIoUOP2
 ZXli/slLC8K0i1mPH8bnxDNCyJ/kV2YnV43yCh6XVW+QMjrC4EvxbMf1Aq0pBnmZCmEJVhYmdm
 61B1lHkFE+vV4Hk8VQAqsD7gzgX5G8hxc2238JlJ+KBcD3GLBd4qer/OjHdI4FVVnVKWh0q95V
 Yemi8pZzF4l0J2QpMPtZLv78pJHP44G8QtQfbMM4NItqqz250hFKc2VL9rKpAOPRYo+2eCydNG
 XyE=
X-IronPort-AV: E=Sophos;i="5.82,246,1613458800"; 
   d="scan'208";a="111995816"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Apr 2021 11:29:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Fri, 23 Apr 2021 11:29:46 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2176.2
 via Frontend Transport; Fri, 23 Apr 2021 11:29:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fXdT3/UzCcumcVKesK8wCpTCrMSIraDirL+P+ghwupYmCn0IMjTGwI1Vg/hCkw/XQ0cqx3BDWbZGPl3DOiJ/S0OUcF/0KVCaqeLmxysubdj0OaelMS7mEPjS3l4ivZYfC9AOhXccBa7FaF4Dmx3tOxyWMm9zaTDdnT9v9yazUYhH0qEdPbP0QHkeMPwxevi79k+ufmr89LhZTuIp2Kq/tKZM8ZOCKjOnDv1XbKf/ObA0OG0mYOvAJIkRr0zYePR9zm0xVYOwlxdSmuLICov+qRgT7kyJIb/noh98CEcYImCV62Px9gsTMRJSwvG7mir21cd52XO7UYmbr8+yIAm0IQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uyh7oGn1inencRrX435KeD1+FY6No+0ZwBBbhuDg5A=;
 b=E20YBp5Jt7FvXN8RNdY6D++EUBrt89WyQyMzDQ262ehdRMkrhWOVm4rqMq8tIWI6ZmqcE3iVs8V5GUqNM7DJEvMMlaITO/0diJyUgR8EhHcCvxWdCheSpxWhbfzq5AMcLoLm9odUUc9F3na4Tyg/xt+ftrXRjGQVrT995mfTisMF0Q3IYg3/XNgFnEIhO/LIJ7OERYNOHROzlanK6KlpYuXu9LRd12j6Hg+p5KgA9gLhbVUUmCqdhlO/j+iHJ2gefV7EU8/xvTH8dQM17Fc79frW0vgf4OT2oi7w3VIwQ+5wybzdulzm5uG2j0PUL+s7i0duqMM1AfnSG/ViwVujFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/uyh7oGn1inencRrX435KeD1+FY6No+0ZwBBbhuDg5A=;
 b=Cruej5jy3yRmTfQnilbBdOZKTjEFlA0B3ThOdZ0MMdjEs5k6S6rNNVOPsG7PWtBTfsd09xmG7OGL0CCwIH7km5LOA2g59XNLt5yq7YMOYuysvCuB/zgoLPaak6W4MYTcNqxB/tGBXVOVBjTUDGeabW+s9ysp2ZXuphrwFAYSC5w=
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com (2603:10b6:a03:2ad::17)
 by BYAPR11MB3318.namprd11.prod.outlook.com (2603:10b6:a03:7d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.21; Fri, 23 Apr
 2021 18:29:45 +0000
Received: from SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3]) by SJ0PR11MB4943.namprd11.prod.outlook.com
 ([fe80::5da7:92e6:d6c9:64b3%7]) with mapi id 15.20.4065.024; Fri, 23 Apr 2021
 18:29:45 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH 05/12] wilc1000: add reset/terminate/repeat command support
 for SPI bus
Thread-Topic: [PATCH 05/12] wilc1000: add reset/terminate/repeat command
 support for SPI bus
Thread-Index: AQHXOG6ijAl2K25sXEivkuk3dLQvdA==
Date:   Fri, 23 Apr 2021 18:29:45 +0000
Message-ID: <20210423182925.5865-6-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: d6fb5033-a88c-4711-cf53-08d90685c4d2
x-ms-traffictypediagnostic: BYAPR11MB3318:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33181E01036F061C0C5616FDE3459@BYAPR11MB3318.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:147;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jjw/oe1XqbO0DclA0RVNJPUiBHvfc2mFwm8WjZSGhSa8t4cb1G3GWzb5C5I9GvDW6jc3ZTcNvcSw58BNnSPdrJ26nTpXyZ2HXTOC1JMhkCkny5UkH/YjJh5nDQo1q4atBn3/gmMVS3GHwug9etsxWrHS1ZgdfLMCofwAvY4jZULFGoU2/YEazcPiaL8a+kXtvVTI4MhdKQIkZvl8FwBmypaLGaon5Se0u5v6fAAPxSDHvEu6m0PcFDWCafXw62fxYiRX5jQprI3Wg1HFeFhwB731OnanRbxb53pjn7HTon292kQtTfvVju4q16FWY6uXuQzpMZKGD+GuN90t4wbICFt7dzYhNlWpO7XAo3mg9EkPwi724z3FE0Kffdxwp+r52kffVdid2AqhJsuqMrkV3aVgkdZ1q1N2zbUFI2VWVFT64ZfEpczVamAtm3GTgiHQFw2WRsOJF52ztSC/6Nn7aN89b2BZLaHjxuKu+RjwmGzNYAvHFbsvYOvL83v6qACyFp95tZS0AqdCbTKsmlSTxSsWi1gNp+MXXp/+n7xVn1AADLYrJQruz8ysuifQESR1BUY9w0k052E0xWPD8b+ETUC7MiY/xWid58fBCBEyUuI=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR11MB4943.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(376002)(136003)(39860400002)(346002)(366004)(8676002)(478600001)(55236004)(5660300002)(54906003)(6506007)(71200400001)(1076003)(4326008)(2616005)(6486002)(86362001)(316002)(107886003)(6916009)(66476007)(66446008)(186003)(66946007)(36756003)(122000001)(26005)(66556008)(91956017)(38100700002)(8936002)(64756008)(76116006)(6512007)(2906002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: =?iso-8859-1?Q?ezJ8EAO5j9VsUznAXe9VRv2X29LUl4PnylIZJKc77LNdTHrKYpqoZNVrOr?=
 =?iso-8859-1?Q?tW9fMHPZBKwYmdVHRoz2jLKqVhitH6g8QFCn1rD2zxg5i0dgy6BfhxDg+8?=
 =?iso-8859-1?Q?EEEOmRXJsz0TLt8LZTWWY646Ml1oZdfITCtHVnacOJ13CQRxx9/R6dRlm5?=
 =?iso-8859-1?Q?7IUnqXIVt5HgRV1yT336csIVhFEFI026Zdo+RCML+NhVIZwnAkk4hF5m6G?=
 =?iso-8859-1?Q?sbATqbITZsUJzZjjnUeuoFPJ3x+tJ/dBhUhB91URNF7wLNQgGsU+Wrh805?=
 =?iso-8859-1?Q?6OkaKS4e9i5k6P1i+wQOhGuctk2IP8rPSDUdEIz0l6rMpplIpXAlX6yMm2?=
 =?iso-8859-1?Q?KSpFGVza4w7P0/OaSrtjo/rLFjYTR5qAMmnS9wVAG0VxqTGZnTWMuiDyC1?=
 =?iso-8859-1?Q?A6lNxkSGKBTrXC+DXW+awTOdWEg2WIn4V4B3W1tjfzV1My/ooVnYrEG8ov?=
 =?iso-8859-1?Q?ZsEz5sBtjhRe8dgJfQDPoC8qlPf2JsnwGYO2xA2g/RhQOgCrZGM3xQ/KlJ?=
 =?iso-8859-1?Q?MFbiTg1cO8NU+er9pJmBCuU2yF05EIglUf7PyAcdcMDZyFbXvejDZ5fmms?=
 =?iso-8859-1?Q?oeHdJaenKVB2G39nQ5AVqc5evAowyXluwQ2sJL3hrwjZ0wXWMSmz8FXFX+?=
 =?iso-8859-1?Q?JlUcom5APv+VHPz5BTOtb1F4WBErw+pdd6d2i831KCRcPsGCKqKVDK9M1h?=
 =?iso-8859-1?Q?M9ehpXPqRm8t0XhVaMKJLGOo1ySnOMdtMhp55/N/tZxpzAcneDFVpwKSZ/?=
 =?iso-8859-1?Q?vAkQ0y49LgMDsC2P4eCWzeKjXbZ06Fdp8powDKlMlcccRbUOQjCcFLJM/o?=
 =?iso-8859-1?Q?I6E5EqIVukKoWZh+2WRgu2d4+RagaKIvlMpQ08j01C/9YbYf7JB0UaIyde?=
 =?iso-8859-1?Q?+xOY8dqp/a/bK9l26C/B5Fl3Ydhztj0sT+iS/BSPlkSu9zfeg5MRJBR6HI?=
 =?iso-8859-1?Q?s3F7nfqXrfCEXHkxK2UzqREuintTa8r9s3YSjVtx6ftLcJ/Uk81YRCCcIh?=
 =?iso-8859-1?Q?hVMUgct2yGCwz5r3/90XhmKHO6dbeL+VtgQhCzHdfrsQDceq3sBRcHohXU?=
 =?iso-8859-1?Q?JXy00iEZc8GWBnnFPSDssSCYDCCfzQ8eU4UdSuW3KHVRoAcLqTwsDkykKj?=
 =?iso-8859-1?Q?AYNgmzeHZ+9IshE+MiXf68+Qh++y3nJWjFYlJnk/8uxtQkI72VK+m4yjts?=
 =?iso-8859-1?Q?v8S7gV8IdfbefuxWeeGkMrZom4Lrft+/BZebr0k3F7Dv/NKUkGtp4lAEnq?=
 =?iso-8859-1?Q?6ujkaq4GM6HuSgpMhUlLm0autRjOy3OJEyGNb+j+u1Ph6N89llgLuMZRN3?=
 =?iso-8859-1?Q?m/hmdWuorGMmV9B5A010DRRqOB6PmFT7y7YBi8Ivei7BCmfEX7iuVfpsuF?=
 =?iso-8859-1?Q?6C0U4fXuQp5bgZlAWWCQOJn9YdIvxqnQ=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR11MB4943.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d6fb5033-a88c-4711-cf53-08d90685c4d2
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Apr 2021 18:29:45.1256
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wx86T2FUF3nkcwb5s8E+gtNkaJz0POsvGH4spTivy5q+++BJRq5pndszSg32/qQN6Cn1D1IVU2vVOO6WlmDkDtkhZzv0B2OOUDip8DGW0ZM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3318
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added API to send reset/terminate/repeat SPI commands to FW.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
index 1472e9843896..607c8b642865 100644
--- a/drivers/net/wireless/microchip/wilc1000/spi.c
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -143,6 +143,12 @@ struct wilc_spi_rsp_data {
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
@@ -705,6 +711,61 @@ static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, =
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
2.24.0
