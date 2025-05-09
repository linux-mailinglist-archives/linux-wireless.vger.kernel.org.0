Return-Path: <linux-wireless+bounces-22769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3F94AB10F9
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 12:45:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8571C24CE0
	for <lists+linux-wireless@lfdr.de>; Fri,  9 May 2025 10:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 924AF21FF59;
	Fri,  9 May 2025 10:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XT090fP1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAB2921D3CD
	for <linux-wireless@vger.kernel.org>; Fri,  9 May 2025 10:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746787510; cv=none; b=nDw9sEYPFTf0bPG5qJFGiGoRRxRzZz5TYSyXN+MN6F/Y3eMDgnxIAFbvsnVnuMwpBULau88Of/dJLnjGz09RZPvVUnZSJOc8BV9NjlTK6a/fHqQJbac38cRH/MVA5IcWl86P0WUNYxeXLCWuxu1+RfQdaqwM9M5qpypbPjs5S5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746787510; c=relaxed/simple;
	bh=4KtPTxz/sgwvD5r0E4TFCI4IhwHLKsvTdgX/gyH+nmg=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=snG+aSrXz8ts3fuiBdtW3Mvd4ksT2KXfEkbGTk4GO7PqPaql4HJpIpodMzzNpUwlDrC7JTc9tSk47CraXBbiOpV7Eu3+R35vEbn9nJiM1e/IBy3tqxxU2Ax7z81GfNbllGvCOn0Wiv2XHFTaTYO+ZfGc35jvYsgUgtwW53gkfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XT090fP1; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746787509; x=1778323509;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4KtPTxz/sgwvD5r0E4TFCI4IhwHLKsvTdgX/gyH+nmg=;
  b=XT090fP1txMisu2FVVkeeITlflLgDfHvoO328rZ2p2EYgBmG/KLv9vuL
   vbc10FPV2t0zbo5w+bqXVIwFXoBgjwQwZXfzEO6VRAhqmHl/+50Nl5rMn
   ZbUodSpet1rrtPw5CMYR7pRICvdFgKsQwPdVFQNXj03LAxEjdKvP90NKN
   OgduUG3atWK/Qafv5wDC2BbI2xq9NoF2Y6+GNzht/VAIH92rtk7gzBHVg
   GkZo0ekt8EqgPP4f2fbHzSJN94FMqGx4sqrkGgOmv5kBbIV7X+H+F0f/n
   iiHYrRBJ1R4qHfwTRccunOAxMtDJbBefKOOY1ByK9kyBfL6C0c+0d9tZ/
   A==;
X-CSE-ConnectionGUID: LgmoL/ODTO2WHMN0TPAp2w==
X-CSE-MsgGUID: KKA/xTVVSuqsT0QTrij+pg==
X-IronPort-AV: E=McAfee;i="6700,10204,11427"; a="59239868"
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="59239868"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:08 -0700
X-CSE-ConnectionGUID: fXGPkWYwSo6RVGoa7ziTpA==
X-CSE-MsgGUID: ibkSrAkIQlit8uUZCWgeog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,275,1739865600"; 
   d="scan'208";a="136537001"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2025 03:45:07 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-09
Date: Fri,  9 May 2025 13:44:39 +0300
Message-Id: <20250509104454.2582160-1-miriam.rachel.korenblit@intel.com>
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
Features, fixes and cleanups from our internal tree.

Thanks,
Miri
---

Benjamin Berg (1):
  wifi: iwlwifi: move dBm averaging function into utils

Johannes Berg (9):
  wifi: iwlwifi: cfg: add ucode API min/max to MAC config
  wifi: iwlwifi: cfg: unify num_rbds config
  wifi: iwlwifi: cfg: unify JF configs
  wifi: iwlwifi: cfg: unify HR configs
  wifi: iwlwifi: cfg: add GF RF config
  wifi: iwlwifi: cfg: add FM RF config
  wifi: iwlwifi: cfg: clean up Sc/Dr/Br configs
  wifi: iwlwifi: rename iwl_cfg to iwl_rf_cfg
  wifi: iwlwifi: mvm/mld: allow puncturing use in 5 GHz

Pagadala Yesu Anjaneyulu (5):
  wifi: iwlwifi: mld: Correct comments for cleanup functions
  wifi: iwlwifi: mld: Fix ROC activity cleanup in iwl_mld_vif
  wifi: iwlwifi: mld: move aux_sta member from iwl_mld_link to
    iwl_mld_vif
  wifi: iwlwifi: mld: Block EMLSR only when ready to enter ROC
  wifi: iwlwifi: mld: add support for ROC on BSS

 drivers/net/wireless/intel/iwlwifi/Makefile   |  12 +-
 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   8 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   8 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  63 +--
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  28 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  60 +--
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  58 +--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  39 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  32 +-
 .../net/wireless/intel/iwlwifi/cfg/rf-fm.c    |  33 ++
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  25 +
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |  37 ++
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  68 +++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  34 +-
 drivers/net/wireless/intel/iwlwifi/dvm/agn.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/dev.h  |   3 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 133 ++---
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  46 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.h  |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  30 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  15 +-
 .../net/wireless/intel/iwlwifi/iwl-utils.c    | 114 ++++-
 .../net/wireless/intel/iwlwifi/iwl-utils.h    |   4 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |   9 +
 .../net/wireless/intel/iwlwifi/mld/iface.h    |   9 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   6 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  |  74 +--
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.h  |   3 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  24 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   2 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c | 117 +----
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   2 +-
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 471 +++++++++---------
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../net/wireless/intel/iwlwifi/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  12 +-
 .../{mvm/tests/scan.c => tests/utils.c}       |  43 +-
 55 files changed, 855 insertions(+), 872 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-fm.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-gf.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-hr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/rf-jf.c
 rename drivers/net/wireless/intel/iwlwifi/{mvm/tests/scan.c => tests/utils.c} (63%)

-- 
2.34.1


