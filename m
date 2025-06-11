Return-Path: <linux-wireless+bounces-23957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA0BAD4965
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 05:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B874C166090
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Jun 2025 03:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE6381991A9;
	Wed, 11 Jun 2025 03:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VhPw58zD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FFC54C80
	for <linux-wireless@vger.kernel.org>; Wed, 11 Jun 2025 03:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749612874; cv=none; b=oY708adqmGlspEblX2iyl6c/7opGzFGeVhP465pleTrIKX9QBHk1/mX4NJxJKwVCyrnx7ZrQR2ESIdxFIy5ewfQkGhOXJENuy0OH21sXweYJUGg2UuJ0Dk23lmCuqwGa1o3yMkBftie0tlDqq0+VQFCAFuEhZm32XjkKaMewb/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749612874; c=relaxed/simple;
	bh=AwO8klrlTgMBcOnDjn8zQPH5yyYxypzUJDyWCEnaLvE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=cYRV7vWfxea56Z0FNH4EbrG5crFmUkGM3MJ8HPr6ct3pOjLAczS/o+El3s3AsbxwFVLSL4Yn/2Vy3YoQpmZNdIKM6Vl3tpx0V+d93bq1Tz+zATaqbbzfaCD6Yv/pirP1DZycYwOO96q8+fih0YFhOuQO46SNhvyPoB7Gr8WIG7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VhPw58zD; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1749612873; x=1781148873;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=AwO8klrlTgMBcOnDjn8zQPH5yyYxypzUJDyWCEnaLvE=;
  b=VhPw58zDblwZZhEgW/odjbzcH8Ixc3QguebltinSApGsovhMjvmuLDTx
   JVdzoNNETw7BEMODUBma+7OPOXyFaGOGGxwcCTRUgkgAnS+9nFsv4ZmV6
   63S7DlLOXfpW0bJp4W7+cykgL+8bWbDRD+vRsxZDWBGTumqXDGK0BMhTV
   Ug4RZRJpuU/JCqSCf7ngmJYtWcg+Da9yvuUB52mvfHfGiiu3TqgeKwEYX
   ImTeYuJJo9rltzJoDlNyxpzJcpg9uNM3K52m0s8so3JF+QlaVF6S8LKLS
   iQ9ri8jDAnQWcBZvDeZz1pnIo/FsGZ4AB24ldIyRWvtCActa1rprNqBhn
   w==;
X-CSE-ConnectionGUID: b50eDgn1SWSO4wvAi1z9og==
X-CSE-MsgGUID: xOtqyE7gRN2W2eJTfi28wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11460"; a="63094876"
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="63094876"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:32 -0700
X-CSE-ConnectionGUID: g6uCuGI8TruZ1wVVU/rfQw==
X-CSE-MsgGUID: rGYzz+2ETsisuTDFp0XgaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,226,1744095600"; 
   d="scan'208";a="150880893"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2025 20:34:31 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-06-11
Date: Wed, 11 Jun 2025 06:34:00 +0300
Message-Id: <20250611033415.1175681-1-miriam.rachel.korenblit@intel.com>
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

A few cleanups, features and bugfixes from our internal tree.

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

-- 
2.34.1


