Return-Path: <linux-wireless+bounces-24000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E20AD5F04
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 21:26:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E6C4189EB82
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 19:27:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0B5A225413;
	Wed, 11 Jun 2025 19:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SPNJIfE7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E42B1D89FD
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 19:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749670013; cv=none; b=FF9NZ+gxrGKy03fFXtxZTlSemtuAzV2ii1yOiP3PfBbGr19V24i3eRUHZQV9BM9dbxouCSYGQzf1b3glCZ1lqKPwKxFh7I4WRrVoqCK6+POwjCbsuzQyRfeSajqzEUZQNBMBJnkIU6EYBxYTd2LSl0fYummFbx+aoZzbi2IL/hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749670013; c=relaxed/simple;
	bh=E+oQX/KOHsIP0oCFiAhEI/irRz0mvx5cvuWb15DBO7A=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=GrpRfFOUknoVKMd74aJ9itu49+BLRsSXF/IkX0rhNq3OnCWIEq+AQZuphNFLHMyFYxJTfBwboOtPqZOXv4ptUeCLJlXpT1mQMq1TNAQixXdmqBe9/gRoq4aTHA4kuun42vF50ycBdaIi3c9OCBUue+VxY54/bMVmS96w3ItUmRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SPNJIfE7; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749670012; x=1781206012;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=E+oQX/KOHsIP0oCFiAhEI/irRz0mvx5cvuWb15DBO7A=;
  b=SPNJIfE7Hcdwb+aX21pyC4FIp27bAbaNfKh43x27MkmQVI+MUclhy4V8
   JJtc4oiBRPrRveKU40HZdsxXcj7LWiBZUvU/tT7rZeuXOkln2Aa7QqiPm
   8lHNNL6Ae6x/tI6XeBNJEhHCNPvRiDwx0YQDbrtTBjb20OS4wKQt2TV57
   sfE0AcMYevqPLzTOAE2R73X81fjdhxZKYKDYMQ0tjX6Kv0rhVE4aHEt8B
   Oz7aGAXKLTSYpDX6OfzOqM3wQ2DETXC9G6bUbAD9wKgG9fzLM63eG3JkC
   tEkvapNis/c71/xUsY92mGd3gHy5lN3JitbhoRfHDLjMJi9iOvC0NzSJm
   A==;
X-CSE-ConnectionGUID: Zf+rkr1dRNi1LRjkFsaL0g==
X-CSE-MsgGUID: gFvRoiw8R06rY5xZz5nwKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11461"; a="74360852"
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="74360852"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:51 -0700
X-CSE-ConnectionGUID: nrsH5qTVSdKnpPWKX7dHTQ==
X-CSE-MsgGUID: 0rE909NBRdqB0mj8fVp2qQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,228,1744095600"; 
   d="scan'208";a="147165818"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2025 12:26:50 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v2 00/15] wifi: iwlwifi: updates - 2025-09-11
Date: Wed, 11 Jun 2025 22:26:19 +0300
Message-Id: <20250611192634.2416885-1-miriam.rachel.korenblit@intel.com>
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

Cleanups, fixes and features from our internal tree.


Thanks,
Miri
---

Johannes Berg (11):
  wifi: iwlwifi: pcie: abort D3 handshake on error
  wifi: iwlwifi: mld: add timer host wakeup debugfs
  wifi: iwlwifi: mld: remove special FW error resume handling
  wifi: iwlwifi: mld: fix last_mlo_scan_time type
  wifi: iwlwifi: defer MLO scan after link activation
  wifi: iwlwifi: dvm: fix some kernel-doc issues
  wifi: iwlwifi: pcie: fix kernel-doc warnings
  wifi: iwlwifi: mei: fix kernel-doc warnings
  wifi: iwlwifi: mvm: fix kernel-doc warnings
  wifi: iwlwifi: mld: make PHY config a debug message
  wifi: iwlwifi: fw: make PNVM version a debug message

Or Ron (1):
  wifi: iwlwifi: phy periph read - flow modification

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: add support for the devcoredump
  wifi: iwlwifi: mld: Add dump handler to iwl_mld
  wifi: iwlwifi: fw: Fix possible memory leak in iwl_fw_dbg_collect

 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |  2 +
 .../net/wireless/intel/iwlwifi/dvm/commands.h | 14 ++--
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |  4 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |  2 +
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |  2 +
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 23 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  | 10 +++
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h | 10 ++-
 drivers/net/wireless/intel/iwlwifi/mei/sap.h  | 30 +++----
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 79 +++----------------
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  5 ++
 .../net/wireless/intel/iwlwifi/mld/iface.c    | 15 ++++
 .../net/wireless/intel/iwlwifi/mld/iface.h    | 12 +++
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  4 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  9 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  | 12 +++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 +
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c | 12 +++
 drivers/net/wireless/intel/iwlwifi/mld/scan.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |  1 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  3 +-
 .../wireless/intel/iwlwifi/mvm/time-event.h   |  8 +-
 .../intel/iwlwifi/pcie/ctxt-info-v2.c         |  4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  9 +++
 .../intel/iwlwifi/pcie/gen1_2/internal.h      | 14 +++-
 .../wireless/intel/iwlwifi/pcie/gen1_2/rx.c   | 16 +++-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 31 +++++---
 .../intel/iwlwifi/pcie/iwl-context-info-v2.h  |  6 +-
 31 files changed, 226 insertions(+), 125 deletions(-)
---
v2: remove trailing whitespcae
--
2.34.1


