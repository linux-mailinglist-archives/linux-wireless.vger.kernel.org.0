Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9E02966398
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2019 03:59:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729148AbfGLB7i (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Jul 2019 21:59:38 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:24969 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729062AbfGLB7i (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Jul 2019 21:59:38 -0400
Received-SPF: Pass (esa6.microchip.iphmx.com: domain of
  Ajay.Kathat@microchip.com designates 198.175.253.82 as
  permitted sender) identity=mailfrom;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="Ajay.Kathat@microchip.com"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1 mx
  a:ushub1.microchip.com a:smtpout.microchip.com
  a:mx1.microchip.iphmx.com a:mx2.microchip.iphmx.com
  include:servers.mcsv.net include:mktomail.com
  include:spf.protection.outlook.com ~all"
Received-SPF: None (esa6.microchip.iphmx.com: no sender
  authenticity information available from domain of
  postmaster@email.microchip.com) identity=helo;
  client-ip=198.175.253.82; receiver=esa6.microchip.iphmx.com;
  envelope-from="Ajay.Kathat@microchip.com";
  x-sender="postmaster@email.microchip.com";
  x-conformance=spf_only
Authentication-Results: esa6.microchip.iphmx.com; spf=Pass smtp.mailfrom=Ajay.Kathat@microchip.com; spf=None smtp.helo=postmaster@email.microchip.com; dkim=pass (signature verified) header.i=@microchiptechnology.onmicrosoft.com; dmarc=pass (p=none dis=none) d=microchip.com
IronPort-SDR: WCvlBZWzUspu/fvi1zBC55q36It63+x8P+gsTMK0sbAFPpWUNUzFRwnttwZuSBECa6WLJS69sE
 /w8/RcEgstf5X7Hen82aD5UvOuTEkuoigMMk6LeLsxy5t3oeCv87ymYv3S+IqauXZq+scJRXbi
 +dfVLVoaCm/3oH1O4wj79hqTUbX12FzODw5tv6CvL74xtg2GNszPGsNzIbi6HuF7tfZfloBrDb
 0WRXnOv4YJYTpMOrIIM9LtPgfmZ4XCLXhuFqPnK8knqavUZkqDa3YLLl1K+io47r/X+lZFPQGi
 6J8=
X-IronPort-AV: E=Sophos;i="5.63,480,1557212400"; 
   d="scan'208";a="37967499"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Jul 2019 18:59:37 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.87.71) by
 chn-vm-ex04.mchp-main.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 11 Jul 2019 18:59:37 -0700
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5 via Frontend
 Transport; Thu, 11 Jul 2019 18:59:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WZamsNEdBo1zDtlqdIKHj1uKWR5oSntPnFdtGWeZsm1nY7ADjJyppnG2II6lG05aOr6bkywfkS1VHsCIW9uPzCRks+dm7lS6B7I+6fNqOM4QXHFmBc24ZQ+p12DoQajx0IXImUWlGVSUgjqNZKOUzNbvRofktTiJo2h5yq1QrUQ9jaO8/J0LeJl4+PRaH0x8bTnzfhx6pJ68mvEFuCBjkWvgsb4EUJHwFWP3cciWr/gAtAZFZKnjHtj6NlywdjhDPEcc6J0Z1g4Yyo/Wydqkfwls6+AzA1OJ2WRDHvp1jfVc69jjbbqKssJ/aFo/VwrsB8WrFqJJJ9lGq4Oq8oBkCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ex3u/rwYqRzCVTAeb6WPgihhjYiEGisS49MuWa/rCs=;
 b=EXIjuiLaRmETFS7JFgc4/uFbI/840AgxJmBpBuTwiVchLs8V9lAmgzgO+NabLy4oAWHOrFlhs57o1MVtTZLiqPNy7GBpFGWyK3iAnG1u8vcRRPIfN3t3vdM9DVw9gvDLU3i9gpvbNa7VrIh4fKUHaEaqguF7jwueQVeEpzRXl50p/lhBwnZ9+BfMS38oFXF9LCeEgOUCYAZQVRKN9MrDSI693dLgAPIJGWr/VhIF0ZmW0c9CvakJfdfOktIsIa553f6N9e6g/QfxdWKdqVR1X2/+2mrudEtBzDMdVvhjxZDOSBKEZExcUDzT/n7zJuVQb7lnqahp3tcyIKn3srD48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=microchip.com;dmarc=pass action=none
 header.from=microchip.com;dkim=pass header.d=microchip.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector1-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1ex3u/rwYqRzCVTAeb6WPgihhjYiEGisS49MuWa/rCs=;
 b=DuO6HFlNFN8R310vLN3s0dYhnOa5zuohHsn6hcD9n55Y9R8mgmaFIzHvu/t3NxowrgA/UjN6jjV6tD6PAKOKOdbQAN5M3Xr7ZzwTSlzpCl+0zueYMpr6y9PoITWROfMu/G2/hDcCQ1m2bDmnGBMdDq8ribx9Njq63w54ZJ5K6XI=
Received: from BN6PR11MB3985.namprd11.prod.outlook.com (10.255.129.78) by
 BN6PR11MB1425.namprd11.prod.outlook.com (10.172.20.145) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.10; Fri, 12 Jul 2019 01:59:35 +0000
Received: from BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086]) by BN6PR11MB3985.namprd11.prod.outlook.com
 ([fe80::54db:507:e9da:5086%6]) with mapi id 15.20.2052.020; Fri, 12 Jul 2019
 01:59:35 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <gregkh@linuxfoundation.org>, <kvalo@codeaurora.org>,
        <johannes@sipsolutions.net>, <Adham.Abozaeid@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v2 16/16] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Topic: [PATCH v2 16/16] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Index: AQHVOFV09WNoFadopkmbEJyNi7rFxg==
