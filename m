Return-Path: <linux-wireless+bounces-16932-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E1C9FEF37
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 12:59:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 32D0E1882BD7
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Dec 2024 11:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B6EF195962;
	Tue, 31 Dec 2024 11:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eyyiXkp6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A57217ADE8
	for <linux-wireless@vger.kernel.org>; Tue, 31 Dec 2024 11:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735646372; cv=none; b=JqiponD6LD/OWA1RdVK5Roi7u6QVkyRp/zmGubPsBQG/IJL31aEe1noOk8dINREuDPO1v4PuYPeSKmlka+9E0BwkUILmvOXK4JVx81mtmYSfUm4Wo4Dluz3+s4IzNyFOcEOlo6sE3+7Gh/7yLOJo/SrqWhoXYm40VYkCuUjYMVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735646372; c=relaxed/simple;
	bh=Gz+9sI3M+woGuLBoxrWM4remiLMXlWML2GprX0PE9oM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Pwr55IYq0EGRZAo5ofsuvIYrO0QpFiTdqBf0Z+cmbG1dpg8f6h8Nz/f2o29oimV8w1ScVeAa1YXwmIh7U+vgsUD4LwQZeWUWsmYR6kLFIXlqtSOyRY8uYJR+TK3mwW11YBAUWYRXZuDXrq5LRB3USWJtIOxgPMpgg1EcT1IvUoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eyyiXkp6; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735646370; x=1767182370;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Gz+9sI3M+woGuLBoxrWM4remiLMXlWML2GprX0PE9oM=;
  b=eyyiXkp6H37o7utg6Q2P4J38M6NzQJ3aApNUb7MKcfWhLxhBMLobSYbn
   2urtGiYhpIzCB4/nq+FKsq1El6IOwAGks8MnEslTJldF6MegSGztcV06R
   OLRELNulhl3qVSPnwkC4fMiJtLzYUGttuih4tg84AzytW14CM98ZXakWl
   oxU08FctsRtJ0Yrr9rM9fioXPtx60QJqNpdpSUU+JzkTMidXk5Vu4GjN5
   ux2jVEopmI5igxy6jxQPKdKu0yfYtw1rPxTzxE34/+AMAk8zzVBGLSOIK
   tmnty1HF3utnooHNvs1YHqzrx/tsC42BPfW+AS5tte10hfcqLoLDbTl1t
   g==;
X-CSE-ConnectionGUID: b2jqvnO+R7WOoroVcOcLEg==
X-CSE-MsgGUID: 6BWjJ2TSR8+4Q94LhyeFbQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11302"; a="53330150"
X-IronPort-AV: E=Sophos;i="6.12,279,1728975600"; 
   d="scan'208";a="53330150"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:29 -0800
X-CSE-ConnectionGUID: 39hjWb7+S6q1S90YP9b/HQ==
X-CSE-MsgGUID: JdDxoUibTIijR2+0O8VLrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="138380247"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Dec 2024 03:59:29 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 31-12-24
Date: Tue, 31 Dec 2024 13:59:00 +0200
Message-Id: <20241231115915.1082656-1-miriam.rachel.korenblit@intel.com>
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
----

Anjaneyulu (4):
  wifi: iwlwifi: add WIKO to PPAG approved list
  wifi: iwlwifi: extend TAS_CONFIG cmd support for v5
  wifi: iwlwifi: mvm: handle version 3 GET_TAS_STATUS notification
  wifi: iwlwifi: mvm: remove unused tas_rsp variable

Emmanuel Grumbach (1):
  wifi: iwlwifi: get the max number of links from the firmware

Johannes Berg (9):
  wifi: iwlwifi: pcie: check for WiAMT/CSME presence
  wifi: iwlwifi: implement product reset for TOP errors
  wifi: iwlwifi: implement reset escalation
  wifi: iwlwifi: mvm: improve/fix chanctx min_def use logic
  wifi: iwlwifi: config: unify fw/pnvm MODULE_FIRMWARE
  wifi: iwlwifi: mvm: support EMLSR on WH/PE
  wifi: iwlwifi: remove Mr/Ms radio
  wifi: iwlwifi: pcie: make _iwl_trans_pcie_gen2_stop_device() static
  wifi: iwlwifi: pcie: make iwl_pcie_d3_complete_suspend() static

Miri Korenblit (1):
  wifi: iwlwifi: rename iwl_datapath_monitor_notif::mac_id to link_id

 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  46 +--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  31 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  36 +--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  52 ++--
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  33 ++-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  42 ++-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   1 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   3 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  40 +--
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  29 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  28 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |   3 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  15 +
 drivers/net/wireless/intel/iwlwifi/iwl-prph.h |   4 +
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 160 ++++++++--
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  23 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  93 +++---
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  44 ++-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  28 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   3 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  48 +++
 .../wireless/intel/iwlwifi/pcie/internal.h    |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   4 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   5 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   | 273 +++++++++++++++++-
 30 files changed, 790 insertions(+), 281 deletions(-)

-- 
2.34.1


