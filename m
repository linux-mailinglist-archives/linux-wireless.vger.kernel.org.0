Return-Path: <linux-wireless+bounces-4548-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 68D5D877E2D
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 11:38:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1F96B20DD9
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Mar 2024 10:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CC12E410;
	Mon, 11 Mar 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="d63pQtU5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C620E22081;
	Mon, 11 Mar 2024 10:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710153497; cv=none; b=rm9dpn7OfCQq/6t344a9Y8kQI7ehMdRr8DkJyg7aw3hIU9lErSGTvMLUWTotHoowqbIcqVDF6UET2PjNgQi6FIpWvMw+WdR0tgPNgxOT2R3+9l1nuqFNL9fss+djG12N7Z7ikwexOSXKdKbnD20L/cBy6kzlmxvy0gbO/34sWc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710153497; c=relaxed/simple;
	bh=VKI4C53tqjvymCOND4W5+jLuXV5U8d5fu41/iuhYVuA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GHq9REaZi1cgD5FNJlTO1spZKtdYSLCYiRnGDf3Do85traEV1+Dla9FvKEGbL+utl4CS6/w9bNXTy/SQcn/JGBqO146x9g1y5zcf1p0sitWVaDWwj3BmjmY4z5SBjw7Nj2n3Jcas4awo0zexD6+W2ni9yNPIa+PhEGtUqSNJLsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=d63pQtU5; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1710153479; x=1710758279; i=fiona.klute@gmx.de;
	bh=VKI4C53tqjvymCOND4W5+jLuXV5U8d5fu41/iuhYVuA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=d63pQtU5m3V8tBnN4qIhNzGxYLk7huTbbyBOt2bRfuGaOMZIqVhCdTSxN/1rQFJU
	 /kRf3P0RWUkIEu5tqhpNeUmiHcz3vHEcSy4F3OhtYD+g+Caphs/7d9mZt3HW0KPsY
	 nASAVt1AUWBXp/eqZPfa6bPHjgNc/ySCNiMwiL0crZ5MeD7nJvionwuxBg94zHZOy
	 DVsE4cyKcs5e2vaHf0xD269YAN5Dc199otNN21+mm6M8NX24qdVJQt8RGx/19Ox7z
	 FVgMzgG0SbTFJ9dsxT8vS3TEj/EWbfhZEY671kKHphuWuruEHiw8GlFM04rvvwI/y
	 k8Nxv1I5JjiVjRg/0Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.108.92]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MSt8W-1rFKcj2GLe-00UGF4; Mon, 11
 Mar 2024 11:37:59 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v4 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Date: Mon, 11 Mar 2024 11:37:04 +0100
Message-ID: <20240311103735.615541-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:HxM8l8pT6+Cfy4PtmyaRT8pSi5B9zmKU6J9IHd3KOiRQ+2VQY84
 WfZbtrVSrhAvtgmpCQzhJXgUDvw++s9xzYOst15UfQ1qY4pPSdhmi/5JN7WayP0lmA7PHTJ
 iItvvQXwDeOjFS7qMBmMlWP4gBIG+lrIxMTjt+YiRhN3lE0npeUamw/HTLs/2at4ydRLjgy
 1YN12+ASgIWOyDdkwxOOQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:JHaKhnCMtGM=;WVqbLKtoBQcd54jUWWWEnTV6zBp
 7E9vZ4IfnW7lu6oIWFucbDFd2Vhy++L0yW+pSnWghOuEfxgkhTjVsOQmOEfYuv0XjAKbarEBb
 XOCugRqqYcuvpJGzdY8aTQCJnA8GD/sibq9H7aiDhJ4jGHdfiNlzya7DpCcqrLBDiBuN/OKqx
 vC8ituHo9PHxPjzuQ1VSxn5cBdwTS93zFSLgaFAJup0ZYET+HhpVm0rr7sjjWj6Gv2In+/67w
 +4qrUuGUHNEey+VAs+LEOEsyau7EGbUDrtqhBKnFjxLOUpt4Y+SgwMwtC/cqkPERGJjA7Ukgs
 w7FlxfF77UE3ggOALSsGK/OlWlNMElH4w6Q8JSXEsi/XutokG93da5ffdY6TAakyEODHnahU4
 Wk2R8iSNRItkREzKaeGXdhOym1v/P3LxejVYgqn8z9yaK8DmB/sfer0SV1BnZyUNy6+7gPDi5
 30I7Sui62I10Wbe+G9fmbLQzYiwGJbK7On79AohhjPvAUHPONPF481vvrhuC0MN9yIltlZA1K
 pcGyqU8Cb95ZpkrrSLcBe9jpUi7YY7PXRVAoneEmIPhZ2aCEJpUIaPMNPSPc5sSAauVjjPL0P
 CBJ6PeshyWOyUL0s+v/1+EXIG8jUyuANtR04SQuS/a0Db0pJEZn/Y+IV0gUf1x2LoNUS1w1R0
 JNOl1ojiPE5gpRUzxrqXQTttXrjbEfzNidDA1PPVw9MfGS5yOt+K3Gvdgo16UXIh0+ql/GMLn
 1yRKU09sycOEH0f9dNVBG8/mA+6/28F1EJ611h0DFdkNeFck6CR7Tr5r+c10c6Cu2SXcoemVc
 AiY+NrxaKmYDyyo0Uz254BaidIpuruZpiJ0IRf7CAN+VA=

