Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 66DCD16BB0E
	for <lists+linux-wireless@lfdr.de>; Tue, 25 Feb 2020 08:41:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729663AbgBYHld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 25 Feb 2020 02:41:33 -0500
Received: from esa1.microchip.iphmx.com ([68.232.147.91]:25184 "EHLO
        esa1.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729656AbgBYHla (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 25 Feb 2020 02:41:30 -0500
Received-SPF: Pass (esa1.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  -exists:%{i}.spf.microchip.iphmx.com include:servers.mcsv.net
  include:mktomail.com include:spf.protection.outlook.com ~all"
Received-SPF: None (esa1.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa1.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa1.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: VJq0GtNUOVm85hwjaw5/cQsUmDVSSzl2K+UytyXQ+L3n42eiNdimznS6Mnm7FZdaGKt2Ov194e
 hy/y+RmveY1TFV4zqarOOBgCOX7Z3Btj+TN2ka0+urpW2LhY6SA4UKWSLV3uN9dqLrSshuLr1b
 qA20TcEWou18rxc0PKYWRsfs4upQq+FzG/fTrMaTv2lsWoUmVhTl0JerLLsmpDrjMJp1qLwZCj
 BD9/D/UhungxcDU+4Y5vgQLRkD19xvoSDEUMiQsS8YgayRSGVdPxnJBXOIrRuCPV73XCotB/AI
 Fao=
X-IronPort-AV: E=Sophos;i="5.70,483,1574146800"; 
   d="scan'208";a="69675655"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2020 00:41:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Tue, 25 Feb 2020 00:41:34 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5 via Frontend
 Transport; Tue, 25 Feb 2020 00:41:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cuQgUWxUsreWGJEPW26VaYv+77Ee/4Cy9oOaBjC4SK0t8jU+5YOPIX1svTWp4YfDp7ZCJ63qjFpt7f5YYjHqTOOjehc/HBvwo+D4KI969OcoLiGWB5pPWPhPDXs2P5MbCnS4aKjmTtOHPTwZH31sVTOXB3Gt1OAy0wxpX1PTqFHa1Cy26dRooaFf8fGT6MZACisEVUul1UAO2v7RITpAsu7JbSlNvHVzI+pTbx9rTRBxy2yWst8PyV6/jdp/FBekbH9vrE27FL+mGdYjsttI4Kc9NTJZM5Lbl/JOqd9tVgkEzssoRzBkTaS6EWvDfB6eIlJFtsiuZxRc9lfeMKEaHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVpx+4/LdVizlZOqNSkBGWRM9tUnSIFoY5jmtsSCed8=;
 b=EKSI7OHG1wcd6sSUXq7Z4+J4nTd/Kph5hCGqOEepT9TCHc53a12cGL7F8HzGe3sdPE/IXhckK31+4dRCGCdbZW2+JxstpicA6W6tnE9i3NRrgIduvoyyzxs6nJzPWA4fu6WEupgpAMksBRQPEaivbCQ3gZYky/zbCwjRK/LtEcGcjKqkk6OOQDFAxsjSzHpLW4oSS7YuBAdsLvqn51IbFuwTXSy/hkKAHocPnDfCVOjwMKs9aH2VGUZpRYss4Dc7pY3MrT4RznYbYvHbeQe+mGAodO1f7SKip4x4ElZn3/oPPi4CsMyb4y3b/GI4GAM9UekJrBkxRMf1BI29Hbv9Iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SVpx+4/LdVizlZOqNSkBGWRM9tUnSIFoY5jmtsSCed8=;
 b=LwJIh4lJyIFHqlaMK/Baq7BbU8CAtwEKdZ++cJfs5xiaK2jhzmA4ij93erontAQ8EGwKkE6JutCl+/uKDMembrRVUJufhg5h/hwPGFHWIKhmGE6PHGMvfdQbSLfsZNFZyRObG+V6tna80Vg+oPPZB2cCYOmUY26EpEQm/NMqF7M=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (2603:10b6:405:7b::14)
 by BN6PR11MB4162.namprd11.prod.outlook.com (2603:10b6:405:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2750.21; Tue, 25 Feb
 2020 07:41:21 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::ec62:e7fd:f17c:dfd4%3]) with mapi id 15.20.2750.021; Tue, 25 Feb 2020
 07:41:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v3 18/18] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Topic: [PATCH v3 18/18] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Index: AQHV6674c3mwMKWyG0W0sxXw9kHshw==
Date:   Tue, 25 Feb 2020 07:41:21 +0000
Message-ID: <20200225074105.7740-19-ajay.kathat@microchip.com>
References: <20200225074105.7740-1-ajay.kathat@microchip.com>
In-Reply-To: <20200225074105.7740-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
x-originating-ip: [121.244.27.38]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 59a690c0-3a9d-4fea-b088-08d7b9c61bdb
x-ms-traffictypediagnostic: BN6PR11MB4162:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN6PR11MB4162F6D6833CDDFA077BA1BDE3ED0@BN6PR11MB4162.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0324C2C0E2
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(396003)(366004)(136003)(376002)(39860400002)(346002)(199004)(189003)(81156014)(2616005)(8676002)(186003)(6512007)(6486002)(5660300002)(26005)(81166006)(8936002)(6506007)(54906003)(66476007)(66446008)(66556008)(316002)(86362001)(4326008)(71200400001)(66946007)(6916009)(2906002)(76116006)(64756008)(478600001)(91956017)(1076003)(36756003)(107886003);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB4162;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JPZOt+4JW9BmYIRiGw0wF0zR8T1+c0eJFCLWvNWObSONQmYllXqZ8IRms2/MRHtQQLnnBH4wZi/e1gh0MmbgJVW0B6qmlzNESbiwJJSrNtJn3ULZBYR8IEQcpCZ4k2IJHM9VcNCfRwXiLJ44ZYum/Euzbb74ahwgMlLypBrE3g/l4d8BaPjW/oTYE7wGjRm16+BFRyOFMKmLRHEgOn4k9XqrbtsiJJcw/GU/HfZIHQDn1Ev6QXxr+7OFCHFOe4wRLwOWWMGELgTnW2FeLj567NKKJ7VBAvRa5A3ENQdCoDTPiyRlOwh2zzgbLEd8Um6bksM8q0/qUUlsZlKfx++WWCnhMRnIwsQ2Y3cq1IaREVOLwUIyqF9xqnwXYoWZ5zZxs13awKMr2K6uyeUTd6KrOGin5j6gpYKpoK9nKzKxBG/FC13Na3uk+KXGSI3SGY18
x-ms-exchange-antispam-messagedata: +Dl9RBdCMr86fldUAKaeMr0eJvknjESXd6IGE78oGikz4RkI5iR4GKGBGEWfAvHvOJrI2ZoYbo9EZTBxNj1hZIdM1fdqRLtJlybnqFGwlAL0oBppmI0micbZnIlIQ1r5pyhk2PSlIW4T22eNvNSBGg==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 59a690c0-3a9d-4fea-b088-08d7b9c61bdb
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2020 07:41:21.0114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: K0gnu+yT/K6v2/wp99HUq+wnatwwfMbH/GkC2UfjPXwf5ea0kDJb0bN7/hPZCExD1Nemzuk/nfqUmxxRBYfpfcJhxfF9V/Kr3Ah9DjTajiI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR11MB4162
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
