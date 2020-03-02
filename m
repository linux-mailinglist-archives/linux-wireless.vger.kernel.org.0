Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6253C175FFA
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Mar 2020 17:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727365AbgCBQfM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Mar 2020 11:35:12 -0500
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:42837 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727308AbgCBQfM (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Mar 2020 11:35:12 -0500
Received-SPF: Pass (esa3.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa3.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa3.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa3.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: WCyfsUoj6Zu50aUJVNePWyNfPnkICY16bsU3/yuCrrnVIaE1+MFpAG48NxQa6DgxDOQolTm04G
 P9WVKxOaMMnxOQ1cN8dneq/+Fa+oHJ9Jmb4wdD62KN0z2VF863i3MuzvAcMX492IXRhiW1wmzj
 yfpibBQrWvVgVAIdLFVVq7awBCacPMI2Oh8EjU0br2H4xjTVUDH+G/7qCR5BtRu/0zPwOjvocG
 NoYJ+dTcdYg+kYZa2aCObaTBz402n5QUE541OEzeAY6UpE6W/RNONqMMNX2vVIXY2L50lCa5dc
 hPs=
X-IronPort-AV: E=Sophos;i="5.70,507,1574146800"; 
   d="scan'208";a="68544284"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 02 Mar 2020 09:34:46 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 2 Mar 2020 09:34:44 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Mon, 2 Mar 2020 09:34:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dlbtotgPahO//NRzYRO/9E+MtHEch+3qXdfqiv+0OEl+VQOumoJl4PtAWRzZ1bwhllps8UQ2tRsW26SZp5QNGuvOsyJXNtb9JL2RR6qqg9E++wkrFofEwjHFIVXQtAE2ddIAANtVcJJN/jmqUydGEDBzv9Nphn03JXoxLIYWuSwtWfiR+yrX/ILudA6DM977FN41tSxwWS9s6p/Yd1GfPF4AAK2hFo5wX3la6787Ku7vWSufpXioKfztb73IwfOwU/rqMm+2jW6Q1lXX/Wq/43OQc1tOkD6YMiDA1dT6r9eMIqpVB5mzcuq4anEBYwsuAWJpplXJ3pzzZ3dcgrVs6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVpx+4/LdVizlZOqNSkBGWRM9tUnSIFoY5jmtsSCed8=;
 b=XsFZ4jKZBV5KVf3wWCxcxxfOdcrk9isxf7YFH2jwceNgATVgZ4lk8jKSeM4pECpFmWdpffysZnk8fByKAcPL3TXuL+Eg3zJUitH08MYzrGz4ifbqrlufHF1XmjHprk/+f2zmuc62HBUbZQ9/sFZQYF7Wl60hbBZlxnhIhGIB6hwGp1QPnZ+EGVbpCnV9ahYbdu+4w4tuXvWZIVszXQP7/CXK5Ds9SAj0rBYpllJo6MG7nEU1QTKvEHsXSpXSIpVK5Xmi2WNPXWw2zSNCKPOWtyIs3jUasLmVoW7jhs9Cqe2smTyVaZaZsllv2GTH+upNu18OG+2MtliEojx99asfIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVpx+4/LdVizlZOqNSkBGWRM9tUnSIFoY5jmtsSCed8=;
 b=OK23eob1/SoBWxPwoA2uqOLWyhjuEJ6MB70C3+nLcgsBRKDySjxj11Lr0Le9eSPOrPU48ttTgy/SfdYzKcnLzWZfUDVOKYK2FKu78V3wXg2Lhgs7NLL6Vn3ezgOcDOfVrUab88LaTpH0mbzUKSrPasq9viP8jcQqOkfh0vKqxj4=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4098.namprd11.prod.outlook.com (2603:10b6:405:7f::36) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2772.18; Mon, 2 Mar
 2020 16:34:41 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2772.019; Mon, 2 Mar 2020
 16:34:41 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v4 18/18] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Topic: [PATCH v4 18/18] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Index: AQHV8LB5xGU60tG2HUSrU+o9veURfA==
Date:   Mon, 2 Mar 2020 16:34:41 +0000
Message-ID: <20200302163414.4342-19-ajay.kathat@microchip.com>
References: <20200302163414.4342-1-ajay.kathat@microchip.com>
In-Reply-To: <20200302163414.4342-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 90aca1c4-c05f-4637-c6ee-08d7bec79bde
x-ms-traffictypediagnostic: BN6PR11MB4098:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4098903979C1FB2A8DD41FC6E3E70@BN6PR11MB4098.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 033054F29A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(396003)(39860400002)(136003)(366004)(346002)(199004)(189003)(316002)(6916009)(86362001)(6512007)(2616005)(478600001)(71200400001)(54906003)(4326008)(64756008)(186003)(107886003)(66446008)(5660300002)(91956017)(76116006)(8676002)(66476007)(66946007)(6486002)(6506007)(66556008)(26005)(81156014)(81166006)(2906002)(1076003)(36756003)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4098;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: UiJ8iUeOOrrjhgY21lwk0LUlKAdsa3zKaDmTb1t7oy4Tfk9iwka9w3KNWZI5vKSNdWGm34n/DghdYq57NGK0l3Wp0kWlziAcGhcF62lYVHzUdNlmW7gIyfQluPuKj0euzx3O6zko/ZTJ2Ks/rdkhmd4Cq+6o+ZGChhgVYmcDpT16gUyY9WZKFN9ibpJ4HXuqYl+lTtUOCFnI9X/bPWkBVJfg63QOnJXOukpRLJ6e1HZMAvZYcRBtHnyxgnwhRRiyShgIOMfupp7ukqRsiTqiW5BczWH+WbAcldfGQrXB1iecK1PkJOLZlROH6jNSfyXQ/AE+YDV7ItnV5CSprtuNE38HmNyGqhMWiGftRqlu+JGNdEmBc1OnLUXshqu9QPF17S05PbFzlFB8M56O94IUk8Uy3u86RhSJLKNDeIUKG1J78USGs+ssQXpuuqimdISG
x-ms-exchange-antispam-messagedata: QCxks+pzcYh66I2Mds5EcY1gWwisMx9rCWtwfKUajE5hoU0/uRqObrh2vjvKRjokn+8+nuoSa8GjVlOkwoedwfYw2AVKk2nS1lpyp5t3ni8W0EYNvNoqJbZZvcCveoj+VZTBq/6v8DypDb9DrFRaLQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 90aca1c4-c05f-4637-c6ee-08d7bec79bde
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Mar 2020 16:34:41.6973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9NSc+vLmMa8d5y0imIEWL/YHGlC2BpEXVynVY8X1qLPXFzr5k7QJBBCuQSZ52OjHDF/ub+2BlREmiyU3jNmNKrnOGYktCJFY4bCdqmjkFyM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4098
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ajay Singh <ajay.kathat@microchip.com>

Added Makefile and Kconfig files for compiling wilc1000 module from
'drivers/net/wireless/microchip/'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/Kconfig                  |  1 +
 drivers/net/wireless/Makefile                 |  1 +
 drivers/net/wireless/microchip/Kconfig        | 15 +++++++
 drivers/net/wireless/microchip/Makefile       |  2 +
 .../net/wireless/microchip/wilc1000/Kconfig   | 42 +++++++++++++++++++
 .../net/wireless/microchip/wilc1000/Makefile  | 14 +++++++
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 8 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/microchip/Kconfig
 create mode 100644 drivers/net/wireless/microchip/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Kconfig
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 1c98d781ae49..86faf8f3d9b0 100644
--- a/drivers/net/wireless/Kconfig
+++ b/drivers/net/wireless/Kconfig
@@ -47,6 +47,7 @@ source "drivers/net/wireless/st/Kconfig"
 source "drivers/net/wireless/ti/Kconfig"
 source "drivers/net/wireless/zydas/Kconfig"
 source "drivers/net/wireless/quantenna/Kconfig"
+source "drivers/net/wireless/microchip/Kconfig"
=20
 config PCMCIA_RAYCS
 	tristate "Aviator/Raytheon 2.4GHz wireless support"
diff --git a/drivers/net/wireless/Makefile b/drivers/net/wireless/Makefile
index 6cfe74515c95..f9a51c2889ca 100644
--- a/drivers/net/wireless/Makefile
+++ b/drivers/net/wireless/Makefile
@@ -19,6 +19,7 @@ obj-$(CONFIG_WLAN_VENDOR_ST) +=3D st/
 obj-$(CONFIG_WLAN_VENDOR_TI) +=3D ti/
 obj-$(CONFIG_WLAN_VENDOR_ZYDAS) +=3D zydas/
 obj-$(CONFIG_WLAN_VENDOR_QUANTENNA) +=3D quantenna/
+obj-$(CONFIG_WLAN_VENDOR_MICROCHIP) +=3D microchip/
=20
 # 16-bit wireless PCMCIA client drivers
 obj-$(CONFIG_PCMCIA_RAYCS)	+=3D ray_cs.o
diff --git a/drivers/net/wireless/microchip/Kconfig b/drivers/net/wireless/=
microchip/Kconfig
new file mode 100644
index 000000000000..a6b46fb6b1ec
--- /dev/null
+++ b/drivers/net/wireless/microchip/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0
+config WLAN_VENDOR_MICROCHIP
+	bool "Microchip devices"
+	default y
+	help
+	If you have a wireless card belonging to this class, say Y.
+
+	Note that the answer to this question doesn't directly affect the
+	kernel: saying N will just cause the configurator to skip all the
+	questions about these cards. If you say Y, you will be asked for
+	your specific card in the following questions.
+
+if WLAN_VENDOR_MICROCHIP
+source "drivers/net/wireless/microchip/wilc1000/Kconfig"
+endif # WLAN_VENDOR_MICROCHIP
diff --git a/drivers/net/wireless/microchip/Makefile b/drivers/net/wireless=
/microchip/Makefile
new file mode 100644
index 000000000000..73b763c7393e
--- /dev/null
+++ b/drivers/net/wireless/microchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_WILC1000)		+=3D wilc1000/
diff --git a/drivers/net/wireless/microchip/wilc1000/Kconfig b/drivers/net/=
wireless/microchip/wilc1000/Kconfig
new file mode 100644
index 000000000000..59e58550d139
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/Kconfig
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: GPL-2.0
+config WILC1000
+	tristate
+	help
+	  This module only support IEEE 802.11n WiFi.
+
+config WILC1000_SDIO
+	tristate "Atmel WILC1000 SDIO (WiFi only)"
+	depends on CFG80211 && INET && MMC
+	select WILC1000
+	help
+	  This module adds support for the SDIO interface of adapters using
+	  WILC1000 chipset. The Atmel WILC1000 SDIO is a full speed interface.
+	  It meets SDIO card specification version 2.0. The interface supports
+	  the 1-bit/4-bit SD transfer mode at the clock range of 0-50 MHz.
+	  The host can use this interface to read and write from any register
+	  within the chip as well as configure the WILC1000 for data DMA.
+	  To use this interface, pin9 (SDIO_SPI_CFG) must be grounded. Select
+	  this if your platform is using the SDIO bus.
+
+config WILC1000_SPI
+	tristate "Atmel WILC1000 SPI (WiFi only)"
+	depends on CFG80211 && INET && SPI
+	select WILC1000
+	help
+	  This module adds support for the SPI interface of adapters using
+	  WILC1000 chipset. The Atmel WILC1000 has a Serial Peripheral
+	  Interface (SPI) that operates as a SPI slave. This SPI interface can
+	  be used for control and for serial I/O of 802.11 data. The SPI is a
+	  full-duplex slave synchronous serial interface that is available
+	  immediately following reset when pin 9 (SDIO_SPI_CFG) is tied to
+	  VDDIO. Select this if your platform is using the SPI bus.
+
+config WILC1000_HW_OOB_INTR
+	bool "WILC1000 out of band interrupt"
+	depends on WILC1000_SDIO
+	help
+	  This option enables out-of-band interrupt support for the WILC1000
+	  chipset. This OOB interrupt is intended to provide a faster interrupt
+	  mechanism for SDIO host controllers that don't support SDIO interrupt.
+	  Select this option If the SDIO host controller in your platform
+	  doesn't support SDIO time devision interrupt.
diff --git a/drivers/net/wireless/microchip/wilc1000/Makefile b/drivers/net=
/wireless/microchip/wilc1000/Makefile
new file mode 100644
index 000000000000..a3305a0a888a
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_WILC1000) +=3D wilc1000.o
+
+ccflags-y +=3D -DFIRMWARE_1002=3D\"atmel/wilc1002_firmware.bin\" \
+		-DFIRMWARE_1003=3D\"atmel/wilc1003_firmware.bin\"
+
+wilc1000-objs :=3D cfg80211.o netdev.o mon.o \
+			hif.o wlan_cfg.o wlan.o
+
+obj-$(CONFIG_WILC1000_SDIO) +=3D wilc1000-sdio.o
+wilc1000-sdio-objs +=3D sdio.o
+
+obj-$(CONFIG_WILC1000_SPI) +=3D wilc1000-spi.o
+wilc1000-spi-objs +=3D spi.o
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index baccd7c883cc..ef5e62e46704 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -80,8 +80,6 @@ source "drivers/staging/fbtft/Kconfig"
=20
 source "drivers/staging/fsl-dpaa2/Kconfig"
=20
-source "drivers/staging/wilc1000/Kconfig"
-
 source "drivers/staging/most/Kconfig"
=20
 source "drivers/staging/ks7010/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fdd03fd6e704..4db5165cb08b 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -30,7 +30,6 @@ obj-$(CONFIG_UNISYSSPAR)	+=3D unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+=3D clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+=3D fbtft/
 obj-$(CONFIG_FSL_DPAA2)		+=3D fsl-dpaa2/
-obj-$(CONFIG_WILC1000)		+=3D wilc1000/
 obj-$(CONFIG_MOST)		+=3D most/
 obj-$(CONFIG_KS7010)		+=3D ks7010/
 obj-$(CONFIG_GREYBUS)		+=3D greybus/
--=20
2.24.0
