Return-Path: <linux-wireless+bounces-30117-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 50139CDE5EA
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 07:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 529943005ABC
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Dec 2025 06:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9865A27A45C;
	Fri, 26 Dec 2025 06:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="p3Gk/NqM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63C2C29E101
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 06:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766729705; cv=none; b=R2/AdNGTl4X4jruaG8eaFJjlH/5CurOYitZrcqJj7L3nLV3yYYBTSRWj0/3/6PB9Nvhm1BARyIt7Q1ybgNYEbXFopeuhmcSkKo9gv/+LFDmL36lmUO+PvotaQ9SDYEJSeIfPhAfFYNmxtTA53wO7jPUdD6zddEZH14PNFvxAXCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766729705; c=relaxed/simple;
	bh=Gm9YN0SoxhU5CWh3yRNwfUDxpEeAttcZ2nMNBAwwjgc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=s+lYWaRJEYO4gk37U5v7z9hP1XP1I4UPB00/iqE3u1ZXnGriSOHu0SK9pxlxgNF/tl1XBfoWTI8Xmn4xRfr21U5OEP+hhiCTSvQz/4eVkpvB9ZsrWF0O9wNPZYaD6DEC/KNh+wdpvt76k2zdrOrz5cr/h1EnYZuq4iO1reRhho0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=p3Gk/NqM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5BQ6F01Y03112775, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1766729700; bh=srAZhMbVxtmAWZ+GIqloj/hiDKfOhkjXcQfHpBtuNWw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=p3Gk/NqMn8RxF9i6HMB6zHYLtDLqU0tk6Wj1U5/c2O4fy1cv+TwqH71qzsk+Uzeuq
	 MrIj0nWJ+10aTjgmJrvfbaStZDWLgaDVLwiV+3yajWi4ehmZyyyaJK7yuC43pqNk4e
	 J4l6u3rP2V7ghO+bf4vzH9DxT1S+t21qZWIAJ+BiBQG9hpJU97nvKUFJD7XhmhcuFi
	 7N3vJnLbJlG0nOLu+5AqxjOUyGcXG/f72w1XH/IUxHnSyIEM1ZUkhpw6ll3xSuqilp
	 8k+16yRBR9QTH+T4BeSo4Q/kmlaZ+Yah035DjBMxax5/GhmXfcw0fIW/phUjynjn4C
	 uImMVH95Joh7g==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5BQ6F01Y03112775
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 26 Dec 2025 14:15:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:00 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Fri, 26 Dec 2025 14:15:00 +0800
Received: from [127.0.1.1] (172.21.40.75) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.10 via Frontend
 Transport; Fri, 26 Dec 2025 14:15:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <timlee@realtek.com>,
        <dian_syuan0116@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/12] wifi: rtw89: more preparations for 8922D and refine of MCC
Date: Fri, 26 Dec 2025 14:14:34 +0800
Message-ID: <20251226061446.63514-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

The first eight patches are preparations to abstract common flow for
8922D, including WoWLAN, TX/RX aggregation capabilities, hardware chip ID,
and default quirks.

Patches 8 and 9 are to refine MCC that two channels are operating
simultaneously.

Patch 10 is to correct 6GHz power type; patch 11 is better beacon loss
handling.

Chih-Kang Chang (2):
  wifi: rtw89: refine TX nulldata judgement when scan with 2 OP channels
  wifi: rtw89: 8922a: configure FW version for SCAN_OFFLOAD_EXTRA_OP
    feature

Chin-Yen Lee (3):
  wifi: rtw89: wow: use struct style to fill WOW CAM H2C command
  wifi: rtw89: wow: add WOW_CAM update function for 8922D
  wifi: rtw89: wow: abstract DMA check register for RTL8922DE

Dian-Syuan Yang (1):
  wifi: rtw89: enhance connection stability when triggering beacon loss

Kuan-Chung Chen (1):
  wifi: rtw89: define TX/RX aggregation and MPDU capability per chip

Ping-Ke Shih (4):
  wifi: rtw89: wow: change type of WoWLAN pattern mask to __le32
  wifi: rtw89: efuse: read hardware version from efuse for WiFi 7 chips
  wifi: rtw89: read chip ID for RTL8922D variants
  wifi: rtw89: add default quirks as features to chip_info

Zong-Zhe Yang (1):
  wifi: rtw89: regd: 6 GHz power type marks default when inactive

 drivers/net/wireless/realtek/rtw89/core.c     |  40 ++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  26 ++-
 drivers/net/wireless/realtek/rtw89/efuse.c    |   4 -
 drivers/net/wireless/realtek/rtw89/efuse.h    |   6 +
 drivers/net/wireless/realtek/rtw89/efuse_be.c |  26 +++
 drivers/net/wireless/realtek/rtw89/fw.c       | 166 +++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       | 126 +++++++------
 drivers/net/wireless/realtek/rtw89/mac.c      |  11 +-
 drivers/net/wireless/realtek/rtw89/mac.h      |  13 ++
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c   |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   7 +
 drivers/net/wireless/realtek/rtw89/regd.c     |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   6 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   2 -
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   8 +-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   8 +-
 drivers/net/wireless/realtek/rtw89/wow.c      |   4 +-
 21 files changed, 342 insertions(+), 142 deletions(-)

-- 
2.25.1


