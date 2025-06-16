Return-Path: <linux-wireless+bounces-24133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A95FADAB75
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 11:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B34DD1885E2D
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 09:07:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C36AF19D06A;
	Mon, 16 Jun 2025 09:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sLU6rPKd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EC41DDC0F
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750064814; cv=none; b=Ey14EOgMtJKxKZ5zqA3SRHq3hjvZYUYKvLKBkjeZM/bDZrI1nx3beSohiOiwO6trCo6jy9EQtaJPqjaaqNLdd4HNd7xbk/MYfLabvZ+M+WSXl1sYjRYi0oC3r+LXioRnJERKzc5pIz+XXzy5TYV0qo2DZX3Cz3bNdab6iNeuGh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750064814; c=relaxed/simple;
	bh=DGzhHSuHoAZl/SIfJ9976aOYYo1U9vQ9Pweknc6p23U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B7RB8bcNSjfyV6TlVFBthgZg7NsLhzFnHEFyOLmGg8eeMT9TLbxLjzmndt4GUX+LT/ZAji9R+zQI90UgZS/Qk+XcVUBGsH4MwzOPTorhchsxJEZJ/+hM6F5Y0/+cFI0R3a8xIosTNUrGYg12DwWkGnkZ3/Zd9TeA5D/KB9KsE3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sLU6rPKd; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G96omfE178550, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750064810; bh=WXnMAdXBRuPrSB/PSHTgubEJPdSwEM0HsspMZ6+covU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=sLU6rPKdWBhwBiUk9BP4227vyaXKZU1vVcKd/omSIsiB72rzpNkSWdhgsGpkIfj9E
	 HtHbWuprdfvIFWpSeMlqRW8wsxOZF61G20lWJn1W4X462gFhmmYbPgf1WGMhZsQmXg
	 YfRYVRxhRB4Q/v870NfFMXfSYN31fuU/SlfBs8c38evxiPaw9VSd5z0hCTSX5GTUjl
	 hKGYB5J8juzxhJk1QfJmFpB/A0aZk/a6mUMCNoD9GfW9LQer+/Glez/4AYKnRH+cbh
	 wrkp0DNrKcPelPqGMemnOaP5fAbeRDjkHd9d6al+/oiPgYKkivxFMvc1Cq3XAQQwQp
	 77VIqW1e/MV2A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G96omfE178550
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 17:06:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 17:03:18 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 16 Jun
 2025 17:03:16 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <ku920601@realtek.com>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: coex: update to support latest firmware of RTL8922AE
Date: Mon, 16 Jun 2025 17:02:41 +0800
Message-ID: <20250616090252.51098-1-pkshih@realtek.com>
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

Update BT-coexistence accordingly for the latest firmware, which supports
new events format, new messages from BT firmware and so on. Also, fine
tune parameters to improve user experience reported in field.

Ching-Te Ku (11):
  wifi: rtw89: coex: Add v1 Bluetooth AFH handshake for WiFi 7
  wifi: rtw89: coex: Enable outsource info H2C command
  wifi: rtw89: coex: Query Bluetooth TX power when firmware support
  wifi: rtw89: coex: RTL8922A add Wi-Fi firmware support for v0.35.71.0
  wifi: rtw89: coex: Get Bluetooth desired version by WiFi firmware
    version
  wifi: rtw89: coex: Update scoreboard to avoid Bluetooth re-link fail
  wifi: rtw89: coex: Assign priority table before entering power save
  wifi: rtw89: coex: Not to set slot duration to zero to avoid firmware
    issue
  wifi: rtw89: coex: Update Bluetooth slot length when Wi-Fi is scanning
  wifi: rtw89: coex: RTL8852B coexistence Wi-Fi firmware support for
    v0.29.122.0
  wifi: rtw89: coex: Update Wi-Fi/Bluetooth coexistence version to 9.0.0

 drivers/net/wireless/realtek/rtw89/coex.c     | 297 ++++++++++++++++--
 drivers/net/wireless/realtek/rtw89/core.h     |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 -
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 -
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   1 -
 8 files changed, 282 insertions(+), 34 deletions(-)

-- 
2.25.1


