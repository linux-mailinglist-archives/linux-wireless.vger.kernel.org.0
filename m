Return-Path: <linux-wireless+bounces-8114-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BCCA8D07ED
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 18:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADEE81C2146E
	for <lists+linux-wireless@lfdr.de>; Mon, 27 May 2024 16:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 803FF7345D;
	Mon, 27 May 2024 16:06:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="T2EYUTaB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF787346C
	for <linux-wireless@vger.kernel.org>; Mon, 27 May 2024 16:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716825986; cv=none; b=YmZ/VmAQMNu7y35+y6mC/bzqorrESNavoV9NDS5dud6L8s0p/fLn6ivLb33YNPeRMLkAhLMwtW31qQObLxAcTmSbnye1qfX1hzPdOrZULAu+s0SxuMo+b4q0f+0O/rr6ElHkuu3QpH81iIgdEO2PP1P0myP11lr15KFpuIPd8Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716825986; c=relaxed/simple;
	bh=rQcuk3RUnxUareOXKQSRUUpT5V9DH2EXcJNtFrMtw1U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BPns3rLHHT0lUOFiKkvfxVUedMSUCwRFPOgVyKf1kAEO7NnjiCFMoJAKVg34jiURUQ4696xtwrzWzvSDI/bc+ezkh8JMQXa1wXDT4HlkqQOxbfgWwX8uKRzEoyrS9sM9SDkJGCPhIoQIU18DnmZf+RM+VRheeCx5xOTztLeJDSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=T2EYUTaB; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716825985; x=1748361985;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rQcuk3RUnxUareOXKQSRUUpT5V9DH2EXcJNtFrMtw1U=;
  b=T2EYUTaBrZejCmhtwiL/27SpElgB9TxpXEkDA8A6SZ1bWhy7DNxLfqdF
   q5ySm5C+3+kHDh3sZWZwQcVMHDoQ/BA3Y/w/whFLOmfzOFVxsPYCiuSTn
   Ecx1wjhpnw2F+aTCXAhtxHoIHqoAkigyBMSC393cDkVb2wYPeD0H7y/Ye
   xyqZXZm8GiGQ25E85gwApFUPO0CfsUDpRIoZt3mINKM1JPicMTzxDgetG
   luaEjURAApBD01lLwa/CLFjkkBRCr64QN44pAp5cC8gLbQWc24w7YlBDj
   4aTHL8TtfSIz3qf4aZT3aS4xn5xWrkrYfbLiwLmR3bWK+5KcT54wIgJrN
   A==;
X-CSE-ConnectionGUID: +FFu71BYQ6O3+VlSvV4YfQ==
X-CSE-MsgGUID: en+V0ATBRHm0aJlLR3narQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13002064"
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="13002064"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:24 -0700
X-CSE-ConnectionGUID: J6p4rTjiR6e/Xo9u6KVnGg==
X-CSE-MsgGUID: mOi27ZrkQASRz/F/dlHhjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,193,1712646000"; 
   d="scan'208";a="35407041"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2024 09:06:23 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/20] wifi: iwlwifi: updates - 2024-05-27
Date: Mon, 27 May 2024 19:05:55 +0300
Message-Id: <20240527160615.1549563-1-miriam.rachel.korenblit@intel.com>
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

This patch set includes iwlwifi patches intended for v6.11. It contains
a few features, bugfixes and cleanups.

Thanks,
Miri

Avraham Stern (6):
  wifi: iwlwifi: mvm: add an option to use ptp clock for rx timestamp
  wifi: iwlwifi: mvm: initiator: move setting target flags into a function
  wifi: iwlwifi: mvm: initiator: move setting the sta_id into a function
  wifi: iwlwifi: mvm: modify iwl_mvm_ftm_set_secured_ranging() parameters
  wifi: iwlwifi: mvm: add support for version 14 of the range request command
  wifi: iwlwifi: mvm: add support for version 10 of the responder config command

Avri Altman (1):
  wifi: iwlwifi: mvm: Enable p2p low latency

Johannes Berg (4):
  wifi: iwlwifi: mvm: report 64-bit radiotap timestamp
  wifi: iwlwifi: mvm: handle TPE advertised by AP
  wifi: iwlwifi: mvm: use only beacon BSS load for active links
  wifi: iwlwifi: mvm: show full firmware ID in debugfs

Miri Korenblit (9):
  wifi: iwlwifi: mvm: remove IWL_MVM_USE_NSSN_SYNC
  wifi: iwlwifi: mvm: move a constant to constants.h
  wifi: iwlwifi: mvm: Remove debug related code
  wifi: iwlwifi: mvm: add debug data for MPDU counting
  wifi: iwlwifi: mvm: declare band variable in the scope
  wifi: iwlwifi: mvm: fix a wrong comment
  wifi: iwlwifi: remove redundant prints
  wifi: iwlwifi: move amsdu_size parsing to iwlwifi
  wifi: iwlwifi: move Bz and Gl iwl_dev_info entries

 .../wireless/intel/iwlwifi/fw/api/location.h  | 157 +++++++++++
 .../wireless/intel/iwlwifi/iwl-modparams.h    |  21 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   5 +-
 .../wireless/intel/iwlwifi/mvm/constants.h    |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   8 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         | 256 +++++++++++++-----
 .../intel/iwlwifi/mvm/ftm-responder.c         |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |  14 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  13 +-
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  57 +++-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   9 +
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  10 +
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   3 +
 .../wireless/intel/iwlwifi/mvm/tests/links.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  54 ++--
 18 files changed, 519 insertions(+), 139 deletions(-)

-- 
2.34.1


