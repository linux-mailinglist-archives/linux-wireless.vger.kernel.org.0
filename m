Return-Path: <linux-wireless+bounces-25204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BDD9B00B5A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 20:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 961D05A3164
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 18:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A0E2F49FE;
	Thu, 10 Jul 2025 18:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JTEdN63t"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE30F2F3638
	for <linux-wireless@vger.kernel.org>; Thu, 10 Jul 2025 18:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752172135; cv=none; b=IGx13XAeh7FTtFC/IFMtVbK5V0L1xrhR2eb6dhpCd7O1AC2Te3zy4lxlnVZW7jfsXSislPt8o/ZSJ7zEr2e+yG2RA71bKzFtoy+JVMJo4iEC96NiMdK5CLIeDVwXkxj8zOVh8z+BJM8ov/ISf8NY/tQn56KEm4VbBHFSyhe3Fcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752172135; c=relaxed/simple;
	bh=atqwtG7cPWubA4LLy3/KF1avU0V6hD70gm/w9j5Hnmc=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=upQUN/0nZkWl+GXczwbVFYsKCmXII1tdFyt4yeISDdR6EidJgAcjrG2ygd1IVm3ys4tsdj+eDYuXewh89i3REq2UPnNZf0XZ9U/XUEa8u6/u8blJI3jddrF65FyUsXnlzNcRxYqODre49Um1ERKErzBtTvu32/nSARNj9LiVKgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JTEdN63t; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752172134; x=1783708134;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=atqwtG7cPWubA4LLy3/KF1avU0V6hD70gm/w9j5Hnmc=;
  b=JTEdN63t9h1sejLjF4d89Phl/05f6/1rwkduaug/LC+WUkxBHvb3klWz
   WrITdq7qQFs3KPmOIUUblPev3zSgn69KeKekPzo1uo4Ihx7BZMOevO5tn
   +wEHbjHYDDJfiat8gmNilodrfzUylccFXp/JLbgTFbM7o5Mi42n1LB5e7
   NSmqM1zHjCOKPLJR3+ky1Mq9POrf//pF2n/g/MH1bCimYbi+u631pIDHc
   y1ErHzWmKi6MjRR2B6PAPpYwFQyckPRDV6qMFfEhSLvV/Tvic39WWu0/8
   rD6/D9R/qa6VDX/F98SsCe3GVCm7S/tlrLIpIeoqIfBveXDWqeYHvX+A7
   w==;
X-CSE-ConnectionGUID: s3Xi09Q7SOCjScEzxqmORw==
X-CSE-MsgGUID: aHAAotZETQWD8wkwx5oodQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11490"; a="57077788"
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="57077788"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:53 -0700
X-CSE-ConnectionGUID: s+p7/DyxSieVi3TgHiSY0g==
X-CSE-MsgGUID: tSpxFd+VQ5CYbXup4TNW4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,301,1744095600"; 
   d="scan'208";a="160718660"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2025 11:28:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-10
Date: Thu, 10 Jul 2025 21:28:17 +0300
Message-Id: <20250710182832.2615019-1-miriam.rachel.korenblit@intel.com>
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
Features, cleanups and bugfixes from our internal tree.

Miri

Avraham Stern (3):
  wifi: iwlwifi: mld: fix scan request validation
  wifi: iwlwifi: mld: update the P2P device mac before starting the GO
  wifi: iwlwifi: mld: update expected range response notification
    version

Johannes Berg (4):
  wifi: iwlwifi: mvm: remove regulatory puncturing setup
  wifi: iwlwifi: mld: restrict puncturing disable to FM
  wifi: iwlwifi: fix HE/EHT capabilities
  wifi: iwlwifi: pcie: don't WARN on bad firmware input

Miri Korenblit (4):
  wifi: iwlwifi: mvm: set gtk id also in older FWs
  wifi: iwlwifi: mvm: always set the key idx in gtk_seq
  wifi: iwlwifi: mvm: don't remove all keys in mcast rekey
  wifi: iwlwifi: mld: don't remove all keys in mcast rekey

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: add support for accepting raw DSM tables by firmware

Rotem Kerem (3):
  wifi: iwlwifi: add suppress_cmd_error_once() API
  wifi: iwlwifi: add iwl_trans_device_enabled() API
  wifi: iwlwifi: add iwl_trans_is_dead() API

 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   6 +
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  35 ++++--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   4 +
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  78 +++---------
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  15 +++
 drivers/net/wireless/intel/iwlwifi/mld/ap.c   |  24 ++--
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 112 ++++++------------
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/key.c  |  12 ++
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |  14 ++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   2 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   2 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |  30 +++--
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  85 ++++++-------
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   1 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |  11 +-
 27 files changed, 230 insertions(+), 239 deletions(-)

-- 
2.34.1


