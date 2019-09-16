Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 49144B4134
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Sep 2019 21:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728178AbfIPThP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 16 Sep 2019 15:37:15 -0400
Received: from esa4.microchip.iphmx.com ([68.232.154.123]:9547 "EHLO
        esa4.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725912AbfIPThP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 16 Sep 2019 15:37:15 -0400
Received-SPF: Pass (esa4.microchip.iphmx.com: domain of
  Adham.Abozaeid@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="Adham.Abozaeid@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa4.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa4.microchip.iphmx.com;
  envelope-from="Adham.Abozaeid@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa4.microchip.iphmx.com; spf=Pass smtp.mailfrom=Adham.Abozaeid@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: d6YhW6hdAqiqVyp28MmfQuxeyHpcCbz687cZgUWAGdMAjnhJz0KPVYPR/boFdvkCRqy6i8VRFV
 ICRny32QUxLWbEP8rtxLz0nBhcw5y7x0TsbS30PKns0d6TV5nQcrk02xJakC09ipcUu1IwQjFP
 0DbN+NNfVNpoz4ERSuChggJqhi4hwKisjdfXtmERHvPayeaJR2BeZkj0B2OiKD5nruH5pspliy
 JDOvRZpJy/+5WOmH/Et/XZz0NkEpoJaUvAQKYC5pP1KuHOiorTZ0Xc/Et2RO1pNaefTUZWVejN
 TpY=
X-IronPort-AV: E=Sophos;i="5.64,513,1559545200"; 
   d="scan'208";a="48120233"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 16 Sep 2019 12:37:14 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 16 Sep 2019 12:37:12 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 16 Sep 2019 12:37:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Hr0r1rA6diokDtYFtYhLrD81U9Pa9+tUuj+p0I2sslHmJeS36w5lJ2bXfULKOJ3/+EepIbO35IllmypO17QuYHVn5/szX3txb2m2cs8zoA4uhxskG1Ar3izPPzqIYWh3PfeNIWYsl1z3+m/PncTIrXsaQlG9nWq4xc13TjG8MlhVjmIVxwC9vsZDJwBTRUECW/y0Cj7wAT/DNqncvWRF+1v4uHKw5HIDEi/F+C3eHUmMWT3sFOU3sOAH7gcTEmCEebucGz2R0hpjzN2eMr3oDhKqBUHUkYvtWQbAgvYqlB/RTz6AukNluL5JrSwour7E8YPHP0G7VG7DOsTSemeBtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJUE6EE48atAEv/KGFArDd7Oj1fACBs0rQAo4rRAEVw=;
 b=SG9Xqp7zXP0tGOFtehvsaKry5vQTXB0ZoFgr9GeYZLHvZ5JWw5z1+dLBcWYaKJP7xhUiiWZWs+k2houlJIdKZ7Ej3Fp4XQ52z6oQoUq551W3u3amDYQPOaIqU2ISMmFAtrwDoWr2cc80i9Orz+/fedzLMAZoAz9SccrZMXjJuWLiVqOqxD4w4QsVo3f81Md5n9zpjsJtg+EntKCeFCEoxxR7yKCCzU+AXTgfgCI8agLhlw/toGnA0YbMttSNBxSe3xYpjS5bE8bBQL3R/GkCwUtuIcz8RrPnVGRxBfgR3pff3waeVvqIvalGGULhxv7TZH2KPD2y5MJQuP9KB1sNfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pJUE6EE48atAEv/KGFArDd7Oj1fACBs0rQAo4rRAEVw=;
 b=b93mfm+sgYHWhZtgIbf180cddZ8JitgVtrMiwuerIrc2qOy0Yjc5YiYaT4vNbDDti79OnGQ5MgAb9DuruLmTyfX5fyTVCVn1/gXAFAzSeXptJ4o2T+m865DgzgSzlcCPTcr6Rs68DDOmlPbMy0L9b8IVieU1L+ghOcoUq9N0WWE=
Received: from CY4PR11MB1366.namprd11.prod.outlook.com (10.169.255.11) by
 CY4PR11MB1254.namprd11.prod.outlook.com (10.169.255.141) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.13; Mon, 16 Sep 2019 19:37:09 +0000
Received: from CY4PR11MB1366.namprd11.prod.outlook.com
 ([fe80::78ba:f834:a390:85ae]) by CY4PR11MB1366.namprd11.prod.outlook.com
 ([fe80::78ba:f834:a390:85ae%10]) with mapi id 15.20.2263.023; Mon, 16 Sep
 2019 19:37:09 +0000
From:   <Adham.Abozaeid@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Ajay.Kathat@microchip.com>,
        <Eugen.Hristev@microchip.com>, <Adham.Abozaeid@microchip.com>
Subject: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Topic: [PATCH] staging: wilc1000: look for rtc_clk clock in spi mode
Thread-Index: AQHVbMYg6jIVhd9+50ifu++xL1vFiQ==
Date:   Mon, 16 Sep 2019 19:37:08 +0000
Message-ID: <20190916193701.20755-1-adham.abozaeid@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [198.175.253.81]
x-clientproxiedby: BYAPR01CA0024.prod.exchangelabs.com (2603:10b6:a02:80::37)
 To CY4PR11MB1366.namprd11.prod.outlook.com (2603:10b6:903:2b::11)
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.17.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a597b3c1-b101-4e3e-4d42-08d73add4330
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600167)(711020)(4605104)(1401327)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:CY4PR11MB1254;
x-ms-traffictypediagnostic: CY4PR11MB1254:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <CY4PR11MB12544780CBCBEF721C9220D28D8C0@CY4PR11MB1254.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0162ACCC24
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(136003)(346002)(39860400002)(376002)(366004)(396003)(199004)(189003)(2616005)(476003)(6436002)(6506007)(86362001)(256004)(386003)(36756003)(52116002)(99286004)(6486002)(102836004)(3846002)(66066001)(14454004)(6116002)(7736002)(2906002)(316002)(6916009)(305945005)(54906003)(5660300002)(1076003)(26005)(71190400001)(8936002)(2351001)(478600001)(71200400001)(64756008)(66446008)(2501003)(66946007)(66556008)(66476007)(8676002)(81166006)(81156014)(486006)(186003)(50226002)(5640700003)(6512007)(25786009)(53936002)(4326008)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:CY4PR11MB1254;H:CY4PR11MB1366.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: i+P1CxopnDMyYIPvAxEur7a4G9lGJ6clfNlpeIpm+QxwGRzIOt9z+h9wacAZ6FYGSnQE/fDhrJM9k+kw+iTRT4AVjhxJVKCPz0WC7HWUPX2aZBOSF1L7Vjf2pQci1cWfXeTP3rgP0HqiTHYarQmbhHAqcEIbdy/TyDnHfoQHP5f+qyxm/oa4+4jOJolGSUXEJscVx6dTnX7OvwBhqe8KXkdJIAYr0eIhH8vhLFbb5LnMMFt/WzQrfNOOrlZwjUBwxTyl1itniKPJ7WEvWV7/7xvQyUbNnKdffp8JnOsbom1gDxsjh1bDqwdlyw8Hs1rjmGmW6VBCJNe7UXfSaj34Z4KERZlBonoJ3TVC8W+8Sr2AhawyUSGiHVlEASt69ZX+8IYesNA4C3mqV5kWqjAL/4jELO2bRy2dKSgRMYEI3EM=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: a597b3c1-b101-4e3e-4d42-08d73add4330
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2019 19:37:08.8955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zz3I+fu5rJleXykKjg9cclMIQkd/wQtHVJEgdlLorfOamwp/L1njabF8L+Mii4cljQ6LOZy8k4nQ/qu+R7yC3zoaUtUoyFA/dijuGVbWPAc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1254
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Adham Abozaeid <adham.abozaeid@microchip.com>

If rtc_clk is provided from DT, use it and enable it.
This is optional.
The signal may be hardcoded and no need to be requested,
but if DT provides it, use it.

Signed-off-by: Adham Abozaeid <adham.abozaeid@microchip.com>
---
 drivers/staging/wilc1000/wilc_spi.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/staging/wilc1000/wilc_spi.c b/drivers/staging/wilc1000=
/wilc_spi.c
index 3c1ae9e9f9aa..166455a969bf 100644
--- a/drivers/staging/wilc1000/wilc_spi.c
+++ b/drivers/staging/wilc1000/wilc_spi.c
@@ -4,6 +4,7 @@
  * All rights reserved.
  */
=20
+#include <linux/clk.h>
 #include <linux/spi/spi.h>
=20
 #include "wilc_wfi_netdevice.h"
@@ -132,6 +133,12 @@ static int wilc_bus_probe(struct spi_device *spi)
 	wilc->bus_data =3D spi_priv;
 	wilc->gpio_irq =3D gpio;
=20
+	wilc->rtc_clk =3D devm_clk_get(&spi->dev, "rtc_clk");
+	if (PTR_ERR_OR_ZERO(wilc->rtc_clk) =3D=3D -EPROBE_DEFER)
+		return -EPROBE_DEFER;
+	else if (!IS_ERR(wilc->rtc_clk))
+		clk_prepare_enable(wilc->rtc_clk);
+
 	return 0;
 }
=20
@@ -142,6 +149,10 @@ static int wilc_bus_remove(struct spi_device *spi)
 	/* free the GPIO in module remove */
 	if (wilc->gpio_irq)
 		gpiod_put(wilc->gpio_irq);
+
+	if (!IS_ERR(wilc->rtc_clk))
+		clk_disable_unprepare(wilc->rtc_clk);
+
 	wilc_netdev_cleanup(wilc);
 	return 0;
 }
--=20
2.17.1

