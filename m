Return-Path: <linux-wireless+bounces-22243-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28D86AA4B00
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 14:24:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 98F51466930
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E1422173C;
	Wed, 30 Apr 2025 12:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="E5J4TQVs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFC61C173F
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746015884; cv=none; b=mB1nPD0dpMja0/CELhnIAInm0sg3DGCusIXFoWavZszmBSL8dqmrdzDpH2LYcxotxOyMYf7is+AOvl5UZATJQ4YhaoAs7gFKpNyjwSQQjqvsODGeE+1+h+ZG7Z/gVfBskhfjLFCDqTO3zsiybkt9Spt/HemI9ip3xe4VZ4ijudk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746015884; c=relaxed/simple;
	bh=jd4P3BVcIBNmDhXGTsRAKMd2QHru459dRfugmDgXV1Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=egea0L+s5a9WmpFkaStVZHjz1ioAmwuW30ft/KD+b9w+0TZY2a/A/AcbjDtDHx7Tl/7as//YbJDlKnz9FhHhb9isDU5bnM2UIhWSbJEmJq8ZF8eiKqdIdkfs7zGE9NcVu4cAmF5iZuv0bD/iiepNYnJ3JUxu0mumOb3Hs19iLAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=E5J4TQVs; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746015882; x=1777551882;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jd4P3BVcIBNmDhXGTsRAKMd2QHru459dRfugmDgXV1Q=;
  b=E5J4TQVs2hZKWUF99k1NS23J7GEkrlGhtlEeQXYAsd+4P2Jur2ySiS44
   Wzlw2f3Yi+GyIj4zSPIqtrITFKB/751S4HdXvOd2qJ5VEgKG532juKqll
   6a0pnV7ZfoAmRShEBypXVraSr8rvJvEx0NwhVjEXsuvt7Sv60y78BsK1K
   JFKB/nacP7t1JdMhWY5i3kjE7ZZG+V4INgLf0EQRbI7H5lp59n7OTHIB6
   AIGRBba4IXuXVk40oIM0IK4e0vbiw47hcYfntnCYc2ClA7a3cvfr+DJre
   zew3ieJfR+1B1DXgqChiEOARkNtYtfMQDAfsOhQELf7HQa6zFF2XnWnj6
   Q==;
X-CSE-ConnectionGUID: uTMHUvNxQ5K6xURdHr/jlg==
X-CSE-MsgGUID: Ezoz/LNmSVOZ3WHn2bmfAQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11418"; a="47578257"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="47578257"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:42 -0700
X-CSE-ConnectionGUID: T13ySFQHTdusrz5SiNa7Pg==
X-CSE-MsgGUID: b8sQe+ODTfqFhXbDIV8IQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="135087832"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:24:41 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/14] wifi: iwlwifi: updates 2025-04-29
Date: Wed, 30 Apr 2025 15:23:06 +0300
Message-Id: <20250430122320.1061510-1-miriam.rachel.korenblit@intel.com>
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
resending the series as one of the commits had a bug

Miri

Johannes Berg (5):
  wifi: iwlwifi: mld: refactor tests to use chandefs
  wifi: iwlwifi: mld: tests: extend link pair tests
  wifi: iwlwifi: avoid scheduling restart during restart
  wifi: iwlwifi: back off on continuous errors
  wifi: iwlwifi: implement TOP reset follower

Miri Korenblit (5):
  wifi: iwlwifi: prepare for reading WPFC from UEFI
  wifi: iwlwifi: read WPFC also from UEFI
  wifi: iwlwifi: mld: send the WPFC table to the FW
  wifi: iwlwifi: mld: check for NULL before referencing a pointer
  wifi: iwlwifi: mld: don't return an error if the FW is dead

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: rename ppag_ver to ppag_bios_rev
  wifi: iwlwifi: fw: support reading PPAG BIOS table revision 4
  wifi: iwlwifi: fw: support PPAG command version 7

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON

 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  28 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  11 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |  32 +++-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  37 +++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  13 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  33 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  21 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   7 +
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  85 +++++++----
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  16 +-
 drivers/net/wireless/intel/iwlwifi/mld/coex.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  12 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  92 ++++++++---
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  |  29 ++++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |   2 +
 .../wireless/intel/iwlwifi/mld/regulatory.c   |   2 +
 .../intel/iwlwifi/mld/tests/link-selection.c  | 144 +++++++++++-------
 .../wireless/intel/iwlwifi/mld/tests/link.c   |   4 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  37 ++++-
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |  84 +++++-----
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  60 +++++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   3 +-
 28 files changed, 580 insertions(+), 221 deletions(-)
---
v2: added a few checks to wifi: iwlwifi: mld: allow EMLSR with 2.4 GHz when BT is ON was

-- 
2.34.1


