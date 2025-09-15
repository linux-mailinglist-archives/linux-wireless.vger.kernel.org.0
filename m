Return-Path: <linux-wireless+bounces-27283-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02CC5B570A7
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:53:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB923B6EAB
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 06:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB9772C028A;
	Mon, 15 Sep 2025 06:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="WLeElKFZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54908214236
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 06:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757919218; cv=none; b=B7DK/V1S1YFJcTY+hgwYfeypXd5qLqRL4yLoKHfGs7G3mV7yGStiXVezNauLHAQRKRiiRQOgSQcP3nmbTcH0v0DJMOSihfypWBQETZGr4H2pPrCm4pRKC+4e7BrAGkba1bedB8lVik2kWa2n/VXw8uFv0wGuiE/bUfbqzTjx1+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757919218; c=relaxed/simple;
	bh=dJGNCW8zly7mIrkRK0S5ELFPlpWkF+3Sf1abgVqxmYE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jHlNbvZApwV8wEeZO2dTLu6UP2+loUSImWppq5p81AsQY3woAEN+c2653vkC+O6MoFDe/T6ZGhvlOgUL95srC+8BnV87Paezrmv6ei/l6Vl46KDAq+mx8zwLqAd6TPykZnxorcDV6paZ6X9z9TiCL2R367m9d9FhrbyjMoDvHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=WLeElKFZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58F6rWQJ1591057, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1757919212; bh=ffl6h55QPTQAl4M9hsoa/zcq0xpt5Adarlp0cELmZQg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=WLeElKFZpvTi+64E9yRHHBq1vzYotHtvNkKsd25ThN69IYJL1F1U+fEnPCAh9LOw2
	 R3/Cc/jrpLpPA42dq2ZnA4e3M3pD8l6B6tvdafN48/Xz1LOa4SLUXrhF39cKSPhk74
	 pZQ51xxGzyr/0toZpo2+Z4dnCfP6o1uUC8vOMLT2IZtudLxmBFRwTSwn9QbMp/Xj0P
	 1a/1xBgokPy7BgO6mSP5Rt9ydl5o8s8Pzt6wiQG6WVk02PA1DY4kaQqxo6CnjUWQrp
	 iQ8NgwWck4gl+O3YsqAP2AlH0jYbIN6YXbJBR3S43D2Xz/a6z5HacTwv7B+LPvC6Af
	 bVyNmvVcjYUcg==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58F6rWQJ1591057
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 14:53:32 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 15 Sep 2025 14:53:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27; Mon, 15 Sep
 2025 14:53:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [PATCH rtw-next 00/11] wifi: rtw89: some fixes, refinements and features
Date: Mon, 15 Sep 2025 14:52:02 +0800
Message-ID: <20250915065213.38659-1-pkshih@realtek.com>
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
 RTKEXHMBS06.realtek.com.tw (10.21.1.56)

Include some fixes, such as firmware command wait with condition of C2H
event; some refinements -- PPDU status configuration, driver_data; and
some features -- WoWLAN TKIP, beacon tracking for 8852B, TAS for 8922A,
PHY AFE setting, and SER simulation.

Chih-Kang Chang (3):
  wifi: rtw89: disable RTW89_PHYSTS_IE09_FTR_0 for ppdu status
  wifi: rtw89: obtain RX path from ppdu status IE00
  wifi: rtw89: wow: enable TKIP related feature

Kuan-Chung Chen (2):
  wifi: rtw89: 8852b: enable beacon tracking support
  wifi: rtw89: 8922a: add TAS feature support

Ping-Ke Shih (2):
  wifi: rtw89: use ieee80211_tx_info::driver_data to store driver TX
    info
  wifi: rtw89: phy: initialize AFE by firmware element table

Zong-Zhe Yang (4):
  wifi: rtw89: chan: allow callers to check if a link has no managed
    chanctx
  wifi: rtw89: debug: support SER L0 simulation
  wifi: rtw89: renew a completion for each H2C command waiting C2H event
  wifi: rtw89: open C2H event waiting window first before sending H2C
    command

 drivers/net/wireless/realtek/rtw89/chan.c     |  11 +-
 drivers/net/wireless/realtek/rtw89/chan.h     |  10 +-
 drivers/net/wireless/realtek/rtw89/core.c     |  83 ++++++++-
 drivers/net/wireless/realtek/rtw89/core.h     |  26 ++-
 drivers/net/wireless/realtek/rtw89/debug.c    |  64 ++++++-
 drivers/net/wireless/realtek/rtw89/fw.c       |  76 ++++++++-
 drivers/net/wireless/realtek/rtw89/fw.h       |  50 +++++-
 drivers/net/wireless/realtek/rtw89/pci.h      |   9 +-
 drivers/net/wireless/realtek/rtw89/phy.c      | 161 ++++++++++++++----
 drivers/net/wireless/realtek/rtw89/phy.h      |   4 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   5 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |   7 +-
 drivers/net/wireless/realtek/rtw89/sar.c      |  15 ++
 drivers/net/wireless/realtek/rtw89/sar.h      |   1 +
 drivers/net/wireless/realtek/rtw89/txrx.h     |   1 +
 drivers/net/wireless/realtek/rtw89/wow.c      |  79 +++++++--
 drivers/net/wireless/realtek/rtw89/wow.h      |   6 +
 17 files changed, 531 insertions(+), 77 deletions(-)

-- 
2.25.1


