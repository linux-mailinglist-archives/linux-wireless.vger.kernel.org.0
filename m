Return-Path: <linux-wireless+bounces-27047-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F06B4799B
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 10:30:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 282E13B9243
	for <lists+linux-wireless@lfdr.de>; Sun,  7 Sep 2025 08:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4771DE885;
	Sun,  7 Sep 2025 08:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="c2CZrAdB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A37117A31E
	for <linux-wireless@vger.kernel.org>; Sun,  7 Sep 2025 08:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757233854; cv=none; b=k7tSZU033cXmpBdEALgpsT72lrIz9yu95sb9D9/0odnsnh1D3qCexi0x/l4niW1vHkYFKqPhyEEjo4WTfZf+oHkGd1TPOqGJXLvIUIpNHZBPAJLSxHjymd8CXnejSlQG9leEtPcoUmD/FLBZXWcJPfzkgKxGGKgWdHRM9tmHsSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757233854; c=relaxed/simple;
	bh=IfXkR/vX2W5uouQ3qHlwVmTjc/6xZlE0uGJoilkMuKQ=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=BNKNfSj2ySO8S9SGwrZuqlW5U6qh7g9HjtAeQBhY2Iy1CseTpn2DFyjFpBw9UE0BonJzzdeix8rI6oRQVjIbbLomTohtLJJ7PbKo6YxT28BhEWIRF9aS1oWwuUlKT2OGgVlOrjWdcOiC2gs8Xpg3voHz9ANfj/fqLx4tbrPXT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=c2CZrAdB; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1757233852; x=1788769852;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IfXkR/vX2W5uouQ3qHlwVmTjc/6xZlE0uGJoilkMuKQ=;
  b=c2CZrAdBDMb7UAU0OVb6Jcole2qQ0Pl2Ksb7HPbiiEjp6MjlPdj6Wc6g
   F9QZqlSpDIpewAAtLaHqmB6msBeCEmLbYOlhMdkZjRnnJIFfFU0SuxnYh
   NCF2n25UqM98jaqc9zkXGdRp8oqfRL1T8uBBqWO+/9+q5fwf27rfZChb1
   r7ro3jby8iNlVxZob+xo/NbqfLP/3Gm9Vw9iRbmBMtqKm1b++Si60Q5/d
   XwqgxjYovKNfQGJWvV/haArE1LM5Wy8va4vLfUDDmctcS7sHuvaY3PZ8p
   QknbT5l2ZIR96AeEqmLPNgkHMMY+1+jUSb0XVu2Fv9pRCM4veQqidruq1
   A==;
X-CSE-ConnectionGUID: 8vWKjMO/SrehOUt/upSzmA==
X-CSE-MsgGUID: vGdP+kFnRWSArENRTObR2g==
X-IronPort-AV: E=McAfee;i="6800,10657,11545"; a="76973593"
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="76973593"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:52 -0700
X-CSE-ConnectionGUID: ks0ivcWiRsuUrLflsAx7nQ==
X-CSE-MsgGUID: YkUmsBAdR6uvqb2nN4N2xQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,246,1751266800"; 
   d="scan'208";a="171789996"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2025 01:30:51 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-09-07
Date: Sun,  7 Sep 2025 11:29:59 +0300
Message-Id: <20250907083014.1439961-1-miriam.rachel.korenblit@intel.com>
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
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 112 ++++++++-
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
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   | 236 +++++++++++++++---
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  30 +--
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  28 +--
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
 33 files changed, 579 insertions(+), 229 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/tests/nvm_parse.c

-- 
2.34.1


