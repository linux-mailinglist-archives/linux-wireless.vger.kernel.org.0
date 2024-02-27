Return-Path: <linux-wireless+bounces-4124-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553EA86A413
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 00:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EC7CB26D4C
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Feb 2024 23:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29D458128;
	Tue, 27 Feb 2024 23:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="nE8OIaqv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE45811B;
	Tue, 27 Feb 2024 23:55:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709078157; cv=none; b=DjW4rhP1eJ4IOx62L8lVnwkraBAMUUdl+cGUmPIoIcNIiuHpB5ckrQ74+bm+XRsPmZ5nJ0D0EK69+tKNd81tYaPXvDn3B9o1pICvgdmEL6G8G4ixzHncqaBF5XixSda8XAOsaDlSdk1vUGdgFsN+aDLuf5jSCf6UyT3DN/HOh48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709078157; c=relaxed/simple;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm5y1SfqlVtj4d90X9zhrM86/0sE0RIWzNDuKuFJSAmI4UGpRi9wVABj8L2Mw25mHzyer/U1HRH/SNsApvPA/3twPc0n/UOKdyVyA6c+Q1WBfsEIFM9D6WSFmXVUkPRza+B75QjMotjooOi8BpcEsD7soIaGl5yxwbPkBTlf/O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=nE8OIaqv; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709078144; x=1709682944; i=fiona.klute@gmx.de;
	bh=lir2t2pdVtLxfOYmeHCDbRJi+Djx6fijtKcExQHW/WU=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=nE8OIaqvDWRQ+Rhmkm/HVgYwcIOdZ6gWbCBfGAViCt6wor1rcG1LICVQdKfgQrr6
	 z/H3IvzBzqlc8nJwyCU2HDy8IQUf8dgrTfnnsPa7n1mzTWM917tPe17OQC1NhoqyX
	 1CaIsrRvdAUMagikUEUtinre0QecXkJd5CJGNFkgvMH/zucw33l271WidebQsGjFg
	 M8eaN8EHR2CDPTGX6Dl47cjKldRy/c8gy7eORUlMxCmf1p72UcuCQkKtYRNHH8fzq
	 JD6z+7YOfynns6/ydGuFzSf6mYoOs8MHIbR+GsRoCKmUSzD8RWigrsn2QlIlI2xvn
	 c1UP7AEn4n3zNhNRJw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.29.223]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M9o1v-1rZs6n1twr-005u4o; Wed, 28
 Feb 2024 00:55:44 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	pkshih@realtek.com
Cc: Fiona Klute <fiona.klute@gmx.de>,
	kvalo@kernel.org,
	ulf.hansson@linaro.org,
	linux-mmc@vger.kernel.org,
	pavel@ucw.cz,
	megi@xff.cz
Subject: [PATCH v2 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Date: Wed, 28 Feb 2024 00:55:03 +0100
Message-ID: <20240227235507.781615-10-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240227235507.781615-1-fiona.klute@gmx.de>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cpc1hcAxe3nxLibE6bVChnNOMkM05VtpqK0a3ZAe2EHATpRLT3F
 Z6gbOCFtokMHsq8C1rniwrXjFIUvE3MvdkMKMR60e1hJBuHqCPTQZTmbuIH8k2N4zRVV9pS
 Bm7pAvWV4mgewwF5ioelqU2TaQLGm5UW3JQXgdsmi1Zgbv5zIZletzgf9nGQ0cjzO1J2AUv
 En4x21IPgbEKfg7sGTxfA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:3x2528n1Lt0=;1RHsvEusb/M4Xz3xAIuVw44OjAh
 4guxolfMlCUcEJBFEL6PhurA+cqHe3bDXZNTCVo6rVUnAipOxuT5sgr8eAH0YnNwlAoW2gbgn
 IM//ys8DX8okvo7Vfs7AtIJUSQQn1yFVEMRu/2QtEYdjqnxOJFO7VdZhZoggddDD87lLI3pLM
 EgZLtQlBUx4kWRlovtLQAwUJLzKs73lvGEv6E3pTWsIagCcTuougI/jVMqLH606jsi4wuEnD/
 jUq/ZMq4qRD2e32k2YbIXzaznMQak3wBBVd5fkLC+VdpPEOU5l2S9Bs4TWhJcVWYAI1r5mpHw
 QwqiVO5WKZiv2uXYE62iBgUAjG+LFC39aY3s2xJLgG9MV184P56Q3me8qZ1dHhN1d1+nRsljT
 /vo4GllCwgQXQ5AJa05a8FojIydub020hfz9TN/a4drV7RRbVNC/aN9688P7AK5XJ1zQ6n70O
 Kh034CirZ2vPL98KsU/2zi+ucm3n4EIQJS3dmdVParEdModPc1UGpF3hoWqtUvSM1MBRhmu93
 P0EkyGmiguY+LDZ/93FZYsC8wlkRiOmqzdroZ/TxMv8HE6+xEESs/5m2bTS8M/2vCqwyVl6tQ
 jVK97hERqIe2uUabup+BZZ9tzLONey15V7SdAanCz/8Y/mvuwAr21EvWyzkxOUToFnUFfWhVT
 XJlN4hbpL+iZMZCX8/uwkOPSnLD9VzCY8Od3QzPwml0GxwdqFJ9k1nR1zJChc6kYR/kp/gmiX
 RCM4vkPd87vHjyMqV6GFgxWxDFe0LIheogz+DCOZx01ReoRakevIDr85uImFneT1FBuVmswzl
 fdErlgcb63r7hSvYsmyYD8NUFvMeNkDLkxTJs3IT38hDM=

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


