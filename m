Return-Path: <linux-wireless+bounces-10378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F6929373FE
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 08:25:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40DB61C21AEB
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 06:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25AD329CE6;
	Fri, 19 Jul 2024 06:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="kd+XFJ2X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 164B61B86E7
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721370295; cv=none; b=Avba3pzfjzIXv3YNVIOeI7CdawuONc/9FDNVO0qZHJ92stycSnQGEjYAJZImcb63N7qDJ7S3jOaqnTRHLRxvc1efPTo9b4/ocQX+aahWyrO15zvQe5R7jAtjKNeBV7cW7RgOsKGYNUoEEuKsUFHWdzV+9TDgcMREZnygBWFJq04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721370295; c=relaxed/simple;
	bh=nKirzCmGU2rWMwfX0WeSOH0yPYlvYOrwuRWBBKyZtds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PNI9SnTPh0N+hpE+PTJZma3wLcoQYqf1APpjxodOYDS+in5C58mbgDvocxdujmJHIV/8gapACsrSV4k/pROFB1lJKtTD0YMLhCrymQCiyYO27Xy0teImLEoLnsWrbsOKzGmc89I6ETHwI2qtKuBRSAm47K1mc8JZGBSDLdXSdhk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=kd+XFJ2X; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46J6OoRF2182601, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721370290; bh=nKirzCmGU2rWMwfX0WeSOH0yPYlvYOrwuRWBBKyZtds=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=kd+XFJ2X/Ua3YiSvTbwyaVqSkJc3kRvPWKJUl/7o8LuB7gCDfq/k05oCngNstiROg
	 7ACyRtbTPMS1ILWGVWFD1oESuJBL8qNf2ZlXxLhychYQJozxH6c8Sl97mwcKv5kU6A
	 7KpLv4yMF2nNhLDzjKU/2Xf3ncLtYlL50iMDDajBXZiV/+55E3MD66YZO0OQpSRNIE
	 XtDpaPqUjoUxncoqjBLmA6O4UpM8+HGFeOwzHl005bunlfveImsvNUzxPoQNnvgCw+
	 kM1lLmW1j1ni+u9WMKS47HseSNYXL4Sc9I1CBdfidhfomDkjkwPn8D4RMnrzXwi/gZ
	 JUFAq+sRcJlxQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46J6OoRF2182601
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 14:24:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 19 Jul 2024 14:24:51 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 19 Jul
 2024 14:24:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH v2 0/6] wifi: rtw89: 8852bt: enable 8852BE-VT
Date: Fri, 19 Jul 2024 14:24:08 +0800
Message-ID: <20240719062414.21953-1-pkshih@realtek.com>
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

v2:
 - add missing RTW89_8852BT entry to Kconfig by patch 6/6
   (Reported by kernel test robot)

Ping-Ke Shih (6):
  wifi: rtw89: 8852bt: add set_channel_rf
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
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 226 +++++
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |   3 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  93 ++
 13 files changed, 1267 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bt.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8852bte.c

-- 
2.25.1


