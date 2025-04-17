Return-Path: <linux-wireless+bounces-21640-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED73A91EBB
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 15:52:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E277463E34
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Apr 2025 13:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FF924EA9A;
	Thu, 17 Apr 2025 13:52:48 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ABCC24EA93
	for <linux-wireless@vger.kernel.org>; Thu, 17 Apr 2025 13:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744897968; cv=none; b=Q2g+zL+GxToMb0XpUQYvKPYdJxNc2fI4v1ZeT7RohN6x9ZZh1TnxEC6MTQs6z0TMO7xxaXMdb184LqTYU2yLse8OERkHcOxwTFLzDgcaJvEnVapbAqySXoux+eJTzJvgmQfJ00FX3GSlDU0SYHgYfao3rwdWnlKFshoPcs/TwXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744897968; c=relaxed/simple;
	bh=mIdcHIkvVisF1/bHzmhp6NT/agzhRnJY+azcTVHYjt4=;
	h=From:To:Cc:Subject:Date:Message-Id; b=a8iiZpQYB/EO5AsPwQfWcMgWq8iV9LH7EpwS/dsQS5rcIFNyM3NUbPlZi6R3/uGyGLT4YXAk3hklR/Oj+Io5vjeipdtsEHFlA+0QLrAEpCtmvo6v2Mdoif7knRtufGMeLDbta5vwZq5AmXUsGYWQuAeAQMTAujYkL6RxuSqvuJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
X-CSE-ConnectionGUID: dKOiQutdRp+htgFYPh3MxQ==
X-CSE-MsgGUID: Fd5Sat8SSTu22I6LuUwOWQ==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 17 Apr 2025 22:52:43 +0900
Received: from localhost.localdomain (unknown [10.14.100.3])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id E8A864005B3F;
	Thu, 17 Apr 2025 22:52:39 +0900 (JST)
From: Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
To: linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>
Cc: Sergiy Petrov <sergiy.petrov.ue@bp.renesas.com>,
	Viktor Barna <viktor.barna.rj@bp.renesas.com>,
	Gal Gur <gal.gur.jx@renesas.com>,
	Alexander Savchenko <oleksandr.savchenko.dn@bp.renesas.com>
Subject: [PATCH 00/38] wireless: ra6w driver for Renesas IEEE 802.11ax devices
Date: Thu, 17 Apr 2025 16:51:58 +0300
Message-Id: <20250417135236.52410-1-oleksandr.savchenko.dn@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>

Renesas Electronics Corporation publishes to the opensource new
wireless driver for an own 802.11 chipset family - RA6Wx.
The chip supports dualband functioning over SDIO interface.
The chip supports 1x1 nss, 20MHz and functioning in AP/STA modes.
The driver architecture is FullMAC.

The current patchset is considered to be published in form of RFCv1.
If there are any suggestions/propositions - we will be glad to fix them and
eventually share the driver with the community in form of an official patch
(including the firmware binaries).

The RFC is divided into separate patches on a per-file basis to simplify
the review process.

Driver src aligned to kernel version 6.15-rc2.

