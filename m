Return-Path: <linux-wireless+bounces-4554-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA94877E39
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 73EEA2825A1
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A16B83AC08;
	Mon, 11 Mar 2024 10:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="RGWLAGuq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E63C38DEC;
	Mon, 11 Mar 2024 10:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153506; cv=none; b=acvATlGI4D4KoJ2jqpOBAyH5xQ6F4brrGLBwN9ZJv8SetLi0ECYOMaWptLv08J2VdoB7+wlGDl7onSQL/tW6wcTijapxwVYJ/b9pC0uFZ42ux3wEepzhmLaPq815A5krBEtmwXgav/t/hxrP7qLFqgC9/aASWNbOVaapo+4wkFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153506; c=relaxed/simple;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rFEyRScNnyVg+Hnpn64NVrIzQHmCij/NGpHbwpzleSUymCEbrr3ZOt8NmuRSYKsGA33AIcawnAo+Tipt6tGoMTikRCzVmYMTIaNKN8onlIHYxsHNYQjWt4nQbaE59HrqMmuOOdB+kAI913N7LQuVBXXnx2j/DGh0LKbN4L/pifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=RGWLAGuq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153493; x=1710758293; i=fiona.klute@gmx.de;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=RGWLAGuqITGPhCQkPQTka2y7Ax0h9Us3hVVAwyurH4apKVnoN4hRPXjDqxuybfSh
	 pMqbVKdcbg2bej+GyEYnGlKS11qTxtH5x/kvMh42S7wGa0vfd448+/kDPPnnYPrbL
	 RUg22GTfKd5Onl//dw8zErJhKo6ip3aeLsOtBoT56GL575Vmv561+mSyhEISFGWE4
	 rz507AiRR9Z4icfDseWfnE3PXui5969cxEI1oel7QRgJa0v4IJnJR6zvQwB/CVxVe
	 4J8IqksAHkP1QXj5MBg9kHnq2wGPl2Ve/vASBzE6cHsnvorQAUjPdWPG2T04taJx/
	 5Wgg7cyW29sOxlNgMw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwfWa-1quFTi3eos-00y8vq; Mon, 11
 Mar 2024 11:38:13 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Date: Mon, 11 Mar 2024 11:37:13 +0100
Message-ID: <20240311103735.615541-10-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240311103735.615541-1-fiona.klute@gmx.de>
References: <20240311103735.615541-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Qvq81pw7X5ueB7u7MHFaITgC3hRiOGasufQ8v8Y2PVQ1MipOksv
 XTB7HrxNz8omrcU6NScCKSbCUOA+p8P3+IoW1ZSb5rLGaQghq4j6vAm657BII+wKubElcWl
 b0c3+KmgvGPI8o6k17PAUqA7Njl2TR1I6JLT7wuLhKOofyc+S0I4vFDzPrJ+B6ODyzhN8A6
 uWiAPaRJHkhUKFnuxxxpw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:NAs1F1JZ5m0=;OOiwLlC59FZ6nFjC3brx/zEi5NL
 FzZCYDF8QSrSPIZFczn3EIR6onm+JvjVnAqDHGkTOZehVUdxm4I4AqlNq6phqzVg6WlOLnt14
 e6bUNS+nvSOq4i5Bk80wHsBMamjYnKVty93O7YMGrjhaMBAtzj6bqY44WvMStQgNOB/I2CO2n
 RkqKamIMinopgkO2saSQ9I8pk/6ntGL/MaSV1Dh/T4P/sTEiwO5rnuGsMcP/wWPkzG+n9voUw
 B9eLzTEFRUba9pg+TCyoZw7Zrks+FEYC3nbDxN0q3zcAMRJG/ff+wJ6NQM3i3GvqSp9uaL7Nm
 uYIoWVXlZ3B5+T+HMSd6OFkTgUTiAXHJpCZpbDehIeKkR8eNkxKXeyTc2JQW2lD/368ZnQt9o
 yGLq37iGQtLR7QT2Cf9hbBKIwTwO0d1EONkUMBOoKB0d5alehlems51NRiB2z4KZLsADkQOML
 PlSShMOrXKUqcftJYaAfFGsbdR1Me5Y81deHjfdD/ofC9rlEmwFZszO9r2SN9Arv/aEpsV+lm
 HyA8Kb2ScI/d84JJzrIFDOSTQW0tWESX9PUzyzWmkv7Vv7bUE2iMNWszcaWJOcynGxkGjcedj
 noGL+oILN2pp8zKj8psvOMzK874fKlGoNIblTz06B+oId4Xx4YjL4TbJyzPdxhbXN/fa7fCpf
 2DSstKaGCI1jkwbxjgqkUk/CiysnDzFvrJ5/OuwQacsBozxy11/26HPkPYYiXNW28q3/VeHNj
 GXOyikeb9s83i7j75lDnChoMeFtJEx62o3uNJ0KF3J67VYI6PkHEpT+hL8R1XzJ6zduLJAukR
 Aw1jk/vDS677+Qhc0Qggzy6BjksCVmD14U3GdLyyHkyDU=

This driver uses the new rtw8703b chip driver code.

