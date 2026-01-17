Return-Path: <linux-wireless+bounces-30920-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F72D38C47
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 05:42:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ACA96300E8DA
	for <lists+linux-wireless@lfdr.de>; Sat, 17 Jan 2026 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54F02D77EA;
	Sat, 17 Jan 2026 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s5DcBqdm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971A718C02E
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768624923; cv=none; b=MKeQFZAwlu+utNf+TzE16ugjKarIbOvZsaH85dM8T9Bg5msYQyxoAVSGQwzxigYWxNBC6HO8JlfzF3APf3vP0XYuWXQ1jIIsklcRgxkYG4OtnL1oDlCyHA+++WqtssxIJn60SmI/Rkhow/5mB1KfR8L37taPXIrsuwv9eqZog9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768624923; c=relaxed/simple;
	bh=v6//EQ1730bwvBycUI/8hNg3cu2s8/yd8q+4pSspkyg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYtgtmmiW3z8EAuT1OYol9jWqQQoA4jCe5bfKYfQ3YX0jjJvQxT/xpzm6GQjeEsw+T/P7IlOz/ZSSxWB8UrKAetrWjv3B2IKLLgWSs12BAJ6Y7jXYyhDaLYqXVU21N7ESbQqPXnvymYCVrNKJeE0L+n12SHkHA6+KZkm+UH/ips=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s5DcBqdm; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60H4fvGdB2464436, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768624917; bh=+drDrCujZCWlp3zrN8A5Tv5HR7hoX796zPBrghobnpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=s5DcBqdmMHYQnzm/FukpB5mkAqI0iexSLv85x4GeVQHmrS2MWwDY+hNszp6IBmrrb
	 13pSPgbi6hO+6EqKFhxj2i8lt4ZgNwaTUnP3NgVHU+5WwZcziRhMHUhw4ajKGWOT82
	 UZBodk32F5MCtEFHwwchrEsMc+t5LNJTXWy6JoEJz2Qm5g7/Z+UB/7p9+svMwr/1jZ
	 T68fK3p42q1P9S6Gct17wcUF+4xkFfT+ids/d2YIU5aNEHR+ibFqR4riFZuCOnxdsX
	 YznnWmMGSgWmsmidMO+B8vJOWvrL/AUIjLzJdRyHfSw/jZxlckfGpEnENvsBIavyik
	 T9EVQeo8kPrwg==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60H4fvGdB2464436
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 17 Jan 2026 12:41:57 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Sat, 17 Jan 2026 12:41:58 +0800
Received: from [127.0.1.1] (172.21.40.76) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Sat, 17 Jan 2026 12:41:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <echuang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 0/9] wifi: rtw89: update PHY RX gain, EDCCA and TSSI, and MAC settings for RTL8922DE
Date: Sat, 17 Jan 2026 12:41:48 +0800
Message-ID: <20260117044157.2392958-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

First 6 patches are related to PHY, including RX gain associated with PS
mode, EDCCA log, digital compensation of fw_elements, and TSSI. The later
three patches are related to MAC, which can improve performance but we
missed these settings previously.

Eric Huang (3):
  wifi: rtw89: phy: handle C2H event for PS mode report
  wifi: rtw89: phy: add H2C command to send detail RX gain and link
    parameters for PS mode
  wifi: rtw89: phy: update edcca log parsing for RTL8922D

Ping-Ke Shih (4):
  wifi: rtw89: phy: add chip_ops to calculate RX gain from efuse to
    support PS mode
  wifi: rtw89: phy: add firmware element of digital TX power
    compensation
  wifi: rtw89: mac: clear DTOP disable excluding CID7090 variant for
    RTL8922D
  wifi: rtw89: mac: set force MBA duration to 0

Po-Hao Huang (1):
  wifi: rtw89: 8922a: add digital compensation for 2GHz

Zong-Zhe Yang (1):
  wifi: rtw89: phy: update TSSI flow for RTL8922D

 drivers/net/wireless/realtek/rtw89/chan.c     |  23 +++
 drivers/net/wireless/realtek/rtw89/core.h     |  38 ++++
 drivers/net/wireless/realtek/rtw89/debug.h    |   1 +
 drivers/net/wireless/realtek/rtw89/fw.c       | 185 +++++++++++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  86 ++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   6 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 125 ++++++++++--
 drivers/net/wireless/realtek/rtw89/phy.h      |   1 +
 drivers/net/wireless/realtek/rtw89/ps.c       |   2 +
 drivers/net/wireless/realtek/rtw89/reg.h      |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  58 +++++-
 16 files changed, 499 insertions(+), 32 deletions(-)


base-commit: 5e632c7ca9e15a1bc1e114bcfd5210add909e7a4
-- 
2.25.1


