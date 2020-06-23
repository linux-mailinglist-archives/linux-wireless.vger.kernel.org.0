Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFA8D204FDE
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Jun 2020 13:00:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732448AbgFWLAv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 23 Jun 2020 07:00:51 -0400
Received: from esa3.microchip.iphmx.com ([68.232.153.233]:48821 "EHLO
        esa3.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732423AbgFWLAW (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 23 Jun 2020 07:00:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1592910021; x=1624446021;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o4qQa4IDs3+28CNNJRdyXoGmO1gs4VMZe2DJwCWXHq8=;
  b=HhV/1WXaULalklTpL/E6oaJ6DzqiHqiXBHwoF9LCCKUmXaNbrCAfObdv
   ZmeUKxs2pRVMYaOPdB3DrV4xHwMJIQah5Mdax0SV2W/1nUV+ipYFjNPft
   6+ZvIHsjwX6630NgogfMtk5wsiZKrVzo1efGopgfkcv7J/BgqjLlJICiO
   UfMLztBA/KE6JNHmDLxX2Qknlclnlj3FZ8IrXkKLfO7AzcLfNxRjwRyxV
   Fp1Mq4rqskOXAWgDQX6LGD/TVJvEIMebG311CvLKBOyPrmzDa8zHpvmt/
   o9T1xHphshrI32tSAB8lDYIzxGEH73iL765UKXt+Yk4+8YnLCPQ5++lHa
   g==;
IronPort-SDR: V4+zdVkWzOzaTCkryifBbWO9Wo5wqg2KXyavtBgisMJKUt3JWdt6g6vpN4YnzPtMfbADmdB1AN
 PT5L8r6DAiOtMtK9YTj7sZslEesax1eX03oe5ZQZkY4Oqsu8xy4SE28+rGAbEqtD89V1EAwqpn
 axfzJxBLoqSvov+BkReRBMBdFfcfUzzpySq+LY0+26JADsrc95pJ5BXCDPcoAZhigDunaq8o1g
 R6kouaxF/EzHVbKfnavc1CbOkeKRvFRKF+ggQhmHz8b1ZvddoCTT6sYyVroZEq51gA6KlMSwY3
 f9o=
X-IronPort-AV: E=Sophos;i="5.75,271,1589266800"; 
   d="scan'208";a="81196124"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 Jun 2020 04:00:21 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Jun 2020 04:00:09 -0700
Received: from NAM02-CY1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1979.3 via Frontend
 Transport; Tue, 23 Jun 2020 04:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DaulHcNR4eAMchQb1103ixMMJ9S5b5CyJv9xvc/wGfIfjUFLFIBmLH3e0EvSLZLP45Wny2vQ3T6ZFxLdr9oxKiF5fFguAQj7CQkJzxFuGb3hioRVp4lN9Fp+LvUybtbBAezB5aEjB/G5EVUs9aOXj77wCbrpF0WU0kgY6NiL4IJc+iwE+67jrrcXIa6rSEcnmiFo6NZ1GjKpzu1j6rNXvfDuAqYttLDI2UHh1qoeDWWXrWqDvLbepIFHM3cZhVxZ+CwC+w/JmAiSqsxAZrKiTX9f3KspJoWhyakHQbwaLFDU8grGAzsZ68uiSs3oDGNmSLKWiChk70vTh/14PzS4Wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYXOy5MztaC58qUX1wwU7l1yROMdDy2kq2/McAIu1+M=;
 b=Z/Wg8CX7XyMLEmvLDy2i0sntekL9HWWGywP+08ZDE7bFPw+QrA4qtA9udRh3to2tGmf99BiCPZ60Qqao9nLq5moR7/uV8CHZOuXHm7Br0fQIRAsVgjqfX8Fgb9p7AeCfMPfmY5Vo2XX2sKZX3JyYhzqZScNUo77fXkhFLGVDhLilxOVRzaZ45PRajHmTNtj2+hcnSB2SZ+DjIV8peyebGr57SLtOXq2JU98vJAQNuiN4ZPIjI3FDOq6yQ9/0uTnAoKq+sogSOvjp5LUy0Fud3IYYRMQJ+KOOy3BpwgkCoH84fVI1DdBywLsPxZjTMTE04w/h0hEXy5ng0/5luqmoZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PYXOy5MztaC58qUX1wwU7l1yROMdDy2kq2/McAIu1+M=;
 b=aFJvVQE4pZ896I00pyK3c+uz5GdC6l0sEgWYWJceKQ1oFdcvgwnZcUC8UBT6LiiX8vilUYy0pZqBdojbehAsMCK8uQwSTv9EqWjX/lwbCjPbC+Z1sHzFTg4ibceWTx8kn7qLhVVTMiJbrSJG3gK1icYycM26q3JE4Yt/3AJQFDo=
Received: from MN2PR11MB4030.namprd11.prod.outlook.com (2603:10b6:208:156::32)
 by MN2PR11MB3551.namprd11.prod.outlook.com (2603:10b6:208:ea::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Tue, 23 Jun
 2020 11:00:14 +0000
Received: from MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed]) by MN2PR11MB4030.namprd11.prod.outlook.com
 ([fe80::3874:6ace:6aec:deed%7]) with mapi id 15.20.3109.027; Tue, 23 Jun 2020
 11:00:14 +0000
From:   <Ajay.Kathat@microchip.com>
To:     <linux-wireless@vger.kernel.org>
CC:     <devel@driverdev.osuosl.org>, <gregkh@linuxfoundation.org>,
        <johannes@sipsolutions.net>, <Nicolas.Ferre@microchip.com>,
        <Claudiu.Beznea@microchip.com>, <Sripad.Balwadgi@microchip.com>,
        <Venkateswara.Kaja@microchip.com>, <Ajay.Kathat@microchip.com>
Subject: [PATCH v7 17/17] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Topic: [PATCH v7 17/17] wilc1000: add Makefile and Kconfig files for
 wilc1000 compilation
Thread-Index: AQHWSU15j3LzKe0p40qXGuHZhF86hg==
Date:   Tue, 23 Jun 2020 11:00:14 +0000
Message-ID: <20200623110000.31559-18-ajay.kathat@microchip.com>
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
x-ms-office365-filtering-correlation-id: 22d0e59c-4c28-467b-e994-08d817649bb7
x-ms-traffictypediagnostic: MN2PR11MB3551:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR11MB355194ABE26A5670F37D55A4E3940@MN2PR11MB3551.namprd11.prod.outlook.com>
x-bypassexternaltag: True
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-forefront-prvs: 04433051BF
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M9Wn5cYWx80EKB94NuEievRm20dwh2Wcy6bo0ASrvP5nqAEN+VDEkbpeGJj7m6SYgkxBlM1UQmyiDjGAJBig1lBCJziWk8ekwe3VmTeTWK1AIsqntM1tioJyL20x7tYYnV3xZkuGVPMTaAIhE7Wf49YWWo+pxv9L95E4KrmqevJ2nMyPLYTXmQgBtqMtrZ1bOmC/JOKOhIxzlWCK3D1q7JVS1Rj0+mDcHXD3fCgG+gJ3MTcT7nETEqhvnclfALBrHubpCg5Qim55AgSk5xlmLqniV73uHw9fJ0C4akkUpaDm5gzuxGZ3ApstWTkslFp6
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR11MB4030.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(366004)(136003)(346002)(396003)(376002)(39860400002)(8676002)(83380400001)(36756003)(2906002)(186003)(6506007)(86362001)(2616005)(4326008)(107886003)(26005)(6486002)(6916009)(5660300002)(55236004)(1076003)(478600001)(66446008)(66476007)(66556008)(64756008)(91956017)(76116006)(66946007)(6512007)(54906003)(316002)(71200400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: w9u0P/v8y8VocEwyXfS5HHRuRlvZciUY2bkxdGqhZhkJL7jNtoCvjS8+Y284LP24jRjM2+fLaWkLpRtbUGY0yc1sFnJN8JtV6stmqnTFPwc8ZQ5xgzcP5/0gT24ko8RSbl0Bj2KNUvzBn/W1VQzn47A+zT3UScFL/rYXNPNi05K9anrBdYCxxVasZTGZD2ADHIygIPNWWIkbc92mxl08xVuyCQ/SiSZAc8LZihO1rgg/8bEO5eLaYu5N0OaXRPJX8FH9UBa0/k8x4HhPWTw+DEyPB/uwvxGhTrHDp+bIcqEBNwcfOsfjw2HstKqkR7WY//2S8rm6N1JxmFAGlqIO1D6su13Jbj4Gf5LSvIc3UfcD4YiKAlYr/a/gjUy6ug9Di5zANpRPPCb/8FRJUv8YGKsgHkZAi4RnX/Xt0f3dUFCTjcWwYj1KSGb2gp5M3lp82TF2JfNVLeh52nk1eUtVI9vxvEye097fSXhvxsXX7mmW/CTNZWqDvU9umnrOkBbw
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: 22d0e59c-4c28-467b-e994-08d817649bb7
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2020 11:00:14.8945
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /094MqcRj9ZRVtdLSRu+FCm2dI0BptwaonJEhHki/I2sJD5BObGSDLShVIA64FJ+1EPyjtkNUBOf61Jg32g7Uh9FiNXdkYXF6A4BGQaZyGA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB3551
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
index 8ab62bb6b853..be0de242d8fd 100644
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
index 4ec5528f89fa..b3fb4d41e231 100644
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
index 4d34198151b3..3d8c7ea21a10 100644
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
2.24.0
