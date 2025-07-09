Return-Path: <linux-wireless+bounces-25054-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76E72AFDF19
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 07:17:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D7D63B1B89
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 05:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B492690F9;
	Wed,  9 Jul 2025 05:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fD2hBalb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3A11F4E4F
	for <linux-wireless@vger.kernel.org>; Wed,  9 Jul 2025 05:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752038217; cv=none; b=sOrtRaonqq7mSDkvxSedN2fDa776WG3rIipjJGjCNBQoZ84pS8wBV8bVNM+oHkauDKoQ/UW4QW+Ib7iiSns9kqVdSO8RvHWULNHPwVL6l5OPwL0Gx6KHhFnFVCxKzSN9B2fEBA10+QrA+Tr5MEzBhkcQvYHq95rd14EWyrldnr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752038217; c=relaxed/simple;
	bh=HZuJf7uJMm/Y6raDh08hAZ8UeA/zLWaRtr8zT+g16x0=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=siN7DVfTOQMmK4GecnnrFZEdr58ywEcvFOS7IbRFdDX7Ee1QSX3zZd8GWHtkjFiUcbFf0S1KNqp/tcIQBeXSoygr+TRtKTHqsMxWJ3gmlReR2lI8hV9P77GvDjGc0dG6TTiATN83b2aspVaoYfUs8YvuoEaeoGhuB12asKxcjlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fD2hBalb; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1752038216; x=1783574216;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HZuJf7uJMm/Y6raDh08hAZ8UeA/zLWaRtr8zT+g16x0=;
  b=fD2hBalbgcpSSuv4VDG1oplcFuXrv4I17hx0oeEyjbfEvPvrU6WdzuNf
   VULGHKoIUQ6P+hHUDQrPO/NKSunfA2QMyrVRhrAppn3flyhcR62u8fVDS
   RNn/ppRKIkWZQXsadktMWFeWExnz3zClLGcZvxF4v/c9+2bD5xwl8s1uH
   3BzQj1yFC1Hdmzq5GNcP5Ir5EJR6lTb7I6E3mbNjizL9vFA+TpBVrKsl/
   p4eUHhmsP5CeuNOzC+r2r3hDAx4b/ZZL2UE9DBPkBwBEDeK3LIpwv0Gj5
   neK5w6Rg0GEGiaJi8E2E8nTcdPTBBLuuYTvJTVKtsRnxmyXC7EfwPYcjh
   w==;
X-CSE-ConnectionGUID: VRzcHVwBRjSrZu1fYIvsjw==
X-CSE-MsgGUID: r5kdQR5HQ+Sga2G28PlU3A==
X-IronPort-AV: E=McAfee;i="6800,10657,11487"; a="58091166"
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="58091166"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:16:55 -0700
X-CSE-ConnectionGUID: xAwV1UF8TdmOODuzS5Qn1Q==
X-CSE-MsgGUID: C/R0QkxkSYqZw1EX/dDiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,298,1744095600"; 
   d="scan'208";a="161327850"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2025 22:16:54 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next v3 00/15] wifi: iwlwifi: updates - 2025-07-08
Date: Wed,  9 Jul 2025 08:16:19 +0300
Message-Id: <20250709051634.866992-1-miriam.rachel.korenblit@intel.com>
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
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 413 ++++++++++++++++--
 .../wireless/intel/iwlwifi/pcie/gen1_2/tx.c   |   2 +-
 .../wireless/intel/iwlwifi/tests/devinfo.c    |  45 +-
 25 files changed, 561 insertions(+), 691 deletions(-)

-- 
2.34.1


