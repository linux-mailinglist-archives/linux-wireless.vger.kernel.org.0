Return-Path: <linux-wireless+bounces-3231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A90784BA81
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 17:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD8891C231EC
	for <lists+linux-wireless@lfdr.de>; Tue,  6 Feb 2024 16:02:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE281134CC9;
	Tue,  6 Feb 2024 16:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eiAyCc+h"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09DC134740
	for <linux-wireless@vger.kernel.org>; Tue,  6 Feb 2024 16:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707235347; cv=none; b=qDU9iIRi1B6bZjy8E0VeKlVYV0T5HhUHZECWJauFNmNs+tgQtAnX2aOaP7UeOz4quZ0ABMHZFiKScFzBJ3/OlfpPtRr0FTLjCpwYI0kwnNC03dbGHDAyYKzOSpOAQYo5wED8hSei5qiGJf8dRhYEKVinwMiWDujiyVQwb41YAJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707235347; c=relaxed/simple;
	bh=/l35/W9pOM0NnRe8YbNavOdetZja5RS7ytmgp+6DwKI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fKqso6FHicC8QdtpO/2DLMhfx/z3b8GijcpkoPHPHGd0VM7PyTsp83OKtv9ZCqDxYghEtzuDznIsOkXeLS7UyqHamqUngNW+N5oSQNTzU3pzAGx/pW74Il3NxGwZ3sPArGSt3qTJ27wXwu/oYRep0M9OjuZCNHcXjLVk2Oxw8cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eiAyCc+h; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707235346; x=1738771346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=/l35/W9pOM0NnRe8YbNavOdetZja5RS7ytmgp+6DwKI=;
  b=eiAyCc+hpaut1FYkS9acGAcy+bOSrRg3hJktIiRSgP60dOWaAn7UIasA
   kAGVrMvvKPlCMGpGodzW8dcK0kVkXvAdQFnCtSgF+A+Smi/s9qp3nfnk6
   tQDe22hCmkk6M5+egGpPit1cvaYkeRJRo1FZXKTWAVSxa/yRE+rCrLD5E
   J/t2+OFPrO8kSHHQMSm76g4Q0IdHX7YlUmiZoiHjpV/1UBNOipZv3Pz8V
   IZJpV3AWPivWc13luoT7+5Hc3O0Z8/5OADFwYavIMP+wExk+ZwexWzn50
   4O1kzxRM86JN+Ze7sg2IZH9wx8Rmn2nteeSvxgNko2SS46JyGe7MPpqDt
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="23252299"
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="23252299"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,247,1701158400"; 
   d="scan'208";a="1349794"
Received: from unknown (HELO WEIS0040.iil.intel.com) ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 08:02:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/11] wifi: iwlwifi: updates - 2024-02-06
Date: Tue,  6 Feb 2024 18:02:03 +0200
Message-Id: <20240206160214.3260547-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.9. It contains a
few features, bugfixes and cleanups.

Thanks,

Emmanuel Grumbach (3):
  wifi: iwlwifi: mvm: fix a crash when we run out of stations
  wifi: iwlwifi: mvm: don't set the MFP flag for the GTK
  wifi: iwlwifi: mvm: don't send the smart fifo command if not needed

Johannes Berg (6):
  wifi: iwlwifi: fw: allow vmalloc for PNVM image
  wifi: iwlwifi: mvm: don't set replay counters to 0xff
  wifi: iwlwifi: mvm: remove flags for enable/disable beacon filter
  wifi: iwlwifi: mvm: show skb_mac_gso_segment() failure reason
  wifi: iwlwifi: mvm: move BA notif messages before action
  wifi: iwlwifi: queue: improve warning for no skb in reclaim

Mukesh Sisodiya (1):
  wifi: iwlwifi: pcie: Add new PCI device id and CNVI

Shaul Triebitz (1):
  wifi: iwlwifi: iwlmvm: handle unprotected deauth/sidassoc in d3

 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   | 38 +++++++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  5 ++-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 10 ++---
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  8 +++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 10 +++--
 .../wireless/intel/iwlwifi/mvm/debugfs-vif.c  |  6 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 21 +++++-----
 .../net/wireless/intel/iwlwifi/mvm/mld-key.c  | 18 +++++----
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +--
 .../net/wireless/intel/iwlwifi/mvm/power.c    | 29 ++++++--------
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  4 ++
 drivers/net/wireless/intel/iwlwifi/mvm/sf.c   |  5 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 30 +++++++++------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 15 +++++++-
 drivers/net/wireless/intel/iwlwifi/queue/tx.c |  9 +++--
 16 files changed, 143 insertions(+), 73 deletions(-)

-- 
2.34.1