Date:   Fri, 12 Jul 2019 01:59:35 +0000
Message-ID: <1562896697-8002-17-git-send-email-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: d9bacf22-6fe9-4cc3-aaee-08d7066c967a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:BN6PR11MB1425;
x-ms-traffictypediagnostic: BN6PR11MB1425:
x-microsoft-antispam-prvs: <BN6PR11MB142594E9EDF6BD2600DB2BD6E3F20@BN6PR11MB1425.namprd11.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 00963989E5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(346002)(396003)(136003)(39860400002)(366004)(199004)(189003)(4326008)(36756003)(5660300002)(54906003)(6486002)(6436002)(86362001)(6512007)(5640700003)(107886003)(68736007)(99286004)(486006)(53936002)(81156014)(71200400001)(71190400001)(66066001)(2351001)(316002)(78486014)(478600001)(476003)(2501003)(256004)(14454004)(186003)(11346002)(8676002)(102836004)(446003)(2616005)(6916009)(6116002)(7736002)(52116002)(26005)(76176011)(50226002)(386003)(66446008)(66476007)(64756008)(6506007)(66556008)(25786009)(66946007)(3846002)(8936002)(305945005)(81166006)(2906002);DIR:OUT;SFP:1101;SCL:1;SRVR:BN6PR11MB1425;H:BN6PR11MB3985.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UpGkvPLbPhq7McQwIx7PvKavS8W6XlMtXsGcbWS9LO4hvkgV5z8cIOikmHn0T1JpTtpPlZIPZGiQjNMTGKibVrEleNwOqm+QMBiafP/Mx7vdmSIbFEacszKzs1B7v52dJmNSv4i1ujciNPvZP86HdG/pprqko4SGIBoLRHDNqm66kzUmPeEd+nYfQu2r4x6ytwFDZxY0GzaRNZIzXp1SKn7uPltPp5EsHaYOogAUAZX8UjuiC1yA7HtVh7B1iCp0gGhCIC90tTwVzYeLdDbq+mbTGz/LMzSER3BJpwOhyk0NtR7yv2QgL9+D+yIVDPJ/4OWmQzrN6uUwx0V/W0KJpcvmQdZQZhTUAZnu2Ki/mtMCgGHHQ2mQTd+WR9xMSeF5vYhaoksYQfvCNYPHxeJEqbdReH91u7NAB9PQoN3I/78=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: d9bacf22-6fe9-4cc3-aaee-08d7066c967a
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2019 01:59:35.0858
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

