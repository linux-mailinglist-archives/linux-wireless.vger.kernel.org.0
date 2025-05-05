Return-Path: <linux-wireless+bounces-22463-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0494AA9C10
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 20:57:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62B30189FB9C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 18:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD71AAE28;
	Mon,  5 May 2025 18:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hSUvgD48"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F2231C1F12
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 18:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746471431; cv=none; b=NZlGcasJENffkt8vlCGPhIDVLgXQAIEOmoxqq0sDZ7pBxGq9JYAnct9TzLtc7SaA2fn3ArERw476YDMWoxtLEeF1JjOoWihWexLp1eDLZ5P/Naw7JGrJeYO8xpYjyS4hbCjUfLX75GOvrUSKaAuAgNpuFZ776ONeMEZC+VRrQiY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746471431; c=relaxed/simple;
	bh=h/FXaFTrwdswTTCyib/XZ7EuKtS1E2wk9WJhWN+9N4U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DGdwP4RTZpBWtVCbrQZNNVj/eqnMzpvjkOYAK+PIkVDeRpy0r5MnoLqrd7zZpFK6ClA0yXfjysIuX9t1LEbR1udJpsqO8Zd1wb7eiCm8JYNgpWKjDqfdBWKqHyooi6RdZN1ds/3Rq6j5Q6H0yMNKrNs50yS6RLbc+1E9+YDU9AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hSUvgD48; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746471429; x=1778007429;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h/FXaFTrwdswTTCyib/XZ7EuKtS1E2wk9WJhWN+9N4U=;
  b=hSUvgD48wEdOhuCqZjZYPmBulQc0OevcDi1atdmhSG186ujFl79TOb06
   RLsdrAIardHm29fQ+8eQg7fpsL+7v76W1Qa/qpRJo3Cr+CInZJ2oVpbHX
   PR4FCzXPFqvgqdvsYhXrvM/cRLdeCbsddv1K8esIam2eVPdKOTIQeN4eC
   GcFjkyHXnrjbTFl1IgjRVO3CilVEYVewoQzFvHrMEvMEm1qpbnntocpoB
   bV8rmTFUx/ieSOtzYdSpnXd3N7Dt5LGDKARjcoAm3Ho0jdcOxpgZnNsXT
   Ta3cL2X4BL29VWITl8yjaoVTNOQfxfAQsXawxfufXtWrIbHn6KMldtUYj
   Q==;
X-CSE-ConnectionGUID: aRNNgqSRRYCIM+iAJXYzxA==
X-CSE-MsgGUID: mRhWQaJNQJOVO+tsxOTUzQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11424"; a="47359430"
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="47359430"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:08 -0700
X-CSE-ConnectionGUID: IZtDoITLRFOPgoyQrHS6Zg==
X-CSE-MsgGUID: YrEKf3Q1SRyfnGAJJ1NdrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,264,1739865600"; 
   d="scan'208";a="135697888"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 11:57:08 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: miriam.rachel.korenblit@intel.com
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-05-05
Date: Mon,  5 May 2025 21:56:39 +0300
Message-Id: <20250505185654.2068339-1-miriam.rachel.korenblit@intel.com>
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

Features, cleanups and bugfixes from our internal tree

Thanks,
Miri

Avraham Stern (1):
  wifi: iwlwifi: mld: add debugfs for using ptp clock time for monitor
    interface

Emmanuel Grumbach (2):
  wifi: iwlwifi: add support PE RF
  wifi: iwlwifi: drop whtc RF

Johannes Berg (7):
  wifi: iwlwifi: pcie: log async commands
  wifi: iwlwifi: dvm: init 'keep_alive_beacons' in power tables
  wifi: iwlwifi: remove NVM C step override
  wifi: iwlwifi: mvm: fix beacon CCK flag
  wifi: iwlwifi: make iwl_uefi_get_uats_table() return void
  wifi: iwlwifi: fix 6005N/SFF match
  wifi: iwlwifi: handle v3 rates

Miri Korenblit (4):
  wifi: iwlwifi: mld: remove one more error in unallocated BAID
  wifi: iwlwifi: print the DSM value when read from UEFI
  wifi: iwlwifi: mld: don't check the TPT counters when scanning
  wifi: iwlwifi: debug: set CDB indication from CSR

Pagadala Yesu Anjaneyulu (1):
  wifi: iwlwifi: mld: add RFI_CONFIG_CMD to iwl_mld_system_names array

 drivers/net/wireless/intel/iwlwifi/cfg/8000.c |   3 -
 .../net/wireless/intel/iwlwifi/dvm/power.c    |  32 +--
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    |  65 ++++--
 .../net/wireless/intel/iwlwifi/fw/api/rx.h    |  16 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  15 +-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  25 +--
 .../wireless/intel/iwlwifi/fw/error-dump.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/rs.c    |  98 ---------
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  17 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |  10 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |   1 -
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  11 +-
 drivers/net/wireless/intel/iwlwifi/mld/agg.c  |   8 +-
 .../net/wireless/intel/iwlwifi/mld/debugfs.c  |  25 ++-
 .../net/wireless/intel/iwlwifi/mld/mac80211.c |  34 +++-
 drivers/net/wireless/intel/iwlwifi/mld/mld.c  |   4 +
 drivers/net/wireless/intel/iwlwifi/mld/mld.h  |   5 +
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  66 +++++++
 drivers/net/wireless/intel/iwlwifi/mld/mlo.h  |   3 +
 .../net/wireless/intel/iwlwifi/mld/notif.c    |   6 +-
 .../wireless/intel/iwlwifi/mld/regulatory.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/rx.c   |  28 ++-
 drivers/net/wireless/intel/iwlwifi/mld/scan.c |   3 +
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  |   4 +-
 drivers/net/wireless/intel/iwlwifi/mld/tx.c   |  32 +--
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   7 +-
 .../net/wireless/intel/iwlwifi/mvm/mac-ctxt.c |  17 +-
 drivers/net/wireless/intel/iwlwifi/mvm/mvm.h  |   2 +
 drivers/net/wireless/intel/iwlwifi/mvm/nvm.c  |  18 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |  38 ++++
 .../net/wireless/intel/iwlwifi/mvm/rs-fw.c    |  19 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.c   | 187 +++++++++++++++++-
 drivers/net/wireless/intel/iwlwifi/mvm/rs.h   |   5 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  26 +--
 drivers/net/wireless/intel/iwlwifi/mvm/sta.h  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   | 112 +++++------
 .../net/wireless/intel/iwlwifi/mvm/utils.c    |  12 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/tx.c  |  10 +-
 39 files changed, 616 insertions(+), 363 deletions(-)

-- 
2.34.1


