Return-Path: <linux-wireless+bounces-30521-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A117DD03CAF
	for <lists+linux-wireless@lfdr.de>; Thu, 08 Jan 2026 16:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 09C87302B518
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Jan 2026 15:23:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AF4936A022;
	Thu,  8 Jan 2026 08:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2E5CYQP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC1AB2DB790
	for <linux-wireless@vger.kernel.org>; Thu,  8 Jan 2026 08:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767861360; cv=none; b=ZYQsQMsbBqnDOLdDNqkaktyH4vZB6MZJZRBPmJHmwHJKRQBDq8776q0kaLCUljYDPr9iZs44k8ki7yoZgC0r99mHo7UVVC7z1JipyD0cIsTZOox6GjIlFfu3lSDulkWbNXO/3V/1mL2x11lu54xUEcnXenL3qbBu65E0gWmOw5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767861360; c=relaxed/simple;
	bh=LT5XC5zCCViACD1X+dNxSNes1AtqIYKYo33UAqQZLkc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=u4NwngTPYzbrvSgDkl+njxuUjJh7zRaXWGdoxMtydwJwtYS0bYx6xNFQ9mG5c4M8qMYPkFpioqsr882mrYeNoJv/02Ef9tc13js8gECWH0Wv1/9SPHUnLboe7N4Wts3bnB7jXz0a+/jhbXocUVwRFeME8BV9I0VeoMCHFFjyh9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2E5CYQP; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767861353; x=1799397353;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LT5XC5zCCViACD1X+dNxSNes1AtqIYKYo33UAqQZLkc=;
  b=T2E5CYQP8S+HIiBUb1QOfjULm3WKbSLI8jZRXKwuwFuSyI90AR6tb2yv
   57BAhctlWb4u6y+6lYerucwpCBDm4DOOZRdaHUz62x9TwqgnW8AqianwJ
   8XWjBHnB8czMHiT8JXJ4RDZglNyhvX/fuFRdIxyPzyR/ZFjBuIAJsWkMq
   NtQEzCySgkIDy6v6aNPpvIVFhTbnMbxOscSOf51ksGcglQ8dZy1qiUXQ0
   8ouaNfCUFYyd6myW/QeWo3j54PmxUxw0PfYQr5bHGQ3GMDsWgkq/pELY8
   HMmK843985T4TP2MriLXOwW8b5JsqHvpZmUdgvwLa/4f3qxvfrFEVQQ/q
   A==;
X-CSE-ConnectionGUID: 1EpRZftMQKmgnWhtGtlv1w==
X-CSE-MsgGUID: chn1kVmyQZ+bT+/JUUZhAg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="73084777"
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="73084777"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:50 -0800
X-CSE-ConnectionGUID: OyagcUHcRBu6ld0hBh/nWQ==
X-CSE-MsgGUID: /EEIJ9XiSv2hj3Q/lvUWcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,210,1763452800"; 
   d="scan'208";a="233847438"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2026 00:35:48 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next v2 00/14] wifi: cfg80211/nl80211: Add NAN Data Path support
Date: Thu,  8 Jan 2026 10:35:26 +0200
Message-Id: <20260108083540.3129471-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

This series adds support for Neighbor Awareness Networking (NAN) Data
Path in cfg80211/nl80211. This includes support for:
- Local and peer NAN schedule configuration
- A new netdev interface type for NAN data communication
- NAN management and data stations
- TX/RX support

Patches 1-4: refactoring and preparaion
Patches 5-8: NAN channels and local schedule support
Patch 9: NAN_DATA interface type support
Patches 10-11: NAN stations and local phy capabilities
Patch 12: Peer NAN schedule
Patches 13-14: TX/RX for NAN DATA 


Daniel Gabay (1):
  wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data
    interfaces

Miri Korenblit (13):
  wifi: nl80211: refactor nl80211_parse_chandef
  wifi: cfg80211: remove unneeded call to cfg80211_leave
  wifi: nl80211/cfg80211: support stations of non-netdev interfaces
  wifi: cfg80211: refactor wiphy_suspend
  wifi: nl80211: don't allow DFS channels for NAN
  wifi: cfg80211: Add an API to configure local NAN schedule
  wifi: cfg80211: store the chandefs used for NAN
  wifi: cfg80211: make sure NAN chandefs are valid
  wifi: cfg80211: add support for NAN data interface
  wifi: cfg80211: separately store HT, VHT and HE capabilities for NAN
  wifi: nl80211: add support for NAN stations
  wifi: nl80211: define an API for configuring the NAN peer's schedule
  wifi: nl80211: allow reporting spurious NAN Data frames

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |   9 +-
 drivers/net/wireless/ath/ath6kl/main.c        |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  20 +-
 drivers/net/wireless/ath/wil6210/main.c       |   3 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |   5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  23 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |   2 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  24 +-
 .../net/wireless/marvell/mwifiex/uap_event.c  |   7 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  26 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  26 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |   6 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  12 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  24 +-
 include/net/cfg80211.h                        | 230 ++++-
 include/uapi/linux/nl80211.h                  | 177 +++-
 net/mac80211/cfg.c                            |  22 +-
 net/mac80211/chan.c                           |   2 +
 net/mac80211/iface.c                          |   3 +
 net/mac80211/rx.c                             |   2 +
 net/mac80211/sta_info.c                       |   4 +-
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   4 +-
 net/wireless/core.c                           | 115 ++-
 net/wireless/core.h                           |   9 +
 net/wireless/mlme.c                           |   4 +-
 net/wireless/nl80211.c                        | 829 ++++++++++++++++--
 net/wireless/nl80211.h                        |   5 +-
 net/wireless/pmsr.c                           |   5 +-
 net/wireless/rdev-ops.h                       |  62 +-
 net/wireless/reg.c                            |  27 +-
 net/wireless/sysfs.c                          |  36 +-
 net/wireless/trace.h                          | 153 +++-
 net/wireless/util.c                           |  26 +-
 net/wireless/wext-compat.c                    |   6 +-
 35 files changed, 1605 insertions(+), 308 deletions(-)

v2: add commit "wifi: cfg80211: remove unneeded call to cfg80211_leave"
to the series. It was sent separately but should really be part of this
series, otherwise it contains a deadlock
-- 
2.34.1


