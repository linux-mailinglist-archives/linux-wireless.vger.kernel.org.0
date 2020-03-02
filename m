Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2844C175FED
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:35:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727451AbgCBQe7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:34:59 -0500
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:64432 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727181AbgCBQe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:34:59 -0500
Received-SPF: Pass (esa5.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa5.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa5.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa5.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 1872EfD4NiFyAeGTmP87FjLIiZD1o4FJbsSzH0yYF+03hwyRC/Fq9+DWnVbC9FEVSF3vee9tXC
 teo7u4Gc/XBGCZSogJ7ImBLchIilyaDVNqeQxK1zzzFTAxtHO0+wsDDsR2d7N3iMFTa43BE0zx
 qHTlbcHpwZ2xaH0Lg4nrtsFOa/dOp+jUawGVQYa+xr6/DEesZ4SSFxhMZuxSzABl2vgWPshOFg
 n5xocU3VPkxrG6GG9+CdUcroV/z5GLsY6LQvZfGAKLAqwVqzZ+nzawZT7cqqSuaEbGfnutFrLg
 JYY=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="67327272"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:43 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:40 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 2 Mar 2020 09:34:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WPgSSzExU5gvSStPTfMlaGIYnS/wo2vd2B4mdsw10/jRprMcVJyVhuabcXxWJy3q7jijq2f7+4ta77bH1dhdScllwZPw6fOi8Af6/XSGcmVAOfYl8HBb/FOTDSqZs3ErjQhYYopRAyiv92viWoMkIpbWICkt/BmGZSh9Ics5huKj3+iAq5p/R3oDsiEvDRetGLnnKSXW3LzvfcmUs2CbdDAcpkFsKZaGoBOlKvzUhpUeT+xWxezVP41wBK1H4KrRYpNDylqbNkGQ3wtHAd5PTzOzIJef2euKF+qgaOlaGgKZaqgX4HMG0D1ZpLJKfNN1mB9XofN/oOOxkArn0xzDiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ629ULqFp2gJsHxeuie4Uwn4UZt6Elh81EK7u/nmR8=;
 b=ke0WTL1q6mt8CXfJ3spyDHDQd5fca9yQpxhJSTmwDLO8nSza4OxvH5zQ/Vsx1GZDRFJ+OC9MQu3sGAhC3hHG/cZHAqJ6pvdb6otfv9wbuAegOIcajmAxS8y/6Ckob2b2tyUwDum/29H7P6FuweVMFYVQ1rb1wqiYVoCBWACDkX7xksaukgMKltqwUsOd1ZzVGpWg2obHm6ETxCXHkk5rQXUahAkgpOfpjsjSO4dfjQym9eLulxhfhFmqDJ1bkZXVdhO8ECiUAj5wIzHsp7h8A2r1u8pNrxSJ/L3nx68ROxNnJYfh+b5Db5JrMy7I+1imRNQyT+5rZopKJR3xrGjL+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xJ629ULqFp2gJsHxeuie4Uwn4UZt6Elh81EK7u/nmR8=;
 b=RXHXqDk6T0pgxr1nrAlZNcyo/i3ftSis3zngDC2UxkqGh+3Cy5i3ffFJqt2+NMTT0hwY/nDF6hepgLc1M3ojFf/elbptKYOjud7vlV1ZaBNgGEDFBon0LvZJhw1wJcXQ9XEDcicz9HwQXskwgsYf2r0lSn+y25QlJMS3yOaDQGw=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:37 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:37 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 11/18] wilc1000: add spi.c
Thread-Topic: [PATCH v4 11/18] wilc1000: add spi.c
Thread-Index: AQHV8LB2ceXQBA4DE0CI7njzmQAQsQ==
Date:   Mon, 2 Mar 2020 16:34:37 +0000
Message-ID: <20200302163414.4342-12-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b92da86-aa5a-4829-992c-08d7bec7993e
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098E37A2D5FD433450BEEAFE3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:208;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(30864003)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: J47o0bggkeV8hLq3nPloiK/g1cOZAR5YvKCGvlB2IHQ81Xq1qS7ghAK9mrOk2CHEiDJwLpFd/OU6/WmII60l8QT9FMg29aCLwM2dCOrcGHGVaqWPFTBD3C2TfgfBlv2PTH7fvi8ya50sX3HsZXHbWFCX9ArG/TCkEvvmBadGrYLRZe45RSUJgu6TSHF4lHvMLn6sWV4rMnFbcNt0Cje18274GRByDSKHcUgN54SoyY3y/EYR+ASw9lxwt9timpHX5UiTXObtC/HZEphBVQN6lOD5W/3ec+gXwfp7zLWMroxT85Va8JWHnOjd1e/KEUoEdsyr5cZG2o1+hKTrJxy+q4U2z96OQ0j3+HOkKGyfQwAcESJPhgmkm1fQJMc/MhArw1gdGxnCAqiAs2Gk0DdYbU3fegCjYDFr1Ek1S99PbVdeeH/JFDd084Mh+sw+CH/Z
x-ms-exchange-antispam-messagedata: avraQOLcfNbjnaG5ygMU1ktv4T67dLs1zzlfUlNN44fFF1JgVtHtVhnbQm3FJQOao5i6Txl6WusHoMSJS0Q3DogkMndIc+pGTZOdOh7WCrLwwzg0RiJxwHEyD5LPSfsYRF/rUqiKqbtfqGBpnWbe6Q==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b92da86-aa5a-4829-992c-08d7bec7993e
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:37.2461
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DODypCmF1ojd46Xb44wdk+zAF2Turut3DQm840AjXsurEirJukz23gy4tGk6DqqShbSSPELETicnbjZPlBYAaQvBxDZY21L3No/NZmXLwl0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/spi.c' to
'drivers/net/wireless/microchip/wilc1000/spi.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/spi.c | 1001 +++++++++++++++++
 1 file changed, 1001 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/spi.c

