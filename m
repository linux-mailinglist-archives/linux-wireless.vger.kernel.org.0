Return-Path: <linux-wireless+bounces-16805-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0F09FCB9F
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 16:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 061F21615D3
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Dec 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DF7412E5B;
	Thu, 26 Dec 2024 15:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kksIJpjl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B504C481B1
	for <linux-wireless@vger.kernel.org>; Thu, 26 Dec 2024 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735227918; cv=none; b=FTgge9cUfJBUkV2ofQeDbQuShTjOtQn4hzbYrVVbKCwj7QxTAXzw5q9bUuHdUdBIeuSl8QLhaXBIFb90ahavy3MJ28SX7fwS/zAKfSH5OUqobE4wEEMn6wY/uc42I1OjKyZ/NtVwmpXwqbG1DHAot/k9t4UNvutQMzULsNrI6sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735227918; c=relaxed/simple;
	bh=tINwQtv5LIiOg3EkmcrY1ZfQabw7VB7cXVPvuT78AYU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Smq1iyBYzZXO2ZE1K4sL0+IBc0R5l4Yf2j9N+VsyDGLv9LKOWsIInxHifCHHQzFaAe7Hv0dnl7QM3KAP/IYRtByLSpDGt9GsbX044WnTBeGhDpnoXQnZQV4Vgc4tBo6yoecEpI4cxCDmi5RavLpsDX2WF4Jp6ZGpiDoPJzBhNYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kksIJpjl; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1735227916; x=1766763916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=tINwQtv5LIiOg3EkmcrY1ZfQabw7VB7cXVPvuT78AYU=;
  b=kksIJpjlXlYjMFRwEU5tjtzu3IqijI/Avk6w+jf/ZG6LX31m5aQKxul3
   qAy9ElMbebW2U3YjGDp/1W3uYA+EaNTYnDIKzffH+Y1IELTspFdxkdAhj
   uCa4eC4CmBvJ+B61nhS/r5p5lRB2tokPn/3gBis0mVMrAaUn/bFAfGnee
   ICBn94uq4y32+J6DLsjqICbee+EC67C2EcbNQXE+xySYBmuLTk8XFXWfN
   +MKxDB7BC5aQ/AO3qAspt3gDcaj4XcOf4C2n8kcJJ4twzlOEIM6argwEw
   y1QZvErlq7yg2NbsfC6FksxBzXrXG/Vlb+/3h6eW7+yiQ8GL8MvfIwGxK
   g==;
X-CSE-ConnectionGUID: JxaYcKAeQkepPEakLe9tOA==
X-CSE-MsgGUID: ltfRIvXlQdqveQNBoSOn4A==
X-IronPort-AV: E=McAfee;i="6700,10204,11296"; a="35878124"
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="35878124"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:15 -0800
X-CSE-ConnectionGUID: t9MvDsX6Q/+P58INeoaJTA==
X-CSE-MsgGUID: dSpiX+J8RBijR2deZ87rTQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,266,1728975600"; 
   d="scan'208";a="99777972"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Dec 2024 07:45:09 -0800
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: johannes@sipsolutions.net
Cc: linux-wireless@vger.kernel.org
Subject: [PATCH 00/15] wifi: iwlwifi: updates - 26-12-24
Date: Thu, 26 Dec 2024 17:44:41 +0200
Message-Id: <20241226154456.473690-1-miriam.rachel.korenblit@intel.com>
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

A few features and cleanups from our internal tree.

Miri
---

Anjaneyulu (3):
  wifi: iwlwifi: mvm: update documentation for iwl_nvm_channel_flags
  wifi: iwlwifi: mvm: add UHB canada support in TAS_CONFIG cmd
  wifi: iwlwifi: mvm: add UHB canada support in GET_TAS_STATUS cmd resp

Benjamin Berg (1):
  wifi: iwlwifi: mvm: log error for failures after D3

Daniel Gabay (4):
  wifi: iwlwifi: Remove mvm prefix from iwl_mvm_compressed_ba_notif
  wifi: iwlwifi: mvm: Check BAR packet size before accessing data
  wifi: iwlwifi: mvm: Move TSO code to shared utility
  wifi: iwlwifi: mvm: Use IWL_FW_CHECK() for BAR notif size validation

Emmanuel Grumbach (1):
  wifi: iwlwifi: add a new NMI type

Miri Korenblit (3):
  wifi: iwlwifi: bump FW API to 95 for BZ/SC devices
  wifi: iwlwifi: support BIOS override for UNII4 in CA/US also in LARI
    versions < 12
  wifi: iwlwifi: support BIOS override for 5G9 in CA also in LARI
    version 8

Somashekhar(Som) (2):
  wifi: mvm: Request periodic system statistics earlier
  wifi: iwlwifi: pcie: Add support for new device ids

Yedidya Benshimol (1):
  wifi: iwlwifi: remove mvm from session protection cmd's name

 drivers/net/wireless/intel/iwlwifi/Makefile   |   3 +-
 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   | 167 ++++++++++++++++++
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |   6 +-
 .../wireless/intel/iwlwifi/fw/api/commands.h  |   2 +-
 .../net/wireless/intel/iwlwifi/fw/api/debug.h |   6 +-
 .../wireless/intel/iwlwifi/fw/api/mac-cfg.h   |   2 +-
 .../wireless/intel/iwlwifi/fw/api/nvm-reg.h   |  15 +-
 .../intel/iwlwifi/fw/api/time-event.h         |  16 +-
 .../net/wireless/intel/iwlwifi/fw/api/tx.h    |  20 +--
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |  10 +-
 drivers/net/wireless/intel/iwlwifi/fw/img.c   |   2 +
 .../wireless/intel/iwlwifi/fw/regulatory.c    |  29 ++-
 .../wireless/intel/iwlwifi/fw/regulatory.h    |  21 +--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |   7 +-
 drivers/net/wireless/intel/iwlwifi/fw/uefi.h  |   3 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  10 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |   6 +-
 .../net/wireless/intel/iwlwifi/iwl-utils.c    |  85 +++++++++
 .../net/wireless/intel/iwlwifi/iwl-utils.h    |  36 ++++
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   |   4 +-
 .../net/wireless/intel/iwlwifi/mvm/debugfs.c  |   8 +
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   4 +
 .../net/wireless/intel/iwlwifi/mvm/mac80211.c |   4 -
 .../wireless/intel/iwlwifi/mvm/mld-mac80211.c |  15 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ops.c  |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/rxmq.c |  23 ++-
 .../wireless/intel/iwlwifi/mvm/time-event.c   |  10 +-
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c   |  87 +--------
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  16 ++
 31 files changed, 462 insertions(+), 161 deletions(-)
 create mode 100644 drivers/net/wireless/intel/iwlwifi/cfg/dr.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.c
 create mode 100644 drivers/net/wireless/intel/iwlwifi/iwl-utils.h

-- 
2.34.1


