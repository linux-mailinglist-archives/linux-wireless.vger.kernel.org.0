Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ABB86ADAE7
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2019 16:13:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405292AbfIIOMe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 9 Sep 2019 10:12:34 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:1496 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405252AbfIIOMd (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 9 Sep 2019 10:12:33 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Eugen.Hristev@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="Eugen.Hristev@microchip.com";
  x-conformance=spf_only; x-record-type="v=spf1";
  x-record-text="v=spf1 mx a:ushub1.microchip.com
  a:smtpout.microchip.com a:mx1.microchip.iphmx.com
  a:mx2.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Eugen.Hristev@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Eugen.Hristev@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: 0fu/paoIoLMVP7AU65SxSw/DN6bchkn9BecuGlGqslUmHZAHVAOAc/U/bz3/3UlbbD9zkvQcm7
 +DCwuRFts7Eo6Ahfqb3jrwLdJTaz4vAr1VrOkxk8GmtI3LFUzX3fr0f6N4wcuHqxdJem75v8BE
 dkIj8TAHCzJX+5/wleFntL6AP5Ji0BFN8xO3oeN55IogRR985ls7RYrNdVuJpDGnOJbGnFeW95
 BQMiiSJI2UZnPdYTNakzbsVXj4Zf5iqN1C+e/rpyA5gelLfFqbB0fXHwuUt/o9ECwjg20aRC6+
 /QM=
X-IronPort-AV: E=Sophos;i="5.64,484,1559545200"; 
   d="scan'208";a="45418043"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Sep 2019 07:12:31 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 9 Sep 2019 07:12:31 -0700
Received: from NAM01-SN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Mon, 9 Sep 2019 07:12:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MOPGqFe+jBqLoBJPfSfbYpNQj4uwimC63eUTmQkttYoi+t2Vh+L/AQtzO51upqWNjZ7g7CZi6pH07/dwXwtGqxR6tULrPnp7tOszHZMfQ6tKpqyjXESiB1HzCwVLZNdjhDak5dDLisDuy2AgPreXMaFJX/cK+flqjrWrcteVnTzYzgpSN+NcWSS5wstzrdO6atIo/0k/uzbPUwRMkkN/FnSk9vgAvTsh3koOntIn7LRQGZDBtkjK4tYgri63OeW5vCd6qtVE0w1itd41X26h8U6EhnwBEf39lrRdLqfGuh3UpAEPwkN5fT/AxTqUUj2MXT2LSaEeidC3iYZRe5dUDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QIZJ54sZgHR+KxPxkQiUF2fC2iVOqjOTvkQHZ7kBc=;
 b=hPH87+/Wg9Tqp8HH9z/ZARKuqJDIhXnK6DIgBm5iM/HzlORzqyMUG9AyoWk9M+UQp+RjMlfOGkXf+trgW69HDo5P4cmsvoaP2tNw1dP581Vl8XRWkUmYH6WALHMSNoMSwTSsDKtTNpFhxPGDn067mC1AU4WQ0mOzFKHt3rzFZkvz/u5wyyalD5peyrdkQwdNUtzvv7FcpCAJb4AkvmT4hD0CBD8Ljwx5G4JoOMp7L8A07V1O+5W3SkZH+452k1fWY0aTziOehS3tmwxuKexSBj8Z5OpCEh0RWh9+m6NoQIFMKjQ9M7uyNv5g35Ib/vHg6NKFqtWj9NrkkPk98pHcYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=T1QIZJ54sZgHR+KxPxkQiUF2fC2iVOqjOTvkQHZ7kBc=;
 b=bYGXKmwOIjr/N/E1/TONxLbH0es1Y9+sWyWKxmnGz8G4A4WJqUOazPinhNNQTs2fwvv+WHJRH4OJZ1/ILbz/ObFnCYCi1D/bCTIj+xvDh0N6XtZ2ZqLbX8WK2ZtKaWVuOWlKbY35iBCTt3VTmfbVwB/ELoC5V2qHJ7KIs9jr8As=
Received: from DM5PR11MB1242.namprd11.prod.outlook.com (10.168.108.8) by
 DM5PR11MB1596.namprd11.prod.outlook.com (10.172.37.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2241.18; Mon, 9 Sep 2019 14:12:30 +0000
Received: from DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2]) by DM5PR11MB1242.namprd11.prod.outlook.com
 ([fe80::a141:1974:9668:fbe2%12]) with mapi id 15.20.2241.018; Mon, 9 Sep 2019
 14:12:30 +0000
From:   <Eugen.Hristev@microchip.com>
To:     <Adham.Abozaeid@microchip.com>, <Ajay.Kathat@microchip.com>,
        <gregkh@linuxfoundation.org>, <linux-wireless@vger.kernel.org>,
        <devel@driverdev.osuosl.org>, <linux-kernel@vger.kernel.org>
