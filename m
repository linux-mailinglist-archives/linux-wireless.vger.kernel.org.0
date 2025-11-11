Return-Path: <linux-wireless+bounces-28819-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7840FC4B342
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 03:25:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520BF1892EDD
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Nov 2025 02:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2EB7347BCA;
	Tue, 11 Nov 2025 02:25:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Z27zk5HD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EDF2BCF43
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 02:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762827929; cv=none; b=YVxxx8po6KoT0q1dia3u9EMY6B6zciqyxlngkViBKcNYPCOLBAvZ4lcDaRG9nBBv4CDKNQRiSSlM9zBH7xH6M9rACYwu25PvAY6YOgpgo6xjEu/73xrcYj3XzrRuRnRLedTta/Bs6PWaAi9fMBi9RV+ZpS2/x+BRkvyQZ16iGtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762827929; c=relaxed/simple;
	bh=uOjAgw7e7VmgvRiZG9HvoEJW0kXu+4/gp2bErZ9qpuA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Ruo5ItIUBeEIJa0uAb2i6e/dRgjD/1BZGYJGPUb8qrzV0Y/Ws6VT5rc+6aEq1LnCnQgs+HqjdJvQxUjNyCY3X+bkwYNSWX8cZ3VTSoFyfujssRi31Enal1Qz7Zn5nbwIx5q7zL8hHVQHuNa/uYXp9Vx8o4+BQPXCj6lava2bR1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Z27zk5HD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AB2PP8D02921455, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1762827925; bh=WpPwFgQB0f2iQ7N0DKX8T+QDtwzjdNHoFu1FfGQ9xSU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=Z27zk5HD73cRGmxN7LV0mAT17k7YQVKBi0Ym9zTgxKco3OR0VL3cj6FHDsfeNcSED
	 LCsoyyFOTkhTEUcjN/bk1qP1zAxV0FaCv/QzG0i1YZ7wTqgBckEjY5YwNitlAJKyO/
	 GlBCzr04+MHb4cNZKvepBqU1kHUlOYe83ikkDhXR8mdOTJALeaWVxIZlw0RaVIJ4Lv
	 D7zJrUQ6PClPBoEyJcV0JdPPgZMenUyChnwMY68u/bBYiWMIFJUzvpcibikmmoGMgn
	 uoV+kMLA/eK+68dKa19qBK3lNw8Ab0n20xGw/LGAlmHUrh3ZbF7re8hMdC1qZsx61n
	 uDoTN3lsdEYsQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AB2PP8D02921455
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 11 Nov 2025 10:25:25 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:25 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 11 Nov 2025 10:25:25 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 11 Nov 2025 10:25:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH v2 rtw-next 0/8] wifi: rtw89: update rate/bw/GI for injection, and add diagnosis to debugfs
Date: Tue, 11 Nov 2025 10:24:44 +0800
Message-ID: <20251111022452.28093-1-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

First three patches are to add diagnosis to debugfs. This feature is to
provide hints to see if MAC hardware went wrong to assist debugging quickly.

Patches 6-8 are related to monitor mode. First is to support injection with
rate/bw/GI. Second is to do calibration on the channel running monitor mode
to have better receiving performance. Third is to configure RX antenna, so
we can test RX performance individually.

Others are patch 4 which implements extension of thermal value programmed
in efuse, and patch 5 fixes Coverity warnings.

v2: rebase on top of rtw-next branch.

Kuan-Chung Chen (1):
  wifi: rtw89: phy: fix out-of-bounds access in
    rtw89_phy_read_txpwr_limit()

Ping-Ke Shih (7):
  wifi: rtw89: pci: add to read PCI configuration space from common code
  wifi: rtw89: fw: parse firmware element of DIAG_MAC
  wifi: rtw89: debug: add parser to diagnose along DIAG_MAC fw element
  wifi: rtw89: 8852c: add compensation of thermal value from efuse
    calibration
  wifi: rtw89: consider data rate/bandwidth/GI for injected packets
  wifi: rtw89: do RF calibration once setting channel when running pure
    monitor mode
  wifi: rtw89: configure RX antenna if chips can support

 drivers/net/wireless/realtek/rtw89/core.c     |  85 +++++
 drivers/net/wireless/realtek/rtw89/core.h     |  17 +
 drivers/net/wireless/realtek/rtw89/debug.c    | 299 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.c       |  15 +
 drivers/net/wireless/realtek/rtw89/fw.h       |   6 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   2 -
 drivers/net/wireless/realtek/rtw89/mac80211.c |   9 +
 drivers/net/wireless/realtek/rtw89/pci.c      |  16 +
 drivers/net/wireless/realtek/rtw89/phy.c      |  20 ++
 .../wireless/realtek/rtw89/rtw8852b_common.c  |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  41 ++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  12 +-
 12 files changed, 517 insertions(+), 11 deletions(-)

-- 
2.25.1