Added Makefile and Kconfig for compiling the wilc1000 module from
'drivers/net/wireless/microhip'.

Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
---
 drivers/net/wireless/Kconfig                     |  1 +
 drivers/net/wireless/Makefile                    |  1 +
 drivers/net/wireless/microchip/Kconfig           | 15 +++++++++
 drivers/net/wireless/microchip/Makefile          |  2 ++
 drivers/net/wireless/microchip/wilc1000/Kconfig  | 42 ++++++++++++++++++++=
++++
 drivers/net/wireless/microchip/wilc1000/Makefile | 14 ++++++++
 drivers/staging/Kconfig                          |  2 --
 drivers/staging/Makefile                         |  1 -
 8 files changed, 75 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/wireless/microchip/Kconfig
 create mode 100644 drivers/net/wireless/microchip/Makefile
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Kconfig
 create mode 100644 drivers/net/wireless/microchip/wilc1000/Makefile

diff --git a/drivers/net/wireless/Kconfig b/drivers/net/wireless/Kconfig
index 1c98d78..86faf8f 100644
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
index 6cfe745..f9a51c2 100644
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
index 0000000..a6b46fb
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
index 0000000..73b763c
--- /dev/null
+++ b/drivers/net/wireless/microchip/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_WILC1000)		+=3D wilc1000/
diff --git a/drivers/net/wireless/microchip/wilc1000/Kconfig b/drivers/net/=
wireless/microchip/wilc1000/Kconfig
new file mode 100644
index 0000000..eedebe1
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
+	tristate "WILC1000 SDIO (WiFi only)"
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
+	tristate "WILC1000 SPI (WiFi only)"
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
index 0000000..a5a8e80
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/Makefile
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_WILC1000) +=3D wilc1000.o
+
+ccflags-y +=3D -DFIRMWARE_1002=3D\"atmel/wilc1002_firmware.bin\" \
+		-DFIRMWARE_1003=3D\"atmel/wilc1003_firmware.bin\"
+
+wilc1000-objs :=3D wilc_wfi_cfgoperations.o wilc_netdev.o wilc_mon.o \
+			wilc_hif.o wilc_wlan_cfg.o wilc_wlan.o
+
+obj-$(CONFIG_WILC1000_SDIO) +=3D wilc1000-sdio.o
+wilc1000-sdio-objs +=3D wilc_sdio.o
+
+obj-$(CONFIG_WILC1000_SPI) +=3D wilc1000-spi.o
+wilc1000-spi-objs +=3D wilc_spi.o
diff --git a/drivers/staging/Kconfig b/drivers/staging/Kconfig
index 7c96a01..4965690 100644
--- a/drivers/staging/Kconfig
+++ b/drivers/staging/Kconfig
@@ -84,8 +84,6 @@ source "drivers/staging/fbtft/Kconfig"
=20
 source "drivers/staging/fsl-dpaa2/Kconfig"
=20
-source "drivers/staging/wilc1000/Kconfig"
-
 source "drivers/staging/most/Kconfig"
=20
 source "drivers/staging/ks7010/Kconfig"
diff --git a/drivers/staging/Makefile b/drivers/staging/Makefile
index fcaac96..37f606b 100644
--- a/drivers/staging/Makefile
+++ b/drivers/staging/Makefile
@@ -32,7 +32,6 @@ obj-$(CONFIG_UNISYSSPAR)	+=3D unisys/
 obj-$(CONFIG_COMMON_CLK_XLNX_CLKWZRD)	+=3D clocking-wizard/
 obj-$(CONFIG_FB_TFT)		+=3D fbtft/
 obj-$(CONFIG_FSL_DPAA2)		+=3D fsl-dpaa2/
-obj-$(CONFIG_WILC1000)		+=3D wilc1000/
 obj-$(CONFIG_MOST)		+=3D most/
 obj-$(CONFIG_KS7010)		+=3D ks7010/
 obj-$(CONFIG_GREYBUS)		+=3D greybus/
--=20
2.7.4