CC:     <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <Eugen.Hristev@microchip.com>
Subject: [PATCH v2 2/2] staging: wilc1000: look for rtc_clk clock
Thread-Topic: [PATCH v2 2/2] staging: wilc1000: look for rtc_clk clock
Thread-Index: AQHVZxidJg0uPq4NhUukllBtOHKh4Q==
Date:   Mon, 9 Sep 2019 14:12:29 +0000
Message-ID: <1568037993-4646-2-git-send-email-eugen.hristev@microchip.com>
References: <1568037993-4646-1-git-send-email-eugen.hristev@microchip.com>
In-Reply-To: <1568037993-4646-1-git-send-email-eugen.hristev@microchip.com>
Accept-Language: en-US, ro-RO
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: VI1PR09CA0080.eurprd09.prod.outlook.com
 (2603:10a6:802:29::24) To DM5PR11MB1242.namprd11.prod.outlook.com
 (2603:10b6:3:14::8)
x-mailer: git-send-email 2.7.4
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [94.177.32.156]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1e9d70e2-9e4f-422f-c910-08d7352fbfdf
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:DM5PR11MB1596;
x-ms-traffictypediagnostic: DM5PR11MB1596:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DM5PR11MB1596D7C867618849E2623E7FE8B70@DM5PR11MB1596.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 01559F388D
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(346002)(376002)(39860400002)(199004)(189003)(2501003)(3846002)(6116002)(4326008)(11346002)(446003)(81166006)(50226002)(186003)(26005)(8936002)(2616005)(476003)(486006)(71200400001)(71190400001)(81156014)(8676002)(66476007)(66556008)(64756008)(66446008)(25786009)(7736002)(66066001)(66946007)(305945005)(102836004)(6506007)(386003)(5660300002)(316002)(99286004)(54906003)(110136005)(14454004)(256004)(14444005)(36756003)(2906002)(6436002)(107886003)(2201001)(53936002)(86362001)(6512007)(52116002)(76176011)(478600001)(6486002);DIR:OUT;SFP:1101;SCL:1;SRVR:DM5PR11MB1596;H:DM5PR11MB1242.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7l8ZnS4P6DUicBtCMgdgTfIZknoUv6IDShDEt2cIRoTDh3TiDryy/oTzjNDwVBUlhmhx1P1qPUWZE5rCKbrIvmASEnzgHtXX9XCtrTMm0Hl+fPgGbf/Rw2ORcLn8BeCqr67jC/HvPioHKSV/DzcxQJIv2l1ey7Y873FWWTmA3eTOiusxvJTqYqeew74hd+37nEI+z4EQK5AGJZtbJU9Q8JbahaDPWwTKWDFQuB8redkf7NrnYT/FRcOfG62iM8U85ZQpGP3psCElfrkwZZJxFR0tIU+uQdzFNXG2STmDc/pwkkvWgpMSETgM1nWrZ3oUQ4gGGFYbqbhBC7yXLsgwEuAt94tSk49I3AtLFWeqbnYQmBQbRk7pNW5cBzHXrHeIQm8HL2LEs13sFKakhGu8KV04AyhWt4afaexBZlPKp9k=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e9d70e2-9e4f-422f-c910-08d7352fbfdf
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2019 14:12:29.9551
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: psCpZW6xuXP7OZ/zrAyuTeNtxyv+YMTYi1w56B200aEmKSmFK+PWXtAnapcjL0MgWt9+X50DIT07m4siV7xsiy9vs/V9jZ352PreOXzwUPk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR11MB1596
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
Acked-by: Ajay Singh <ajay.kathat@microchip.com>
---

Changes in v2:
- rebased on staging-next

 drivers/staging/wilc1000/wilc_sdio.c          | 14 ++++++++++++++
 drivers/staging/wilc1000/wilc_wfi_netdevice.h |  1 +
 2 files changed, 15 insertions(+)

diff --git a/drivers/staging/wilc1000/wilc_sdio.c b/drivers/staging/wilc100=
0/wilc_sdio.c
index 2f9aa36..c787c5d 100644
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
 	if (wilc->suspend_event) {
 		host_sleep_notify(wilc);
 		chip_allow_sleep(wilc);
diff --git a/drivers/staging/wilc1000/wilc_wfi_netdevice.h b/drivers/stagin=
g/wilc1000/wilc_wfi_netdevice.h
index 7e7ce94..978a8bd 100644
--- a/drivers/staging/wilc1000/wilc_wfi_netdevice.h
+++ b/drivers/staging/wilc1000/wilc_wfi_netdevice.h
@@ -216,6 +216,7 @@ struct wilc {
 	int io_type;
 	s8 mac_status;
 	struct gpio_desc *gpio_irq;
+	struct clk *rtc_clk;
 	bool initialized;
 	int dev_irq_num;
 	int close;
--=20
2.7.4

