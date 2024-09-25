Return-Path: <linux-wireless+bounces-13135-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC9FC9850CD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 04:02:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 188161C2306C
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885CE148FF0;
	Wed, 25 Sep 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bF1trDQ1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF11814831D
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 02:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727229725; cv=none; b=LExf8AJxdb9q2Gg4snsXQhnbuBJfy+4QijgvyHSSc7+8bKZ6YPSggV9ue0fGYbpS/OI6ps7cdxtQELXphbzzpePwlys0YE8+76Ie1AD1S9IeZkBnqcfnAVr/6tE73nXcMZh0ICr64gYYg1NUWYFiCZCZ6OkLVKiz/Fz8ldIe5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727229725; c=relaxed/simple;
	bh=oL4O5XJtIVXzRe9sABhTlFcCEUVrDRd/GSx98IF7fxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XeqoY6ZG7Jw0MEIVaDEFAGBZb5GdY3L+8b7H4yeyY7XOmv72bOx5N56XXYEY6/k+0YJA+HGLwNQbKOppCHxvRMzBp8NXWp0KGqSaGrmK2ctj6IjbEgIAwWpNz3+/X83YsUBaT1m9nnZIkMl9XlFOlcgTimMFNbhaoJxJgEIR8PM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bF1trDQ1; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P221yaC3859915, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727229721; bh=oL4O5XJtIVXzRe9sABhTlFcCEUVrDRd/GSx98IF7fxI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=bF1trDQ1VnQdvsu/QVCsJyg8zL/rQlewebh8aFGtVtHU0W+/ObOGbX9OJQEuZf2hD
	 fxABzDQpqbeq2Eih7P680UEraJx1DnGvKHqHCiPSXA/xGpq4ITSGMvc9tWNK949LiR
	 tu6x1rOBswlcE+xQQ9OROh5EEy1Kv1CcukbhF8rJkyW/RaoiVVtkBmf2E5SsZAikH0
	 9TpptVjS9xbP+6fiu0ptAknZtv6O2tVcK1us4umab+VQoR4naLIITjuHFxR3rW6GAO
	 PXUlyUxAMdXCRe0GZBK6KiwLC3xxrsJy8ZQ7/A8W4jh87SBKA7qzT6hJovUDp2mkpe
	 zAoYJU3bJ6pPw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P221yaC3859915
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 10:02:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 10:02:01 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 25 Sep
 2024 10:02:01 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 0/2] wifi: rtw89: configure two HW bands as preparation of MLO
Date: Wed, 25 Sep 2024 10:01:17 +0800
Message-ID: <20240925020119.13170-1-pkshih@realtek.com>
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

Originally we only configure first hardware band, and now we should
configure second hardware band or both bands for MLO.

Zong-Zhe Yang (2):
  wifi: rtw89: initialize dual HW bands for MLO and control them by link
  wifi: rtw89: handle entity active flag per PHY

 drivers/net/wireless/realtek/rtw89/chan.h     | 11 ++-
 drivers/net/wireless/realtek/rtw89/core.c     | 37 ++++----
 drivers/net/wireless/realtek/rtw89/core.h     | 21 +++--
 drivers/net/wireless/realtek/rtw89/fw.c       | 33 ++++---
 drivers/net/wireless/realtek/rtw89/fw.h       |  4 -
 drivers/net/wireless/realtek/rtw89/mac.c      | 15 +++-
 drivers/net/wireless/realtek/rtw89/mac.h      | 17 +++-
 drivers/net/wireless/realtek/rtw89/mac80211.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  2 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 90 +++++++++++++------
 drivers/net/wireless/realtek/rtw89/phy.h      |  4 +
 drivers/net/wireless/realtek/rtw89/phy_be.c   | 12 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 17 +++-
 13 files changed, 180 insertions(+), 85 deletions(-)

-- 
2.25.1


