Return-Path: <linux-wireless+bounces-26637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F85AB36F37
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:01:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDDBB1BC51D1
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 15:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F3828B7DB;
	Tue, 26 Aug 2025 15:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RZXT57Ke"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 804BA31A546
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 15:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756223733; cv=none; b=KyvbwbI17bXw37ivf3hKFbXQBWSCJcqYg+9cRVjV2zufLvUiiFytbEt4BCuJp8EtHZPB8jpxVjtxksp5AxXHiMkTS6wElWUS6vL1Boh0I3BUbs9c9CIxKuNq1AIvNK8NyJZoVjz8iUs0mjykKXl/cEo1rbAxcL0Rppb9hTvRawI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756223733; c=relaxed/simple;
	bh=GouQJzRYysLePgWpb4eeKMcPrXrYB/X94j54QGHbYsY=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=u4d/7Up8YmB/RcIXVblL2Y17LqR78LRxcobhgCOqGbCrPdQtZXSSiQo1GTx0hfuk2yPDpRs4KXUoUqHjITbcDnDx8CynCKYIyODlZQz0YgLhJzQA4DMPPfwPJntFl1IQyXHTC/dMSOh/koafvv/gN9F4Jf92dZy9JoRhNZGAMEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RZXT57Ke; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756223731; x=1787759731;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=GouQJzRYysLePgWpb4eeKMcPrXrYB/X94j54QGHbYsY=;
  b=RZXT57Ke4vq67vwlG9kq2towU7qsOQbNXuqQlPzBl0tSMlmdDOkSCh5Q
   StpcnR6+rfygPFZBYLsDZwQ5hCzmdoLOAWjIa1Ye0680YiIN/Iif3aKNk
   pUVgx5n46rbO4YqxXEcjbSEl+9k5EC7+6LfgLv/i2eXoKnKnsZLrEluNu
   1JGvfpjMX9CzTVohzIfOFMek+BTgh/W7Ubs7xGmTvKOUQja/24LpeDtS/
   fqfIJZpvUjCNWrXJL9ThTL4/ZjV9KxFF9Jk+maxItXkR8j9PPx172Jy55
   KfK5YUKX59bMzU+qUdzKm3Xmx6iTC7XZPCXmSb/LT9xxLEuU2Qi0KQcIq
   g==;
X-CSE-ConnectionGUID: D/eKU1bfT+anvk5HLodlpQ==
X-CSE-MsgGUID: +k0e3fYUTuOXJe68bHh9wQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11534"; a="62108391"
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="62108391"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:31 -0700
X-CSE-ConnectionGUID: 8LV1IIaJRoqwu2ikZmUKtA==
X-CSE-MsgGUID: QLJLT7MuRwCJhS+xeugh2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,214,1751266800"; 
   d="scan'208";a="169218175"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2025 08:55:30 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-08-26
Date: Tue, 26 Aug 2025 18:54:49 +0300
Message-Id: <20250826155504.2982930-1-miriam.rachel.korenblit@intel.com>
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
Features, cleanups and fixes from our internal tree.

Thanks,
Miri
---

Daniel Gabay (1):
  wifi: iwlwifi: mld: add few missing hcmd/notif names

Itamar Shalev (2):
  wifi: iwlwifi: pcie: relocate finish_nic_init logic to gen1_2
  wifi: iwlwifi: simplify iwl_poll_prph_bit return value

Johannes Berg (2):
  wifi: iwlwifi: add a new FW file numbering scheme
  wifi: iwlwifi: iwl-config: include module.h

Miri Korenblit (8):
  wifi: iwlwifi: mld: don't check the cipher on resume
  wifi: iwlwifi: mvm: remove d3 test code
  wifi: iwlwifi: remove dump file name extension support
  wifi: iwlwifi: trans: remove d3 test code
  wifi: iwlwifi: trans: remove STATUS_SUSPENDED
  wifi: iwlwifi: simplify iwl_trans_pcie_d3_resume
  wifi: iwlwifi: mld: don't modify trans state where not needed
  wifi: iwlwifi: refactor iwl_pnvm_get_from_fs

Somashekhar Puttagangaiah (2):
  wifi: iwlwifi: mld: trigger mlo scan only when not in EMLSR
  wifi: iwlwifi: mld: Add debug log for second link

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  16 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  11 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  16 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  31 ---
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |  52 -----
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  20 +-
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 -
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  40 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  41 +++-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |  91 +-------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  27 +--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  22 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |  91 +++-----
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  26 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  11 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 196 ++----------------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   1 -
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   4 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   3 -
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  10 -
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   6 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 132 +++++++++---
 25 files changed, 295 insertions(+), 575 deletions(-)

-- 
2.34.1


