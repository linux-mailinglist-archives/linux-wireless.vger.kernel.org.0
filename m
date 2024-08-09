Return-Path: <linux-wireless+bounces-11163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F52B94CB1D
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDAFF1F24323
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 07:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9144012FB34;
	Fri,  9 Aug 2024 07:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GaO1414z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDD9717BA2
	for <linux-wireless@vger.kernel.org>; Fri,  9 Aug 2024 07:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723188045; cv=none; b=Es7/CDF2K7v6dQnb0wuqDvrnO0Vq4OEIS/SCj3S341wT+yi078jk/hR23Swisr7yC9FxSInDxni7ieh6W8iIorGhgU0tVJJI25tHW0UjRBvfvbHw9Fy6G5flB4STqLY5BLIeaDAvDw9+c/HcnfAZuId+Z7Rkcdb2U4nlwOYmU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723188045; c=relaxed/simple;
	bh=99ybslGaACto+3+fBjxNGyGoYr87+Dy/kAGMEEjXRRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Yub9x6l1qh2/Rd3dEw3X8+dJas1/VUJ2iQS63o30Md/WIYCt8PaSxqdaA+T9Un4viMWcUolMhBQiTJGuKLBFASptuu+yvFfzJcOwgNWRBHNPTZQvEV+RAAvauYFZTT+MX5+b6haSKmNvBfK16cqO/UxLtRwPvmgRV/2dqGMZvRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GaO1414z; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4797KdPyA514056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723188039; bh=99ybslGaACto+3+fBjxNGyGoYr87+Dy/kAGMEEjXRRQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=GaO1414zndU+TeaxJzB8lQUTaOOR09E4rXkbJ7ohiATKyYpJiCywVMcfZnVPDXaax
	 4Rj7pZB4K8yRf5M58ovRO6AN+Q/+H1eAEfBzY975LXRJUbj0XsB+lVGnPYyj21pvMY
	 bTzugEYrrlMHtV4XlXfVS3cHdc04rNzW0Ecd2/0yRHFKfkNRnJlD/u8MyzrDK22yo5
	 r7HX4Hx5b8+933ZFDenBB1JQBtSS+YS/1ddpaJtBdHL2ZDgvfZzrBDC+lRqt7OS2o5
	 VO7rSRkWVxUf74HQaZeBsyT/zT5g8hfm7Bqeij4RG8RFVHktzhv9wKjwQ3tDKNLkkW
	 fA9FjMu4LTS3Q==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4797KdPyA514056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 9 Aug 2024 15:20:39 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 15:20:39 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 9 Aug
 2024 15:20:38 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <damon.chen@realtek.com>
Subject: [PATCH 0/6] wifi: rtw89: some fixes and support of multiple adapters debugging
Date: Fri, 9 Aug 2024 15:20:06 +0800
Message-ID: <20240809072012.84152-1-pkshih@realtek.com>
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

Patch 1/6 is to support fw_element for 8852C. Without this, it will use
original tables built in driver.

Patch 2/6 is to improve TX EVM to yield better performance.

Patch 3-4/6 are to fix Coverity warnings.

Patch 5/6 is to improve 8852A I/O time wakeup from power save mode.

The last patch is to support multiple adapters debugging like rtw88 did.

Chin-Yen Lee (1):
  wifi: rtw89: 8852a: adjust ANA clock to 12M

Kuan-Chung Chen (2):
  wifi: rtw89: 8852c: support firmware with fw_element
  wifi: rtw89: 8922a: add digital compensation to avoid TX EVM degrade

Ping-Ke Shih (3):
  wifi: rtw89: remove unused C2H event ID
    RTW89_MAC_C2H_FUNC_READ_WOW_CAM to prevent out-of-bounds reading
  wifi: rtw89: correct base HT rate mask for firmware
  wifi: rtw89: debugfs: support multiple adapters debugging

 drivers/net/wireless/realtek/rtw89/core.c     |   2 +
 drivers/net/wireless/realtek/rtw89/core.h     |  14 ++
 drivers/net/wireless/realtek/rtw89/debug.c    | 156 +++++++++---------
 drivers/net/wireless/realtek/rtw89/debug.h    |   2 +
 drivers/net/wireless/realtek/rtw89/mac.h      |   1 -
 drivers/net/wireless/realtek/rtw89/phy.c      |   4 +-
 drivers/net/wireless/realtek/rtw89/ps.c       |   7 +-
 drivers/net/wireless/realtek/rtw89/reg.h      |   3 +
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |   6 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |   1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |   1 +
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 100 +++++++----
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  61 ++++++-
 15 files changed, 238 insertions(+), 122 deletions(-)

-- 
2.25.1


