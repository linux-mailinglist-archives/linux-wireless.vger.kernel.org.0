Return-Path: <linux-wireless+bounces-26356-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51EF9B24815
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 13:12:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820A01BC3BAF
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 11:12:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB8402D7387;
	Wed, 13 Aug 2025 11:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ANezn5P+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7109A1A9F9E
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 11:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755083517; cv=none; b=dEfgSWRAvHVThmETzwPs6HHroxBSZo+tG9ebT/ogbcYuYjBcO3c3nMGJGhqkRCJA4YP36CivjP26dZNpyPR6rJFJcgXPHNX2htERsJTGvfXYXOr25n06G/gho/REzkInKyuAcOT/0RseQ22iCcxB/ywqwcmBrvgmWNnSLeESEEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755083517; c=relaxed/simple;
	bh=SvIoBrpSkUuSmTesZ3pwDufRunxKsMT4xYKbrYXFx4A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=T1/dsNQcTb8YKz4Wa9zwHiFDoZNgapdJ32hbGcRLyc48AGI3gaFfxzlZTuypfq0cL+xY9IKQJGXMe1F3C04EfUXV/ZLn2blmgbVBsOe3vAHIDh+3Cn1EqT9VKsrVpyPSGceyT9WzT4sy+UMuRB6JZOTJq7nvve2st/qu3tYeAZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ANezn5P+; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755083516; x=1786619516;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=SvIoBrpSkUuSmTesZ3pwDufRunxKsMT4xYKbrYXFx4A=;
  b=ANezn5P+GhXnpuUQRnyyJ1xubuXdYJLxDMZ7N+xJv1HhQ4oZ5at9QBBG
   K0aJ+F7BzyfTrA4HiXXNjd1nDVUYWuzeGB+UEUbVwvkPiEOoCGRNpI7oj
   4jbw0YKsuoBmmwI1/Sm03JGG2adfRz60BCz6+gvc46tROgp1RM1DIIviF
   nWV1CSdPbl79vma+YpPa5T5iTpd57EVCmuexNPTeKWkJlUAHvV9fD1LTo
   qIMWo/ljfnRuCZ5UXHGDP9gqVVX/gO8ya5PZEh4NB/0HU+F3wGD2/17+M
   bPDidAbAfLmxe0FIBoQxoCfZE50XD6KkWLekMDPqAkiT/VvPHsksqIcpL
   g==;
X-CSE-ConnectionGUID: XG8fDFAwQz2VH2KSQoMDLA==
X-CSE-MsgGUID: auYLd4drSta8BUD5xLR4RA==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="74951174"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="74951174"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:11:54 -0700
X-CSE-ConnectionGUID: Q8f+RWhbTNODVBvEStLvzQ==
X-CSE-MsgGUID: cdMiJxIdQYexy7kCAmhO2A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="165628920"
Received: from aotchere-mobl1.jer.intel.com ([10.13.73.232])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 04:11:51 -0700
From: Andrei Otcheretianski <andrei.otcheretianski@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org,
	maheshkkv@google.com,
	quic_vganneva@quicinc.com,
	Andrei Otcheretianski <andrei.otcheretianski@intel.com>
Subject: [RFC v3 0/4] wifi: nl80211: Extend NAN APIs to allow more flexible implementations
Date: Wed, 13 Aug 2025 17:10:44 +0300
Message-ID: <20250813141048.100884-1-andrei.otcheretianski@intel.com>
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
For devices that may require longer DW notification processing time,
user space may provide the expected latency to the device using
%NL80211_NAN_CONF_DW_LEAD_TIME attribute.
Note that such approach may not be appropriate for highly power
efficient devices or scenarios that require long discovery sessions, as
it may require the host to wake up for each DW.
User space can, in turn, turn off this notification using
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
Changes in v3:
  - Added %NL80211_NAN_CONF_DW_LEAD_TIME
  - Added capabilities to limit extra NAN attributes and vendor IEs
  - Changed NAN configuration parameters format/types etc
  - Improved documentation and bugfixes

Andrei Otcheretianski (4):
  wifi: nl80211: Add more configuration options for NAN commands
  wifi: nl80211: Add NAN Discovery Window (DW) notification
  wifi: cfg80211: Add cluster joined notification APIs
  wifi: nl80211: Add more NAN capabilities

 include/net/cfg80211.h       |  91 ++++++++
 include/uapi/linux/nl80211.h | 203 +++++++++++++++++-
 net/wireless/nl80211.c       | 389 +++++++++++++++++++++++++++++++----
 net/wireless/trace.h         |  35 ++++
 4 files changed, 681 insertions(+), 37 deletions(-)

-- 
2.47.1


