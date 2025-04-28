Return-Path: <linux-wireless+bounces-22130-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E376EA9EEFD
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 13:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB56617B86E
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Apr 2025 11:25:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4C826388C;
	Mon, 28 Apr 2025 11:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZzRkKjMv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E8281B4138
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839542; cv=none; b=tZ/My43R4eRFX6B1GjDcHsYZ/eU/HAV/oOuzvCrmnAyIHcSWyjDRmurMVH2yeZAePWJoVJDhFMifXatL1ROvDqubGzIJ5s15hxaTtQt6ioUaP8SzevgG5S15cVlZKG2X2yL1FkKkiBpswc5c9D6flk+jzhidsSiK02m1di1O4KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839542; c=relaxed/simple;
	bh=nsPXbOQcouj0KPTJJt2PfDYN21JPZ168oyYuTIG6ItI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A836RZN3RLcyaUUtzez4jdLsOpNwITza1oStsawIJBFAByQBieIHVTtrWUbb2Io652j0YEWkdYxu2O7Dsz21RbMdliusxdLAAXSj/SzymfOIyu+g04a/s4m+ZnrLMYHpLv0jHicjfwYyAhxwIpBpqBLrqHLe6ILtd8E5pWU2KRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZzRkKjMv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53SBPaK222101184, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745839536; bh=nsPXbOQcouj0KPTJJt2PfDYN21JPZ168oyYuTIG6ItI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ZzRkKjMvQCOgTws0tC69eso8cTL/hiVF1QDq4U7Jc1JRsX7rbQ6dxcWyGCZtRl3mX
	 NlqVZ+ckGZWmMC1Rz61EdEPJl1oRUu7Q5Yk1prrnwWosIJDnsaMeEMLLTEbqVCbWp2
	 PV+Ajmt7gb0H7gGWxT0+1w9d8vLTbzAmMXvCXIXBlrTw5NC2aaUx7XSNjLzNzTXL/f
	 toYjCpLYIu+cHEdLx7dXYH6ErW1K7R1sC/mGFVSYLUWDQux/0ILDHUJZhC0rMgjOW6
	 EZcEFp6lOghaycteAvAIaQJpzzYk/7bLpdg5hqug7IcSrgm6SA6dMKXIW+z5BsYxdM
	 hLiEDX1M3LEVw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53SBPaK222101184
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 28 Apr 2025 19:25:36 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 28 Apr 2025 19:25:36 +0800
Received: from [127.0.1.1] (172.16.19.226) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 28 Apr
 2025 19:25:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/10] wifi: rtw89: refine TX/RX logic as preparation to support MLO
Date: Mon, 28 Apr 2025 19:24:46 +0800
Message-ID: <20250428112456.13165-1-pkshih@realtek.com>
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

To support MLO, two HW will work simultaneous, and driver needs to decide
which HW to transmit packets corresponding to selected link. Therefore,
refine TX logic to achieve this.

For the RX path, read the received HW from RX descriptor, and report
corresponding link id to mac80211.

Ping-Ke Shih (1):
  wifi: rtw89: 8922a: rfk: adjust timeout time of RX DCK

Po-Hao Huang (6):
  wifi: rtw89: 8922a: use SW CRYPTO when broadcast in MLO mode
  wifi: rtw89: Adjust management queue mapping for [MLO, HW-1]
  wifi: rtw89: Configure scan band when mlo_dbcc_mode changes
  wifi: rtw89: extend join_info H2C command for MLO fields
  wifi: rtw89: add MLD capabilities declaration
  wifi: rtw89: Fill in correct Rx link ID for MLO

Zong-Zhe Yang (3):
  wifi: rtw89: extend mapping from Qsel to DMA ch for MLO
  wifi: rtw89: roc: dynamically handle link id and link instance index
  wifi: rtw89: introduce helper to get designated link for MLO

 drivers/net/wireless/realtek/rtw89/cam.c      |  4 +
 drivers/net/wireless/realtek/rtw89/chan.c     | 23 ++---
 drivers/net/wireless/realtek/rtw89/chan.h     |  2 +-
 drivers/net/wireless/realtek/rtw89/core.c     | 95 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/core.h     | 16 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 28 +++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  3 +
 drivers/net/wireless/realtek/rtw89/mac.c      |  2 +
 drivers/net/wireless/realtek/rtw89/mac80211.c | 21 ++--
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  4 +-
 drivers/net/wireless/realtek/rtw89/txrx.h     | 31 ++++++
 drivers/net/wireless/realtek/rtw89/wow.c      |  3 +-
 17 files changed, 169 insertions(+), 68 deletions(-)

-- 
2.25.1


