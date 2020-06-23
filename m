Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE54204FDC
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732443AbgFWLAt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:49 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:50065 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732205AbgFWLAV (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910019; x=1624446019;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=SAb8jMvzvPNA3Hf9f8AQNDpbIUrM32cF1MuLL3qdP3s=;
  b=fk+BS0cibiV7yqn2vTiPBVO4LxD8EjNBj5Ed4TWEQ515gsV9Rg1zImb8
   6bWe+obzUAkHnrP+ubwTF77x8r6BpsY5TGuByytYHTJG8xVmLT3e6NrNY
   8P5j08lQlDFGaco+2Q9aVuc2kE4Ma+2AWPQaZe7mIR4KZkK44EYv1HhX/
   8zt2FudbXcLKhf0+Zja88MwvIr6rqNC7nRvICUUa/I7119462zhT1KZYB
   ZU3U25I86aLHIYFym0cQud6pBWM3qnr/gb8R1bOQrwwVMU4ft9+EyRwXh
   bJcnzMUH7vPTHCV0HoVnsLoCO7N1a9VHEXYujOMn8nB+v5iudSL+28og4
   w==;
IronPort-SDR: kmrN2umDeZihsOuxc7BIVCgYKdRl1Ka2J449KiKcacwneXcWCE3BgaXvOmoRSOmzktFxb8equ3
 ibi2crrTYqi8R/AfrOgHOw7gkDs3NCIAIhd68G7tXDxdV8N0t/eUaJULKND/9HrXSeXHl/H8Bh
 5NXMf85TYvSfqFglqKP98yU3DD3gSiKzMTprHQyXt7GxIH0sL+qrRkafFUHCDm3dmriE1iRPt6
 SlfURnphd77S6z6NdxVrMq4hzmvfzCR5inIMmzmAOuczcvjeIaHfCPSto2Vqq5TTN/BQ5jr+/W
 4Lk=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="16737474"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:18 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 04:00:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 04:00:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NEjdd9Lu820YDpwTzhsWZPidExUWwTp2ZaDFSfh5rALcHd31HQISl90zNEQ8Cehb5092z4fzJMZGq3u6GRYjWVS3I96GigzQnj3Uanp2m/zsRa8MOsQTZqVLKS1VIpBiS1XjZboqJRhy3yXSpIYKRkIZ+ZcFdgt1iEXqVmgTZTmD4ZufBRlzUpUBHgaVj+GdMyZnD0rfnVgnjLRCWMPfKfC3gn0mNlChWFP3vOaDjRVyi8fEtNIQSbwZiBdRfdnTr146koCCtlsPbRzMtqIyJa8DyorHvtSrgHTZCpXidEgpmUZZd1fPC763zg1bsvtLKJ413I8Ews2HMDe/rrUkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y3dRx7lty2J5gZu8DU1YXgIthh1ObPT+WLB9M2bTRw=;
 b=I03XhJFZe8nXy5DvgpJIXM6mWWx30ExEGw4OzZOntm9+uEu6LZir2p2a2tNYFGjJnXkqRVmVQewUF9iDH7a7PhfWmqeh8JLMyShbMO3lsrFMvBtvspm+h4yhJQwuE9UEj9k5o6MlrV2BHxr7C+TngGOL2yHJFbP3T6lEzEupTYgiddd7Tg68Xu/2Itesc9vz678Ww6BDT3WLJq9LLHg2SRe/DKi28bGsDBI9GZ2g2598pwPqKpIkE+1uFJKDLbqwXQtPOqHudVjYn6t/lRb8l80jcwBZY3EHQBE0HWhi85C0lMVADGkF45qejYoGTcsRy+axC4feqtmGkfwfBDjf8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Y3dRx7lty2J5gZu8DU1YXgIthh1ObPT+WLB9M2bTRw=;
 b=T1UMX9KS0IytNy15dMMMA+0Atoc50n5cS9/p3LBptIPNatYehzZn+AeqnFy/eOOpHTAOu0DqGNEhHiBcQxUuFyYEo1+9GLZI8qtJ8bf84SvTuGffSKy8PEhXV23IucYQc7JVgPRmInlPdJqQv6cds2cthbIGSXgVLbfyOZwzij8=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:13 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:13 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 14/17] wilc1000: add sdio.c
Thread-Topic: [PATCH v7 14/17] wilc1000: add sdio.c
Thread-Index: AQHWSU14uL44G6no9kiASAhfLT0LsQ==
Date:   Tue, 23 Jun 2020 11:00:13 +0000
Message-ID: <20200623110000.31559-15-ajay.kathat@microchip.com>
References: <20200623110000.31559-1-ajay.kathat@microchip.com>
In-Reply-To: <20200623110000.31559-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none
 header.from=microchip.com;