Acked-by: Ping-Ke Shih <pkshih@realtek.com>
Acked-by: Ulf Hansson <ulf.hansson@linaro.org> # For SDIO
Tested-by: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Fiona Klute <fiona.klute@gmx.de>
=2D--
 drivers/net/wireless/realtek/rtw88/Kconfig    | 18 ++++++++++
 drivers/net/wireless/realtek/rtw88/Makefile   |  6 ++++
 .../net/wireless/realtek/rtw88/rtw8723cs.c    | 34 +++++++++++++++++++
 include/linux/mmc/sdio_ids.h                  |  1 +
 4 files changed, 59 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c

diff --git a/drivers/net/wireless/realtek/rtw88/Kconfig b/drivers/net/wire=
less/realtek/rtw88/Kconfig
index 07b5b2f6eef..22838ede03c 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/Kconfig
+++ b/drivers/net/wireless/realtek/rtw88/Kconfig
@@ -31,6 +31,10 @@ config RTW88_8822C
 config RTW88_8723X
 	tristate

+config RTW88_8703B
+	tristate
+	select RTW88_8723X
+
 config RTW88_8723D
 	tristate
 	select RTW88_8723X
@@ -126,6 +130,20 @@ config RTW88_8723DS

 	  802.11n SDIO wireless network adapter

+config RTW88_8723CS
+	tristate "Realtek 8723CS SDIO wireless network adapter"
+	depends on MMC
+	select RTW88_CORE
+	select RTW88_SDIO
+	select RTW88_8703B
+	help
+	  Select this option to enable support for 8723CS chipset (EXPERIMENTAL)
+
+	  This module adds support for the 8723CS 802.11n SDIO
+	  wireless network adapter.
+
+	  If you choose to build a module, it'll be called rtw88_8723cs.
+
 config RTW88_8723DU
 	tristate "Realtek 8723DU USB wireless network adapter"
 	depends on USB
diff --git a/drivers/net/wireless/realtek/rtw88/Makefile b/drivers/net/wir=
eless/realtek/rtw88/Makefile
index 22516c98460..8f47359b438 100644
=2D-- a/drivers/net/wireless/realtek/rtw88/Makefile
+++ b/drivers/net/wireless/realtek/rtw88/Makefile
@@ -47,6 +47,12 @@ rtw88_8822cu-objs		:=3D rtw8822cu.o
 obj-$(CONFIG_RTW88_8723X)	+=3D rtw88_8723x.o
 rtw88_8723x-objs		:=3D rtw8723x.o

+obj-$(CONFIG_RTW88_8703B)	+=3D rtw88_8703b.o
+rtw88_8703b-objs		:=3D rtw8703b.o rtw8703b_tables.o
+
+obj-$(CONFIG_RTW88_8723CS)	+=3D rtw88_8723cs.o
+rtw88_8723cs-objs		:=3D rtw8723cs.o
+
 obj-$(CONFIG_RTW88_8723D)	+=3D rtw88_8723d.o
 rtw88_8723d-objs		:=3D rtw8723d.o rtw8723d_table.o

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723cs.c b/drivers/net/=
wireless/realtek/rtw88/rtw8723cs.c
new file mode 100644
index 00000000000..8d38d36be8c
=2D-- /dev/null
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723cs.c
@@ -0,0 +1,34 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright Fiona Klute <fiona.klute@gmx.de> */
+
+#include <linux/mmc/sdio_func.h>
+#include <linux/mmc/sdio_ids.h>
+#include <linux/module.h>
+#include "main.h"
+#include "rtw8703b.h"
+#include "sdio.h"
+
+static const struct sdio_device_id rtw_8723cs_id_table[] =3D {
+	{
+		SDIO_DEVICE(SDIO_VENDOR_ID_REALTEK,
+			    SDIO_DEVICE_ID_REALTEK_RTW8723CS),
+		.driver_data =3D (kernel_ulong_t)&rtw8703b_hw_spec,
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(sdio, rtw_8723cs_id_table);
+
+static struct sdio_driver rtw_8723cs_driver =3D {
+	.name =3D "rtw8723cs",
+	.id_table =3D rtw_8723cs_id_table,
+	.probe =3D rtw_sdio_probe,
+	.remove =3D rtw_sdio_remove,
+	.drv =3D {
+		.pm =3D &rtw_sdio_pm_ops,
+		.shutdown =3D rtw_sdio_shutdown
+	}};
+module_sdio_driver(rtw_8723cs_driver);
+
+MODULE_AUTHOR("Fiona Klute <fiona.klute@gmx.de>");
+MODULE_DESCRIPTION("Realtek 802.11n wireless 8723cs driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/include/linux/mmc/sdio_ids.h b/include/linux/mmc/sdio_ids.h
index 7fada7a714f..7cddfdac2f5 100644
=2D-- a/include/linux/mmc/sdio_ids.h
+++ b/include/linux/mmc/sdio_ids.h
@@ -124,6 +124,7 @@
 #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_2ANT	0xd723
 #define SDIO_DEVICE_ID_REALTEK_RTW8723DS_1ANT	0xd724
 #define SDIO_DEVICE_ID_REALTEK_RTW8821DS	0xd821
+#define SDIO_DEVICE_ID_REALTEK_RTW8723CS	0xb703

 #define SDIO_VENDOR_ID_SIANO			0x039a
 #define SDIO_DEVICE_ID_SIANO_NOVA_B0		0x0201
=2D-
2.43.0


