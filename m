Return-Path: <linux-wireless+bounces-14089-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A00169A0BBC
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 15:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C951C231D1
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Oct 2024 13:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E873D2076DA;
	Wed, 16 Oct 2024 13:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HeIYZcmp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 578F29443
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 13:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729085885; cv=none; b=NNIOsWfWK+dOibE7nCnAoP9kNmhrvL5diEUTjDuvlkJEn93kr0gQHojFeY0h1Dc/0RUXBKPCfdJSI0yaQRU3V7aC6gYpWPQpqKbIf1uWDaCp+rxNyA5rwPJVsksa9eKi8+OvOwwSJMryDpEVA1dVqxRaSQ58zUJh0XkhLSICJoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729085885; c=relaxed/simple;
	bh=R78z0TEI2IzmSHDsvrWpf5cjayl39LuHloQgZg0qjk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Nt21hIsobd1cvk1yNZwXYMN9BzgVKsOSoGxoTmAb3qkK+ih8WN+DlrTqoGI87u5mBEjtedcEZGLZHDyU8pd6fTP/7s016d7Ftc+QF032BWX4zrgzcw4PSXZdZVTCD07cnGypX1zTMKsLCHr5fe3TwfAuOhoBXCPTGmN5okpJ1UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HeIYZcmp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49GDbxarF3078475, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729085880; bh=R78z0TEI2IzmSHDsvrWpf5cjayl39LuHloQgZg0qjk0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=HeIYZcmpNVw/kg4dPxHGZbb177tj70tH4XwLH7Jw6WApNiI2YScyOTnabx+NjVKaG
	 msxgvrbG+pjNw264WRipObbWh65hqBUgdYy9s3iWF5dSnD7Z/NVd1yw/fqC9OG58MD
	 01iF0PH2oDAE4rLqI2naiN4J09CgMRI+AfFsX+hRdFujyRCsiwRLg1ZzJ2BBvm8Siw
	 tV81GGIoCEtYL1pMXmuCUlLM3QNWp7v8UWEhNSBwNOzKCzuXWATl21M1BJ9YBY0vtI
	 2EM/CzZ9uCN9n2R+3Ut62raPwjl/bwQU4oF8p56nIWMzL/k5YiAbX549+pERTDWUjg
	 BUrRvyt0ixd5g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49GDbxarF3078475
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 16 Oct 2024 21:38:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 16 Oct 2024 21:37:59 +0800
Received: from [127.0.1.1] (172.16.21.70) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 16 Oct
 2024 21:37:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 0/2] wifi: rtw89: add support of thermal protection
Date: Wed, 16 Oct 2024 21:37:33 +0800
Message-ID: <20241016133735.7571-1-pkshih@realtek.com>
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

Introduce thermal protection to prevent chip overheating. One of methods
is the proposal method by this patchset is to reduce TX duty.

When temperature obtained by thermal value is over a threshold, driver
asks firmware to reduce TX duty that also reduces throughput. Then,
temperature is expected to become lower and recall normal throughput.

Currently this feature is enabled by PCI subsystem ID (SSID) of sub-vendors.
Add quirks bits to represent thermal protection settings.

Ping-Ke Shih (2):
  wifi: rtw89: add thermal protection
  wifi: rtw89: pci: add quirks by PCI subsystem ID for thermal
    protection

 drivers/net/wireless/realtek/rtw89/core.c     |  9 ++++
 drivers/net/wireless/realtek/rtw89/core.h     | 22 +++++++++
 drivers/net/wireless/realtek/rtw89/debug.c    | 10 +++-
 drivers/net/wireless/realtek/rtw89/fw.c       | 46 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h       | 18 ++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      | 13 ++++++
 drivers/net/wireless/realtek/rtw89/mac.h      |  1 +
 drivers/net/wireless/realtek/rtw89/pci.c      | 31 +++++++++++++
 drivers/net/wireless/realtek/rtw89/pci.h      | 15 ++++++
 drivers/net/wireless/realtek/rtw89/phy.c      | 34 +++++++++++++-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8851be.c    |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ae.c    |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852be.c    |  2 +
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 .../net/wireless/realtek/rtw89/rtw8852bte.c   |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  1 +
 .../net/wireless/realtek/rtw89/rtw8852ce.c    |  2 +
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  7 ++-
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  8 ++++
 22 files changed, 224 insertions(+), 5 deletions(-)

-- 
2.25.1


