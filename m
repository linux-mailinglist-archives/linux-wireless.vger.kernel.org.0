Return-Path: <linux-wireless+bounces-18518-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48A9AA28AF6
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 13:56:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51624163949
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Feb 2025 12:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4508F5E;
	Wed,  5 Feb 2025 12:56:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H4E0fdca"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0912376
	for <linux-wireless@vger.kernel.org>; Wed,  5 Feb 2025 12:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738760166; cv=none; b=AokZJGOlHXQ9LHOtXmxS/tFIFv+tqUVVMyLWW62fnmFzM8FRz1n6iVfcgdC7sbcroE5aQJKjEqD5X3sVs869O25++NUTF85V+iyuwd9u/PytB9IW25+4FZ0coNRKxFoXMi9YHQTNfm5fyuVzb5D9+VKJOBqE+yYM58YakwRLTVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738760166; c=relaxed/simple;
	bh=zzktoVHphbdLifNihB0gwjT84EGWOhQtR6O1bAKWP0U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mpSPgGrA1PsoGyv4WC4fA05WVsOXqCuObSPGJyDXoVu5zvBIyhSMByvBhwRYRaLe8w6qTGmerzfSaKskBsLIpmgEqCq3FkHuJo59+1AxeXBsgC7XxXrb5b6gbyy6PeLeXPG7mq8T73qveMeEeE/X8eShDsWvd4enyBpGy6ztOoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H4E0fdca; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738760165; x=1770296165;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zzktoVHphbdLifNihB0gwjT84EGWOhQtR6O1bAKWP0U=;
  b=H4E0fdcah504dJ4QkteqSoVnXmz9BTxZv/YweKzYSE+PXWMJaIpXsVdT
   Vq1HKaR9HTxIJ+PCWEO/NpqaE4FRZAY5QGqdXMGVOUeaJhpu8n2nLkNUM
   jk+drv1VSBqHLdH2UuJizipXJHDwqcWpij2+AdphgjJyB2K32g/g8Ebc6
   0WHsoULgS5kXSW+IPWSEiK7h2dKY51y5PbEb4OY2qeLvF51UqLLN76cIg
   Iu03+k+YHmMS46idDNZbPE0PhGEoR3PFEL56XX6YpBSOlGexDMMUdAqYV
   eNfhhnjB0DpuRc+RxymQte//FLHsw3+blmVJ6HQj4+JWKXSY3z3WSoBDJ
   A==;
X-CSE-ConnectionGUID: hssobaw1RRmOdsrZn6xLCA==
X-CSE-MsgGUID: MVGmwObCQ2GpblqCbZaBnQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11336"; a="42159156"
X-IronPort-AV: E=Sophos;i="6.13,261,1732608000"; 
   d="scan'208";a="42159156"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:04 -0800
X-CSE-ConnectionGUID: mOx3GuKmQHOtKR7XD1ZzUQ==
X-CSE-MsgGUID: ta6ch843SY28XWMpQ2htPg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="110745409"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa010-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 04:56:03 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/19] wifi: iwlwifi: updates - 2025-02-05
Date: Wed,  5 Feb 2025 14:55:29 +0200
Message-Id: <20250205125548.1963070-1-miriam.rachel.korenblit@intel.com>
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
This series contains features, cleanups and bugfixes from our internal
tree.

Thanks,
Miri
---

Anjaneyulu (2):
  wifi: iwlwifi: mvm: rename and move iwl_mvm_eval_dsm_rfi() to
    iwl_rfi_is_enabled_in_bios()
  wifi: iwlwifi: Unify TAS block list handling in regulatory.c

Emmanuel Grumbach (7):
  wifi: iwlwifi: remove the mvm prefix from iwl_mvm_ctdp_cmd
  wifi: iwlwifi: remove the version number from
    iwl_dts_measurement_notif_v2
  wifi: iwlwifi: remove the mvm prefix from iwl_mvm_aux_sta_cmd
  wifi: iwlwifi: be less aggressive with re-probe
  wifi: iwlwifi: make no_160 more generic
  wifi: iwlwifi: properly set the names for SC devices
  wifi: iwlwifi: clarify the meaning of IWL_INIT_PHY

Ilan Peer (2):
  wifi: iwlwifi: Indicate support for EPCS
  wifi: iwlwifi: mvm: Indicate support link reconfiguration

Johannes Berg (5):
  wifi: iwlwifi: enable 320 MHz on slow PCIe links
  wifi: iwlwifi: cfg: separate 22000/BZ family HT params
  wifi: iwlwifi: fw: make iwl_send_dbg_dump_complete_cmd() static
  wifi: iwlwifi: use correct IMR dump variable
  wifi: iwlwifi: implement dump region split

Miri Korenblit (1):
  wifi: iwlwifi: don't warn during reprobe

Shaul Triebitz (2):
  wifi: iwlwifi: support ROC version 6
  wifi: iwlwifi: add twt operation cmd

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   9 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   8 +-
 .../net/wireless/intel/iwlwifi/fw/api/alive.h |   4 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   2 +-
 .../wireless/intel/iwlwifi/fw/api/dbg-tlv.h   |   9 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |  91 ++++++-
 .../net/wireless/intel/iwlwifi/fw/api/phy.h   |  18 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  42 +++-
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   | 108 +++++---
 drivers/net/wireless/intel/iwlwifi/fw/dbg.h   |   3 -
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  49 ++++
 .../wireless/intel/iwlwifi/fw/regulatory.h    |   3 +
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  20 +-
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  24 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |   5 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   8 +-
 drivers/net/wireless/intel/iwlwifi/mld/roc.c  | 224 +++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |  54 +---
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   5 +-
 .../net/wireless/intel/iwlwifi/mvm/mld-sta.c  |   2 +-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tt.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 237 ++++++++++--------
 .../wireless/intel/iwlwifi/pcie/trans-gen2.c  |   4 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  15 +-
 26 files changed, 704 insertions(+), 252 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/mld/roc.c

-- 
2.34.1


