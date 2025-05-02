Return-Path: <linux-wireless+bounces-22342-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28B22AA72A9
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 14:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCCE05A2892
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CE11246794;
	Fri,  2 May 2025 12:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="WYN/Udmd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2545723C516
	for <linux-wireless@vger.kernel.org>; Fri,  2 May 2025 12:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746190608; cv=none; b=GaWBpfkzCMEdF30EZSqQ+mLYyZwuSfryNkKSOKzpa6KfdI3VMWXZIE3pjgR7EgEdN6hGdUe+h8VbKbGm23qJgLSItZOYKsMZ9BmFCZ4+bZTuXpWYwmrgdHB0dLNORis0IvZAx4mMql7vMbjkrt9nI/kzALLXHYwEV2ZeAToJXRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746190608; c=relaxed/simple;
	bh=5mDb1jhTSy64Hl6mqAo+Aw+NgNZmTIQDRgkRs6QasIA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mGfZcxa9xm0SE3eojzgqvakHX+IXobW42eess2XJ89YhwVcllOPq5xbDEn/COHIKfWD6Rc5/mJxiECXOos6ogD72p4xU2b0q03MJR+/YMTh8xjtpbGGxUQlPrnasUp0LkGVfTvtBjGH5N2a0uET0K7vahupyN9iZVsUvYgIv4ug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=WYN/Udmd; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746190607; x=1777726607;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=5mDb1jhTSy64Hl6mqAo+Aw+NgNZmTIQDRgkRs6QasIA=;
  b=WYN/UdmdguwYzyN11k5K7iJmFr+p8+r4+RrfgO1oVFbPNOi8MHPPYgZ/
   czq6XV3a26G4S7Rk/lNIFBAG7n6LQnj+uFf5jtr/qE+lpgcdbDno2nS1J
   wMruvMdlSeHXkkwsgQvWTbmqQAufSYzCE1iPX6s1Kjdztj7Q1flq9onEB
   Ie56sYcsfmami2/69/KWaE8muM0xZ/ock5V1o7vMzrjBpPCl1usERwK3M
   MZi26gRwaDK+cL90Vbs2w3TOCgh2KJISSHbQmMtK5r9JGtKK7YXXqC3r+
   NllyfUMO+0x9mIjyvpB+NrT5OaXd5G+wEQgCD5e8g4qyyRRznXQAa0fj4
   A==;
X-CSE-ConnectionGUID: waDs6yk/RMyMtO8l4wiYEQ==
X-CSE-MsgGUID: o8IfzuPnRvGKQ1dRdNK1tA==
X-IronPort-AV: E=McAfee;i="6700,10204,11421"; a="59255531"
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="59255531"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:46 -0700
X-CSE-ConnectionGUID: i4p/qL7WQEasK5zBoVVQzA==
X-CSE-MsgGUID: 1EVITy26TuOZsJGC/0l47A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,256,1739865600"; 
   d="scan'208";a="165554691"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 May 2025 05:56:44 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-02
Date: Fri,  2 May 2025 15:56:16 +0300
Message-Id: <20250502125631.3184319-1-miriam.rachel.korenblit@intel.com>
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

features and cleanups from our internal tree.

Thanks,
Miri

Johannes Berg (15):
  wifi: iwlwifi: cfg: remove iwl_cfg_br
  wifi: iwlwifi: tests: check configs are not duplicated
  wifi: iwlwifi: tests: check transport configs are not duplicated
  wifi: iwlwifi: cfg: clean up BW limit and subdev matching
  wifi: iwlwifi: cfg: rename BW_NO_LIMIT to BW_NOT_LIMITED
  wifi: iwlwifi: pcie: remove 'ent' argument from alloc
  wifi: iwlwifi: cfg: minor fixes for Sc
  wifi: iwlwifi: cfg: finish config split
  wifi: iwlwifi: cfg: move all names out of configs
  wifi: iwlwifi: tests: check for duplicate name strings
  wifi: iwlwifi: cfg: reduce mac_type to u8
  wifi: iwlwifi: cfg: remove unnecessary configs
  wifi: iwlwifi: pcie: don't call itself indirectly
  wifi: iwlwifi: mvm: add command order checks to kunit
  wifi: iwlwifi: remove iwl_cmd_groups_verify_sorted()

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |   23 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   48 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |   24 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   45 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |  153 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |  123 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   49 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |   14 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |   38 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   14 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   10 -
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   28 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  159 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |    7 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   18 -
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |    3 -
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |    4 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |    8 +-
 .../wireless/intel/iwlwifi/mvm/tests/Makefile |    2 +-
 .../wireless/intel/iwlwifi/mvm/tests/hcmd.c   |   42 +
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1752 ++++++++++-------
 .../wireless/intel/iwlwifi/pcie/internal.h    |    1 -
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |    4 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |   10 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   13 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  141 +-
 26 files changed, 1586 insertions(+), 1147 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mvm/tests/hcmd.c

-- 
2.34.1


