Return-Path: <linux-wireless+bounces-18805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14246A31E17
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 06:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B107188B6F2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 05:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58DD71E1A05;
	Wed, 12 Feb 2025 05:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="aZjIqy0T"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A361E271837
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 05:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739339030; cv=none; b=LiIGdtAWL5ILDQp1t3MxhswGzZjSufjrgWyYcfBJRfog9pdWqeEqGDSiUZZjLwm4y0MC/lOiWR0rhrcK9ep/xmeHP04VSI66l2UgzYO6JH0b0Py5djaW0hLpWBxEe8Dic1IKc/Poyr+GzDaxe6isTC4RM5Te8m6J66KnvOeRe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739339030; c=relaxed/simple;
	bh=hJFBkbe1kacoJuEKwJg44mrMaPkeNzwLjpfgaiHwqw0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lAC4Orqtw5iMNwjYgaXaTeAYFN8o6z1HSMLelg+NW34jxuVyU1zGniYn9avCinZZuGOQfEP1lP3qz56EJciY7tXhL4IGUXnL+yHUMxIvRb//x45V+CFL5QxdolA/RvFB1Tr6E/pgr8Bv6JzZULCbRL5e8lMUbMieTyT280QZUU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=aZjIqy0T; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1739339028; x=1770875028;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=hJFBkbe1kacoJuEKwJg44mrMaPkeNzwLjpfgaiHwqw0=;
  b=aZjIqy0TAZy1Bw/T8oXEWvT44Eqer91Y9dkr1jh2aE3jcdJJg6ZI2PqH
   z6yJGw4BQrWIKBW0oKNYif90x5MhGXu6q94fnvZebffb7WxoifCc9YYef
   jSRE81jv4ad7Su4sFupttaK2yPfN6/pxmlMYsJZ72xOJojpiZ8cC1fzkM
   mEKSnAS+cr+tLdSWidpaCznRkjUuYhiPkASFbJ5TkbNUFXrf7JxzbkKY8
   mvxefdjGYyUN9R4ojUGPBJnHr0Rfb+PViH9lsR6464oa7Le1p9t0tNgqh
   JuKVVqgLxp+OyPV8LghhYtMwlEzSCVgFriOy6mCzPX/y34E1KN4axEPxu
   w==;
X-CSE-ConnectionGUID: oagi0PvkToKb1MotKZs6pA==
X-CSE-MsgGUID: qkka6p4NQcG4ZPqRotmc7g==
X-IronPort-AV: E=McAfee;i="6700,10204,11342"; a="39172195"
X-IronPort-AV: E=Sophos;i="6.13,279,1732608000"; 
   d="scan'208";a="39172195"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:48 -0800
X-CSE-ConnectionGUID: i4OcMhOLQ4+eDhByE0sXbA==
X-CSE-MsgGUID: eMGSUhv8S+uQlJVu/aqVGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="117893812"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2025 21:43:47 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/12] wifi: iwlwifi: updates - 2025-02-12
Date: Wed, 12 Feb 2025 07:43:21 +0200
Message-Id: <20250212054333.376219-1-miriam.rachel.korenblit@intel.com>
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

This series contains features and cleanups.

Thanks,
Miri
---

Avraham Stern (1):
  wifi: iwlwifi: location api cleanup

Emmanuel Grumbach (4):
  wifi: iwlwifi: use 0xff instead of 0xffffffff for invalid
  wifi: iwlwifi: add support for external 32 KHz clock
  wifi: iwlwifi: export iwl_get_lari_config_bitmap
  wifi: iwlwifi: remember if the UATS table was read successfully

Johannes Berg (1):
  wifi: iwlwifi: add OMI bandwidth reduction APIs

Miri Korenblit (6):
  wifi: iwlwifi: remove mvm prefix from iwl_mvm_esr_mode_notif
  wifi: iwlwifi: mld: add a debug level for PTP prints
  wifi: iwlwifi: mld: add a debug level for EHT prints
  wifi: iwlwifi: remove mvm prefix from iwl_mvm_d3_end_notif
  wifi: iwlwifi: add IWL_MAX_NUM_IGTKS macro
  wifi: iwlwifi: add Debug Host Command APIs

 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +
 .../wireless/intel/iwlwifi/fw/api/context.h   |   6 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |   2 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |  19 ++-
 .../net/wireless/intel/iwlwifi/fw/api/dhc.h   | 129 ++++++++++++++++++
 .../wireless/intel/iwlwifi/fw/api/location.h  |  66 ++++-----
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   4 +-
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  52 +++++++
 .../net/wireless/intel/iwlwifi/fw/api/sta.h   |   1 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   7 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   1 +
 .../net/wireless/intel/iwlwifi/fw/runtime.h   |   2 +
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |   3 +
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   8 +-
 .../net/wireless/intel/iwlwifi/iwl-debug.h    |   9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   3 +
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   2 +-
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  18 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   6 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   5 +-
 22 files changed, 291 insertions(+), 65 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/fw/api/dhc.h

-- 
2.34.1


