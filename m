Return-Path: <linux-wireless+bounces-22367-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F4AA8257
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 21:44:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D343517CA3D
	for <lists+linux-wireless@lfdr.de>; Sat,  3 May 2025 19:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1B427E7DB;
	Sat,  3 May 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SaE1UDmt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6572D1553A3
	for <linux-wireless@vger.kernel.org>; Sat,  3 May 2025 19:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746301492; cv=none; b=TQOBMOaxhg6YsiRNAHVVVG/b0JyhrVJr/Y0aIL+UWTK/cj96tmJX8dZLI3qGMobsdbpTpw+TK1u2Sj5yi+pzpVaQ4/NbbT40Zx/tlrvQbUnSYVLhjzARpvs9kTWq2lvm7qaLl/WlSwa/YI2rwAge7Kw283Mqn/Gs+fSZDiAAc9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746301492; c=relaxed/simple;
	bh=uX9EnKxfwkAyGATe2yLn2irmiXzRmjZdnWVmRnJPR4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KEZCQujMmNUIyk6o7SzN1BtwUy1n/ptY6zv9ZG66VGmtTjmcklcyKl0j4GDiVpuKgtA7zvQaiFGjtdTLdinVY6RTbGY9Wr2THnmwhCH0AlKcrb3oiQ0F+c3XCouNarKCw5+LbqIuI6WgXHRlJgZoFSpGsl70vpfkfG4qmn3Iqew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SaE1UDmt; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746301490; x=1777837490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uX9EnKxfwkAyGATe2yLn2irmiXzRmjZdnWVmRnJPR4Q=;
  b=SaE1UDmtbFDYE5iBbF/boClWuWju0ryXHoAaGHDPYP3xzRdHRVnDl+41
   pZ0KHS2y3ZIWh7eI6TNp0Uza1GqDCitcabINjFowNKseZIETauoF14+7k
   AfsatU6AqLjgTNlT01i2cbXWiO3qwMPm8gRP56Xqg0PNX5hfw9hcGOsxl
   ll8JWhDwKDd/YO5GmvQcGL5fbgFd7pWlQcIw3CUN35s1lAO01l10inNnS
   YehdovRepst3zD7HfECLI6WUg7gGe4jz94dv9sbKJHQ7Ou4eZ1t2Wq0jx
   pDvl2FqmwBy8Yv11TxRc12V53eQQ3rO62k2FOdkiMEIAConYD9An37dJ2
   g==;
X-CSE-ConnectionGUID: 07qzx9QfSrKK7s4X5bDspg==
X-CSE-MsgGUID: YAo2ccr6TDKlEmZVlW3AaQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11422"; a="58613256"
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="58613256"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:49 -0700
X-CSE-ConnectionGUID: h7+jVCrZQ42pkmzcloLLew==
X-CSE-MsgGUID: 7bQnZ3DiSgWM2pqes4Y4zg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,258,1739865600"; 
   d="scan'208";a="134644236"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa009-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2025 12:44:48 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-03
Date: Sat,  3 May 2025 22:44:19 +0300
Message-Id: <20250503194434.147426-1-miriam.rachel.korenblit@intel.com>
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
A few cleanups, features and bugfixes from our internal tree.

Thanks,
Miri

Ilan Peer (1):
  wifi: iwlfiwi: mvm: Fix the rate reporting

Johannes Berg (13):
  wifi: iwlwifi: pcie: rename "continuous" memory
  wifi: iwlwifi: pcie: move ME check data to pcie
  wifi: iwlwifi: pcie: move invalid TX CMD into PCIe
  wifi: iwlwifi: pcie: move wait_command_queue into PCIe
  wifi: iwlwifi: unexport iwl_trans_pcie_send_hcmd()
  wifi: iwlwifi: remove PM mode and send-in-D3
  wifi: iwlwifi: pass full FW info to transport
  wifi: iwlwifi: trans: remove hw_id_str
  wifi: iwlwifi: trans: remove hw_wfpm_id
  wifi: iwlwifi: pcie: remove constant wdg_timeout
  wifi: iwlwifi: remove bc_table_dword transport config
  wifi: iwlwifi: trans: remove SCD base address validation
  wifi: iwlwifi: trans: collect device information

Somashekhar Puttagangaiah (1):
  wifi: iwlwifi: handle reasons recommended by FW for leaving EMLSR

 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |   7 +-
 .../net/wireless/intel/iwlwifi/dvm/ucode.c    |  10 +-
 .../wireless/intel/iwlwifi/fw/api/datapath.h  |   2 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  43 +++++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  21 +--
 .../net/wireless/intel/iwlwifi/fw/debugfs.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/init.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  12 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   8 +-
 .../intel/iwlwifi/iwl-context-info-gen3.h     |   3 +-
 .../wireless/intel/iwlwifi/iwl-context-info.h |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  20 +--
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   4 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  12 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  58 +++++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 127 +++++++---------
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/d3.c   |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   8 +-
 .../wireless/intel/iwlwifi/mld/low_latency.c  |  12 +-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |   6 +-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   3 -
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  33 ++++-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   2 +-
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   5 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/sta.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  28 ++--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  18 +--
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/sta.c  |  16 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |  52 ++++---
 .../wireless/intel/iwlwifi/pcie/ctxt-info.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 137 ++++++++++--------
 .../wireless/intel/iwlwifi/pcie/internal.h    |  39 +++--
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |  32 ++--
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  16 +-
 .../net/wireless/intel/iwlwifi/pcie/trans.c   |  86 ++++++-----
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   7 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  29 ++--
 49 files changed, 495 insertions(+), 462 deletions(-)

-- 
2.34.1


