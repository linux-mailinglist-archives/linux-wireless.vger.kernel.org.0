Return-Path: <linux-wireless+bounces-22738-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AACAAF972
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 14:13:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 384019C34C7
	for <lists+linux-wireless@lfdr.de>; Thu,  8 May 2025 12:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0E5214A76;
	Thu,  8 May 2025 12:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OJd10a4L"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA435966
	for <linux-wireless@vger.kernel.org>; Thu,  8 May 2025 12:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746706403; cv=none; b=EbK5auVAW7ng/pFY9IPXKLCWYSZcZvriRUqwAN9Au3+I+JiFyAjsRXKelAl5ihwfoVbwgUEBMOcLeFBVsh65KfmcTMnG2ljOZL+YhYByaYt9tl/nOj+l1MMeaK7EoS4mxri72amVI1O8AFUXTN1GbvZ1ioBm8gNuT+f8OaOnLNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746706403; c=relaxed/simple;
	bh=TRR8yzFLvWJM9wzpraZBTVSne7x9TCpwBHAhyWnWRQs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=KZtG28JT0N+gZs3DM6BZFlZl4Ng28l9ya1Ih6kaGp5f927gjKKN9IMtHdsTkBEQLwvA847iV0MWnFITCfBh6eWW2dmeXqP93hlVW0Z8vj18bWJUyGHwkkokHGtsT4kTVfEbbRiJ4Bu7ID1iJhSdrsGITWmw7bt71xS6UBD7+5Xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=OJd10a4L; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746706402; x=1778242402;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TRR8yzFLvWJM9wzpraZBTVSne7x9TCpwBHAhyWnWRQs=;
  b=OJd10a4LhjgK31BJzNKAgrZFsVn2uQC22UdxtOEq3GlNN+Vppjl7vLOW
   GAImYKULLg9kZwnK+4zDpwV3xLV8usL71io1TP4r5y8NKDbUtYkHKEy3M
   8pUDv0KYnPbJ2iUM/vBjYfd4MiKd3QPVn+eNve4BfFeG7KOlXA3s/Erdq
   viTfBM6si0VpZNZKJ6SafO40Qt5+N0+3tGZImmv4Z9+ZCqSSTUbb5RroE
   2giXo0EScYhx0iKpW2NNdo3+A03p/JACeVOIzP68W4VqusVMjisHkViCG
   2CG9mUevWWp2tc91pyqJw9br0RZ+gngeYDO8xDCTvXmrvu66TQTf78Ikr
   A==;
X-CSE-ConnectionGUID: CV3gaNaFQ+aWXmRcGx2XcQ==
X-CSE-MsgGUID: p5hx6E2FRLGshZGH9T6L8w==
X-IronPort-AV: E=McAfee;i="6700,10204,11426"; a="58688030"
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="58688030"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:22 -0700
X-CSE-ConnectionGUID: RbhXyPB5QPeIyvjvJzVpsQ==
X-CSE-MsgGUID: +93nYdMWSp2rvJXxj9oOGQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,272,1739865600"; 
   d="scan'208";a="167347763"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2025 05:13:20 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-08
Date: Thu,  8 May 2025 15:12:51 +0300
Message-Id: <20250508121306.1277801-1-miriam.rachel.korenblit@intel.com>
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

This contains a (part of) transport configuration rework

Thanks,
Miri

Johannes Berg (15):
  wifi: iwlwifi: build 9000 series FW filenames dynamically
  wifi: iwlwifi: cfg: remove QuZ/JF special cases
  wifi: iwlwifi: cfg: remove 'cdb' value
  wifi: iwlwifi: cfg: build ax210 family FW names dynamically
  wifi: iwlwifi: cfg: handle cc firmware dynamically
  wifi: iwlwifi: cfg: remove nvm_hw_section_num from new devices
  wifi: iwlwifi: pass trans to iwl_parse_nvm_mcc_info()
  wifi: iwlwifi: rename cfg_trans_params to mac_cfg
  wifi: iwlwifi: cfg: remove dbgc_supported field
  wifi: iwlwifi: cfg: remove rf_id field
  wifi: iwlwifi: rename struct iwl_base_params
  wifi: iwlwifi: cfg: remove eeprom_size from new devices
  wifi: iwlwifi: cfg: remove DCCM offsets from new devices
  wifi: iwlwifi: cfg: move MAC parameters to MAC data
  wifi: iwlwifi: remove unused high_temp from iwl_cfg

 drivers/net/wireless/intel/iwlwifi/cfg/1000.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/cfg/2000.c |   20 +-
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  119 +-
 drivers/net/wireless/intel/iwlwifi/cfg/5000.c |   10 +-
 drivers/net/wireless/intel/iwlwifi/cfg/6000.c |   30 +-
 drivers/net/wireless/intel/iwlwifi/cfg/7000.c |    9 +-
 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   21 +-
 drivers/net/wireless/intel/iwlwifi/cfg/9000.c |  102 +-
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  137 +--
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |  125 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |  116 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  100 +-
 .../net/wireless/intel/iwlwifi/dvm/devices.c  |    4 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |    8 +-
 drivers/net/wireless/intel/iwlwifi/dvm/led.c  |    6 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |    4 +-
 .../net/wireless/intel/iwlwifi/dvm/power.c    |    2 +-
 drivers/net/wireless/intel/iwlwifi/dvm/tx.c   |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |   57 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |    6 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   12 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   14 +-
 .../net/wireless/intel/iwlwifi/fw/paging.c    |    4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/smem.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  207 ++--
 drivers/net/wireless/intel/iwlwifi/iwl-csr.h  |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-dbg-tlv.c  |    8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   26 +-
 drivers/net/wireless/intel/iwlwifi/iwl-fh.h   |    4 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   20 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   14 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   21 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.h    |   12 +-
 .../wireless/intel/iwlwifi/iwl-nvm-utils.c    |    2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   22 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |    6 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/link.c |    2 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mcc.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/coex.c |    6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |    6 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |    4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   22 +-
 drivers/net/wireless/intel/iwlwifi/mvm/led.c  |    4 +-
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   20 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |    2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |   20 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |   18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |    8 +-
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |    8 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 1091 ++++++++---------
 .../wireless/intel/iwlwifi/pcie/internal.h    |   14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   58 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   34 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  126 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   16 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   82 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |    8 +-
 70 files changed, 1385 insertions(+), 1510 deletions(-)

-- 
2.34.1


