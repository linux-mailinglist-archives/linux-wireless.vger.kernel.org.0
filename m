Return-Path: <linux-wireless+bounces-22675-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C848AACE2C
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 21:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7FB1782A1
	for <lists+linux-wireless@lfdr.de>; Tue,  6 May 2025 19:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55A581F4C9B;
	Tue,  6 May 2025 19:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UwMOEcyw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81DE07262D
	for <linux-wireless@vger.kernel.org>; Tue,  6 May 2025 19:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746560479; cv=none; b=EMWSALFQ90mHsUNhnG/D4IqqRSS+deHjYl2bjeAWvvy0g49uCoTa16BVjdnBCoa7y10VQ8R0cwm5Z7bViAh0FHYWDv0z1iN2BhG2Yvh+l/SIwcM0R/AjV8NSqqA0Cj4YGVhG6MphgOKoWnV7VHL+0D/6UpmymyYCb91cfnJHccQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746560479; c=relaxed/simple;
	bh=I7pvqV/5xAh+f9/oVlRzLfWJcEK/n/36zCLhK83VJbc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=rPXyj3PHnvdzNIGXnUCuKRViDBkZF3Up2FjsPFd1zof6wbwhXEQu5kHG0tL+9UrS6FHAKVu81ApdpMT5lHa04yOCCJeE9KQ7VSYQ7ROs7ZPjegPoqju11IsK1SwjKHSAKTm9qrjh9ei0q932x3SkQxbYfiCTeju2bwLdIIEEagQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UwMOEcyw; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746560478; x=1778096478;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=I7pvqV/5xAh+f9/oVlRzLfWJcEK/n/36zCLhK83VJbc=;
  b=UwMOEcywq/6nBEvT91BqcnkI9rLitV7aEoLyfEEb4hHV/eDceRUHo7KN
   ZxuOubQebUHas221XvES2ixXNlRuvEDj6VVMdhlo9tRsvLbLisfnwwPex
   3cXC6z3rHyFrkXKyanVSXnQs7B1LXwYcLt95DUluVPQMQc6921v3/4kf1
   vu8fTBNjL75TGm+ad9foGd2Va51CUnCBfxzUjXSFJLdNiGr0veao8JgyU
   hqAvnlvS8c3HxReucUbWGFXhIu1J1eGB/9e9IuhRccrEy/T9DQY0WWndG
   fDlnG8ReBRWpy3L5mPFY4PT7dyh5OIHtbUzKWVRPJpnZn568FhslENOB4
   w==;
X-CSE-ConnectionGUID: ODVxdqr7Tc2XJOn1nuGQpQ==
X-CSE-MsgGUID: DDWE61wYREOe61KQuIzmog==
X-IronPort-AV: E=McAfee;i="6700,10204,11425"; a="47961607"
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="47961607"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:17 -0700
X-CSE-ConnectionGUID: jT5m7PGLSjqa04aqTTI8Cg==
X-CSE-MsgGUID: +cnHwKetSm2F8KIAR3Owmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,267,1739865600"; 
   d="scan'208";a="140465388"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2025 12:41:16 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-06
Date: Tue,  6 May 2025 22:40:47 +0300
Message-Id: <20250506194102.3407967-1-miriam.rachel.korenblit@intel.com>
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

A few features, bugfixes and cleanups from our internal tree.

Thanks,
Miri

Avraham Stern (1):
  wifi: iwlwifi: add range response version 10 support

Benjamin Berg (4):
  wifi: iwlwifi: fix thermal code compilation with -Werror=cast-qual
  wifi: iwlwifi: mvm: use a radio/system specific power budget
  wifi: iwlwifi: mld: use a radio/system specific power budget
  wifi: iwlwifi: mld: call thermal exit without wiphy lock held

Johannes Berg (4):
  wifi: iwlwifi: cfg: remove 6 GHz from ht40_bands
  wifi: iwlwifi: cfg: inline HT params
  wifi: iwlwifi: pcie: remove 0x2726 devices
  wifi: iwlwifi: add JF1/JF2 RF for dynamic FW building

Miri Korenblit (3):
  wifi: iwlwifi: mld: remove one more error in unallocated BAID
  wifi: iwlwifi: pcie: remove iwl_trans_pcie_gen2_send_hcmd
  wifi: iwlwifi: mld: avoid init-after-queue

Yedidya Benshimol (3):
  wifi: iwlwifi: Add a new version for sta config command
  wifi: iwlwifi: Add a new version for mac config command
  wifi: iwlwifi: Add support for a new version for link config command

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |  18 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |  30 ++--
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  26 +--
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  54 +++++--
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  48 +++---
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |  18 ++-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  13 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   7 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   7 +-
 .../net/wireless/intel/iwlwifi/dvm/debugfs.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   8 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  84 +++++++++-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   | 149 ++++++++++++++++--
 .../net/wireless/intel/iwlwifi/fw/api/mac.h   |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   5 +
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   8 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    |  13 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  35 ++--
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mld/thermal.c  |  89 +++++++----
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-mac.c  |  46 ++++--
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |  93 +++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   4 -
 .../wireless/intel/iwlwifi/pcie/internal.h    |   2 -
 37 files changed, 626 insertions(+), 241 deletions(-)

-- 
2.34.1