This patch set adds a driver for RTL8723CS, which is used in the
Pinephone and a few other devices. It is a combined wifi/bluetooth
device, the wifi part is called RTL8703B. There is already a mainline
driver for the bluetooth part. RTL8703B is similar to the RTL8723D
chip already supported by rtw88. I've been using the out-of-tree
rtl8723cs driver as reference.

Station and monitor mode work well enough for daily use on my
Pinephone, I have not tested other modes yet. WOW firmware is
declared, but WOW isn't implemented yet. RX rates stay fairly low
still.

Ping-Ke Shih kindly offered to add the required s-o-b for the firmware
and help get it into linux-firmware when it's time, for testing now
please see the code I used to extract firmware from the out-of-tree
driver [1].

Thanks to Ping-Ke Shih for advice, and Ond=C5=99ej Jirman for debug logs!

[1] https://github.com/airtower-luna/rtw8703b-fw-extractor

v2:
  * Parse PHY status using struct instead of macros
  * Prefer MAC from EFUSE if available, move retrieving MAC from DT to
    a separate function
  * Tidy up wait for IQK to be done, replace mdelay loop with
    read_poll_timeout
  * Set dual author for rtw88_8723x
  * Add missing "static" to rtw8723x function declarations, fixes
    build failure when not built as a module
  * Various style fixes

v3 has only minor changes requested in review, so I hope it's good to
merge now:
  * rtw8703b.h: #include rtw8723x.h instead of linux/types.h and
    linux/compiler_attributes.h
  * rtw8703b_tables.c: #include rtw8703b_tables.h
  * rtw8703b.c: define TRANS_SEQ_END without braces (checkpatch.pl
    doesn't like this, but I assume maintainer request overrides it)

v4:
  * Move definition of GET_RX_DESC_BW from rtw8703b.c to rx.h (now in
    patch 3/9 "wifi: rtw88: Add definitions for 8703b chip")

Fiona Klute (9):
  wifi: rtw88: Shared module for rtw8723x devices
  wifi: rtw88: Debug output for rtw8723x EFUSE
  wifi: rtw88: Add definitions for 8703b chip
  wifi: rtw88: Add rtw8703b.h
  wifi: rtw88: Add rtw8703b.c
  wifi: rtw88: Add rtw8703b_tables.h
  wifi: rtw88: Add rtw8703b_tables.c
  wifi: rtw88: Reset 8703b firmware before download
  wifi: rtw88: SDIO device driver for RTL8723CS

 drivers/net/wireless/realtek/rtw88/Kconfig    |   22 +
 drivers/net/wireless/realtek/rtw88/Makefile   |    9 +
 drivers/net/wireless/realtek/rtw88/mac.c      |    6 +
 drivers/net/wireless/realtek/rtw88/main.h     |    3 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2109 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h |  102 +
 .../wireless/realtek/rtw88/rtw8703b_tables.c  |  902 +++++++
 .../wireless/realtek/rtw88/rtw8703b_tables.h  |   14 +
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  673 +-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  269 +--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  721 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  518 ++++
 drivers/net/wireless/realtek/rtw88/rx.h       |    2 +
 include/linux/mmc/sdio_ids.h                  |    1 +
 15 files changed, 4485 insertions(+), 900 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h

=2D-
2.43.0


