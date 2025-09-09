Return-Path: <linux-wireless+bounces-27119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F38B49FEE
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 05:22:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AFBA01B24546
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 03:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 454011A08A3;
	Tue,  9 Sep 2025 03:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="IQUs0aDj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8957C26F2B2
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 03:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757388118; cv=none; b=AcO1djnH/QlljMCPmoChUdUMGLAeEPjff/MZPVc9vZ70EkoJnUhtfUXC3uKmCSySZDbWmuL5MP1Q9MySGdPDa5ktZayMWLv4+GFaHfpb8tV8QEK+p9o/s9hOeX0rc1vI4gwSTOdxC3I8oVjo50zLRMGTq7LKMmkv3V0yVvxB4hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757388118; c=relaxed/simple;
	bh=sURoUPOB1nm3QOBlD50qf2qsFtmYQpKw0nWknXA9VB8=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=kpUlXF+OmyhwexEqj4cuGbm0UanVPixOBAmMQnYcsJFFBbJ2xerKxn5KazBwqD62KxUzqaShUDObFIBRKOKH1gabfslsVvUyCRxY95mC3N9cHUaxOuu0IHC1jzsFY9xWreadOXqmScmmnHOgQ+UWRIz/0BvDOJmLoeaIs84y9Mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=IQUs0aDj; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757388116; x=1788924116;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=sURoUPOB1nm3QOBlD50qf2qsFtmYQpKw0nWknXA9VB8=;
  b=IQUs0aDjpw2nE9XA8o8HyVDb9hSwyb39ISRs3wufXJ7oPm0m2oc3qWoU
   5ZYCb0ajFccOSDu80tSn8Y7qAOxyb2KQ+oWXUhCLsJxx6pLmHPNZO55oA
   alg/d2HfI5Dis9CombFJJmCS2edfnUT5JgW9GDHgiYjaOmzdypfRaeRJ0
   3d/oGz5BElRY4EaVBY8cYkbv/RKlY8G7FRiDQJJ0uyMvF5xuGZvQQsgek
   PcpA2/19JR0J89OQNdlYQyRItq0vgZH2YYvnfhp7fHaZysSpKAuZn/qa7
   zWXL9NHz7rQ1zRZV0PKdFxhy/xD7vsHgiBQqo/E9uq1tyF8GCD4mXtfsU
   g==;
X-CSE-ConnectionGUID: OGG9sf8+SSmdDFGVozOKvA==
X-CSE-MsgGUID: HLPz77BXRACMIWBvByE32w==
X-IronPort-AV: E=McAfee;i="6800,10657,11547"; a="70281047"
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="70281047"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:56 -0700
X-CSE-ConnectionGUID: VGSSIZ+RT5iNvSQsVlifOw==
X-CSE-MsgGUID: hHtdzWIzSAKVwFZtiS5ZYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,250,1751266800"; 
   d="scan'208";a="203950282"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2025 20:21:55 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH v2 iwlwifi-next 00/15] wifi: iwlwifi: updates -2025-09-07 
Date: Tue,  9 Sep 2025 06:21:13 +0300
Message-Id: <20250909032128.3318193-1-miriam.rachel.korenblit@intel.com>
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
Resending this with checkpath fixed.

Miri
---

Miri Korenblit (10):
  wifi: iwlwifi: rename iwl_finish_nic_init
  wifi: iwlwifi: pcie: move pm_support to the specific transport
  wifi: iwlwifi: pcie: move ltr_enabled to the specific transport
  wifi: iwlwifi: api: add a flag to iwl_link_ctx_modify_flags
  wifi: iwlwifi: mld: don't consider phy cmd version 5
  wifi: iwlwifi: mld: remove support of mac cmd ver 2
  wifi: iwlwifi: mld: remove support of roc cmd version 5
  wifi: iwlwifi: mld: remove support from of sta cmd version 1
  wifi: iwlwifi: mld: remove support of iwl_esr_mode_notif version 1
  wifi: iwlwifi: mld: CHANNEL_SURVEY_NOTIF is always supported

Nidhish A N (1):
  wifi: iwlwifi: fw: Add ASUS to PPAG and TAS list

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: add kunit tests for nvm parse

Rotem Kerem (3):
  wifi: iwlwifi: add STATUS_FW_ERROR API
  wifi: iwlwifi: replace SUPPRESS_CMD_ERROR_ONCE status bit with a
    boolean
  wifi: iwlwifi: implement wowlan status notification API update

 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 112 +++++++-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   3 +
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   2 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  76 +-----
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |  74 ++++++
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  15 ++
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  33 ++-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 239 +++++++++++++++---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  30 +--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  28 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   1 -
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  13 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |  20 +-
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |   2 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  20 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   5 +-
 .../net/wireless/intel/iwlwifi/tests/Makefile |   2 +-
 .../wireless/intel/iwlwifi/tests/nvm_parse.c  |  72 ++++++
 33 files changed, 582 insertions(+), 229 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c

-- 
2.34.1


