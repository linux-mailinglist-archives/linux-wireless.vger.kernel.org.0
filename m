Return-Path: <linux-wireless+bounces-3022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DBE4846FE0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:12:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9D2C29B373
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E575140788;
	Fri,  2 Feb 2024 12:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="TfDv/GKU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD3F140784;
	Fri,  2 Feb 2024 12:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875893; cv=none; b=IvAIaNRMu42riiZQW2lhXggSS2XYVkY3aesSdfO9DeLNIx+j2mPc4nVywnEA4cSnuO2xT7kbRr0Eq/KYtZvKScekuKVkco4Lgl3K0E3f2qoCwGURy7QzMPBd1tL8RTuIiD1wJbvxKecOLQTj8HYZMzSTt0PTmSYK/8LY8UP+TvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875893; c=relaxed/simple;
	bh=7FrTbG5u0MkX+aiNtAj7VC29Woe/ZAyajcrdvlmpeyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OJHS38D/OwpRvrBLFJDdi00NGEwoJvcZprpoUj9lQsujvoRjgm7rVovy21RxKYnM//Lai9rHqARTSdPIxHpR2dTtwhxlLWRccv3pdJfvld1TJm+JsLi7pPom9EVC/RGNB6ULrzd2ACSnUZKH1vvnbmygDV/msVDC/oiv/gzeFIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=TfDv/GKU; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875879; x=1707480679; i=fiona.klute@gmx.de;
	bh=7FrTbG5u0MkX+aiNtAj7VC29Woe/ZAyajcrdvlmpeyQ=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:
	 References;
	b=TfDv/GKUybpkxFjB69nCvBVYt5yHqoCKoEFGUo52xhcBP7k4lGHQEh4kOadvqhfy
	 8YLlHBrNKA4YttfDXQnO1Ol3r4p81c+OO4glDUHvQu7+PwdB2L8GN3nJwLQcQcunS
	 pnrkJuqpJfseG2XdH8wJoacDm8KCjwwX0Eea+5jvcYkrlFzd2I/9gFJ2PRI3e2GHp
	 la5gXXm9/56PFMPOOIhwkqNipE2/bskc2KRlThwijjAOGTtwebYay78bhf8tHhR30
	 DrmVPrtPrPh3WERDVRSpkUXPnzbauZI38108Ua6ClUYIDz4Lvvny0qap4qJAK1I0G
	 R39W6bWx3pviCzSC3w==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MPXd2-1rjXML1E0Y-00Mb6D; Fri, 02
 Feb 2024 13:11:19 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 9/9] wifi: rtw88: SDIO device driver for RTL8723CS
Date: Fri,  2 Feb 2024 13:10:48 +0100
Message-ID: <20240202121050.977223-10-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202121050.977223-1-fiona.klute@gmx.de>
References: <20240202121050.977223-1-fiona.klute@gmx.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1QIHKnHPlXIUIEP0Hyg+Spka+5RU+m/NeS+BfRZrDIBbgnL8xkW
 yJ4n8zJMRK0+i76Y35DzwOJRj+Ywc8pj8myunb0x4+lavW5kR/GxAPoi6zUhdNq6qB+haoC
 DOlU2KtyzD5x7TVGoGL3h0a/HfPz/+YBrutxtZaaFjUMZpbkoy1QNvm2+SXP8qJIPUoleAJ
 uGjY+12VsiUcDPXQs8YIw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:aP9BKBAdQJQ=;KTfpmmyG0Bn2I4Jpk0PaFGUXAJy
 2TBem/skad2DZ0c2ZLnHuR/tSCpRBKJ5hpKw43l3/1Y//TLJ0340vleUiMsRKZ5w4UhZeLNwN
 7JU3vDqDb+8KMHfHSIEMmglyM5OjrGdK3maPQbpeOFl1exkduafuPIy3DFEiQrOAkWk44hg2e
 /H0Kew1bOUL08KX6bSW/8G0kFeyS0XcuL4m7OfD0+i9QRTtZJcwVZsbwz4zYW0BWk8iboRKcV
 KuGmzDeKgP4f2SCojmGTIn7VYhVc+gLS5dcNdyaguhlIcuknDAQJRy+aHcBDeUz3vbtZ+0p4R
 1jYR3QeDCC2zkeomHYsiI0MQOUNTXfq9xwiuUmasgTWrzdjiwe+7f5BJp3QdL/XwUkhWGuR58
 kn8ak/H3CAVExpkrLeU7tXQXzhSabLObtFCnGtJd1eowfIt5GI0ZZwlpKgF2qj6ylQfvEoiSx
 SfW9KKbc0HFbi/RtTLpHhXDoHE/Rw0zotmXe17x8ANqHLNsdQVz3qzQUpfv1LJMN7pMvIPO1m
 SDd6zyAaoWIU9kyrFuWGP3jTskD/+RjQNMKyAIIC+8RAk1W8wfld4o4TnrQ7MvsTqEk6vUooi
 guil6v2tKOQ8iwr76q3jzbI281jiyBZnn0egGp8OtXVmd/zQKD5CPp4/wXDlYXd8B01JLCF0o
 dGZOR9XM7mL5z5YKCzLx9AxT5z41FRDl91vlhJl2myVhapHZl/j6TI5yi8aNJkAK3oCDulG8g
 041Oh06AZCXCTScn7WlW8J1XrhVkNrk1dmOQRq2kVIlwWOCH4D5OHN5HNrbt2F96RYWNaJxzO
 LWbrYOJPP7wcFlQ0hPjKFsFyXFT3Vth0ItQTcmKlEQeTU=

This driver uses the new rtw8703b chip driver code.

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
index 07b5b2f6ee..22838ede03 100644
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
index 22516c9846..8f47359b43 100644
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
index 0000000000..8d38d36be8
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
index 7fada7a714..7cddfdac2f 100644
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