diff --git a/drivers/net/wireless/microchip/wilc1000/spi.c b/drivers/net/wi=
reless/microchip/wilc1000/spi.c
new file mode 100644
index 000000000000..dfd25df75780
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/spi.c
@@ -0,0 +1,1001 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/spi/spi.h>
+
+#include "netdev.h"
+#include "cfg80211.h"
+
+struct wilc_spi {
+	int crc_off;
+};
+
+static const struct wilc_hif_func wilc_hif_spi;
+
+/********************************************
+ *
+ *      Crc7
+ *
+ ********************************************/
+
+static const u8 crc7_syndrome_table[256] =3D {
+	0x00, 0x09, 0x12, 0x1b, 0x24, 0x2d, 0x36, 0x3f,
+	0x48, 0x41, 0x5a, 0x53, 0x6c, 0x65, 0x7e, 0x77,
+	0x19, 0x10, 0x0b, 0x02, 0x3d, 0x34, 0x2f, 0x26,
+	0x51, 0x58, 0x43, 0x4a, 0x75, 0x7c, 0x67, 0x6e,
+	0x32, 0x3b, 0x20, 0x29, 0x16, 0x1f, 0x04, 0x0d,
+	0x7a, 0x73, 0x68, 0x61, 0x5e, 0x57, 0x4c, 0x45,
+	0x2b, 0x22, 0x39, 0x30, 0x0f, 0x06, 0x1d, 0x14,
+	0x63, 0x6a, 0x71, 0x78, 0x47, 0x4e, 0x55, 0x5c,
+	0x64, 0x6d, 0x76, 0x7f, 0x40, 0x49, 0x52, 0x5b,
+	0x2c, 0x25, 0x3e, 0x37, 0x08, 0x01, 0x1a, 0x13,
+	0x7d, 0x74, 0x6f, 0x66, 0x59, 0x50, 0x4b, 0x42,
+	0x35, 0x3c, 0x27, 0x2e, 0x11, 0x18, 0x03, 0x0a,
+	0x56, 0x5f, 0x44, 0x4d, 0x72, 0x7b, 0x60, 0x69,
+	0x1e, 0x17, 0x0c, 0x05, 0x3a, 0x33, 0x28, 0x21,
+	0x4f, 0x46, 0x5d, 0x54, 0x6b, 0x62, 0x79, 0x70,
+	0x07, 0x0e, 0x15, 0x1c, 0x23, 0x2a, 0x31, 0x38,
+	0x41, 0x48, 0x53, 0x5a, 0x65, 0x6c, 0x77, 0x7e,
+	0x09, 0x00, 0x1b, 0x12, 0x2d, 0x24, 0x3f, 0x36,
+	0x58, 0x51, 0x4a, 0x43, 0x7c, 0x75, 0x6e, 0x67,
+	0x10, 0x19, 0x02, 0x0b, 0x34, 0x3d, 0x26, 0x2f,
+	0x73, 0x7a, 0x61, 0x68, 0x57, 0x5e, 0x45, 0x4c,
+	0x3b, 0x32, 0x29, 0x20, 0x1f, 0x16, 0x0d, 0x04,
+	0x6a, 0x63, 0x78, 0x71, 0x4e, 0x47, 0x5c, 0x55,
+	0x22, 0x2b, 0x30, 0x39, 0x06, 0x0f, 0x14, 0x1d,
+	0x25, 0x2c, 0x37, 0x3e, 0x01, 0x08, 0x13, 0x1a,
+	0x6d, 0x64, 0x7f, 0x76, 0x49, 0x40, 0x5b, 0x52,
+	0x3c, 0x35, 0x2e, 0x27, 0x18, 0x11, 0x0a, 0x03,
+	0x74, 0x7d, 0x66, 0x6f, 0x50, 0x59, 0x42, 0x4b,
+	0x17, 0x1e, 0x05, 0x0c, 0x33, 0x3a, 0x21, 0x28,
+	0x5f, 0x56, 0x4d, 0x44, 0x7b, 0x72, 0x69, 0x60,
+	0x0e, 0x07, 0x1c, 0x15, 0x2a, 0x23, 0x38, 0x31,
+	0x46, 0x4f, 0x54, 0x5d, 0x62, 0x6b, 0x70, 0x79
+};
+
+static u8 crc7_byte(u8 crc, u8 data)
+{
+	return crc7_syndrome_table[(crc << 1) ^ data];
+}
+
+static u8 crc7(u8 crc, const u8 *buffer, u32 len)
+{
+	while (len--)
+		crc =3D crc7_byte(crc, *buffer++);
+	return crc;
+}
+
+static u8 wilc_get_crc7(u8 *buffer, u32 len)
+{
+	return crc7(0x7f, (const u8 *)buffer, len) << 1;
+}
+
+/********************************************
+ *
+ *      Spi protocol Function
+ *
+ ********************************************/
+
+#define CMD_DMA_WRITE				0xc1
+#define CMD_DMA_READ				0xc2
+#define CMD_INTERNAL_WRITE			0xc3
+#define CMD_INTERNAL_READ			0xc4
+#define CMD_TERMINATE				0xc5
+#define CMD_REPEAT				0xc6
+#define CMD_DMA_EXT_WRITE			0xc7
+#define CMD_DMA_EXT_READ			0xc8
+#define CMD_SINGLE_WRITE			0xc9
+#define CMD_SINGLE_READ				0xca
+#define CMD_RESET				0xcf
+
+#define DATA_PKT_SZ_256				256
+#define DATA_PKT_SZ_512				512
+#define DATA_PKT_SZ_1K				1024
+#define DATA_PKT_SZ_4K				(4 * 1024)
+#define DATA_PKT_SZ_8K				(8 * 1024)
+#define DATA_PKT_SZ				DATA_PKT_SZ_8K
+
+#define USE_SPI_DMA				0
+
+#define WILC_SPI_COMMAND_STAT_SUCCESS		0
+#define WILC_GET_RESP_HDR_START(h)		(((h) >> 4) & 0xf)
+
+struct wilc_spi_cmd {
+	u8 cmd_type;
+	union {
+		struct {
+			u8 addr[3];
+			u8 crc[];
+		} __packed simple_cmd;
+		struct {
+			u8 addr[3];
+			u8 size[2];
+			u8 crc[];
+		} __packed dma_cmd;
+		struct {
+			u8 addr[3];
+			u8 size[3];
+			u8 crc[];
+		} __packed dma_cmd_ext;
+		struct {
+			u8 addr[2];
+			__be32 data;
+			u8 crc[];
+		} __packed internal_w_cmd;
+		struct {
+			u8 addr[3];
+			__be32 data;
+			u8 crc[];
+		} __packed w_cmd;
+	} u;
+} __packed;
+
+struct wilc_spi_read_rsp_data {
+	u8 rsp_cmd_type;
+	u8 status;
+	u8 resp_header;
+	u8 resp_data[4];
+	u8 crc[];
+} __packed;
+
+struct wilc_spi_rsp_data {
+	u8 rsp_cmd_type;
+	u8 status;
+} __packed;
+
+static int wilc_bus_probe(struct spi_device *spi)
+{
+	int ret;
+	struct wilc *wilc;
+	struct gpio_desc *gpio;
+	struct wilc_spi *spi_priv;
+
+	spi_priv =3D kzalloc(sizeof(*spi_priv), GFP_KERNEL);
+	if (!spi_priv)
+		return -ENOMEM;
+
+	gpio =3D gpiod_get(&spi->dev, "irq", GPIOD_IN);
+	if (IS_ERR(gpio)) {
+		/* get the GPIO descriptor from hardcode GPIO number */
+		gpio =3D gpio_to_desc(GPIO_NUM);
+		if (!gpio)
+			dev_err(&spi->dev, "failed to get the irq gpio\n");
+	}
+
+	ret =3D wilc_cfg80211_init(&wilc, &spi->dev, WILC_HIF_SPI, &wilc_hif_spi)=
;
+	if (ret) {
+		kfree(spi_priv);
+		return ret;
+	}
+
+	spi_set_drvdata(spi, wilc);
+	wilc->dev =3D &spi->dev;
+	wilc->bus_data =3D spi_priv;
+	wilc->gpio_irq =3D gpio;
+
+	wilc->rtc_clk =3D devm_clk_get(&spi->dev, "rtc_clk");
+	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (!IS_ERR(wilc->rtc_clk))
+		clk_prepare_enable(wilc->rtc_clk);
+
+	return 0;
+}
+
+static int wilc_bus_remove(struct spi_device *spi)
+{
+	struct wilc *wilc =3D spi_get_drvdata(spi);
+
+	/* free the GPIO in module remove */
+	if (wilc->gpio_irq)
+		gpiod_put(wilc->gpio_irq);
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
+	wilc_netdev_cleanup(wilc);
+	return 0;
+}
+
+static const struct of_device_id wilc_of_match[] =3D {
+	{ .compatible =3D "microchip,wilc1000-spi", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, wilc_of_match);
+
+static struct spi_driver wilc_spi_driver =3D {
+	.driver =3D {
+		.name =3D MODALIAS,
+		.of_match_table =3D wilc_of_match,
+	},
+	.probe =3D  wilc_bus_probe,
+	.remove =3D wilc_bus_remove,
+};
+module_spi_driver(wilc_spi_driver);
+MODULE_LICENSE("GPL");
+
+static int wilc_spi_tx(struct wilc *wilc, u8 *b, u32 len)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int ret;
+	struct spi_message msg;
+
+	if (len > 0 && b) {
+		struct spi_transfer tr =3D {
+			.tx_buf =3D b,
+			.len =3D len,
+			.delay_usecs =3D 0,
+		};
+		char *r_buffer =3D kzalloc(len, GFP_KERNEL);
+
+		if (!r_buffer)
+			return -ENOMEM;
+
+		tr.rx_buf =3D r_buffer;
+		dev_dbg(&spi->dev, "Request writing %d bytes\n", len);
+
+		memset(&msg, 0, sizeof(msg));
+		spi_message_init(&msg);
+		msg.spi =3D spi;
+		msg.is_dma_mapped =3D USE_SPI_DMA;
+		spi_message_add_tail(&tr, &msg);
+
+		ret =3D spi_sync(spi, &msg);
+		if (ret < 0)
+			dev_err(&spi->dev, "SPI transaction failed\n");
+
+		kfree(r_buffer);
+	} else {
+		dev_err(&spi->dev,
+			"can't write data with the following length: %d\n",
+			len);
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int wilc_spi_rx(struct wilc *wilc, u8 *rb, u32 rlen)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int ret;
+
+	if (rlen > 0) {
+		struct spi_message msg;
+		struct spi_transfer tr =3D {
+			.rx_buf =3D rb,
+			.len =3D rlen,
+			.delay_usecs =3D 0,
+
+		};
+		char *t_buffer =3D kzalloc(rlen, GFP_KERNEL);
+
+		if (!t_buffer)
+			return -ENOMEM;
+
+		tr.tx_buf =3D t_buffer;
+
+		memset(&msg, 0, sizeof(msg));
+		spi_message_init(&msg);
+		msg.spi =3D spi;
+		msg.is_dma_mapped =3D USE_SPI_DMA;
+		spi_message_add_tail(&tr, &msg);
+
+		ret =3D spi_sync(spi, &msg);
+		if (ret < 0)
+			dev_err(&spi->dev, "SPI transaction failed\n");
+		kfree(t_buffer);
+	} else {
+		dev_err(&spi->dev,
+			"can't read data with the following length: %u\n",
+			rlen);
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int wilc_spi_tx_rx(struct wilc *wilc, u8 *wb, u8 *rb, u32 rlen)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int ret;
+
+	if (rlen > 0) {
+		struct spi_message msg;
+		struct spi_transfer tr =3D {
+			.rx_buf =3D rb,
+			.tx_buf =3D wb,
+			.len =3D rlen,
+			.bits_per_word =3D 8,
+			.delay_usecs =3D 0,
+
+		};
+
+		memset(&msg, 0, sizeof(msg));
+		spi_message_init(&msg);
+		msg.spi =3D spi;
+		msg.is_dma_mapped =3D USE_SPI_DMA;
+
+		spi_message_add_tail(&tr, &msg);
+		ret =3D spi_sync(spi, &msg);
+		if (ret < 0)
+			dev_err(&spi->dev, "SPI transaction failed\n");
+	} else {
+		dev_err(&spi->dev,
+			"can't read data with the following length: %u\n",
+			rlen);
+		ret =3D -EINVAL;
+	}
+
+	return ret;
+}
+
+static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int ix, nbytes;
+	int result =3D 0;
+	u8 cmd, order, crc[2] =3D {0};
+
+	/*
+	 * Data
+	 */
+	ix =3D 0;
+	do {
+		if (sz <=3D DATA_PKT_SZ) {
+			nbytes =3D sz;
+			order =3D 0x3;
+		} else {
+			nbytes =3D DATA_PKT_SZ;
+			if (ix =3D=3D 0)
+				order =3D 0x1;
+			else
+				order =3D 0x02;
+		}
+
+		/*
+		 * Write command
+		 */
+		cmd =3D 0xf0;
+		cmd |=3D order;
+
+		if (wilc_spi_tx(wilc, &cmd, 1)) {
+			dev_err(&spi->dev,
+				"Failed data block cmd write, bus error...\n");
+			result =3D -EINVAL;
+			break;
+		}
+
+		/*
+		 * Write data
+		 */
+		if (wilc_spi_tx(wilc, &b[ix], nbytes)) {
+			dev_err(&spi->dev,
+				"Failed data block write, bus error...\n");
+			result =3D -EINVAL;
+			break;
+		}
+
+		/*
+		 * Write Crc
+		 */
+		if (!spi_priv->crc_off) {
+			if (wilc_spi_tx(wilc, crc, 2)) {
+				dev_err(&spi->dev, "Failed data block crc write, bus error...\n");
+				result =3D -EINVAL;
+				break;
+			}
+		}
+
+		/*
+		 * No need to wait for response
+		 */
+		ix +=3D nbytes;
+		sz -=3D nbytes;
+	} while (sz);
+
+	return result;
+}
+
+/********************************************
+ *
+ *      Spi Internal Read/Write Function
+ *
+ ********************************************/
+static int wilc_spi_single_read(struct wilc *wilc, u8 cmd, u32 adr, void *=
b,
+				u8 clockless)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u8 wb[32], rb[32];
+	int cmd_len, resp_len;
+	u8 crc[2];
+	struct wilc_spi_cmd *c;
+	struct wilc_spi_read_rsp_data *r;
+
+	memset(wb, 0x0, sizeof(wb));
+	memset(rb, 0x0, sizeof(rb));
+	c =3D (struct wilc_spi_cmd *)wb;
+	c->cmd_type =3D cmd;
+	if (cmd =3D=3D CMD_SINGLE_READ) {
+		c->u.simple_cmd.addr[0] =3D adr >> 16;
+		c->u.simple_cmd.addr[1] =3D adr >> 8;
+		c->u.simple_cmd.addr[2] =3D adr;
+	} else if (cmd =3D=3D CMD_INTERNAL_READ) {
+		c->u.simple_cmd.addr[0] =3D adr >> 8;
+		if (clockless =3D=3D 1)
+			c->u.simple_cmd.addr[0] |=3D BIT(7);
+		c->u.simple_cmd.addr[1] =3D adr;
+		c->u.simple_cmd.addr[2] =3D 0x0;
+	} else {
+		dev_err(&spi->dev, "cmd [%x] not supported\n", cmd);
+		return -EINVAL;
+	}
+
+	cmd_len =3D offsetof(struct wilc_spi_cmd, u.simple_cmd.crc);
+	resp_len =3D sizeof(*r);
+	if (!spi_priv->crc_off) {
+		c->u.simple_cmd.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+		cmd_len +=3D 1;
+		resp_len +=3D 2;
+	}
+
+	if (cmd_len + resp_len > ARRAY_SIZE(wb)) {
+		dev_err(&spi->dev,
+			"spi buffer size too small (%d) (%d) (%zu)\n",
+			cmd_len, resp_len, ARRAY_SIZE(wb));
+		return -EINVAL;
+	}
+
+	if (wilc_spi_tx_rx(wilc, wb, rb, cmd_len + resp_len)) {
+		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
+		return -EINVAL;
+	}
+
+	r =3D (struct wilc_spi_read_rsp_data *)&rb[cmd_len];
+	if (r->rsp_cmd_type !=3D cmd) {
+		dev_err(&spi->dev,
+			"Failed cmd response, cmd (%02x), resp (%02x)\n",
+			cmd, r->rsp_cmd_type);
+		return -EINVAL;
+	}
+
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
+			r->status);
+		return -EINVAL;
+	}
+
+	if (WILC_GET_RESP_HDR_START(r->resp_header) !=3D 0xf) {
+		dev_err(&spi->dev, "Error, data read response (%02x)\n",
+			r->resp_header);
+		return -EINVAL;
+	}
+
+	if (b)
+		memcpy(b, r->resp_data, 4);
+
+	if (!spi_priv->crc_off)
+		memcpy(crc, r->crc, 2);
+
+	return 0;
+}
+
+static int wilc_spi_write_cmd(struct wilc *wilc, u8 cmd, u32 adr, u32 data=
,
+			      u8 clockless)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u8 wb[32], rb[32];
+	int cmd_len, resp_len;
+	struct wilc_spi_cmd *c;
+	struct wilc_spi_rsp_data *r;
+
+	memset(wb, 0x0, sizeof(wb));
+	memset(rb, 0x0, sizeof(rb));
+	c =3D (struct wilc_spi_cmd *)wb;
+	c->cmd_type =3D cmd;
+	if (cmd =3D=3D CMD_INTERNAL_WRITE) {
+		c->u.internal_w_cmd.addr[0] =3D adr >> 8;
+		if (clockless =3D=3D 1)
+			c->u.internal_w_cmd.addr[0] |=3D BIT(7);
+
+		c->u.internal_w_cmd.addr[1] =3D adr;
+		c->u.internal_w_cmd.data =3D cpu_to_be32(data);
+		cmd_len =3D offsetof(struct wilc_spi_cmd, u.internal_w_cmd.crc);
+		if (!spi_priv->crc_off)
+			c->u.internal_w_cmd.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+	} else if (cmd =3D=3D CMD_SINGLE_WRITE) {
+		c->u.w_cmd.addr[0] =3D adr >> 16;
+		c->u.w_cmd.addr[1] =3D adr >> 8;
+		c->u.w_cmd.addr[2] =3D adr;
+		c->u.w_cmd.data =3D cpu_to_be32(data);
+		cmd_len =3D offsetof(struct wilc_spi_cmd, u.w_cmd.crc);
+		if (!spi_priv->crc_off)
+			c->u.w_cmd.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+	} else {
+		dev_err(&spi->dev, "write cmd [%x] not supported\n", cmd);
+		return -EINVAL;
+	}
+
+	if (!spi_priv->crc_off)
+		cmd_len +=3D 1;
+
+	resp_len =3D sizeof(*r);
+
+	if (cmd_len + resp_len > ARRAY_SIZE(wb)) {
+		dev_err(&spi->dev,
+			"spi buffer size too small (%d) (%d) (%zu)\n",
+			cmd_len, resp_len, ARRAY_SIZE(wb));
+		return -EINVAL;
+	}
+
+	if (wilc_spi_tx_rx(wilc, wb, rb, cmd_len + resp_len)) {
+		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
+		return -EINVAL;
+	}
+
+	r =3D (struct wilc_spi_rsp_data *)&rb[cmd_len];
+	if (r->rsp_cmd_type !=3D cmd) {
+		dev_err(&spi->dev,
+			"Failed cmd response, cmd (%02x), resp (%02x)\n",
+			cmd, r->rsp_cmd_type);
+		return -EINVAL;
+	}
+
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
+			r->status);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int wilc_spi_dma_rw(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32 =
sz)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u8 wb[32], rb[32];
+	int cmd_len, resp_len;
+	int retry, ix =3D 0;
+	u8 crc[2];
+	struct wilc_spi_cmd *c;
+	struct wilc_spi_rsp_data *r;
+
+	memset(wb, 0x0, sizeof(wb));
+	memset(rb, 0x0, sizeof(rb));
+	c =3D (struct wilc_spi_cmd *)wb;
+	c->cmd_type =3D cmd;
+	if (cmd =3D=3D CMD_DMA_WRITE || cmd =3D=3D CMD_DMA_READ) {
+		c->u.dma_cmd.addr[0] =3D adr >> 16;
+		c->u.dma_cmd.addr[1] =3D adr >> 8;
+		c->u.dma_cmd.addr[2] =3D adr;
+		c->u.dma_cmd.size[0] =3D sz >> 8;
+		c->u.dma_cmd.size[1] =3D sz;
+		cmd_len =3D offsetof(struct wilc_spi_cmd, u.dma_cmd.crc);
+		if (!spi_priv->crc_off)
+			c->u.dma_cmd.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+	} else if (cmd =3D=3D CMD_DMA_EXT_WRITE || cmd =3D=3D CMD_DMA_EXT_READ) {
+		c->u.dma_cmd_ext.addr[0] =3D adr >> 16;
+		c->u.dma_cmd_ext.addr[1] =3D adr >> 8;
+		c->u.dma_cmd_ext.addr[2] =3D adr;
+		c->u.dma_cmd_ext.size[0] =3D sz >> 16;
+		c->u.dma_cmd_ext.size[1] =3D sz >> 8;
+		c->u.dma_cmd_ext.size[2] =3D sz;
+		cmd_len =3D offsetof(struct wilc_spi_cmd, u.dma_cmd_ext.crc);
+		if (!spi_priv->crc_off)
+			c->u.dma_cmd_ext.crc[0] =3D wilc_get_crc7(wb, cmd_len);
+	} else {
+		dev_err(&spi->dev, "dma read write cmd [%x] not supported\n",
+			cmd);
+		return -EINVAL;
+	}
+	if (!spi_priv->crc_off)
+		cmd_len +=3D 1;
+
+	resp_len =3D sizeof(*r);
+
+	if (cmd_len + resp_len > ARRAY_SIZE(wb)) {
+		dev_err(&spi->dev, "spi buffer size too small (%d)(%d) (%zu)\n",
+			cmd_len, resp_len, ARRAY_SIZE(wb));
+		return -EINVAL;
+	}
+
+	if (wilc_spi_tx_rx(wilc, wb, rb, cmd_len + resp_len)) {
+		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
+		return -EINVAL;
+	}
+
+	r =3D (struct wilc_spi_rsp_data *)&rb[cmd_len];
+	if (r->rsp_cmd_type !=3D cmd) {
+		dev_err(&spi->dev,
+			"Failed cmd response, cmd (%02x), resp (%02x)\n",
+			cmd, r->rsp_cmd_type);
+		return -EINVAL;
+	}
+
+	if (r->status !=3D WILC_SPI_COMMAND_STAT_SUCCESS) {
+		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
+			r->status);
+		return -EINVAL;
+	}
+
+	if (cmd =3D=3D CMD_DMA_WRITE || cmd =3D=3D CMD_DMA_EXT_WRITE)
+		return 0;
+
+	while (sz > 0) {
+		int nbytes;
+		u8 rsp;
+
+		if (sz <=3D DATA_PKT_SZ)
+			nbytes =3D sz;
+		else
+			nbytes =3D DATA_PKT_SZ;
+
+		/*
+		 * Data Response header
+		 */
+		retry =3D 100;
+		do {
+			if (wilc_spi_rx(wilc, &rsp, 1)) {
+				dev_err(&spi->dev,
+					"Failed resp read, bus err\n");
+				return -EINVAL;
+			}
+			if (WILC_GET_RESP_HDR_START(rsp) =3D=3D 0xf)
+				break;
+		} while (retry--);
+
+		/*
+		 * Read bytes
+		 */
+		if (wilc_spi_rx(wilc, &b[ix], nbytes)) {
+			dev_err(&spi->dev,
+				"Failed block read, bus err\n");
+			return -EINVAL;
+		}
+
+		/*
+		 * Read Crc
+		 */
+		if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
+			dev_err(&spi->dev,
+				"Failed block crc read, bus err\n");
+			return -EINVAL;
+		}
+
+		ix +=3D nbytes;
+		sz -=3D nbytes;
+	}
+	return 0;
+}
+
+static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+	u8 cmd =3D CMD_SINGLE_READ;
+	u8 clockless =3D 0;
+
+	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+		/* Clockless register */
+		cmd =3D CMD_INTERNAL_READ;
+		clockless =3D 1;
+	}
+
+	result =3D wilc_spi_single_read(wilc, cmd, addr, data, clockless);
+	if (result) {
+		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
+		return result;
+	}
+
+	le32_to_cpus(data);
+
+	return 0;
+}
+
+static int wilc_spi_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	if (size <=3D 4)
+		return -EINVAL;
+
+	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_READ, addr, buf, size);
+	if (result) {
+		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
+		return result;
+	}
+
+	return 0;
+}
+
+static int spi_internal_write(struct wilc *wilc, u32 adr, u32 dat)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	result =3D wilc_spi_write_cmd(wilc, CMD_INTERNAL_WRITE, adr, dat, 0);
+	if (result) {
+		dev_err(&spi->dev, "Failed internal write cmd...\n");
+		return result;
+	}
+
+	return 0;
+}
+
+static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	result =3D wilc_spi_single_read(wilc, CMD_INTERNAL_READ, adr, data, 0);
+	if (result) {
+		dev_err(&spi->dev, "Failed internal read cmd...\n");
+		return result;
+	}
+
+	le32_to_cpus(data);
+
+	return 0;
+}
+
+/********************************************
+ *
+ *      Spi interfaces
+ *
+ ********************************************/
+
+static int wilc_spi_write_reg(struct wilc *wilc, u32 addr, u32 data)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+	u8 cmd =3D CMD_SINGLE_WRITE;
+	u8 clockless =3D 0;
+
+	if (addr < WILC_SPI_CLOCKLESS_ADDR_LIMIT) {
+		/* Clockless register */
+		cmd =3D CMD_INTERNAL_WRITE;
+		clockless =3D 1;
+	}
+
+	result =3D wilc_spi_write_cmd(wilc, cmd, addr, data, clockless);
+	if (result) {
+		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
+		return result;
+	}
+
+	return 0;
+}
+
+static int wilc_spi_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	/*
+	 * has to be greated than 4
+	 */
+	if (size <=3D 4)
+		return -EINVAL;
+
+	result =3D wilc_spi_dma_rw(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size);
+	if (result) {
+		dev_err(&spi->dev,
+			"Failed cmd, write block (%08x)...\n", addr);
+		return result;
+	}
+
+	/*
+	 * Data
+	 */
+	result =3D spi_data_write(wilc, buf, size);
+	if (result) {
+		dev_err(&spi->dev, "Failed block data write...\n");
+		return result;
+	}
+
+	return 0;
+}
+
+/********************************************
+ *
+ *      Bus interfaces
+ *
+ ********************************************/
+
+static int wilc_spi_deinit(struct wilc *wilc)
+{
+	/*
+	 * TODO:
+	 */
+	return 0;
+}
+
+static int wilc_spi_init(struct wilc *wilc, bool resume)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u32 reg;
+	u32 chipid;
+	static int isinit;
+	int ret;
+
+	if (isinit) {
+		ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
+		if (ret)
+			dev_err(&spi->dev, "Fail cmd read chip id...\n");
+
+		return ret;
+	}
+
+	/*
+	 * configure protocol
+	 */
+
+	/*
+	 * TODO: We can remove the CRC trials if there is a definite
+	 * way to reset
+	 */
+	/* the SPI to it's initial value. */
+	ret =3D spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
+	if (ret) {
+		/*
+		 * Read failed. Try with CRC off. This might happen when module
+		 * is removed but chip isn't reset
+		 */
+		spi_priv->crc_off =3D 1;
+		dev_err(&spi->dev,
+			"Failed read with CRC on, retrying with CRC off\n");
+		ret =3D spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg);
+		if (ret) {
+			/*
+			 * Read failed with both CRC on and off,
+			 * something went bad
+			 */
+			dev_err(&spi->dev, "Failed internal read protocol\n");
+			return ret;
+		}
+	}
+	if (spi_priv->crc_off =3D=3D 0) {
+		reg &=3D ~0xc; /* disable crc checking */
+		reg &=3D ~0x70;
+		reg |=3D (0x5 << 4);
+		ret =3D spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg);
+		if (ret) {
+			dev_err(&spi->dev,
+				"[wilc spi %d]: Failed internal write reg\n",
+				__LINE__);
+			return ret;
+		}
+		spi_priv->crc_off =3D 1;
+	}
+
+	/*
+	 * make sure can read back chip id correctly
+	 */
+	ret =3D wilc_spi_read_reg(wilc, WILC_CHIPID, &chipid);
+	if (ret) {
+		dev_err(&spi->dev, "Fail cmd read chip id...\n");
+		return ret;
+	}
+
+	isinit =3D 1;
+
+	return 0;
+}
+
+static int wilc_spi_read_size(struct wilc *wilc, u32 *size)
+{
+	int ret;
+
+	ret =3D spi_internal_read(wilc,
+				WILC_SPI_INT_STATUS - WILC_SPI_REG_BASE, size);
+	*size =3D FIELD_GET(IRQ_DMA_WD_CNT_MASK, *size);
+
+	return ret;
+}
+
+static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
+{
+	return spi_internal_read(wilc, WILC_SPI_INT_STATUS - WILC_SPI_REG_BASE,
+				 int_status);
+}
+
+static int wilc_spi_clear_int_ext(struct wilc *wilc, u32 val)
+{
+	return spi_internal_write(wilc, WILC_SPI_INT_CLEAR - WILC_SPI_REG_BASE,
+				  val);
+}
+
+static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	u32 reg;
+	int ret, i;
+
+	if (nint > MAX_NUM_INT) {
+		dev_err(&spi->dev, "Too many interrupts (%d)...\n", nint);
+		return -EINVAL;
+	}
+
+	/*
+	 * interrupt pin mux select
+	 */
+	ret =3D wilc_spi_read_reg(wilc, WILC_PIN_MUX_0, &reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+			WILC_PIN_MUX_0);
+		return ret;
+	}
+	reg |=3D BIT(8);
+	ret =3D wilc_spi_write_reg(wilc, WILC_PIN_MUX_0, reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+			WILC_PIN_MUX_0);
+		return ret;
+	}
+
+	/*
+	 * interrupt enable
+	 */
+	ret =3D wilc_spi_read_reg(wilc, WILC_INTR_ENABLE, &reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+			WILC_INTR_ENABLE);
+		return ret;
+	}
+
+	for (i =3D 0; (i < 5) && (nint > 0); i++, nint--)
+		reg |=3D (BIT((27 + i)));
+
+	ret =3D wilc_spi_write_reg(wilc, WILC_INTR_ENABLE, reg);
+	if (ret) {
+		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+			WILC_INTR_ENABLE);
+		return ret;
+	}
+	if (nint) {
+		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+				WILC_INTR2_ENABLE);
+			return ret;
+		}
+
+		for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
+			reg |=3D BIT(i);
+
+		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		if (ret) {
+			dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+				WILC_INTR2_ENABLE);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/* Global spi HIF function table */
+static const struct wilc_hif_func wilc_hif_spi =3D {
+	.hif_init =3D wilc_spi_init,
+	.hif_deinit =3D wilc_spi_deinit,
+	.hif_read_reg =3D wilc_spi_read_reg,
+	.hif_write_reg =3D wilc_spi_write_reg,
+	.hif_block_rx =3D wilc_spi_read,
+	.hif_block_tx =3D wilc_spi_write,
+	.hif_read_int =3D wilc_spi_read_int,
+	.hif_clear_int_ext =3D wilc_spi_clear_int_ext,
+	.hif_read_size =3D wilc_spi_read_size,
+	.hif_block_tx_ext =3D wilc_spi_write,
+	.hif_block_rx_ext =3D wilc_spi_read,
+	.hif_sync_ext =3D wilc_spi_sync_ext,
+};
--=20
2.24.0
