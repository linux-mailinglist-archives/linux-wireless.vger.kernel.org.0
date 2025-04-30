Return-Path: <linux-wireless+bounces-22261-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD3A2AA4C48
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 15:01:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133281643C5
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 12:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AFA825CC4C;
	Wed, 30 Apr 2025 12:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GYBIwfO0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475B4254852
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 12:57:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746017866; cv=none; b=bM/EX93prST8Q7HxaMC90MU5poKPuZAkNdIMo1e9UpLy/4y+GlXSwJUJXn1jPIv8zRLuHwkaEwe/AH0/51BtI0+kDjQZ76jCVZm7w8ePKHerVtR+Tv+4Fno28ntFIcJqA+a1J163xrASryUbOCy37HGpFB8ddj4KGBCvnvx73Cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746017866; c=relaxed/simple;
	bh=LoEWMXMEmQjaUcfA8xTyoS6XYZDjCFvO2HI2P0+S9IU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ER+fLTNGKg/9vTA1NoND0tnwIShHPT5v+CVbNIoaDSTmopKsBxxYD/TgRZHUl9EKN3htUjCQggzEmr+X/JBlAMfLH/w2aX4UvtGmW/ySO1wi+m/fTd8YMOcp/wldunJhNqO8CXQRyyJSe9shzQ0k6qP272qzafBVb5PTPHh3+Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GYBIwfO0; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746017864; x=1777553864;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=LoEWMXMEmQjaUcfA8xTyoS6XYZDjCFvO2HI2P0+S9IU=;
  b=GYBIwfO0TBDSzpPqFXShgdbYscEzUC+LKpbFPHWXGTqsyuxLR3WUKjoD
   j2E/xNHOIXpgIge5hIvy3+urDVfjS5+hFU58IuhGmKkt84ybUJPQV2kVV
   BG0tLI6dCLWHF6JaY3uyI08026tcyks4dNYMu7xcN9I7FAaysecla+RZ1
   WfG3CtcorB19ZKj0Cnf+IxjjH/gmFYCBICy7BTr4rN45D22EM0ZItTWKA
   /QgWyxibDT8gewhPqibvHf9zZMOnDW8fZVdhaR+ntB7OrYtv3sQXS33Wr
   qtFivrzW5tb/YIfLZaeQfMzkfIENNE8qsxZqjl9i2HlA1730U0juasJuK
   w==;
X-CSE-ConnectionGUID: jqIY5u2sRd+afkCI1ekQjQ==
X-CSE-MsgGUID: SNcCxcaDRe+FP2e6wMCyEA==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="58332318"
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="58332318"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:43 -0700
X-CSE-ConnectionGUID: 2QvOEG2VRW6NVDKdhSFU6g==
X-CSE-MsgGUID: uiuJ7qomTVG3MRjrfW18rw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,251,1739865600"; 
   d="scan'208";a="134632075"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 05:57:42 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-04-30
Date: Wed, 30 Apr 2025 15:57:14 +0300
Message-Id: <20250430125729.1122751-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and bugfixes from our internal tree.

Thanks,
Miri
---

Avraham Stern (2):
  wifi: iwlwifi: mld: start AP with the correct bandwidth
  wifi: iwlwifi: mld: force the responder to use the full bandwidth

Daniel Gabay (1):
  wifi: iwlwifi: mld: add monitor internal station

Emmanuel Grumbach (2):
  wifi: iwlwifi: add support for ALIVE v8
  wifi: iwlwifi: mld: support for COMPRESSED_BA_RES_API_S_VER_7

Johannes Berg (6):
  wifi: iwlwifi: mld: handle SW reset w/o NIC error
  wifi: iwlwifi: implement TOP reset
  wifi: iwlwifi: mld: fix BAID validity check
  wifi: iwlwifi: dvm: fix various W=1 warnings
  wifi: iwlwifi: mld: set rx_mpdu_cmd_hdr_size
  wifi: iwlwifi: mvm: remove nl80211 testmode

Miri Korenblit (3):
  wifi: iwlwifi: mld: support iwl_mac_power_cmd version 2
  wifi: iwlwifi: mvm: support ROC command version 6
  wifi: iwlwifi: mvm: support iwl_mac_power_cmd version 2

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: mld: add kunit test for emlsr with bt on

 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  35 ++---
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rx.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/rxon.c |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |  10 ++
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |   8 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   7 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   6 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  47 +++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   9 ++
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |   9 ++
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |  21 ++-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   1 +
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   4 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  28 +++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   8 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   4 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   3 +-
 drivers/net/wireless/intel/iwlwifi/mld/phy.c  |  14 ++
 drivers/net/wireless/intel/iwlwifi/mld/phy.h  |   3 +
 .../net/wireless/intel/iwlwifi/mld/power.c    |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  34 +++++
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   8 +
 .../wireless/intel/iwlwifi/mld/tests/Makefile |   2 +-
 .../intel/iwlwifi/mld/tests/emlsr_with_bt.c   | 140 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  78 +---------
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  15 --
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 -
 .../net/wireless/intel/iwlwifi/mvm/power.c    |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/quota.c    |  43 +-----
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  12 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  38 +++--
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   2 +-
 .../wireless/intel/iwlwifi/pcie/internal.h    |  22 ++-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  12 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  65 +++++++-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  19 ++-
 42 files changed, 534 insertions(+), 241 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/tests/emlsr_with_bt.c

-- 
2.34.1


