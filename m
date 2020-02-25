Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEFB616BB01
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729637AbgBYHlY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:24 -0500
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:27339 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729585AbgBYHlW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:22 -0500
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
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: J1gURbqw24GJFfBjQmCM9q5cvG7gwNQ4wnXQctm1mfxfwlv4spudRrL1ky4N8iuac7TbWukCDu
 jyq6nyxd7keq81przVZp4AsmRpvO2iR4B0jyK25kHVU9pjB7OxsVvmoOrGsR7UEz0C/x+rTAkk
 k7pkDMfuHnjBGd4IM8SPsHNdzm2F+dO13wD/3qXR/h3x6PpIGhRRHXaLWYaFyVxlTnkLW62P2Q
 rGx0tJBFuii7AM5BRtGylZ3CI6nNr/Nx3klrSq3vOFowOgSbeay/EQZjK4XUMm9D1pkV9g/8+i
 CTA=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="65241130"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:21 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:32 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 25 Feb 2020 00:41:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jBvjG9BtYyIk0iT3fOvLvDMaQNGPowhStvgMfXPccWLFvZJME6nK2/s4ZZC/etA+nr2zMecvL5fFkLnAIR3SIrfLf6TG7fOV86pE5iHx3sB8jMvRI2VaoT8Esd3Pkry9DB8Qbh/rSb32NOD5buAOdAl3lsBMj4klg9l/D2vqaxrGnGnEFP++hNpxvRJQp02PToucIrS0BgzhWE8U4gWthIPaPiJx8y2U+CehTCwqyJ0sATiqcz8Mr67ODxnYdJmXqBB+vpFEfkF57OHXaQGP+ABZwvTpWpwKAxP17lw8ZwpqpTFr/jCJ1RpdZ068reHMCHl/igprvrAd0Dp3cnSHOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysFYgW69f3RLX3x8h81oczcPNuXMQIQGipePUaWcSig=;
 b=Ecjbh7yrmtbcrTLnGGPccIZZBHOMLuk2M9jIYeHrZtGX3zAj1vZaPi2RtVQ9Eq9dZc1SVpi6sgqTOdJTaqoL9T9nCa0HJgJyK3/ys9QzsqNhNFrqMlahfsrfrcEPChedE1nPwviuTjaBCQetQEHEqSSWG6++VxOKuHtZs3SrzI7TwPVuct/EeXSVYp9oiWgRZhRMB38vACi95zYOmLAL0zfHSH2DMFtYT7WvFuxRuz5mLPDGA2AXAS7Ujhd8R4rSsQTBxTHT38OGLlDnQPuP73+sPCuNOLPQCRoEAgnxotjhSWVXABS5G1LkUe0VMydjeUXXBn84+dlQUhoBLDRCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ysFYgW69f3RLX3x8h81oczcPNuXMQIQGipePUaWcSig=;
 b=Um2aZ9enZy5zUYVQZMlGyQ7KSvDO7/lFcZemQmd0kYpxu5TsGJEd3/QCAnFrP1Enb1cLNWcbNims6CMIEp7Iw1DuWxqNYMYGBfdWWxymBuNzkMY61/7jMs7Jv1MVBtqQgA4Yz0KiXZUq6jqAoeeWhkrLduVsxp6qD/Jyd7eQa54=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4162.namprd11.prod.outlook.com (2603:10b6:405:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:41:19 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:19 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 14/18] wilc1000: add sdio.c
