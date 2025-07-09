Return-Path: <linux-wireless+bounces-25020-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C15AAFDE7C
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:45:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF46A175C64
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 03:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D4CC21B195;
	Wed,  9 Jul 2025 03:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ijLGRebU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6766A1FAC37
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 03:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752032641; cv=none; b=PplP3ysh8pzOvOh3biNHt3KEBSy0zgCm/WDT6pwQvQ9YN1AA2GbEl6X3Kl2q0te6LOPJrTQhDV6ODF8EzpRZOeccIs7Hxe7QSEfoV8GQ8iUG6rCUhIWSqTTTihG3U9x49DUFomJFzoN8arJTExTyN4dYuTXOeB4U61I2Yv/vGEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752032641; c=relaxed/simple;
	bh=S0g3IQA2JFEC/87K/6DmDOPigDlB4NIo02EsqdLfrqs=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=FDczCL8Xlcx2Q+ybnRc9KryqgDferyHFxWevXNmV/SHJu8kQc8VoYDVCduT9gUzh1IcS8UcjnDOb3rj3Y1WnnvZqsKLBFtAYM/rnpgF4tP2g28focPhszHlnZ4jkV8lgPXemYK0Me5Mz9vNaaTRCQPtnPIpwle9eX5l9x58cVz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ijLGRebU; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752032639; x=1783568639;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=S0g3IQA2JFEC/87K/6DmDOPigDlB4NIo02EsqdLfrqs=;
  b=ijLGRebUbyUhpffIcTBLN5Q4xuCeLmGCa8b50YO9YjwbEIoqHyQEQBy8
   sK9UmmHbLir8NiKFldaqOxnk+Z8GkA9BDQty7++VVtsFfXLutWii+YKMv
   Cv2lPsIjPhCYsK1LUu2BdvZzTkJjwrzQXBbZ+LRycPzcUFj88wzG0Mxge
   +TMKWUq3fJCQiT4h17yx/iKl5P3u7z1U5fUgmGoSYT8NTj6gAw0KeMG3u
   U1r/wFV9zW+s/CiR0AzGXApbQ5SrhXuhe7wnnbYK2jrtwSUG6pRpAmNp+
   rzgS8lC2oNn+Cl6KHKihs7tTzOMwH72OJ/zGlsfjZct0DiWecrS90GS2x
   A==;
X-CSE-ConnectionGUID: EmQpS4fXQmOqWxUgq31mrw==
X-CSE-MsgGUID: zjUkvS1oRaag+xGd5JLlRg==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="79720614"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="79720614"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:43:58 -0700
X-CSE-ConnectionGUID: MRU7SmziSWi6ZHmi/kunpg==
X-CSE-MsgGUID: aBmnO2eFR5OPkhEjqEn7zQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="156390528"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by fmviesa010-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 20:43:58 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v2 00/15] wifi: iwlwifi: updates - 2025-07-08
Date: Wed,  9 Jul 2025 06:43:24 +0300
Message-Id: <20250709034339.794677-1-miriam.rachel.korenblit@intel.com>
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
features, cleanups and fixes from our internal tree.

Miri

Johannes Berg (5):
  wifi: iwlwifi: use PNVM data embedded in .ucode files
  wifi: iwlwifi: mvm/mld: make PHC messages debug messages
  wifi: iwlwifi: remove Intel driver load message
  wifi: iwlwifi: match discrete/integrated to fix some names
  wifi: iwlwifi: pcie: rename iwl_pci_gen1_2_probe() argument

Miri Korenblit (7):
  wifi: iwlwifi: bump FW API to 102 for BZ/SC/DR
  wifi: iwlwifi: pcie move common probe logic
  wifi: iwlwifi: trans: remove iwl_trans_init
  wifi: iwlwifi: mvm: remove MLO GTK rekey code
  wifi: iwlwifi: mvm: remove unneeded argument
  wifi: iwlwifi: bump minimum API version in BZ
  wifi: iwlwifi: mvm: remove support for iwl_wowlan_info_notif_v4

Rotem Kerem (1):
  wifi: iwlwifi: Add an helper function for polling bits

Yedidya Benshimol (2):
  wifi: iwlwifi: pcie move gen1_2 probe to gen1_2/trans.c
  wifi: iwlwifi: pcie: Move txcmd size/align calculation to callers

 drivers/net/wireless/intel/iwlwifi/cfg/bz.c   |   4 +-
 drivers/net/wireless/intel/iwlwifi/cfg/dr.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/cfg/sc.c   |   2 +-
 .../net/wireless/intel/iwlwifi/dvm/eeprom.c   |  21 +-
 .../net/wireless/intel/iwlwifi/fw/api/d3.h    |  13 +-
 drivers/net/wireless/intel/iwlwifi/fw/file.h  |   3 +
 drivers/net/wireless/intel/iwlwifi/fw/img.h   |   5 +
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  |  32 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.h  |   4 +-
 .../net/wireless/intel/iwlwifi/iwl-config.h   |  11 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.c   |   8 +-
 drivers/net/wireless/intel/iwlwifi/iwl-io.h   |   9 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.c    |  37 +-
 .../net/wireless/intel/iwlwifi/iwl-trans.h    |   7 +-
 drivers/net/wireless/intel/iwlwifi/mld/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mld/ptp.c  |  12 +-
 drivers/net/wireless/intel/iwlwifi/mvm/d3.c   | 232 +---------
 drivers/net/wireless/intel/iwlwifi/mvm/fw.c   |   2 +-
 drivers/net/wireless/intel/iwlwifi/mvm/ptp.c  |  14 +-
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 350 ++-------------
 .../intel/iwlwifi/pcie/gen1_2/internal.h      |   8 +-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 416 ++++++++++++++++--
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  45 +-
 25 files changed, 564 insertions(+), 691 deletions(-)
-- 
2.34.1



