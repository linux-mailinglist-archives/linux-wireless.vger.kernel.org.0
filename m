Return-Path: <linux-wireless+bounces-25972-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA2DCB10153
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 09:07:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C51189FB88
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE0E221736;
	Thu, 24 Jul 2025 07:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SiCj5wLM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E94E28F4
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 07:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753340865; cv=none; b=Qs9fr0JooW5m5nQo7SI4g33913FLGwyDphHBEpfi+DiZ//+ssBPwHGkxRmQraNBHi7lPVBFogjm4P/9g4xbPOQkWCeUUlLRpPHEkh0plnklROveI45D64cOIFXrQtALUPns+3YmP+YTLfpbttr8Ht3tFmJQAyIjiNv+JTwlkiwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753340865; c=relaxed/simple;
	bh=6NARyrueIhXuREm+TGKnU0qWS1Q4x1MSZzEehRv7RKE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RpbrBbHWPZmlls3dVmI7MCqTQxdOJ7JoULVeB5YR4XKjQrd42QqflUMWR/GUb6z0UmY18qavDLXYkgicwMdoBjVvNv9f/CPgvBFIjkDVkq3gPe6bG+WzS2lSD/+NvxGeTGZ4euG7PyTq5tsX2CRJUGWlNe7t3vIGAMbvdtgSkYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SiCj5wLM; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753340863; x=1784876863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6NARyrueIhXuREm+TGKnU0qWS1Q4x1MSZzEehRv7RKE=;
  b=SiCj5wLM8fgybrnxB0i+AIV8eavVCdARft8xo0B625b2ht9gxP3PN0+K
   uAIf9i3339okMAM9XY/xMJCwdZrjUjZLqSwwNfL0id8Tjw6AC/Z9QRKNu
   +ZWMNrgoNN7wX2iWj7v1jX50wSKKGnoOLKWBL8PYkmfuDPSyHsqvR3olW
   WTsLFx/GuMyE2S/Uu0S/cCji4yu+AyB9hsMa4HUg3r6qtyzmEDv/evMyv
   aSkFuVSJIe3CdtqvXe4Wl/qjHU4M4DrXhhw/QGHzSBYqsCUgpnhI8T7ue
   TizUB1EcEIskDum8cMbt05ZTdj4e2R6RaDyYmiAnc7EF/HbNLLxTzRzV8
   g==;
X-CSE-ConnectionGUID: 5pIOMjxXTzS7HjzhxAKvmQ==
X-CSE-MsgGUID: 7TMUYJu2T9yxaNoXWU+I6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11501"; a="55732628"
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="55732628"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:07:42 -0700
X-CSE-ConnectionGUID: NP2Y7W44RmSEB+0oE/9dmw==
X-CSE-MsgGUID: ZdYBngOFS56ZZRPj/mW6PQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,336,1744095600"; 
   d="scan'208";a="165422576"
Received: from aotchere-mobl1.ger.corp.intel.com (HELO aotchere-mobl1.intel.com) ([10.245.249.251])
  by fmviesa004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2025 00:07:40 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	quic_vganneva@quicinc.com,
	maheshkkv@google.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v2 0/4] wifi: nl80211: Extend NAN APIs to allow more flexible implementations
Date: Thu, 24 Jul 2025 13:04:53 +0300
Message-ID: <20250724100457.181825-1-andrei.otcheretianski@intel.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series extend exiting NAN APIs to support more
configuration options for NAN synchronization and a user space oriented
NAN Service Discovery implementation.
Existing NAN APIs are very limited and not really used, resulting in
vendors using proprietary vendor commands and a need to offload NAN
protocol implementations to the device firmware or driver.
In this series, additional APIs are added which allow to extend the
configuration of the NAN Synchronization logic and support user space
oriented NAN Service Discovery implementation.
With this design, wireless devices/drivers are still required to
implement NAN synchronization and cluster merging. NAN Discovery Engine,
may be either offloaded (keep using the existing APIs) or alternatively
implemented in user space.
To support user space oriented NAN Discovery Engine, the device will
notify user space with %NL80211_CMD_NAN_NEXT_DW_NOTIFICATION about the
upcoming Discovery Window (DW). This notification should be used as a
trigger for transmission of uncsolicited multicast SDF's (i.e.
unsolicited publish and active subscribe). Once SDF transmission is
requested with %NL80211_CMD_FRAME, the device shall take care of the
actual frame transmission during the upcoming DW.
Note, this notification may be sent before the actual DW start time.
On DW termination, the device/driver shall flush all untransmitted NAN
management frames. Untransmitted frames shall not be carried forward to
the next DW.
Note that such approach may not be appropriate for highly power
efficient devices or scenarios that require long discovery sessions, as
it may require the host to wake up for each DW.
User space can in turn, turn off this notification using
%NL80211_NAN_CONF_NOTIFY_DW configuration flag if it doesn't intend to
send unsolicited multicast SDFs to prevent unneeded wake ups.

%NL80211_CMD_NAN_CLUSTER_JOINED notification shall be sent once after
new NAN cluster has been started or the device has joined an existing
cluster. In addition each time, cluster merge procedure results in
cluster merging, user space shall be notified. This is required, as
cluster ID is used as address 3 in SDF frames. Untransmitted frames
should be flushed, when this notification is generated in order to
prevent transmission of SDFs with invalid address 3.

This patch series goal is to provide APIs to support NAN synchronization
and user space oriented Service Discovery. It will be further extended
in a separate patch set to support user space implementation of NAN data
path (NDP) and NDL schedule establishment.

---
Changes in v2:
  - Fixed attribute types and improved documentation
  - Generic per band configuration
  - Using frequency instead of channel
  - Removed excessive CHANGED_* flags
  - Added more capabilities
  - Sending DW notification to socket owner only

Andrei Otcheretianski (4):
  wifi: nl80211: Add more configuration options for NAN commands
  wifi: nl80211: Add more NAN capabilities
  wifi: nl80211: Add NAN Discovery Window (DW) notification
  wifi: cfg80211: Add cluster joined notification API's

 include/net/cfg80211.h       |  80 ++++++++
 include/uapi/linux/nl80211.h | 181 +++++++++++++++++-
 net/wireless/nl80211.c       | 355 +++++++++++++++++++++++++++++++----
 net/wireless/trace.h         |  34 ++++
 4 files changed, 610 insertions(+), 40 deletions(-)

-- 
2.49.0


