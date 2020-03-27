Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 835B119513D
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 07:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgC0Gd1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 02:33:27 -0400
Received: from esa5.microchip.iphmx.com ([216.71.150.166]:49575 "EHLO
        esa5.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727708AbgC0Gd0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 02:33:26 -0400
IronPort-SDR: +QAoGsY7/7jBLj8vLjLoCo1Kv85Oylz2suoHBquW0TCi4swCRbrgEhLq3hGzjCytxGhFo5LY6d
 MzJKv7DiRhyclqmSvv06qnxQXuwjkhRe262VZ6yOCZDZTrckuPbz9Y5v6lZ4phw4ObYvcgCBWv
 jMwHN8pTDxUWNg0VcUXOubGIi9ZHlbWilBbOnhtJP5R/fL4L+iqpifNXsXvctSMDQedrUZRznr
 qi1Fh47EPBFF6fS9n1R3gSbdmEyousT2+gweL5/uF8z62OQPGkrlBIG1FJ6RBCQO4z6DSRlp66
 c5Q=
X-IronPort-AV: E=Sophos;i="5.72,311,1580799600"; 
   d="scan'208";a="70452434"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 26 Mar 2020 23:33:26 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 26 Mar 2020 23:33:23 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1713.5
 via Frontend Transport; Thu, 26 Mar 2020 23:33:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WUxYGG0VzEJ3IR5Bl17hsd64naCCSQpNhRR5MloGkMObLqH2YfUfSRMiaOweDwLBzkNKnVre7EJdtKC6wFPC4j6MXyYCNnRIlD2Lyy5/hUDQcjWBZmDRZ/2MJFrj0PAB8Y19ZbG7ObCWjk1wSxsDpRpgFHnpL+tmrkyITsLUYWYRfhr1mxCKol/gihgR/DNEIzhBGAZNp03Wmbh8RVz6THZwZg5iR1WrRZ1EiW1un+u5oREBGI6GastL+XNrfgFsBBDKFQaufxxhr6gtykNwWERrOgmxgpqIu70VZD76bxoAG7NU4Py8fi872f0w1ZBV/7nldwnOc+iGCE2+SFWD0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+FHaC2cDxz7we2ANw7qXo4BJsliKhNlAJAMbrj1e60=;
 b=li7OnTa9ELPRXLPhM+ru7Jw1qEuoPE+tuilZni4Yp2w0LgJjnVy7nCHphUZ6swb3S7iClGuqtWkyTxuZeBhY6ujYDxA5H0UwX+tsDae+q3un8iE6W+SGo2qRhKS2t1m3dcLSjeBEJFx179le9da2YgI5Gu4q0AY6fUmZSqkuPxnZtWihGzT452faBYN9898JK50MjXiMHvHamcSsc8AaR3Fwp7yQ/b+b8s9//L/RLXOejCDOfD45l/B7s5cPg8q0YC+0P8XNq4WyhncDRFvCady/DmwOl5+gPa+5iQzQVVOxtEyZ7XacUc+VwgLUQ8QwUHFeYamCb5IGOC63K3o8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v+FHaC2cDxz7we2ANw7qXo4BJsliKhNlAJAMbrj1e60=;
 b=sOZzvyLmxfDdn8E+G7zJpDWLqn5PbxGAuwiFIo9PXwJ5qzMn+6xjabkHFSewWClKR2dNgFMl/N1aiQsZrwXEJMJMYpWAJgCjPzwz8gWmbxi/8hMNWBN5Sn9UvvCN7XHEZ/5DjXXj2Q89hMSjwNBtD8Ou7VLCcG86IgnAQgURxt4=
Received: from BYAPR11MB3125.namprd11.prod.outlook.com (2603:10b6:a03:8e::32)
 by BYAPR11MB3397.namprd11.prod.outlook.com (2603:10b6:a03:1b::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Fri, 27 Mar
 2020 06:33:21 +0000
Received: from BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e]) by BYAPR11MB3125.namprd11.prod.outlook.com
 ([fe80::c27:87cf:ca4:d86e%4]) with mapi id 15.20.2835.021; Fri, 27 Mar 2020
 06:33:21 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <devicetree@vger.kernel.org>,
        <gregkh@linuxfoundation.org>, <johannes@sipsolutions.net>,
        <Adham.Abozaeid@microchip.com>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Venkateswara.Kaja@microchip.com>,
        <Ajay.Kathat@microchip.com>
