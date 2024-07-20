Return-Path: <linux-wireless+bounces-10406-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D1E8937EB7
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 04:14:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 119EB1C21012
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Jul 2024 02:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2B7E1;
	Sat, 20 Jul 2024 02:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="k2uZTgDV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B045AB64A
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 02:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721441664; cv=none; b=b+r6/hEAlKnyWw+EAN+E8ut5tPfEeYq3ca3KLpXFRI68l+9udjuN7221x6ZQG2ikTOvvc1O7JLfYTHK/sTQxH4S0GIN5GTArMhrIuZtz/pYIo7PNGngnFGUUBLsPmPgDzaW9+CE8LIOvBIVyiL+zt9CGQLxNoLkBN0SJwbIZ+mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721441664; c=relaxed/simple;
	bh=qZSJ5QJ6QhWOkRfZtOMrtXexHLbuspVEPJxWLqBq2Dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=L2XK6pp6ll41sxdkQ0J5dynYjgpMzNB9TvIa8O1i/xOkGarCspgxmTSc43ndFnYb+D/BJC2W4D4c143AqYWiqj4FuSAsIIokXTonHBUp9xiUvMlXdJ+bhp5l+VDkbimpvWQ4g3d2Tlu0ataW4UbDiE0L9XyHnGyqppCCghGPUTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=k2uZTgDV; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46K2EIIp81147467, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721441658; bh=qZSJ5QJ6QhWOkRfZtOMrtXexHLbuspVEPJxWLqBq2Dc=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=k2uZTgDViuo2/svtNj8yen/ne2eBTT6BlN3P0WNOddu1Cb3oLefl6O6wNdzNNkKgE
	 2yx6P03Rsu1sqq8cTCHpg/G1bfIGjFxD2h26SHC/ilRKyZeeOTPP3R7ZzmNas12YmB
	 TtzNyjUHB9i2hd4RromgEkxoaYQ02CUPCcdliv4Kj7B9hVbUTq9/RumdI+j7RKOI7O
	 PzWh8WqKZ6G5ogQYTOe6rYq0P3SO5WjJZIH0ZUYt/7CBTs5YRaF3vZhoiBdQrDSnee
	 6oVGj70sdisFe6EsVLhqpD9IKUsB7MgpxRfIipoVjUPIRXtjKHE7gz+ikrxmouK+/W
	 uIKnt5B/PyBKA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46K2EIIp81147467
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 20 Jul 2024 10:14:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 20 Jul 2024 10:14:18 +0800
Received: from [127.0.1.1] (172.16.22.168) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 20 Jul
 2024 10:14:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v3 0/7] wifi: rtw89: 8852bt: enable 8852BE-VT
Date: Sat, 20 Jul 2024 10:13:33 +0800
Message-ID: <20240720021340.12102-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Add remaining materials and enable 8852BE-VT. Fow now, STA, AP and P2P
modes can work well, and throughput is around 900+ Mbps for TX/RX. Only
BT-coexistence code needs further update to work with BT enabled.

v3:
 - add an new patch at 2/7 to avoid clang warning of precedence of
   '?:' and '&'.

v2:
 - add missing RTW89_8852BT entry to Kconfig by patch 6/6
   (Reported by kernel test robot)

Ping-Ke Shih (7):
  wifi: rtw89: 8852bt: add set_channel_rf
  wifi: rtw89: 8852bt: rfk: use predefined string choice for DPK
    enable/disable
  wifi: rtw89: 8852bt: add chip_info of RTL8852BT
  wifi: rtw89: 8852bt: add chip_ops of RTL8852BT
  wifi: rtw89: 8852bt: declare firmware features of RTL8852BT
  wifi: rtw89: 8852bte: add PCI entry of 8852BE-VT
  wifi: rtw89: 8852bt: add 8852BE-VT to Makefile and Kconfig

 drivers/net/wireless/realtek/rtw89/Kconfig    |  15 +
 drivers/net/wireless/realtek/rtw89/Makefile   |   8 +
 drivers/net/wireless/realtek/rtw89/coex.h     |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   4 +
 drivers/net/wireless/realtek/rtw89/fw.h       |  17 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   7 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   6 +
 drivers/net/wireless/realtek/rtw89/reg.h      |  58 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    | 830 ++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8852bt.h    |   2 +
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 228 ++++-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   3 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  93 ++
 13 files changed, 1268 insertions(+), 5 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c

-- 
2.25.1


