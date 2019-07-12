Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6F8766395
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729081AbfGLB7e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:34 -0400
Received: from esa2.microchip.iphmx.com ([68.232.149.84]:23316 "EHLO
        esa2.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728877AbfGLB7d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:33 -0400
Received-SPF: Pass (esa2.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa2.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa2.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa2.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: SQxQT3KSG9LM+uAKWxROY0piTE2PIhJzSLdw2iX1gJLtYL7cRcGUvTI2palVg7OBliRB2aaW2c
 7C0SwLJGqn+ZR7EukrOdC5iUs5JLMccaUGTi/oYzZJdDi7vGStFqJAJ3pmv5NtcGYfXgeQIPJM
 bOK0wOLBk2vdVnEZuweB4Dix/yIjjtneQYRLsiLeFSBDc/W+Q010Cv4GC5t6egdFa6LlcFzyA6
 zXXKq7SYYS7Txt5GKoyB06pcaFOvsqtLhEb45O4PWVJe2xBVQry1/Gtr9VKS6r8XU/I5Eqz3O5
 CuE=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="40962363"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:22 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex03.mchp-main.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:19 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 11 Jul 2019 18:59:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hw26F/hZ6HNIck2SwMcryIJOuYwXVLBk/eUvJMXuZV7DwEuGAqY9w17tOsYjbz8ivSaO5ujIi5WlTzuukFfX+SWzbzQHtYKDwILYAQVevYxBtZlqvyt5YmeDKbJxmVXBxD00Dbm5Ovj8MR6p/Wd/d7PCBdxfF3kQTEhaV2tXWow+WAZM2EcL+m2neIebgOxwxVTSMooM/yEsDgbTywMlN4tH0dI2GaMSRxY9E8PhM0Iuxds6ePoCxOzH6oEaYyn8ZKMXYBXO+a3WIJQIX3KsxKHHMQ9097QHOmO2jIrP5Oh90IuMyGX3Vz3APZiTSZG9JxcDnCpQfdDTxylXIAvq4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9LFolfMIyIcg/IjDaLmkLvFo/401yJn5OkbF4/bH7s=;
 b=CtvKpwvBFSw5tG3NWaWS08Q46hDDExh8GgIQmfi6HOwe4vDn3vmKPbihgCSbTztfksGc/5x7GdLUozsaTTNDN3Dn+PgsdfoKE4TRs3C7pOYv0KHdfOaQeKHWo1LbSJon/DRsbm1zzwtWjTMXfUfISfx/iMQa+auJOwfUXNM7yz4HLvHCt/yVPoFo7aGimVeZqdmRvmHXFLe8i0b1B/PGwAam+JuTJEhpMm7/nsRDclwg+utiiHfzSx9NPDGwI2UEv+YmLliyhwDphbVjipImyBwYnXk7Zzfr0lYuvPZh3daye+VfYG93s2eK7WOFrGedEcN7V0v6hd37/qO/wWIauQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V9LFolfMIyIcg/IjDaLmkLvFo/401yJn5OkbF4/bH7s=;
 b=JOG65P7NNc2WhaSk3HcIomqA0HRHEUqdUu3IW4WtgBKszF3CW5/btjK7DpZLn3JSrV4/r7wNN/XytLsy8khs3hXG2V8NtgvZjyUUqdQgVPWNhhJdrRjK1ID5mCW65FgHQcB9I7orSiD47LGpUMJ5qcQOsy1B/Z8F3I/ROUOFegM=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:17 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:17 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 11/16] wilc1000: add wilc_spi.c
Thread-Topic: [PATCH v2 11/16] wilc1000: add wilc_spi.c
Thread-Index: AQHVOFVpbLhjxD//y0m7wRk7QVJxmA==
Date:   Fri, 12 Jul 2019 01:59:16 +0000
Message-ID: <1562896697-8002-12-git-send-email-ajay.kathat@microchip.com>
References: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
In-Reply-To: <1562896697-8002-1-git-send-email-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BM1PR0101CA0026.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:1a::12) To BN6PR11MB3985.namprd11.prod.outlook.com
 (2603:10b6:405:7b::14)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [49.205.218.233]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4437d9a3-261d-46d8-7bf6-08d7066c8ba7
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB14256D9B05D63C295DBDA9D8E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:268;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(53946003)(5640700003)(107886003)(68736007)(99286004)(30864003)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(14444005)(3846002)(8936002)(305945005)(81166006)(2906002)(579004)(559001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: bY0EPpV7Lwog18PKyNa/ywi+wzR1d8gTk3OXJBxjWHhyTsuivQyjvQkto5Y403PAzkJqwsv51AhGSZvyV6UA9qbXfYjdN6sze8KHrv2ZNbQDQfEzjkrS+N/VCWt+TTyVZdFtEnmL02lYXke75sx80y73w6VlaPAmNBrQLa+LqZMKB+aIA4/5eDLnQroh/yKUCQwK7Jria+l2DinH7/LL/NdX1e2ueoawX5n4pjwrFiqkIGlbW/YvfnXiQgLB5FYJo1sDkjXLdFLauNe5+c05YUQmhyCpOEqh6daE0HjB0Ot15oTImU+0Vhqpd9rzZPLgcHCCVv1qK3rOakjk34ZU0VBRYPgGKOLXO059/V+5xo8ZctPSJcVmMWwP3u/yuiSX77NAvQY7C5L0DmwviWHJ2v9n9rYtEROZYG4Zl9XDj0g=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 4437d9a3-261d-46d8-7bf6-08d7066c8ba7
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:16.8636
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ajay.kathat@microchip.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB1425
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved '/driver/staging/wilc1000/wilc_spi.c' to
'drivers/net/wireless/microchip/wilc1000/wilc_spi.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/microchip/wilc1000/wilc_spi.c | 1134 ++++++++++++++++=
++++
 1 file changed, 1134 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/wilc_spi.c

diff --git a/drivers/net/wireless/microchip/wilc1000/wilc_spi.c b/drivers/n=
et/wireless/microchip/wilc1000/wilc_spi.c
new file mode 100644
index 0000000..3c1ae9e
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/wilc_spi.c
@@ -0,0 +1,1134 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/spi/spi.h>
+
+#include "wilc_wfi_netdevice.h"
+#include "wilc_wfi_cfgoperations.h"
+
+struct wilc_spi {
+	int crc_off;
+	int nint;
+	int has_thrpt_enh;
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
+#define N_OK					1
+#define N_FAIL					0
+#define N_RESET					-1
+#define N_RETRY					-2
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
+static int spi_cmd_complete(struct wilc *wilc, u8 cmd, u32 adr, u8 *b, u32=
 sz,
+			    u8 clockless)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u8 wb[32], rb[32];
+	u8 wix, rix;
+	u32 len2;
+	u8 rsp;
+	int len =3D 0;
+	int result =3D N_OK;
+	int retry;
+	u8 crc[2];
+
+	wb[0] =3D cmd;
+	switch (cmd) {
+	case CMD_SINGLE_READ: /* single word (4 bytes) read */
+		wb[1] =3D (u8)(adr >> 16);
+		wb[2] =3D (u8)(adr >> 8);
+		wb[3] =3D (u8)adr;
+		len =3D 5;
+		break;
+
+	case CMD_INTERNAL_READ: /* internal register read */
+		wb[1] =3D (u8)(adr >> 8);
+		if (clockless =3D=3D 1)
+			wb[1] |=3D BIT(7);
+		wb[2] =3D (u8)adr;
+		wb[3] =3D 0x00;
+		len =3D 5;
+		break;
+
+	case CMD_TERMINATE:
+		wb[1] =3D 0x00;
+		wb[2] =3D 0x00;
+		wb[3] =3D 0x00;
+		len =3D 5;
+		break;
+
+	case CMD_REPEAT:
+		wb[1] =3D 0x00;
+		wb[2] =3D 0x00;
+		wb[3] =3D 0x00;
+		len =3D 5;
+		break;
+
+	case CMD_RESET:
+		wb[1] =3D 0xff;
+		wb[2] =3D 0xff;
+		wb[3] =3D 0xff;
+		len =3D 5;
+		break;
+
+	case CMD_DMA_WRITE: /* dma write */
+	case CMD_DMA_READ:  /* dma read */
+		wb[1] =3D (u8)(adr >> 16);
+		wb[2] =3D (u8)(adr >> 8);
+		wb[3] =3D (u8)adr;
+		wb[4] =3D (u8)(sz >> 8);
+		wb[5] =3D (u8)(sz);
+		len =3D 7;
+		break;
+
+	case CMD_DMA_EXT_WRITE: /* dma extended write */
+	case CMD_DMA_EXT_READ:  /* dma extended read */
+		wb[1] =3D (u8)(adr >> 16);
+		wb[2] =3D (u8)(adr >> 8);
+		wb[3] =3D (u8)adr;
+		wb[4] =3D (u8)(sz >> 16);
+		wb[5] =3D (u8)(sz >> 8);
+		wb[6] =3D (u8)(sz);
+		len =3D 8;
+		break;
+
+	case CMD_INTERNAL_WRITE: /* internal register write */
+		wb[1] =3D (u8)(adr >> 8);
+		if (clockless =3D=3D 1)
+			wb[1] |=3D BIT(7);
+		wb[2] =3D (u8)(adr);
+		wb[3] =3D b[3];
+		wb[4] =3D b[2];
+		wb[5] =3D b[1];
+		wb[6] =3D b[0];
+		len =3D 8;
+		break;
+
+	case CMD_SINGLE_WRITE: /* single word write */
+		wb[1] =3D (u8)(adr >> 16);
+		wb[2] =3D (u8)(adr >> 8);
+		wb[3] =3D (u8)(adr);
+		wb[4] =3D b[3];
+		wb[5] =3D b[2];
+		wb[6] =3D b[1];
+		wb[7] =3D b[0];
+		len =3D 9;
+		break;
+
+	default:
+		result =3D N_FAIL;
+		break;
+	}
+
+	if (result !=3D N_OK)
+		return result;
+
+	if (!spi_priv->crc_off)
+		wb[len - 1] =3D (crc7(0x7f, (const u8 *)&wb[0], len - 1)) << 1;
+	else
+		len -=3D 1;
+
+#define NUM_SKIP_BYTES (1)
+#define NUM_RSP_BYTES (2)
+#define NUM_DATA_HDR_BYTES (1)
+#define NUM_DATA_BYTES (4)
+#define NUM_CRC_BYTES (2)
+#define NUM_DUMMY_BYTES (3)
+	if (cmd =3D=3D CMD_RESET ||
+	    cmd =3D=3D CMD_TERMINATE ||
+	    cmd =3D=3D CMD_REPEAT) {
+		len2 =3D len + (NUM_SKIP_BYTES + NUM_RSP_BYTES + NUM_DUMMY_BYTES);
+	} else if (cmd =3D=3D CMD_INTERNAL_READ || cmd =3D=3D CMD_SINGLE_READ) {
+		int tmp =3D NUM_RSP_BYTES + NUM_DATA_HDR_BYTES + NUM_DATA_BYTES
+			+ NUM_DUMMY_BYTES;
+		if (!spi_priv->crc_off)
+			len2 =3D len + tmp + NUM_CRC_BYTES;
+		else
+			len2 =3D len + tmp;
+	} else {
+		len2 =3D len + (NUM_RSP_BYTES + NUM_DUMMY_BYTES);
+	}
+#undef NUM_DUMMY_BYTES
+
+	if (len2 > ARRAY_SIZE(wb)) {
+		dev_err(&spi->dev, "spi buffer size too small (%d) (%zu)\n",
+			len2, ARRAY_SIZE(wb));
+		return N_FAIL;
+	}
+	/* zero spi write buffers. */
+	for (wix =3D len; wix < len2; wix++)
+		wb[wix] =3D 0;
+	rix =3D len;
+
+	if (wilc_spi_tx_rx(wilc, wb, rb, len2)) {
+		dev_err(&spi->dev, "Failed cmd write, bus error...\n");
+		return N_FAIL;
+	}
+
+	/*
+	 * Command/Control response
+	 */
+	if (cmd =3D=3D CMD_RESET || cmd =3D=3D CMD_TERMINATE || cmd =3D=3D CMD_RE=
PEAT)
+		rix++; /* skip 1 byte */
+
+	rsp =3D rb[rix++];
+
+	if (rsp !=3D cmd) {
+		dev_err(&spi->dev,
+			"Failed cmd response, cmd (%02x), resp (%02x)\n",
+			cmd, rsp);
+		return N_FAIL;
+	}
+
+	/*
+	 * State response
+	 */
+	rsp =3D rb[rix++];
+	if (rsp !=3D 0x00) {
+		dev_err(&spi->dev, "Failed cmd state response state (%02x)\n",
+			rsp);
+		return N_FAIL;
+	}
+
+	if (cmd =3D=3D CMD_INTERNAL_READ || cmd =3D=3D CMD_SINGLE_READ ||
+	    cmd =3D=3D CMD_DMA_READ || cmd =3D=3D CMD_DMA_EXT_READ) {
+		/*
+		 * Data Respnose header
+		 */
+		retry =3D 100;
+		do {
+			/*
+			 * ensure there is room in buffer later
+			 * to read data and crc
+			 */
+			if (rix < len2) {
+				rsp =3D rb[rix++];
+			} else {
+				retry =3D 0;
+				break;
+			}
+			if (((rsp >> 4) & 0xf) =3D=3D 0xf)
+				break;
+		} while (retry--);
+
+		if (retry <=3D 0) {
+			dev_err(&spi->dev,
+				"Error, data read response (%02x)\n", rsp);
+			return N_RESET;
+		}
+	}
+
+	if (cmd =3D=3D CMD_INTERNAL_READ || cmd =3D=3D CMD_SINGLE_READ) {
+		/*
+		 * Read bytes
+		 */
+		if ((rix + 3) < len2) {
+			b[0] =3D rb[rix++];
+			b[1] =3D rb[rix++];
+			b[2] =3D rb[rix++];
+			b[3] =3D rb[rix++];
+		} else {
+			dev_err(&spi->dev,
+				"buffer overrun when reading data.\n");
+			return N_FAIL;
+		}
+
+		if (!spi_priv->crc_off) {
+			/*
+			 * Read Crc
+			 */
+			if ((rix + 1) < len2) {
+				crc[0] =3D rb[rix++];
+				crc[1] =3D rb[rix++];
+			} else {
+				dev_err(&spi->dev,
+					"buffer overrun when reading crc.\n");
+				return N_FAIL;
+			}
+		}
+	} else if ((cmd =3D=3D CMD_DMA_READ) || (cmd =3D=3D CMD_DMA_EXT_READ)) {
+		int ix;
+
+		/* some data may be read in response to dummy bytes. */
+		for (ix =3D 0; (rix < len2) && (ix < sz); )
+			b[ix++] =3D rb[rix++];
+
+		sz -=3D ix;
+
+		if (sz > 0) {
+			int nbytes;
+
+			if (sz <=3D (DATA_PKT_SZ - ix))
+				nbytes =3D sz;
+			else
+				nbytes =3D DATA_PKT_SZ - ix;
+
+			/*
+			 * Read bytes
+			 */
+			if (wilc_spi_rx(wilc, &b[ix], nbytes)) {
+				dev_err(&spi->dev,
+					"Failed block read, bus err\n");
+				return N_FAIL;
+			}
+
+			/*
+			 * Read Crc
+			 */
+			if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
+				dev_err(&spi->dev,
+					"Failed block crc read, bus err\n");
+				return N_FAIL;
+			}
+
+			ix +=3D nbytes;
+			sz -=3D nbytes;
+		}
+
+		/*
+		 * if any data in left unread,
+		 * then read the rest using normal DMA code.
+		 */
+		while (sz > 0) {
+			int nbytes;
+
+			if (sz <=3D DATA_PKT_SZ)
+				nbytes =3D sz;
+			else
+				nbytes =3D DATA_PKT_SZ;
+
+			/*
+			 * read data response only on the next DMA cycles not
+			 * the first DMA since data response header is already
+			 * handled above for the first DMA.
+			 */
+			/*
+			 * Data Respnose header
+			 */
+			retry =3D 10;
+			do {
+				if (wilc_spi_rx(wilc, &rsp, 1)) {
+					dev_err(&spi->dev,
+						"Failed resp read, bus err\n");
+					result =3D N_FAIL;
+					break;
+				}
+				if (((rsp >> 4) & 0xf) =3D=3D 0xf)
+					break;
+			} while (retry--);
+
+			if (result =3D=3D N_FAIL)
+				break;
+
+			/*
+			 * Read bytes
+			 */
+			if (wilc_spi_rx(wilc, &b[ix], nbytes)) {
+				dev_err(&spi->dev,
+					"Failed block read, bus err\n");
+				result =3D N_FAIL;
+				break;
+			}
+
+			/*
+			 * Read Crc
+			 */
+			if (!spi_priv->crc_off && wilc_spi_rx(wilc, crc, 2)) {
+				dev_err(&spi->dev,
+					"Failed block crc read, bus err\n");
+				result =3D N_FAIL;
+				break;
+			}
+
+			ix +=3D nbytes;
+			sz -=3D nbytes;
+		}
+	}
+	return result;
+}
+
+static int spi_data_write(struct wilc *wilc, u8 *b, u32 sz)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int ix, nbytes;
+	int result =3D 1;
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
+			result =3D N_FAIL;
+			break;
+		}
+
+		/*
+		 * Write data
+		 */
+		if (wilc_spi_tx(wilc, &b[ix], nbytes)) {
+			dev_err(&spi->dev,
+				"Failed data block write, bus error...\n");
+			result =3D N_FAIL;
+			break;
+		}
+
+		/*
+		 * Write Crc
+		 */
+		if (!spi_priv->crc_off) {
+			if (wilc_spi_tx(wilc, crc, 2)) {
+				dev_err(&spi->dev, "Failed data block crc write, bus error...\n");
+				result =3D N_FAIL;
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
+
+static int spi_internal_write(struct wilc *wilc, u32 adr, u32 dat)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	cpu_to_le32s(&dat);
+	result =3D spi_cmd_complete(wilc, CMD_INTERNAL_WRITE, adr, (u8 *)&dat, 4,
+				  0);
+	if (result !=3D N_OK)
+		dev_err(&spi->dev, "Failed internal write cmd...\n");
+
+	return result;
+}
+
+static int spi_internal_read(struct wilc *wilc, u32 adr, u32 *data)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	result =3D spi_cmd_complete(wilc, CMD_INTERNAL_READ, adr, (u8 *)data, 4,
+				  0);
+	if (result !=3D N_OK) {
+		dev_err(&spi->dev, "Failed internal read cmd...\n");
+		return 0;
+	}
+
+	le32_to_cpus(data);
+
+	return 1;
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
+	int result =3D N_OK;
+	u8 cmd =3D CMD_SINGLE_WRITE;
+	u8 clockless =3D 0;
+
+	cpu_to_le32s(&data);
+	if (addr < 0x30) {
+		/* Clockless register */
+		cmd =3D CMD_INTERNAL_WRITE;
+		clockless =3D 1;
+	}
+
+	result =3D spi_cmd_complete(wilc, cmd, addr, (u8 *)&data, 4, clockless);
+	if (result !=3D N_OK)
+		dev_err(&spi->dev, "Failed cmd, write reg (%08x)...\n", addr);
+
+	return result;
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
+		return 0;
+
+	result =3D spi_cmd_complete(wilc, CMD_DMA_EXT_WRITE, addr, NULL, size, 0)=
;
+	if (result !=3D N_OK) {
+		dev_err(&spi->dev,
+			"Failed cmd, write block (%08x)...\n", addr);
+		return 0;
+	}
+
+	/*
+	 * Data
+	 */
+	result =3D spi_data_write(wilc, buf, size);
+	if (result !=3D N_OK)
+		dev_err(&spi->dev, "Failed block data write...\n");
+
+	return 1;
+}
+
+static int wilc_spi_read_reg(struct wilc *wilc, u32 addr, u32 *data)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result =3D N_OK;
+	u8 cmd =3D CMD_SINGLE_READ;
+	u8 clockless =3D 0;
+
+	if (addr < 0x30) {
+		/* Clockless register */
+		cmd =3D CMD_INTERNAL_READ;
+		clockless =3D 1;
+	}
+
+	result =3D spi_cmd_complete(wilc, cmd, addr, (u8 *)data, 4, clockless);
+	if (result !=3D N_OK) {
+		dev_err(&spi->dev, "Failed cmd, read reg (%08x)...\n", addr);
+		return 0;
+	}
+
+	le32_to_cpus(data);
+
+	return 1;
+}
+
+static int wilc_spi_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	int result;
+
+	if (size <=3D 4)
+		return 0;
+
+	result =3D spi_cmd_complete(wilc, CMD_DMA_EXT_READ, addr, buf, size, 0);
+	if (result !=3D N_OK) {
+		dev_err(&spi->dev, "Failed cmd, read block (%08x)...\n", addr);
+		return 0;
+	}
+
+	return 1;
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
+	return 1;
+}
+
+static int wilc_spi_init(struct wilc *wilc, bool resume)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u32 reg;
+	u32 chipid;
+	static int isinit;
+
+	if (isinit) {
+		if (!wilc_spi_read_reg(wilc, 0x1000, &chipid)) {
+			dev_err(&spi->dev, "Fail cmd read chip id...\n");
+			return 0;
+		}
+		return 1;
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
+	if (!spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg)) {
+		/*
+		 * Read failed. Try with CRC off. This might happen when module
+		 * is removed but chip isn't reset
+		 */
+		spi_priv->crc_off =3D 1;
+		dev_err(&spi->dev,
+			"Failed read with CRC on, retrying with CRC off\n");
+		if (!spi_internal_read(wilc, WILC_SPI_PROTOCOL_OFFSET, &reg)) {
+			/*
+			 * Read failed with both CRC on and off,
+			 * something went bad
+			 */
+			dev_err(&spi->dev, "Failed internal read protocol\n");
+			return 0;
+		}
+	}
+	if (spi_priv->crc_off =3D=3D 0) {
+		reg &=3D ~0xc; /* disable crc checking */
+		reg &=3D ~0x70;
+		reg |=3D (0x5 << 4);
+		if (!spi_internal_write(wilc, WILC_SPI_PROTOCOL_OFFSET, reg)) {
+			dev_err(&spi->dev,
+				"[wilc spi %d]: Failed internal write reg\n",
+				__LINE__);
+			return 0;
+		}
+		spi_priv->crc_off =3D 1;
+	}
+
+	/*
+	 * make sure can read back chip id correctly
+	 */
+	if (!wilc_spi_read_reg(wilc, 0x1000, &chipid)) {
+		dev_err(&spi->dev, "Fail cmd read chip id...\n");
+		return 0;
+	}
+
+	spi_priv->has_thrpt_enh =3D 1;
+
+	isinit =3D 1;
+
+	return 1;
+}
+
+static int wilc_spi_read_size(struct wilc *wilc, u32 *size)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int ret;
+
+	if (spi_priv->has_thrpt_enh) {
+		ret =3D spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE,
+					size);
+		*size =3D *size  & IRQ_DMA_WD_CNT_MASK;
+	} else {
+		u32 tmp;
+		u32 byte_cnt;
+
+		ret =3D wilc_spi_read_reg(wilc, WILC_VMM_TO_HOST_SIZE,
+					&byte_cnt);
+		if (!ret) {
+			dev_err(&spi->dev,
+				"Failed read WILC_VMM_TO_HOST_SIZE ...\n");
+			return ret;
+		}
+		tmp =3D (byte_cnt >> 2) & IRQ_DMA_WD_CNT_MASK;
+		*size =3D tmp;
+	}
+
+	return ret;
+}
+
+static int wilc_spi_read_int(struct wilc *wilc, u32 *int_status)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int ret;
+	u32 tmp;
+	u32 byte_cnt;
+	bool unexpected_irq;
+	int j;
+	u32 unknown_mask;
+	u32 irq_flags;
+	int k =3D IRG_FLAGS_OFFSET + 5;
+
+	if (spi_priv->has_thrpt_enh)
+		return spi_internal_read(wilc, 0xe840 - WILC_SPI_REG_BASE,
+					 int_status);
+	ret =3D wilc_spi_read_reg(wilc, WILC_VMM_TO_HOST_SIZE, &byte_cnt);
+	if (!ret) {
+		dev_err(&spi->dev,
+			"Failed read WILC_VMM_TO_HOST_SIZE ...\n");
+		return ret;
+	}
+	tmp =3D (byte_cnt >> 2) & IRQ_DMA_WD_CNT_MASK;
+
+	j =3D 0;
+	do {
+		wilc_spi_read_reg(wilc, 0x1a90, &irq_flags);
+		tmp |=3D ((irq_flags >> 27) << IRG_FLAGS_OFFSET);
+
+		if (spi_priv->nint > 5) {
+			wilc_spi_read_reg(wilc, 0x1a94, &irq_flags);
+			tmp |=3D (((irq_flags >> 0) & 0x7) << k);
+		}
+
+		unknown_mask =3D ~((1ul << spi_priv->nint) - 1);
+
+		unexpected_irq =3D (tmp >> IRG_FLAGS_OFFSET) & unknown_mask;
+		if (unexpected_irq) {
+			dev_err(&spi->dev,
+				"Unexpected interrupt(2):j=3D%d,tmp=3D%x,mask=3D%x\n",
+				j, tmp, unknown_mask);
+		}
+
+		j++;
+	} while (unexpected_irq);
+
+	*int_status =3D tmp;
+
+	return ret;
+}
+
+static int wilc_spi_clear_int_ext(struct wilc *wilc, u32 val)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	int ret;
+	u32 flags;
+	u32 tbl_ctl;
+
+	if (spi_priv->has_thrpt_enh) {
+		return spi_internal_write(wilc, 0xe844 - WILC_SPI_REG_BASE,
+					  val);
+	}
+
+	flags =3D val & (BIT(MAX_NUM_INT) - 1);
+	if (flags) {
+		int i;
+
+		ret =3D 1;
+		for (i =3D 0; i < spi_priv->nint; i++) {
+			/*
+			 * No matter what you write 1 or 0,
+			 * it will clear interrupt.
+			 */
+			if (flags & 1)
+				ret =3D wilc_spi_write_reg(wilc,
+							 0x10c8 + i * 4, 1);
+			if (!ret)
+				break;
+			flags >>=3D 1;
+		}
+		if (!ret) {
+			dev_err(&spi->dev,
+				"Failed wilc_spi_write_reg, set reg %x ...\n",
+				0x10c8 + i * 4);
+			return ret;
+		}
+		for (i =3D spi_priv->nint; i < MAX_NUM_INT; i++) {
+			if (flags & 1)
+				dev_err(&spi->dev,
+					"Unexpected interrupt cleared %d...\n",
+					i);
+			flags >>=3D 1;
+		}
+	}
+
+	tbl_ctl =3D 0;
+	/* select VMM table 0 */
+	if (val & SEL_VMM_TBL0)
+		tbl_ctl |=3D BIT(0);
+	/* select VMM table 1 */
+	if (val & SEL_VMM_TBL1)
+		tbl_ctl |=3D BIT(1);
+
+	ret =3D wilc_spi_write_reg(wilc, WILC_VMM_TBL_CTL, tbl_ctl);
+	if (!ret) {
+		dev_err(&spi->dev, "fail write reg vmm_tbl_ctl...\n");
+		return ret;
+	}
+
+	if (val & EN_VMM) {
+		/*
+		 * enable vmm transfer.
+		 */
+		ret =3D wilc_spi_write_reg(wilc, WILC_VMM_CORE_CTL, 1);
+		if (!ret) {
+			dev_err(&spi->dev, "fail write reg vmm_core_ctl...\n");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static int wilc_spi_sync_ext(struct wilc *wilc, int nint)
+{
+	struct spi_device *spi =3D to_spi_device(wilc->dev);
+	struct wilc_spi *spi_priv =3D wilc->bus_data;
+	u32 reg;
+	int ret, i;
+
+	if (nint > MAX_NUM_INT) {
+		dev_err(&spi->dev, "Too many interrupts (%d)...\n", nint);
+		return 0;
+	}
+
+	spi_priv->nint =3D nint;
+
+	/*
+	 * interrupt pin mux select
+	 */
+	ret =3D wilc_spi_read_reg(wilc, WILC_PIN_MUX_0, &reg);
+	if (!ret) {
+		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+			WILC_PIN_MUX_0);
+		return 0;
+	}
+	reg |=3D BIT(8);
+	ret =3D wilc_spi_write_reg(wilc, WILC_PIN_MUX_0, reg);
+	if (!ret) {
+		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+			WILC_PIN_MUX_0);
+		return 0;
+	}
+
+	/*
+	 * interrupt enable
+	 */
+	ret =3D wilc_spi_read_reg(wilc, WILC_INTR_ENABLE, &reg);
+	if (!ret) {
+		dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+			WILC_INTR_ENABLE);
+		return 0;
+	}
+
+	for (i =3D 0; (i < 5) && (nint > 0); i++, nint--)
+		reg |=3D (BIT((27 + i)));
+
+	ret =3D wilc_spi_write_reg(wilc, WILC_INTR_ENABLE, reg);
+	if (!ret) {
+		dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+			WILC_INTR_ENABLE);
+		return 0;
+	}
+	if (nint) {
+		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		if (!ret) {
+			dev_err(&spi->dev, "Failed read reg (%08x)...\n",
+				WILC_INTR2_ENABLE);
+			return 0;
+		}
+
+		for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
+			reg |=3D BIT(i);
+
+		ret =3D wilc_spi_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+		if (!ret) {
+			dev_err(&spi->dev, "Failed write reg (%08x)...\n",
+				WILC_INTR2_ENABLE);
+			return 0;
+		}
+	}
+
+	return 1;
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
2.7.4

