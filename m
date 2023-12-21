Return-Path: <linux-wireless+bounces-1150-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C178C81BC36
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 17:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7DDE7284615
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 16:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6976539F8;
	Thu, 21 Dec 2023 16:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tB/XxQZX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/JoTo/M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C5E55E68
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 16:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Martin Kaistra <martin.kaistra@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703177042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aSygvLvTthPd559pqe9YTU8NPDJ1TN86SpHZ1+KXmqI=;
	b=tB/XxQZXZBV7/KUGZvjwebYm04una3nOVwRcIkI5OSme+Do/WopX6rFCDVbK9qOznTd9Iw
	Xju10zskii4OvxBk24VeEhHUDEH8uoLzK0sTkACawIvZqXIrlrCEcvTHTFJU/azt49Hm56
	dm6iMZXI4MCLFYKcJOnTmg0FVNTSXZmYxh8XNgiaFsLWc3E0ofmfE/yHV/VxC7PhLL+ZQe
	uSB7oxeUAW9dD3GCpnBAzOgMskKrtzmdTF9HThQBNnsvMF+4MKZh4OGFjDPMGfpIBeOUd0
	AIMvLoopt2vnK8YI/FGmMwvSK3/KspuDrpMN4E2pBqrwDvO0mQ7Hts9g94VZ6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703177042;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=aSygvLvTthPd559pqe9YTU8NPDJ1TN86SpHZ1+KXmqI=;
	b=Y/JoTo/MolHtd0MySGcmipFRu8tLTdufF45m7qrMS1rQHSVHsxnz2Lxye+AmwnT/nnm00V
	2EgcJ5MhFZYAPUCQ==
To: linux-wireless@vger.kernel.org
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>,
	Kalle Valo <kvalo@kernel.org>,
	Ping-Ke Shih <pkshih@realtek.com>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2 00/21] wifi: rtl8xxxu: Add concurrent mode for 8188f
Date: Thu, 21 Dec 2023 17:43:32 +0100
Message-Id: <20231221164353.603258-1-martin.kaistra@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series adds the possibility to use two virtual interfaces on the
same channel. Supported combinations are STA+STA and STA+AP. The
conversion of the driver to support multiple interfaces is split into
individual patches to hopefully make it easier to understand what is
going on.

Thanks,
  Martin

changes for v2:
- collect reviewed-by tags
- coding style changess
- ignore CFO for STA+STA
- extend watchdog_callback to call refresh_rate_mask for both interfaces
- remove port_num check for BEACON change notifications
- add macids for STA mode
- add number of sec cam entries to rtl8xxxu_fileops
- add comment to switch_ports about using the function in the future

v1: https://lore.kernel.org/linux-wireless/20231218143645.433356-1-martin.kaistra@linutronix.de/

Martin Kaistra (21):
  wifi: rtl8xxxu: remove assignment of priv->vif in
    rtl8xxxu_bss_info_changed()
  wifi: rtl8xxxu: prepare supporting two virtual interfaces
  wifi: rtl8xxxu: support setting linktype for both interfaces
  wifi: rtl8xxxu: 8188e: convert usage of priv->vif to priv->vifs[0]
  wifi: rtl8xxxu: support setting mac address register for both
    interfaces
  wifi: rtl8xxxu: extend wifi connected check to both interfaces
  wifi: rtl8xxxu: extend check for matching bssid to both interfaces
  wifi: rtl8xxxu: don't parse CFO, if both interfaces are connected in
    STA mode
  wifi: rtl8xxxu: support setting bssid register for multiple interfaces
  wifi: rtl8xxxu: support multiple interfaces in set_aifs()
  wifi: rtl8xxxu: support multiple interfaces in
    update_beacon_work_callback()
  wifi: rtl8xxxu: support multiple interfaces in configure_filter()
  wifi: rtl8xxxu: support multiple interfaces in watchdog_callback()
  wifi: rtl8xxxu: support multiple interfaces in
    {add,remove}_interface()
  wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
  wifi: rtl8xxxu: support multiple interface in start_ap()
  wifi: rtl8xxxu: add macids for STA mode
  wifi: rtl8xxxu: remove obsolete priv->vif
  wifi: rtl8xxxu: add hw crypto support for AP mode
  wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
  wifi: rtl8xxxu: declare concurrent mode support for 8188f

 .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h  |  18 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188e.c         |   2 +-
 .../realtek/rtl8xxxu/rtl8xxxu_8188f.c         |   2 +
 .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 381 ++++++++++++++----
 4 files changed, 312 insertions(+), 91 deletions(-)

-- 
2.39.2


