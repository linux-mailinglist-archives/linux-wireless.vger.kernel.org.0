Return-Path: <linux-wireless+bounces-3016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DCE0846FD4
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 13:11:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FF101C25652
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Feb 2024 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A884713DBA9;
	Fri,  2 Feb 2024 12:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b="gpgu+1LA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6355213541C;
	Fri,  2 Feb 2024 12:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875888; cv=none; b=HCW+/168rhH1aTneo7q9CAJ/KF9XLQcJVAOlGmEj04DOrOS2XSb2rW5iYrhOQckbKzMPOnIXhM6KEC1k7+p1gnu3PiZZDNd7ljhHohrs+gngFfyfyu9VHFmki/sx1CAFsLsxnUPaGjL9zh+kA/N//bS078q3Y83DA4JUku71mSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875888; c=relaxed/simple;
	bh=4AhjPzXaUJ5bsF3nimywB/bT0/Vklgsm0DU2i4x7WXA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SbjXhNTc0qV2haZY6RQQlaQwXYfRSg+hcVv84i1U6rXa0mlMYCkAHqeWZ68RjCK1ut3AX62rgbGX/yRTEmgMvvDPSeQOZZHMcgVNs8cmNFfOAxEAvTgNynM6i+050QfLVaHhm9sAubWyaoB59U/9pHDwbKLjcp8mIjDeOkA4QCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de header.b=gpgu+1LA; arc=none smtp.client-ip=212.227.15.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1706875873; x=1707480673; i=fiona.klute@gmx.de;
	bh=4AhjPzXaUJ5bsF3nimywB/bT0/Vklgsm0DU2i4x7WXA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
	b=gpgu+1LA7ax/lLpYm9BVhiX3dRGmjLCRAYhlqegKU/Cv3neb8FYKqWQSu+3An9/W
	 eA5o5SWXN/BJvugypmRVWg4y6blegKBXi5KiAWrzNOruBkJqoZhXKvmV+VHdvfdb5
	 ykerzqQH+Kpfk1gu2BjJAWpMfR62YPyDhELy18X2qANGT59saSyRdJBKl06hzqD51
	 doHb82zJ60qWs79WCtVfy8P+ppGXeIGEUCBVthgF2hPONO+AVqDE43X81QLErSx2o
	 3HcqMllK8vMYK5I9OKufwCMnAywxy9VTpIUvNTZm58W/iZK/E5dKQdjEcjnlHqNyT
	 RdR7YqN6+97a2uAd2Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from haruka.lan ([85.22.17.32]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MQMyZ-1rjGNM0lN3-00MJz4; Fri, 02
 Feb 2024 13:11:13 +0100
From: Fiona Klute <fiona.klute@gmx.de>
To: linux-wireless@vger.kernel.org,
	Ping-Ke Shih <pkshih@realtek.com>
Cc: Kalle Valo <kvalo@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	linux-mmc@vger.kernel.org,
	Pavel Machek <pavel@ucw.cz>,
	=?UTF-8?q?Ond=C5=99ej=20Jirman?= <megi@xff.cz>,
	Fiona Klute <fiona.klute@gmx.de>
Subject: [PATCH 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Date: Fri,  2 Feb 2024 13:10:39 +0100
Message-ID: <20240202121050.977223-1-fiona.klute@gmx.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:1F++Ow/K5+kHhUQ/XQf6G9ou6ba2ls07noywmqqqx8Y8WI4nnCn
 xTnaQTr3DutqufWflKdcxQW5EvrV6XqfOWqDLUgh88OOLCbvoCLAJWcnwy6ovJJ5UFy9Vpt
 m6SGwpCzo+UV3ko3cdaHQdpEFQ0T9I1zbdTBxfXxTHI2vBYcjPo05P0y6rSauIdpUO9tgvd
 TvR5jZKSiOgF53eG1A9nQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:YkD51cJZ2QY=;uxO7GGG5JJcUpU5uS+Ys28DPW62
 oKtF7GSdUWjN/InDDpf8wDUV8gxuCVXGFkK3/RWLTuac9t5tT5zCX7eFljeuq0UHkW4P6J30O
 /vuUGMsIemLZcNKz29/QQLQVn7I2ih3dkdBfzb5L46XOCp7bzcREFj7X8hvRBEErF1LaIiFWG
 JxBt8CTGfMvFUkZrN4l96WBIvX6moLYCK+FUX+MbU70lC2LLomeakg0ScV2pgzggtKoCL8QXJ
 iCmSM2xhZ59Ahf6Bbr0xAHkWr18z3tnfweIgHrrBqlKpFwt4ywtr6lYGWTLRoI8fn417t7w9P
 bgFwHWpUYGiSlj6/81lWLlRFh9CKxdXpxFPFZ88yNbCITmjfOp8LVQbvtXUJ/dPE/XYHTpnr2
 NM1nhs88P+B/eZngobRYfUgPqBT9A8XlV0uEyci9jx3e2WULLVrg32zoGyIEnJmB6CpYxlTMd
 vdR8AYD50IP3GKqNw3xi/SqXVXkVQrLoIhOwGLACo7uGcJTXz4KOFI4bvhLMBpt29Z3uX0Obd
 biCU6rIA1fmPBVsol8M94tsnLqdROPfYn3zb/uWcSxuioDDSJhvk6WKiPsTiiYQ8nwAhKRMkR
 fvItNIUVuBHi2pJs1GG4YYT9lwIvX82YlxdvRntZRuPRWbRgVE3dn+H60913pbXujbikePXpZ
 4DGRGzSo1sPXoOB+Qn9UzaUnypFF2xDsFtrp/AZFlnbx0+4AVYEenTz2Aan6Dc/sTFjAlxCrX
 FDbhztRaIl8ueHd9EFHenk7av2qhcOSFv5v9JAs5jh/C3yHONZ8C5ETuKTpVSZe1UdHFFti6f
 1lgBcaSjTn9LUVyIWUIlbbzmbwpdeZ91YAJj5/miwgAyg=

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

I'm trying to follow the "one file per patch" rule for new drivers
while integrating with the existing rtw88 code, please let me know if
I should split it differently. I'll be including a few questions for
reviewers in the relevant patch mails.

Thanks to Ping-Ke Shih for advice, and Ond=C5=99ej Jirman for debug logs!

Requests for testers:

* I do not have any 8723d device. I made sure rtw88_8723d still
  compiles, testing would be very welcome to make sure I didn't break
  anything while moving common code to rtw8723x.

* Does anyone actually get the "unexpected cck agc report type"
  warning? The out-of-tree driver also logs a warning and handles the
  3 bit LNA index in that case, but the code could be simpler without
  the workaround if it isn't needed.

* I've found mentions of RTL8703BS devices online which seem to be
  wifi-only SDIO devices using RTL8703B, and posts telling people they
  need to use the rtl8723cs driver to make them work. If anyone has
  one of those I'd be curious if this driver works with it.

[1] https://github.com/airtower-luna/rtw8703b-fw-extractor

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
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 2106 +++++++++++++++++
 drivers/net/wireless/realtek/rtw88/rtw8703b.h |   62 +
 .../wireless/realtek/rtw88/rtw8703b_tables.c  |  901 +++++++
 .../wireless/realtek/rtw88/rtw8703b_tables.h  |   14 +
 .../net/wireless/realtek/rtw88/rtw8723cs.c    |   34 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c |  673 +-----
 drivers/net/wireless/realtek/rtw88/rtw8723d.h |  269 +--
 drivers/net/wireless/realtek/rtw88/rtw8723x.c |  720 ++++++
 drivers/net/wireless/realtek/rtw88/rtw8723x.h |  517 ++++
 include/linux/mmc/sdio_ids.h                  |    1 +
 14 files changed, 4437 insertions(+), 900 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8703b_tables.h
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723cs.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.c
 create mode 100644 drivers/net/wireless/realtek/rtw88/rtw8723x.h

=2D-
2.43.0


