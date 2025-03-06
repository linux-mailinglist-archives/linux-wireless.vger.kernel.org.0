Return-Path: <linux-wireless+bounces-19893-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0FBA549F3
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 12:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9BB2618840C6
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Mar 2025 11:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82C6A204590;
	Thu,  6 Mar 2025 11:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f/6TeCgS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7185B1A0711
	for <linux-wireless@vger.kernel.org>; Thu,  6 Mar 2025 11:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741261750; cv=none; b=bleC4/LUH5Ba/O65X/6en+oAlJpA4BmfxQQ7Gd9SMhJ/g36F7gZZn7iG5ZfLGjSOggPoH5BmW75edsxKyZSaglxNPhfW1vONbqjCQOebyol6sPiuy8TJ+vMGzVA0bmH0sinObzNCHBnBYX0R3IY+SbfBAsZCR6cDYY8oN56hBi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741261750; c=relaxed/simple;
	bh=4PIAGewwH+cVR/Aq16w8c5USEBqq/tKxm/ekR8hzZp0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FzpwkiRHnYG+/UGMQjEf3VHpofhOyTrexcW2b4g88vNpr16kK33XRXfh+yO+ypJqcsIirXBco7zN6OxMpjAfhYip16bj4OM0RkmvdmIAHDrP8Pwgq0vdqbEnKX5etPqicoenuMyNBUG3sdTPzYcrsJkft7ovU4emkcjMaZD4yKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f/6TeCgS; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741261749; x=1772797749;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=4PIAGewwH+cVR/Aq16w8c5USEBqq/tKxm/ekR8hzZp0=;
  b=f/6TeCgSX5TJLKVF+GtP7OcOEQoK5PeRpeYEuS6rbVg9XJSsfHndKyDY
   oBclF1LC9vfdokxcmr1fwuD3l76974BHLC+UhE3VNS6C4xZ2chGF0Vm1t
   RQAAnjzQ2fszzf4KbB3BFJei1KRkVAeM1GxHQz/UYvL+iXl1rxVAOAAAg
   drYrjZpCvI2wlA7l7DdRHDxSUD+Xj9OxP4/uoostBIa+d4M+UGJUieuzh
   91guhWPY64/pADhW5D02nhqBEYExzK1qvp4uOb+ClhGZfoBY3foYkxDhG
   cKK3Pqvrh03WJW/0zutOFhTh34Fo+o+Am2Y847h728ks2Cs4bu0O5WZ7e
   g==;
X-CSE-ConnectionGUID: FLlt7KsfSLy+xfc2RlUTUQ==
X-CSE-MsgGUID: jUw0dx3cTRy3koJ5FEzVaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11363"; a="52474493"
X-IronPort-AV: E=Sophos;i="6.14,226,1736841600"; 
   d="scan'208";a="52474493"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:08 -0800
X-CSE-ConnectionGUID: rpZ6bh6qRC+lfgj+bB0x8Q==
X-CSE-MsgGUID: 9y1b5FKqRnmjq2tkKZUSeA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="119915507"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Mar 2025 03:49:06 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH wireless-next 00/19] wifi: iwlwifi: updates - 2025-03-06
Date: Thu,  6 Mar 2025 13:48:36 +0200
Message-Id: <20250306114855.4170261-1-miriam.rachel.korenblit@intel.com>
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
---

Anjaneyulu (1):
  wifi: iwlwifi: parse active and 20 MHz AP NVM channel flag

Avraham Stern (1):
  wifi: iwlwifi: mvm: fix setting the TK when associated

Daniel Gabay (1):
  wifi: iwlwifi: w/a FW SMPS mode selection

Emmanuel Grumbach (3):
  wifi: iwlwifi: add support for BE213
  wifi: iwlwifi: fix the ECKV UEFI variable name
  wifi: iwlwifi: fix print for ECKV

Johannes Berg (4):
  wifi: iwlwifi: mark Br device not integrated
  wifi: iwlwifi: fix debug actions order
  wifi: iwlwifi: mvm: remove IWL_EMPTYING_HW_QUEUE_DELBA state
  wifi: iwlwifi: fw: do reset handshake during assert if needed

Miri Korenblit (5):
  wifi: iwlwifi: bump FW API to 97 for BZ/SC/DC devices
  wifi: iwlwifi: bump FW API to 98 for BZ/SC/DR devices
  wifi: iwlwifi: bump minimum API version in BZ/SC to 93
  wifi: iwlwifi: don't warn when if there is a FW error
  wifi: iwlwifi: re-add IWL_AMSDU_8K case

Pagadala Yesu Anjaneyulu (3):
  wifi: iwlwifi: mvm: cleanup of TAS structure and enums
  wifi: iwlwifi: Add new TAS disable reason for invalid table source
  wifi: iwlwifi: mvm: Fix bit size calculation in
    iwl_dbgfs_tas_get_status_read

nerrera (1):
  wifi: iwlwifi: add restricted TWT capability

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  6 +--
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  8 +--
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |  8 +--
 .../net/wireless/intel/iwlwifi/fw/api/debug.h | 42 +++++++--------
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 15 ++++--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  | 11 +++-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  | 10 ++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  1 +
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  | 10 ++--
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    | 53 ++++++++++++-------
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  1 +
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  | 38 ++++++-------
 .../intel/iwlwifi/mvm/ftm-initiator.c         |  4 ++
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c | 15 ++++++
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  3 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  3 ++
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |  5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 14 +----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 21 ++++++--
 22 files changed, 170 insertions(+), 113 deletions(-)

-- 
2.34.1