Alexander Savchenko (38):
  wireless: add Renesas vendor
  renesas: add Kconfig
  renesas: add Makefile
  ra6w: add cfg80211.c
  ra6w: add cfg80211.h
  ra6w: add cmd.h
  ra6w: add core.c
  ra6w: add core.h
  ra6w: add ctrl.c
  ra6w: add ctrl.h
  ra6w: add dbg.h
  ra6w: add dbgfs.c
  ra6w: add dbgfs.h
  ra6w: add dev.c
  ra6w: add dev.h
  ra6w: add if.h
  ra6w: add indi.c
  ra6w: add indi.h
  ra6w: add params.c
  ra6w: add params.h
  ra6w: add q.c
  ra6w: add q.h
  ra6w: add recovery.c
  ra6w: add recovery.h
  ra6w: add rx.c
  ra6w: add rx.h
  ra6w: add sdio.c
  ra6w: add sdio.h
  ra6w: add stats.c
  ra6w: add stats.h
  ra6w: add status.c
  ra6w: add status.h
  ra6w: add testmode.c
  ra6w: add testmode.h
  ra6w: add tx.c
  ra6w: add tx.h
  ra6w: add Makefile
  ra6w: add Kconfig

 drivers/net/wireless/Kconfig                 |    1 +
 drivers/net/wireless/Makefile                |    1 +
 drivers/net/wireless/renesas/Kconfig         |   12 +
 drivers/net/wireless/renesas/Makefile        |    2 +
 drivers/net/wireless/renesas/ra6w/Kconfig    |    8 +
 drivers/net/wireless/renesas/ra6w/Makefile   |    9 +
 drivers/net/wireless/renesas/ra6w/cfg80211.c | 2519 ++++++++++++++++++
 drivers/net/wireless/renesas/ra6w/cfg80211.h |  266 ++
 drivers/net/wireless/renesas/ra6w/cmd.h      |  978 +++++++
 drivers/net/wireless/renesas/ra6w/core.c     |  286 ++
 drivers/net/wireless/renesas/ra6w/core.h     |   99 +
 drivers/net/wireless/renesas/ra6w/ctrl.c     | 1649 ++++++++++++
 drivers/net/wireless/renesas/ra6w/ctrl.h     |  100 +
 drivers/net/wireless/renesas/ra6w/dbg.h      |   47 +
 drivers/net/wireless/renesas/ra6w/dbgfs.c    |  201 ++
 drivers/net/wireless/renesas/ra6w/dbgfs.h    |   22 +
 drivers/net/wireless/renesas/ra6w/dev.c      |  233 ++
 drivers/net/wireless/renesas/ra6w/dev.h      |   16 +
 drivers/net/wireless/renesas/ra6w/if.h       |   41 +
 drivers/net/wireless/renesas/ra6w/indi.c     |  581 ++++
 drivers/net/wireless/renesas/ra6w/indi.h     |   59 +
 drivers/net/wireless/renesas/ra6w/params.c   |  387 +++
 drivers/net/wireless/renesas/ra6w/params.h   |  149 ++
 drivers/net/wireless/renesas/ra6w/q.c        |  134 +
 drivers/net/wireless/renesas/ra6w/q.h        |   39 +
 drivers/net/wireless/renesas/ra6w/recovery.c |   87 +
 drivers/net/wireless/renesas/ra6w/recovery.h |   21 +
 drivers/net/wireless/renesas/ra6w/rx.c       |  274 ++
 drivers/net/wireless/renesas/ra6w/rx.h       |  105 +
 drivers/net/wireless/renesas/ra6w/sdio.c     |  505 ++++
 drivers/net/wireless/renesas/ra6w/sdio.h     |   38 +
 drivers/net/wireless/renesas/ra6w/stats.c    |   94 +
 drivers/net/wireless/renesas/ra6w/stats.h    |  100 +
 drivers/net/wireless/renesas/ra6w/status.c   |  117 +
 drivers/net/wireless/renesas/ra6w/status.h   |   73 +
 drivers/net/wireless/renesas/ra6w/testmode.c |  649 +++++
 drivers/net/wireless/renesas/ra6w/testmode.h |  150 ++
 drivers/net/wireless/renesas/ra6w/tx.c       |  254 ++
 drivers/net/wireless/renesas/ra6w/tx.h       |   69 +
 39 files changed, 10375 insertions(+)
 create mode 100644 drivers/net/wireless/renesas/Kconfig
 create mode 100644 drivers/net/wireless/renesas/Makefile
 create mode 100644 drivers/net/wireless/renesas/ra6w/Kconfig
 create mode 100644 drivers/net/wireless/renesas/ra6w/Makefile
 create mode 100644 drivers/net/wireless/renesas/ra6w/cfg80211.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/cfg80211.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/cmd.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/core.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/core.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/ctrl.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/ctrl.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbg.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbgfs.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/dbgfs.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/dev.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/dev.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/if.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/indi.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/indi.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/params.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/params.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/q.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/q.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/recovery.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/recovery.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/rx.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/rx.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/sdio.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/sdio.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/stats.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/stats.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/status.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/status.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/testmode.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/testmode.h
 create mode 100644 drivers/net/wireless/renesas/ra6w/tx.c
 create mode 100644 drivers/net/wireless/renesas/ra6w/tx.h

-- 
2.17.1