Thread-Topic: [PATCH v3 14/18] wilc1000: add sdio.c
Thread-Index: AQHV6673dIUtK6bdZkuhWtu13oL72w==
Date:   Tue, 25 Feb 2020 07:41:18 +0000
Message-ID: <20200225074105.7740-15-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: efbf3795-0c71-4e75-db09-08d7b9c61a7d
x-ms-traffictypediagnostic: BN6PR11MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4162A9082E86F6B4684C32CEE3ED0@BN6PR11MB4162.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:13;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(30864003)(81156014)(2616005)(8676002)(186003)(6512007)(6486002)(5660300002)(26005)(81166006)(8936002)(6506007)(54906003)(66476007)(66446008)(66556008)(316002)(86362001)(4326008)(71200400001)(66946007)(6916009)(2906002)(76116006)(64756008)(478600001)(91956017)(1076003)(36756003)(107886003)(579004);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4162;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6Ns14h9+QIqcP/m2eaEv64nsiy1NVf1dg1BXkQWze9/xglb5q+iflBgtkDxkMJIE4N15rgCLSWZnsb8vVYOzh7EVk+gHjjz9wNPylaZaBEIyUqkmVsV7G+aa+BQgP8RMpIx0RGDUktcQMIP5+5kCFhGBG0bjBxITmHfsZrfUPBJvHIaZwuJJTw7kgjNnNxAAy++CF5eQ9wzVy5ihotPzbLxWRQnbU0ZSpydfxoCSu0YZDp92f9N4G1fvgb3U0EAmTdBLCyq6BcXm0tX95fWTWejUsKqgCrbzzh098zfX4v/8teShzjdmFYs6G3g9EQTthkETOhsHaRUp9OPc5TxuoQL9Mz2W6ve8cwrKgR+sQoD7kKO/wWXpNfovPGkxOL9GZwQqlpLx+onLAyA0gd9svTXupp3GV82TPxWJ2kHVr1eRqexS8OndiycugldHDssy
x-ms-exchange-antispam-messagedata: eXgIZBh8CBrBha2WxdJjgVRepZb9THauw2uNmpLYWmM3bOMKTvyR3zoY6+29YoQGv0pti9zF5Ix6danQG2keOByzC6wBfHg4cDPFeesu/EWL1Ap2R6t+zjlu90clsaXmkakPuaULyRGmGcTjv+miMA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: efbf3795-0c71-4e75-db09-08d7b9c61a7d
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:18.7397
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HUWN6edEXyf1wTIyxPNJYWhmzSyUvZxb4jt3mK85jTIIwBlQb+rLrDxAU8pm9+SWGf7HHDDoIagD1KFS2jwJEo6i975q5cUQ6ERIfi4WFlw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4162
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/sdio.c' to
'drivers/net/wireless/microchip/wilc1000/sdio.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 1030 +++++++++++++++++
 1 file changed, 1030 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/sdio.c

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
new file mode 100644
index 000000000000..2301e90c21ca
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -0,0 +1,1030 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2012 - 2018 Microchip Technology Inc., and its subsidiari=
es.
+ * All rights reserved.
+ */
+
+#include <linux/clk.h>
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/host.h>
+#include <linux/mmc/sdio.h>
+
+#include "netdev.h"
+#include "cfg80211.h"
+
+#define SDIO_MODALIAS "wilc1000_sdio"
+
+#define SDIO_VENDOR_ID_WILC 0x0296
+#define SDIO_DEVICE_ID_WILC 0x5347
+
+static const struct sdio_device_id wilc_sdio_ids[] =3D {
+	{ SDIO_DEVICE(SDIO_VENDOR_ID_WILC, SDIO_DEVICE_ID_WILC) },
+	{ },
+};
+
+#define WILC_SDIO_BLOCK_SIZE 512
+
+struct wilc_sdio {
+	bool irq_gpio;
+	u32 block_size;
+	int has_thrpt_enh3;
+};
+
+struct sdio_cmd52 {
+	u32 read_write:		1;
+	u32 function:		3;
+	u32 raw:		1;
+	u32 address:		17;
+	u32 data:		8;
+};
+
+struct sdio_cmd53 {
+	u32 read_write:		1;
+	u32 function:		3;
+	u32 block_mode:		1;
+	u32 increment:		1;
+	u32 address:		17;
+	u32 count:		9;
+	u8 *buffer;
+	u32 block_size;
+};
+
+static const struct wilc_hif_func wilc_hif_sdio;
+
+static void wilc_sdio_interrupt(struct sdio_func *func)
+{
+	sdio_release_host(func);
+	wilc_handle_isr(sdio_get_drvdata(func));
+	sdio_claim_host(func);
+}
+
+static int wilc_sdio_cmd52(struct wilc *wilc, struct sdio_cmd52 *cmd)
+{
+	struct sdio_func *func =3D container_of(wilc->dev, struct sdio_func, dev)=
;
+	int ret;
+	u8 data;
+
+	sdio_claim_host(func);
+
+	func->num =3D cmd->function;
+	if (cmd->read_write) {  /* write */
+		if (cmd->raw) {
+			sdio_writeb(func, cmd->data, cmd->address, &ret);
+			data =3D sdio_readb(func, cmd->address, &ret);
+			cmd->data =3D data;
+		} else {
+			sdio_writeb(func, cmd->data, cmd->address, &ret);
+		}
+	} else {        /* read */
+		data =3D sdio_readb(func, cmd->address, &ret);
+		cmd->data =3D data;
+	}
+
+	sdio_release_host(func);
+
+	if (ret)
+		dev_err(&func->dev, "%s..failed, err(%d)\n", __func__, ret);
+	return ret;
+}
+
+static int wilc_sdio_cmd53(struct wilc *wilc, struct sdio_cmd53 *cmd)
+{
+	struct sdio_func *func =3D container_of(wilc->dev, struct sdio_func, dev)=
;
+	int size, ret;
+
+	sdio_claim_host(func);
+
+	func->num =3D cmd->function;
+	func->cur_blksize =3D cmd->block_size;
+	if (cmd->block_mode)
+		size =3D cmd->count * cmd->block_size;
+	else
+		size =3D cmd->count;
+
+	if (cmd->read_write) {  /* write */
+		ret =3D sdio_memcpy_toio(func, cmd->address,
+				       (void *)cmd->buffer, size);
+	} else {        /* read */
+		ret =3D sdio_memcpy_fromio(func, (void *)cmd->buffer,
+					 cmd->address,  size);
+	}
+
+	sdio_release_host(func);
+
+	if (ret)
+		dev_err(&func->dev, "%s..failed, err(%d)\n", __func__,  ret);
+
+	return ret;
+}
+
+static int wilc_sdio_probe(struct sdio_func *func,
+			   const struct sdio_device_id *id)
+{
+	struct wilc *wilc;
+	int ret;
+	struct gpio_desc *gpio =3D NULL;
+	struct wilc_sdio *sdio_priv;
+
+	sdio_priv =3D kzalloc(sizeof(*sdio_priv), GFP_KERNEL);
+	if (!sdio_priv)
+		return -ENOMEM;
+
+	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
+		gpio =3D gpiod_get(&func->dev, "irq", GPIOD_IN);
+		if (IS_ERR(gpio)) {
+			/* get the GPIO descriptor from hardcode GPIO number */
+			gpio =3D gpio_to_desc(GPIO_NUM);
+			if (!gpio)
+				dev_err(&func->dev, "failed to get irq gpio\n");
+		}
+	}
+
+	ret =3D wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
+				 &wilc_hif_sdio);
+	if (ret) {
+		kfree(sdio_priv);
+		return ret;
+	}
+	sdio_set_drvdata(func, wilc);
+	wilc->bus_data =3D sdio_priv;
+	wilc->dev =3D &func->dev;
+	wilc->gpio_irq =3D gpio;
+
+	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc_clk");
+	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (!IS_ERR(wilc->rtc_clk))
+		clk_prepare_enable(wilc->rtc_clk);
+
+	dev_info(&func->dev, "Driver Initializing success\n");
+	return 0;
+}
+
+static void wilc_sdio_remove(struct sdio_func *func)
+{
+	struct wilc *wilc =3D sdio_get_drvdata(func);
+
+	/* free the GPIO in module remove */
+	if (wilc->gpio_irq)
+		gpiod_put(wilc->gpio_irq);
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
+	wilc_netdev_cleanup(wilc);
+}
+
+static int wilc_sdio_reset(struct wilc *wilc)
+{
+	struct sdio_cmd52 cmd;
+	int ret;
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 0;
+	cmd.address =3D SDIO_CCCR_ABORT;
+	cmd.data =3D WILC_SDIO_CCCR_ABORT_RESET;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, reset cmd ...\n");
+		return ret;
+	}
+	return 0;
+}
+
+static int wilc_sdio_suspend(struct device *dev)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(dev);
+	struct wilc *wilc =3D sdio_get_drvdata(func);
+	int ret;
+
+	dev_info(dev, "sdio suspend\n");
+	chip_wakeup(wilc);
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
+	if (wilc->suspend_event) {
+		host_sleep_notify(wilc);
+		chip_allow_sleep(wilc);
+	}
+
+	ret =3D wilc_sdio_reset(wilc);
+	if (ret) {
+		dev_err(&func->dev, "Fail reset sdio\n");
+		return ret;
+	}
+	sdio_claim_host(func);
+
+	return 0;
+}
+
+static int wilc_sdio_enable_interrupt(struct wilc *dev)
+{
+	struct sdio_func *func =3D container_of(dev->dev, struct sdio_func, dev);
+	int ret =3D 0;
+
+	sdio_claim_host(func);
+	ret =3D sdio_claim_irq(func, wilc_sdio_interrupt);
+	sdio_release_host(func);
+
+	if (ret < 0) {
+		dev_err(&func->dev, "can't claim sdio_irq, err(%d)\n", ret);
+		ret =3D -EIO;
+	}
+	return ret;
+}
+
+static void wilc_sdio_disable_interrupt(struct wilc *dev)
+{
+	struct sdio_func *func =3D container_of(dev->dev, struct sdio_func, dev);
+	int ret;
+
+	sdio_claim_host(func);
+	ret =3D sdio_release_irq(func);
+	if (ret < 0)
+		dev_err(&func->dev, "can't release sdio_irq, err(%d)\n", ret);
+	sdio_release_host(func);
+}
+
+/********************************************
+ *
+ *      Function 0
+ *
+ ********************************************/
+
+static int wilc_sdio_set_func0_csa_address(struct wilc *wilc, u32 adr)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct sdio_cmd52 cmd;
+	int ret;
+
+	/**
+	 *      Review: BIG ENDIAN
+	 **/
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 0;
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG;
+	cmd.data =3D (u8)adr;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
+		return ret;
+	}
+
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG + 1;
+	cmd.data =3D (u8)(adr >> 8);
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
+		return ret;
+	}
+
+	cmd.address =3D WILC_SDIO_FBR_CSA_REG + 2;
+	cmd.data =3D (u8)(adr >> 16);
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int wilc_sdio_set_block_size(struct wilc *wilc, u8 func_num,
+				    u32 block_size)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct sdio_cmd52 cmd;
+	int ret;
+
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 0;
+	cmd.address =3D SDIO_FBR_BASE(func_num) + SDIO_CCCR_BLKSIZE;
+	cmd.data =3D (u8)block_size;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
+		return ret;
+	}
+
+	cmd.address =3D SDIO_FBR_BASE(func_num) + SDIO_CCCR_BLKSIZE +  1;
+	cmd.data =3D (u8)(block_size >> 8);
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Failed cmd52, set %04x data...\n",
+			cmd.address);
+		return ret;
+	}
+
+	return 0;
+}
+
+/********************************************
+ *
+ *      Sdio interfaces
+ *
+ ********************************************/
+static int wilc_sdio_write_reg(struct wilc *wilc, u32 addr, u32 data)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	int ret;
+
+	cpu_to_le32s(&data);
+
+	if (addr >=3D 0xf0 && addr <=3D 0xff) { /* only vendor specific registers=
 */
+		struct sdio_cmd52 cmd;
+
+		cmd.read_write =3D 1;
+		cmd.function =3D 0;
+		cmd.raw =3D 0;
+		cmd.address =3D addr;
+		cmd.data =3D data;
+		ret =3D wilc_sdio_cmd52(wilc, &cmd);
+		if (ret)
+			dev_err(&func->dev,
+				"Failed cmd 52, read reg (%08x) ...\n", addr);
+	} else {
+		struct sdio_cmd53 cmd;
+
+		/**
+		 *      set the AHB address
+		 **/
+		ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+		if (ret)
+			return ret;
+
+		cmd.read_write =3D 1;
+		cmd.function =3D 0;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
+		cmd.block_mode =3D 0;
+		cmd.increment =3D 1;
+		cmd.count =3D 4;
+		cmd.buffer =3D (u8 *)&data;
+		cmd.block_size =3D sdio_priv->block_size;
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret)
+			dev_err(&func->dev,
+				"Failed cmd53, write reg (%08x)...\n", addr);
+	}
+
+	return ret;
+}
+
+static int wilc_sdio_write(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	u32 block_size =3D sdio_priv->block_size;
+	struct sdio_cmd53 cmd;
+	int nblk, nleft, ret;
+
+	cmd.read_write =3D 1;
+	if (addr > 0) {
+		/**
+		 *      func 0 access
+		 **/
+		cmd.function =3D 0;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
+	} else {
+		/**
+		 *      func 1 access
+		 **/
+		cmd.function =3D 1;
+		cmd.address =3D WILC_SDIO_F1_DATA_REG;
+	}
+
+	size =3D ALIGN(size, 4);
+	nblk =3D size / block_size;
+	nleft =3D size % block_size;
+
+	if (nblk > 0) {
+		cmd.block_mode =3D 1;
+		cmd.increment =3D 1;
+		cmd.count =3D nblk;
+		cmd.buffer =3D buf;
+		cmd.block_size =3D block_size;
+		if (addr > 0) {
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
+		}
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd53 [%x], block send...\n", addr);
+			return ret;
+		}
+		if (addr > 0)
+			addr +=3D nblk * block_size;
+		buf +=3D nblk * block_size;
+	}
+
+	if (nleft > 0) {
+		cmd.block_mode =3D 0;
+		cmd.increment =3D 1;
+		cmd.count =3D nleft;
+		cmd.buffer =3D buf;
+
+		cmd.block_size =3D block_size;
+
+		if (addr > 0) {
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
+		}
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd53 [%x], bytes send...\n", addr);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int wilc_sdio_read_reg(struct wilc *wilc, u32 addr, u32 *data)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	int ret;
+
+	if (addr >=3D 0xf0 && addr <=3D 0xff) { /* only vendor specific registers=
 */
+		struct sdio_cmd52 cmd;
+
+		cmd.read_write =3D 0;
+		cmd.function =3D 0;
+		cmd.raw =3D 0;
+		cmd.address =3D addr;
+		ret =3D wilc_sdio_cmd52(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd 52, read reg (%08x) ...\n", addr);
+			return ret;
+		}
+		*data =3D cmd.data;
+	} else {
+		struct sdio_cmd53 cmd;
+
+		ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+		if (ret)
+			return ret;
+
+		cmd.read_write =3D 0;
+		cmd.function =3D 0;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
+		cmd.block_mode =3D 0;
+		cmd.increment =3D 1;
+		cmd.count =3D 4;
+		cmd.buffer =3D (u8 *)data;
+
+		cmd.block_size =3D sdio_priv->block_size;
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd53, read reg (%08x)...\n", addr);
+			return ret;
+		}
+	}
+
+	le32_to_cpus(data);
+	return 0;
+}
+
+static int wilc_sdio_read(struct wilc *wilc, u32 addr, u8 *buf, u32 size)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	u32 block_size =3D sdio_priv->block_size;
+	struct sdio_cmd53 cmd;
+	int nblk, nleft, ret;
+
+	cmd.read_write =3D 0;
+	if (addr > 0) {
+		/**
+		 *      func 0 access
+		 **/
+		cmd.function =3D 0;
+		cmd.address =3D WILC_SDIO_FBR_DATA_REG;
+	} else {
+		/**
+		 *      func 1 access
+		 **/
+		cmd.function =3D 1;
+		cmd.address =3D WILC_SDIO_F1_DATA_REG;
+	}
+
+	size =3D ALIGN(size, 4);
+	nblk =3D size / block_size;
+	nleft =3D size % block_size;
+
+	if (nblk > 0) {
+		cmd.block_mode =3D 1;
+		cmd.increment =3D 1;
+		cmd.count =3D nblk;
+		cmd.buffer =3D buf;
+		cmd.block_size =3D block_size;
+		if (addr > 0) {
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
+		}
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd53 [%x], block read...\n", addr);
+			return ret;
+		}
+		if (addr > 0)
+			addr +=3D nblk * block_size;
+		buf +=3D nblk * block_size;
+	}       /* if (nblk > 0) */
+
+	if (nleft > 0) {
+		cmd.block_mode =3D 0;
+		cmd.increment =3D 1;
+		cmd.count =3D nleft;
+		cmd.buffer =3D buf;
+
+		cmd.block_size =3D block_size;
+
+		if (addr > 0) {
+			ret =3D wilc_sdio_set_func0_csa_address(wilc, addr);
+			if (ret)
+				return ret;
+		}
+		ret =3D wilc_sdio_cmd53(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd53 [%x], bytes read...\n", addr);
+			return ret;
+		}
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
+static int wilc_sdio_deinit(struct wilc *wilc)
+{
+	return 0;
+}
+
+static int wilc_sdio_init(struct wilc *wilc, bool resume)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	struct sdio_cmd52 cmd;
+	int loop, ret;
+	u32 chipid;
+
+	if (!resume)
+		sdio_priv->irq_gpio =3D wilc->dev_irq_num;
+
+	/**
+	 *      function 0 csa enable
+	 **/
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 1;
+	cmd.address =3D SDIO_FBR_BASE(func->num);
+	cmd.data =3D SDIO_FBR_ENABLE_CSA;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, enable csa...\n");
+		return ret;
+	}
+
+	/**
+	 *      function 0 block size
+	 **/
+	ret =3D wilc_sdio_set_block_size(wilc, 0, WILC_SDIO_BLOCK_SIZE);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, set func 0 block size...\n");
+		return ret;
+	}
+	sdio_priv->block_size =3D WILC_SDIO_BLOCK_SIZE;
+
+	/**
+	 *      enable func1 IO
+	 **/
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 1;
+	cmd.address =3D SDIO_CCCR_IOEx;
+	cmd.data =3D WILC_SDIO_CCCR_IO_EN_FUNC1;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev,
+			"Fail cmd 52, set IOE register...\n");
+		return ret;
+	}
+
+	/**
+	 *      make sure func 1 is up
+	 **/
+	cmd.read_write =3D 0;
+	cmd.function =3D 0;
+	cmd.raw =3D 0;
+	cmd.address =3D SDIO_CCCR_IORx;
+	loop =3D 3;
+	do {
+		cmd.data =3D 0;
+		ret =3D wilc_sdio_cmd52(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Fail cmd 52, get IOR register...\n");
+			return ret;
+		}
+		if (cmd.data =3D=3D WILC_SDIO_CCCR_IO_EN_FUNC1)
+			break;
+	} while (loop--);
+
+	if (loop <=3D 0) {
+		dev_err(&func->dev, "Fail func 1 is not ready...\n");
+		return -EINVAL;
+	}
+
+	/**
+	 *      func 1 is ready, set func 1 block size
+	 **/
+	ret =3D wilc_sdio_set_block_size(wilc, 1, WILC_SDIO_BLOCK_SIZE);
+	if (ret) {
+		dev_err(&func->dev, "Fail set func 1 block size...\n");
+		return ret;
+	}
+
+	/**
+	 *      func 1 interrupt enable
+	 **/
+	cmd.read_write =3D 1;
+	cmd.function =3D 0;
+	cmd.raw =3D 1;
+	cmd.address =3D SDIO_CCCR_IENx;
+	cmd.data =3D WILC_SDIO_CCCR_IEN_MASTER | WILC_SDIO_CCCR_IEN_FUNC1;
+	ret =3D wilc_sdio_cmd52(wilc, &cmd);
+	if (ret) {
+		dev_err(&func->dev, "Fail cmd 52, set IEN register...\n");
+		return ret;
+	}
+
+	/**
+	 *      make sure can read back chip id correctly
+	 **/
+	if (!resume) {
+		int rev;
+
+		ret =3D wilc_sdio_read_reg(wilc, WILC_CHIPID, &chipid);
+		if (ret) {
+			dev_err(&func->dev, "Fail cmd read chip id...\n");
+			return ret;
+		}
+		dev_err(&func->dev, "chipid (%08x)\n", chipid);
+		rev =3D FIELD_GET(WILC_CHIP_REV_FIELD, chipid);
+		if (rev > FIELD_GET(WILC_CHIP_REV_FIELD, WILC_1000_BASE_ID_2A))
+			sdio_priv->has_thrpt_enh3 =3D 1;
+		else
+			sdio_priv->has_thrpt_enh3 =3D 0;
+		dev_info(&func->dev, "has_thrpt_enh3 =3D %d...\n",
+			 sdio_priv->has_thrpt_enh3);
+	}
+
+	return 0;
+}
+
+static int wilc_sdio_read_size(struct wilc *wilc, u32 *size)
+{
+	u32 tmp;
+	struct sdio_cmd52 cmd;
+
+	/**
+	 *      Read DMA count in words
+	 **/
+	cmd.read_write =3D 0;
+	cmd.function =3D 0;
+	cmd.raw =3D 0;
+	cmd.address =3D WILC_SDIO_INTERRUPT_DATA_SZ_REG;
+	cmd.data =3D 0;
+	wilc_sdio_cmd52(wilc, &cmd);
+	tmp =3D cmd.data;
+
+	cmd.address =3D WILC_SDIO_INTERRUPT_DATA_SZ_REG + 1;
+	cmd.data =3D 0;
+	wilc_sdio_cmd52(wilc, &cmd);
+	tmp |=3D (cmd.data << 8);
+
+	*size =3D tmp;
+	return 0;
+}
+
+static int wilc_sdio_read_int(struct wilc *wilc, u32 *int_status)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	u32 tmp;
+	u8 irq_flags;
+	struct sdio_cmd52 cmd;
+
+	wilc_sdio_read_size(wilc, &tmp);
+
+	/**
+	 *      Read IRQ flags
+	 **/
+	if (!sdio_priv->irq_gpio) {
+		cmd.function =3D 1;
+		cmd.address =3D WILC_SDIO_EXT_IRQ_FLAG_REG;
+	} else {
+		cmd.function =3D 0;
+		cmd.address =3D WILC_SDIO_IRQ_FLAG_REG;
+	}
+	cmd.raw =3D 0;
+	cmd.read_write =3D 0;
+	cmd.data =3D 0;
+	wilc_sdio_cmd52(wilc, &cmd);
+	irq_flags =3D cmd.data;
+	tmp |=3D FIELD_PREP(IRG_FLAGS_MASK, cmd.data);
+
+	if (FIELD_GET(UNHANDLED_IRQ_MASK, irq_flags))
+		dev_err(&func->dev, "Unexpected interrupt (1) int=3D%lx\n",
+			FIELD_GET(UNHANDLED_IRQ_MASK, irq_flags));
+
+	*int_status =3D tmp;
+
+	return 0;
+}
+
+static int wilc_sdio_clear_int_ext(struct wilc *wilc, u32 val)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	int ret;
+	int vmm_ctl;
+
+	if (sdio_priv->has_thrpt_enh3) {
+		u32 reg =3D 0;
+
+		if (sdio_priv->irq_gpio)
+			reg =3D val & (BIT(MAX_NUM_INT) - 1);
+
+		/* select VMM table 0 */
+		if (val & SEL_VMM_TBL0)
+			reg |=3D BIT(5);
+		/* select VMM table 1 */
+		if (val & SEL_VMM_TBL1)
+			reg |=3D BIT(6);
+		/* enable VMM */
+		if (val & EN_VMM)
+			reg |=3D BIT(7);
+		if (reg) {
+			struct sdio_cmd52 cmd;
+
+			cmd.read_write =3D 1;
+			cmd.function =3D 0;
+			cmd.raw =3D 0;
+			cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
+			cmd.data =3D reg;
+
+			ret =3D wilc_sdio_cmd52(wilc, &cmd);
+			if (ret) {
+				dev_err(&func->dev,
+					"Failed cmd52, set (%02x) data (%d) ...\n",
+					cmd.address, __LINE__);
+				return ret;
+			}
+		}
+		return 0;
+	}
+	if (sdio_priv->irq_gpio) {
+		/* has_thrpt_enh2 uses register 0xf8 to clear interrupts. */
+		/*
+		 * Cannot clear multiple interrupts.
+		 * Must clear each interrupt individually.
+		 */
+		u32 flags;
+		int i;
+
+		flags =3D val & (BIT(MAX_NUM_INT) - 1);
+		for (i =3D 0; i < NUM_INT_EXT && flags; i++) {
+			if (flags & BIT(i)) {
+				struct sdio_cmd52 cmd;
+
+				cmd.read_write =3D 1;
+				cmd.function =3D 0;
+				cmd.raw =3D 0;
+				cmd.address =3D WILC_SDIO_IRQ_CLEAR_FLAG_REG;
+				cmd.data =3D BIT(i);
+
+				ret =3D wilc_sdio_cmd52(wilc, &cmd);
+				if (ret) {
+					dev_err(&func->dev,
+						"Failed cmd52, set (%02x) data (%d) ...\n",
+						cmd.address, __LINE__);
+					return ret;
+				}
+				flags &=3D ~BIT(i);
+			}
+		}
+
+		for (i =3D NUM_INT_EXT; i < MAX_NUM_INT && flags; i++) {
+			if (flags & BIT(i)) {
+				dev_err(&func->dev,
+					"Unexpected interrupt cleared %d...\n",
+					i);
+				flags &=3D ~BIT(i);
+			}
+		}
+	}
+
+	vmm_ctl =3D 0;
+	/* select VMM table 0 */
+	if (val & SEL_VMM_TBL0)
+		vmm_ctl |=3D BIT(0);
+	/* select VMM table 1 */
+	if (val & SEL_VMM_TBL1)
+		vmm_ctl |=3D BIT(1);
+	/* enable VMM */
+	if (val & EN_VMM)
+		vmm_ctl |=3D BIT(2);
+
+	if (vmm_ctl) {
+		struct sdio_cmd52 cmd;
+
+		cmd.read_write =3D 1;
+		cmd.function =3D 0;
+		cmd.raw =3D 0;
+		cmd.address =3D WILC_SDIO_VMM_TBL_CTRL_REG;
+		cmd.data =3D vmm_ctl;
+		ret =3D wilc_sdio_cmd52(wilc, &cmd);
+		if (ret) {
+			dev_err(&func->dev,
+				"Failed cmd52, set (%02x) data (%d) ...\n",
+				cmd.address, __LINE__);
+			return ret;
+		}
+	}
+	return 0;
+}
+
+static int wilc_sdio_sync_ext(struct wilc *wilc, int nint)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(wilc->dev);
+	struct wilc_sdio *sdio_priv =3D wilc->bus_data;
+	u32 reg;
+
+	if (nint > MAX_NUM_INT) {
+		dev_err(&func->dev, "Too many interrupts (%d)...\n", nint);
+		return -EINVAL;
+	}
+
+	/**
+	 *      Disable power sequencer
+	 **/
+	if (wilc_sdio_read_reg(wilc, WILC_MISC, &reg)) {
+		dev_err(&func->dev, "Failed read misc reg...\n");
+		return -EINVAL;
+	}
+
+	reg &=3D ~BIT(8);
+	if (wilc_sdio_write_reg(wilc, WILC_MISC, reg)) {
+		dev_err(&func->dev, "Failed write misc reg...\n");
+		return -EINVAL;
+	}
+
+	if (sdio_priv->irq_gpio) {
+		u32 reg;
+		int ret, i;
+
+		/**
+		 *      interrupt pin mux select
+		 **/
+		ret =3D wilc_sdio_read_reg(wilc, WILC_PIN_MUX_0, &reg);
+		if (ret) {
+			dev_err(&func->dev, "Failed read reg (%08x)...\n",
+				WILC_PIN_MUX_0);
+			return ret;
+		}
+		reg |=3D BIT(8);
+		ret =3D wilc_sdio_write_reg(wilc, WILC_PIN_MUX_0, reg);
+		if (ret) {
+			dev_err(&func->dev, "Failed write reg (%08x)...\n",
+				WILC_PIN_MUX_0);
+			return ret;
+		}
+
+		/**
+		 *      interrupt enable
+		 **/
+		ret =3D wilc_sdio_read_reg(wilc, WILC_INTR_ENABLE, &reg);
+		if (ret) {
+			dev_err(&func->dev, "Failed read reg (%08x)...\n",
+				WILC_INTR_ENABLE);
+			return ret;
+		}
+
+		for (i =3D 0; (i < 5) && (nint > 0); i++, nint--)
+			reg |=3D BIT((27 + i));
+		ret =3D wilc_sdio_write_reg(wilc, WILC_INTR_ENABLE, reg);
+		if (ret) {
+			dev_err(&func->dev, "Failed write reg (%08x)...\n",
+				WILC_INTR_ENABLE);
+			return ret;
+		}
+		if (nint) {
+			ret =3D wilc_sdio_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+			if (ret) {
+				dev_err(&func->dev,
+					"Failed read reg (%08x)...\n",
+					WILC_INTR2_ENABLE);
+				return ret;
+			}
+
+			for (i =3D 0; (i < 3) && (nint > 0); i++, nint--)
+				reg |=3D BIT(i);
+
+			ret =3D wilc_sdio_read_reg(wilc, WILC_INTR2_ENABLE, &reg);
+			if (ret) {
+				dev_err(&func->dev,
+					"Failed write reg (%08x)...\n",
+					WILC_INTR2_ENABLE);
+				return ret;
+			}
+		}
+	}
+	return 0;
+}
+
+/* Global sdio HIF function table */
+static const struct wilc_hif_func wilc_hif_sdio =3D {
+	.hif_init =3D wilc_sdio_init,
+	.hif_deinit =3D wilc_sdio_deinit,
+	.hif_read_reg =3D wilc_sdio_read_reg,
+	.hif_write_reg =3D wilc_sdio_write_reg,
+	.hif_block_rx =3D wilc_sdio_read,
+	.hif_block_tx =3D wilc_sdio_write,
+	.hif_read_int =3D wilc_sdio_read_int,
+	.hif_clear_int_ext =3D wilc_sdio_clear_int_ext,
+	.hif_read_size =3D wilc_sdio_read_size,
+	.hif_block_tx_ext =3D wilc_sdio_write,
+	.hif_block_rx_ext =3D wilc_sdio_read,
+	.hif_sync_ext =3D wilc_sdio_sync_ext,
+	.enable_interrupt =3D wilc_sdio_enable_interrupt,
+	.disable_interrupt =3D wilc_sdio_disable_interrupt,
+};
+
+static int wilc_sdio_resume(struct device *dev)
+{
+	struct sdio_func *func =3D dev_to_sdio_func(dev);
+	struct wilc *wilc =3D sdio_get_drvdata(func);
+
+	dev_info(dev, "sdio resume\n");
+	sdio_release_host(func);
+	chip_wakeup(wilc);
+	wilc_sdio_init(wilc, true);
+
+	if (wilc->suspend_event)
+		host_wakeup_notify(wilc);
+
+	chip_allow_sleep(wilc);
+
+	return 0;
+}
+
+static const struct of_device_id wilc_of_match[] =3D {
+	{ .compatible =3D "microchip,wilc1000-sdio", },
+	{ /* sentinel */ }
+};
+MODULE_DEVICE_TABLE(of, wilc_of_match);
+
+static const struct dev_pm_ops wilc_sdio_pm_ops =3D {
+	.suspend =3D wilc_sdio_suspend,
+	.resume =3D wilc_sdio_resume,
+};
+
+static struct sdio_driver wilc_sdio_driver =3D {
+	.name		=3D SDIO_MODALIAS,
+	.id_table	=3D wilc_sdio_ids,
+	.probe		=3D wilc_sdio_probe,
+	.remove		=3D wilc_sdio_remove,
+	.drv =3D {
+		.pm =3D &wilc_sdio_pm_ops,
+		.of_match_table =3D wilc_of_match,
+	}
+};
+module_driver(wilc_sdio_driver,
+	      sdio_register_driver,
+	      sdio_unregister_driver);
+MODULE_LICENSE("GPL");
--=20
2.24.0
