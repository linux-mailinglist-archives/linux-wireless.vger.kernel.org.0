Return-Path: <linux-wireless+bounces-25109-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5493AFF2A0
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 22:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 166365C0779
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 20:07:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD949251795;
	Wed,  9 Jul 2025 20:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="cKV3QtZA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8ABD24635E
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 20:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752091566; cv=none; b=f8spcQK6GLHyKemSwKikWAb/sM6I1J6FbWs6TwqHAL/Jmv1Quyf5IR4T7lw1yZ6j2icgWsJXEiFZTIDdMg5BRyhhi68dikREO9ZuK5DLWcZJnGbFWpmTNBJ92W9/Kpg1ANEGjKjggvuLURVEaAx2VqdQOIvytu3ySiQ3/09Z0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752091566; c=relaxed/simple;
	bh=uqTf8XJXulNR2HCOkIi4uLT0XQkbBHPtVixLDBo+jbk=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=sJMW9KNZYJmX1wCp/TStBrcqQJiFjzckaFLPWP0g5jNQnQk+ndTQNM4Yfd9ApVvV9yLGnpiAApzVe+GxvyVXWwynGhUxKnnCrKpTvUrxuKgnNe/NisV//FqF3KcUfumFnNmZfCAOG6tceMCf02CurFp2SaQAG1aFrCMm51ZNEgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=cKV3QtZA; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752091564; x=1783627564;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uqTf8XJXulNR2HCOkIi4uLT0XQkbBHPtVixLDBo+jbk=;
  b=cKV3QtZAJAUGiD27NkfYQuM328OUXCcKyYheVFLwLiuyJZ6OU8RWw3Tc
   TIvgn9v8Nkvv9FWbl55GafV+rTlj9TxIUYHr8NBJ/7U3RihC0jMYMiKAY
   DI+3Bz/4kZpOTbpd/4rBFXjGuqd7HBy7yKribFK1XyZTiUwq5wCEpTmih
   aIDjbdvdwSQsrENGQSms5BY/c8jTSk+Gi97twmHshhtlaEuyg9zRgstGm
   SiM296EU4ZwHAytD4TmWQ0R/fc7pTkokuRIVeKcFoVobtCdUYrMgH9paf
   2gZQDqtaoFkPxJqq7/nxxpCh4C+od3C1RHn0dNCtebuBRr0KdKBWPagz2
   g==;
X-CSE-ConnectionGUID: JSk2Nk2NQqy9C7F/3BAaHQ==
X-CSE-MsgGUID: zH+92UNrTzW3IHes/0bhKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11489"; a="54240296"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="54240296"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:04 -0700
X-CSE-ConnectionGUID: jeDd759ZS2ukSYfznk7QYw==
X-CSE-MsgGUID: WmxxV6v8SX2MhVS1E1aVMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="160125986"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2025 13:06:03 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-07-09
Date: Wed,  9 Jul 2025 23:05:28 +0300
Message-Id: <20250709200543.1628666-1-miriam.rachel.korenblit@intel.com>
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

Miri

Avraham Stern (1):
  wifi: iwlwifi: mvm: fix scan request validation

Itamar Shalev (3):
  wifi: iwlwifi: simplify iwl_poll_bits_mask return value
  wifi: iwlwifi: pcie: inform me when op mode leaving
  wifi: iwlwifi: trans: remove retake_ownership parameter from sw_reset

Johannes Berg (1):
  wifi: iwlwifi: pcie: accept new devices for MVM-only configs

Miri Korenblit (10):
  wifi: iwlwifi: handle non-overlapping API ranges
  wifi: iwlwifi: assign a FW API range for JF
  wifi: iwlwifi: bump minimum API version for SO/MA/TY
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v2
  wifi: iwlwifi: add a reference to iwl_wowlan_info_notif_v3
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v12
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_status_v9
  wifi: iwlwifi: assign a FW API range for HR
  wifi: iwlwifi: assign a FW API range for GF
  wifi: iwlwifi: pcie: add a missing include

 drivers/net/wireless/intel/iwlwifi/Makefile   |   1 +
 .../net/wireless/intel/iwlwifi/cfg/22000.c    |  24 ----
 .../net/wireless/intel/iwlwifi/cfg/ax210.c    |  34 +-----
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   9 --
 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    |  31 +++++
 .../net/wireless/intel/iwlwifi/cfg/rf-hr.c    |  49 +++++++-
 .../net/wireless/intel/iwlwifi/cfg/rf-jf.c    |  29 ++++-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |  13 ---
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  12 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   5 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    | 109 ------------------
 .../wireless/intel/iwlwifi/fw/api/offload.h   |   4 +-
 drivers/net/wireless/intel/iwlwifi/fw/dump.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   2 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |  55 +--------
 drivers/net/wireless/intel/iwlwifi/mvm/scan.c |   2 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |   4 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   1 +
 .../intel/iwlwifi/pcie/gen1_2/trans-gen2.c    |  20 ++++
 .../intel/iwlwifi/pcie/gen1_2/trans.c         |  12 +-
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   2 +-
 .../net/wireless/intel/iwlwifi/pcie/utils.h   |   2 +
 25 files changed, 171 insertions(+), 270 deletions(-)

-- 
2.34.1


