Return-Path: <linux-wireless+bounces-20265-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 064F2A5E73D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 23:22:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A22E17316F
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Mar 2025 22:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035251EF0B2;
	Wed, 12 Mar 2025 22:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ijulxti/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B701E2823
	for <linux-wireless@vger.kernel.org>; Wed, 12 Mar 2025 22:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741818172; cv=none; b=V3L2UFnfB43trlbmKaUuLZonzIVVSd/pA0iX/4RKIqzyFL04tv4cEwK+7DNnU0FLVAlUnV0GTMLVuwUYlDY3i4IbTC0EvhTJ2wFhqpn2iMCkv1TivCbH6NyKqo0tlOXmj0bzIGics7C9rsnlcrXjX5mnLx6sbty0IfY5dwN/JeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741818172; c=relaxed/simple;
	bh=6k30MFVMWrDoNxqDmsGMXpI0rQz7X3i4bQGdHWnoV9k=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZfynmisuZblgX9zTQcut0aI35mtZSM9MFnymj9N2gHWU7GXg4o0hhq84Cyp7iKbm/Nd1ffcY7rJwPfZULcHw0tWyvkn7p1ks5elPlKH1LC5zQsHjIogCV5chbjvLNYXlcz1I9BdOeqoc5ucSeIN/lNcYG1Inf6/9o4XtM4Ca7cY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ijulxti/; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741818172; x=1773354172;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=6k30MFVMWrDoNxqDmsGMXpI0rQz7X3i4bQGdHWnoV9k=;
  b=Ijulxti/aQiyS/CXej1+yTxe7Hd21V0CG/+YMDaoiJ1LbDgGGNXqbiiv
   irzP/cRTbo00nK30Cxbs9WL1amGkJ1sBTmutDwedWqOiJIDq+KFRBiA0k
   OdU7ppOZ+PY5gMgkpOTHNavNrr+TxnlGXopDhHJYh6818DTu/ACY2QFmD
   ZGyMrXU+OPBLwVrz0HEaMeZa6dsV3H1mU9YKhtLB+Y3iSKFYM9JE0j4Hf
   itP0t1bsHor7wtvY89+s2cuS2Fp9E2Q9Zr9QCoLY5+Up1jCB4jktPPnnc
   4AQISGawwLSzXk8u95HQUDNyNVS+bRGdcyb5wyBJQMF8+iHwB+ZpMp+T6
   Q==;
X-CSE-ConnectionGUID: hLDbUWx/THGIq6Bc2XUjFQ==
X-CSE-MsgGUID: y/RodgT8SBaiz8CZNjt32g==
X-IronPort-AV: E=McAfee;i="6700,10204,11371"; a="42826726"
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="42826726"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:51 -0700
X-CSE-ConnectionGUID: QPk3y5htQ7ayqPQM72yWww==
X-CSE-MsgGUID: Itp5tqJ/RXmtAJ0hgtJNpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,242,1736841600"; 
   d="scan'208";a="121267336"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 15:22:49 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/15] wifi: iwlwifi: updates - 2025-03-13
Date: Thu, 13 Mar 2025 00:22:23 +0200
Message-Id: <20250312222238.2585340-1-miriam.rachel.korenblit@intel.com>
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

A few features, cleanups and bugfixes.

Thanks,
Miri
---

Emmanuel Grumbach (1):
  wifi: iwlwifi: mld: we support v6 of compressed_ba_notif

Miri Korenblit (10):
  wifi: iwlwifi: mld: remove IWL_MLD_EMLSR_BLOCKED_FW
  wifi: iwlwifi: mld: prevent toggling EMLSR due to FW requests
  wifi: iwlwifi: mld: allow EMLSR for unequal bandwidth
  wifi: iwlwifi: mld: KUnit: introduce iwl_mld_kunit_link
  wifi: iwlwifi: mld: KUnit: create chanctx with a custom width
  wifi: iwlwifi: mld: KUnit: test iwl_mld_channel_load_allows_emlsr
  wifi: iwlwifi: mld: make iwl_mld_run_fw_init_sequence static
  wifi: iwlwifi: mld: fix copy/paste error
  wifi: iwlwifi: mld: iwl_mld_remove_link can't fail
  wifi: iwlwifi: mld: add debugfs to control MLO scan

Pagadala Yesu Anjaneyulu (4):
  wifi: iwlwifi: mld: Rename WIPHY_DEBUGFS_HANDLER_WRAPPER to
    WIPHY_DEBUGFS_WRITE_HANDLER_WRAPPER
  wifi: iwlwifi: mld: Add support for WIPHY_DEBUGFS_READ_FILE_OPS_MLD
    macro
  wifi: iwlwifi: mld: Ensure wiphy lock is held during debugfs read
    operations
  wifi: iwlwifi: mld: add support for DHC_TOOLS_UMAC_GET_TAS_STATUS
    command

 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   |  97 +++++++
 .../net/wireless/intel/iwlwifi/fw/dhc-utils.h |  75 +++++
 .../wireless/intel/iwlwifi/mld/constants.h    |   2 +-
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  | 265 +++++++++++++++++-
 .../net/wireless/intel/iwlwifi/mld/debugfs.h  |  60 +++-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  25 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |  19 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.h |   4 +-
 .../wireless/intel/iwlwifi/mld/low_latency.c  |   4 +
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  | 201 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |  23 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   3 +-
 .../net/wireless/intel/iwlwifi/mld/stats.c    |  10 +-
 .../intel/iwlwifi/mld/tests/link-selection.c  | 144 +++++++++-
 .../wireless/intel/iwlwifi/mld/tests/link.c   |  15 +-
 .../wireless/intel/iwlwifi/mld/tests/utils.c  |  46 ++-
 .../wireless/intel/iwlwifi/mld/tests/utils.h  |  36 ++-
 20 files changed, 875 insertions(+), 173 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/dhc-utils.h

-- 
2.34.1


