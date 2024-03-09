Return-Path: <linux-wireless+bounces-4515-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E38770DB
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:58:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DE451C20A8A
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA5C33BBF1;
	Sat,  9 Mar 2024 11:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="LX14kvBY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52EB3A8F9;
	Sat,  9 Mar 2024 11:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985471; cv=none; b=MPAvjm7srYKaVcVYqDKoR92rp2yfxoKwijlRrLjbwOcQDRhP7ao0EP1YSQ/ltkTXSksrprmxCtEqZ+sEhio11LX7bFNeaTtksSPCpt3MKsmdZXF3STdf8/Gc+lw4vGKWH1JFUtdi9XSPxsVTiJf+oWMxhBE7QJr2IV9lijubfcE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985471; c=relaxed/simple;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PbOwpiXIrJFfdcu3LN3BJVzhZ7JH3qA7QsVHHzNJep7T/1vaOJzn2nXsD062w0MnvScvMTSjM/CsTbK9aT4HpbCJD8pWHhioYi/DihM/GKujPX5S+ZaW7kvwDMV17geBOU55kX2w3w0J+gldXAI3pR5Jvgq1hyIVkJwkcyxjEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=LX14kvBY; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985457; x=1710590257; i=fiona.klute@gmx.de;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=LX14kvBYsTDPLLDkUNJa8VYsBZ+0NHDFJY/Y478Y5gtjtRhx9LB/rsbNhvHmF5e8
	 i2cKx+AFs9njqOF/30zh7jDBrLVgbrjHLNyjJ5tiJisOONuF18Ph2+c545DbVjiQB
	 Uxwoj6cq5lj2+iGu6Fi1BwZrFGez6KaP79VWEEfIutrdjTmReYPJsFHwCZxWjKxx9
	 MiAlY22qV0DOmwN+4Jp+lgQkpfd6sJO0DIf9lOwQvX0wOXR6njU3X+snylQG/tOEL
	 YTVGOPAhWC0/qYpLsX2nqpAR42WoJxHvx3OmzDtk/cjvx5nSh3IeCAH7/33nwLCoF
	 xNJb6CCsdSRCulzM2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNbp3-1rUHxS27x5-00P5X4; Sat, 09
 Mar 2024 12:57:37 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Date: Sat,  9 Mar 2024 12:56:45 +0100
Message-ID: <20240309115650.367204-10-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240309115650.367204-1-fiona.klute@gmx.de>
References: <20240309115650.367204-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:WNZSjhbM9GWxzJcfU9uH56tkLyDLRbN3WLO8RW78lg8b5lXlm9H
 k/rFiUV+cyBBQEsREIAjvG5+1pyjwl6L2+98F5o0NO/ltaKxwQZy1hR8E4aLO/YI52Iou0t
 oItak8CIz/cauRBsxJIt+K+XOjElrBqU979UoRoXLEPpsjfvLd+zkbTy2Rv1cULtCmmarX2
 x7+ubcxteW553f1ie7MOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:XZp3ocSsxUo=;2jZpIZ5nQHDm8LeGRWG/jpYobcP
 8qbjzdvK9WU5GAW4Ix1Ep+vMh5441L9uhLxUe24KPfucfGQMtCQB9AWJ7HU08R+jBnzheJ1Mj
 AfsMXaR2YxcM7Em/BnaDMaVsXy/t6bwEWW2P+PP0sLWyL9mlzCzBCCuNW0P0J4YA/JQYIKqnO
 evCjg3bKRfzkjNJo4+e1H/8TqA6dpqBAFPms3hsaxxNZbVHbIGiBZTkbEm47iM/72NnqBvQF3
 su7vibkzZ2aZL1OmTr60/vyCySTzTRUNIQPOCOYsS940xkVXK683VtjDqmzUdRrDi0UZDEWkW
 AYmtKXGnDt0IidDrFYeBxWPtIWVsVtJ4TyhBmshc8yMxkDGPWt5/Z6EKHbdA6j+/EVB6S6faa
 100YCMC1mF/D6OZbIbOOfyqp8iz5WYMZVKhoKCeDIyDxGA3yqVUHzQ6YLtDKxnK9HcEey5vfq
 V0HDtUbRJhOMqQCx8TYKVgrFcxerhTtAm4FcdZnR2kzbiyggMDLj0O0mC72P9k3eaYMhmauwQ
 Gc6K0FbiyNb2mZuUWbxaGICHNxSIRYYGJr2o5FKGTzias9+EMQb2jsfWPRvGfoQnCwr78zn49
 sOTEcCKMoPQSYkB+oWHci3buFgX5kjwoXCEG7wqbOsdEfjPtmi37/MqY09n21GbVmblDaVkLC
 Ei6Oc33H/2oQ4lfPww6+qgYUermqp+ieBDJoO2IcSdLNhp39XLp66RIdBbFzwzvGbHCrNG7j4
 DdN5nGasO8S7bJDhVK+oF0GGQ/xsdEXboiRtOwq7A3I1d/5bIXM35JR4pOoQxOZZ9NimtcNT7
 TquyvkMtA6OvJVOugJ19kfZQFV5vZesENuYnAj4T0a2wk=

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


