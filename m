Return-Path: <linux-wireless+bounces-15769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78AF59DB29F
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:54:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38812823D3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:54:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8071313DBB6;
	Thu, 28 Nov 2024 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NDUSZOYq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D97A613DB9F
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773291; cv=none; b=etAxog6WrwRDxRQMd7pDfkKl2ieCAvtech4KAxFpV6HR1jeHgrrwqK5hITQewzBb9VKrIPLRpoVS7pyXuA2tjguWAZ9Xzlan8Ba4GSkGRKWLXhYxnnGyjms/IL79qx12fwC0B0rJcqq+mpyI/U+0TyLW/g1Rw/LLMhNP7wYPI9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773291; c=relaxed/simple;
	bh=dwQgBXe8Lm8OlgtXd4YMx0AjuORSHk8n/PLqdC0myo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CqV/HozIP2LLAHeRO00whD6OyvEASsXXmrfHeJxM1EM/a/f2Iqq5bJZCwzEYeRQHixua1QrOb624zfrXe1FQYO/SHvrYKc8eyx3cFmTBmiaSUCnRGtb0DnTAtDlJDdHHjizJNvx3EH723XGv9fIenOgSkqvPdFQKseKsNsFERYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NDUSZOYq; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5sijuF3960090, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773284; bh=dwQgBXe8Lm8OlgtXd4YMx0AjuORSHk8n/PLqdC0myo4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=NDUSZOYqmqvAPX6na1DrvOuUvf6FItIeN5ntSi/oPHngyXafhuR6bNjX1/UQ9ZBgq
	 SQ8U+K+k0y/Jgp3Wdg1YH756SPSWnuSG44pA8p22L+s8G0CMDsWg/QWj5U9OvrBsCO
	 yege4MAhi1BPIBmkBKjrqxt3eLZ2UopDZDqaqhbTVU7BkrgMWJt37Z4LiqM24y1LgV
	 XNloWLkst4QpSfWUP3/ylVV72TVbLzLkWcYYmuRm75yv9pw9PbBTHEsmA+Egw7O8fU
	 HsE8kcVezN+f3J4WWDJasRk1vLoy2R9E9eWjAQBZrrKzePN51wLEwcV8h17m6cGd1c
	 DyYOyTIk4rX8Q==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5sijuF3960090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:54:44 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:54:45 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:54:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 0/6] wifi: rtw89: some changes related to fw feature bit, PHY RSSI and PHY XTAL
Date: Thu, 28 Nov 2024 13:54:27 +0800
Message-ID: <20241128055433.11851-1-pkshih@realtek.com>
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

First three patches are related to firmware command format and features.
Add them for coming firmware.

The third and fifth patches are related to PHY. The RSSI report can be
from many places of RX, but each of them could be incomplete, so add this
new one to complement. The other patch is to limit boundary when adjusting
XTAL to track peer frequency.

The forth patch is to implement ops link_sta_rc_update() according to
change of mac80211, which becomes a link-base ops.

No functional dependency within this patchset.

Chih-Kang Chang (2):
  wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
  wifi: rtw89: add crystal_cap check to avoid setting as overflow value

Po-Hao Huang (3):
  wifi: rtw89: 8922a: Extend channel info field length for scan
  wifi: rtw89: 8852b: add beacon filter and CQM support
  wifi: rtw89: 8852bt: add beacon filter and CQM support

Zong-Zhe Yang (1):
  wifi: rtw89: refine link handling for link_sta_rc_update

 drivers/net/wireless/realtek/rtw89/core.c     | 17 +++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 20 +++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       | 45 ++++++++++++++-----
 drivers/net/wireless/realtek/rtw89/fw.h       | 22 ++++++++-
 drivers/net/wireless/realtek/rtw89/mac.c      | 25 ++++++++---
 drivers/net/wireless/realtek/rtw89/mac.h      | 36 +++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac80211.c |  9 +++-
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 15 +++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 26 +++++------
 drivers/net/wireless/realtek/rtw89/phy.h      |  5 ++-
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 ++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  4 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  5 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  4 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 19 ++++++--
 drivers/net/wireless/realtek/rtw89/txrx.h     |  3 ++
 19 files changed, 223 insertions(+), 44 deletions(-)

-- 
2.25.1


