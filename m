Return-Path: <linux-wireless+bounces-22839-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B977CAB29C2
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 18:53:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 422BA175C80
	for <lists+linux-wireless@lfdr.de>; Sun, 11 May 2025 16:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2B1825A2DA;
	Sun, 11 May 2025 16:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="QcMASpBR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38BE17DFE7
	for <linux-wireless@vger.kernel.org>; Sun, 11 May 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746982418; cv=none; b=Evk8u8XAoUpjCbWyVISdsh/6YUhGTxXMzopvOT4JKx8d1kmdSUoVy6Yq93kO9uioU738DzU2It9xAYdYyTVCkkRue8s9NR6nPsHtP7kugsGJzFo6dDKMAES40BNwq++k+qAcsBGzkTRidEo6A8Oa3PksnI+VYRacR/1p4/lUs/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746982418; c=relaxed/simple;
	bh=y1yfWn5qiYA6QxNhLT5YfEGeg9guSC1fqk/TF/g1gfE=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EWaAK+nAOPc5ZaH0cdLmyxhXb+4ce2ZkDMmMyZOTgUMRnxPdUo/JANWJPeZZ/10kT8SKu7Iw0oL2w8BFBlwVvnwejxOvrzXswoxJsGOu4QZun4VmfdChjHukEH8/CJDIXJratJeAGcUMXKen6snWKXAaM5IR/VJG9iinlVkNWSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=QcMASpBR; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746982417; x=1778518417;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=y1yfWn5qiYA6QxNhLT5YfEGeg9guSC1fqk/TF/g1gfE=;
  b=QcMASpBRVFluEBfag3w3JJU11hcrylC9WmElGEd3CVh8dGqSV+Ne3B0Z
   DpvxC2sqWX1X9cEfXKIGDurNEs8ycPCbo4k/gwh7gmFBaGQY6ou5cmrQT
   QrUIClf7k7qKWt/v3v/jJChOUGWfMf3scKBbTLu0+9CwQATL2cpVfhaJI
   FhGJI9oPU89yzuMy0wZkw/J+4qrwBNypwZFR8HOp43ZHfetQu8jAciRR3
   0yoHcIvWoc8O0vBf3K6BweI0e4BAgROTA6DSW79ZfI9XS7sD2Xc8+3t8f
   cb+S5C1hL2kecl44XlCfOb7vTGhwkHKXhPUQqvJYNgBcUiDjZJdRWgmCs
   g==;
X-CSE-ConnectionGUID: HdQuTNbHTyu/QFXSLCYbXw==
X-CSE-MsgGUID: 3T+10d3PQ6qPgIYRB3Eb1A==
X-IronPort-AV: E=McAfee;i="6700,10204,11430"; a="52582678"
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="52582678"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:36 -0700
X-CSE-ConnectionGUID: PtqFrvkER9q1gIYj+IiNLA==
X-CSE-MsgGUID: w5fntzPITS6xRBmZ2gPv1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,280,1739865600"; 
   d="scan'208";a="137654995"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2025 09:53:35 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-11
Date: Sun, 11 May 2025 19:53:06 +0300
Message-Id: <20250511165321.590808-1-miriam.rachel.korenblit@intel.com>
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

Thanks,
Miri

Johannes Berg (4):
  wifi: iwlwifi: cfg: mark Ty devices as discrete
  wifi: iwlwifi: cfg: clean up dr/br configs
  wifi: iwlwifi: cfg: reduce configuration struct size
  wifi: iwlwifi: fw: api: include required headers in rs/location

Miri Korenblit (10):
  wifi: iwlwifi: stop supporting TX_CMD_API_S_VER_8
  wifi: iwlwifi: use normal versioning convention for iwl_tx_cmd
  wifi: iwlwifi: remove GEN3 from a couple of macros
  wifi: iwlwifi: use bc entries instead of bc table also for pre-ax210
  wifi: iwlwifi: unify iwlagn_scd_bc_tbl_entry and iwl_gen3_bc_tbl_entry
  wifi: iwlwifi: remove unused macro
  wifi: iwlwifi: map iwl_context_info to the matching struct
  wifi: iwlwifi: fix a wrong comment
  wifi: iwlwifi: rename ctx-info-gen3 to ctx-info-v2
  wifi: iwlwifi: mld: allow 2 ROCs on the same vif

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: Add helper function to extract device ID

 drivers/net/wireless/intel/iwlwifi/Makefile   |  2 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    | 10 +++
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 23 +----
 .../wireless/intel/iwlwifi/fw/api/commands.h  |  6 +-
 .../wireless/intel/iwlwifi/fw/api/location.h  |  5 ++
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  4 +-
 .../net/wireless/intel/iwlwifi/fw/api/tdls.h  |  6 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    | 21 +++--
 .../net/wireless/intel/iwlwifi/iwl-config.h   | 30 +++----
 ...text-info-gen3.h => iwl-context-info-v2.h} | 40 ++++-----
 .../wireless/intel/iwlwifi/iwl-context-info.h |  2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   | 26 ++----
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 16 ++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  7 ++
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |  2 -
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  | 59 +++++++++----
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 16 ++--
 .../pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} | 84 +++++++++----------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 76 +++++++----------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  8 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  6 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  | 10 +--
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 14 ++--
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c | 31 ++++---
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  | 32 +++----
 .../wireless/intel/iwlwifi/tests/devinfo.c    | 69 +++++++++++----
 29 files changed, 329 insertions(+), 288 deletions(-)
 rename drivers/net/wireless/intel/iwlwifi/{iwl-context-info-gen3.h => iwl-context-info-v2.h} (91%)
 rename drivers/net/wireless/intel/iwlwifi/pcie/{ctxt-info-gen3.c => ctxt-info-v2.c} (89%)

-- 
2.34.1


