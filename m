Return-Path: <linux-wireless+bounces-4508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 119F68770CD
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 12:57:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91F61281A6C
	for <lists+linux-wireless@lfdr.de>; Sat,  9 Mar 2024 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 779D1374D4;
	Sat,  9 Mar 2024 11:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="sTufG0mq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E13FA22612;
	Sat,  9 Mar 2024 11:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709985461; cv=none; b=dNM71PNKmc8VL6pVIHDRb2GnPEDWpnkSd0MoqAL/ekuAhqBAFspFd5AZTvGnBUixHMkZFhfbqfkGPq/c/lo/z8HBEBlObqren1jmjiWVcI9uDW3b8nlAeCUtido7sOjKW7rSGIZz6tiy8nW8NLgM58MS6XlsZ8B/V+a5uclTRBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709985461; c=relaxed/simple;
	bh=Do3jN5CcuhLPhWl0DEQ3pyZoDmUQS19YwPwPANcgouE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=seWwggiSUbWRNqvyLbWMoTM06bgrmjbO3RZK7vTzTXcfRPd5tUllVEfkK+HJa5yA//MHSdLZz0LYve8xoC+0XVtrAArfHa3tjGiI7Rv2jNUhpVYOF9gbifB58pm5i0L7vCN5MUczDKUuuNZNJuWuM81XU5OsNc5ekHAihbh3mDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=sTufG0mq; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1709985441; x=1710590241; i=fiona.klute@gmx.de;
	bh=Do3jN5CcuhLPhWl0DEQ3pyZoDmUQS19YwPwPANcgouE=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=sTufG0mq536PxkgIVaJDMPaxcCX/C0ZA8vsfV6lJQE6M8epp/FqgaaKffRuLK0SX
	 eF7FzLrLzAv5Kwjw8Arxl9LVPqprDrh9tlbyMY9oN2dW0yGsrIFMqpe5MVDmghJeK
	 7z0ZyHIup35J3xplFwZNi/38MG9HX2RVkV/SWFoJfLr9h0jJRL+944qy4XnPpn2+l
	 mZydniuR2SUmaXeuUgIAtWMVVhZm42HbjOEBI2a6Cc5lHNRmQ0LPyxRduMk332p5o
	 syQ7aASgblQHBKua/RRiHvBm1z/qd8VvL1vqU+QxsJ9VeUAL/OEryJuy+3m6x6SRL
	 AYIYgtKUO7iYLwI+tQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.112.71]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1N0G1d-1qwKec0xSZ-00xJLu; Sat, 09
 Mar 2024 12:57:21 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Fiona Klute <fiona.klute@gmx.de>,
	Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>
Subject: [PATCH v3 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Date: Sat,  9 Mar 2024 12:56:36 +0100
Message-ID: <20240309115650.367204-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:AjJE1XckzQTfF3Oi5ZFc2dyURXjwhM164Gf+hA1MthIzDzcSXrw
 EMwOTkj7ADYjlkD0/gFppanmGCSER5imuITfHuIuxvlPvOiy79FPft8bfku1XCKyZVblHfe
 JwpWsJt8iESQX7DGXr99yAHK7KyvrWffIrX8zdofai/EoHGHSxPmItdcejqTYWnZ2njx7gc
 Klovf9Yp8/wug1EgOH/Vw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:ary083shjtM=;Ax7IIpWfpZJzirnf3wOiA0BMHSV
 +pOBrvC0AJhP9KqNXpODGNdC4tZCYeLQtl2MnXioaR52Fzq82MQIvWwENwdQIvKTr/XR2sOf0
 2lZTwz5IHOqvM4+aRgbmKvOg8CrrEBi8nVaVVxiXPGwwS1fLQzq6DpywyqIhDSJhxqxwoh6/L
 vSut20y+a/hMyJf5j+Pww4IJHyaGP+lmtZQLT7jL1QiLSFhNcYbyORdQIS7vVhFz0RBiUFl6F
 dfyRCClpP8BuXxi3r7T9wiXSFM/yoGCI5EXMq8msdI0NmtKG7dc6HOUCu2arodeFUU9m9yQZ4
 0Zt+QrOnKKygZkiZ85t0QSAMjAun+YwvinvtAo66wqAVEfBzRxKVLFKfgFKqigyuvROtzyUHG
 M5J+VN3xeRKsiNUe4umxd3QnX+7IxfMTz1UKhemqlWectfPTeQT3I1ZftCV9J3/ZhGiUuDppt
 kHOMl6RLyekxAkAmFbdGFEEW9GQ/5YCmshYYny5x1svynpN+1uwNEyX66xbx+Z4HDeNW6Vxie
 hNhtxoZbo556ucJFkvi47/awVm4EIljPHN/dpvmqrUocZ9twsQeRWFMBC5Ptfo1QTO2E1OwKX
 0XFJORUaLSz8eamxe0XuINvtfmGYcRMiKQeaWno4rE7WZxFVKqW3JMMhnRAoF9Kr/Ki/PIjv0
 Z1tAYlZjenReIX9isBLL6DW/+c6ZWv3IdZXeZNkNUXhDv+FoijSz0mffSAavvwy/KkvRnnpOe
 XH1qw7QfwjnMaHp6dVY3E1qpWWUYB1WB45pAUDbflx1n3P/WFaFltN0lLJjgtEDDqvJuh+v9w
 h27rLtjOlf8ish99CZMqUcE4unK7aralNLMSEJCjFNQvo=

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
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2112 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h |  102 +
 .../wireless/realtek/rtw88/rtw8703b_tables.c  |  902 +++++++
 .../wireless/realtek/rtw88/rtw8703b_tables.h  |   14 +
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  673 +-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  269 +--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  721 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  518 ++++
 include/linux/mmc/sdio_ids.h                  |    1 +
 14 files changed, 4486 insertions(+), 900 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h

=2D-
2.43.0


