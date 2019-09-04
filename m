Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14111A848B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2019 15:50:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730378AbfIDNeE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 4 Sep 2019 09:34:04 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:24302 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730372AbfIDNeE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 4 Sep 2019 09:34:04 -0400
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: lCLqNMme6uIG3+gM/x2tSSttw/YZTttPDeNp548+D1uvXU8Rp7wwt13eva8muX7AIy5pNn2wLt
 vVAEeU0HWriDrweUM4TIi78bZPHnEKe4G+/JxrF4wd7oOwV9bSGOk8VVaN1cBrdIdSHVfRK7/W
 oY4ls3AoWCdmSe90GdWjA7ExavZEvapXHV63Kgk66XhTh5mTQSWBZzmEg03/LUMMqaTFYCvhpU
 +VycDI46SvDM48javd+TOBRkqR4jCfPr4pxCGnEkkPGoSJj9vU5uAyiNDAA6KrKFJu+DWh7pXE
 Eck=
X-IronPort-AV: E=Sophos;i="5.64,467,1559545200"; 
   d="scan'208";a="47757053"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Sep 2019 06:34:03 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 4 Sep 2019 06:34:04 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Wed, 4 Sep 2019 06:34:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QpoO9lp5UCtukFrUcIHKNiWHXRHAdVOegGJqd8s7i4W/AvQsg7OJxo4agBU5gVdQOUz/phmEajdgYreAQz0dtDYGv4TtohhlvRI+wjls4I/L6iOKZaRKlwZtZ+qGFSOVJMToc1uHGe+0h9z6aLhgLqGJKa8YhgG7/Fk/Ut4ICsYAsIruOM+t3pxZ7r9i9IB/GZmETwVZGRKeCCTxnOkZKbSamEeBJn0+rC58u1V0lI2cw/QQlQcXQNFp0AcsncMt9oMuP25KBr4Q+kUtRfAib1Brw8DnE9Z1JgvWDLaiBSzOZRCJB4b1LR25MtEy2thNedtsB7WpfPJYpiioigf6Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoHRcMVMOHlD2VYOGr5941LLK6YfhVlGzC9doEyuLk0=;
 b=jML4mX91tJul2QqopFpzkjM0AK5wzsxoQ0Ol1ooicJtdv22OSvimCIF3/lFZA847RUZbZpLj1VPLuy0lbjOTxdMsQGAUGXoU2MwnTxXDM5d8sTaJBuYv/QAL0Xj3+UWS83366T06KwWZK3PoIgBDkya5OQnWZabvO+QiSvptjVMWhRkrr3Fr30jo4On3jozU0pA2BU/Jpcbo8KyWwnB0SjgtKBXblfyoXGy1BFwfqqdH4GnS9l+nG4x5YKatRWoXhPRfJ9/bw2b0RnfIiLwMS/PjNJ6sRpU9yWap/E3CKl4u3JmuqJEM3BwQGo3huWiSRNwORtDzHkasmrTbMGRJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XoHRcMVMOHlD2VYOGr5941LLK6YfhVlGzC9doEyuLk0=;
 b=V4DdyP5x+TwoGxGAHSvq3vpDZG1AXJzwRNmnn3ZLr28qgvD0tuTSal7dIy6oI93HavSXnVoTH3oBp/t3XmRco7MRi1xUIWb20RyDRKwVi96CGYwEB1dzQV7e11SVtyY/YlZ1/hkJqf5vPXQoHQoQgzJNfXHWmJfkMLXeezCIZbg=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1786.namprd11.prod.outlook.com (10.175.91.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 13:34:01 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.014; Wed, 4 Sep 2019
 13:34:01 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <Ajay.Kathat@microchip.com>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>,
        <linux-kernel@vger.kernel.org>
CC:     <Claudiu.Beznea@microchip.com>, <Eugen.Hristev@microchip.com>
Subject: [PATCH 2/2] staging: wilc1000: look for rtc_clk clock
Thread-Topic: [PATCH 2/2] staging: wilc1000: look for rtc_clk clock
Thread-Index: AQHVYyVpLOW1Mruv6EeGi5027BzJDg==
Date:   Wed, 4 Sep 2019 13:34:01 +0000
Message-ID: <1567603548-13355-2-git-send-email-eugen.hristev@microchip.com>
References: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1567603548-13355-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0043.eurprd09.prod.outlook.com
 (2603:10a6:802:28::11) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ae377a61-bf31-4ad0-3bad-08d7313c8c0f
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1786;
x-ms-traffictypediagnostic: DM5PR11MB1786:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1786FF8341002005258D9827E8B80@DM5PR11MB1786.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(376002)(396003)(39860400002)(366004)(136003)(346002)(189003)(199004)(8676002)(99286004)(6486002)(478600001)(110136005)(52116002)(316002)(86362001)(107886003)(2501003)(4326008)(2201001)(3846002)(25786009)(6512007)(6436002)(305945005)(7736002)(53936002)(14454004)(6116002)(54906003)(76176011)(66476007)(66556008)(186003)(66946007)(102836004)(64756008)(256004)(2906002)(26005)(6506007)(66446008)(14444005)(386003)(5660300002)(66066001)(486006)(81166006)(8936002)(476003)(2616005)(71200400001)(11346002)(446003)(50226002)(71190400001)(81156014)(36756003)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1786;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mm34tIVN4xq2NWoe2kM/KyOMS6V6AnLF16DQw1pAznTmqF4kTvOodKODDd07UBcBnWWxaaUSoaqn97Of0o7PMgT1MJ1Gy66woo6vjrNJpQHfVKWPCgncQ/9mu9Cn1VHRiZ8zdAf4IGdKdBlFwuvtvAPnGG+o9eMlonKb05ED2VFjV4dn/8rDOUYXu9sLbNRRDkoBUMixyn4qO4Qz3PsmGWrkjO3Af2SFlshHHHCiT+yKPnS/hifeShlmb18dbRcauBC1f6XwWZKe3hNPHvf95i3ywJn2LpzxkcBtJYCDWKCJ/k1I0NE8MfDWrgxju/YU1FsAKvjZrHGiYp6ISkPcAwEz5PXj7Zp9nFuCwrNPO6AmupBtOswp2mR+xVEKHpx8R/NYro7IV3qrt8SbgiRXZS3XvAcE6ukCicY6guXKqiQ=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: ae377a61-bf31-4ad0-3bad-08d7313c8c0f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 13:34:01.6280
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 4xisQkuMrRRMjq52kJiIDxNMFw78Wfc4HABwCsg4VsdZakyleL4pQY6L5mc/agIO1fJUMwiyl1e+GgW6RYBqT07cJHvfVeYsnzeGt2rsB/o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1786
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Eugen Hristev <eugen.hristev@microchip.com>

If rtc_clk is provided from DT, use it and enable it.
This is optional.
The signal may be hardcoded and no need to be requested,
but if DT provides it, use it.

Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
---
 drivers/staging/wilc1000/wilc_sdio.c          | 14 ++++++++++++++
 drivers/staging/wilc1000/wilc_wfi_netdevice.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/staging/wilc1000/wilc_sdio.c b/drivers/staging/wilc100=
0/wilc_sdio.c
index 4c1c81f..41b69fd 100644
--- a/drivers/staging/wilc1000/wilc_sdio.c
+++ b/drivers/staging/wilc1000/wilc_sdio.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
=20
+#include <linux/clk.h>
 #include <linux/mmc/sdio_func.h>
 #include <linux/mmc/host.h>
=20
@@ -151,6 +152,12 @@ static int wilc_sdio_probe(struct sdio_func *func,
 	wilc->dev =3D &func->dev;
 	wilc->gpio_irq =3D gpio;
=20
+	wilc->rtc_clk =3D devm_clk_get(&func->card->dev, "rtc_clk");
+	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (!IS_ERR(wilc->rtc_clk))
+		clk_prepare_enable(wilc->rtc_clk);
+
 	dev_info(&func->dev, "Driver Initializing success\n");
 	return 0;
 }
@@ -162,6 +169,10 @@ static void wilc_sdio_remove(struct sdio_func *func)
 	/* free the GPIO in module remove */
 	if (wilc->gpio_irq)
 		gpiod_put(wilc->gpio_irq);
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
 	wilc_netdev_cleanup(wilc);
 }
=20
@@ -193,6 +204,9 @@ static int wilc_sdio_suspend(struct device *dev)
 	dev_info(dev, "sdio suspend\n");
 	chip_wakeup(wilc);
=20
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
 	if (!wilc->suspend_event) {
 		wilc_chip_sleep_manually(wilc);
 	} else {
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/wilc_wfi_netdevice.h
index 1e74a08..d8f3ebe 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/wilc_wfi_netdevice.h
@@ -217,6 +217,7 @@ struct wilc {
 	int io_type;
 	s8 mac_status;
 	struct gpio_desc *gpio_irq;
+	struct clk *rtc_clk;
 	bool initialized;
 	int dev_irq_num;
 	int close;
--=20
2.7.4

