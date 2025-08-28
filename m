Return-Path: <linux-wireless+bounces-26730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E87B396D8
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 10:26:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 250E116852D
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Aug 2025 08:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055341F4162;
	Thu, 28 Aug 2025 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="H1c6lGAw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F692D97A6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Aug 2025 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756369602; cv=none; b=bHxBLLcS9XumZvvRF7tFqIB9lyW6kVbazYuk0wHZf/7+vHQkSTtScwuEzYZGAO0qsufKAmxWqxxYM8UQnZpt3zJTykzhJlSdx7T93Sa39wmTqtMfLNxXnzYvllREFxXX27EzvkJa/Yn7SgYk2ntyGaJq1ioZ+TRWWw+AwKvCvIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756369602; c=relaxed/simple;
	bh=X4Ghc+wiqHc3zFZF2vuI6qpq8cWJc5yhzH+fJlNH3Iw=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=EtlitsuF0QKpAmjZ/MJLscExGBhkgIF2WwHXfD0cyA58ad7flTdVpRbkEwV6iMFegOSIFKZWX1ovB2YBYCJbniPxnp8KDoOrgs3i/nFAy+A7nYFy8Nv9SxUg1vHYa4A83WXNYjr7y+H1i2JnRavcsojJ6obq+EI5zw9gucLEfvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=H1c6lGAw; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1756369601; x=1787905601;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=X4Ghc+wiqHc3zFZF2vuI6qpq8cWJc5yhzH+fJlNH3Iw=;
  b=H1c6lGAwSJWetFVYKK5NokNM9a0sdF/9V00oHCiK5ErbH7ZHkNw14Mkb
   wFCIps7Ttxa3MPNbCVSEBl4basJZDVrGuCc3NZKpTOYklil/y376L08/h
   6JwO3S5VlcPIgBme1GS4ce+QUs0Pp8d+cXzHSql6IS5TEgUC+Cmeolmbb
   8QVRl8v9cPjRDQK0nQj6btC4C59R4b4yQxETBz9XcsAUc2+xgRRP+xf1z
   BUOHzVKa8u6iGW0qhuSvIMHuIkeGq0SL9tDnsoXgwyKKcQO+e0AY2refU
   Z4+tvP6qAGiHTcD6nrzCrUqqMdfSphIZrxCid3u6GY3sbwa2JcKSJxuBt
   w==;
X-CSE-ConnectionGUID: biiHTQZzSUCmnYuxLZDS4g==
X-CSE-MsgGUID: 8vu1YmexT0Ss9grkrCb84g==
X-IronPort-AV: E=McAfee;i="6800,10657,11535"; a="70003317"
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="70003317"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:34 -0700
X-CSE-ConnectionGUID: aHTBuTWbS62tMLxEZjMnSw==
X-CSE-MsgGUID: +DHcn33tQXe6ph7kinEIcg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,217,1751266800"; 
   d="scan'208";a="170224466"
Received: from weis0040.iil.intel.com ([10.12.217.108])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2025 01:26:29 -0700
From: Miri Korenblit <miriam.rachel.korenblit@intel.com>
To: linux-wireless@vger.kernel.org
Subject: [PATCH iwlwifi-next 00/15] wifi: iwlwifi: updates - 2025-08-28
Date: Thu, 28 Aug 2025 11:25:46 +0300
Message-Id: <20250828082601.537908-1-miriam.rachel.korenblit@intel.com>
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

Features, cleanups and bugfixes from out internal tree.

Thanks,
Miri
---

Johannes Berg (2):
  wifi: iwlwifi: uefi: remove runtime check of constant values
  wifi: iwlwifi: acpi: make iwl_guid static

Miri Korenblit (13):
  wifi: iwlwifi: remove .pnvm files from module info
  wifi: iwlwifi: trans: move dev_cmd_pool to trans specific
  wifi: iwlwifi: don't publish TWT capabilities
  wifi: iwlwifi: remove unneeded jacket indication
  wifi: iwlwifi: really remove hw_wfpm_id
  wifi: iwlwifi: gen1_2: rename iwl_trans_pcie_op_mode_enter
  wifi: iwlwifi: gen1_2: move gen specific code to a function
  wifi: iwlwifi: mld: support TLC command version 5
  wifi: iwlwifi: pcie: remember when interrupts are disabled
  wifi: iwlwifi: mld: make iwl_mld_rm_vif void
  wifi: iwlwifi: carefully select the PNVM source
  wifi: iwlwifi: mld: remove a TODO
  wifi: iwlwifi: don't support WH a step

 .../net/wireless/intel/iwlwifi/cfg/rf-gf.c    | 20 ++++-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.c  |  6 +-
 drivers/net/wireless/intel/iwlwifi/fw/acpi.h  |  2 -
 .../net/wireless/intel/iwlwifi/fw/api/rs.h    | 35 ++++++++
 drivers/net/wireless/intel/iwlwifi/fw/dbg.c   |  8 +-
 .../wireless/intel/iwlwifi/fw/error-dump.h    |  3 +-
 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c  | 69 +++++++++++++--
 drivers/net/wireless/intel/iwlwifi/fw/uefi.c  |  7 +-
 drivers/net/wireless/intel/iwlwifi/iwl-drv.c  |  6 ++
 .../wireless/intel/iwlwifi/iwl-nvm-parse.c    |  4 -
 .../net/wireless/intel/iwlwifi/iwl-trans.c    | 29 ++++---
 .../net/wireless/intel/iwlwifi/iwl-trans.h    | 26 +-----
 .../net/wireless/intel/iwlwifi/mld/iface.c    |  9 +-
 .../net/wireless/intel/iwlwifi/mld/iface.h    |  2 +-
 drivers/net/wireless/intel/iwlwifi/mld/mlo.c  |  6 --
 drivers/net/wireless/intel/iwlwifi/mld/tlc.c  | 75 ++++++++++++----
 drivers/net/wireless/intel/iwlwifi/pcie/drv.c |  7 +-
 .../intel/iwlwifi/pcie/gen1_2/internal.h      | 29 ++++++-
 .../intel/iwlwifi/pcie/gen1_2/trans.c         | 86 +++++++++++--------
 19 files changed, 285 insertions(+), 144 deletions(-)

-- 
2.34.1