Subject: [PATCH v6 17/17] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Topic: [PATCH v6 17/17] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Index: AQHWBAGbrApgv2HB8UaaR09pNWOsRg==
Date:   Fri, 27 Mar 2020 06:33:21 +0000
Message-ID: <20200327063302.20511-18-ajay.kathat@microchip.com>
References: <20200327063302.20511-1-ajay.kathat@microchip.com>
In-Reply-To: <20200327063302.20511-1-ajay.kathat@microchip.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: git-send-email 2.17.1
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Ajay.Kathat@microchip.com; 
x-originating-ip: [183.82.22.58]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8e79d0be-b640-41cb-1b7c-08d7d218be6a
x-ms-traffictypediagnostic: BYAPR11MB3397:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR11MB33978611C324BD9DA0E237CCE3CC0@BYAPR11MB3397.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 0355F3A3AE
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(136003)(376002)(346002)(366004)(396003)(81156014)(26005)(8676002)(81166006)(76116006)(66446008)(66556008)(66476007)(36756003)(6512007)(66946007)(6486002)(64756008)(91956017)(2906002)(6506007)(4326008)(71200400001)(2616005)(107886003)(186003)(86362001)(5660300002)(478600001)(1076003)(6916009)(316002)(8936002)(54906003);DIR:OUT;SFP:1101;SCL:1;SRVR:BYAPR11MB3397;H:BYAPR11MB3125.namprd11.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;
received-spf: None (protection.outlook.com: microchip.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5+zGm9WW3TQYyh0IY+8f5hcm1sa4pXMupY90kW5Tu9GYvhKEHirXNsyL3XF14IicDX4mknZ6DbQOIsFMkYv5Sy7mDOcB3UIg43zGP2hqSY4Tns+uZBm6QtGZbVd3HGZXO+TzygPRbz/v18XfxjJRfrcbMigh2W9ZYbUJIrYX0oDyU2AtNrDjW7g2yL04zFYBh5kmyak0NqgiDcug/FK3W7tgakuAHHGiIVh9uHIexs+7SLswqny6qkEUT80lO7cNkrZKp8/xjgRxU2KrefFqoec17SiH/fud1v+hXZynfYmg36025KzZatQpBY405fSsImRHdS8fnSenw0PMnqRLR3jY4aQ+99vSyetGtoL1WbWu2f4to7whyPa1YaBTvSbSN0MuvnNmHc/eblzErPcwdGWEbNAE6v2tBiPI6AAh/1olQ2VZqbef2BIrGsa5cVEj
x-ms-exchange-antispam-messagedata: vKO+7qDIALVVfdGp6MXvBUHAE2myxeXkuNB1EIUh/tCSo3FfGPFRlZN5qi7rQM/vb9abh09AKaItWWGDtWzNRedM3EgyxLbjuwJ6/M/aVm1ZC45s7wXaehgB6SCzSakjStk8wVqvn3qyURbhPjuGcQ==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e79d0be-b640-41cb-1b7c-08d7d218be6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Mar 2020 06:33:21.0738
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ACudVmYsPRTAREyCKrCX1lh2DEvtW5eK8B+ItUb15fB8ySop9zS+AceylOyq2kWp8+hp4iUFACVYbq0syNU3wUF0EEXSi7wOJjVTz5TpkSQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3397
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
 drivers/net/wireless/microchip/Kconfig        | 15 ++++++
 drivers/net/wireless/microchip/Makefile       |  2 +
 .../net/wireless/microchip/wilc1000/Kconfig   | 47 +++++++++++++++++++
 .../net/wireless/microchip/wilc1000/Makefile  | 14 ++++++
 drivers/staging/Kconfig                       |  2 -
 drivers/staging/Makefile                      |  1 -
 8 files changed, 80 insertions(+), 3 deletions(-)
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
index 000000000000..80c92e8bf8a5
--- /dev/null
+++ b/drivers/net/wireless/microchip/wilc1000/Kconfig
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: GPL-2.0
+config WILC1000
+	tristate
+	help
+	  Add support for the Atmel WILC1000 802.11 b/g/n SoC.
+	  This provides Wi-FI over an SDIO or SPI interface, and
+	  is usually found in IoT devices.
+
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
+	select CRC7
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
