Return-Path: <linux-wireless+bounces-30443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id D8928CFDE46
	for <lists+linux-wireless@lfdr.de>; Wed, 07 Jan 2026 14:20:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D18E3002D3A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Jan 2026 13:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D10831AAA3;
	Wed,  7 Jan 2026 13:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BcKIdDFW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D330327BF3
	for <linux-wireless@vger.kernel.org>; Wed,  7 Jan 2026 13:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767792015; cv=none; b=FBQFm1GdWjCWKyqYkftaQuyuAKJ20MQNeJE0XSHaQF/J+RxTQWl8bp2gqYYUnaPcGYn/j3rFmPNQ4Xr7MlbEgGT8PdvDOXBKsdFbKVCjnJt/ih2EkBre6gLP9Gd9pIBKzPdGmSAhSPXjuz71bBOxiH+jAhf9UxDmyOvpBJyucOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767792015; c=relaxed/simple;
	bh=uilpgffz43SYPyMwofGLUgCndJb7cQNfzooRyzuzgjk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cAwPFmQQdKdB1OMFkxoRiSB5QI9VmtXfffO2QK2p12nSH2f5Mho7IbRlvSBlTefOGoZWGHk8fRpcQWuI2xiZoed/Z6UAKL2AWfYBeRs1RZyMyxAJmFUtDKQT/nYqZg+C/tPgzq14JXMWS80yjyi8LDbEicUclG39RyMqTb9Q4eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BcKIdDFW; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1767792013; x=1799328013;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uilpgffz43SYPyMwofGLUgCndJb7cQNfzooRyzuzgjk=;
  b=BcKIdDFWQ30D7kCeJtBEeUPmMmXqGXN1N65G9ek3MI3/0tQVlbx/4j2g
   Kmg6VuanLA9bueUAldRpXzB3AIIctM4xZBHmNUPNVqlthwPfQ8ebl1rMb
   /hMyjdB7b4m08XVGuTaCdwVfAW0hWUScUR4hsm2r24lJjiZz6ktMY7X3b
   nJusbc4qRlOV5FJcDVTKzMONLtBbvUDQS9zEL80zo1Qc++OmzYXa2qfkv
   o8h+/EGRUDmm9Ea6qnrK+LLpeCcAFMSOzwMl7tOd8yYnYJV0F7qECN1OZ
   mLCvjB5u3MO5BM7hTUY1mHIf6sZbajBFQi7LMZeiyNuqojv1Xcr4ZgzgT
   w==;
X-CSE-ConnectionGUID: WaZTxnRlRZS/BKJiB09UjA==
X-CSE-MsgGUID: D8zLZ3SrRretuZjpsGznkg==
X-IronPort-AV: E=McAfee;i="6800,10657,11664"; a="86576840"
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="86576840"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:13 -0800
X-CSE-ConnectionGUID: H5OqwIoWTjqm7v9GmrWHQw==
X-CSE-MsgGUID: dH4RiaqGRnCAGcPr+HcrNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,208,1763452800"; 
   d="scan'208";a="203185633"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jan 2026 05:20:11 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: cfg80211/nl80211: Add NAN Data Path support
Date: Wed,  7 Jan 2026 15:19:48 +0200
Message-Id: <20260107132003.2291979-1-miriam.rachel.korenblit@intel.com>
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
- Key configuraion for NAN (for secured data path and for pairing)

For a detailed design see the DOC section in include/net/cfg80211.h.

Patches 1-3: refactorings and preparaion.
Patches 4-7: NAN channels and local schedule support
Patch 8: NAN_DATA interface type support
Patches 9-10: NAN stations and local phy capabilities
Patch 11: Peer NAN channel schedule
Patches 12-13: TX/RX for NAN DATA
Patches 14-15: Security

Avraham Stern (2):
  wifi: cfg80211: support key installation on non-netdev wdevs
  wifi: cfg80211: allow protected action frame TX for NAN

Daniel Gabay (1):
  wifi: cfg80211: allow ToDS=0/FromDS=0 data frames on NAN data
    interfaces

Miri Korenblit (12):
  wifi: nl80211: refactor nl80211_parse_chandef
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

 drivers/net/wireless/ath/ath6kl/cfg80211.c    |  25 +-
 drivers/net/wireless/ath/ath6kl/main.c        |   4 +-
 drivers/net/wireless/ath/wil6210/cfg80211.c   |  33 +-
 drivers/net/wireless/ath/wil6210/main.c       |   3 +-
 drivers/net/wireless/ath/wil6210/wmi.c        |   5 +-
 .../broadcom/brcm80211/brcmfmac/cfg80211.c    |  41 +-
 drivers/net/wireless/marvell/libertas/cfg.c   |   8 +-
 .../net/wireless/marvell/mwifiex/cfg80211.c   |  36 +-
 .../net/wireless/marvell/mwifiex/uap_event.c  |   7 +-
 .../wireless/microchip/wilc1000/cfg80211.c    |  44 +-
 .../net/wireless/quantenna/qtnfmac/cfg80211.c |  38 +-
 .../net/wireless/quantenna/qtnfmac/event.c    |   6 +-
 drivers/net/wireless/virtual/virt_wifi.c      |  12 +-
 .../staging/rtl8723bs/os_dep/ioctl_cfg80211.c |  33 +-
 include/net/cfg80211.h                        | 242 ++++-
 include/uapi/linux/nl80211.h                  | 177 +++-
 net/mac80211/cfg.c                            |  44 +-
 net/mac80211/chan.c                           |   2 +
 net/mac80211/iface.c                          |   3 +
 net/mac80211/rx.c                             |   2 +
 net/mac80211/sta_info.c                       |   4 +-
 net/mac80211/util.c                           |   1 +
 net/wireless/chan.c                           |   4 +-
 net/wireless/core.c                           | 114 ++-
 net/wireless/core.h                           |   9 +
 net/wireless/ibss.c                           |   4 +-
 net/wireless/mlme.c                           |  13 +-
 net/wireless/nl80211.c                        | 877 +++++++++++++++---
 net/wireless/nl80211.h                        |   5 +-
 net/wireless/pmsr.c                           |   5 +-
 net/wireless/rdev-ops.h                       |  94 +-
 net/wireless/reg.c                            |  27 +-
 net/wireless/sme.c                            |   4 +-
 net/wireless/sysfs.c                          |  36 +-
 net/wireless/trace.h                          | 215 +++--
 net/wireless/util.c                           |  30 +-
 net/wireless/wext-compat.c                    |  12 +-
 37 files changed, 1765 insertions(+), 454 deletions(-)

-- 
2.34.1


