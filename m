Return-Path: <linux-wireless+bounces-29687-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F4ECB7BA1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 04:13:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 762F3301C3D8
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 03:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 714572512C8;
	Fri, 12 Dec 2025 03:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="FSrz/T+z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C02821E091
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 03:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765509191; cv=none; b=FUSK+XNG/nHlZLbPIeQFwoSRjiA2qHhqJGVZGlme9P4QM4ZOVRK9UkvlI8lgmq0g2k02ev6PZSesscmc+Hj6+8+B/Tjnx3FgLYOh1qNygjqwTRXiYEJgNyedhardiPgd3Hs+d7hHy7p+odSh2igo7fGVO2w0oXonTuyGlYrJEQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765509191; c=relaxed/simple;
	bh=2p5YxsSaR7D1NB8YPq/nndqPeF+y1/zqXmXn7RJ1hM8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FJbVkH0h3mdf1lmCItf9NMxq3W5/2t1kL/L/vl8yezGqJB7XD1rcBkdDGHo4e4F0Xl+T53FK92FolUUZoiWRBp8oZsV6umPUMX+TQkTgkU/ywnEf6jG6tqlEMMTEKZYT73HUaMeN19p4xSXiJXeRUeRr86dDqsg6M+XY5tVH1LE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=FSrz/T+z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BC3D4xU43499506, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1765509184; bh=G7q1Dw40/dr7HfdOt2xV8/qQJ8+CbuIFfhyT2CYzJDo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=FSrz/T+ziYrM8K490UNqdzHlpdo9yA9igmsc9U8SUEHqabZX9mkamtrBKOqqU88f7
	 6sksv86PMK2qqH+mUrWO49VNPSndj5JT7jvvLAWJgwalKkbzHsRSl6+Bmzqdb+eVzC
	 AcL1Q9uQJaA4LARMIYNCyOq7gSp1YiFOqgRdY3B7kuTunN9JM1mVQkIof6b4S5Mb8a
	 GtDrxpzPi1MUUOg8rTZZLDNBGcv+BX77difapuoUA4w/viHMEVHv8quBTF3frYN7I9
	 dC44dCwnm6jYsdhbwC/4kP7PyjtkOmYnvrKdNvMUlm4UsGCHJPOCaz+P8dWZ0dJdFb
	 bkVt9q0YRK6mg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BC3D4xU43499506
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 12 Dec 2025 11:13:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 12 Dec 2025 11:13:04 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 12 Dec 2025 11:13:04 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Fri, 12 Dec 2025 11:13:04 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: refine MLO, MCC and SER functions
Date: Fri, 12 Dec 2025 11:12:51 +0800
Message-ID: <20251212031303.19882-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Refine MLO (by patch 2-3) found by test, MCC (by patch 9, 11, 12) getting
better connection stability and SER (by patch 5-8) supporting newer flow.

Others are random features and refinements found in field.

Chih-Kang Chang (3):
  wifi: rtw89: refine C2H reg event polling timeout for LPS
  wifi: rtw89: setting TBTT AGG number when mac port initialization
  wifi: rtw89: mcc: reset probe counter when receiving beacon

Kuan-Chung Chen (3):
  wifi: rtw89: 8852b: increase beacon loss to 6 seconds
  wifi: rtw89: mlo: fix missing TX null-data 1 during link switch
  wifi: rtw89: mlo: fix incorrect link address in management frames

Ping-Ke Shih (2):
  wifi: rtw89: mac: reset power state before switching to power on
  wifi: rtw89: warn unexpected polling value of XTAL SI

Zong-Zhe Yang (4):
  wifi: rtw89: ser: enable error IMR after recovering from L1
  wifi: rtw89: ser: L1 skip polling status if FW runs event mode
  wifi: rtw89: debug: add ser_counters dbgfs
  wifi: rtw89: debug: support SER L0/L1 simulation via halt H2C

 drivers/net/wireless/realtek/rtw89/chan.c     |   5 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  13 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/debug.c    |  79 ++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  12 ++
 drivers/net/wireless/realtek/rtw89/fw.h       |   1 +
 drivers/net/wireless/realtek/rtw89/mac.c      | 124 +++++++++++++--
 drivers/net/wireless/realtek/rtw89/mac.h      |   5 +
 drivers/net/wireless/realtek/rtw89/mac80211.c |  37 ++---
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 142 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |  32 +++-
 drivers/net/wireless/realtek/rtw89/ser.c      |  10 ++
 13 files changed, 425 insertions(+), 39 deletions(-)

-- 
2.25.1


