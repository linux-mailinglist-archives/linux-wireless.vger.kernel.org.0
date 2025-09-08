Return-Path: <linux-wireless+bounces-27082-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62349B48BCE
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 13:17:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 606831B26F36
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Sep 2025 11:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023F52FABFE;
	Mon,  8 Sep 2025 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K1QjCgnS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37B0C2FC869
	for <linux-wireless@vger.kernel.org>; Mon,  8 Sep 2025 11:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757330019; cv=none; b=BxeHn5cDzY+0fMymGVsmXWNxEuuOjYQvcSrgdyu9NGEyz3hIBIzHNPsEFS33WHYXamnwkDM3g0Y3xoKZkVwqQircXzZqyi2Z8zjdktnm0G3vDlDNGG5Oi/hOzKJ5yDkmsrLpb4gEPYZv1J8Gp45HkC8peuBoFuWBIrGZCWcUwmA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757330019; c=relaxed/simple;
	bh=ZCFcLN7D2p40AqAV8Af91QF9rKpBGnERtx3avRyuK9M=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=PIKO12IpqTvdxH0IU3h9gq/GZeqVO/fidZdOVDsgAMQQqRE4eUqUoqnbiDirftdakszaHbWpV+yO8WqGxCmWrjW6nBfrloqHnMcSY4pmR16O9Z2LnXWJ/DG6/eQcKFKPuhHC7cG2PQ1PeDBPX861miQgHKU27cLO0QyiuSuUwFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K1QjCgnS; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757330018; x=1788866018;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ZCFcLN7D2p40AqAV8Af91QF9rKpBGnERtx3avRyuK9M=;
  b=K1QjCgnS045SuDO08nMNgfbsCe+ezfYkY/tGDjYTdYmmuSLCaTs+aoGR
   So/Noc2UiQJ7iCGoG8lCan1RkMYkyvxO5kjHufptUvUhCtj//nDJP6hTn
   9jDxFfgzhtGAPXxXkNKg/SM7SU1IIhEaXKI/wQCH3xLnCJ/Icqfb1akri
   i37YBF1424Y9U7z1xAn2qyANpP9mlTCRYroXThnd+tdOs0JBwwvpG34f3
   B564B0w0Fx99tYuKrhNCiDIxp81yMdCYx4A2jeJAKx7+Nhy6oCwAfykwK
   9EDl+kOyNQw1r8V0BzE/6w0FYkQuGP54mLe5kp4DnFaQnNEIiO2iK5U5Y
   A==;
X-CSE-ConnectionGUID: SzjLGadpSwmoG6QwaXcDNw==
X-CSE-MsgGUID: lpI2HVj9QDSl+xOFGGQlcg==
X-IronPort-AV: E=McAfee;i="6800,10657,11546"; a="77037872"
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="77037872"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:37 -0700
X-CSE-ConnectionGUID: Ld2t78wYTDCwTw6KVEAA7g==
X-CSE-MsgGUID: iztRmTlPSTWukcZHahEYRw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,248,1751266800"; 
   d="scan'208";a="173126554"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 04:13:37 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/14] wifi: nl80211/cfg80211/mac80211: Add support for NAN discovery
Date: Mon,  8 Sep 2025 14:12:54 +0300
Message-Id: <20250908111308.2688889-1-miriam.rachel.korenblit@intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Organization: Intel Israel (74) Limited
Content-Transfer-Encoding: 8bit

Hi,

This series contains patches that enable the NAN basic functionality:
discovery and join clusters, serivces dicovery.

- Publishing specific NAN capabilities
- Configuring and managing NAN interface
- Notification to user space about joining a cluster
- Notification to user spcae about the end of a DW
- Enablement of Tx/Rx of NAN specifc frames
- Some simulation code in hwsim

Thanks,
Miri
---

Andrei Otcheretianski (4):
  wifi: nl80211: Add more configuration options for NAN commands
  wifi: nl80211: Add NAN Discovery Window (DW) notification
  wifi: cfg80211: Add cluster joined notification APIs
  wifi: nl80211: Add more NAN capabilities

Ilan Peer (10):
  wifi: cfg80211: Advertise supported NAN capabilities
  wifi: cfg80211: Support Tx/Rx of action frame for NAN
  wifi: cfg80211: Store the NAN cluster ID
  wifi: mac80211: Support Tx of action frame for NAN
  wifi: mac80211: Accept management frames on NAN interface
  wifi: mac80211: Track NAN interface start/stop
  wifi: mac80211: Get the correct interface for non-netdev skb status
  wifi: mac80211: Export an API to check if NAN is started
  wifi: mac80211: Extend support for changing NAN configuration
  wifi: mac80211_hwsim: Add simulation support for NAN device

 drivers/net/wireless/virtual/mac80211_hwsim.c | 259 ++++++++++-
 drivers/net/wireless/virtual/mac80211_hwsim.h |   4 +-
 include/linux/ieee80211.h                     |  17 +
 include/net/cfg80211.h                        | 127 +++++
 include/net/mac80211.h                        |  10 +
 include/uapi/linux/nl80211.h                  | 189 +++++++-
 net/mac80211/cfg.c                            | 140 +++++-
 net/mac80211/ieee80211_i.h                    |   4 +-
 net/mac80211/iface.c                          |  25 +-
 net/mac80211/main.c                           |   5 +
 net/mac80211/offchannel.c                     |   5 +-
 net/mac80211/rate.c                           |  11 +-
 net/mac80211/rx.c                             |  12 +-
 net/mac80211/status.c                         |  21 +-
 net/mac80211/tx.c                             |  12 +-
 net/mac80211/util.c                           |   8 +
 net/wireless/nl80211.c                        | 435 ++++++++++++++++--
 net/wireless/trace.h                          |  35 ++
 18 files changed, 1230 insertions(+), 89 deletions(-)

-- 
2.34.1


