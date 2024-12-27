Return-Path: <linux-wireless+bounces-16823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F679FD1B0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 09:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C72418831EB
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Dec 2024 08:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5FA57083A;
	Fri, 27 Dec 2024 08:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UKj/p/Ja"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60472BAF7
	for <linux-wireless@vger.kernel.org>; Fri, 27 Dec 2024 08:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735286489; cv=none; b=B2zp9vC3YMdiWBI3pGhF1xMT+s0wJWYWvlNEkPJkNiX++LjrbdbANVNSYJoRV10URw4zvQU9MTpQ+LhJflO8/OxNW1sAG8511LabIcDGXbHOuWE/pGZS88f58KsxyDIuxPMYRtvWpO+lAkYsf3uvg9TnlcPnxTKG36Y9K51wYzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735286489; c=relaxed/simple;
	bh=kCmstekM9ePzRwTtQKXJD+2Lu/xe/cVtIdeTdWD8UM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d4WCJW1DISATQ0P+9DPO9nYpG9WgImEDeXHkGszstGXgNCHg4Baiyf0MKvRBE45LpN57/vT8gUdZBv7Vd//ceDpI2tNb+hDgsmLUJLmw6FQ60yf1IVYp1D+SuMgPpIzixu1oDZHOiVmzJkXh7d6vC1WyRmSNKA+M4YEbIFMZbwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UKj/p/Ja; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735286487; x=1766822487;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kCmstekM9ePzRwTtQKXJD+2Lu/xe/cVtIdeTdWD8UM8=;
  b=UKj/p/JaIJMM4RJQXIZkMoTXrpXFA68H52Mrp4JGZojxzdRWTky4tzh4
   NwpHgpYDxJlZ4nnVpchD9bz/HMRD2nfVAxtQsMDG790diSSR9ND141ju8
   3tyiZs/+UaH6ygB6RJXsrEZVFkCtR4KyMzhEGK0Jp4Ttafml/jf5e+OMS
   xr5On96hBYp9Ir7J80om/8+Uh0Pj0QUHLSv9ud3d4KSEBTPqPVYdAPsgm
   /jbPa0fRZopIY2vmY9fW8aN6kyUOeKq48l7Tbf6JEzn/O2zpgMf7zCUZd
   QqzN6zzopa2rC6iAgAWb+SJ9UV+iJJsVjhXRekXebDdDqzLwLnMVca3bZ
   A==;
X-CSE-ConnectionGUID: v+9AOlEaSK2EyAzVdreS3g==
X-CSE-MsgGUID: yWy/PwjKRrSK6mSttyetgQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11297"; a="46690904"
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="46690904"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:25 -0800
X-CSE-ConnectionGUID: p3uiw9DrQGO29Ut7Iy/jfg==
X-CSE-MsgGUID: uFR87OEvSYOjrBZNzZ7Y4g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,268,1728975600"; 
   d="scan'208";a="99858190"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2024 00:01:24 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/17] wifi: iwlwifi: updates - 27-12-24
Date: Fri, 27 Dec 2024 10:00:55 +0200
Message-Id: <20241227080112.1098419-1-miriam.rachel.korenblit@intel.com>
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

This series contains a rework of the error handling,
along with a few cleanups and features.

Thanks,
Miri
----

Benjamin Berg (1):
  wifi: iwlwifi: mvm: skip short statistics window when updating EMLSR

Emmanuel Grumbach (2):
  wifi: iwlwifi: mvm: rename iwl_dev_tx_power_common::mac_context_id
  wifi: iwlwifi: s/iwl_mvm_ctdp_cmd/iwl_ctdp_cmd/

Johannes Berg (13):
  wifi: iwlwifi: differentiate NIC error types
  wifi: iwlwifi: mvm: remove warning on unallocated BAID
  wifi: iwlwifi: fw: read STEP table from correct UEFI var
  wifi: iwlwifi: context-info: add kernel-doc markers
  wifi: iwlwifi: return ERR_PTR from opmode start()
  wifi: iwlwifi: restrict driver retry loops to timeouts
  wifi: iwlwifi: mvm: restrict MAC start retry to timeouts
  wifi: iwlwifi: mvm: remove STARTING state
  wifi: iwlwifi: mvm: clean up FW restart a bit
  wifi: iwlwifi: unify cmd_queue_full() into nic_error()
  wifi: iwlwifi: mvm: restart device through NMI
  wifi: iwlwifi: rework firmware error handling
  wifi: iwlwifi: iwl_fw_error_collect() is always called sync

Somashekhar(Som) (1):
  wifi: iwlwifi: interpret STEP URM BIOS configuration

 .../net/wireless/intel/iwlwifi/dvm/mac80211.c |  11 ++
 drivers/net/wireless/intel/iwlwifi/dvm/main.c |  78 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  34 ++++
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  16 ++
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  12 +-
 .../net/wireless/intel/iwlwifi/fw/api/power.h |   8 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   4 +-
 .../wireless/intel/iwlwifi/fw/regulatory.c    |   1 +
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  23 +++
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  70 +++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  23 +++
 .../intel/iwlwifi/iwl-context-info-gen3.h     |  40 ++--
 .../wireless/intel/iwlwifi/iwl-context-info.h |  30 ++-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   9 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-op-mode.h  |  79 +++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 109 +++++++++-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |  66 ++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   7 -
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   4 -
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |  34 ++--
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  36 ----
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   6 -
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  | 186 +++++++-----------
 drivers/net/wireless/intel/iwlwifi/mvm/rx.c   |  16 ++
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   2 +-
 .../intel/iwlwifi/pcie/ctxt-info-gen3.c       |   8 +
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c  |   2 +-
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |  11 +-
 .../net/wireless/intel/iwlwifi/pcie/tx-gen2.c |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |   4 +-
 33 files changed, 664 insertions(+), 287 deletions(-)

-- 
2.34.1