x-originating-ip: [49.207.200.183]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b9c01701-f609-4b5f-ce5a-08d817649ac6
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB3551871BDBC2F4A4AE032F20E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:8;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: nWMb2TSZNiA4fIWktHRzDRNNGrgfatsNwW+aBnEZTp6Fe2yMFNZrpKB5AbgUSw1Ufgb8wi3KFqtEf6OwuOUuNc2w6yknvqvkyGP96jfJukzUmOUZbbxAY8FHmn1nWCyweE+FXwz+pqoawW6NSGFAdoHVuo5KX9K+XHh81sTkHHgsBD7UkVnWJUjMGoulcSxrDufarUwhxJ9GcJolnPyNV3Yy7HVVP7H8vwBbuhFM1doFYNzQNOSZos95uYyJoC6aBBpS/q6damiew3QMkqjEntQ2Icdcs295pxdtanEm61jfjnWIUKbYJyJwDmkKMRrWckm4vd2DaaRBMjxMg5rPxQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(30864003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002)(579004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: BIbsphqw67MApDHcuaDS1TBauiqjQI8oA8EnUxur2kUXqxAkwUYaylU/kliLidCJULZfTDhysOt5tKK+JdyZLKXvb4KDYpBNu+5sMCtJu4AtC/z9lCr8599b2o3VI68rOwdGiogRCtQzOUOiGAIvBg74USDB6z2RbyuJUzUjor7FpjhW7plad8e4zqhtH6h2rkoSeETJ/5XOkUGHm1pZe/92WsomNBDDY4p1CTbeWN581awywZaHqefewKO6KfBu+aNuZd42kQKu1yMQHDbHDKg/+s7E3yzoaJCZULzThGhyQBDAzKfgBpX+zbT66aKdwCMgBnNPMXBBrMBDC1kjzhG9c2gHwl6Z5puqus4sDh07nJvml29z2V8g+nFJHhRG3+rCnvE6LbKaN3+fPOYHDOW3Fj2T718sp2M2uyxsmQJxKsvPRUQQVA47Y24k1/Hq6n+h7K886HbFIanbGWMrxWP3h2yhdwTwklZz2uHfn96XUhpnIIq02fFQk9nTjDs4
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: b9c01701-f609-4b5f-ce5a-08d817649ac6
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:13.2284
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MC2QVKE2DyqPZaCF7ZMihbbC+izyk+dcmQqSd9W69ykCZOrPvD8e4uy/e3gsSkWNfA31WNIDt0bvhYBdGANAPbdWB9Hni82T+6uiOu/VAGM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Moved 'drivers/staging/wilc1000/sdio.c' to
'drivers/net/wireless/microchip/wilc1000/sdio.c'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 .../net/wireless/microchip/wilc1000/sdio.c    | 1023 +++++++++++++++++
 1 file changed, 1023 insertions(+)
 create mode 100644 drivers/net/wireless/microchip/wilc1000/sdio.c

diff --git a/drivers/net/wireless/microchip/wilc1000/sdio.c b/drivers/net/w=
ireless/microchip/wilc1000/sdio.c
new file mode 100644
index 000000000000..36eb589263bf
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/sdio.c
@@ -0,0 +1,1023 @@
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
+#include <linux/of_irq.h>
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
+	struct wilc_sdio *sdio_priv;
+
+	sdio_priv =3D kzalloc(sizeof(*sdio_priv), GFP_KERNEL);
+	if (!sdio_priv)
+		return -ENOMEM;
+
+	ret =3D wilc_cfg80211_init(&wilc, &func->dev, WILC_HIF_SDIO,
+				 &wilc_hif_sdio);
+	if (ret) {
+		kfree(sdio_priv);
+		return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_WILC1000_HW_OOB_INTR)) {
+		struct device_node *np =3D func->card->dev.of_node;
+		int irq_num =3D of_irq_get(np, 0);
+
+		if (irq_num > 0) {
+			wilc->dev_irq_num =3D irq_num;
+			sdio_priv->irq_gpio =3D true;
+		}
+	}
+
+	sdio_set_drvdata(func, wilc);
+	wilc->bus_data =3D sdio_priv;
+	wilc->dev =3D &func->dev;
+
+	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc");
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
+	{ .compatible =3D "microchip,wilc1000", },
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
